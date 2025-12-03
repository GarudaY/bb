::Legends.Settings <- {
    skipCamp = @() ::Legends.Mod.ModSettings.getSetting("SkipCamp").getValue() || ::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legend_risen_legion", "scenario.legends_solo_necro", "scenario.raiders")
}

local function addNCSetting( _page, _setting )
{
    _setting.getData().NewCampaign <- true;
    _setting.getData().NewCampaignOnly <- true;
    _page.addElement(_setting);
}

local map = ::Legends.Mod.ModSettings.addPage("Настройки карты");

//Setting, Default, Min, Max, ?, Name, Description
//Setting, Default, Min, Max, ?, Name, Description
addNCSetting(map, ::MSU.Class.RangeSetting("LandRatio", 50, 45, 70, 1, "Соотношение суши и воды", "Минимальное соотношение суши к воде для подходящей карты. Значение по умолчанию — 50. Крайние значения ползунка могут привести к невозможности сгенерировать карту."));
addNCSetting(map, ::MSU.Class.RangeSetting("Water", 38, 28, 48, 1, "Вода", "Влияет на то, какая часть карты покрыта водой. Малое значение даёт пятна воды у углов карты. Большие значения могут создать один большой остров при низком соотношении суши."));
addNCSetting(map, ::MSU.Class.RangeSetting("Snowline", 85, 75, 95, 1, "Линия снега", "Определяет, где проходит линия снега. Значение по умолчанию — 90. Это инвертированная величина: значение 10 означает, что верхние 90% карты покрыты снегом."));
addNCSetting(map, ::MSU.Class.RangeSetting("Settlements", 19, 19, 27, 1, "Поселения", "Максимальное количество поселений. В зависимости от размера карты попробует добавить число поселений из ползунка, сохраняя пропорции типов, как на стандартных картах Battle Brothers. Минимальная дистанция между поселениями — 12 тайлов. Базовое значение — 19."));
addNCSetting(map, ::MSU.Class.RangeSetting("Factions", 3, 1, 6, 1, "Фракции", "Максимальное количество фракций, которые пытаемся сгенерировать. В зависимости от размера карты может не добавить все выбранные фракции."));

addNCSetting(map, ::MSU.Class.SettingsDivider("MapDivider1"));

addNCSetting(map, ::MSU.Class.BooleanSetting("StackCitadels", false, "Полноценные цитадели", "Если включено, каждая цитадель сразу стартует со всеми желанными пристройками."));
addNCSetting(map, ::MSU.Class.BooleanSetting("AllTradeLocations", false, "Все торговые здания доступны", "Если включено, гарантируется наличие хотя бы одного здания каждого торгового типа на карте."));
addNCSetting(map, ::MSU.Class.BooleanSetting("DebugMap", false, "(Отладка) Показать всю карту", "Если включено, карта будет открыта полностью, а все враги и лагеря будут видны."));

local config = ::Legends.Mod.ModSettings.addPage("Параметры кампании");

