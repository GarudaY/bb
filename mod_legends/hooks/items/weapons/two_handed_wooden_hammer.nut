::mods_hookExactClass("items/weapons/two_handed_wooden_hammer", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/hammer_two_handed_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/hammer_two_handed_02" + v + ".png";
		this.m.ArmamentIcon = "icon_hammer_02" + v;
	}

});
