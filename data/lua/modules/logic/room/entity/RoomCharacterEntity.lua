module("modules.logic.room.entity.RoomCharacterEntity", package.seeall)

slot0 = class("RoomCharacterEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.id = slot1
	slot0.entityId = slot0.id
end

function slot0.getTag(slot0)
	return SceneTag.RoomCharacter
end

function slot0.init(slot0, slot1)
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = slot0.containerGO
	slot0.containerGOTrs = slot0.containerGO.transform
	slot0.goTrs = slot1.transform

	uv0.super.init(slot0, slot1)

	slot0._scene = GameSceneMgr.instance:getCurScene()

	if RoomController.instance:isObMode() then
		slot0.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				res = RoomScenePreloader.ResCharacterClickHelper
			}
		})
		slot0.effect:refreshEffect()
	end

	slot0.isPressing = false
end

function slot0.initComponents(slot0)
	slot0:addComp("characterspineeffect", RoomCharacterSpineEffectComp)
	slot0:addComp("characterspine", RoomCharacterSpineComp)
	slot0:addComp("followPathComp", RoomCharacterFollowPathComp)
	slot0:addComp("charactermove", RoomCharacterMoveComp)
	slot0:addComp("effect", RoomEffectComp)
	slot0:addComp("birthday", RoomCharacterBirthdayComp)

	if RoomController.instance:isObMode() then
		slot0:addComp("collider", RoomColliderComp)
	end

	if not RoomEnum.IsShowUICharacterInteraction then
		slot0:addComp("characterinterac", RoomCharacterInteractionComp)
	end

	if slot0:getMO() and not slot1:getCanWade() then
		slot0:addComp("characterfootprint", RoomCharacterFootPrintComp)
	end

	slot0:addComp("cameraFollowTargetComp", RoomCameraFollowTargetComp)
	slot0:addComp("interactActionComp", RoomCharacterInteractActionComp)
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
end

function slot0.setLocalPos(slot0, slot1, slot2, slot3, slot4)
	if slot0._tweenId then
		slot0._scene.tween:killById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot4 then
		slot5, slot6, slot7 = transformhelper.getLocalPos(slot0.goTrs)
		slot0._tweenId = slot0._scene.tween:tweenFloat(0, 1, 0.05, slot0._frameCallback, slot0._finishCallback, slot0, {
			originalX = slot5,
			originalY = slot6,
			originalZ = slot7,
			x = slot1,
			y = slot2,
			z = slot3
		})
	else
		transformhelper.setLocalPos(slot0.goTrs, slot1, slot2, slot3)
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterPositionChanged, slot0:getMO().id)

	if slot0.characterspine then
		slot0.characterspine:characterPosChanged()
	end
end

function slot0.getLocalPosXYZ(slot0)
	return transformhelper.getLocalPos(slot0.goTrs)
end

function slot0._frameCallback(slot0, slot1, slot2)
	transformhelper.setLocalPos(slot0.goTrs, slot2.originalX + (slot2.x - slot2.originalX) * slot1, slot2.originalY + (slot2.y - slot2.originalY) * slot1, slot2.originalZ + (slot2.z - slot2.originalZ) * slot1)
end

function slot0._finishCallback(slot0, slot1)
	transformhelper.setLocalPos(slot0.goTrs, slot1.x, slot1.y, slot1.z)
end

function slot0._getCharacterRes(slot0)
	return RoomResHelper.getCharacterPath(slot0:getMO().skinId)
end

function slot0.beforeDestroy(slot0)
	if slot0._tweenId then
		slot0._scene.tween:killById(slot0._tweenId)

		slot0._tweenId = nil
	end

	TaskDispatcher.cancelTask(slot0._pressingEffectDelayDestroy, slot0)
	uv0.super.beforeDestroy(slot0)
end

function slot0.playConfirmEffect(slot0)
	slot0.effect:addParams({
		[RoomEnum.EffectKey.ConfirmCharacterEffectKey] = {
			res = RoomScenePreloader.ResEffectConfirmCharacter,
			containerGO = slot0.staticContainerGO
		}
	}, 2)
	slot0.effect:refreshEffect()
end

function slot0.playClickEffect(slot0)
	slot0.effect:addParams({
		[RoomEnum.EffectKey.ConfirmCharacterEffectKey] = {
			res = RoomScenePreloader.ResCharacterClickEffect,
			containerGO = slot0.staticContainerGO
		}
	}, 1)
	slot0.effect:refreshEffect()
end

function slot0.tweenUp(slot0)
	TaskDispatcher.cancelTask(slot0._pressingEffectDelayDestroy, slot0)

	slot0.isPressing = true

	slot0.characterspine:updateAlpha()
	slot0.effect:addParams({
		[RoomEnum.EffectKey.PressingEffectKey] = {
			res = RoomScenePreloader.ResEffectPressingCharacter,
			containerGO = slot0.staticContainerGO
		}
	})
	slot0.effect:refreshEffect()

	if slot0.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey) and slot1:GetComponent(typeof(UnityEngine.Animator)) then
		slot2:Play("open", 0, 0)
	end

	if slot0.characterspine then
		slot0.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "up")
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_drag)
end

function slot0.tweenDown(slot0)
	slot0.isPressing = false

	slot0.characterspine:updateAlpha()

	if slot0.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey) and slot1:GetComponent(typeof(UnityEngine.Animator)) then
		slot2:Play("close", 0, 0)
	end

	if slot0.characterspine then
		slot0.characterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "down", 0, slot0._downDone, slot0)
	end

	TaskDispatcher.runDelay(slot0._pressingEffectDelayDestroy, slot0, 2)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_put)
end

function slot0._downDone(slot0)
	if slot0.characterspine then
		slot0.characterspine:clearAnim()
	end
end

function slot0._pressingEffectDelayDestroy(slot0)
	slot0.effect:removeParams({
		RoomEnum.EffectKey.PressingEffectKey
	})
	slot0.effect:refreshEffect()
end

function slot0.playFaithEffect(slot0)
	if not slot0.characterspine:getCharacterGO() then
		return
	end

	slot0.effect:addParams({
		[RoomEnum.EffectKey.FaithEffectKey] = {
			res = RoomScenePreloader.ResCharacterFaithEffect,
			containerGO = slot0.staticContainerGO
		}
	}, 1.8)
	slot0.effect:refreshEffect()
end

function slot0.getMO(slot0)
	slot0._mo = RoomCharacterModel.instance:getCharacterMOById(slot0.id) or slot0._mo

	return slot0._mo
end

return slot0
