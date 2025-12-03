::mods_hookExactClass("retinue/followers/recruiter_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.recruiter";
                this.m.Name = "Заполненные контракты";
                this.m.Description = "Хитрость заранее заполненных контрактов, требующих лишь подписи, избавляет от утомительных споров об оплате. Просто распишитесь на линии — и вперёд! Только не давайте им читать мелкий шрифт.";
                this.m.Image = "ui/campfire/legend_recruiter_01";
                this.m.Cost = 1500;
                this.m.Effects = [
                        "Уменьшает первоначальный платёж за наём новичков на 10% и стоимость пробы на 50%",
                        "Добавляет от 2 до 4 дополнительных кандидатов для найма в каждом поселении"
                ];

                this.addSkillRequirement("Иметь наёмника с умением 'Вдохновляющее присутствие'. Гарантировано у Культистов, Сводников, Отставных солдат и многих других", [
			::Legends.Perks.getID(::Legends.Perk.InspiringPresence),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onUpdate = function ()
	{
		// handled in settlement
		// if ("RosterSizeAdditionalMin" in this.World.Assets.m)
		// 	this.World.Assets.m.RosterSizeAdditionalMin += 2;
		// if ("RosterSizeAdditionalMax" in this.World.Assets.m)
		// 	this.World.Assets.m.RosterSizeAdditionalMax  += 4;
		
		// handled in town_hire_dialog_module
		// if ("HiringCostMult" in this.World.Assets.m)
		// 	this.World.Assets.m.HiringCostMult *= 0.9;
		
		// handled in player
		// if ("TryoutPriceMult" in this.World.Assets.m)
		// 	this.World.Assets.m.TryoutPriceMult *= 0.5;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

