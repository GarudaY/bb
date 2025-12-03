::mods_hookExactClass("items/weapons/three_headed_flail", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2200;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/flail_three_headed_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/flail_three_headed_01" + v + ".png";
		this.m.ArmamentIcon = "icon_flail_three_headed_01" + v;
	}

});
