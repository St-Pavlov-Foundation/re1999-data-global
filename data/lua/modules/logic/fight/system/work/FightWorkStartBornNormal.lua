module("modules.logic.fight.system.work.FightWorkStartBornNormal", package.seeall)

slot0 = class("FightWorkStartBornNormal", BaseWork)
slot1 = {
	[FightEnum.EntitySide.MySide] = 0.7,
	[FightEnum.EntitySide.EnemySide] = 0.5
}
slot2 = {
	{
		0,
		0.16,
		"_BloomFactor",
		"float",
		"0",
		"1",
		false
	}
}
slot3 = 0.16
slot4 = 0.1
slot5 = 1.5

function slot0.ctor(slot0, slot1, slot2)
	slot0._entity = slot1
	slot0._needPlayBornAnim = slot2
	slot0._animDone = false
	slot0._effectDone = false
	slot0.dontDealBuff = nil
end

function slot0.onStart(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.OnStartFightPlayBornNormal, slot0._entity.id)

	if slot0._entity.isSub then
		slot0._effectDone = true

		slot0._entity:setAlpha(1, 0)
		slot0:_playBornAnim()

		return
	end

	if slot0._needPlayBornAnim and slot0._entity.spine:hasAnimation(SpineAnimState.born) then
		slot0:_setSkinSpineActionLock(true)
		slot0._entity.spine:getSkeletonAnim():SetMixDuration(0)
		slot0._entity.spine:play(SpineAnimState.born, false, true)
		TaskDispatcher.runDelay(function ()
			uv0._entity.spine:setFreeze(true)
		end, nil, 0.001)
	end

	slot0:_playEffect()
	slot0._entity:setAlpha(0, 0)

	if slot0._entity.spine and slot0._entity.spine:getPPEffectMask() then
		slot2.enabled = false
	end

	if slot0._entity.nameUI then
		slot0._entity.nameUI:setActive(false)
	end

	if uv0[slot0._entity:getSide()] / FightModel.instance:getSpeed() and slot3 > 0 then
		TaskDispatcher.runDelay(slot0._startFadeIn, slot0, slot3)
	else
		slot0:_startFadeIn()
	end
end

function slot0._playEffect(slot0)
	slot1 = FightPreloadEffectWork.buff_chuchang
	slot2 = nil
	slot3 = uv0

	if slot0._entity:getMO() and lua_fight_debut_show.configDict[slot4.skin] then
		slot1 = nil

		if not string.nilorempty(slot5.effect) then
			slot1 = slot5.effect
			slot2 = slot5.effectHangPoint
			slot3 = slot5.effectTime / 1000
		end

		if slot5.audioId ~= 0 then
			AudioMgr.instance:trigger(slot5.audioId)
		end
	end

	if slot1 then
		slot0._effectWrap = slot0._entity.effect:addHangEffect(slot1, slot2)

		slot0._effectWrap:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot0._effectWrap)
		TaskDispatcher.runDelay(slot0._onEffectDone, slot0, slot3 / FightModel.instance:getSpeed())
	else
		slot0:_onEffectDone()
	end
end

function slot0._onEffectDone(slot0)
	slot0._effectDone = true

	slot0:_checkDone()
end

function slot0._checkDone(slot0)
	if slot0._effectDone and slot0._animDone then
		if slot0._entity.nameUI then
			slot0._entity.nameUI:setActive(true)
		end

		if slot0._entity.spine and slot0._entity.spine:getPPEffectMask() then
			slot1.enabled = true
		end

		if not slot0.dontDealBuff and slot0._entity.buff then
			slot0._entity.buff:dealStartBuff()
		end

		slot0:onDone(true)
	end
end

function slot0._startFadeIn(slot0)
	slot0._entity:setAlpha(1, uv0 / FightModel.instance:getSpeed())

	slot6 = FightModel.instance:getSpeed()
	slot5 = uv0 / slot6

	TaskDispatcher.runDelay(slot0._playBornAnim, slot0, slot5)

	slot0._startTime = Time.time
	slot1 = slot0._entity.spine:getPPEffectMask()
	slot0._spineMat = slot0._entity.spineRenderer:getReplaceMat()

	for slot5, slot6 in ipairs(uv1) do
		slot7 = slot6[4]
		slot6.startValue = MaterialUtil.getPropValueFromStr(slot7, slot6[5])
		slot6.endValue = MaterialUtil.getPropValueFromStr(slot7, slot6[6])
	end

	TaskDispatcher.runRepeat(slot0._onFrameMaterialProperty, slot0, 0.01)
end

function slot0._onFrameMaterialProperty(slot0)
	slot1 = FightModel.instance:getSpeed() or 1
	slot2 = slot0._entity.spineRenderer:getReplaceMat()
	slot3 = Time.time - slot0._startTime

	for slot7, slot8 in ipairs(uv0) do
		slot10 = slot8[2] / slot1

		if slot3 >= slot8[1] * 0.95 and slot3 <= slot10 * 1.05 then
			slot13 = slot8[7]
			slot8.frameValue = MaterialUtil.getLerpValue(slot8[4], slot8.startValue, slot8.endValue, Mathf.Clamp01((slot3 - slot9) / (slot10 - slot9)), slot8.frameValue)

			if slot0._spineMat then
				MaterialUtil.setPropValue(slot15, slot8[3], slot12, slot8.frameValue)
			end
		end
	end

	if slot3 > uv1 / slot1 then
		TaskDispatcher.cancelTask(slot0._onFrameMaterialProperty, slot0)
	end
end

function slot0._setSkinSpineActionLock(slot0, slot1)
	if slot0._entity and slot0._entity.skinSpineAction then
		slot0._entity.skinSpineAction.lock = slot1
	end
end

function slot0._playBornAnim(slot0)
	if slot0._needPlayBornAnim and slot0._entity.spine:hasAnimation(SpineAnimState.born) then
		slot0:_setSkinSpineActionLock(false)
		slot0._entity.spine:setFreeze(false)
		slot0._entity.spine:addAnimEventCallback(slot0._onAnimEvent, slot0)
		slot0._entity.spine:play(SpineAnimState.born, false, true)
	else
		slot0._animDone = true

		slot0:_checkDone()
	end
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3)
	if slot2 == SpineAnimEvent.ActionComplete then
		slot0._entity.spine:getSkeletonAnim():ClearMixDuration()
		slot0._entity.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		slot0._entity:resetAnimState()

		slot0._animDone = true

		slot0:_checkDone()
	end
end

function slot0.clearWork(slot0)
	slot0:_setSkinSpineActionLock(false)
	TaskDispatcher.cancelTask(slot0._startFadeIn, slot0)
	TaskDispatcher.cancelTask(slot0._playBornAnim, slot0)
	TaskDispatcher.cancelTask(slot0._onEffectDone, slot0)
	TaskDispatcher.cancelTask(slot0._onFrameMaterialProperty, slot0)

	if slot0._effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot0._effectWrap)
		slot0._entity.effect:removeEffect(slot0._effectWrap)

		slot0._effectWrap = nil
	end

	if slot0._entity and slot0._entity.spine:getSkeletonAnim() then
		slot0._entity.spine:setFreeze(false)
		slot0._entity.spine:getSkeletonAnim():ClearMixDuration()
		slot0._entity.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
	end

	slot0._spineMat = nil
end

return slot0
