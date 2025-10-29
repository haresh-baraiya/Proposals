<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\Template;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Update existing templates to remove {{experience}} placeholder
        $templates = Template::all();

        foreach ($templates as $template) {
            $updatedContent = $template->content;

            // Remove {{experience}} placeholder and clean up the text
            $updatedContent = str_replace('With {{experience}}, I am confident', 'I am confident', $updatedContent);
            $updatedContent = str_replace('I\'ve been working in tech for quite some time now ({{experience}}), and I\'d love', 'I\'d love', $updatedContent);
            $updatedContent = str_replace('{{experience}}', '', $updatedContent);

            // Clean up any double spaces or awkward formatting
            $updatedContent = preg_replace('/\s+/', ' ', $updatedContent);
            $updatedContent = str_replace(' ,', ',', $updatedContent);
            $updatedContent = str_replace('( )', '', $updatedContent);
            $updatedContent = str_replace('()', '', $updatedContent);

            $template->update(['content' => $updatedContent]);
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // This migration cannot be easily reversed as we're removing content
        // If needed, the templates would need to be manually restored
    }
};
