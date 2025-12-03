::mods_hookExactClass("retinue/followers/alchemist_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.alchemist";
                this.m.Name = "Алхимические инструменты";
                this.m.Description = "Алхимик умеет создавать всевозможные загадочные устройства и настойки из редких ингредиентов, получив доступ к оснащению таксидермиста, и тратит при этом меньше материалов.";
                this.m.Image = "ui/campfire/legend_alchemist_01";
                this.m.Cost = 1250;
                this.m.Effects = [
                        "25% шанс не расходовать компонент ремесла, используемый вами",
                        "Открывает рецепт 'Змеиное масло' для заработка на создании из разных базовых компонентов",
                        "Позволяет пополнять бомбы и колбы боеприпасами"
                ];

                this.addRequirement("Создать 10 предметов", function() {
                        return ::World.Statistics.getFlags().getAsInt("ItemsCrafted") >= 10;
                }, false, function( _r ) {
                        _r.Count <- 10;
                        _r.UpdateText <- function() {
                                this.Text = "Создано предметов: " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("ItemsCrafted")) + "/" + this.Count
                        };
                });

                this.addSkillRequirement("Иметь хотя бы одну из следующих предысторий: Травник, Таксидермист, Друид, Алхимик", [
			"background.legend_herbalist",
			"background.legend_taxidermist",
			"background.legend_druid",
			"background.legend_commander_druid",
			"background.legend_alchemist",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

