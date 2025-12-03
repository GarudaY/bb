::mods_hookExactClass("contracts/contracts/patrol_contract", function(o)
{
	local create = o.create;
o.create = function()
{
create();
this.m.Name = "Патрульная служба";
this.m.DescriptionTemplates = [
"Нанять наёмников для защиты дорог дорого, но похоже, у %s не осталось выбора.",
"Само присутствие наёмников может отпугнуть разбойников и обеспечить безопасный путь, но такая услуга стоит немало.",
"Разбойные нападения на их землях заставляют знать выглядеть слабой, поэтому платные патрули — надёжный повторяющийся контракт.",
"По мере того как слухи о бандитских шайках, грабящих торговые пути к %s, расползаются, необходимость бдительных патрулей становится первостепенной.",
"Когда из-за растущей угрозы разбойников купцы боятся ехать к %s, знать должна показать, что предпринимает меры для восстановления уверенности.",
"На фоне множащихся сообщений о нападениях бандитов и засадах на караваны необходимость патрулировать дороги уже не оспаривается.",
"Работа не самая славная и не особенно увлекательная, но получать деньги за то, что просто топаешь туда-сюда, приятно.",
"Получать плату за то, что несколько дней водишь парней по округе, — пожалуй, лучшая сделка года.",
];
}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null) {
			if (this.getFaction() != null)
				r = this.format(r, ::Const.UI.getColorized(::World.FactionManager.getFaction(this.getFaction()).getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));
		}

		this.m.Description = r;
	}

	o.addKillCount = function ( _actor, _killer )
	{
		if (_killer != null && _killer.getFaction() != this.Const.Faction.Player && _killer.getFaction() != this.Const.Faction.PlayerAnimals)
		{
			return;
		}

		if (this.m.Flags.get("HeadsCollected") >= this.m.Payment.MaxCount)
		{
			return;
		}

		if (_actor.getXPValue() == 0)
		{
			return;
		}

		if (_actor.getType() == this.Const.EntityType.GoblinWolfrider || _actor.getType() == this.Const.EntityType.Wardog || _actor.getType() == this.Const.EntityType.Warhound || _actor.getType() == this.Const.EntityType.SpiderEggs || _actor.getFlags().has("tail"))
		{
			return;
		}

		if (!_actor.isAlliedWithPlayer() && !_actor.isAlliedWith(this.m.Faction) && !_actor.isResurrected())
		{
			this.m.Flags.set("HeadsCollected", this.m.Flags.get("HeadsCollected") + 1);
		}
	}

local createScreens = o.createScreens;
o.createScreens = function()
{
createScreens();
foreach (s in this.m.Screens)
{
if (s.ID == "Task")
{
s.Title = this.m.Name;
}
if (s.ID == "CrucifiedF")
{
foreach (option in s.Options)
{
option.Text = "Пусть упокоится с миром. (Повысить репутацию нравов)";
}
s.start <- function ()
{
local brothers = this.World.getPlayerRoster().getAll();

foreach( bro in brothers )
{
if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.OffendedByViolence) && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
{
bro.worsenMood(0.5, "Вы позволили распятому умереть мучительно медленно");

							if (bro.getMoodState() < this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
					}
				}

			}
if (s.ID == "Success3")
{
s.Text = "[img]gfx/ui/events/event_45.png[/img]{Ваше возвращение к %employer% встречают с любопытством. Он пересчитывает кроны, но прежде чем заплатить, спрашивает, сколько \"голов\" вы собрали в пути. Вы докладываете о %killcount% убийств, он поджимает губы и кивает.%SPEECH_ON%Этого достаточно.%SPEECH_OFF%Мужчина пересыпает немного крон в котомку и протягивает её. | Вернувшись к %employer%, вы находите его, глубоко утонувшим в огромном кресле, будто ему требуется столько места, чтобы поддерживать свою знатность, роскошь и гордость.\n\nВы рассказываете о патруле и о том, как убили %killcount% врагов на дороге. Делаете упор на убийства — именно за них вам платят. %employer% кивает и велит одному из людей насыпать крон в сумку и передать её. | %employer% стоит у окна, пьёт вино и, кажется, посматривает на нескольких женщин, работающих в саду внизу. Не оборачиваясь, он спрашивает, сколько вы убили в пути.%SPEECH_ON%%killcount%.%SPEECH_OFF%Дворянин усмехается.%SPEECH_ON%Ты говоришь так, будто это проще простого.%SPEECH_OFF%Не глядя, он щёлкает пальцами. Из боковой комнаты появляется человек с котомкой в руках. Вы берёте её и уходите. | %employer% читает свитки, приветствуя вас. Его интересует, сколько убийств вы совершили на патруле. Вы сообщаете %killcount%, он хмыкает и делает небольшую пометку на одном из листов. Кивнув, он пинком открывает сундук рядом и начинает сгребать кроны в сумку. Он протягивает её и, даже не поднимая глаз, велит вам убираться. | В доме %employer% идёт вечеринка. Вы пробираетесь сквозь толпу и пьяную роскошь, чтобы добраться до хозяина. Он перекрикивает музыку и шум, спрашивая, сколько вы уложили на патруле. Забавно, но крик о %killcount% убитых никак не действует на гостей. Пожав плечами, %employer% разворачивается и растворяется в толпе. Вы пытаетесь догнать, но один из людей преграждает путь, вбивая вам в грудь сумку.%SPEECH_ON%Твоё жалованье, наёмник. А теперь, будь добр, к дверям. Люди начинают замечать тебя, а они сюда пришли не за этим.%SPEECH_OFF%}";
}
}
}
});
