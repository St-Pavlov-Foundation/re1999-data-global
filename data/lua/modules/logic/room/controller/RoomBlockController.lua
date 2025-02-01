module("modules.logic.room.controller.RoomBlockController", package.seeall)

slot0 = class("RoomBlockController", BaseController)

function slot0.onInit(slot0)
	slot0._lastUpdatePathGraphicTimeDic = {}

	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
end

function slot0.refreshResourceLight(slot0)
	slot1 = slot0:_isHasResourceLight()

	if slot0._isLastHasResourceLight or slot1 then
		slot0._isLastHasResourceLight = slot1

		RoomMapController.instance:dispatchEvent(RoomEvent.ResourceLight)
	end
end

function slot0._isHasResourceLight(slot0)
	if RoomMapBlockModel.instance:getTempBlockMO() and slot1:isHasLight() then
		slot3 = slot1.hexPoint

		for slot7 = 1, 6 do
			if RoomResourceModel.instance:isLightResourcePoint(slot3.x, slot3.y, slot7) then
				return true
			end
		end
	end

	return false
end

function slot0.refreshNearLand(slot0, slot1, slot2)
	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntity(false, slot1, 1, slot2, false), "refreshLand")
	RoomBlockHelper.refreshBlockEntity(RoomBlockHelper.getNearBlockEntity(true, slot1, 1, slot2, true), "refreshWaveEffect")
end

function slot0.refreshBackBuildingEffect(slot0)
	if not slot0._ishasWaitBlockBuildingEffect then
		slot0._ishasWaitBlockBuildingEffect = true

		TaskDispatcher.runDelay(slot0._onRefreshBackBuildingEffect, slot0, 0.01)
	end
end

function slot0._onRefreshBackBuildingEffect(slot0)
	slot0._ishasWaitBlockBuildingEffect = false

	for slot6 = 1, #RoomMapBlockModel.instance:getFullBlockMOList() do
		if GameSceneMgr.instance:getCurScene().mapmgr:getBlockEntity(slot1[slot6].id, SceneTag.RoomMapBlock) then
			slot8:refreshBackBuildingEffect(slot7)
		end
	end
end

slot0.instance = slot0.New()

return slot0
