module("modules.logic.player.view.IconTipViewContainer", package.seeall)

local var_0_0 = class("IconTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "window/left/scrollview"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = IconListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 6
	var_1_1.cellWidth = 160
	var_1_1.cellHeight = 160
	var_1_1.cellSpaceH = 5
	var_1_1.cellSpaceV = 5
	var_1_1.startSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(IconListModel.instance, var_1_1))
	table.insert(var_1_0, IconTipView.New())

	return var_1_0
end

return var_0_0
