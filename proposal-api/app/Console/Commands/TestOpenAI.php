<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\OpenAIService;

class TestOpenAI extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'openai:test';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Test OpenAI integration';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('Testing OpenAI integration...');

        // Check if API key is configured
        if (empty(config('openai.api_key'))) {
            $this->error('OpenAI API key is not configured. Please set OPENAI_API_KEY in your .env file.');
            return 1;
        }

        $this->info('API Key: ' . substr(config('openai.api_key'), 0, 7) . '...');
        $this->info('Model: ' . config('openai.model'));

        try {
            $openAIService = new OpenAIService();

            // Test connection
            $this->info('Testing connection...');
            $result = $openAIService->testConnection();

            if ($result['success']) {
                $this->info('✅ Connection successful!');
                $this->info('Response: ' . $result['message']);
            } else {
                $this->error('❌ Connection failed: ' . $result['message']);
                return 1;
            }

            // Test proposal generation
            $this->info('Testing proposal generation...');
            $testData = [
                'job_title' => 'Full Stack Developer',
                'job_description' => 'We need a developer to build a web application using React and Laravel.',
                'client_name' => 'Test Client',
                'skills' => 'React, Laravel, PHP, JavaScript',
                'experience' => '5 years of web development'
            ];

            $proposal = $openAIService->generateProposal($testData);

            $this->info('✅ Proposal generated successfully!');
            $this->info('Length: ' . strlen($proposal) . ' characters');
            $this->line('');
            $this->line('--- GENERATED PROPOSAL ---');
            $this->line($proposal);
            $this->line('--- END PROPOSAL ---');

            return 0;

        } catch (\Exception $e) {
            $this->error('❌ Error: ' . $e->getMessage());
            return 1;
        }
    }
}
