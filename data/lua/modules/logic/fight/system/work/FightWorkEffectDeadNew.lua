module("modules.logic.fight.system.work.FightWorkEffectDeadNew", package.seeall)

slot0 = class("FightWorkEffectDeadNew", BaseWork)
slot1 = 1
slot2 = 0.35
slot3 = 0.4
slot4 = 1
slot5 = 0.1
slot6 = 0.6

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0._fightStepMO = slot1
	slot0._actEffectMO = slot2
	slot0._waitForLastHit = slot3
end

function slot0.onStart(slot0)
	slot0._deadEntity = FightHelper.getEntity(slot0._actEffectMO.targetId)

	if slot0._deadEntity and not slot0._deadEntity.isDead then
		slot0._deadEntity.isDead = true

		if isTypeOf(slot0._deadEntity, FightEntityAssembledMonsterMain) then
			slot0._deadEntity:killAllSubMonster()
		end

		if isTypeOf(slot0._deadEntity, FightEntityAssembledMonsterSub) then
			slot0:onDone(true)

			return
		end

		slot0._deadEntityModelId = slot0._deadEntity:getMO().modelId

		FightController.instance:dispatchEvent(FightEvent.OnStartEntityDead, slot0._deadEntity.id)

		if slot0._fightStepMO.actType == FightEnum.ActType.SKILL then
			slot0._deadEntity.deadBySkillId = slot0._fightStepMO.actId
		end

		if slot0._waitForLastHit then
			if not FightHelper.getEntity(slot0._fightStepMO.fromId) then
				slot0:_playDeadWork()

				return
			end

			TaskDispatcher.runDelay(slot0._delayDone, slot0, 20 / FightModel.instance:getSpeed())
			FightController.instance:registerCallback(FightEvent.OnSkillLastHit, slot0._onLastHit, slot0)
			FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
			FightController.instance:registerCallback(FightEvent.PlaySameSkillOneDone, slot0._playSameSKillOneDone, slot0)
			FightController.instance:registerCallback(FightEvent.InvokeEntityDeadImmediately, slot0._invokeEntityDeadImmediately, slot0)
		else
			slot0:_playDeadWork()
		end
	else
		slot0:onDone(true)
	end
end

function slot0._invokeEntityDeadImmediately(slot0, slot1, slot2)
	slot0:_onLastHit(slot1, slot2)
end

function slot0._onLastHit(slot0, slot1, slot2)
	if slot0._fightStepMO == slot2 then
		if slot2.actId ~= slot0._fightStepMO.actId then
			return
		end

		if slot1 ~= slot0._deadEntity.id then
			return
		end

		slot4 = false

		if slot0._deadEntity and slot0._deadEntity:getMO() and lua_fight_skin_replay_lasthit.configDict[slot3.skin] then
			slot4 = true
		end

		if not slot4 and slot0:_isNoDeadEffect() then
			slot0._deadEntity.spine:play(SpineAnimState.hit, false, true)

			return
		end

		FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, slot0._onLastHit, slot0)
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
		FightController.instance:unregisterCallback(FightEvent.PlaySameSkillOneDone, slot0._playSameSKillOneDone, slot0)
		slot0:_playDeadWork()
	end
end

function slot0._playSameSKillOneDone(slot0, slot1)
	if slot0._fightStepMO == slot1 then
		FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, slot0._onLastHit, slot0)
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
		FightController.instance:unregisterCallback(FightEvent.PlaySameSkillOneDone, slot0._playSameSKillOneDone, slot0)
		slot0:_playDeadWork()
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot0._fightStepMO == slot3 then
		FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, slot0._onLastHit, slot0)
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
		FightController.instance:unregisterCallback(FightEvent.PlaySameSkillOneDone, slot0._playSameSKillOneDone, slot0)
		slot0:_playDeadWork()
	end
end

function slot0._playDeadWork(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 10)

	if slot0:_getDieActName(slot0._deadEntity:getMO()) then
		slot0._deadEntity.spine:play(slot2, false, false)
	end

	for slot6, slot7 in pairs(slot1:getBuffDic()) do
		slot0._deadEntity.buff:delBuff(slot7.uid, true)
	end

	slot1:clearAllBuff()
	slot0._deadEntity:resetSpineMat()
	FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, slot0._deadEntity.id)
	FightController.instance:dispatchEvent(FightEvent.SetEntityWeatherEffectVisible, slot0._deadEntity, false)
	FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, slot0._deadEntity.id, slot0._deadEntity.spineRenderer:getReplaceMat())

	if slot1.modelId == 111101 and FightModel.instance:getFightParam().episodeId == 10115 then
		slot0._direct_end_work = true
	end

	if FightController.instance:GuideFlowPauseAndContinue("OnGuideEntityDeadPause", FightEvent.OnGuideEntityDeadPause, FightEvent.OnGuideEntityDeadContinue, slot0._deadContinue, slot0, {
		side = slot0._deadEntity:getSide(),
		modelId = slot0._deadEntity:getMO().modelId
	}) then
		TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	end

	if slot0._deadEntity.nameUI then
		slot0._deadEntity.nameUI:playDeadEffect()
	end

	FightAudioMgr.instance:playHeroVoiceRandom(slot0._deadEntity:getMO().modelId, CharacterEnum.VoiceType.FightDie)
