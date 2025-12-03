::mods_hookExactClass("items/weapons/greenskins/orc_metal_club", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/orc_club_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/orc_club_02" + v + ".png";
		this.m.ArmamentIcon = "icon_orc_weapon_07" + v;
	}

});
