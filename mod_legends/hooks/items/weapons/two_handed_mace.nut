::mods_hookExactClass("items/weapons/two_handed_mace", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 1000;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/mace_two_handed_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/mace_two_handed_01" + v + ".png";
		this.m.ArmamentIcon = "icon_mace_two_handed_01" + v;
	}

});
