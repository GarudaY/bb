::mods_hookExactClass("items/weapons/named/named_greatsword", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Variants = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Description = "This zweihander is a true masterpiece, with a blade that is both flexible yet extremely durable.";
	}

	o.updateVariant = function() {
		local variant = (this.m.Variant < 10 ? "0" : "") + this.m.Variant;
		this.m.Icon = "weapons/melee/sword_two_hand_01_named_" + variant + "_70x70.png";
		this.m.IconLarge = "weapons/melee/sword_two_hand_01_named_" + variant + ".png";
		this.m.ArmamentIcon = "icon_named_greatsword_" + variant;
	}
});
