::mods_hookExactClass("retinue/followers/agent_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.agent";
                this.m.Name = "Привал гонцов";
                this.m.Description = "Организовав сеть гонцов, можно нанять умелых агентов для доставки полезной информации... но сперва им нужно немного отдохнуть.";
                this.m.Image = "ui/campfire/legend_agent_01";
                this.m.Cost = 2000;
                this.m.Effects = [
                        "Показывает доступные контракты и активные события в подсказке поселений, где бы вы ни находились"
                ];

                this.addRequirement("Иметь союзные отношения с домом знати или городом-государством", function() {

			if (::World.Retinue.m.Slots.filter(function(i,v){if (v == null){return false} else {return v.getID() == "follower.agent"}}).len() > 0)
			{
				return true; // This requirement only needs to be met at the time of purchase; While the follower is in your retinue, this check is not needed
			}

			local factions = ::World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse);
			factions.extend(::World.FactionManager.getFactionsOfType(::Const.FactionType.OrientalCityState));

			foreach (f in factions) {
				if (f.getPlayerRelation() >= 90.0 ) {
					return true;
				}
			}

			return false;
		});

                this.addSkillRequirement("Иметь хотя бы одну из следующих предысторий: Евнух, Гонец, Убийца (южный или северный)", [
			"background.eunuch",
			"background.messenger",
			"background.assassin",
			"background.assassin_southern",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

