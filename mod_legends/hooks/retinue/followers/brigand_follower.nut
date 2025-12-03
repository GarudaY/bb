::mods_hookExactClass("retinue/followers/brigand_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.brigand";
                this.m.Name = "Похищенные документы";
                this.m.Description = "Знать и торговцы беспечны в вопросах охраны, а их слуг легко запугать. Ловко вложенная взятка, заварушка или шустрые пальцы помогут узнать, кто и что куда везёт.";
                this.m.Image = "ui/campfire/legend_brigand_01";
                this.m.Cost = 2500;
                this.m.Effects = [
                        "Позволяет всегда видеть расположение некоторых караванов, даже вне радиуса обзора",
                        "Позволяет увидеть до 3 самых ценных предметов, перевозимых караванами"
                ];

		this.addRequirement("Raided at least 3 caravans", function() {
			return ::World.Statistics.getFlags().getAsInt("CaravansRaided") >= 3;
		}, true, function( _r ) {
                        _r.Count <- 3;
                        _r.UpdateText <- function() {
                                this.Text = "Разграблено караванов: " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("CaravansRaided")) + "/" + this.Count
                        };
                });

                this.addSkillRequirement("Иметь хотя бы одну из следующих предысторий: Налётчик, Варвар, Дезертир", [
			"background.raider",
			"background.barbarian",
			"background.deserter",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		], true);
	}

	o.onUpdate = function ()
	{
		if ("IsBrigand" in this.World.Assets.m)
			this.World.Assets.m.IsBrigand = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

