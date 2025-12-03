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
	"Iron Brigade",
	"The Ubermensche",
	"Bottle Brothers",
	"Mordhau Brigands",
	"Rules of Poss",
	"The Elder Ones",
	"Enduring Eels",
	"Rat Petters",
	"Placid Hunters",
	"Heartpiercers",
	"Silver Company",
	"Kraken Band",
	"Sons of Talos",
	"Steel Born",
	"Stormtaken",
	"Unhold Breakers",
	"Tunnel Snakes",
	"Moronic Plungers",
	"The Bloodhound Gang"
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
