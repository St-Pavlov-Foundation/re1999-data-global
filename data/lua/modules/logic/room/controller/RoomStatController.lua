module("modules.logic.room.controller.RoomStatController", package.seeall)

local var_0_0 = class("RoomStatController", BaseController)

function var_0_0.blockOp(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_1 or #arg_1_1 < 1 then
		return
	end

	local var_1_0 = {}
	local var_1_1 = RoomConfig.instance

	for iter_1_0 = 1, #arg_1_1 do
		local var_1_2 = var_1_1:getPackageConfigByBlockId(arg_1_1[iter_1_0])

		if var_1_2 then
			table.insert(var_1_0, var_1_2.name)
		end
	end

	StatController.instance:track(StatEnum.EventName.RoomOperatingPlot, {
		[StatEnum.EventProperties.RoomPivotLevel] = RoomModel.instance:getRoomLevel() or 0,
		[StatEnum.EventProperties.RoomOperationType] = arg_1_2 and luaLang("datatrack_room_place_block") or luaLang("datatrack_room_back_block"),
		[StatEnum.EventProperties.RoomPlotbag] = var_1_0
	})
end

function var_0_0.oneKeyDispatch(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 and "critter" or "manu"

	StatController.instance:track(StatEnum.EventName.RoomManuAutoDispatch, {
		[StatEnum.EventProperties.RoomDispatchType] = var_2_0,
		[StatEnum.EventProperties.RoomDispatchSubType] = arg_2_2
	})
end

function var_0_0.switchUpdateRecordTime(arg_3_0)
	arg_3_0._switchRecordTime = Time.realtimeSinceStartup
end

function var_0_0.roomTransportCameraSwitch(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = Time.realtimeSinceStartup - arg_4_0._switchRecordTime
	local var_4_1 = arg_4_0:getRoadInfo(arg_4_3)
	local var_4_2 = arg_4_0:getRoadInfo(arg_4_2)
	local var_4_3 = {
		var_4_2
	}
	local var_4_4 = {
		var_4_1
	}

	StatController.instance:track(StatEnum.EventName.RoomTransportCameraSwitch, {
		[StatEnum.EventProperties.IsOnePerson] = arg_4_1,
		[StatEnum.EventProperties.SpendTime] = var_4_0,
		[StatEnum.EventProperties.RoadInfoBefore] = var_4_3,
		[StatEnum.EventProperties.RoadInfo] = var_4_4
	})
	arg_4_0:switchUpdateRecordTime()
end

function var_0_0.startOpenTransportSiteView(arg_5_0)
	arg_5_0:switchUpdateRecordTime()

	arg_5_0._openTransportSiteViewTime = Time.realtimeSinceStartup
end

function var_0_0.closeTransportSiteView(arg_6_0, arg_6_1)
	if not arg_6_0._openTransportSiteViewTime or not arg_6_1 then
		return
	end

	local var_6_0 = Time.realtimeSinceStartup - arg_6_0._openTransportSiteViewTime
	local var_6_1 = arg_6_0:getRoadInfo(arg_6_1)
	local var_6_2 = {
		var_6_1
	}

	StatController.instance:track(StatEnum.EventName.RoomTransportCameraLeave, {
		[StatEnum.EventProperties.SpendTime] = var_6_0,
		[StatEnum.EventProperties.RoadInfo] = var_6_2
	})

	arg_6_0._openTransportSiteViewTime = nil
end

function var_0_0.roomRoadEditView(arg_7_0)
	arg_7_0._openTransportPathViewTime = Time.realtimeSinceStartup

	StatController.instance:track(StatEnum.EventName.RoomRoadEditView)
end

function var_0_0.roomRoadEditClose(arg_8_0)
	if not arg_8_0._openTransportPathViewTime then
		return
	end

	local var_8_0 = Time.realtimeSinceStartup - arg_8_0._openTransportPathViewTime
	local var_8_1 = {}
	local var_8_2 = RoomTransportHelper.getPathBuildingTypesList()

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_3 = iter_8_1[1]
		local var_8_4 = iter_8_1[2]
		local var_8_5 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(var_8_3, var_8_4)

		if not (var_8_5 and var_8_5:isLinkFinish()) then
			local var_8_6 = RoomTransportHelper.fromTo2SiteType(var_8_3, var_8_4)
			local var_8_7 = RoomTransportPathEnum.TipLang[var_8_6]

			table.insert(var_8_1, var_8_7)
		end
	end

	local var_8_8 = {}
	local var_8_9 = RoomMapTransportPathModel.instance:getTransportPathMOList()

	for iter_8_2, iter_8_3 in ipairs(var_8_9) do
		local var_8_10 = arg_8_0:getRoadInfo(iter_8_3)

		table.insert(var_8_8, var_8_10)
	end

	StatController.instance:track(StatEnum.EventName.RoomRoadEditClose, {
		[StatEnum.EventProperties.SpendTime] = var_8_0,
		[StatEnum.EventProperties.TipList] = var_8_1,
		[StatEnum.EventProperties.RoadInfo] = var_8_8
	})

	arg_8_0._openTransportPathViewTime = nil
end

function var_0_0.getRoadInfo(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = RoomTransportHelper.fromTo2SiteType(arg_9_1.fromType, arg_9_1.toType)

	return {
		id = arg_9_1.id,
		length = arg_9_1:getHexPointCount(),
		vehicle = arg_9_1.buildingId,
		vehicleSkinId = arg_9_1.buildingSkinId,
		from = arg_9_1.fromType,
		to = arg_9_1.toType,
		is_auto = RoomTransportHelper.getIsQuickLink(var_9_0)
	}
end

function var_0_0.roomInteractBuildingInvite(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	tabletool.addValues(var_10_0, arg_10_2)
	StatController.instance:track(StatEnum.EventName.RoomInteractBuildingInvite, {
		[StatEnum.EventProperties.BuildingId] = arg_10_1,
		[StatEnum.EventProperties.HeroList] = var_10_0
	})
end

function var_0_0.critterBookBgSwitch(arg_11_0, arg_11_1, arg_11_2)
	StatController.instance:track(StatEnum.EventName.CritterBookBgSwitch, {
		[StatEnum.EventProperties.CritterBookId] = arg_11_1,
		[StatEnum.EventProperties.CritterBookBg] = arg_11_2
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
