::Legends.Map <- {};
::Legends.Maps <- {
	Type = {
		Legendary = "misc.legend_map_legendary",
		Named = "misc.legend_map_named"
	}
	Locations = []
	add = function(_id, _name) {
		this.Locations.push({
			Target = _id,
			Name = _name
		});
		return this.Locations.top();
	}
}

// vanilla locations
::Legends.Map.AncientStatue <- ::Legends.Maps.add("location.ancient_statue", "Древняя статуя");
::Legends.Map.AncientTemple <- ::Legends.Maps.add("location.ancient_temple", "Древний храм");
::Legends.Map.AncientSpire <- ::Legends.Maps.add("location.ancient_watchtower", "Древний шпиль");
::Legends.Map.BlackMonolith <- ::Legends.Maps.add("location.black_monolith", "Чёрный монолит");
::Legends.Map.GrotequeTree <- ::Legends.Maps.add("location.fountain_of_youth", "Уродливое дерево");
::Legends.Map.IcyCave <- ::Legends.Maps.add("location.icy_cave_location", "Ледяная пещера");
::Legends.Map.StonePillars <- ::Legends.Maps.add("location.kraken_cult", "Каменные столпы");
::Legends.Map.CuriousShipWreck <- ::Legends.Maps.add("location.land_ship", "Таинственное кораблекрушение");
::Legends.Map.SunkenLibrary <- ::Legends.Maps.add("location.sunken_library", "Затонувшая библиотека");
::Legends.Map.HuntingGround <- ::Legends.Maps.add("location.tundra_elk_location", "Охотничьи угодья");
::Legends.Map.UnholdGraveyard <- ::Legends.Maps.add("location.unhold_graveyard", "Кладбище унхольдов");
::Legends.Map.GoblinCity <- ::Legends.Maps.add("location.goblin_city", "Rul\'gazhix");
::Legends.Map.WaterMill <- ::Legends.Maps.add("location.waterwheel", "Водяная мельница");
::Legends.Map.WitchHut <- ::Legends.Maps.add("location.witch_hut", "Хижина ведьмы");
::Legends.Map.FallenStar <- ::Legends.Maps.add("location.holy_site.meteorite", "Падшая звезда");
::Legends.Map.Oracle <- ::Legends.Maps.add("location.holy_site.oracle", "Оракул");
::Legends.Map.AncientCity <- ::Legends.Maps.add("location.holy_site.vulcano", "Древний город");
::Legends.Map.AbandonedVillage <- ::Legends.Maps.add("location.abandoned_village", "Заброшенная деревня");
::Legends.Map.ArtifactReliquary <- ::Legends.Maps.add("location.artifact_reliquary", "Хранилище артефактов");

// legends locations
::Legends.Map.AncientMastaba <- ::Legends.Maps.add("location.legend_mummy", "Древняя мастаба");
::Legends.Map.Tournament <- ::Legends.Maps.add("location.legend_tournament", "Турнир");
//::Legends.Map.TeeteringTower <- ::Legends.Maps.add("location.legend_wizard_tower","Teetering Tower");
