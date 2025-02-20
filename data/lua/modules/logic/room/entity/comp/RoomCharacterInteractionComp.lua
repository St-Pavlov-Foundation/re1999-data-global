module("modules.logic.room.entity.comp.RoomCharacterInteractionComp", package.seeall)

slot0 = class("RoomCharacterInteractionComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._faithFill = 0
	slot0.entity = slot1
	slot0._effectKeyResDict = {
		[RoomEnum.EffectKey.CharacterFaithMaxKey] = RoomScenePreloader.ResCharacterFaithMax,
		[RoomEnum.EffectKey.CharacterFaithFullKey] = RoomScenePreloader.ResCharacterFaithFull,
		[RoomEnum.EffectKey.CharacterFaithNormalKey] = RoomScenePreloader.ResCharacterFaithNormal,
		[RoomEnum.EffectKey.CharacterChatKey] = RoomScenePreloader.ResCharacterChat
	}
	slot0._showCameraStateDict = {
		[RoomEnum.CameraState.Normal] = true,
		[RoomEnum.CameraState.Overlook] = true
	}
	slot0._offsetX = 0
	slot0._offsetY = 0
	slot0._offsetZ = 0
	slot0._effectKeyInxDict = {}
	slot2 = 0

	for slot6, slot7 in pairs(slot0._effectKeyResDict) do
		slot0._effectKeyInxDict[slot6] = slot2
		slot2 = slot2 + 1
	end
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goTrs = slot1.transform
	slot0._scene = GameSceneMgr.instance:getCurScene()

	slot0:_refreshShowIcom()
end

function slot0.getMO(slot0)
	return slot0.entity:getMO()
end

function slot0.addEventListeners(slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, slot0._characterPositionChanged, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterInteractionUI, slot0.startCheckEventTask, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, slot0.startCheckEventTask, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterCanConfirm, slot0.startCheckEventTask, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, slot0.startCheckEventTask, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, slot0.startCheckEventTask, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraStateUpdate, slot0.startCheckEventTask, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, slot0._characterPositionChanged, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterInteractionUI, slot0.startCheckEventTask, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, slot0.startCheckEventTask, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterCanConfirm, slot0.startCheckEventTask, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, slot0.startCheckEventTask, slot0)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, slot0.startCheckEventTask, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraStateUpdate, slot0.startCheckEventTask, slot0)

	slot0._isHasCheckEventTask = false

	TaskDispatcher.cancelTask(slot0._onRunCheckEventTask, slot0)
end

function slot0._characterPositionChanged(slot0)
	if slot0._lastCameraState ~= slot0._scene.camera:getCameraState() then
		slot0._lastCameraState = slot1

		slot0:startCheckEventTask()
	end

	slot0:_updateParticlePosOffset()
end

function slot0.startCheckEventTask(slot0)
	if not slot0._isHasCheckEventTask then
		slot0._isHasCheckEventTask = true

		TaskDispatcher.runDelay(slot0._onRunCheckEventTask, slot0, 0.1)
	end
end

function slot0._onRunCheckEventTask(slot0)
	slot0._isHasCheckEventTask = false

	slot0:_refreshShowIcom()
end

function slot0._refreshShowIcom(slot0)
	slot0:_showByKey(slot0:_getShowEffectKey())
	slot0:_upateFaithFill()
end

function slot0._getShowEffectKey(slot0)
	if not RoomController.instance:isObMode() then
		return nil
	end

	if not slot0._showCameraStateDict[slot0._scene.camera:getCameraState()] or RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		return nil
	end

	if not slot0:getMO() or slot2:isTrainSourceState() then
		return
	end

	if RoomCharacterModel.instance:getTempCharacterMO() and slot3.id == slot2.id then
		if RoomCharacterController.instance:isCharacterFaithFull(slot2.heroId) then
			return RoomEnum.EffectKey.CharacterFaithMaxKey
		end

		return
	end

	if slot2:getCurrentInteractionId() then
		if not RoomCharacterController.instance:getPlayingInteractionParam() then
			return RoomEnum.EffectKey.CharacterChatKey
		end
	else
		if RoomCharacterController.instance:isCharacterFaithFull(slot2.heroId) then
			if RoomCharacterModel.instance:isShowFaithFull(slot2.heroId) then
				return RoomEnum.EffectKey.CharacterFaithMaxKey
			end

			return nil
		end

		if RoomCharacterHelper.getCharacterFaithFill(slot2) >= 1 then
			return RoomEnum.EffectKey.CharacterFaithFullKey
		elseif slot5 > 0 then
			slot0._faithFill = slot5

			return RoomEnum.EffectKey.CharacterFaithNormalKey
		end
	end
