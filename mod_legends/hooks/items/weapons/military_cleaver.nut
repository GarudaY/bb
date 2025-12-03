::mods_hookExactClass("items/weapons/military_cleaver", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2500;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/cleaver_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/cleaver_01" + v + ".png";
		this.m.ArmamentIcon = "icon_cleaver_01" + v;
	}

});
