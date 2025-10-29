<?php

namespace Database\Seeders;

use App\Models\Template;
use Illuminate\Database\Seeder;

class TemplateSeeder extends Seeder
{
    public function run(): void
    {
        Template::create([
            'name' => 'Professional Web Development',
            'description' => 'Standard professional template for web development projects',
            'is_active' => true,
            'content' => <<<'EOT'
Dear Hiring Manager,

I am writing to express my strong interest in the {{job_title}} position. I am confident in my ability to deliver exceptional results for your project.

I have carefully reviewed your job description: {{job_description}}

My expertise directly aligns with your requirements, particularly in {{skills}}. I understand that your budget is {{budget}}, and I am prepared to work within your parameters while ensuring high-quality deliverables.

My approach includes:
- Thorough project analysis and planning
- Regular communication and progress updates
- Clean, maintainable code following best practices
- Testing and quality assurance
- On-time delivery

I would welcome the opportunity to discuss how my skills and experience can contribute to the success of your project. I am available for a call at your convenience.

Looking forward to working with you.

Best regards
EOT
        ]);

        Template::create([
            'name' => 'Friendly Web Development',
            'description' => 'Warm and approachable template for web development',
            'is_active' => true,
            'content' => <<<'EOT'
Hi there!

Thanks for posting this {{job_title}} opportunity – it sounds like a great project!

I'd love to help bring your vision to life. I read through your description and I'm excited about what you're building.

Here's what caught my attention: {{job_description}}

I have solid experience with {{skills}}, which seems like a perfect match for what you need. I noticed your budget is {{budget}}, and I'm flexible and ready to discuss how we can make this work.

What I bring to the table:
- A collaborative, easy-going work style
- Clear communication throughout the project
- Quality work that I'm proud to put my name on
- Flexibility to adapt to your needs

I'd love to chat more about your project! Feel free to reach out anytime – I'm here to help.

Cheers!
EOT
        ]);

        Template::create([
            'name' => 'Concise & Direct',
            'description' => 'Short and to-the-point template for quick applications',
            'is_active' => true,
            'content' => <<<'EOT'
Hello,

I'm interested in your {{job_title}} project and believe I'm a great fit.

Key points:
• {{skills}} expertise
• Available to start immediately
• Budget: {{budget}} works for me
• Quality delivery guaranteed

I've reviewed your requirements: {{job_description}}

Let's discuss how I can help achieve your goals.

Best regards
EOT
        ]);

        Template::create([
            'name' => 'AI-Enhanced Template',
            'description' => 'Template designed to work well with AI enhancement',
            'is_active' => true,
            'content' => <<<'EOT'
Dear Hiring Manager,

I'm excited about your {{job_title}} project and would love to contribute to its success.

Project Understanding:
{{job_description}}

My Relevant Skills:
{{skills}}

Budget Alignment:
I see your budget is {{budget}}, and I'm confident we can deliver excellent value within this range.

Why Choose Me:
- Proven track record in similar projects
- Clear communication and regular updates
- Quality-focused approach
- On-time delivery commitment

I'd appreciate the opportunity to discuss your project in detail and show how my expertise can benefit your goals.

Looking forward to your response.

Best regards
EOT
        ]);
    }
}
