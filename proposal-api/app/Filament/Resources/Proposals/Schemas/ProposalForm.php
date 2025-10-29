<?php

namespace App\Filament\Resources\Proposals\Schemas;

use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Schemas\Schema;

class ProposalForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                Select::make('template_id')
                    ->relationship('template', 'name')
                    ->required(),
                TextInput::make('job_title')
                    ->required(),
                Textarea::make('job_description')
                    ->columnSpanFull(),
                Textarea::make('job_skills')
                    ->columnSpanFull(),
                TextInput::make('job_budget'),
                Textarea::make('generated_proposal')
                    ->required()
                    ->columnSpanFull(),
            ]);
    }
}