end

function slot0._getDieActName(slot0, slot1)
	if lua_fight_skin_dead_performance.configDict[slot1.skin] then
		return nil
	end

	slot3 = SpineAnimState.die

	if lua_fight_die_act_enemyus.configDict[slot1.skin] and (not slot0._deadEntity:isMySide() or slot4[1]) and slot4[2] then
		slot0._showDeadEffect = slot4.playEffect
		slot3 = slot4.act
	end

	return slot3
end

function slot0._deadContinue(slot0)
	if lua_fight_skin_dead_performance.configDict[slot0._deadEntity:getMO().skin] then
		slot0:_delayNoDeadEffectDone()
	else
		if gohelper.isNil(slot0._deadEntity.spine:getSkeletonAnim()) then
			logError("skeleton anim is nil " .. slot0._deadEntity.id)
		end

		slot4 = slot3 and slot3:GetCurAnimDuration() or 0.01

		if FightConfig.instance:getSkinSpineActionDict(slot0._deadEntity:getMO().skin) and slot5[SpineAnimState.die] and slot6.effectRemoveTime ~= 0 then
			slot4 = slot6.effectRemoveTime
		end

		if slot0:_isNoDeadEffect() then
			TaskDispatcher.runDelay(slot0._delayNoDeadEffectDone, slot0, slot4 / FightModel.instance:getSpeed())
		else
			slot7 = slot0._deadEntity and slot0._deadEntity:getMO()

			TaskDispatcher.runDelay(slot0._deadComplete, slot0, slot4 * (slot7 and slot7:isCharacter() and uv0 or uv1))
		end
	end

	if FightReplayModel.instance:isReplay() then
		TaskDispatcher.runRepeat(slot0._tick, slot0, 1, 10)
	end
end

function slot0._tick(slot0)
	if FightReplayModel.instance:isReplay() then
		FightController.instance:dispatchEvent(FightEvent.ReplayTick)
	end
end

function slot0._deadComplete(slot0)
	slot2 = slot0._deadEntity:getMO() and slot1:isCharacter() and true or false

	if slot0:_getDeadEffectType() == FightEnum.DeadEffectType.NormalEffect then
		TaskDispatcher.runDelay(slot0._deadPlayEffect, slot0, (slot2 and uv0 or uv1) / FightModel.instance:getSpeed())
	end

	slot0._dissolveWork = SpineDissolveWork.New()

	slot0._dissolveWork:registerDoneListener(slot0._onDissolveDone, slot0)
	slot0._dissolveWork:onStart({
		dissolveEntity = slot0._deadEntity,
		dissolveType = slot0:_getDissolveType(slot3, slot2),
		timeScale = slot2 and uv2 or uv3
	})
end

function slot0._getDissolveType(slot0, slot1, slot2)
	if slot1 == FightEnum.DeadEffectType.NormalEffect then
		return slot2 and FightEnum.DissolveType.Player or FightEnum.DissolveType.Monster
	elseif slot1 == FightEnum.DeadEffectType.ZaoWu then
		return FightEnum.DissolveType.ZaoWu
	elseif slot1 == FightEnum.DeadEffectType.Abjqr4 then
		return FightEnum.DissolveType.Abjqr4
	else
		return slot2 and FightEnum.DissolveType.Player or FightEnum.DissolveType.Monster
	end
end

function slot0._deadPlayEffect(slot0)
	if (slot0._deadEntity:isMySide() and FightPreloadEffectWork.buff_siwang or FightPreloadEffectWork.buff_siwang_monster) == FightPreloadEffectWork.buff_siwang_monster then
		AudioMgr.instance:trigger(410000079)
	end

	if slot0._deadEntity.effect:isDestroyed() then
		return
	end

	slot0._effectWrap = slot0._deadEntity.effect:addHangEffect(slot1, ModuleEnum.SpineHangPointRoot)

	FightRenderOrderMgr.instance:onAddEffectWrap(slot0._deadEntity.id, slot0._effectWrap)
	slot0._effectWrap:setLocalPos(0, 0, 0)
end

function slot0._onDissolveDone(slot0)
	slot0:_doneAndRemoveEntity()
end

