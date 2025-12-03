::mods_hookExactClass("skills/actives/chop", function(o)
{
	o.m.IsOrcWeapon <- false;

	o.setApplyOrcWeapon <- function ( _f )
	{
		this.m.IsOrcWeapon = _f;
	}

	o.isHidden <- function() {
		local dg = this.getContainer().getActor().getSkills().getSkillByID("special.double_grip");
		local canDoubleGrip = dg != null && ("canDoubleGrip" in dg) && dg.canDoubleGrip();
		return this.m.IsOrcWeapon && canDoubleGrip;
	}
});
