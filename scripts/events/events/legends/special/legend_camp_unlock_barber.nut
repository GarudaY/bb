// Deprecated, removed in 19.3
this.legend_camp_unlock_barber <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_camp_unlock_barber";
		this.m.Title = "At %townname%";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
	}

	function onUpdateScore()
	{
		return;
	}
});

