module("modules.logic.room.entity.RoomTransportSiteEntity", package.seeall)

slot0 = class("RoomTransportSiteEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)
	slot0:setEntityId(slot1)
end

function slot0.setEntityId(slot0, slot1)
	slot0.id = slot1
	slot0.entityId = slot0.id
end

function slot0.getTag(slot0)
	return SceneTag.RoomBuilding
end

function slot0.init(slot0, slot1)
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = slot0.containerGO
	slot0.containerGOTrs = slot0.containerGO.transform
	slot0.goTrs = slot1.transform

	uv0.super.init(slot0, slot1)
end

function slot0.playAudio(slot0, slot1)
	if slot1 and slot1 ~= 0 then
		slot0.__isHasAuidoTrigger = true

		AudioMgr.instance:trigger(slot1, slot0.go)
	end
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", RoomEffectComp)
	slot0:addComp("alphaThresholdComp", RoomAlphaThresholdComp)
	slot0:addComp("collider", RoomColliderComp)
	slot0:addComp("nightlight", RoomNightLightComp)
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
end

function slot0.refreshBuilding(slot0)
	if not slot0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BuildingGOKey) then
		slot0.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				res = "scenes/m_s07_xiaowu/prefab/building/2_2_simulate/simulate_tingchezhan_1.prefab",
				pathfinding = true,
				deleteChildPath = "0"
			}
		})
		slot0.effect:refreshEffect()
	end
end

function slot0.setLocalPos(slot0, slot1, slot2, slot3, slot4)
	ZProj.TweenHelper.KillByObj(slot0.goTrs)

	if slot4 then
		ZProj.TweenHelper.DOLocalMove(slot0.goTrs, slot1, slot2, slot3, 0.1)
	else
		transformhelper.setLocalPos(slot0.goTrs, slot1, slot2, slot3)
	end
end

function slot0.getAlphaThresholdValue(slot0)
	return nil
end

function slot0.onEffectRebuild(slot0)
	if not slot0._isSmokeAnimPlaying then
		slot0:_playSmokeAnim(false)
	end

	if slot0:getBodyGO() then
		RoomMapController.instance:dispatchEvent(RoomEvent.RoomVieiwConfirmRefreshUI)
	end
end

function slot0.getBodyGO(slot0)
	return slot0:_findBuildingGOChild(RoomEnum.EntityChildKey.BodyGOKey)
end

function slot0.getHeadGO(slot0)
	return slot0:_findBuildingGOChild(RoomEnum.EntityChildKey.HeadGOKey)
end

function slot0.playAnimator(slot0, slot1)
	return slot0.effect:playEffectAnimator(RoomEnum.EffectKey.BuildingGOKey, slot1)
end

function slot0.playSmokeEffect(slot0)
	slot0:_returnSmokeEffect()
	slot0:_playSmokeAnim(true)

	slot0._isSmokeAnimPlaying = true

	TaskDispatcher.runDelay(slot0._delayReturnSmokeEffect, slot0, 3)
end

function slot0._delayReturnSmokeEffect(slot0)
	slot0._isSmokeAnimPlaying = false

	slot0:_playSmokeAnim(false)
end

function slot0._returnSmokeEffect(slot0)
	TaskDispatcher.cancelTask(slot0._delayReturnSmokeEffect, slot0)
end

function slot0._playSmokeAnim(slot0, slot1)
	if slot0:_findBuildingGOChild(RoomEnum.EntityChildKey.SmokeGOKey) then
		if slot1 then
			gohelper.setActive(slot2, false)
		end

		gohelper.setActive(slot2, slot1)
	end
end

function slot0._findBuildingGOChild(slot0, slot1)
	return slot0.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, slot1)
end

function slot0.beforeDestroy(slot0)
	ZProj.TweenHelper.KillByObj(slot0.goTrs)
	slot0:_returnSmokeEffect()
	slot0:removeEvent()
end

function slot0.removeEvent(slot0)
end

function slot0.getMO(slot0)
	return nil
end

function slot0.getCharacterMeshRendererList(slot0)
	return slot0.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

return slot0
