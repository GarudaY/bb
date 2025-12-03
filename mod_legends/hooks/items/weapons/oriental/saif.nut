::mods_hookExactClass("items/weapons/oriental/saif", function(o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.Categories = "Sword/Cleaver, One-Handed";
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/southern_short_sword_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/southern_short_sword_01" + v + ".png";
		this.m.ArmamentIcon = "icon_southern_short_sword_01" + v;
	}

});
