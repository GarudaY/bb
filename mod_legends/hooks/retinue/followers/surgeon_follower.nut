::mods_hookExactClass("retinue/followers/surgeon_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.surgeon";
                this.m.Name = "Стол для сортировки";
                this.m.Description = "Подготовленное место для обработки тяжёлых ран может стать тонкой гранью между жизнью и смертью для отряда. Возможно, однажды и для вас самого...";
                this.m.Image = "ui/campfire/legend_surgeon_01";
                this.m.Cost = 1750;
                this.m.Effects = [
                        "Гарантирует выживание от смертельного удара каждому без постоянных травм",
                        "Сокращает время лечения каждой раны на один день"
                ];

                this.addSkillRequirement("Иметь кого-то с умением 'Полевое сортирование'. Гарантировано у Монахов и Монахинь", [
			::Legends.Perks.getID(::Legends.Perk.LegendFieldTriage),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function ()
	{
		if ("IsSurvivalGuaranteed" in this.World.Assets.m)
			this.World.Assets.m.IsSurvivalGuaranteed = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

