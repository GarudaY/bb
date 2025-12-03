this.legend_scroll_item <- ::inherit("scripts/items/item", {
	m = {
		Selection = null
	},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.legend_scroll";
		this.m.Name = "Ancient Scroll";
		this.m.Description = "A torn-up scroll with knowledge unseen for centuries. It can be translated by a character with the interpretation perk in the crafting tent. Highly valuable to some historians, although it is useless to many. They can, however, be studied with effort and a high chance of headache. Every brother may use up to 1 scroll. Being bright increases this to 2 scrolls, and being dumb decreases this to 0 scrolls.";
		this.m.Icon = "trade/scroll.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsUsable = true;
		this.m.Value = 2000;
		this.m.Selection = ::Math.rand(0, 2);
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = getName()
			},
			{
				id = 2,
				type = "description",
				text = getDescription()
			},
			{
				id = 66,
				type = "text",
				text = getValueString()
			},
			{
				id = 3,
				type = "image",
				image = getIcon()
			},
			{
				id = 65,
				type = "text",
				text = "Right-click to use on a character. Studying will lead to irritability. What mercenary wants to study?"
			},
			{
				id = 67,
				type = "text",
				text = "Will apply a 30 day cooldown until you can read again."
			}
		];

		local actor = ::World.State.m.CharacterScreen.getSelectedActor();
		if (::World.State.isInCharacterScreen() && actor != null) {
			local injury = ::Legends.Effects.get(actor, ::Legends.Effect.LegendHeadache);
			if (injury != null) {
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/cancel.png",
					text = "Cannot be used for next [color=%negative%]" + injury.m.HealingTimeMin + "-" + injury.m.HealingTimeMax + "[/color] days because of [color=%status%]" + injury.getName() + "[/color] status"
				});
				return result;
			}
			local effect = ::Legends.Effects.get(actor, ::Legends.Effect.LegendIrritable);
			if (effect != null) {
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/cancel.png",
					text = "Cannot be used for next [color=%negative%]" + effect.m.HealingTime + "[/color] days because of [color=%status%]" + effect.getName() + "[/color] status"
				});
				return result;
			}
		}
		return result;
	}

	function isAbleToUseScroll( _actor )
	{
		local effect = ::Legends.Effects.get(_actor, ::Legends.Effect.LegendIrritable);
		local injury = ::Legends.Effects.get(_actor, ::Legends.Effect.LegendHeadache);
		if (injury != null)
			return "Failed to use this item as the user will be recovering from the last reading for another [color=%negative%]" + injury.m.HealingTimeMin + "-" + injury.m.HealingTimeMax +"[/color] days.";
		if (effect != null)
			return "Failed to use this item as the user will be recovering from the last reading for another [color=%negative%]" + effect.m.HealingTime + "[/color] days.";

		return true;
	}

	function applySideEffect( _actor )
	{
		::Legends.Effects.grant(_actor, ::Legends.Effect.LegendHeadache, function (_effect) {
			_effect.m.IrritableHealingTime = 30;
		}.bindenv(this));
	}

	function applyScrollEffect( _result = null, _actor = null )
	{
		if (_result == null)
			_result = ::Math.rand(1, 2);

		switch (_result)
		{
		case 1:
			return gainGiftedEffect(_actor);
		case 2:
			return gainTrainingEffect(_actor);
		case 3:
			return gainExperience(_actor);
		default:
			return "Nothing happens.";
		}
	}

	function gainGiftedEffect( _actor )
	{
		_actor.m.LevelUps += 1;
		_actor.fillAttributeLevelUpValues(1, true);
		return format("You gain free [color=%s]Gifted[/color] perk worth amount of level-up stats.", ::Const.UI.Color.NegativeValue);
	}

	function gainExperience( _actor )
	{
		_actor.addXP( this.Math.rand(100, 150));
	}

	function gainTrainingEffect( _actor )
	{
		local trained = ::Legends.Effects.get(_actor, ::Legends.Effect.Trained);

		if (trained != null)
		{
			if (!::MSU.isKindOf(trained, "injury"))
			{
				trained.m.Duration += 3;
				trained.m.XPGainMult = 1.5;
				trained.m.Description = format("Trained effect (: +50% XP for %i battles", effect.m.Duration);
			}
			else
			{
				trained.addHealingTime(3);
			}
		}
		else
		{
			trained = ::Legends.Effects.new(::Legends.Effect.Trained);
			trained.m.Description = "Trained effect (: +50% exp for 3 battles"; //todo flavor text
			trained.m.Duration = 3;
			trained.m.XPGainMult = 1.5;
		}

		_actor.getSkills().add(trained);
		return format("You gain [color=%s]%s[/color] effect that lasts for at least 3 battles.", ::Const.UI.Color.NegativeValue, trained.getName());
	}

	function onUse( _actor, _item = null )
	{
		local result = this.isAbleToUseScroll(_actor);

		if (typeof result == "string") {
			::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", ::Legends.tooltip(result));
			return false;
		}

		::World.State.m.CharacterScreen.m.JSHandle.asyncCall("openPopupDialog", this.applyScrollEffect(m.Selection, _actor));
		::Sound.play("sounds/scribble.wav", ::Const.Sound.Volume.Inventory);
		this.applySideEffect(_actor);
		return true;
	}

	function getValue()
	{
		if (m.Selection == null || m.Selection == 0)
			return 100;

		return this.item.getValue();
	}

	function getName()
	{
		switch(this.m.Selection)
		{
			case 0:
				return "Scroll of .Nut\'in";
			case 1:
				return "Scroll of Natural Talent";
			case 2:
				return "Battle Scroll";
			case 3:
				return "Scroll of Experience";
		}
	}

	function getDescription()
	{
		switch(this.m.Selection)
		{
			case 0:
				return "After a bit of labor the scroll seems to just be gibberish, nothing meaningful could be translated. Can be sold to gullible scholars.";
			case 1:
				return "Use the scroll to grant a character a max-stat roll similar to gifted.";
			case 2:
				return "Use the scroll on a character to increase experience gains by +50% for at least the next 3 battles. This will override any other current trained effects.";
			case 3:
				return "Use the scroll on a character to gain 100-150 XP.";
		}
	}

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
		_out.writeU8(this.m.Selection);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
		this.m.Selection = _in.readU8();
	}

});

