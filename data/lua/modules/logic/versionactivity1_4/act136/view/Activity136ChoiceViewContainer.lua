module("modules.logic.versionactivity1_4.act136.view.Activity136ChoiceViewContainer", package.seeall)

local var_0_0 = class("Activity136ChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "root/#scroll_item"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = Activity136ChoiceItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 6
	var_1_1.cellWidth = 200
	var_1_1.cellHeight = 225
	var_1_1.cellSpaceH = 30
	var_1_1.startSpace = 10

	table.insert(var_1_0, Activity136ChoiceView.New())
	table.insert(var_1_0, LuaListScrollView.New(Activity136ChoiceViewListModel.instance, var_1_1))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
