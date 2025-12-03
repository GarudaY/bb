::mods_hookExactClass("items/weapons/oriental/handgonne", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/handgonne_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/handgonne_01" + v + ".png";
		this.m.ArmamentIcon = "icon_handgonne_01" + v + "_loaded";
	}

	local setLoaded = o.setLoaded;
	o.setLoaded = function (_l) {
		setLoaded(_l);
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		if (_l) {
			this.m.ArmamentIcon = "icon_handgonne_01" + v + "_loaded";
		} else {
			this.m.ArmamentIcon = "icon_handgonne_01" + v + "_empty";
		}
		this.updateAppearance();
	}

	o.onCombatFinished = function ()
	{
		this.weapon.onCombatFinished();
		this.m.IsLoaded = true;
	}
});
