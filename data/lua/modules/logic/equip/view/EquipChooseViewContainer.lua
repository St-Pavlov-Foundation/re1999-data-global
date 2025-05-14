module("modules.logic.equip.view.EquipChooseViewContainer", package.seeall)

local var_0_0 = class("EquipChooseViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_equip"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = EquipChooseItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 4
	var_1_0.cellWidth = 232
	var_1_0.cellHeight = 232
	var_1_0.cellSpaceH = 15
	var_1_0.cellSpaceV = 15
	var_1_0.startSpace = 60

	return {
		LuaListScrollView.New(EquipChooseListModel.instance, var_1_0),
		EquipChooseView.New()
	}
end

return var_0_0