addNCSetting(config, ::MSU.Class.EnumSetting("GenderEquality", "Enabled", ["Disabled", "Enabled", "Enabled (Cosmetic)"], "Боевые сёстры", "При включении большинство происхождений случайно назначаются как мужские, так и женские. Некоторые происхождения остаются сугубо мужскими или женскими. Женские персонажи получают +10 к усталости, но -10 к здоровью.\n\n[u]Disabled[/u]\nПочти ванильный опыт. Обычные происхождения не имеют женских вариантов, хотя особые вроде Валы всё равно появляются. Нет вражеских столкновений с женщинами (да, твоя подруга Ведьма остаётся!).\n\n[u]Enabled[/u]\nЖенский пол влияет на характеристики.\n\n[u]Enabled (Cosmetic)[/u]\nЖенский пол не влияет на характеристики."));
local myEnumTooltip = "Бонусы специалиста (например, руки егера) учитываются лишь на 25% для неспециализированного оружия, но будут расти на 5% по правилам ниже.\n\n[u]Уровень[/u]\n5% за уровень (100% на уровне 16)\n\n[u]Неделя в отряде (стиль SSU)[/u]\n5% за каждые 7 дней, проведённые в компании (100% на 105-й день)\n\n[u]Тренировка[/u]\n5% за уровень лагерной тренировки (100% по завершении тренировки)";
addNCSetting(config, ::MSU.Class.EnumSetting("SpecialistSkillsSetting", "Level", ["Level", "Week in company", "Training"], "Правила специализации навыков", myEnumTooltip));
addNCSetting(config, ::MSU.Class.SettingsDivider("ConfigDivider1"));
addNCSetting(config, ::MSU.Class.BooleanSetting("DistanceScaling", true, "Скалирование по дальности", "Если включено, враги будут сильнее, чем дальше они появляются от цивилизации.\n\nПодробно: начиная с 14 тайлов от ближайшего города враги на отметке 28 тайлов будут вдвое сильнее.\n\nЭто дополнительно к другим настройкам сложности."));
addNCSetting(config, ::MSU.Class.BooleanSetting("SkipCamp", true, "Пропустить обучение лагерю", "Если отключено, вы будете постепенно открывать лагерные активности, посещая города. Полезно для первого прохождения.\n\nПодробно: пропускает события и амбицию открытия лагеря, но улучшения всё равно нужно покупать."));
addNCSetting(config, ::MSU.Class.BooleanSetting("RecruitScaling", true, "Скалирование рекрутов", "Если включено, новые рекруты будут получать уровни в зависимости от уровня вашего отряда и вашей славы.\n\nПодробно: максимальный уровень рекрутов повышается наполовину от среднего уровня братьев в компании, усреднённого с вашей репутацией, делённой на 1000.\n\nНапример, если весь отряд имеет 10 уровень, а слава равна 10 000, новые рекруты смогут получить до 7 уровней (с округлением вниз).\n\nЭто дополняет обычный разброс уровней рекрутов."));
addNCSetting(config, ::MSU.Class.BooleanSetting("BleedKiller", true, "Эффекты считаются убийствами", "Если включено, убийства от кровотечения, яда или освящения засчитываются актёру, вызвавшему соответствующий эффект."));
addNCSetting(config, ::MSU.Class.BooleanSetting("WorldEconomy", true, "Мировая экономика", "Если включено, поселения активно торгуют предметами и ресурсами и могут расти или деградировать.\n\nПодробно: ценность поселения — динамическая величина, которая растёт или падает с прибывающими и уходящими караванами, выполненными или проваленными контрактами, хорошими или плохими событиями.\n\nЦенность поселения определяет стоимость караванов, которые оно создаёт, а также силу ополчения.\n\nОчень процветающие поселения будут продолжать расти и потенциально добавят новые локации."));

addNCSetting(config, ::MSU.Class.SettingsDivider("ConfigDivider2"));

local tooltip = ::Legends.Mod.ModSettings.addPage("Подсказки / Интерфейс");
tooltip.addTitle("TooltipCombat", "Подсказки — Бой");
tooltip.addElement(::MSU.Class.BooleanSetting("EnhancedTooltips", false, "Расширенные подсказки врагов", "Подсказки врагов в тактических битвах показывают больше информации, например перки и статусы"));
tooltip.addDivider("TooltipDivider1");
tooltip.addTitle("TooltipInventory", "Подсказки — Инвентарь");
tooltip.addElement(::MSU.Class.BooleanSetting("ShowArmorPerFatigueValue", true, "Эффективность брони/усталости", "Показывать в подсказке, сколько брони даёт каждый пункт усталости для элемента брони или шлема/слоя при наведении на отдельный элемент.\n\nПолезно тем, кто выбирает экипировку по цене за единицу веса"));
tooltip.addElement(::MSU.Class.BooleanSetting("ShowExpandedArmorLayerTooltip", true, "Развёрнутые подсказки слоёв брони", "Показывать в подсказке броню и усталость каждого слоя брони/шлема при наведении на комбинированный набор.\n\nОтключение может сократить длину подсказки на экранах с низким разрешением"));
tooltip.addElement(::MSU.Class.BooleanSetting("ShowItemTradeHistory", true, "Показывать историю торговли предмета", "Показывать торговую историю предметов, например, где они были произведены или откуда импортированы.\n\nНе действует, если отключена мировая экономика"));
tooltip.addDivider("TooltipDivider2");
tooltip.addTitle("TooltipCharacter", "Подсказки — Персонаж");
tooltip.addElement(::MSU.Class.BooleanSetting("ShowCharacterBackgroundType", true, "Показывать типы происхождения персонажа", "Показывать типы происхождения персонажа в подсказках.\n\nПолезно при игре с происхождениями, где механики завязаны на типы"));
tooltip.addDivider("TooltipDivider3");
tooltip.addTitle("TooltipWorldMap", "Подсказки — Мир");
tooltip.addElement(::MSU.Class.BooleanSetting("ExactEngageNumbers", false, "Точное число участников столкновения", "Отображать точное количество противников в столкновении."));
tooltip.addDivider("TooltipDivider4");
tooltip.addTitle("TooltipUI", "Интерфейс");

