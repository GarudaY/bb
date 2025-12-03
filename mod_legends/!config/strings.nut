::Const.Strings.EngageEnemyNumbersNames <- {
        Few = "Несколько",
        Some = "Пара",
        Several = "Немного",
        Pack = "Стая",
        Many = "Много",
        Lots = "Множество",
        Plethora = "Тьма",
        Hordes = "Полчища",
        Throng = "Толпа",
        Swarm = "Рой",
        Legion = "Легион",
        Myriad = "Бесчисленное множество"
};

::Const.Strings.MercenaryCompanyNames.extend([
        "Железная бригада",
        "Сверхлюди",
        "Бутылочные братья",
        "Разбойники Мордау",
        "Законы Посса",
        "Древние",
        "Выносливые угри",
        "Крысогладцы",
        "Мирные охотники",
        "Пронзающие сердца",
        "Серебряная компания",
        "Банда Кракена",
        "Сыны Талоса",
        "Рождённые сталью",
        "Унесённые бурей",
        "Ломатели унхольдов",
        "Туннельные змеи",
        "Тупые ныряльщики",
        "Банда ищей"
]);
::Const.Strings.FreeCompanyNames <- clone ::Const.Strings.MercenaryCompanyNames;
::Const.Strings.CityEncounterNames <- [
        "Пока в %settlement%...",
        "Прогуливаясь по %settlement%.",
        "Что-то происходит в %settlement%."
];
::Const.Strings.CampEncounterNames <- [
        "Во время стоянки..."
];

::Const.Strings.randomCityEncounterName <- function ()
{
	return ::Const.Strings.CityEncounterNames[this.Math.rand(0, ::Const.Strings.CityEncounterNames.len() - 1)];
}

::Const.Strings.randomCampEncounterName <- function ()
{
	return ::Const.Strings.CampEncounterNames[this.Math.rand(0, ::Const.Strings.CampEncounterNames.len() - 1)];
}
