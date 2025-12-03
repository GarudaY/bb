::mods_hookExactClass("retinue/followers/lookout_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.lookout";
                this.m.Name = "Пост разведчиков";
                this.m.Description = "Быстрый дозорный с острым зрением, отправленный впереди отряда, помогает вовремя узнать об опасностях и примечательных местах, прежде чем те заметят сам отряд.";
                this.m.Image = "ui/campfire/legend_lookout_01";
                this.m.Cost = 2500;
                this.m.Effects = [
                        "Увеличивает радиус обзора на 25%",
                        "Показывает расширенную информацию о следах"
                ];

                this.addSkillRequirement("Нанять кого-то с умением 'Дозорный'. Гарантировано у Вора, Браконьера, Кочевника и многих других", [
                        ::Legends.Perks.getID(::Legends.Perk.LegendLookout),
                        "background.legend_companion_melee",
                        "background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function ()
	{
		if ("VisionRadiusMult" in this.World.Assets.m)
			this.World.Assets.m.VisionRadiusMult = 1.25;
		if ("IsShowingExtendedFootprints" in this.World.Assets.m)
			this.World.Assets.m.IsShowingExtendedFootprints = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

