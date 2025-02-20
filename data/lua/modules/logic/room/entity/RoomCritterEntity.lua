module("modules.logic.room.entity.RoomCritterEntity", package.seeall)

slot0 = class("RoomCritterEntity", RoomBaseEntity)

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
	slot0.__willDestroy = false
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", RoomEffectComp)
	slot0:addComp("critterspineeffect", RoomCritterSpineEffectComp)
	slot0:addComp("critterspine", RoomCritterSpineComp)
	slot0:addComp("critterfollower", RoomCritterFollowerComp)

	if RoomController.instance:isObMode() then
		slot0:addComp("collider", RoomColliderComp)
	end

	slot0:addComp("eventiconComp", RoomCritterEventItemComp)
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
		slot5 = slot0.go.transform.localPosition
		slot0._tweenId = slot0._scene.tween:tweenFloat(0, 1, 0.05, slot0._frameCallback, slot0._finishCallback, slot0, {
			originalX = slot5.x,
			originalY = slot5.y,
			originalZ = slot5.z,
			x = slot1,
			y = slot2,
			z = slot3
		})
	else
		transformhelper.setLocalPos(slot0.go.transform, slot1, slot2, slot3)
	end

	if slot0.critterspine then
		slot0.critterspine:characterPosChanged()
	end
end

function slot0._frameCallback(slot0, slot1, slot2)
	transformhelper.setLocalPos(slot0.go.transform, slot2.originalX + (slot2.x - slot2.originalX) * slot1, slot2.originalY + (slot2.y - slot2.originalY) * slot1, slot2.originalZ + (slot2.z - slot2.originalZ) * slot1)
end

function slot0._finishCallback(slot0, slot1)
	transformhelper.setLocalPos(slot0.go.transform, slot1.x, slot1.y, slot1.z)
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true

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

function slot0.playCommonInteractionEff(slot0, slot1, slot2)
	if slot0.__willDestroy then
		return
	end

	if not CritterConfig.instance:getCritterCommonInteractionEffCfg(slot1) then
		return
	end

	slot4 = slot3.effectKey
	slot5 = RoomResHelper.getCharacterEffectABPath(slot3.effectRes)

	if gohelper.isNil(slot0.critterspine and slot0.critterspine:getSpineGO()) then
		return
	end

	if gohelper.isNil(gohelper.findChild(slot6, RoomCharacterHelper.getSpinePointPath(slot3.point))) then
		slot8 = slot0.containerGO

		logError(string.format(" RoomCritterEntity:playCommonInteractionEff error, no point, critterUid:%s, pointPath:%s", slot0.entityId, slot7))
	end

	slot0.effect:addParams({
		[slot4] = {
			res = slot5,
			containerGO = slot8
		}
	}, slot2)
	slot0.effect:refreshEffect()
end

function slot0.stopCommonInteractionEff(slot0, slot1)
	if slot0.__willDestroy then
		return
	end

	if not CritterConfig.instance:getCritterCommonInteractionEffCfg(slot1) then
		return
	end

	slot0.effect:removeParams({
		slot2.effectKey
	})
	slot0.effect:refreshEffect()
end

function slot0.stopAllCommonInteractionEff(slot0)
	if slot0.__willDestroy then
		return
	end

	slot0.effect:removeParams(CritterConfig.instance:getAllCritterCommonInteractionEffKeyList())
	slot0.effect:refreshEffect()
end

function slot0.tweenUp(slot0)
	TaskDispatcher.cancelTask(slot0._pressingEffectDelayDestroy, slot0)

	slot0.isPressing = true

	slot0.critterspine:updateAlpha()

	slot1 = nil

	if slot0:getMO() and slot2:isRestingCritter() then
		slot1 = Vector3.one * CritterEnum.CritterPressingEffectScaleInSeatSlot
	end

	slot0.effect:addParams({
		[RoomEnum.EffectKey.PressingEffectKey] = {
			res = RoomScenePreloader.ResEffectPressingCharacter,
			containerGO = slot0.staticContainerGO,
			localScale = slot1
		}
	})
	slot0.effect:refreshEffect()

	if slot0.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey) and slot4:GetComponent(typeof(UnityEngine.Animator)) then
		slot5:Play("open", 0, 0)
	end

	if slot0.critterspine then
		slot0.critterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "up")
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_drag)
end

function slot0.tweenDown(slot0)
	slot0.isPressing = false

	slot0.critterspine:updateAlpha()

	if slot0.effect:getEffectGO(RoomEnum.EffectKey.PressingEffectKey) and slot1:GetComponent(typeof(UnityEngine.Animator)) then
		slot2:Play("close", 0, 0)
	end

	if slot0.critterspine then
		slot0.critterspine:playAnim(RoomScenePreloader.ResAnim.PressingCharacter, "down", 0, slot0._downDone, slot0)
	end

	TaskDispatcher.runDelay(slot0._pressingEffectDelayDestroy, slot0, 2)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_role_put)
end

function slot0._downDone(slot0)
	if slot0.critterspine then
		slot0.critterspine:clearAnim()
	end
end

function slot0._pressingEffectDelayDestroy(slot0)
	slot0.effect:removeParams({
		RoomEnum.EffectKey.PressingEffectKey
	})
	slot0.effect:refreshEffect()
end

function slot0.getMO(slot0)
	slot0._mo = RoomCritterModel.instance:getCritterMOById(slot0.id) or slot0._mo

	return slot0._mo
end

return slot0
