module("modules.logic.fight.system.work.FightBuffTriggerEffect", package.seeall)

slot0 = class("FightBuffTriggerEffect", FightEffectBase)
slot1 = 2
slot2 = 2

function slot0.onStart(slot0)
	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:onDone(true)

		return
	end

	if lua_skill_buff.configDict[slot0._actEffectMO.effectNum] and FightHelper.shouUIPoisoningEffect(slot2.id) and slot1.nameUI and slot1.nameUI.showPoisoningEffect then
		slot1.nameUI:showPoisoningEffect(slot2)
	end

	slot3, slot4, slot5 = slot0:_getBuffTriggerParam(slot2, slot1)

	if slot3 ~= "0" and not string.nilorempty(slot3) then
		slot0._effectWrap = nil

		if not string.nilorempty(slot4) then
			slot0._effectWrap = slot1.effect:addHangEffect("buff/" .. slot3, slot4, slot1:getSide())

			slot0._effectWrap:setLocalPos(0, 0, 0)
		else
			slot0._effectWrap = slot1.effect:addGlobalEffect(slot7, slot6)
			slot8, slot9, slot10 = transformhelper.getPos(slot1.go.transform)

			slot0._effectWrap:setWorldPos(slot8, slot9, slot10)
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot0._effectWrap)
		TaskDispatcher.runDelay(slot0._onTickCheckRemoveEffect, slot0, uv0 / FightModel.instance:getSpeed())
	end

	if slot5 and slot5 > 0 then
		FightAudioMgr.instance:playAudio(slot5)
	end

	slot0._animationName = slot2 and slot2.triggerAnimationName
	slot0._animationName = FightHelper.processEntityActionName(slot1, slot0._animationName)

	if not string.nilorempty(slot0._animationName) and slot1.spine:hasAnimation(slot0._animationName) then
		slot0._hasPlayAnim = true

		slot1.spine:addAnimEventCallback(slot0._onAnimEvent, slot0)
		slot1.spine:play(slot0._animationName, false, true, true)
		TaskDispatcher.runDelay(slot0._onTickCheckRemoveAnim, slot0, uv1 / FightModel.instance:getSpeed())
	end

	slot0:onDone(true)
end

function slot0._getBuffTriggerParam(slot0, slot1, slot2)
	slot4 = slot1 and slot1.triggerEffectHangPoint
	slot5 = slot1 and slot1.triggerAudio

	if (string.nilorempty(slot1 and slot1.triggerEffect) or slot3 == "0") and lua_buff_act.configDict[slot0._actEffectMO.buffActId] and not string.nilorempty(slot6.effect) then
		if slot6.effect ~= "0" and not string.nilorempty(slot7) then
			return slot7, slot6.effectHangPoint, slot6.audioId
		end
	end

	if slot1 then
		slot3 = FightHelper.processBuffEffectPath(slot3, slot2, slot1.id, "triggerEffect")
	end

	return slot3, slot4, slot5
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3)
	if slot1 == slot0._animationName and slot2 == SpineAnimEvent.ActionComplete and FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot4.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)

		if not FightSkillMgr.instance:isEntityPlayingTimeline(slot4.id) then
			slot4:resetAnimState()
		end
	end
end

function slot0._onTickCheckRemoveEffect(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	slot1 = FightHelper.getEntity(slot0._actEffectMO.targetId)

	if slot0._effectWrap and slot1 then
		slot1.effect:removeEffect(slot0._effectWrap)

		slot0._effectWrap = nil
	end
end

function slot0._onTickCheckRemoveAnim(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	if FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot1.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onTickCheckRemoveEffect, slot0)
	TaskDispatcher.cancelTask(slot0._onTickCheckRemoveAnim, slot0)

	if slot0._hasPlayAnim and FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot1.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
	end

	uv0.super.onDestroy(slot0)
end

return slot0
