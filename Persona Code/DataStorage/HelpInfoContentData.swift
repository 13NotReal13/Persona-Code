//
//  HelpInfoViewModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import Foundation

final class HelpInfoContentData {
    let categories: [CodeInfo] = [
        CodeInfo(codeNumber: 0, title: "1. Persona Code", subcategories: [
            Subcategory(title: "Code Meaning", shortDescription: "Your key characteristics and personality traits."),
            Subcategory(title: "Influence on Character", shortDescription: "How inherent qualities shape your behavior."),
            Subcategory(title: "Recommendations", shortDescription: "How to use your strengths and work with limitations.")
        ]),
        CodeInfo(codeNumber: 0, title: "2. Path of Development", subcategories: [
            Subcategory(title: "Key Stages", shortDescription: "Main life periods and their significance."),
            Subcategory(title: "Self-Realization", shortDescription: "Ways to unlock potential and directions for growth."),
            Subcategory(title: "Priorities and Goals", shortDescription: "How to define important life guidelines."),
            Subcategory(title: "External Influences", shortDescription: "How circumstances and environment affect your path."),
            Subcategory(title: "Success Strategies", shortDescription: "Practical tips for achieving goals.")
        ]),
        CodeInfo(codeNumber: 0, title: "3. Communication", subcategories: [
            Subcategory(title: "Personal Relationships", shortDescription: "How to build harmonious relationships."),
            Subcategory(title: "Friendly Connections", shortDescription: "Principles of reliable and long-term friendship."),
            Subcategory(title: "Family Relationships", shortDescription: "Interaction with close ones."),
            Subcategory(title: "Social Adaptation", shortDescription: "Ways to establish communication and fit into a group."),
            Subcategory(title: "Compatibility", shortDescription: "How to find people with matching energy.")
        ]),
        CodeInfo(codeNumber: 0, title: "4. Financial Potential", subcategories: [
            Subcategory(title: "Financial Abilities", shortDescription: "Your strengths and weaknesses in managing money."),
            Subcategory(title: "Money Mindset", shortDescription: "How your beliefs affect financial well-being."),
            Subcategory(title: "Risks and Investments", shortDescription: "Inclination towards caution or risk-taking in finance."),
            Subcategory(title: "Income Obstacles", shortDescription: "Main challenges and ways to overcome them."),
            Subcategory(title: "Effective Management", shortDescription: "Strategies for financial management.")
        ]),
        CodeInfo(codeNumber: 0, title: "5. Professional Growth", subcategories: [
            Subcategory(title: "Suitable Fields", shortDescription: "In which areas you can achieve success."),
            Subcategory(title: "Key Skills", shortDescription: "Which competencies should be developed."),
            Subcategory(title: "Career Prospects", shortDescription: "How to move up the career ladder."),
            Subcategory(title: "Work Environment", shortDescription: "In what team and conditions you will feel comfortable."),
            Subcategory(title: "Growth Strategies", shortDescription: "How to build a successful career.")
        ]),
        CodeInfo(codeNumber: 0, title: "6. Resource State", subcategories: [
            Subcategory(title: "Physical Potential", shortDescription: "Overall endurance and susceptibility to illnesses."),
            Subcategory(title: "Energy Balance", shortDescription: "Level of vital energy and ways to maintain it."),
            Subcategory(title: "Weak Points of the Body", shortDescription: "Aspects of health that require attention."),
            Subcategory(title: "Prevention and Support", shortDescription: "How to take care of yourself."),
            Subcategory(title: "Emotional Stability", shortDescription: "Impact of psycho-emotional state on the body.")
        ]),
        CodeInfo(codeNumber: 0, title: "7. Strengths", subcategories: [
            Subcategory(title: "Natural Talents", shortDescription: "Inherent abilities and traits."),
            Subcategory(title: "Creative Potential", shortDescription: "Inclination towards art and creative thinking."),
            Subcategory(title: "Intellectual Resource", shortDescription: "Level of logic and analytical skills."),
            Subcategory(title: "Skill Development", shortDescription: "How to unlock and enhance your strengths."),
            Subcategory(title: "Talent Application", shortDescription: "Where to maximize your potential.")
        ]),
        CodeInfo(codeNumber: 0, title: "8. Risk Zones", subcategories: [
            Subcategory(title: "Main Challenges", shortDescription: "What you have to face."),
            Subcategory(title: "Profound Lessons", shortDescription: "Situations that provide key insights."),
            Subcategory(title: "Inner Conflicts", shortDescription: "Internal contradictions and ways to resolve them."),
            Subcategory(title: "External Barriers", shortDescription: "Influence of the environment on your path."),
            Subcategory(title: "Overcoming Tactics", shortDescription: "How to cope with challenges.")
        ]),
        CodeInfo(codeNumber: 0, title: "9. Self-Development", subcategories: [
            Subcategory(title: "Self-Awareness", shortDescription: "Deep understanding of yourself."),
            Subcategory(title: "Personality Harmonization", shortDescription: "Working on emotional intelligence."),
            Subcategory(title: "Learning and Growth", shortDescription: "Importance of new knowledge and skills."),
            Subcategory(title: "Personal Strategies", shortDescription: "How to develop effectively."),
            Subcategory(title: "Development Practices", shortDescription: "Effective methods of self-improvement.")
        ]),
        CodeInfo(codeNumber: 0, title: "10. Inner Balance", subcategories: [
            Subcategory(title: "Psychological Profile", shortDescription: "Key personality traits."),
            Subcategory(title: "Subconscious Mechanisms", shortDescription: "How hidden beliefs influence life."),
            Subcategory(title: "Intuition Development", shortDescription: "How to make more accurate decisions."),
            Subcategory(title: "Reflection and Self-Analysis", shortDescription: "Methods of deep self-understanding."),
            Subcategory(title: "Harmony with Yourself", shortDescription: "Achieving inner peace.")
        ]),
        CodeInfo(codeNumber: 0, title: "11. Life Goals", subcategories: [
            Subcategory(title: "Key Tasks", shortDescription: "Main guidelines in your life."),
            Subcategory(title: "Social Contribution", shortDescription: "How you impact the world around."),
            Subcategory(title: "Search for Meaning", shortDescription: "What makes your life fulfilling."),
            Subcategory(title: "Paths to Implementation", shortDescription: "Specific steps towards goals."),
            Subcategory(title: "Overcoming Obstacles", shortDescription: "How to handle difficulties along the way.")
        ]),
        CodeInfo(codeNumber: 0, title: "12. Experience and Evolution", subcategories: [
            Subcategory(title: "Impact of Past Experience", shortDescription: "How past events shape you."),
            Subcategory(title: "Recurring Scenarios", shortDescription: "Situations that require awareness."),
            Subcategory(title: "Resolving Complex Situations", shortDescription: "How to work with deep beliefs."),
            Subcategory(title: "Growth through Challenges", shortDescription: "How to use difficulties for development."),
            Subcategory(title: "Liberation from the Past", shortDescription: "How not to dwell on negative experiences.")
        ])
    ]
}

