::mods_hookExactClass("items/weapons/battle_whip", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Cleaver/Whip, One-Handed";
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Cultist;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/whip_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/whip_01" + v + ".png";
		this.m.ArmamentIcon = "icon_whip_01" + v;
	}

});
