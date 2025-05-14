module("modules.logic.room.view.RoomInitBuildingViewContainer", package.seeall)

local var_0_0 = class("RoomInitBuildingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_navigatebuttonscontainer"))

	arg_1_0._roomInitBuildingView = RoomInitBuildingView.New()

	table.insert(var_1_0, arg_1_0._roomInitBuildingView)
	table.insert(var_1_0, RoomInitBuildingViewChange.New())
	table.insert(var_1_0, RoomInitBuildingSkinView.New())
	table.insert(var_1_0, RoomViewTopRight.New("#go_topright", arg_1_0._viewSetting.otherRes[1], {
		{
			initAnim = "idle",
			type = 2,
			id = 5,
			supportFlyEffect = true,
			classDefine = RoomViewTopRightMaterialItem,
			listeningItems = {
				{
					id = 5,
					type = 2
				},
				{
					id = 3,
					type = 2
				}
			}
		},
		{
			initAnim = "idle",
			type = 2,
			id = 3,
			supportFlyEffect = true,
			classDefine = RoomViewTopRightMaterialItem,
			listeningItems = {
				{
					id = 5,
					type = 2
				},
				{
					id = 3,
					type = 2
				}
			}
		}
	}))
	table.insert(var_1_0, arg_1_0:_createShowDegreeListView())
	table.insert(var_1_0, arg_1_0:_createRoomSkinListView())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.RoomInitBuilding, arg_2_0._closeCallback, nil, nil, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0._closeCallback(arg_3_0)
	if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		ViewMgr.instance:closeView(ViewName.RoomFormulaView)
	end

	RoomMapController.instance:onCloseRoomInitBuildingView()
end

function var_0_0.setSelectLine(arg_4_0, arg_4_1)
	arg_4_0._selectLineId = arg_4_1
end

function var_0_0.getSelectLine(arg_5_0)
	return arg_5_0._selectLineId
end

function var_0_0.setSelectPartId(arg_6_0, arg_6_1)
	arg_6_0._selectPartId = arg_6_1
end

function var_0_0.getCurrentViewParam(arg_7_0)
	return {
		partId = arg_7_0._selectPartId,
		lineId = arg_7_0._selectLineId
	}
end

function var_0_0.onContainerOpenFinish(arg_8_0)
	arg_8_0._navigateButtonView:resetCloseBtnAudioId(0)
end

function var_0_0._createShowDegreeListView(arg_9_0)
	local var_9_0 = ListScrollParam.New()

	var_9_0.scrollGOPath = "right/#go_init/#go_activeList/#scroll_activeList"
	var_9_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_9_0.prefabUrl = "right/#go_init/#go_activeList/#scroll_activeList/viewport/content/#go_degreeItem"
	var_9_0.cellClass = RoomInitBuildingDegreeItem
	var_9_0.scrollDir = ScrollEnum.ScrollDirV
	var_9_0.cellWidth = 635
	var_9_0.cellHeight = 60
	var_9_0.cellSpaceV = 4
	var_9_0.startSpace = 0

	local var_9_1 = {}

	for iter_9_0 = 1, 10 do
		var_9_1[iter_9_0] = (iter_9_0 - 1) * 0.03
	end

	return LuaListScrollViewWithAnimator.New(RoomShowDegreeListModel.instance, var_9_0, var_9_1)
end

function var_0_0._createRoomSkinListView(arg_10_0)
	local var_10_0 = ListScrollParam.New()

	var_10_0.scrollGOPath = "right/#go_skin/#scroll_view"
	var_10_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_10_0.prefabUrl = "right/#go_skin/#scroll_view/viewport/content/#go_skinitem"
	var_10_0.cellClass = RoomInitBuildingSkinItem
	var_10_0.scrollDir = ScrollEnum.ScrollDirV
	var_10_0.cellWidth = 600
	var_10_0.cellHeight = 184
	var_10_0.cellSpaceV = 20
	var_10_0.startSpace = 14

	return LuaListScrollView.New(RoomSkinListModel.instance, var_10_0)
end

function var_0_0.setIsShowTitle(arg_11_0, arg_11_1)
	if not arg_11_0._roomInitBuildingView then
		return
	end

	arg_11_0._roomInitBuildingView:setTitleShow(arg_11_1)
end

return var_0_0
