module("modules.logic.guide.controller.action.impl.GuideActionRoomFocusBlockBuildingPut", package.seeall)

slot0 = class("GuideActionRoomFocusBlockBuildingPut", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = slot0.actionParam and string.splitToNumber(slot0.actionParam, "#")
	slot3 = slot2[1]

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		if slot3 < 100 then
			slot0:focusByBuildingType(slot3, slot2[2] or 0, slot2[3] or 0)
		else
			slot0:focusByBuildingId(slot3, slot4, slot5)
		end
	else
		logError("不在小屋场景，指引失败 " .. slot0.guideId .. "_" .. slot0.stepId)
		slot0:onDone(true)
	end
end

function slot0.focusByBuildingType(slot0, slot1, slot2, slot3)
	slot5 = nil

	if RoomMapBuildingModel.instance:getBuildingListByType(slot1) then
		for slot9, slot10 in ipairs(slot4) do
			if slot10:isInMap() then
				slot5 = slot10.hexPoint
				slot12 = GameSceneMgr.instance:getCurScene().buildingmgr and slot11.buildingmgr:getBuildingEntity(slot10.id, SceneTag.RoomBuilding)

				GuideModel.instance:setNextStepGOPath(slot0.guideId, slot0.stepId, slot12 and SLFramework.GameObjectHelper.GetPath(slot12.go))

				break
			end
		end
	end

	slot0:_focusByPoint(slot5, slot2, slot3)
end

function slot0.focusByBuildingId(slot0, slot1, slot2, slot3)
	slot5 = nil

	slot0:_focusByPoint((not RoomMapBuildingModel.instance:getBuildingMoByBuildingId(slot1) or not slot4:isInMap() or slot4.hexPoint) and RoomBuildingHelper.getRecommendHexPoint(slot1, nil, , , slot0:getNearRotate(slot1)) and slot7.hexPoint, slot2, slot3)
end

function slot0._focusByPoint(slot0, slot1, slot2, slot3)
	if slot1 then
		slot4 = HexMath.hexToPosition(slot1, RoomBlockEnum.BlockSize)

		GameSceneMgr.instance:getCurScene().camera:tweenCamera({
			focusX = slot4.x + slot2,
			focusY = slot4.y + slot3
		})
		TaskDispatcher.runDelay(slot0._onDone, slot0, 0.7)
	else
		slot0:onDone(true)
	end
end

function slot0._onDone(slot0, slot1)
	slot0:onDone(true)
end

function slot0.getNearRotate(slot0, slot1)
	return RoomRotateHelper.getCameraNearRotate(RoomCameraController.instance:getRoomScene().camera:getCameraRotate() * Mathf.Rad2Deg) + RoomConfig.instance:getBuildingConfig(slot1).rotate
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._onDone, slot0)
end

return slot0
