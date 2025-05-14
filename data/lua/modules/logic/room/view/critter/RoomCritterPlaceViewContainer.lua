module("modules.logic.room.view.critter.RoomCritterPlaceViewContainer", package.seeall)

local var_0_0 = class("RoomCritterPlaceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomCritterPlaceView.New())

	local var_1_1 = arg_1_0:getScrollParam1()
	local var_1_2 = arg_1_0:getScrollParam2()
	local var_1_3 = LuaListScrollView.New(RoomCritterPlaceListModel.instance, var_1_1)
	local var_1_4 = LuaListScrollView.New(RoomCritterPlaceListModel.instance, var_1_2)

	table.insert(var_1_0, var_1_3)
	table.insert(var_1_0, var_1_4)

	return var_1_0
end

function var_0_0.getScrollParam1(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "#go_critterview1/critterscroll"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_2_0.prefabUrl = "#go_critterview1/critterscroll/Viewport/#go_critterContent1/#go_critterItem"
	var_2_0.cellClass = RoomCritterPlaceItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirH
	var_2_0.cellWidth = 150
	var_2_0.cellHeight = 200
	var_2_0.cellSpaceH = 30
	var_2_0.startSpace = 30

	return var_2_0
end

function var_0_0.getScrollParam2(arg_3_0)
	local var_3_0 = "#go_critterview2/critterscroll"
	local var_3_1 = arg_3_0:_getScrollWidth(var_3_0)
	local var_3_2 = ListScrollParam.New()

	var_3_2.scrollGOPath = var_3_0
	var_3_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_3_2.prefabUrl = "#go_critterview2/critterscroll/Viewport/#go_critterContent2/#go_critterItem"
	var_3_2.cellClass = RoomCritterPlaceItem
	var_3_2.scrollDir = ScrollEnum.ScrollDirV
	var_3_2.cellWidth = 180
	var_3_2.cellHeight = 150
	var_3_2.lineCount = arg_3_0:_getLineCount(var_3_1, var_3_2.cellWidth)
	var_3_2.cellSpaceV = 20
	var_3_2.startSpace = 10

	return var_3_2
end

function var_0_0._getScrollWidth(arg_4_0, arg_4_1)
	local var_4_0 = gohelper.findChildComponent(arg_4_0.viewGO, arg_4_1, gohelper.Type_Transform)

	if var_4_0 then
		return recthelper.getWidth(var_4_0)
	end

	local var_4_1 = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * var_4_1 + 0.5))
end

function var_0_0._getLineCount(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = math.floor(arg_5_1 / arg_5_2)

	return (math.max(var_5_0, 1))
end

function var_0_0.onContainerInit(arg_6_0)
	arg_6_0:setContainerViewBuildingUid(arg_6_0.viewParam and arg_6_0.viewParam.buildingUid)
end

function var_0_0.onContainerClose(arg_7_0)
	arg_7_0:setContainerViewBuildingUid()
end

function var_0_0.setContainerViewBuildingUid(arg_8_0, arg_8_1)
	arg_8_0._viewBuildingUid = arg_8_1
end

function var_0_0.getContainerViewBuilding(arg_9_0, arg_9_1)
	local var_9_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_9_0._viewBuildingUid)

	if not var_9_0 and arg_9_1 then
		logError(string.format("RoomCritterPlaceViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", arg_9_0._viewBuildingUid))
	end

	return arg_9_0._viewBuildingUid, var_9_0
end

return var_0_0
