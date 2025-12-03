::mods_hookExactClass("retinue/followers/cook_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.cook";
                this.m.Name = "Кухонное оборудование";
                this.m.Description = "Хорошая горячая еда сильно помогает восстановить тело и дух. В дикой местности повар может делать лишь немногое из того, что под рукой, но правильное снаряжение для готовки гарантирует, что ни одна провизия не пропадёт зря.";
                this.m.Image = "ui/campfire/legend_cook_01";
                this.m.Cost = 1000;
                this.m.Effects = [
                        "Продлевает срок годности всех запасов на 4 дня"
                ];

                this.addSkillRequirement("Иметь кого-то с умением 'Полевой повар'. Гарантировано у Пекарей, Рыбачек, Каннибалов и Мясников, реже встречается у многих других", [
			::Legends.Perks.getID(::Legends.Perk.LegendCampCook),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function ()
	{
		if ("FoodAdditionalDays" in this.World.Assets.m)
			this.World.Assets.m.FoodAdditionalDays = 4;
		//if ("HitpointsPerHourMult" in this.World.Assets.m)
			//this.World.Assets.m.HitpointsPerHourMult = 1.33;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

