/**
* For item reward based contracts.
* This contract negotiation template requires `this.Contract.m.Payment.ItemPool` being not empty.
* Monetary compensation will be converted to items defined in that list.
* It does not support both money and items at once.
*/
// TODO, doesn't work, to be fixed
::Const.Contracts.NegotiationMoneyAndItems <- @(_count) [{
   ID = "Negotiation",
   Title = "Переговоры",
	Text = "",
	Image = "",
	List = [],
	ShowEmployer = true,
	ShowDifficulty = true,
	Options = [],
	function start() {
		while (this.Contract.m.Payment.Items.len() < _count) {
			local item = ::Const.World.Common.pickItem(this.Contract.m.Payment.ItemPool, "scripts/items/");
			this.Contract.m.Payment.Items.push(item);
			this.Contract.m.Payment.Pool -= item.getValue() / 2;
		}

		this.Options = [];
		this.Options.push({
                  Text = "Я принимаю ваше предложение.",
			function getResult() {
				this.Contract.m.BulletpointsPayment = [];

				if (this.Contract.m.Payment.Advance != 0) {
                                  this.Contract.m.BulletpointsPayment.push("Получить " + this.Contract.m.Payment.getInAdvance() + " крон авансом");
				}

				if (this.Contract.m.Payment.Count != 0) {
                                  this.Contract.m.BulletpointsPayment.push("Получить " + this.Contract.m.Payment.getPerCount() + " крон за каждую голову, но не больше " + this.Contract.m.Payment.MaxCount + " в сумме");
				}

				if (this.Contract.m.Payment.Items.len() != 0) {
                                  this.Contract.m.BulletpointsPayment.push("Получить " + this.Contract.m.Payment.Items.len() + " различных предметов по завершении");
				}

				return "Overview";
			}
		});
		this.Options.push({
                        Text = "{Нам нужно больше заплатить за эту работу.}",
			function getResult() {
				if (!::World.Retinue.hasFollower("follower.negotiator")) {
					if (::Math.rand(1, 100) <= 66) {
						::World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				} else {
					if (::Math.rand(1, 100) <= 10) {
						::World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelationEx(-0.5);
					}
				}

				this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

				if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance) {
					return "Negotiation.Fail";
				}

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance) {
					this.Contract.m.Payment.IsFinal = true;
				} else {
					this.Contract.m.Payment.IsFinal = false;
					this.Contract.m.Payment.Pool += 200;
				}

				return "Negotiation";
			}

		});

                this.Options.push({
                        Text = "{Забудьте, это того не стоит. | Пустая трата времени. }",
			function getResult() {
				this.World.Contracts.removeContract(this.Contract);
				this.World.State.getTownScreen().updateContracts();
				return 0;
			}
		});

		if (this.Contract.m.Payment.Advance < 1.0)
		{
			this.Options.push({
                                Text = this.Contract.m.Payment.Advance == 0 ? "Нам нужна предоплата." : "Нам нужно больше предоплаты.",
				function getResult()
				{
					this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

					if (this.Contract.m.Payment.Advance >= this.World.Assets.m.AdvancePaymentCap || this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
					{
						return "Negotiation.Fail";
					}

					if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
					{
						this.Contract.m.Payment.IsFinal = true;
					}
					else
					{
						this.Contract.m.Payment.IsFinal = false;
						this.Contract.m.Payment.Advance = this.Math.minf(1.0, this.Contract.m.Payment.Advance + 0.25);
						this.Contract.m.Payment.Completion = this.Math.maxf(0.0, this.Contract.m.Payment.Completion - 0.25);
					}

					return "Negotiation";
				}
			});
		}


		if (this.Contract.m.Payment.Completion < 1.0)
		{
			this.Options.push({
                                Text = this.Contract.m.Payment.Completion == 0 ? "Нам нужна оплата по завершении работы." : "Нам нужно больше оплаты после выполнения.",
				function getResult()
				{
					this.Contract.m.Payment.Annoyance += this.Math.maxf(1.0, this.Math.rand(this.Const.Contracts.Settings.NegotiationAnnoyanceGainMin, this.Const.Contracts.Settings.NegotiationAnnoyanceGainMax) * this.World.Assets.m.NegotiationAnnoyanceMult);

					if (this.Contract.m.Payment.Annoyance > this.Const.Contracts.Settings.NegotiationMaxAnnoyance)
					{
						return "Negotiation.Fail";
					}

					if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.NegotiationRefuseChance * this.Contract.m.Payment.Annoyance)
					{
						this.Contract.m.Payment.IsFinal = true;
					}
					else
					{
						this.Contract.m.Payment.IsFinal = false;
						this.Contract.m.Payment.Advance = this.Math.maxf(0.0, this.Contract.m.Payment.Advance - 0.25);
						this.Contract.m.Payment.Completion = this.Math.minf(1.0, this.Contract.m.Payment.Completion + 0.25);
					}

					return "Negotiation";
				}

			});
		}

		if (!this.Contract.m.Payment.IsNegotiating) {
                        this.Text = "[img]gfx/ui/events/event_04.png[/img]{%They_employer% кивает.%SPEECH_ON%Да. Хорошо. Я тут поразмышлял об оплате за вашу задачу. | %They_employer% выпрямляется.%SPEECH_ON%Итак, об оплате. | %They_employer% улыбается.%SPEECH_ON%Это сделает вас богачом, мой друг. | %They_employer% глубоко вздыхает.%SPEECH_ON%Хорошо, вот что я готов предложить. | %They_employer% кладёт %their_employer% руку вам на плечо, ободряюще улыбаясь.%SPEECH_ON%Думаю, я знаю, какая компенсация вам подойдёт. | %They_employer% жестикулирует %their_employer% руками, загибая %their_employer% пальцы, словно что-то подсчитывая, но вы ничего не понимаете.%SPEECH_ON%По опыту знаю, что это хорошая плата за задачу. | %They_employer% кивает. %SPEECH_ON%Вы выглядите способными, так что я готов заплатить немало. | %They_employer% позвякивает мешочком монет.%SPEECH_ON%Это будет вашим, если поможете мне. | %They_employer% раскрывает ладони.%SPEECH_ON%У меня туго с кронами, так что заранее предупреждаю: это всё, что есть сейчас. | %SPEECH_ON%Будьте уверены, то, что я предлагаю, достойная награда за вашу работу.} ";
			this.Contract.m.Payment.IsNegotiating = true;
		} else if (this.Contract.m.Payment.IsFinal) {
                        this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%Я отказываюсь платить больше за это.  | %SPEECH_START%Будьте разумны.  | %SPEECH_START%Нет, нет, нет.  | %SPEECH_START%Кем вы себя возомнили? Я решаю, как вам будут платить.  | %They_employer% строго смотрит на вас и качает %their_employer% головой.%SPEECH_ON% | %SPEECH_START%Нет, вы уже получаете больше, чем стоите.  | %SPEECH_START%Нет. Не доводите меня!  | %SPEECH_START%Вы, похоже, не понимаете, как это работает. Нужно договориться, если хотите получить деньги. Моё предложение остаётся. }";
		} else {
                        this.Text = "[img]gfx/ui/events/event_04.png[/img]{%SPEECH_START%Так это всё?  | %They_employer% глубоко вздыхает.%SPEECH_ON% | %They_employer% тяжело выдыхает.%SPEECH_ON% | %SPEECH_START%Ладно, справедливо.  | %SPEECH_START%Хорошо, хорошо.  | %SPEECH_START%Если надо. | %SPEECH_START%Хорошо. Как вам такое?  | %SPEECH_START%Ладно, понимаю.  | %SPEECH_START%Разумно.  | %SPEECH_START%Интересно. Думаю, так будет уместнее.  | %SPEECH_START%Предпочтёте это вместо того?  | %SPEECH_START%Позвольте сделать следующее предложение.  | %SPEECH_ON%Справедливо. Согласитесь на это?  | %SPEECH_START%Хорошо. Учитывая ваши требования, предлагаю вот что.  | %SPEECH_START%Давайте побыстрее покончим с этим. Вот моё новое предложение.  | %SPEECH_START%Мы же друзья, правда? Посмотрим... }";
		}

		if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance == 0) {
                        this.Text += "{Вы получите | Вам заплатят | Вы будете оплачены | Это} %reward_completion% крон, когда контракт будет выполнен.%SPEECH_OFF%";
		} else if (this.Contract.m.Payment.Completion == 0 && this.Contract.m.Payment.Advance != 0) {
                        this.Text += "{Вы получите | Вам заплатят | Вы будете оплачены} все %reward_advance% крон авансом.%SPEECH_OFF%";
		} else if (this.Contract.m.Payment.Completion != 0 && this.Contract.m.Payment.Advance != 0) {
                        this.Text += "{Вы получите | Вам заплатят | Вы будете оплачены | Это} %reward_advance% крон авансом и ещё %reward_completion% по завершении работы.%SPEECH_OFF%";
		} else {
                        this.Text += "Вы не получите ничего. Этого вы хотите?%SPEECH_OFF%";
		}

		if (this.Contract.m.Payment.Items.len() != 0) {
                        this.Text += "%SPEECH_START%{Вы также получите} эту кучку из %reward_item_count% предметов, когда контракт будет выполнен.%SPEECH_OFF%";
			this.List.extend(this.Contract.getPaymentItems());
		}
	}
}, {
	ID = "Negotiation.Fail",
        Title = "Переговоры",
        Text = "[img]gfx/ui/events/event_74.png[/img]{%SPEECH_START%Вы ведёте себя так, будто только вы можете держать меч за монеты. Пожалуй, я поищу других людей. Всего доброго.%SPEECH_OFF% | %SPEECH_START%Моему терпению тоже есть предел, и, кажется, я трачу тут время впустую.%SPEECH_OFF% | %SPEECH_START%С меня хватит! Я уверен, что найду кого-то другого для работы!%SPEECH_OFF% | %SPEECH_START%Не оскорбляйте мой разум! Забудьте об этом контракте. Мы закончили.%SPEECH_OFF% | %Their_employer% лицо краснеет от злости.%SPEECH_ON%Убирайтесь отсюда, я не привык иметь дело с алчными дьяволами!%SPEECH_OFF% | %They_employer% вздыхает. %SPEECH_ON%Просто... забудьте. Не стоило доверять вам изначально. Уйдите, чтобы я нашёл более разумных людей.%SPEECH_OFF% | %SPEECH_START%Я правда думал, что у нас хорошие отношения. Но знайте, я тоже не резиновый. Не думаю, что у нас что-то выйдет. Я ухожу.%SPEECH_OFF% | %SPEECH_ON%Это была полная трата моего времени. Не возвращайтесь, пока не образумитесь.%SPEECH_OFF%}",
	Image = "",
	List = [],
	ShowEmployer = true,
	ShowDifficulty = true,
	Options = [
		{
                        Text = "Мы не будем рисковать жизнями за столь жалкую оплату...",
			function getResult() {
				::World.Contracts.removeContract(this.Contract);
				return 0;
			}

		}
	]
}];
