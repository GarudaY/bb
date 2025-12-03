::mods_hookExactClass("items/weapons/falchion", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/sword_04" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/sword_04" + v + ".png";
		this.m.ArmamentIcon = "icon_sword_04" + v;
	}

});
