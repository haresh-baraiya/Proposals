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
        Schema::table('templates', function (Blueprint $table) {
            $table->dropColumn(['tone', 'length', 'usage_count']);
        });

        Schema::table('proposals', function (Blueprint $table) {
            $table->dropColumn(['tone', 'length']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('templates', function (Blueprint $table) {
            $table->string('tone')->default('professional');
            $table->string('length')->default('medium');
            $table->integer('usage_count')->default(0);
        });

        Schema::table('proposals', function (Blueprint $table) {
            $table->string('tone');
            $table->string('length');
        });
    }
};
