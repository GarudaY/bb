::mods_hookExactClass("retinue/followers/quartermaster_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.quartermaster";
                this.m.Name = "Упорядоченный инвентарь";
                this.m.Description = "Годы путешествий с караванами научили квартирмейстера втискивать и перекладывать любое снаряжение, поклажу или броню так, чтобы использовать место максимально эффективно.";
                this.m.Image = "ui/campfire/legend_quartermaster_01";
                this.m.Cost = 3500;
                this.m.Effects = [
                        "Увеличивает переносимый запас боеприпасов на 100, медикаментов и инструментов на 50",
                        "Увеличивает размер тайника на 27"
                ];

                this.addSkillRequirement("Иметь кого-то с умением 'Умелая укладка'. Гарантировано у Бродяг, Мельников, Ослов и многих других", [
			::Legends.Perks.getID(::Legends.Perk.LegendSkillfulStacking),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function ()
	{
		if ("AmmoMaxAdditional" in this.World.Assets.m)
			this.World.Assets.m.AmmoMaxAdditional = 100;
		if ("MedicineMaxAdditional" in this.World.Assets.m)
			this.World.Assets.m.MedicineMaxAdditional  = 50;
		if ("ArmorPartsMaxAdditional" in this.World.Assets.m)
			this.World.Assets.m.ArmorPartsMaxAdditional = 50;

		::Legends.Stash.resize();
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

