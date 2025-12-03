::mods_hookExactClass("retinue/followers/minstrel_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.minstrel";
                this.m.Name = "Шатёр менестреля";
                this.m.Description = "Хорошая песня и история сильно влияют на репутацию отряда. Место для репетиций и раздумий над своим ремеслом поможет распространить вести о ваших подвигах до всех ушей — хотят они того или нет.";
                this.m.Image = "ui/campfire/legend_minstrel_01";
                this.m.Cost = 1000;
                this.m.Effects = [
                        "Увеличивает получаемую славу на 15% за каждое действие",
                        "Делает более вероятным появление полезных сведений среди слухов в тавернах"
                ];

                this.addSkillRequirement("Иметь кого-то с умением 'Обольстить'. Гарантировано у Менестрелей и Трубадуров", [
			::Legends.Perks.getID(::Legends.Perk.LegendEntice),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function ()
	{	
		// handled in asset_manager
		// if ("BusinessReputationRate" in this.World.Assets.m)
		// 	this.World.Assets.m.BusinessReputationRate *= 1.15;
		if ("IsNonFlavorRumorsOnly" in this.World.Assets.m)
			this.World.Assets.m.IsNonFlavorRumorsOnly = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

