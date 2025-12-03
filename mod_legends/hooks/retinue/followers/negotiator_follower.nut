::mods_hookExactClass("retinue/followers/negotiator_follower", function(o)  {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.negotiator";
                this.m.Name = "Место переговоров";
                this.m.Description = "Выделенное место встречи, где переговорщики могут говорить, торговаться и обмениваться колкостями с важными особами или их приспешниками, помогает находить работу.";
                this.m.Image = "ui/campfire/legend_negotiator_01";
                this.m.Cost = 3500;
                this.m.Effects = [
                        "Позволяет больше раундов переговоров о контракте и повышенную оплату, прежде чем наниматели прервут разговор, с лишь 10% шансом ухудшить отношения. Плохие отношения восстанавливаются быстрее"
                        //"Greater contract payment if negotiations are successful and makes good relations with any faction decay slower and bad relations recover faster"
                ];

                this.addRequirement("Вести переговоры об оплате контрактов заданное число раз", function() {
                        return ::World.Statistics.getFlags().getAsInt("NegotiatingTries") >= 10;
                }, true, function( _r ) {
                        _r.Count <- 10;
                        _r.UpdateText <- function() {
                                this.Text = "Переговоры об оплате контрактов: " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("NegotiatingTries")) + "/" + this.Count + " (попытки считаются только после принятия контракта)"
                        };
                });

                this.addSkillRequirement("Иметь кого-то с умением 'Пацифист'. Гарантировано у Вдовы, Изобретателя, Портного и многих других", [
			::Legends.Perks.getID(::Legends.Perk.LegendPacifist),
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		], true);
	}

	o.onUpdate = function ()
	{
		if ("NegotiationAnnoyanceMult" in this.World.Assets.m)
			this.World.Assets.m.NegotiationAnnoyanceMult = 0.5;
		if ("AdvancePaymentCap" in this.World.Assets.m)
			this.World.Assets.m.AdvancePaymentCap = 0.75;

		if ("RelationDecayGoodMult" in this.World.Assets.m) {
			if (this.World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves") {
				this.World.Assets.m.RelationDecayGoodMult = 1.075;
			} else {
				this.World.Assets.m.RelationDecayGoodMult = 0.85;
			}
		}
		if ("RelationDecayBadMult" in this.World.Assets.m) {
			if (this.World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves") {
				this.World.Assets.m.RelationDecayBadMult = 0.925;
			} else {
				this.World.Assets.m.RelationDecayBadMult = 1.15;
			}
		}
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

