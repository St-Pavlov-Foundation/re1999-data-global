module("modules.logic.equip.view.EquipSkillTipViewContainer", package.seeall)

local var_0_0 = class("EquipSkillTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_character/#scroll_character"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = EquipSkillCharacterItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 3
	var_1_0.cellWidth = 150
	var_1_0.cellHeight = 190
	var_1_0.cellSpaceH = 24.1
	var_1_0.cellSpaceV = 19.5
	var_1_0.startSpace = 0

	return {
		LuaListScrollView.New(EquipSkillCharacterListModel.instance, var_1_0),
		EquipSkillTipView.New()
	}
end

return var_0_0