function slot0._delayNoDeadEffectDone(slot0)
	if slot0._direct_end_work then
		slot0:_checkDieDialogAfter()

		return
	end

	slot0:_doneAndRemoveEntity()
end

function slot0._delayDone(slot0)
	logError("dead step play timeout, targetId = " .. slot0._actEffectMO.targetId)
	slot0:_doneAndRemoveEntity()
end

function slot0._doneAndRemoveEntity(slot0)
	TaskDispatcher.cancelTask(slot0._deadPlayEffect, slot0)

	slot0._afterDeadFlow = FlowSequence.New()
	slot2 = slot0._deadEntity:isMySide()
	slot3 = slot0._deadEntity:getMO()
	slot5 = lua_fight_skin_dead_performance.configDict[slot3.skin]

	if lua_fight_dead_entity_mgr.configDict[slot3.skin] then
		GameSceneMgr.instance:getCurScene().entityMgr:removeUnitData(slot0._deadEntity:getTag(), slot0._deadEntity.id)
		FightController.instance:dispatchEvent(FightEvent.EntrustEntity, slot0._deadEntity)
		slot0._afterDeadFlow:addWork(WorkWaitSeconds.New(slot4.playTime / 1000))
	elseif slot5 then
		TaskDispatcher.cancelTask(slot0._delayDone, slot0)
		slot0._afterDeadFlow:addWork(FightHelper.buildDeadPerformanceWork(slot5, slot0._deadEntity))
		slot0._afterDeadFlow:addWork(FunctionWork.New(function ()
			uv0:removeUnit(uv1._deadEntity:getTag(), uv1._deadEntity.id)
		end))
	else
		slot1:removeUnit(slot0._deadEntity:getTag(), slot0._deadEntity.id)
	end

	slot0._afterDeadFlow:addWork(FunctionWork.New(slot0._dispatchDead, slot0))

	if slot2 then
		TaskDispatcher.cancelTask(slot0._delayDone, slot0)
		slot0._afterDeadFlow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.CheckDeadEntityCount))
	end

	slot0._afterDeadFlow:registerDoneListener(slot0._checkDieDialogAfter, slot0)
	slot0._afterDeadFlow:start()
end

function slot0._dispatchDead(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnEntityDead, slot0._deadEntity.id)
end

function slot0._checkDieDialogAfter(slot0)
	uv0.needStopDeadWork = nil

	if slot0._deadEntityModelId then
		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterDieP, slot0._deadEntityModelId)

		if uv0.needStopDeadWork then
			TaskDispatcher.cancelTask(slot0._delayDone, slot0)
			FightController.instance:registerCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
		else
			slot0:_onFinish()
		end
	else
		slot0:_onFinish()
	end
end

function slot0._onFightDialogEnd(slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
	slot0:_onFinish()
end

function slot0._onFinish(slot0)
	FightController.instance:dispatchEvent(FightEvent.EntityDeadFinish, slot0._deadEntityModelId)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._afterDeadFlow then
		slot0._afterDeadFlow:unregisterDoneListener(slot0._checkDieDialogAfter, slot0)
		slot0._afterDeadFlow:stop()

		slot0._afterDeadFlow = nil
	end

	TaskDispatcher.cancelTask(slot0._tick, slot0)

	if slot0._dissolveWork then
		slot0._dissolveWork:onStop()
		slot0._dissolveWork:unregisterDoneListener(slot0._onDissolveDone, slot0)

		slot0._dissolveWork = nil
	end

	FightController.instance:unregisterCallback(FightEvent.InvokeEntityDeadImmediately, slot0._invokeEntityDeadImmediately, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, slot0._onLastHit, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, slot0._onFightDialogEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.cancelTask(slot0._deadPlayEffect, slot0)
	TaskDispatcher.cancelTask(slot0._deadComplete, slot0)
	TaskDispatcher.cancelTask(slot0._delayNoDeadEffectDone, slot0)

	slot0._fightStepMO = nil
	slot0._actEffectMO = nil
end

function slot0.onResume(slot0)
	logError("dead step can't resume")
end

function slot0._isNoDeadEffect(slot0)
	if slot0._showDeadEffect == 0 then
		return true
	elseif slot0._showDeadEffect == 1 then
		return false
	end

	slot1 = slot0._deadEntity and slot0._deadEntity:getMO()
	slot2 = slot1 and slot1:getCO()
	slot3 = slot2 and FightConfig.instance:getSkinCO(slot2.skinId)

	return slot3 and slot3.noDeadEffect == FightEnum.DeadEffectType.NoEffect
end

function slot0._getDeadEffectType(slot0)
	slot1 = slot0._deadEntity and slot0._deadEntity:getMO()
	slot2 = slot1 and FightConfig.instance:getSkinCO(slot1.skin)

	return slot2 and slot2.noDeadEffect
end

return slot0
