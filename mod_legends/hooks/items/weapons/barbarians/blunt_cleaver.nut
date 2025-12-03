::mods_hookExactClass("items/weapons/barbarians/blunt_cleaver", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Description = "This cleaver is heavy and blunt, but can still cause terrible wounds.";
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/wildmen_04" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/wildmen_04" + v + ".png";
		this.m.ArmamentIcon = "icon_wildmen_04" + v;
	}

});
