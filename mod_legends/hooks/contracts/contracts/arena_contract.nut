::mods_hookExactClass("contracts/contracts/arena_contract", function(o)
{
	o.m.WasInReserves <- [];

	local create = o.create;
	o.create = function()
	{
		create();
                this.m.DescriptionTemplates = [
                        "Гул толпы манит многих в Арену. Золото, слава и смерть ждут внутри.",
                        "Посреди выкриков и свиста Арена стоит как доказательство мощи Южных земель.",
                        "Имперская Арена, где золото и слава добываются кровью и потом.",
                        "Легенды рождаются и мечты рушатся внутри стен Имперской Арены.",
                        "Знать и простолюдины собираются, чтобы наблюдать за зрелищем Имперской Арены.",
                        "Сверкая под солнцем, пески Имперской Арены видели бесчисленные поединки."
                ];
	}

	o.newTwist <- function (_chance, _flag, _payment) {
		return {
			R = _chance,
			F = _flag,
			P = _payment
		}
	}

	o.onTwistsSetup <- function (_twists) {}

	o.setup = function()
	{
		this.m.Flags.set("Number", 0);
		local pay = 550;
		local twists = [
			this.newTwist(10, "IsGhouls", 0),
			this.newTwist(15, "IsDesertRaiders", 0),
			this.newTwist(10, "IsSerpents", 0)
		];

		if(this.m.Home.hasSituation("situation.bread_and_games"))
			pay = pay + 100;

		local arenaFights = this.World.Statistics.getFlags().getAsInt("ArenaFightsWon");

		if (arenaFights <= 3) {
			twists.push(this.newTwist(10, "IsHyenas", 0));
		}

		if (arenaFights <= 5) {
			twists.push(this.newTwist(10, "IsSpiders", -75));
		}

		if (arenaFights >= 3) {
			twists.push(this.newTwist(5, "IsSandGolems", 50));
			twists.push(this.newTwist(15, "IsGladiators", 0));
		}

		if (arenaFights >= 4) {
			twists.push(this.newTwist(10, "IsFrenziedHyenas", 0));
		}

		if (arenaFights >= 5) {
			twists.push(this.newTwist(5, "IsSwordmaster", 50));
			twists.push(this.newTwist(5, "IsHedgeKnight", 50));
			twists.push(this.newTwist(5, "IsDesertDevil", 50));
			twists.push(this.newTwist(5, "IsMercenaries", 0));
		}

		if (arenaFights >= 6) {
			twists.push(this.newTwist(5, "IsUnholds", 100));
		}

		if (arenaFights >= 10) {
			twists.push(this.newTwist(5, "IsLindwurm", 200));
		}

		if (arenaFights >= 15) {
			twists.push(this.newTwist(2, "IsSwordmasterChampion", 150));
			twists.push(this.newTwist(2, "IsDesertDevilChampion", 150));
			twists.push(this.newTwist(5, "IsGladiatorChampion", 150));
		}

		this.onTwistsSetup(twists);

		local maxR = 0;

		foreach( t in twists )
		{
			maxR = maxR + t.R;
		}

		local r = this.Math.rand(1, maxR);

		foreach( t in twists )
		{
			if (r <= t.R)
			{
				this.m.Flags.set(t.F, true);
				pay = pay + t.P;
				break;
			}
			else
			{
				r = r - t.R;
			}
		}

		local paymentMult = ::World.Assets.m.IsArenaTooled ? 1.25 : 1.0;
		this.m.Payment.Pool = pay * this.getPaymentMult() * this.getReputationToPaymentMult() * paymentMult;
		this.m.Payment.Completion = 1.0;
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Overview")
			{
				s.Options.push(
				{
                                        Text = "{Это не то, что я ожидал. | Я пропущу этот бой. | Подожду следующего поединка.}",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.arena").registerAttempt();
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.State.getTownScreen().getMainDialogModule().reload();
						return 0;
					}
				});
			}

			if (s.ID == "Start")
			{
				s.Options.push({
                                        Text = "Мне нужно обдумать это.",
					getResult = @() 0
				});

				s.start <- function ()
				{
                                        this.Text += "\n\n\n\n\n\n\n\nВ Арену выйдут следующие бойцы:\n\n%bro1name%\n%bro2name%\n%bro3name%";
				}
			}

			if (s.ID == "Success")
			{
				s.start <- function ()
				{
                                        this.Text = "[img]gfx/ui/events/event_147.png[/img]{Управляющий ареной говорит так, будто даже не помнит вашего лица, да он, вероятно, и не помнит.%SPEECH_ON%Вот ваша плата, приходите ещё.%SPEECH_OFF% | Не отрывая головы от куска папируса, хозяин арены кидает вам кошель с монетами.%SPEECH_ON%Слышал рев толпы, так что держи свои кроны. Заходи в ямы ещё.%SPEECH_OFF% | Управляющий ареной уже ждёт вас.%SPEECH_ON%Вы устроили славное представление, коронник. Буду только рад видеть вас снова.%SPEECH_OFF%}";

					local arena = this.Contract.getHome().getBuilding("building.arena");
					if (arena.getCurrentAttempts() == arena.getMaxAttempts() - 1) {
                                                this.Text += "Арена сегодня закроется, но вы сможете вернуться уже завтра.";
                                        } else {
                                                this.Text += "Можете продолжить сражаться сегодня, если хотите.";
					}

					foreach( bro in ::Legends.Arena.getCollaredBros()) {
						bro.getFlags().increment("ArenaFightsWon", 1);
						bro.getFlags().increment("ArenaFights", 1);
						::Legends.Arena.updateTraits(this.List, bro);
					}

					if (this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") > 0 && this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") % 5 == 0)
					{
						local r;
						local a;
						local u;

						if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") == 5)
							r = 1;
						else if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") == 10)
							r = 3;
						else if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") == 15)
							r = 2;
						else
							r = this.Math.rand(1, 3);

						switch(r)
						{
						case 1:
							a = this.Const.World.Common.pickArmor([
									[1, ::Legends.Armor.Southern.gladiator_harness],
							]);
							a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));

							this.List.push({
								id = 12,
								icon = "ui/items/" + a.getUpgrade().getIcon(),
                                                                text = "Вы получаете " + a.getName()
							});
							break;

						case 2:
							a = this.Const.World.Common.pickArmor([
									[1, ::Legends.Armor.Southern.gladiator_harness],
							]);
							a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));
							this.List.push({
								id = 12,
								icon = "ui/items/" + a.getUpgrade().getIcon(),
                                                                text = "Вы получаете " + a.getName()
							});
							break;

						case 3:
							a = ::new(::MSU.Array.rand([
								"scripts/items/legend_helmets/helm/legend_helmet_southern_gladiator_helm_crested",
								"scripts/items/legend_helmets/helm/legend_helmet_southern_gladiator_helm_split",
								"scripts/items/legend_helmets/helm/legend_helmet_southern_gladiator_helm_masked"
							]));
							this.List.push({
								id = 12,
								icon = "ui/items/" + a.getIcon(),
                                                                text = "Вы получаете " + a.getName()
							});
							break;
						}

						this.World.Assets.getStash().makeEmptySlots(1);
						this.World.Assets.getStash().add(a);
					}
				}
			}
			if (s.ID == "Failure1")
			{
				s.Options[0].getResult <- function ()
				{
					foreach (bro in ::Legends.Arena.getCollaredBros()) {
						bro.getFlags().increment("ArenaFights", 1);
					}

					this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
					this.World.Contracts.finishActiveContract(true);
				}
			}
		}
	}


	o.getBros = function ()
	{
		local ret = ::Legends.Arena.getCollaredBros();
		foreach (bro in ret) {
			if (bro.isInReserves()) {
				this.m.WasInReserves.push(bro);
				bro.setInReserves(false);
			}
		}
		return ret;
	}

	/*Adds the following vars:
		bro1name = "Bro Name"
		bro2name = "2nd Bro Name" (if bro exists)
		bro3name = "" (if bro doesn't exist)
	*/
	o.prepareBroVariables <- function ( _maxNumBros, _vars)
	{
		local currentBro = 1;

		foreach (bro in ::Legends.Arena.getCollaredBros()) {
			_vars.push([
				"bro" + currentBro++ + "name",
				" - " + bro.getName()
			]);
		}
		for (local i = currentBro; i <= _maxNumBros; ++i) {
			_vars.push([
				"bro" + i + "name",
				""
			])
		}
	}

	local onClear = o.onClear;
	o.onClear = function ()
	{
		if(this.m.Home != null && this.m.IsActive) {
			this.m.Home.getBuilding("building.arena").registerAttempt();
			foreach (bro in this.m.WasInReserves) {
				bro.setInReserves(true);
			}
		}
		this.m.WasInReserves.clear();
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			::Legends.Arena.removeCollar(bro);
		}
		onClear();
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		this.prepareBroVariables(3, _vars)
	}
});
