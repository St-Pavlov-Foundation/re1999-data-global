module("modules.logic.character.view.CharacterEquipSettingViewContainer", package.seeall)

local var_0_0 = class("CharacterEquipSettingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_equip"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = CharacterEquipSettingItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 3
	var_1_1.cellWidth = 228
	var_1_1.cellHeight = 218
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 2.22
	var_1_1.startSpace = 0

	table.insert(var_1_0, CharacterEquipSettingView.New())
	table.insert(var_1_0, LuaListScrollView.New(CharacterEquipSettingListModel.instance, var_1_1))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
