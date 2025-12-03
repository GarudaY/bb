::mods_hookExactClass("items/weapons/short_bow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Shortbow;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/bow_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/bow_02" + v + ".png";
		this.m.ArmamentIcon = "icon_short_bow" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingShot);
		::Legends.Actives.grant(this, ::Legends.Active.LegendCascade);
	}

});
