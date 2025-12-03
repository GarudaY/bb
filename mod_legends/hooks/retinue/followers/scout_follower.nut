::mods_hookExactClass("retinue/followers/scout_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.scout";
                this.m.Name = "Тотем дозорного";
                this.m.Description = "Люди из лесов и окраин клянутся, что присутствие этого тотема приносит удачу окружающим, каким-то образом предотвращая болезни и несчастья, пока он стоит в лагере. Звучит как полнейшая чушь, но если они от этого довольны...";
                this.m.Image = "ui/campfire/legend_scout_01";
                this.m.Cost = 1250;
                this.m.Effects = [
                        "Снижает штраф к перемещению по сложной местности на 15%",
                        "Предотвращает болезни и несчастья из-за местности"
                ];

                this.addSkillRequirement("Иметь хотя бы один из следующих предысторий: Дикий/Дикая, Охотник, Лесоруб, Следопыт, Мастер-лучник", [
                        "background.wildman",
                        "background.hunter",
                        "background.lumberjack",
			"background.legend_ranger",
			"background.legend_commander_ranger",
			"background.legend_master_archer",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	// handled in party.nut
	o.onUpdate = function ()
	{
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

