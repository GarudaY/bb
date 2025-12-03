::mods_hookExactClass("retinue/followers/scavenger_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.scavenger";
                this.m.Name = "Тележка мародёра";
                this.m.Description = "Хотя это и рутинно, привычка забирать всё, что не прибито, после боя может сэкономить много денег в будущем. В комплекте — щипцы, чтобы разжимать мёртвые хватки.";
                this.m.Image = "ui/campfire/legend_scavenger_01";
                this.m.Cost = 1500;
                this.m.Effects = [
                        "Возвращает часть всего использованного в бою боезапаса",
                        "Возвращает инструменты и припасы с каждой уничтоженной вами брони"
                ];

                this.addSkillRequirement("Иметь хотя бы одну из следующих предысторий: Нищий, Инвалид, Беженец, Должник", [
			"background.beggar",
			"background.cripple",
			"background.refugee",
			"background.slave",
			"background.legend_commander_beggar",
			"background.legend_commander_beggar_op",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function ()
	{
		if ("IsRecoveringAmmo" in this.World.Assets.m)
			this.World.Assets.m.IsRecoveringAmmo = true;
		if ("IsRecoveringArmor" in this.World.Assets.m)
			this.World.Assets.m.IsRecoveringArmor = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

