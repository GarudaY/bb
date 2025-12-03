::mods_hookExactClass("retinue/followers/drill_sergeant_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.drill_sergeant";
                this.m.Name = "Тренировочные манекены";
                this.m.Description = "Кто-то рождается убийцей, но другим нужно больше подбадривания и меньше риска, чтобы раскрыть свой потенциал — под присмотром, разумеется.";
                this.m.Image = "ui/campfire/legend_drill_01";
                this.m.Cost = 1750;
                this.m.Effects = [
                        "Даёт вашим наёмникам на 20% больше опыта на 1 уровне, на каждом следующем уровне бонус снижается на 2%",
                        "Наёмники в резерве не теряют настроение из-за отсутствия в боях"
                ];

		this.addRequirement("Won 50 battles", function() {
			return ::World.Statistics.getFlags().getAsInt("BattlesWon") >= 50;
		}, true, function( _r ) {
                        _r.Count <- 50;
                        _r.UpdateText <- function() {
                                this.Text = "Побед как минимум: " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("BattlesWon")) + "/" + this.Count
                        };
                });

                this.addSkillRequirement("Иметь хотя бы одну из следующих предысторий: Отставной солдат, Мастер меча, Наёмник или Гладиатор", [
			"background.retired_soldier",
			"background.swordmaster",
			"background.sellsword",
			"background.gladiator",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		], true);
	}

	o.onUpdate = function ()
	{
		if ("IsDisciplined" in this.World.Assets.m)
			this.World.Assets.m.IsDisciplined = true;
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

