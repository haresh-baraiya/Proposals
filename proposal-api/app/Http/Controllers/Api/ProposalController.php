<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Proposal;
use App\Models\Template;
use App\Services\OpenAIService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class ProposalController extends Controller
{
    public function generate(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'job_title' => 'required|string',
            'job_description' => 'nullable|string',
            'skills' => 'nullable|string',
            'budget' => 'nullable|string',
            'template_id' => 'required|integer|exists:templates,id',
        ]);

        // Find the specified template
        $template = Template::where('is_active', true)
            ->where('id', $validated['template_id'])
            ->first();

        if (!$template) {
            return response()->json([
                'success' => false,
                'message' => 'Template not found or inactive.',
            ], 404);
        }

        // Generate proposal by replacing variables
        $proposalContent = $this->replaceVariables($template->content, $validated);

        // Save proposal to history
        $proposal = Proposal::create([
            'template_id' => $template->id,
            'job_title' => $validated['job_title'],
            'job_description' => $validated['job_description'] ?? null,
            'job_skills' => $validated['skills'] ?? null,
            'job_budget' => $validated['budget'] ?? null,
            'generated_proposal' => $proposalContent,
        ]);

        return response()->json([
            'success' => true,
            'data' => [
                'proposal' => $proposalContent,
                'template_name' => $template->name,
                'proposal_id' => $proposal->id,
            ],
        ]);
    }

    public function getTemplates(): JsonResponse
    {
        $templates = Template::where('is_active', true)
            ->select('id', 'name', 'description')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $templates,
        ]);
    }

    public function getProposals(Request $request): JsonResponse
    {
        $query = Proposal::with('template:id,name');

        // Handle sorting
        $sortBy = $request->get('sort', 'desc'); // Default to desc (newest first)
        $sortColumn = $request->get('sort_by', 'created_at');

        // Validate sort direction
        $sortDirection = in_array(strtolower($sortBy), ['asc', 'desc']) ? strtolower($sortBy) : 'desc';

        // Validate sort column (security)
        $allowedSortColumns = ['created_at', 'updated_at', 'job_title'];
        $sortColumn = in_array($sortColumn, $allowedSortColumns) ? $sortColumn : 'created_at';

        $query->orderBy($sortColumn, $sortDirection);

        // Handle pagination
        $limit = $request->get('limit', 20);
        $limit = min(max((int)$limit, 1), 100); // Between 1 and 100

        $proposals = $query->paginate($limit);

        return response()->json([
            'success' => true,
            'data' => $proposals,
        ]);
    }

    public function getProposal($id): JsonResponse
    {
        $proposal = Proposal::with('template:id,name')
            ->findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => $proposal,
        ]);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'job_title' => 'required|string',
            'job_description' => 'nullable|string',
            'proposal_text' => 'required|string',
            'generated_at' => 'nullable|date',
        ]);

        // Store the OpenAI-generated proposal
        $proposal = Proposal::create([
            'template_id' => null, // No template used for OpenAI generation
            'job_title' => $validated['job_title'],
            'job_description' => $validated['job_description'] ?? null,
            'job_skills' => null,
            'job_budget' => null,
            'generated_proposal' => $validated['proposal_text'],
            'generated_at' => $validated['generated_at'] ? now()->parse($validated['generated_at']) : now(),
        ]);

        return response()->json([
            'success' => true,
            'data' => [
                'proposal_id' => $proposal->id,
                'message' => 'Proposal stored successfully',
            ],
        ], 201);
    }

    public function generateWithOpenAI(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'job_title' => 'required|string',
            'job_description' => 'nullable|string',
            'skills' => 'nullable|string',
            'budget' => 'nullable|string',
        ]);

        try {
            $openAIService = new OpenAIService();

            // Generate proposal using OpenAI
            $proposalContent = $openAIService->generateProposal($validated);

            // Save proposal to history
            $proposal = Proposal::create([
                'template_id' => null, // No template used for OpenAI generation
                'job_title' => $validated['job_title'],
                'job_description' => $validated['job_description'] ?? null,
                'job_skills' => $validated['skills'] ?? null,
                'job_budget' => $validated['budget'] ?? null,
                'generated_proposal' => $proposalContent,
                'generated_at' => now(),
            ]);

            return response()->json([
                'success' => true,
                'data' => [
                    'proposal' => $proposalContent,
                    'proposal_id' => $proposal->id,
                    'generated_by' => 'OpenAI',
                    'model' => config('openai.model'),
                ],
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to generate proposal with OpenAI',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function generateWithAIReview(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'job_title' => 'required|string',
            'job_description' => 'nullable|string',
            'skills' => 'nullable|string',
            'budget' => 'nullable|string',
            'template_id' => 'nullable|integer|exists:templates,id',
        ]);

        try {
            $openAIService = new OpenAIService();
            $proposalContent = '';
            $generationMethod = '';

            // Generate proposal using template or AI
            if (!empty($validated['template_id'])) {
                // Use template-based generation
                $template = Template::where('is_active', true)
                    ->where('id', $validated['template_id'])
                    ->first();

                if (!$template) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Template not found or inactive.',
                    ], 404);
                }

                $proposalContent = $this->replaceVariables($template->content, $validated);
                $generationMethod = 'Template: ' . $template->name;
            } else {
                // Use AI generation
                $proposalContent = $openAIService->generateProposal($validated);
                $generationMethod = 'AI Generated';
            }

            // Review the proposal with AI
            $reviewResult = $openAIService->reviewProposal($proposalContent, $validated);

            // Use revised proposal if available and score is low
            $finalProposal = $proposalContent;
            if ($reviewResult['score'] < 8 && !empty($reviewResult['revised_proposal'])) {
                $finalProposal = $reviewResult['revised_proposal'];
                $generationMethod .= ' + AI Reviewed & Improved';
            } else {
                $generationMethod .= ' + AI Reviewed';
            }

            // Save proposal to history
            $proposal = Proposal::create([
                'template_id' => $validated['template_id'] ?? null,
                'job_title' => $validated['job_title'],
                'job_description' => $validated['job_description'] ?? null,
                'job_skills' => $validated['skills'] ?? null,
                'job_budget' => $validated['budget'] ?? null,
                'generated_proposal' => $finalProposal,
                'generated_at' => now(),
            ]);

            return response()->json([
                'success' => true,
                'data' => [
                    'proposal' => $finalProposal,
                    'proposal_id' => $proposal->id,
                    'generated_by' => $generationMethod,
                    'review' => [
                        'score' => $reviewResult['score'],
                        'strengths' => $reviewResult['strengths'],
                        'improvements' => $reviewResult['improvements'],
                        'was_revised' => !empty($reviewResult['revised_proposal']) && $reviewResult['score'] < 8,
                        'original_proposal' => $reviewResult['score'] < 8 ? $proposalContent : null,
                    ],
                    'model' => config('openai.model'),
                ],
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to generate proposal with AI review',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function testOpenAI(): JsonResponse
    {
        try {
            $openAIService = new OpenAIService();
            $result = $openAIService->testConnection();

            return response()->json([
                'success' => $result['success'],
                'message' => $result['message'],
                'model' => $result['model'],
                'api_key_configured' => !empty(config('openai.api_key')),
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'OpenAI test failed',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    private function replaceVariables(string $content, array $data): string
    {
        $replacements = [
            '{{job_title}}' => $data['job_title'] ?? '',
            '{{job_description}}' => $data['job_description'] ?? '',
            '{{skills}}' => $data['skills'] ?? '',
            '{{budget}}' => $data['budget'] ?? '',
        ];

        return str_replace(
            array_keys($replacements),
            array_values($replacements),
            $content
        );
    }
}
