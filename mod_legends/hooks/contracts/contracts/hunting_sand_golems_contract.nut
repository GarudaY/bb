::mods_hookExactClass("contracts/contracts/hunting_sand_golems_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
                        "В пустыне заметили мерцающих духов воздуха — дурное знамение для местных.",
                        "Остерегайтесь безмолвных стражей пустыни: песчаных големов, чьи массивные тела выходят из песков, преграждая путь любым путникам, рискнувшим войти на их территорию.",
                        "В пустыне есть не только жара и солнце — под дюнами прячутся песчаные големы, готовые своими тяжёлыми кулаками сокрушить каждого, кто подойдет слишком близко.",
                        "В песках пустыни таится не только зной и жажда — это владения духов воздуха, чьи капризные причуды способны превратить груду камней в исполинского песчаного голема.",
                        "Путникам в пустыне противостоит неумолимый враг: духи воздуха, чья бурная ярость обращает в пыль даже самые стойкие караваны.",
                        "Остерегайтесь проклятых пустошей: говорят, духи древних обитают там, веками искривлённые гневом и злобой.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Success")
			{
				s.Text = "[img]gfx/ui/events/event_162.png[/img]{You try and enter %employer%\'s room, but a guard stops you. With a bit of a brow raiser, you tell the man that the Vizier is expecting you. The guard stares down at you.%SPEECH_ON%He expects you, he does not wish to see you. Those are two different things, Crownling. The scouts have confirmed your doings in the deserts. Here is your pay, as agreed upon. Now depart. I said depart!%SPEECH_OFF%The guard stamps his foot and all the guards posted down the hall stamp their feet and face you. Now, you are no genius, but you get the feeling that it is probably time to go. | %employer% stares down at you from a throne of pillows and women. Slave women, judging by their chains, though perhaps that is just their thing. The sad faces say otherwise. The Vizier speaks, but it is almost as if it is a show for all those listening and you\'re just playing a part.%SPEECH_ON%Crownling, my little hawks have told me of your doings. The Ifrits have been put to rest and their sorcery shall be a threat no more! Such is the power of my gold. It is work which we have agreed to, and for that %reward% crowns is your reward.%SPEECH_OFF%As a servant hands you a purse of coins, the Vizier flitters his fingers dismissively toward you.%SPEECH_ON%Begone.%SPEECH_OFF% | You find %employer% turning an hourglass one way and back again. The sands are equally pitted to the halved bulbs. There are servants all along the wall with their heads bowed. At the adjacent wall are a line of cushions upon which sit gaudy women whose hair is tended to by women in chains. The Vizier slams the hourglass down. He crouches behind it, his eyes visile to either side of the glass, the pupils staring inward. You finally notice that the sands within are not shifting as they should, but instead twirling angrily.%SPEECH_ON%The Ifrits have been dealt with, this my hawks have told me so. Crownling, you have done your job as you were summoned to do, and for that you are to be given %reward% crowns. I hope your time in the deserts rewarded you not only with experience of combat and war, but also graced you with the notion of contemplation.%SPEECH_OFF%You\'re not sure what this man means. He yanks the hourglass up and starts to tilt it side to side again. The sands thrash as they bounce from side to side. A servant hands you a purse of coins and you could not depart the room faster. | You return to %employer% to find the Vizier facedown on a couch. A number of old men are knuckling his back or rubbing his feet. Across the room, a woman fans herself. She is entirely naked and her eyes never leave the Vizier\'s, nor his hers. The man talks almost as if you are not even in the room at all.%SPEECH_ON%Servants, hand this Crownling the purple purse with black thread. Crownling, you have done well in handling the spirits of the sands, these so-called Ifrits. It was my gold which ushered you into those deserts, and my gold which rewarded you, so let the scribes know that it is my gold which has settled this issue truly, and that the tool, this Crownling, was paid fairly.%SPEECH_OFF%A servant stabs a purple sack into your arms. The Vizier groans as an old man plants an elbow right into his ass crack.%SPEECH_ON%Need I tell you to depart, Crownling?%SPEECH_OFF% | An old man with no eyebrows greets you, stopping you just outside %employer%\'s door. He pushes a sack into your arms.%SPEECH_ON%There are %reward% crowns in there, as the Vizier agreed.%SPEECH_OFF%The man looks around for listeners and seems to nod when seeing you are the only one within earshot.%SPEECH_ON%The Ifrits are not just demons, they are wronged spirits, and you have set them free. But they will likely return, because men such as %employer% have nothing to offer this world but a waterfall of gold, and they forget that beneath that waterfall many are crushed or drowned.%SPEECH_OFF%You\'re not sure what he means, but an approaching guard ends the conversation and the old man slaps you across the face.%SPEECH_ON%Begone, Crownling! Take your pay and leave my sight!%SPEECH_OFF% | Of all things, a troop of cats welcome you enter %employer%\'s room. You can just barely see the Vizier on the other side of a mesh with a crowd of equally amused onlookers.\n\n You look down and see the cats are carting around a piece of wood with a purse atop it. You look back up. The silhouettes are holding their breath. Sighing, you bend down and pick up the purse. One voyeur erupts and claps but is met by stern hushing. Their task complete, the cats fall down and spread out on the tile, dozing or grooming themselves or pawing at the shadows which flitter in the sunbeams. You\'re pretty sure %reward% crowns are in the sack, but not wanting to spend another second in the room you step outside to count.}";
			}
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
		}
	}
});
