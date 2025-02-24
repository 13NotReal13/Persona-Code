//
//  MatrixHelpInfoViewModel.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 01/12/2024.
//

import Foundation

final class HelpInfoViewModel {
    let categories: [ArkanInfo] = [
        ArkanInfo(arkanNumber: 0, title: "1. Число Судьбы", subcategories: [
            Subcategory(title: "Значение числа судьбы", shortDescription: "Общее описание и характеристика полученного числа судьбы."),
            Subcategory(title: "Влияние на личность", shortDescription: "Как число судьбы формирует ваши черты характера и поведение."),
            Subcategory(title: "Рекомендации", shortDescription: "Советы по гармонизации жизни в соответствии с вашим числом судьбы.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "2. Жизненный Путь", subcategories: [
            Subcategory(title: "Основные этапы жизни", shortDescription: "Ключевые периоды вашей жизни и их значение для вашего развития."),
            Subcategory(title: "Направления развития", shortDescription: "Возможные пути самореализации и карьерного роста."),
            Subcategory(title: "Цели и задачи", shortDescription: "Определение жизненных приоритетов и постановка целей."),
            Subcategory(title: "Влияние внешних факторов", shortDescription: "Как окружение и обстоятельства влияют на ваш жизненный путь."),
            Subcategory(title: "Советы по достижению успеха", shortDescription: "Рекомендации для успешного достижения поставленных целей.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "3. Отношения", subcategories: [
            Subcategory(title: "Романтические отношения", shortDescription: "Перспективы в любви и браке, поиск гармонии в личной жизни."),
            Subcategory(title: "Дружеские связи", shortDescription: "Построение и укрепление дружеских отношений."),
            Subcategory(title: "Семейные отношения", shortDescription: "Взаимодействие с членами семьи и родственниками."),
            Subcategory(title: "Социальная адаптация", shortDescription: "Умение общаться, налаживать контакты и интегрироваться в коллективы."),
            Subcategory(title: "Совместимость", shortDescription: "Анализ с кем легче установить гармоничные и долгосрочные отношения.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "4. Деньги и Финансы", subcategories: [
            Subcategory(title: "Финансовый потенциал", shortDescription: "Ваши способности к заработку, накоплению и управлению финансами."),
            Subcategory(title: "Отношение к деньгам", shortDescription: "Психологические установки и убеждения относительно материального благополучия."),
            Subcategory(title: "Инвестиции и риски", shortDescription: "Склонность к финансовым авантюрам и умение управлять рисками."),
            Subcategory(title: "Финансовые препятствия", shortDescription: "Возможные трудности на пути к финансовой стабильности и способы их преодоления."),
            Subcategory(title: "Советы по управлению финансами", shortDescription: "Рекомендации для эффективного управления личными средствами.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "5. Карьера и Профессия", subcategories: [
            Subcategory(title: "Рекомендуемые сферы деятельности", shortDescription: "Области, в которых вы можете достичь наибольшего успеха."),
            Subcategory(title: "Профессиональные навыки", shortDescription: "Ключевые умения и компетенции, которые следует развивать."),
            Subcategory(title: "Карьерный рост", shortDescription: "Перспективы продвижения и профессионального развития."),
            Subcategory(title: "Рабочая среда", shortDescription: "Предпочтительные условия труда и типы коллективов."),
            Subcategory(title: "Советы по построению карьеры", shortDescription: "Стратегии для достижения профессиональных целей и удовлетворения от работы.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "6. Здоровье", subcategories: [
            Subcategory(title: "Физическое состояние", shortDescription: "Общий потенциал вашего здоровья и жизненной силы."),
            Subcategory(title: "Энергетический баланс", shortDescription: "Уровень жизненной энергии и способы его поддержания."),
            Subcategory(title: "Уязвимые места", shortDescription: "Органы и системы организма, требующие особого внимания."),
            Subcategory(title: "Профилактика и уход", shortDescription: "Рекомендации по поддержанию и улучшению здоровья."),
            Subcategory(title: "Эмоциональное благополучие", shortDescription: "Влияние эмоционального состояния на физическое здоровье.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "7. Таланты и Способности", subcategories: [
            Subcategory(title: "Врожденные таланты", shortDescription: "Способности и дарования, данные вам от природы."),
            Subcategory(title: "Творческий потенциал", shortDescription: "Склонности к искусству, музыке, литературе и другим видам творчества."),
            Subcategory(title: "Интеллектуальные способности", shortDescription: "Умственные ресурсы и их эффективное использование."),
            Subcategory(title: "Развитие навыков", shortDescription: "Методы раскрытия и усиления ваших способностей."),
            Subcategory(title: "Применение талантов", shortDescription: "Сферы, где вы можете максимально реализовать свои дарования.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "8. Испытания и Препятствия", subcategories: [
            Subcategory(title: "Основные трудности", shortDescription: "Проблемы и вызовы, с которыми вы можете столкнуться."),
            Subcategory(title: "Кармические задачи", shortDescription: "Уроки, которые необходимо усвоить для духовного роста."),
            Subcategory(title: "Внутренние конфликты", shortDescription: "Борьба с сомнениями, страхами и внутренними противоречиями."),
            Subcategory(title: "Внешние препятствия", shortDescription: "Влияние окружающих людей и обстоятельств на ваш путь."),
            Subcategory(title: "Стратегии преодоления", shortDescription: "Эффективные способы справиться с испытаниями и выйти из них сильнее.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "9. Личностный Рост", subcategories: [
            Subcategory(title: "Самоосознание", shortDescription: "Понимание своих истинных желаний, ценностей и целей."),
            Subcategory(title: "Духовное развитие", shortDescription: "Поиск внутренней гармонии и смыслов жизни."),
            Subcategory(title: "Эмоциональный интеллект", shortDescription: "Умение распознавать и управлять своими эмоциями."),
            Subcategory(title: "Обучение и образование", shortDescription: "Необходимость в постоянном развитии и приобретении новых знаний."),
            Subcategory(title: "Рекомендации по развитию", shortDescription: "Практики и методики для личностного и духовного роста.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "10. Внутренний Мир", subcategories: [
            Subcategory(title: "Психологический профиль", shortDescription: "Особенности вашего характера и их влияние на жизнь."),
            Subcategory(title: "Подсознательные мотивы", shortDescription: "Скрытые желания, страхи и убеждения, влияющие на поведение."),
            Subcategory(title: "Интуиция", shortDescription: "Способность доверять внутреннему голосу и принимать интуитивные решения."),
            Subcategory(title: "Медитация и самоанализ", shortDescription: "Инструменты для глубокого понимания себя."),
            Subcategory(title: "Гармония с собой", shortDescription: "Достижение внутреннего баланса и удовлетворенности жизнью.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "11. Предназначение", subcategories: [
            Subcategory(title: "Жизненная миссия", shortDescription: "Главная цель вашего существования и задачи, которые вы призваны выполнить."),
            Subcategory(title: "Вклад в общество", shortDescription: "Роль и влияние, которые вы можете оказать на окружающий мир."),
            Subcategory(title: "Смысл жизни", shortDescription: "Поиск и понимание глубинного смысла своего пути."),
            Subcategory(title: "Пути реализации", shortDescription: "Конкретные шаги для воплощения своего предназначения."),
            Subcategory(title: "Препятствия на пути", shortDescription: "Трудности, которые могут возникнуть, и способы их преодоления.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "12. Кармические Уроки", subcategories: [
            Subcategory(title: "Наследие прошлого", shortDescription: "Влияние прошлых жизней или опытов на настоящее."),
            Subcategory(title: "Повторяющиеся ситуации", shortDescription: "Сценарии, которые повторяются в вашей жизни и требуют осознания."),
            Subcategory(title: "Разрешение кармы", shortDescription: "Способы отработки кармических долгов и освобождения от них."),
            Subcategory(title: "Рост через опыт", shortDescription: "Извлечение мудрости и силы из пережитых уроков."),
            Subcategory(title: "Освобождение", shortDescription: "Как избавиться от негативных влияний и начать новую главу жизни.")
        ]),
        ArkanInfo(arkanNumber: 0, title: "13. Будущее", subcategories: [
            Subcategory(title: "Краткосрочные перспективы", shortDescription: "Ожидаемые события и изменения в ближайшем будущем."),
            Subcategory(title: "Долгосрочные планы", shortDescription: "Ваши отдаленные цели, мечты и стремления."),
            Subcategory(title: "Потенциальные изменения", shortDescription: "Возможные повороты судьбы и как к ним подготовиться."),
            Subcategory(title: "Факторы влияния", shortDescription: "Внешние и внутренние факторы, способные повлиять на ваше будущее."),
            Subcategory(title: "Советы по формированию будущего", shortDescription: "Рекомендации по направлению жизни в желаемое русло.")
        ]),
    ]
}
