module("modules.logic.fight.entity.mgr.FightSkillBehaviorMgr", package.seeall)

slot0 = class("FightSkillBehaviorMgr")

function slot0.init(slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillEffectPlayFinish, slot0._onSkillEffectPlayFinish, slot0)

	slot0._hasPlayDict = {}
	slot0._specialWorkList = {}
end

function slot0.playSkillEffectBehavior(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if FightSkillMgr.instance:isPlayingAnyTimeline() then
		return
	end

	if slot2.configEffect and slot3 > 0 then
		slot4 = slot2.targetId .. ":" .. slot3

		if not slot0._hasPlayDict[slot1.stepUid] then
			slot0._hasPlayDict[slot1.stepUid] = {}
		end

		if not slot5[slot4] then
			slot5[slot4] = true

			if lua_skill_behavior.configDict[slot3] then
				slot0:_doSkillBehaviorEffect(slot1, slot2, slot6, false)
			end
		end
	end
end

function slot0.playSkillBehavior(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if not lua_skill.configDict[slot1.actId] then
		return
	end

	for slot9, slot10 in ipairs(slot1.actEffectMOs) do
		if slot10.configEffect and slot11 > 0 then
			slot12 = slot2 and slot2[slot11]
			slot13 = slot10.targetId .. ":" .. slot11

			if not slot0._hasPlayDict[slot1.stepUid] then
				slot0._hasPlayDict[slot1.stepUid] = {}
			end

			if slot12 or not slot2 and not slot14[slot13] then
				slot14[slot13] = true

				if lua_skill_behavior.configDict[slot11] then
					slot0:_doSkillBehaviorEffect(slot1, slot10, slot16, slot3)
				end
			end
		end
	end
end

function slot0._doSkillBehaviorEffect(slot0, slot1, slot2, slot3, slot4)
	slot5 = FightHelper.getEntity(slot2.targetId) or slot2.entityMO and FightHelper.getEntity(slot2.entityMO.id)
	slot6 = slot3.effect
	slot7 = slot3.effectHangPoint
	slot8 = slot3.audioId
	slot9 = FightDataHelper.entityMgr:getById(slot1.fromId)

	if slot3.id == 60052 and slot9 and lua_fight_sp_effect_kkny_bear_damage_hit.configDict[slot9.skin] then
		slot6 = slot10.path
		slot7 = slot10.hangPoint
		slot8 = slot10.audio
	end

	if not string.nilorempty(slot6) and slot5 and slot5.effect then
		slot10 = nil

		if not string.nilorempty(slot7) then
			slot5.effect:addHangEffect(slot6, slot7):setLocalPos(0, 0, 0)
		else
			slot5.effect:addGlobalEffect(slot6):setWorldPos(FightHelper.getProcessEntitySpinePos(slot5))
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(slot5.id, slot10)

		slot0._effectCache = slot0._effectCache or {}

		table.insert(slot0._effectCache, {
			slot5.id,
			slot10,
			Time.time
		})
		TaskDispatcher.runRepeat(slot0._removeEffects, slot0, 0.5)
	end

	if slot8 > 0 then
		FightAudioMgr.instance:playAudio(slot8)
	end

	if slot3.dec_Type > 0 then
		slot10 = slot2.targetId

		if slot2.effectType == FightEnum.EffectType.CARDLEVELCHANGE then
			slot10 = slot2.entityMO and slot2.entityMO.uid or slot1.fromId
		end

		FightFloatMgr.instance:float(slot10, FightEnum.FloatType.buff, slot3.dec, slot3.dec_Type)
	end

	if slot4 then
		if (slot3.type == FightEnum.Behavior_AddExPoint or slot10 == FightEnum.Behavior_DelExPoint) and slot2.effectType == FightEnum.EffectType.EXPOINTCHANGE then
			slot11 = FightWork2Work.New(FightWorkExPointChange, slot1, slot2)

			slot11:onStart()
			table.insert(slot0._specialWorkList, slot11)
		elseif FightEnum.BuffEffectType[slot2.effectType] then
			FightSkillBuffMgr.instance:playSkillBuff(slot1, slot2)
		elseif slot10 == FightEnum.Behavior_LostLife and slot2.effectType == FightEnum.EffectType.DAMAGE and not slot2:isDone() then
			slot11 = FightWork2Work.New(FightWorkEffectDamage, slot1, slot2)

			slot11:onStart()
			table.insert(slot0._specialWorkList, slot11)
		end
	end
end

function slot0._onSkillEffectPlayFinish(slot0, slot1)
	slot0:playSkillBehavior(slot1, false)
end

function slot0._removeEffects(slot0, slot1)
	if not slot0._effectCache then
		return
	end

	for slot6 = #slot0._effectCache, 1, -1 do
		slot8 = slot0._effectCache[slot6][2]
		slot10 = FightHelper.getEntity(slot0._effectCache[slot6][1])

		if slot1 or Time.time - slot0._effectCache[slot6][3] > 2 then
			if slot10 then
				FightRenderOrderMgr.instance:onRemoveEffectWrap(slot10.id, slot8)
				slot10.effect:removeEffect(slot8)
			end

			table.remove(slot0._effectCache, slot6)
		end
	end

	if #slot0._effectCache == 0 then
		TaskDispatcher.cancelTask(slot0._removeEffects, slot0)
	end
end

function slot0.dispose(slot0)
	if slot0._specialWorkList then
		for slot4, slot5 in ipairs(slot0._specialWorkList) do
			if slot5.status == WorkStatus.Running then
				slot5:onStop()
			end
		end
	end

	slot0._specialWorkList = nil

	FightController.instance:unregisterCallback(FightEvent.OnSkillEffectPlayFinish, slot0._onSkillEffectPlayFinish, slot0)
	TaskDispatcher.cancelTask(slot0._removeEffects, slot0)
	slot0:_removeEffects(true)

	slot0._effectCache = nil
	slot0._hasPlayDict = nil
end

slot0.instance = slot0.New()

return slot0
