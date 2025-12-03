::mods_hookExactClass("items/weapons/warhammer", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 2500;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/warhammer_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/warhammer_01" + v + ".png";
		this.m.ArmamentIcon = "icon_warhammer_01" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPryArmor);
	}

});
