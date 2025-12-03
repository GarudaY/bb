::mods_hookExactClass("entity/tactical/enemies/zombie_betrayer", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.SurroundedBonus = 5; // resetting from vanilla
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
		if(::Legends.isLegendaryDifficulty())
		{
			b.MeleeSkill += 10;
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 50;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 50;		
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 100;
			this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 100;
		}
	}

	o.makeMiniboss <- function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 50;
		this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 50;		
		this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 100;
		this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 100;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"named_axe",
			"named_cleaver",
			"named_flail",
			"named_greataxe",
			"named_greatsword",
			"named_mace",
			"named_two_handed_hammer",
			"legend_named_flamberge",
			"legend_named_longsword",
			"legend_named_glaive",
			"legend_named_swordstaff",
			"legend_named_halberd",
			"legend_named_ranged_flail",
			"legend_named_infantry_axe",
			"legend_named_warhammer",
			"legend_named_military_goedendag",
			"legend_named_military_warscythe",
			"named_two_handed_mace",
			"named_two_handed_flail"
		];

		local shields = clone this.Const.Items.NamedUndeadShields;

		this.m.Items.equip(this.new("scripts/items/weapons/named/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));

		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBoneBreaker);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTerrifyingVisage);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBackswing);
		return true;
	}
});
