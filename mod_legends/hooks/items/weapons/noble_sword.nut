::mods_hookExactClass("items/weapons/noble_sword", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/sword_03" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/sword_03" + v + ".png";
		this.m.ArmamentIcon = "icon_sword_03" + v;
	}

});
