module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffViewContainer", package.seeall)

local var_0_0 = class("RougeLimiterBuffViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_choosebuff/SmallBuffView"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes.BuffItem
	var_1_0.cellClass = RougeLimiterBuffListItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 3
	var_1_0.cellWidth = 160
	var_1_0.cellHeight = 160
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0
	var_1_0.endSpace = 0

	local var_1_1 = {}

	table.insert(var_1_1, RougeLimiterBuffView.New())
	table.insert(var_1_1, RougeLimiterViewEmblemComp.New("#go_RightTop"))
	table.insert(var_1_1, LuaListScrollView.New(RougeLimiterBuffListModel.instance, var_1_0))

	return var_1_1
end

return var_0_0
