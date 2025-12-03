::mods_hookExactClass("items/weapons/woodcutters_axe", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 450;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/axe_two_handed_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/axe_two_handed_02" + v + ".png";
		this.m.ArmamentIcon = "icon_axe_two_handed_02" + v;
	}

});
