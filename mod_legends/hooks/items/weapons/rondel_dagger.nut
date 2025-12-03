::mods_hookExactClass("items/weapons/rondel_dagger", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/dagger_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/dagger_02" + v + ".png";
		this.m.ArmamentIcon = "icon_dagger_02" + v;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Deathblow);
	}
});
