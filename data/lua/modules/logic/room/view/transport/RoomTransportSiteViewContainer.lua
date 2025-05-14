module("modules.logic.room.view.transport.RoomTransportSiteViewContainer", package.seeall)

local var_0_0 = class("RoomTransportSiteViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "go_content/#go_right/#go_buildinglist/#scroll_building"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = RoomTransportBuildingItem.prefabPath
	var_1_0.cellClass = RoomTransportBuildingItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 540
	var_1_0.cellHeight = 180
	var_1_0.cellSpaceV = 10

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "go_content/#go_right/#go_buildinglist/#scroll_buildingskin"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = RoomTransportBuildingSkinItem.prefabPath
	var_1_1.cellClass = RoomTransportBuildingSkinItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 196
	var_1_1.cellHeight = 140
	var_1_1.cellSpaceV = 10

	local var_1_2 = ListScrollParam.New()

	var_1_2.scrollGOPath = "go_content/#go_right/#go_critterlist/#scroll_critter"
	var_1_2.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_2.prefabUrl = RoomTransportCritterItem.prefabPath
	var_1_2.cellClass = RoomTransportCritterItem
	var_1_2.scrollDir = ScrollEnum.ScrollDirV
	var_1_2.lineCount = 1
	var_1_2.cellWidth = 640
	var_1_2.cellHeight = 175
	var_1_2.cellSpaceV = 10

	local var_1_3 = {}

	table.insert(var_1_3, TabViewGroup.New(1, "go_content/#go_BackBtns"))
	table.insert(var_1_3, RoomTransportSiteView.New())
	table.insert(var_1_3, LuaListScrollView.New(RoomTransportBuildingListModel.instance, var_1_0))
	table.insert(var_1_3, LuaListScrollView.New(RoomTransportBuildingSkinListModel.instance, var_1_1))

	return var_1_3
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.RoomTransportHelp)

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)
		NavigateMgr.instance:addEscape(arg_2_0.viewName, arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterListView) then
		ViewMgr.instance:closeView(ViewName.RoomCritterListView)

		return
	end

	arg_3_0:closeThis()
end

function var_0_0.setUseBuildingUid(arg_4_0, arg_4_1)
	arg_4_0.useBuildingUid = arg_4_1
end

function var_0_0.getUseBuildingUid(arg_5_0)
	return arg_5_0.useBuildingUid
end

return var_0_0
