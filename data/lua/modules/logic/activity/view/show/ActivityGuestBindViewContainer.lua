module("modules.logic.activity.view.show.ActivityGuestBindViewContainer", package.seeall)

local var_0_0 = class("ActivityGuestBindViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()
	local var_1_1 = ActivityGuestBindViewListModel.instance

	var_1_0.cellClass = ActivityGuestBindViewItem
	var_1_0.scrollGOPath = "leftbottom/#scroll_reward"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.scrollDir = ScrollEnum.ScrollDirH
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 172
	var_1_0.cellHeight = 185
	var_1_0.cellSpaceH = 35
	var_1_0.cellSpaceV = 0
	var_1_0.startSpace = 0
	var_1_0.endSpace = 0

	return {
		ActivityGuestBindView.New(),
		(LuaListScrollView.New(var_1_1, var_1_0))
	}
end

return var_0_0
