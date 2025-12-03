::mods_hookExactClass("items/weapons/greenskins/goblin_falchion", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 1));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/goblin_weapon_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/goblin_weapon_02" + v + ".png";
		this.m.ArmamentIcon = "icon_goblin_weapon_02" + v;
	}

});
