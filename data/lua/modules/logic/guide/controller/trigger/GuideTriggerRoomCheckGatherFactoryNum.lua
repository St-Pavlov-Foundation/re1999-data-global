module("modules.logic.guide.controller.trigger.GuideTriggerRoomCheckGatherFactoryNum", package.seeall)

slot0 = class("GuideTriggerRoomCheckGatherFactoryNum", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterOneSceneFinish, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.UseBuildingReply, slot0._onUseBuildingReply, slot0)
end

function slot0._onUseBuildingReply(slot0)
	slot0:checkStartGuide(SceneType.Room)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	if slot1 ~= SceneType.Room or not RoomController.instance:isObMode() then
		return
	end

	for slot10, slot11 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if slot11.config.buildingType == RoomBuildingEnum.BuildingType.Gather and slot11.buildingState == RoomBuildingEnum.BuildingState.Map then
			slot6 = 0 + 1
		end
	end

	return slot6 >= 4
end

function slot0._onEnterOneSceneFinish(slot0, slot1, slot2)
	slot0:checkStartGuide(slot1)
end

return slot0
