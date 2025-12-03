::mods_hookExactClass("items/weapons/goedendag", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setCategories("Spear/Mace, Two-Handed");
		this.m.Value = 750;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/goedendag_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/goedendag_01" + v + ".png";
		this.m.ArmamentIcon = "icon_goedendag_01" + v;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Thrust))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.Thrust, function (_skill)
			{
				_skill.m.IsGoedendagThrust = true;
			}.bindenv(this));
			return;
		}

		weapon.addSkill(_skill);
	}

});
