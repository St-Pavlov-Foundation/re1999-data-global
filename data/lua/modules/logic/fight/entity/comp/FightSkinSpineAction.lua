module("modules.logic.fight.entity.comp.FightSkinSpineAction", package.seeall)

slot0 = class("FightSkinSpineAction", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._effectWraps = {}
	slot0.lock = false
end

function slot0.init(slot0, slot1)
	slot0._spine = slot0.entity.spine
end

function slot0.addEventListeners(slot0)
	slot0._spine:addAnimEventCallback(slot0._onAnimEvent, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3)
	if slot0.lock then
		return
	end

	if not slot0.entity:getMO() then
		return
	end

	if not FightConfig.instance:getSkinSpineActionDict(slot4.skin, slot1) then
		return
	end

	slot6 = slot5[slot1]

	if slot2 == SpineAnimEvent.ActionStart then
		slot0:_removeEffect()

		slot7 = true

		if slot1 == SpineAnimState.die or slot1 == SpineAnimState.born then
			if FightDataHelper.entityMgr:isSub(slot4.id) then
				slot7 = false
			end

			if slot1 == SpineAnimState.born and FightAudioMgr.instance.enterFightVoiceHeroID and FightAudioMgr.instance.enterFightVoiceHeroID ~= slot4.modelId then
				slot7 = false
			end
		end

		if slot6 then
			slot0:_playActionEffect(slot6)

			if slot7 then
				slot0:_playActionAudio(slot6)
			end

			if slot6.effectRemoveTime > 0 then
				TaskDispatcher.cancelTask(slot0._removeEffect, slot0)
				TaskDispatcher.runDelay(slot0._removeEffect, slot0, slot6.effectRemoveTime)
			end
		end
	elseif slot2 == SpineAnimEvent.ActionComplete and slot6 and slot6.effectRemoveTime == 0 then
		slot0:_removeEffect()
	end
end

function slot0._removeEffect(slot0)
	TaskDispatcher.cancelTask(slot0._removeEffect, slot0)

	for slot4, slot5 in ipairs(slot0._effectWraps) do
		slot0.entity.effect:removeEffect(slot5)
	end

	slot0._effectWraps = {}
end

function slot0._playActionEffect(slot0, slot1)
	if not string.nilorempty(slot1.effect) then
		for slot7, slot8 in ipairs(string.split(slot1.effect, "#")) do
			slot9 = slot0.entity.effect:addHangEffect(slot8, string.split(slot1.effectHangPoint, "#")[slot7])

			slot9:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(slot0.entity.id, slot9)
			table.insert(slot0._effectWraps, slot9)
		end
	end
end

function slot0._playActionAudio(slot0, slot1)
	if slot1.audioId and slot1.audioId > 0 then
		FightAudioMgr.instance:playAudio(slot1.audioId)
	end
end

function slot0.onDestroy(slot0)
	slot0:_removeEffect()
end

return slot0
