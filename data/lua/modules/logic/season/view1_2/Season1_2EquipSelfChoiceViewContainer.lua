module("modules.logic.season.view1_2.Season1_2EquipSelfChoiceViewContainer", package.seeall)

local var_0_0 = class("Season1_2EquipSelfChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = arg_1_0:createEquipItemsParam()
	local var_1_1 = Season1_2EquipTagSelect.New()

	var_1_1:init(Activity104EquipSelfChoiceController.instance, "root/#drop_filter", "#433834")

	return {
		Season1_2EquipSelfChoiceView.New(),
		var_1_1,
		LuaListScrollView.New(Activity104SelfChoiceListModel.instance, var_1_0)
	}
end

function var_0_0.createEquipItemsParam(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "root/mask/#scroll_item"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = Season1_2EquipSelfChoiceItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 5
	var_2_0.cellWidth = 180
	var_2_0.cellHeight = 235
	var_2_0.cellSpaceH = 7.4
	var_2_0.cellSpaceV = 32.5
	var_2_0.startSpace = 56

	return var_2_0
end

return var_0_0
