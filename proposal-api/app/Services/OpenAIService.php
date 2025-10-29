<?php

namespace App\Services;

use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http;

class OpenAIService
{
    private $apiKey;
    private $baseUrl;

    public function __construct()
    {
        $this->apiKey = config('openai.api_key');
        $this->baseUrl = 'https://openrouter.ai/api/v1';
    }

    /**
     * Generate a proposal using OpenRouter.ai
     */
    public function generateProposal(array $jobData): string
    {
        try {
            $prompt = $this->buildPrompt($jobData);

            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $this->apiKey,
                'Content-Type' => 'application/json',
                'HTTP-Referer' => config('app.url'),
                'X-Title' => 'Laravel Proposal Generator'
            ])->post($this->baseUrl . '/chat/completions', [
                'model' => config('openai.model'),
                'messages' => [
                    [
                        'role' => 'system',
                        'content' => config('openai.system_prompt')
                    ],
                    [
                        'role' => 'user',
                        'content' => $prompt
                    ]
                ],
                'max_tokens' => (int) config('openai.max_tokens'),
                'temperature' => (float) config('openai.temperature'),
            ]);

            if (!$response->successful()) {
                throw new \Exception('OpenRouter API error: ' . $response->status() . ' - ' . $response->body());
            }

            $data = $response->json();
            return $data['choices'][0]['message']['content'] ?? '';
        } catch (\Exception $e) {
            Log::error('OpenRouter API Error: ' . $e->getMessage());
            throw new \Exception('Failed to generate proposal: ' . $e->getMessage());
        }
    }

    /**
     * Build the prompt for OpenAI
     */
    private function buildPrompt(array $jobData): string
    {
        $jobTitle = $jobData['job_title'] ?? 'Untitled Job';
        $jobDescription = $jobData['job_description'] ?? '';
        $clientName = $jobData['client_name'] ?? 'Hiring Manager';
        $skills = $jobData['skills'] ?? 'Full-stack development, JavaScript, React, Node.js';
        $experience = $jobData['experience'] ?? '5+ years of web development experience';

        return "
Write a professional Upwork proposal for the following job:

Job Title: {$jobTitle}
Client: {$clientName}
Job Description: {$jobDescription}

My Skills: {$skills}
My Experience: {$experience}

Requirements:
- Keep it concise (under 200 words)
- Be professional and friendly
- Highlight relevant skills
- Show understanding of the project
- Include a clear call to action
- Avoid generic templates
- Make it personalized to this specific job

Generate only the proposal text, no additional formatting or explanations.
        ";
    }

    /**
     * Review and improve a generated proposal using AI
     */
    public function reviewProposal(string $proposal, array $jobData): array
    {
        try {
            $reviewPrompt = $this->buildReviewPrompt($proposal, $jobData);

            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $this->apiKey,
                'Content-Type' => 'application/json',
                'HTTP-Referer' => config('app.url'),
                'X-Title' => 'Laravel Proposal Reviewer'
            ])->post($this->baseUrl . '/chat/completions', [
                'model' => config('openai.model'),
                'messages' => [
                    [
                        'role' => 'system',
                        'content' => 'You are an expert freelancer and proposal reviewer. Analyze proposals for Upwork jobs and provide constructive feedback and improvements.'
                    ],
                    [
                        'role' => 'user',
                        'content' => $reviewPrompt
                    ]
                ],
                'max_tokens' => (int) config('openai.max_tokens'),
                'temperature' => 0.3, // Lower temperature for more focused review
            ]);

            if (!$response->successful()) {
                throw new \Exception('OpenRouter API error: ' . $response->status() . ' - ' . $response->body());
            }

            $data = $response->json();
            $reviewResult = $data['choices'][0]['message']['content'] ?? '';

            // Parse the review result to extract score and feedback
            return $this->parseReviewResult($reviewResult);
        } catch (\Exception $e) {
            Log::error('OpenRouter Review API Error: ' . $e->getMessage());
            throw new \Exception('Failed to review proposal: ' . $e->getMessage());
        }
    }

    /**
     * Build the review prompt for AI analysis
     */
    private function buildReviewPrompt(string $proposal, array $jobData): string
    {
        $jobTitle = $jobData['job_title'] ?? 'Untitled Job';
        $jobDescription = $jobData['job_description'] ?? '';

        return "
Please review this Upwork proposal and provide feedback:

JOB TITLE: {$jobTitle}
JOB DESCRIPTION: {$jobDescription}

PROPOSAL TO REVIEW:
{$proposal}

Please analyze the proposal and provide:
1. SCORE: Rate from 1-10 (10 being excellent)
2. STRENGTHS: What works well in this proposal
3. IMPROVEMENTS: Specific suggestions for improvement
4. REVISED_PROPOSAL: An improved version of the proposal (if score < 8)

Format your response as:
SCORE: [number]
STRENGTHS: [bullet points]
IMPROVEMENTS: [bullet points]
REVISED_PROPOSAL: [improved proposal text or 'No revision needed']
        ";
    }

    /**
     * Parse the AI review result
     */
    private function parseReviewResult(string $reviewText): array
    {
        $result = [
            'score' => 7,
            'strengths' => [],
            'improvements' => [],
            'revised_proposal' => null,
            'raw_review' => $reviewText
        ];

        // Extract score
        if (preg_match('/SCORE:\s*(\d+)/i', $reviewText, $matches)) {
            $result['score'] = (int) $matches[1];
        }

        // Extract strengths
        if (preg_match('/STRENGTHS:(.*?)(?=IMPROVEMENTS:|REVISED_PROPOSAL:|$)/is', $reviewText, $matches)) {
            $strengths = trim($matches[1]);
            $result['strengths'] = array_filter(array_map('trim', explode('-', $strengths)));
        }

        // Extract improvements
        if (preg_match('/IMPROVEMENTS:(.*?)(?=REVISED_PROPOSAL:|$)/is', $reviewText, $matches)) {
            $improvements = trim($matches[1]);
            $result['improvements'] = array_filter(array_map('trim', explode('-', $improvements)));
        }

        // Extract revised proposal
        if (preg_match('/REVISED_PROPOSAL:(.*?)$/is', $reviewText, $matches)) {
            $revised = trim($matches[1]);
            if (!empty($revised) && !stripos($revised, 'no revision needed')) {
                $result['revised_proposal'] = $revised;
            }
        }

        return $result;
    }

    /**
     * Test the OpenRouter.ai connection
     */
    public function testConnection(): array
    {
        try {
            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . $this->apiKey,
                'Content-Type' => 'application/json',
                'HTTP-Referer' => config('app.url'),
                'X-Title' => 'Laravel Proposal Generator Test'
            ])->post($this->baseUrl . '/chat/completions', [
                'model' => config('openai.model'),
                'messages' => [
                    [
                        'role' => 'user',
                        'content' => 'Say "Hello, OpenRouter connection is working!"'
                    ]
                ],
                'max_tokens' => 50,
                'temperature' => 0.7,
            ]);

            if (!$response->successful()) {
                throw new \Exception('OpenRouter API error: ' . $response->status() . ' - ' . $response->body());
            }

            $data = $response->json();
            return [
                'success' => true,
                'message' => $data['choices'][0]['message']['content'] ?? 'Connection successful',
                'model' => config('openai.model')
            ];
        } catch (\Exception $e) {
            return [
                'success' => false,
                'message' => $e->getMessage(),
                'model' => config('openai.model')
            ];
        }
    }
}
