module("modules.logic.fight.entity.comp.buff.FightBuffCardAreaRedOrBlueBuff", package.seeall)

slot0 = class("FightBuffCardAreaRedOrBlueBuff")

function slot0.ctor(slot0)
end

function slot0.onBuffStart(slot0, slot1, slot2)
	slot0.entity = slot1
	slot0.entityMo = slot1:getMO()
	slot0.side = slot0.entityMo.side
	slot0.sceneEntityMgr = GameSceneMgr.instance:getCurScene() and slot3.entityMgr
	slot0.effectCo = FightHeroSpEffectConfig.instance:getLYEffectCo(slot0.entityMo.originSkin)
	slot0.buffRes = slot0.effectCo.path
	slot0.spine1EffectRes = slot0.effectCo.spine1EffectRes
	slot0.spine2EffectRes = slot0.effectCo.spine2EffectRes
	slot0.spine1Res = slot0:getFullSpineResPath(slot0.effectCo.spine1Res)
	slot0.spine2Res = slot0:getFullSpineResPath(slot0.effectCo.spine2Res)
	slot0.playingUniqueSkill = false

	FightController.instance:registerCallback(FightEvent.BeforePlayUniqueSkill, slot0.onBeforePlayUniqueSkill, slot0)
	FightController.instance:registerCallback(FightEvent.AfterPlayUniqueSkill, slot0.onAfterPlayUniqueSkill, slot0)
	FightController.instance:registerCallback(FightEvent.ReleaseAllEntrustedEntity, slot0.onReleaseAllEntrustedEntity, slot0)
	FightController.instance:registerCallback(FightEvent.OnCameraFocusChanged, slot0.onCameraFocusChanged, slot0)

	slot0.loaded = false

	slot0:startLoadRes()
	FightDataHelper.LYDataMgr:setLYCardAreaBuff(slot2)
end

function slot0.startLoadRes(slot0)
	slot0:clearLoader()

	slot0.resLoader = MultiAbLoader.New()

	slot0.resLoader:addPath(slot0:getEffectAbPath(slot0.buffRes))
	slot0.resLoader:addPath(slot0:getEffectAbPath(slot0.spine1EffectRes))
	slot0.resLoader:addPath(slot0:getEffectAbPath(slot0.spine2EffectRes))
	slot0.resLoader:addPath(slot0.spine1Res)
	slot0.resLoader:addPath(slot0.spine2Res)
	slot0.resLoader:startLoad(slot0.onResLoaded, slot0)

	if slot0.effectCo.audioId and slot1 ~= 0 then
		AudioMgr.instance:trigger(slot1)
	end
end

function slot0.getEffectAbPath(slot0, slot1)
	return FightHelper.getEffectAbPath(FightHelper.getEffectUrlWithLod(slot1))
end

function slot0.getEffectPos(slot0, slot1)
	slot2 = slot0.effectCo.pos

	if slot1 == FightEnum.EntitySide.EnemySide then
		return -slot2[1], slot2[2], slot2[3]
	else
		return slot2[1], slot2[2], slot2[3]
	end
end

function slot0.onResLoaded(slot0, slot1)
	slot0.loaded = true
	slot2 = slot0.entity:getSide()
	slot0.spine1 = slot0.sceneEntityMgr:buildTempSpine(slot0.spine1Res, slot0.entity.id .. "_1", slot2, UnityLayer.EffectMask, FightEntityLyTemp)
	slot0.spine2 = slot0.sceneEntityMgr:buildTempSpine(slot0.spine2Res, slot0.entity.id .. "_2", slot2, UnityLayer.EffectMask, FightEntityLyTemp)

	slot0:hideEntity()

	slot0.spine1Effect = slot0.spine1.effect:addHangEffect(slot0.spine1EffectRes, ModuleEnum.SpineHangPointRoot)
	slot0.spine2Effect = slot0.spine2.effect:addHangEffect(slot0.spine2EffectRes, ModuleEnum.SpineHangPointRoot)
	slot0.effectWrap = slot0.entity.effect:addGlobalEffect(slot0.buffRes)
	slot3 = FightRenderOrderMgr.LYEffect * FightEnum.OrderRegion

	slot0.spine1Effect:setRenderOrder(slot3)
	slot0.spine2Effect:setRenderOrder(slot3)
	slot0.effectWrap:setRenderOrder(slot3)

	slot4 = slot0.spine1Effect.effectGO and gohelper.findChild(slot0.spine1Effect.effectGO, "root")
	slot0.spine1EffectAnimator = slot4 and ZProj.ProjAnimatorPlayer.Get(slot4)
	slot5 = slot0.spine2Effect.effectGO and gohelper.findChild(slot0.spine2Effect.effectGO, "root")
	slot0.spine2EffectAnimator = slot5 and ZProj.ProjAnimatorPlayer.Get(slot5)
	slot6 = slot0.effectWrap.effectGO and gohelper.findChild(slot0.effectWrap.effectGO, "root")
	slot0.effectAnimator = slot6 and ZProj.ProjAnimatorPlayer.Get(slot6)

	slot0.effectWrap:setWorldPos(slot0:getEffectPos(slot2))
	slot0:addEffect(slot0.spine1, slot0.spine1Effect, slot2)
	slot0:addEffect(slot0.spine2, slot0.spine2Effect, slot2)
	slot0:showEntity()
	slot0.spine1.spine:addAnimEventCallback(slot0.onAnimEventCallback, slot0)
	slot0:playAnim(SpineAnimState.born)
	slot0:refreshEffectActive()
	FightController.instance:registerCallback(FightEvent.TimelineLYSpecialSpinePlayAniName, slot0.playAnim, slot0)
