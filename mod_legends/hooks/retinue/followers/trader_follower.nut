::mods_hookExactClass("retinue/followers/trader_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.trader";
                this.m.Name = "Запертые сундуки";
                this.m.Description = "Хотя это и редкость, у некоторых отрядов есть особые товары, которые можно показать путникам в дороге. Эти товары всегда хранятся в самых укреплённых сундуках, чтобы защитить их от чужих рук снаружи и внутри лагеря.";
                this.m.Image = "ui/campfire/legend_trader_01";
                this.m.Cost = 3500;
                this.m.Effects = [
                        "Увеличивает количество торговых товаров на продажу на 1 за каждую локацию, где они производятся (например, соль возле соляных шахт), что позволяет торговать большими объёмами"
                ];

                this.addRequirement("Продать 25 торговых товаров", function() {
                        return ::World.Statistics.getFlags().getAsInt("TradeGoodsSold") >= 25;
                }, false, function( _r ) {
                        _r.Count <- 25;
                        _r.UpdateText <- function() {
                                this.Text = "Продано торговых товаров: " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("TradeGoodsSold")) + "/" + this.Count
                        };
                });

                this.addSkillRequirement("Иметь хотя бы одну из следующих предысторий: Караванщик, Бродячий торговец, Торговец, Осёл", [
			"background.caravan_hand",
			"background.legend_trader",
			"background.legend_commander_trader",
			"background.legend_donkey",
			"background.peddler",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

