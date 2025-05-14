module("modules.logic.versionactivity1_3.act125.view.VersionActivity1_3RadioViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_3RadioViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "Middle/FMSlider/#scroll_FMChannelList"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "Middle/FMSlider/#scroll_FMChannelList/Viewport/Content/#go_radiochannelitem"
	var_1_0.cellClass = VersionActivity1_3RadioChannelItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirH
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 100
	var_1_0.cellHeight = 100
	var_1_0.cellSpaceH = 0
	var_1_0.startSpace = 210
	var_1_0.endSpace = 210
	arg_1_0._channelScrollView = LuaListScrollView.New(V1A3_RadioChannelListModel.instance, var_1_0)

	return {
		VersionActivity1_3RadioView.New(),
		arg_1_0._channelScrollView
	}
end

return var_0_0