end

function slot0.addEffect(slot0, slot1, slot2, slot3)
	slot2:setWorldPos(slot0:getEffectPos(slot3))
	FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot2)
end

function slot0.playAnim(slot0, slot1)
	if not slot0.loaded then
		return
	end

	if slot0:isIdleAnim(slot1) then
		slot0.spine1.spine:play(slot1, true, true)
	else
		slot0.spine1.spine:play(slot1, false, true)
	end
end

function slot0.onAnimEventCallback(slot0, slot1, slot2, slot3)
	if slot0:isIdleAnim(slot1) then
		return
	end

	if slot2 == SpineAnimEvent.ActionComplete then
		return slot0:playAnim(SpineAnimState.idle1)
	end
end

function slot0.isIdleAnim(slot0, slot1)
	return SpineAnimState.idle1 == slot1 or SpineAnimState.idle2 == slot1
end

function slot0.onCameraFocusChanged(slot0, slot1)
	slot0.focusing = slot1

	slot0:refreshEffectActive()
end

function slot0.onBeforePlayUniqueSkill(slot0)
	slot0.playingUniqueSkill = true

	slot0:refreshEffectActive()
end

function slot0.onAfterPlayUniqueSkill(slot0)
	slot0.playingUniqueSkill = false

	slot0:refreshEffectActive()
end

function slot0.refreshEffectActive(slot0)
	if slot0.loaded then
		slot1 = not slot0.playingUniqueSkill and not slot0.focusing

		slot0.spine1Effect:setActive(slot1)
		slot0.spine2Effect:setActive(slot1)
		slot0.effectWrap:setActive(slot1)

		if slot1 then
			slot0:showEntity()
		else
			slot0:hideEntity()
		end
	end
end

function slot0.setEntityAlpha(slot0, slot1)
	if not slot0.loaded then
		return
	end

	slot0.spine1.spineRenderer:setAlpha(slot1)
	slot0.spine2.spineRenderer:setAlpha(slot1)
end

function slot0.hideEntity(slot0)
	slot0:setEntityAlpha(0)
end

function slot0.showEntity(slot0)
	TaskDispatcher.cancelTask(slot0._showEntity, slot0)
	TaskDispatcher.runDelay(slot0._showEntity, slot0, 0.01)
end

function slot0._showEntity(slot0)
	if slot0.playingUniqueSkill then
		slot0:setEntityAlpha(0)
	else
		slot0:setEntityAlpha(1)
	end
end

function slot0.getFullSpineResPath(slot0, slot1)
	return string.format("roles/%s.prefab", slot1)
end

function slot0.onReleaseAllEntrustedEntity(slot0)
	slot0:clear()
end

function slot0.clearLoader(slot0)
	if slot0.resLoader then
		slot0.resLoader:dispose()

		slot0.resLoader = nil
	end
end

function slot0.clear(slot0)
	slot0:clearLoader()
	TaskDispatcher.cancelTask(slot0._showEntity, slot0)

	if slot0.effectAnimator then
		if slot0.effectCo and slot0.effectCo.fadeAudioId and slot1 ~= 0 then
			AudioMgr.instance:trigger(slot1)
		end

		slot0.spine1EffectAnimator:Play("close")
		slot0.spine2EffectAnimator:Play("close")
		slot0.effectAnimator:Play("close", slot0.clearEffectAndEntity, slot0)
	else
		slot0:clearEffectAndEntity()
	end

	FightDataHelper.LYDataMgr:setLYCardAreaBuff(nil)
	FightController.instance:unregisterCallback(FightEvent.TimelineLYSpecialSpinePlayAniName, slot0.playAnim, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, slot0.onBeforePlayUniqueSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, slot0.onAfterPlayUniqueSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.ReleaseAllEntrustedEntity, slot0.onReleaseAllEntrustedEntity, slot0)

	slot0.loaded = false
end

function slot0.clearEffectAndEntity(slot0)
	slot0:clearSpine(slot0.spine1, slot0.spine1Effect)
	slot0:clearSpine(slot0.spine2, slot0.spine2Effect)
	slot0:clearEffect(slot0.entity, slot0.effectWrap)

	slot0.spine1 = nil
	slot0.spine2 = nil
	slot0.spine1Effect = nil
	slot0.spine2Effect = nil
	slot0.effectWrap = nil
	slot0.effectAnimator = nil
	slot0.spine1EffectAnimator = nil
	slot0.spine2EffectAnimator = nil
	slot0.entity = nil
end

function slot0.clearSpine(slot0, slot1, slot2)
	if slot1 then
		slot0:clearEffect(slot1, slot2)
		slot0.sceneEntityMgr:removeUnit(slot1:getTag(), slot1.id)
	end
end

function slot0.clearEffect(slot0, slot1, slot2)
	if slot1 and slot2 then
		slot1.effect:removeEffect(slot2)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot1.id, slot2)
	end
end

function slot0.onBuffEnd(slot0)
	slot0:clear()
end

function slot0.dispose(slot0)
	slot0:clear()
end

return slot0
