::mods_hookExactClass("items/weapons/oriental/heavy_southern_mace", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2100;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/heavy_southern_mace_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/heavy_southern_mace_01" + v + ".png";
		this.m.ArmamentIcon = "icon_heavy_southern_mace_01" + v;
	}

});
