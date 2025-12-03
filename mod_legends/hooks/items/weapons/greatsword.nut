::mods_hookExactClass("items/weapons/greatsword", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Name = "Zweihander";
		this.m.Description = "A massive two-handed blade as good for carving swathes through the enemy as for battering them into submission."; //Let's get this working
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/sword_two_hand_02" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/sword_two_hand_02" + v + ".png";
		this.m.ArmamentIcon = "icon_sword_two_handed_02" + v;
	}

});
