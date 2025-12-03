::Legends.CampContracts <- {
	EmployerFactory = [],
	EmployerBanner = [],
	EmployersPerFaction = 4,
	EmployerFaction = {
		COUNT = 0
	}
	addFaction = function (_banner, _factory) {
		local faction = this.EmployerFaction.COUNT++;
		if (_banner.find(".png") != null)
			_banner = _banner.slice(0, _banner.len() - 4);
		this.EmployerBanner.push(_banner);
		this.EmployerFactory.push(_factory);
		return faction;
	}
}

::Legends.CampContracts.EmployerFaction.Barbarians <- ::Legends.CampContracts.addFaction("ui/banners/factions/banner_legend_barbarians_s.png", function (_factionID, _roster) {
	local unit = ::Const.World.Spawn.Troops.BarbarianChampion;
	local character = _roster.create("scripts/entity/tactical/employer/legend_barbarian_employer");
	character.setFaction(_factionID);
	character.m.HairColors = ::Const.HairColors.Young;
	character.setAppearance();
	character.assignRandomEquipment();
	character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : ""));
});

::Legends.CampContracts.EmployerFaction.Bandits <- ::Legends.CampContracts.addFaction("ui/banners/factions/banner_legend_bandits_s.png", function (_factionID, _roster) {
	local unit = ::Const.World.Spawn.Troops.BanditLeader;
	local character = _roster.create("scripts/entity/tactical/employer/legend_bandit_employer");
	character.setFaction(_factionID);
	character.m.HairColors = ::Const.HairColors.Young;
	character.setAppearance();
	character.assignRandomEquipment();
	character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : ""));
});

::Legends.CampContracts.EmployerFaction.Necromancers <- ::Legends.CampContracts.addFaction("ui/banners/factions/banner_legend_necro_s.png", function (_factionID, _roster) {
	local unit = ::Const.World.Spawn.Troops.Necromancer;
	local character = _roster.create("scripts/entity/tactical/employer/legend_necromancer_employer");
	character.setFaction(_factionID);
	character.m.HairColors = this.Const.HairColors.Old;
	character.setAppearance();
	character.assignRandomEquipment();
	character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : ""));
});

::Legends.CampContracts.EmployerFaction.Legion <- ::Legends.CampContracts.addFaction("ui/banners/factions/banner_legend_legion_s.png", function (_factionID, _roster) { //needs new banner art for legion ideally. this is a placeholder.
	local unit = ::Const.World.Spawn.Troops.SkeletonHeavy; //may change to priest later
	local character = _roster.create("scripts/entity/tactical/employer/legend_legion_employer"); //need to refine this - clothes and style
	character.setFaction(_factionID);
	character.assignRandomEquipment();
	character.setName(::Const.World.Common.generateName(unit.NameList) + (unit.TitleList != null ? " " + unit.TitleList[::Math.rand(0, unit.TitleList.len() - 1)] : "")); //double check
});


::Legends.CampContracts.IntroBarbarians <- [{
        ID = "Intro",
        Title = "Переговоры",
        Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{Группа искалеченных шрамами воинов входит в лагерь, словно он принадлежит им. Один рычит приветствие, другой плюёт в землю, а самый крупный бросает на ваш костёр наполовину зажаренную ногу. %SPEECH_ON%Мы говорим. Ты слушаешь.%SPEECH_OFF%Похоже, они хотят нанять вас или, может быть, сразиться. В любом случае стоит выслушать. | Вы просыпаетесь и видите у края лагеря сложенную гору костей унхольда. Мгновение спустя из-за деревьев гулко раздаются варварские барабаны, и появляются массивные силуэты. Это либо вызов, либо приглашение. Или и то и другое.}",
        Image = "",
        List = [],
        ShowEmployer = false,
        ShowDifficulty = true,
        Options = [{
                Text = "Поговорим о деле.",
                function getResult() {
                        return "Task";
                }
        }]
}];

::Legends.CampContracts.IntroBandits <- [{
        ID = "Intro",
        Title = "Переговоры",
        Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{Какой‑то человек неожиданно врезается вам в плечо. Вы уже тянетесь к мечу, но он быстро объясняет, что некто по имени %employer% хочет видеть вас. Убирая оружие в ножны, вы велите незнакомцу отвести вас к нему — если у него есть дело, пусть скажет сам. Посланник кивает и ведёт к бандитскому логову. | Посыльный — мальчишка ростом с длинный меч — промчался мимо, подбросив свиток в воздух. Вы ловите его, но пока ищете взглядом мальца, он уже пропал. Пожав плечами, разворачиваете свиток и видите имя %employer%. Внизу приписаны указания, как пройти к убежищу бандитов.}",
        Image = "",
        List = [],
        ShowEmployer = false,
        ShowDifficulty = true,
        Options = [
                {
                        Text = "Поговорим о деле.",
                        function getResult() {
                                return "Task";
                        }
                }
        ]
}];

::Legends.CampContracts.IntroNecromancers <- [{
        ID = "Intro",
        Title = "Переговоры",
        Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{Ваш огонь без предупреждения тускнеет. Пламя шипит, сжимаясь до углей. Затем вы замечаете %person_employer%, сотканного из тени и шёлка, скользящего ближе. %SPEECH_ON%Не пугайся. Мне нужна помощь… не сердце.%SPEECH_OFF% Ритуал пошёл наперекосяк. Что‑то пожирает мёртвых, но это не дело %them_employer%. %SPEECH_ON%Не всё, что несёт запах смерти, моё.%SPEECH_OFF%%They_employer% предлагает больше золота, чем здравого смысла.}",
        Image = "",
        List = [],
        ShowEmployer = false,
        ShowDifficulty = true,
        Options = [
                {
                        Text = "Поговорим о деле.",
                        function getResult() {
                                return "Task";
                        }
                }
        ]
}];

::Legends.CampContracts.IntroLegion <- [{
	ID = "Intro",
        Title = "Посланник",
	Text = "[img]gfx/ui/events/legend_camp_hunt.png[/img]{Лагерь наполнен лишь звоном точащихся клинков и скрипом костей. Ничто больше не нарушает приготовления к следующей битве, только тихое служение. Без церемоний, объявлений или предупреждений в лагерь входит %person_employer%. Не произнося ни слова, он вручает вам запечатанный свиток...}",
	Image = "",
	List = [],
	ShowEmployer = false,
	ShowDifficulty = true,
	Options = [
		{
                        Text = "Поговорим о деле.",
			function getResult() {
				return "Task";
			}
		}
	]
}];
