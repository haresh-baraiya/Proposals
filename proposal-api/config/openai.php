<?php

return [
    /*
    |--------------------------------------------------------------------------
    | OpenRouter.ai API Key
    |--------------------------------------------------------------------------
    |
    | Here you may specify your OpenRouter.ai API key. This key is used to authenticate
    | requests to the OpenRouter.ai API for generating proposals.
    |
    */
    'api_key' => env('OPENAI_API_KEY'),

    /*
    |--------------------------------------------------------------------------
    | Default Model
    |--------------------------------------------------------------------------
    |
    | The default model to use for generating proposals via OpenRouter.ai.
    | Available models: deepseek/deepseek-chat-v3.1, openai/gpt-3.5-turbo, openai/gpt-4, etc.
    |
    */
    'model' => env('OPENAI_MODEL', 'deepseek/deepseek-chat-v3.1'),

    /*
    |--------------------------------------------------------------------------
    | Generation Parameters
    |--------------------------------------------------------------------------
    |
    | These parameters control how the AI generates proposals.
    |
    */
    'max_tokens' => env('OPENAI_MAX_TOKENS', 800),
    'temperature' => env('OPENAI_TEMPERATURE', 0.7),

    /*
    |--------------------------------------------------------------------------
    | System Prompt
    |--------------------------------------------------------------------------
    |
    | The system prompt that guides the AI in generating proposals.
    |
    */
    'system_prompt' => 'You are a professional freelancer writing compelling Upwork proposals. Create personalized, engaging proposals that highlight relevant skills and experience. Keep proposals concise (under 200 words), professional, and tailored to the specific job requirements.',

    /*
    |--------------------------------------------------------------------------
    | OpenRouter.ai Base URL
    |--------------------------------------------------------------------------
    |
    | The base URL for OpenRouter.ai API endpoints.
    |
    */
    'base_url' => 'https://openrouter.ai/api/v1',
];