local cpLight = tooltip.addElement(::MSU.Class.ColorPickerSetting("HighlightLightBackground", "2,55,189,1", "Выделенный текст (светлый фон)", "Настройте цвет выделенного текста на светлых фонах, например в подсказках"));
::Const.UI.Color.getHighlightLightBackgroundValue <- function() {return "#" + cpLight.getValueAsHexString().slice(0,6)}
local cpDark = tooltip.addElement(::MSU.Class.ColorPickerSetting("HighlightDarkBackground", "111,145,201,1", "Выделенный текст (тёмный фон)", "Настройте цвет выделенного текста на тёмных фонах, например в событиях"));
::Const.UI.Color.getHighlightDarkBackgroundValue <- function() {return "#" + cpDark.getValueAsHexString().slice(0,6)}
local cpFade = tooltip.addElement(::MSU.Class.ColorPickerSetting("FadeDarkBackground", "135,114,81,1", "Приглушённый текст (тёмный фон)", "Настройте цвет приглушённого текста на тёмных фонах, например в событиях"));
::Const.UI.Color.getFadeDarkBackgroundValue <- function() {return "#" + cpFade.getValueAsHexString().slice(0,6)}
tooltip.addElement(::MSU.Class.EnumSetting("ContractCategoryIconAlignment", "Middle", ["Left","Middle","Right","Below"], "Расположение иконки категории контракта", "Настройте позицию иконки категории контракта внизу экрана поселения"));

local misc = ::Legends.Mod.ModSettings.addPage("Разное");
myEnumTooltip = "Определяет, как показывать чертежи: 'Все ингредиенты доступны' — поведение по умолчанию; 'Доступен один ингредиент' показывает рецепты, когда один ингредиент полностью закрыт; 'Всегда' показывает все рецепты в любой момент";
misc.addElement(::MSU.Class.EnumSetting("ShowBlueprintsWhen", "All Ingredients Available", ["All Ingredients Available", "One Ingredient Available", "Always"], "Когда показывать чертежи", myEnumTooltip));
misc.addElement(::MSU.Class.BooleanSetting("AutoRepairLayer", false, "Автопочинка слоя", "Любой снятый слой тела или шлема автоматически помечается как 'отремонтировать'."));
misc.addElement(::MSU.Class.BooleanSetting("ClickPresetToSwitch", false, "Быстрая смена пресета лагеря", "Клик по слоту лагерного пресета сразу применяет пресет"));
misc.addElement(::MSU.Class.RangeSetting("MinimumChanceToHit", 5, 0, 100, 1, "Минимальный шанс попадания", "Ползунок минимального процента попадания. Слишком низкое значение приведёт к невозможности попасть всем"));
misc.addElement(::MSU.Class.RangeSetting("MaximumChanceToHit", 95, 0, 100, 1, "Максимальный шанс попадания", "Ползунок максимального процента попадания. Слишком низкое значение приведёт к невозможности попасть всем"));
myEnumTooltip = "Определяет правила поворота ИИ: 'Default' — ванильное поведение, ИИ может поворачивать себя и братьев, если навык позволяет; 'Limited' — ИИ может поворачивать только себя, но не братьев (если у них нет перка Кружение); 'Disabled' — полностью отключает поворот ИИ";
misc.addElement(::MSU.Class.EnumSetting("AiRotation", "Default", ["Default", "Limited", "Disabled"], "Правила поворота ИИ", myEnumTooltip));
misc.addElement(::MSU.Class.BooleanSetting("SellDialogNamed", true, "Окно продажи именных предметов", "Показывать ли окно подтверждения при продаже именных предметов?"));

local logging = ::Legends.Mod.ModSettings.addPage("Логирование");
foreach(f in ::Const.LegendMod.Debug.FlagDefs)
{
    local b = logging.addElement(::MSU.Class.BooleanSetting(f.ID, f.Value, f.Name, f.Description)); // Set the default MSU Debug logging flags based on configuration in ::Const.LegendMod.Debug.FlagDefs
    b.Data.FlagID <- f.ID;
    b.addBeforeChangeCallback(function(_value)
        {
            ::Legends.Mod.Debug.setFlag(this.Data.FlagID, _value);
        }
    );
}
