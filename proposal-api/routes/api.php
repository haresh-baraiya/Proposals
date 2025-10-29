<?php

use App\Http\Controllers\Api\ProposalController;
use App\Http\Controllers\Api\AuthController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    // Public routes
    Route::post('/login', [AuthController::class, 'login']);

    // Public routes for Chrome extension
    Route::post('/proposals', [ProposalController::class, 'store']);
    Route::get('/openai/test', [ProposalController::class, 'testOpenAI']);

    // Protected routes
    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/me', [AuthController::class, 'me']);
        Route::post('/proposals/generate', [ProposalController::class, 'generate']);
        Route::post('/proposals/generate-openai', [ProposalController::class, 'generateWithOpenAI']);
        Route::post('/proposals/generate-with-review', [ProposalController::class, 'generateWithAIReview']);
        Route::get('/proposals', [ProposalController::class, 'getProposals']);
        Route::get('/proposals/{id}', [ProposalController::class, 'getProposal']);
        Route::get('/templates', [ProposalController::class, 'getTemplates']);
    });
});
