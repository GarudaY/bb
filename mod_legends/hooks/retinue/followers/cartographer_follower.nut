::mods_hookExactClass("retinue/followers/cartographer_follower", function(o) {
	o.create = function ()
	{
		this.follower.create();
		this.m.ID = "follower.cartographer";
		this.m.Name = "Принадлежности картографа";
		this.m.Description = "Умение читать — редкий навык, на освоение которого порой уходит вся жизнь. Разбираться в картах для обычного наёмника чуть проще. Если дать лучшим и смышлёным в отряде всё необходимое для рисования, это может пригодиться.";
		this.m.Image = "ui/campfire/legend_cartographer_01";
		this.m.Cost = 1250;
		this.m.Effects = [
			"Платит от 100 до 400 крон за каждую найденную лично локацию. Чем дальше от цивилизации, тем выше плата. Легендарные места оплачиваются вдвое дороже."
		];

		this.addRequirement("Обнаружить легендарную локацию", function() {
			return ::World.Flags.getAsInt("LegendaryLocationsDiscovered") >= 1;
		});

		this.addSkillRequirement("Иметь хотя бы одну из следующих предысторий: Отважный дворянин/Дама, Дворянский командир, Философ, Историк", [
			"background.adventurous_noble",
			"background.historian",
			"background.legend_philosopher",
			"background.legend_commander_noble",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	o.onLocationDiscovered = function ( _location )
	{
		local settlements = this.World.EntityManager.getSettlements();
		local dist = 9999;

		foreach( s in settlements )
		{
			local d = s.getTile().getDistanceTo(_location.getTile());

			if (d < dist)
			{
				dist = d;
			}
		}

		local reward = this.Math.min(400, this.Math.max(100, 10 * dist));

		if (_location.isLocationType(this.Const.World.LocationType.Unique))
		{
			reward = reward * 2;
		}

		this.World.Assets.addMoney(reward);
	}

	o.onEvaluate = function () {
		this.follower.onEvaluate();
	}
});

