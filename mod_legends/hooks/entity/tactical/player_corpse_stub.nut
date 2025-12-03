::mods_hookExactClass("entity/tactical/player_corpse_stub", function(o)
{
	o.m.IsCommander <- false;
	o.m.Gender <- -1;

	o.setCommander <- function ( _f )
	{
		this.m.IsCommander = _f;
	}

	o.isCommander <- function ()
	{
		return this.m.IsCommander;
	}

	o.setGender <- function ( _gender )
	{
		this.m.Gender = _gender;
	}

	o.getGender <- function ()
	{
		return this.m.Gender;
	}

	o.getRosterTooltip = function ()
	{
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			}
		];
		local time = this.m.DaysWithCompany;
		local text;

                if (time == -1)
                {
                        text = "В отряде с самого начала.";
                }
                else if (time > 1)
                {
                        text = "В отряде уже " + time + " дн.";
                }
                else
                {
                        text = "Только что присоединился к отряду.";
                }

		if (this.m.LifetimeStats.Battles != 0)
		{
                        text = text + (" Принял участие в " + this.m.LifetimeStats.Battles + " битвах и имеет " + this.m.LifetimeStats.Kills + " убийств.");
		}

		if (this.m.LifetimeStats.MostPowerfulVanquished != "")
		{
                        local vanquishedText = "{" + (" Самый сильный противник, которого %they% одолел%g% — " + this.m.LifetimeStats.MostPowerfulVanquished + ".") + "}";
			local vars = [];
			::Const.LegendMod.extendVarsWithPronouns(vars, this);
			vanquishedText = this.buildTextFromTemplate(vanquishedText, vars);
			text = text + vanquishedText;
		}

		tooltip.push({
			id = 2,
			type = "description",
			text = text
		});
		tooltip.push({
			id = 5,
			type = "text",
			icon = "ui/icons/xp_received.png",
                        text = "Уровень " + this.m.Level
		});

		if (this.m.DailyCost != 0)
		{
			tooltip.push({
				id = 3,
				type = "text",
				icon = "ui/icons/asset_daily_money.png",
                                text = "Плата [img]gfx/ui/tooltips/money.png[/img]" + this.m.DailyCost + " в день"
			});
		}

		return tooltip;
	}
});
