::mods_hookExactClass("items/weapons/barbarians/axehammer", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Categories = "Hammer/Axe, One-Handed";
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/wildmen_03" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/wildmen_03" + v + ".png";
		this.m.ArmamentIcon = "icon_wildmen_03" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestTree);
		//::Legends.Actives.grant(this, ::Legends.Active.LegendHarvestRock);
	}

});
