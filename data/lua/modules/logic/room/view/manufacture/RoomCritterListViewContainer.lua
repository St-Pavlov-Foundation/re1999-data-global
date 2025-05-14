module("modules.logic.room.view.manufacture.RoomCritterListViewContainer", package.seeall)

local var_0_0 = class("RoomCritterListViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_critter/#scroll_critter"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#go_critter/#scroll_critter/viewport/content/#go_critterItem"
	var_1_1.cellClass = RoomManufactureCritterItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 648
	var_1_1.cellHeight = 175
	var_1_1.cellSpaceV = 10

	table.insert(var_1_0, LuaListScrollView.New(ManufactureCritterListModel.instance, var_1_1))
	table.insert(var_1_0, RoomCritterListView.New())

	return var_1_0
end

function var_0_0.onContainerInit(arg_2_0)
	local var_2_0
	local var_2_1

	if arg_2_0.viewParam then
		var_2_1 = arg_2_0.viewParam.buildingUid
		var_2_0 = arg_2_0.viewParam.pathId
	end

	if not var_2_1 and not var_2_0 then
		logError("RoomCritterListViewContainer:onContainerInit,error, no buildingUid and no pathId")
	end

	arg_2_0:setContainerViewBelongId(var_2_1, var_2_0)
end

function var_0_0.onContainerClose(arg_3_0)
	arg_3_0:setContainerViewBelongId()
end

function var_0_0.setContainerViewBelongId(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._isTransport = false

	if not arg_4_1 and arg_4_2 then
		arg_4_0._isTransport = true
	end

	arg_4_0._viewBelongId = arg_4_1 or arg_4_2
end

function var_0_0.getContainerPathId(arg_5_0)
	if arg_5_0._isTransport then
		return arg_5_0._viewBelongId
	end
end

function var_0_0.getContainerViewBuilding(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1
	local var_6_2

	if arg_6_0._isTransport then
		local var_6_3 = RoomMapTransportPathModel.instance:getTransportPathMO(arg_6_0._viewBelongId)

		var_6_0 = var_6_3 and var_6_3.buildingUid
		var_6_2 = var_6_3 and var_6_3.buildingId
	else
		var_6_0 = arg_6_0._viewBelongId
		var_6_1 = RoomMapBuildingModel.instance:getBuildingMOById(var_6_0)
		var_6_2 = var_6_1 and var_6_1.buildingId
	end

	if not var_6_1 and arg_6_1 then
		logError(string.format("RoomCritterListViewContainer:getContainerViewBuilding error, buildingMO is nil, id:%s  isTransport:%s", arg_6_0._viewBelongId, arg_6_0._isTransport))
	end

	return var_6_0, var_6_1, var_6_2
end

return var_0_0
