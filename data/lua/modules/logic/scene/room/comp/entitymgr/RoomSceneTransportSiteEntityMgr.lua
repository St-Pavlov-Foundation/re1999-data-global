module("modules.logic.scene.room.comp.entitymgr.RoomSceneTransportSiteEntityMgr", package.seeall)

slot0 = class("RoomSceneTransportSiteEntityMgr", BaseSceneUnitMgr)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0:_addEvents()

	slot0._scene = slot0:getCurScene()

	slot0:refreshAllSiteEntity()
end

function slot0.onSwitchMode(slot0)
	slot0:refreshAllSiteEntity()
end

function slot0._addEvents(slot0)
	if slot0._isInitAddEvent then
		return
	end

	slot0._isInitAddEvent = true

	RoomMapController.instance:registerCallback(RoomEvent.TransportPathLineChanged, slot0.refreshAllSiteEntity, slot0)
end

function slot0._removeEvents(slot0)
	if not slot0._isInitAddEvent then
		return
	end

	slot0._isInitAddEvent = false

	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathLineChanged, slot0.refreshAllSiteEntity, slot0)
end

function slot0.refreshAllSiteEntity(slot0)
	for slot5 = 1, #RoomTransportHelper.getSiteBuildingTypeList() do
		slot6 = slot1[slot5]
		slot8 = slot0:getSiteEntity(slot6)

		if RoomMapTransportPathModel.instance:getSiteHexPointByType(slot6) then
			if slot8 then
				slot0:moveToHexPoint(slot8, slot7)
			else
				slot8 = slot0:spawnRoomTransportSite(slot6, slot7)
			end

			slot8:refreshBuilding()
		elseif slot8 then
			slot0:destroySiteEntity(slot8)
		end
	end
end

function slot0.spawnRoomTransportSite(slot0, slot1, slot2)
	slot3 = slot0._scene.go.buildingRoot
	slot4 = gohelper.create3d(slot3, string.format("site_%s", slot1))
	slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, RoomTransportSiteEntity, slot1)

	slot0:addUnit(slot5)
	gohelper.addChild(slot3, slot4)
	slot0:moveToHexPoint(slot5, slot2)

	return slot5
end

function slot0.moveToHexPoint(slot0, slot1, slot2)
	if slot1 and slot2 then
		slot3, slot4 = HexMath.hexXYToPosXY(slot2.x, slot2.y, RoomBlockEnum.BlockSize)

		slot1:setLocalPos(slot3, 0, slot4)
	end
end

function slot0.moveTo(slot0, slot1, slot2)
	slot1:setLocalPos(slot2.x, slot2.y, slot2.z)
end

function slot0.destroySiteEntity(slot0, slot1)
	slot0:removeUnit(slot1:getTag(), slot1.id)
end

function slot0.getSiteEntity(slot0, slot1)
	return slot0:getUnit(RoomTransportSiteEntity:getTag(), slot1)
end

function slot0.getRoomSiteEntityDict(slot0)
	return slot0._tagUnitDict[RoomTransportSiteEntity:getTag()] or {}
end

function slot0._onUpdate(slot0)
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)
	slot0:_removeEvents()
end

return slot0
