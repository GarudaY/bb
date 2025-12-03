::mods_hookExactClass("retinue/followers/blacksmith_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.blacksmith";
                this.m.Name = "Инструменты кузнеца";
                this.m.Description = "Наёмники умеют ломать оружие и доспехи, но не чинить их. Назначив кого-то на роль кузнеца и снабдив его нужным инструментом, можно быстро и эффективно избавить отряд от этой скучной работы, чиня даже то, что, казалось бы, уже потеряно.";
		this.m.Image = "ui/campfire/legend_blacksmith_01";
		this.m.Cost = 1500;
		this.m.Effects = [
                        "Чинит всю броню, шлемы, оружие и щиты на ваших бойцах, даже если они сломаны или потеряны после гибели бойца",
                        "Увеличивает скорость починки на 33%"
		];

                this.addSkillRequirement("Иметь наёмника с умением 'Полевые ремонты'. Гарантировано у Кузнецов, Ковальщиков и Крестоносцев", [
			::Legends.Perks.getID(::Legends.Perk.LegendFieldRepairs),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function()
	{
		this.follower.onUpdate();
		// handled in asset_manager and repair_building
		// if ("RepairSpeedMult" in this.World.Assets.m)
		// 	this.World.Assets.m.RepairSpeedMult *= 1.33;
		if ("IsBlacksmithed" in this.World.Assets.m)
			this.World.Assets.m.IsBlacksmithed = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

