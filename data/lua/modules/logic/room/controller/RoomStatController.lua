module("modules.logic.room.controller.RoomStatController", package.seeall)

slot0 = class("RoomStatController", BaseController)

function slot0.blockOp(slot0, slot1, slot2)
	if not slot1 or #slot1 < 1 then
		return
	end

	slot3 = {}

	for slot8 = 1, #slot1 do
		if RoomConfig.instance:getPackageConfigByBlockId(slot1[slot8]) then
			table.insert(slot3, slot9.name)
		end
	end

	StatController.instance:track(StatEnum.EventName.RoomOperatingPlot, {
		[StatEnum.EventProperties.RoomPivotLevel] = RoomModel.instance:getRoomLevel() or 0,
		[StatEnum.EventProperties.RoomOperationType] = slot2 and luaLang("datatrack_room_place_block") or luaLang("datatrack_room_back_block"),
		[StatEnum.EventProperties.RoomPlotbag] = slot3
	})
end

function slot0.oneKeyDispatch(slot0, slot1, slot2)
	StatController.instance:track(StatEnum.EventName.RoomManuAutoDispatch, {
		[StatEnum.EventProperties.RoomDispatchType] = slot1 and "critter" or "manu",
		[StatEnum.EventProperties.RoomDispatchSubType] = slot2
	})
end

function slot0.switchUpdateRecordTime(slot0)
	slot0._switchRecordTime = Time.realtimeSinceStartup
end

function slot0.roomTransportCameraSwitch(slot0, slot1, slot2, slot3)
	StatController.instance:track(StatEnum.EventName.RoomTransportCameraSwitch, {
		[StatEnum.EventProperties.IsOnePerson] = slot1,
		[StatEnum.EventProperties.SpendTime] = Time.realtimeSinceStartup - slot0._switchRecordTime,
		[StatEnum.EventProperties.RoadInfoBefore] = {
			slot0:getRoadInfo(slot2)
		},
		[StatEnum.EventProperties.RoadInfo] = {
			slot0:getRoadInfo(slot3)
		}
	})
	slot0:switchUpdateRecordTime()
end

function slot0.startOpenTransportSiteView(slot0)
	slot0:switchUpdateRecordTime()

	slot0._openTransportSiteViewTime = Time.realtimeSinceStartup
end

function slot0.closeTransportSiteView(slot0, slot1)
	if not slot0._openTransportSiteViewTime or not slot1 then
		return
	end

	StatController.instance:track(StatEnum.EventName.RoomTransportCameraLeave, {
		[StatEnum.EventProperties.SpendTime] = Time.realtimeSinceStartup - slot0._openTransportSiteViewTime,
		[StatEnum.EventProperties.RoadInfo] = {
			slot0:getRoadInfo(slot1)
		}
	})

	slot0._openTransportSiteViewTime = nil
end

function slot0.roomRoadEditView(slot0)
	slot0._openTransportPathViewTime = Time.realtimeSinceStartup

	StatController.instance:track(StatEnum.EventName.RoomRoadEditView)
end

function slot0.roomRoadEditClose(slot0)
	if not slot0._openTransportPathViewTime then
		return
	end

	slot1 = Time.realtimeSinceStartup - slot0._openTransportPathViewTime

	for slot7, slot8 in ipairs(RoomTransportHelper.getPathBuildingTypesList()) do
		if not (RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot8[1], slot8[2]) and slot11:isLinkFinish()) then
			table.insert({}, RoomTransportPathEnum.TipLang[RoomTransportHelper.fromTo2SiteType(slot9, slot10)])
		end
	end

	slot4 = {}

	for slot9, slot10 in ipairs(RoomMapTransportPathModel.instance:getTransportPathMOList()) do
		table.insert(slot4, slot0:getRoadInfo(slot10))
	end

	StatController.instance:track(StatEnum.EventName.RoomRoadEditClose, {
		[StatEnum.EventProperties.SpendTime] = slot1,
		[StatEnum.EventProperties.TipList] = slot2,
		[StatEnum.EventProperties.RoadInfo] = slot4
	})

	slot0._openTransportPathViewTime = nil
end

function slot0.getRoadInfo(slot0, slot1)
	if not slot1 then
		return
	end

	return {
		id = slot1.id,
		length = slot1:getHexPointCount(),
		vehicle = slot1.buildingId,
		vehicleSkinId = slot1.buildingSkinId,
		from = slot1.fromType,
		to = slot1.toType,
		is_auto = RoomTransportHelper.getIsQuickLink(RoomTransportHelper.fromTo2SiteType(slot1.fromType, slot1.toType))
	}
end

function slot0.roomInteractBuildingInvite(slot0, slot1, slot2)
	slot3 = {}

	tabletool.addValues(slot3, slot2)
	StatController.instance:track(StatEnum.EventName.RoomInteractBuildingInvite, {
		[StatEnum.EventProperties.BuildingId] = slot1,
		[StatEnum.EventProperties.HeroList] = slot3
	})
end

function slot0.critterBookBgSwitch(slot0, slot1, slot2)
	StatController.instance:track(StatEnum.EventName.CritterBookBgSwitch, {
		[StatEnum.EventProperties.CritterBookId] = slot1,
		[StatEnum.EventProperties.CritterBookBg] = slot2
	})
end

slot0.instance = slot0.New()

return slot0
