::mods_hookExactClass("items/weapons/barbarians/skull_hammer", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/wildmen_07" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/wildmen_07" + v + ".png";
		this.m.ArmamentIcon = "icon_wildmen_07" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestRock);
	}
});
