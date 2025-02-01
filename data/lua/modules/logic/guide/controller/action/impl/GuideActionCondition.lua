module("modules.logic.guide.controller.action.impl.GuideActionCondition", package.seeall)

slot0 = class("GuideActionCondition", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot4 = tonumber(slot2[2])
	slot8 = GuideModel.instance:getById(slot0.guideId)

	if slot0[slot2[1]] and slot7(slot0, slot2[4]) then
		if slot8 then
			slot8.currStepId = tonumber(slot2[3]) - 1
		end
	elseif slot8 then
		slot8.currStepId = slot4 - 1
	end

	slot0:onDone(true)
end

function slot0.checkRoomTransport(slot0)
	slot1 = false

	for slot6, slot7 in ipairs(RoomModel.instance:getBuildingInfoList()) do
		if RoomConfig.instance:getBuildingConfig(slot7.buildingId) and slot8.buildingType == RoomBuildingEnum.BuildingType.Collect and slot7.use then
			slot1 = true

			break
		end
	end

	if not slot1 then
		return false
	end

	slot1 = false

	for slot6, slot7 in ipairs(slot2) do
		if RoomConfig.instance:getBuildingConfig(slot7.buildingId) and slot8.buildingType == RoomBuildingEnum.BuildingType.Process and slot7.use then
			slot1 = true

			break
		end
	end

	return slot1
end

function slot0.checkRoomTaskHasFinished(slot0)
	slot1, slot2 = RoomSceneTaskController.instance:isFirstTaskFinished()

	return slot1
end

return slot0
