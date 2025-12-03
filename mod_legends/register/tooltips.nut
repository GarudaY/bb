// MSU Tooltips Features
// Documentation available at https://github.com/MSUTeam/MSU/wiki/Tooltips
// Setup custom tooltips to bind to UI elements
::Legends.getEncounterUIData <- function(_data) {
	local encounterType = _data.encounterType;
	local encounter = ::World.Encounters.getEncounter(_data.encounterType);
	local title;
	if (encounter != null)
		title = encounter.getName();
        if (title == null)
                title = "Ошибка";
	return [{
		id = 1,
		type = "title",
		text = title
	}, {
		id = 2,
                type = "description",
                text = "Нажмите, чтобы узнать, что здесь происходит."
        }];
}

::Legends.Mod.Tooltips.setTooltips({

	// Camping - Commander's Tent
	CampingPresets = {
                ButtonSavePreset = ::MSU.Class.BasicTooltip("Сохранить пресет","Сохраните текущие назначения лагеря в выбранный пронумерованный слот пресета"),
                ButtonLoadPreset = ::MSU.Class.BasicTooltip("Загрузить пресет","Загрузите назначения лагеря из выбранного пронумерованного слота пресета"),
                ButtonPresetName = ::MSU.Class.BasicTooltip("Изменить имя пресета","Дайте пользовательское имя выбранному пронумерованному слоту пресета"),
                ButtonPresetSlot = ::MSU.Class.BasicTooltip(
                        @(_data) "Слот пресета " + (_data.index + 1),
                        function(_data)
                        {
                                local name = ::World.Camp.getPresetName(_data.index);
                                if (name)
                                        return name;
				return "";
			}
		),
		PresetNameDialog = {
                        ButtonDelete = ::MSU.Class.BasicTooltip("Удалить имя пресета","Удалите пользовательское имя текущего слота пресета и закройте это окно"),
                        ButtonCancel = ::MSU.Class.BasicTooltip("Отменить изменения","Отмените любые изменения и закройте это окно"),
                        ButtonOk = ::MSU.Class.BasicTooltip("Сохранить имя пресета","Сохраните введённое имя как имя текущего слота пресета и закройте это окно"),
                },
        }

        Camping = {
                ButtonAssignAll = ::MSU.Class.BasicTooltip("Назначить всех","Назначить всех наёмников в текущую палатку"),
                ButtonConfigure = ::MSU.Class.CustomTooltip(function(_data){
                        local ret = [];
                        switch(_data.tent)
                        {
                                case ::Const.World.CampBuildings.Hunter:
					if (::World.Camp.getBuildingByID(::Const.World.CampBuildings.Hunter).getUpgraded())
					{
                                                ret.push({
                                                        id = 0,
                                                        type = "title",
                                                        text = "Режим охоты",
                                                });
                                                ret.push({
                                                        id = 1,
                                                        type = "description",
                                                        text = "Настройте приоритеты охотничьей партии."
                                                })
                                        }
                                        else
                                        {
                                                ret.push({
                                                        id = 0,
                                                        type = "title",
                                                        text = "Режим охоты",
                                                });
                                                ret.push({
                                                        id = 1,
                                                        type = "description",
                                                        text = "Настройте приоритеты охотничьей партии.\n\n" + ::Const.UI.getColorized("Требуется улучшение кухни",::Const.UI.Color.NegativeValue),
                                                })
                                        }
                                        break;
                                default:
                                        ret.push({
                                                id = 0,
                                                type = "title",
                                                text = "Настройка",
                                        });
                                        ret.push({
                                                id = 1,
                                                type = "description",
                                                text = "Для этой палатки нет особых настроек."
                                        })
                        }
                        return ret;
                }),
        },

        CampingHuntingMode = {
                Default = ::MSU.Class.BasicTooltip("Обычный режим","Ваша охотничья партия будет действовать с базовой скоростью."),
                Cook = ::MSU.Class.BasicTooltip(
                        "Подготовка еды",
                        format(
                                "Дайте поварам больше времени на приготовление лучшей еды.\n\nУдваивает шанс получения %s, но увеличивает время собирательства и охоты примерно на %s",
                                ::Const.UI.getColorized("улучшенных продуктов",::Const.UI.Color.PositiveValue),
                                ::Const.UI.getColorized("40%",::Const.UI.Color.NegativeValue)
                        )
                ),
                Brew = ::MSU.Class.BasicTooltip(
                        "Варка алкоголя",
                        format(
                                "Сосредоточьтесь на приготовлении алкогольных напитков.\n\nУдваивает шанс получения %s, но увеличивает время собирательства и охоты примерно на %s",
                                ::Const.UI.getColorized("настойки и напитков",::Const.UI.Color.PositiveValue),
                                ::Const.UI.getColorized("40%",::Const.UI.Color.NegativeValue)
                        )
                ),
                Hunt = ::MSU.Class.BasicTooltip(
                        "Упор на охоту",
                        format(
                                "Ваша охотничья партия будет %s на животных или чудовищ, тщательно обыскивая останки в поисках трофеев.\n\nУдваивает шанс получения %s, но увеличивает время охоты примерно на %s\n\nДля добычи трофеев требуются %s",
                                ::Const.UI.getColorized("только охотиться",::Const.UI.Color.PositiveValue),
                                ::Const.UI.getColorized("трофеев",::Const.UI.Color.PositiveValue),
                                ::Const.UI.getColorized("40%",::Const.UI.Color.NegativeValue),
                                ::Const.UI.getColorized("Искусные охотники",::Const.UI.Color.NegativeValue)
                        )
                ),
                Forage = ::MSU.Class.BasicTooltip(
                        "Упор на собирательство",
                        format(
                                "Ваша охотничья партия будет %s еду и делать это быстро.\n\nУменьшает время собирательства примерно на %s",
                                ::Const.UI.getColorized("только собирать",::Const.UI.Color.PositiveValue),
                                ::Const.UI.getColorized("15%",::Const.UI.Color.PositiveValue)
                        )
                ),
        },
        CombatResult = {
                Sort = ::MSU.Class.BasicTooltip("Сортировать предметы", "Отсортировать предметы по типу.")
        },
        Encounters = {
                Element = ::MSU.Class.CustomTooltip(@(_data) ::Legends.getEncounterUIData(_data))
        },

        Placeholder = ::MSU.Class.BasicTooltip("Заглушка","В разработке"),
});
