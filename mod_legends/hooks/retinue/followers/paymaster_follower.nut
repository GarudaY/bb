::mods_hookExactClass("retinue/followers/paymaster_follower", function(o) {
	o.m.Multiplier <- 0.85;

	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.paymaster";
                this.m.Name = "Инструменты скнаря";
                this.m.Description = "Мало кто терпеливо пересчитывает монеты, и ещё меньше тех, у кого хватает сил взвешивать и считать их по контракту. Но интендант вызывает уважение у всех вокруг.";
                this.m.Image = "ui/campfire/legend_paymaster_01";
                this.m.Cost = 3500;
                this.m.Effects = [
                        format("Снижает ежедневную плату каждому бойцу на %s%%", ((1.0 - this.m.Multiplier) * 100).tostring()),
                        "Уменьшает шанс дезертирства на 50%",
                        "Не допускает требований повысить жалованье в событиях"
                ];

                this.addSkillRequirement("Иметь наёмника с умением 'Интендант'. Гарантировано у Разносчиков, Евнухов и Слуг", [
			::Legends.Perks.getID(::Legends.Perk.LegendPaymaster),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.isVisible = function () { return true; }
	o.onUpdate = function () {}

	o.getMultiplier <- function () {
		return this.m.Multiplier;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

