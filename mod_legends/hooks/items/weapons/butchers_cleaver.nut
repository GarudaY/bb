::mods_hookExactClass("items/weapons/butchers_cleaver", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/cleaver_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/cleaver_02" + v + ".png";
		this.m.ArmamentIcon = "icon_cleaver_02" + v;
	}

});
