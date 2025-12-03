::mods_hookExactClass("items/weapons/oriental/firelance", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/firelance_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/firelance_01" + v + ".png";
		this.m.ArmamentIcon = "icon_firelance_01" + v;
	}

	o.updateEmptyVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/firelance_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/firelance_01" + v + ".png";
		this.m.ArmamentIcon = "icon_firelance_01" + v + "_empty";
	}

	local setAmmo = o.setAmmo;
	o.setAmmo = function(_a) {
		setAmmo(_a);
		if (this.m.Ammo > 0) {
			this.updateVariant();
		} else {
			this.updateEmptyVariant();
		}
		this.updateAppearance();
	}

});
