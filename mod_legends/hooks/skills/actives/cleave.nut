::mods_hookExactClass("skills/actives/cleave", function(o)
{
	o.m.IsHew <- false;
	o.m.IsScytheCleave <- false;

	o.setItem <- function (_item) {
		if (this.m.IsHew)
		{
			this.m.Name = "Hew";
			this.m.Icon = "skills/active_210.png";
			this.m.IconDisabled = "skills/active_210_sw.png";
			this.m.Overlay = "active_210";
			this.m.FatigueCost = 15;
		}
		else if (this.m.IsScytheCleave)
		{
			this.m.Description = "A sweeping cleave that can be used from behind the frontline and can inflict bleeding wounds if there is no armor absorbing the blow and if the target is able to bleed at all.";
			this.m.KilledString = "Cleaved";
			this.m.Icon = "skills/active_61.png";
			this.m.IconDisabled = "skills/active_61_sw.png";
			this.m.Overlay = "active_61";
			this.m.FatigueCost = 15;
			this.m.MinRange = 1;
			this.m.MaxRange = 2;
		}
		this.skill.setItem(_item);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		if (!this.m.IsScytheCleave)
			return getTooltip();

		local ret = this.getDefaultTooltip();
		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5;
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=%positive%]2" + "[/color] tiles"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=%damage%]" + dmg + "[/color] bleeding damage per turn, for 2 turns"
		});
		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=%negative%]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		if (this.m.IsScytheCleave)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
			this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;
		}
		else
		{
			onAfterUpdate(_properties);
		}
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this && this.m.IsScytheCleave)
		{
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				this.m.HitChanceBonus += -15;
				_properties.MeleeSkill += -15;
			}
		}
	}

	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (success)
		{
			if (!target.isAlive() || target.isDying())
			{
				if (target.getFlags().has("tail") || !target.getCurrentProperties().IsImmuneToBleeding)
				{
					this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
				else
				{
					this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
			}
			else if (!target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding )
			{
				::Legends.Effects.grant(target, ::Legends.Effect.Bleeding, function(_effect) {
					if (_user.getFaction() == this.Const.Faction.Player )
						_effect.setActor(this.getContainer().getActor());
					_effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
				}.bindenv(this));
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
			else
			{
				this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
		}

		return success;
	}
});
