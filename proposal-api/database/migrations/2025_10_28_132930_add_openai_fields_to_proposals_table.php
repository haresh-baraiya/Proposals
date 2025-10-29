<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('proposals', function (Blueprint $table) {
            // Check and add columns only if they don't exist
            if (!Schema::hasColumn('proposals', 'client_name')) {
                $table->string('client_name')->nullable()->after('job_budget');
            }

            if (!Schema::hasColumn('proposals', 'skills_used')) {
                $table->text('skills_used')->nullable()->after('job_budget');
            }

            if (!Schema::hasColumn('proposals', 'experience_mentioned')) {
                $table->text('experience_mentioned')->nullable()->after('job_budget');
            }

            if (!Schema::hasColumn('proposals', 'generated_at')) {
                $table->timestamp('generated_at')->nullable()->after('job_budget');
            }
        });

        // Make template_id nullable in a separate statement
        Schema::table('proposals', function (Blueprint $table) {
            $table->foreignId('template_id')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('proposals', function (Blueprint $table) {
            $table->dropColumn([
                'client_name',
                'skills_used',
                'experience_mentioned',
                'generated_at'
            ]);

            $table->foreignId('template_id')->nullable(false)->change();
        });
    }
};
