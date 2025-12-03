::mods_hookExactClass("skills/actives/riposte", function(o)
{
	o.getDescription <- function ()
	{
		return this.m.Description + " Attacks from this ability are considered attacks of opportunity."
	}

	o.isUsable = function ()
	{
		return !this.m.IsSpent && this.skill.isUsable() && !this.getContainer().hasEffect(::Legends.Effect.Riposte);
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}
});
