::mods_hookExactClass("items/weapons/oriental/two_handed_saif", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2400;
		this.m.Categories = "Sword/Cleaver, Two-Handed";
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		if (this.getVariant() == 0) {
			this.m.Icon = "weapons/melee/two_handed_saif_70x70.png";
			this.m.IconLarge = "weapons/melee/two_handed_saif.png";
			this.m.ArmamentIcon = "icon_two_handed_saif_01";
		} else {
			this.m.Icon = "weapons/melee/two_handed_saif_01_" + this.getVariant() + "_70x70.png";
			this.m.IconLarge = "weapons/melee/two_handed_saif_01_" + this.getVariant() + ".png";
			this.m.ArmamentIcon = "icon_two_handed_saif_01_" + this.getVariant();
		}
	}
});
