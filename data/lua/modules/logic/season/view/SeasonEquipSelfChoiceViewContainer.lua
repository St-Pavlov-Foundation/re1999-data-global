module("modules.logic.season.view.SeasonEquipSelfChoiceViewContainer", package.seeall)

local var_0_0 = class("SeasonEquipSelfChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = arg_1_0:createEquipItemsParam()

	return {
		SeasonEquipSelfChoiceView.New(),
		LuaListScrollView.New(Activity104SelfChoiceListModel.instance, var_1_0)
	}
end

function var_0_0.createEquipItemsParam(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "root/mask/#scroll_item"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = SeasonEquipSelfChoiceItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 7
	var_2_0.cellWidth = 197
	var_2_0.cellHeight = 272
	var_2_0.cellSpaceH = 0
	var_2_0.cellSpaceV = 1.67

	return var_2_0
end

return var_0_0
