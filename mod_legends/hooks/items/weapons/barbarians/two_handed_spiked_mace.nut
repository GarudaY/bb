::mods_hookExactClass("items/weapons/barbarians/two_handed_spiked_mace", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/wildmen_06" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/wildmen_06" + v + ".png";
		this.m.ArmamentIcon = "icon_wildmen_06" + v;
	}

});