end

function slot0._showByKey(slot0, slot1)
	slot0._curShowKey = slot1
	slot2 = slot0.entity.effect

	for slot6, slot7 in pairs(slot0._effectKeyResDict) do
		slot2:setActiveByKey(slot6, slot1 == slot6)
	end

	if slot0._effectKeyResDict[slot1] and not slot2:isHasEffectGOByKey(slot1) then
		slot2:addParams({
			[slot1] = {
				res = slot0._effectKeyResDict[slot1]
			}
		})
		slot2:refreshEffect()
	end
end

function slot0._upateFaithFill(slot0)
	if slot0._isLastFaithFill == slot0._faithFill then
		return
	end

	if slot0.entity.effect:isHasEffectGOByKey(RoomEnum.EffectKey.CharacterFaithNormalKey) then
		slot0._isLastFaithFill = slot0._faithFill
		slot3 = slot0._scene.mapmgr:getPropertyBlock()

		slot3:Clear()
		slot3:SetVector("_UVOffset", Vector4.New(0, Mathf.Lerp(-0.53, -0.7, slot0._faithFill), 0, 0))

		slot8 = "_ParticlePosOffset"
		slot9 = Vector4.New

		slot3:SetVector(slot8, slot9(0, slot0._offsetY, 0, 0))

		for slot8, slot9 in ipairs(slot1:getComponentsByPath(RoomEnum.EffectKey.CharacterFaithNormalKey, RoomEnum.ComponentName.Renderer, "mesh/faith_process")) do
			slot9:SetPropertyBlock(slot3)
		end

		transformhelper.setLocalPos(slot1:getEffectGOTrs(RoomEnum.EffectKey.CharacterFaithNormalKey), slot0._offsetX, 0, slot0._offsetZ)
	end
end

function slot0._updateParticlePosOffset(slot0)
	if not slot0._effectKeyResDict[slot0._curShowKey] or not slot0.entity.effect:isHasEffectGOByKey(slot0._curShowKey) then
		return
	end

	if not slot0.entity.characterspine:getMountheadGOTrs() then
		return
	end

	slot3, slot4, slot5 = transformhelper.getPos(slot2)
	slot6, slot7, slot8 = transformhelper.getPos(slot0.entity.containerGOTrs)
	slot10 = slot4 - slot7 + 0.08
	slot11 = slot5 - slot8

	if 0.001 < math.abs(slot3 - slot6 - slot0._offsetX) or slot12 < math.abs(slot10 - slot0._offsetY) or slot12 < math.abs(slot11 - slot0._offsetZ) or slot0._lastInx ~= slot0._effectKeyInxDict[slot0._curShowKey] then
		slot0._offsetX = slot9
		slot0._offsetY = slot10
		slot0._offsetZ = slot11
		slot0._lastInx = slot0._effectKeyInxDict[slot0._curShowKey]

		transformhelper.setLocalPos(slot1:getEffectGOTrs(slot0._curShowKey), slot0._offsetX, 0, slot0._offsetZ)

		slot14 = slot0._scene.mapmgr:getPropertyBlock()

		slot14:Clear()

		slot18 = "_ParticlePosOffset"
		slot19 = Vector4.New

		slot14:SetVector(slot18, slot19(0, slot0._offsetY, 0, 0))

		for slot18, slot19 in ipairs(slot1:getComponentsByPath(slot0._curShowKey, RoomEnum.ComponentName.Renderer, "mesh")) do
			slot19:SetPropertyBlock(slot14)
		end

		if slot0._curShowKey == RoomEnum.EffectKey.CharacterFaithNormalKey then
			slot0._isLastFaithFill = -1

			slot0:_upateFaithFill()
		end
	end
end

return slot0
