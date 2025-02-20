module("modules.logic.room.entity.comp.RoomCritterEventItemComp", package.seeall)

slot0 = class("RoomCritterEventItemComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._faithFill = 0
	slot0.entity = slot1
	slot0._eventType2ResDict = {
		[CritterEnum.CritterItemEventType.HasTrainEvent] = RoomScenePreloader.ResCritterEvent.HasTrainEvent,
		[CritterEnum.CritterItemEventType.TrainEventComplete] = RoomScenePreloader.ResCritterEvent.TrainEventComplete,
		[CritterEnum.CritterItemEventType.NoMoodWork] = RoomScenePreloader.ResCritterEvent.NoMoodWork,
		[CritterEnum.CritterItemEventType.SurpriseCollect] = RoomScenePreloader.ResCritterEvent.SurpriseCollect
	}
	slot0._showCameraStateDict = {
		[RoomEnum.CameraState.Normal] = true,
		[RoomEnum.CameraState.Overlook] = true
	}
	slot0._offsetX = 0
	slot0._offsetY = 0
	slot0._offsetZ = 0
	slot0._eventType2SkowKeyDict = {}
	slot2 = 0

	for slot6, slot7 in pairs(slot0._eventType2ResDict) do
		slot0._eventType2SkowKeyDict[slot6] = "critter_event_" .. slot6
	end
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goTrs = slot1.transform
	slot0._scene = GameSceneMgr.instance:getCurScene()

	slot0:startCheckTrainEventTask()
end

function slot0.getMO(slot0)
	return slot0.entity:getMO()
end

function slot0.addEventListeners(slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, slot0._characterPositionChanged, slot0)
	CritterController.instance:registerCallback(CritterEvent.CritterInfoPushReply, slot0.startCheckTrainEventTask, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, slot0.startCheckTrainEventTask, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraStateUpdate, slot0.startCheckTrainEventTask, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, slot0._characterPositionChanged, slot0)
	CritterController.instance:unregisterCallback(CritterEvent.CritterInfoPushReply, slot0.startCheckTrainEventTask, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, slot0.startCheckTrainEventTask, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraStateUpdate, slot0.startCheckTrainEventTask, slot0)
	TaskDispatcher.cancelTask(slot0._onRunCheckTrainEventTask, slot0)

	slot0._isHasCheckTrainEventTask = false
end

function slot0._characterPositionChanged(slot0)
	if slot0._lastCameraState ~= slot0._scene.camera:getCameraState() then
		slot0._lastCameraState = slot1

		slot0:startCheckTrainEventTask()
	end

	slot0:_updateParticlePosOffset()
end

function slot0._refreshShowIcom(slot0)
	slot0:_showByEventType(slot0:_getShowEventType())
end

function slot0.startCheckTrainEventTask(slot0)
	if not slot0._isHasCheckTrainEventTask then
		slot0._isHasCheckTrainEventTask = true

		TaskDispatcher.runDelay(slot0._onRunCheckTrainEventTask, slot0, 0.1)
	end
end

function slot0._onRunCheckTrainEventTask(slot0)
	slot0._isHasCheckTrainEventTask = false

	slot0:_refreshShowIcom()
end

function slot0._getShowEventType(slot0)
	if not RoomController.instance:isObMode() then
		return nil
	end

	if not slot0._showCameraStateDict[slot0._scene.camera:getCameraState()] or RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		return nil
	end

	return CritterHelper.getEventTypeByCritterMO(CritterModel.instance:getCritterMOByUid(slot0.entity.id))
end

function slot0._showByEventType(slot0, slot1)
	slot0._curShowEventType = slot1
	slot2 = slot0.entity.effect

	for slot6, slot7 in pairs(slot0._eventType2SkowKeyDict) do
		slot2:setActiveByKey(slot7, slot6 == slot1)
	end

	slot3 = slot0._eventType2SkowKeyDict[slot1]

	if slot0._eventType2ResDict[slot1] and not slot2:isHasEffectGOByKey(slot3) then
		slot2:addParams({
			[slot3] = {
				res = slot0._eventType2ResDict[slot1]
			}
		})
		slot2:refreshEffect()
	end
end

function slot0._updateParticlePosOffset(slot0)
	if not slot0._eventType2SkowKeyDict[slot0._curShowEventType] or not slot0.entity.effect:isHasEffectGOByKey(slot2) then
		return
	end

	if not slot0.entity.critterspine:getMountheadGOTrs() then
		return
	end

	slot4, slot5, slot6 = transformhelper.getPos(slot3)
	slot7, slot8, slot9 = transformhelper.getPos(slot0.entity.containerGOTrs)
	slot11 = slot5 - slot8 + 0.08
	slot12 = slot6 - slot9

	if 0.001 < math.abs(slot4 - slot7 - slot0._offsetX) or slot13 < math.abs(slot11 - slot0._offsetY) or slot13 < math.abs(slot12 - slot0._offsetZ) or slot0._lastInx ~= slot0._curShowEventType then
		slot0._offsetX = slot10
		slot0._offsetY = slot11
		slot0._offsetZ = slot12
		slot0._lastInx = slot0._curShowEventType

		transformhelper.setLocalPos(slot1:getEffectGOTrs(slot2), slot0._offsetX, 0, slot0._offsetZ)

		slot15 = slot0._scene.mapmgr:getPropertyBlock()

		slot15:Clear()

		slot19 = "_ParticlePosOffset"
		slot20 = Vector4.New

		slot15:SetVector(slot19, slot20(0, slot0._offsetY, 0, 0))

		for slot19, slot20 in ipairs(slot1:getComponentsByKey(slot2, RoomEnum.ComponentName.Renderer)) do
			slot20:SetPropertyBlock(slot15)
		end
	end
end

return slot0
