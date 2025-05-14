module("modules.logic.login.view.ServerListViewContainer", package.seeall)

local var_0_0 = class("ServerListViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "serverlist"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = ServerListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 2
	var_1_1.cellWidth = 400
	var_1_1.cellHeight = 60
	var_1_1.cellSpaceH = 50
	var_1_1.cellSpaceV = 40

	table.insert(var_1_0, LuaListScrollView.New(ServerListModel.instance, var_1_1))
	table.insert(var_1_0, ServerListView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
