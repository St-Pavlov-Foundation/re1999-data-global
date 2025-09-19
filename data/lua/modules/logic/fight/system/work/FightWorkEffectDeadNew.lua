module("modules.logic.fight.system.work.FightWorkEffectDeadNew", package.seeall)

local var_0_0 = class("FightWorkEffectDeadNew", FightWorkItem)
local var_0_1 = 1
local var_0_2 = 0.35
local var_0_3 = 0.4
local var_0_4 = 1
local var_0_5 = 0.1
local var_0_6 = 0.6

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.actEffectData = arg_1_2
	arg_1_0._waitForLastHit = arg_1_3
end

function var_0_0.onStart(arg_2_0)
	arg_2_0.delayDoneTimer = arg_2_0:com_registTimer(arg_2_0._delayDone, 20)
	arg_2_0._deadEntity = FightHelper.getEntity(arg_2_0.actEffectData.targetId)

	if arg_2_0._deadEntity and not arg_2_0._deadEntity.isDead then
		arg_2_0._deadEntity.isDead = true

		if isTypeOf(arg_2_0._deadEntity, FightEntityAssembledMonsterMain) then
			arg_2_0._deadEntity:killAllSubMonster()
		end

		if isTypeOf(arg_2_0._deadEntity, FightEntityAssembledMonsterSub) then
			arg_2_0:onDone(true)

			return
		end

		arg_2_0._deadEntityModelId = arg_2_0._deadEntity:getMO().modelId

		FightController.instance:dispatchEvent(FightEvent.OnStartEntityDead, arg_2_0._deadEntity.id)

		if arg_2_0.fightStepData.actType == FightEnum.ActType.SKILL then
			arg_2_0._deadEntity.deadBySkillId = arg_2_0.fightStepData.actId
		end

		if arg_2_0._waitForLastHit then
			if not FightHelper.getEntity(arg_2_0.fightStepData.fromId) then
				arg_2_0:_playDeadWork()

				return
			end

			FightController.instance:registerCallback(FightEvent.OnSkillLastHit, arg_2_0._onLastHit, arg_2_0)
			FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
			FightController.instance:registerCallback(FightEvent.PlaySameSkillOneDone, arg_2_0._playSameSKillOneDone, arg_2_0)
			FightController.instance:registerCallback(FightEvent.InvokeEntityDeadImmediately, arg_2_0._invokeEntityDeadImmediately, arg_2_0)
		else
			arg_2_0:_playDeadWork()
		end
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._invokeEntityDeadImmediately(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:_onLastHit(arg_3_1, arg_3_2)
end

function var_0_0._onLastHit(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.fightStepData == arg_4_2 then
		if arg_4_2.actId ~= arg_4_0.fightStepData.actId then
			return
		end

		if arg_4_1 ~= arg_4_0._deadEntity.id then
			return
		end

		local var_4_0 = arg_4_0._deadEntity and arg_4_0._deadEntity:getMO()
		local var_4_1 = false

		if var_4_0 and lua_fight_skin_replay_lasthit.configDict[var_4_0.skin] then
			var_4_1 = true
		end

		if not var_4_1 and arg_4_0:_isNoDeadEffect() then
			arg_4_0._deadEntity.spine:play(SpineAnimState.hit, false, true)

			return
		end

		FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, arg_4_0._onLastHit, arg_4_0)
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_4_0._onSkillPlayFinish, arg_4_0)
		FightController.instance:unregisterCallback(FightEvent.PlaySameSkillOneDone, arg_4_0._playSameSKillOneDone, arg_4_0)
		arg_4_0:_playDeadWork()
	end
end

function var_0_0._playSameSKillOneDone(arg_5_0, arg_5_1)
	if arg_5_0.fightStepData == arg_5_1 then
		FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, arg_5_0._onLastHit, arg_5_0)
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_5_0._onSkillPlayFinish, arg_5_0)
		FightController.instance:unregisterCallback(FightEvent.PlaySameSkillOneDone, arg_5_0._playSameSKillOneDone, arg_5_0)
		arg_5_0:_playDeadWork()
	end
end

function var_0_0._onSkillPlayFinish(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0.fightStepData == arg_6_3 then
		FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, arg_6_0._onLastHit, arg_6_0)
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_6_0._onSkillPlayFinish, arg_6_0)
		FightController.instance:unregisterCallback(FightEvent.PlaySameSkillOneDone, arg_6_0._playSameSKillOneDone, arg_6_0)
		arg_6_0:_playDeadWork()
	end
end

function var_0_0._playDeadWork(arg_7_0)
	arg_7_0:com_cancelTimer(arg_7_0.delayDoneTimer)

	arg_7_0.delayDoneTimer = arg_7_0:com_registTimer(arg_7_0._delayDone, 20)

	local var_7_0 = arg_7_0._deadEntity:getMO()
	local var_7_1 = arg_7_0:_getDieActName(var_7_0)

	if var_7_1 then
		arg_7_0._deadEntity.spine:play(var_7_1, false, false)
	end

	for iter_7_0, iter_7_1 in pairs(var_7_0:getBuffDic()) do
		arg_7_0._deadEntity.buff:delBuff(iter_7_1.uid, true)
	end

	var_7_0:clearAllBuff()
	arg_7_0._deadEntity:resetSpineMat()
	FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, arg_7_0._deadEntity.id)
	FightController.instance:dispatchEvent(FightEvent.SetEntityWeatherEffectVisible, arg_7_0._deadEntity, false)
	FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, arg_7_0._deadEntity.id, arg_7_0._deadEntity.spineRenderer:getReplaceMat())

	if var_7_0.modelId == 111101 and FightModel.instance:getFightParam().episodeId == 10115 then
		arg_7_0._direct_end_work = true
	end

	local var_7_2 = "OnGuideEntityDeadPause"
	local var_7_3 = FightEvent.OnGuideEntityDeadPause
	local var_7_4 = FightEvent.OnGuideEntityDeadContinue
	local var_7_5 = arg_7_0._deadContinue
	local var_7_6 = arg_7_0
	local var_7_7 = {
		side = arg_7_0._deadEntity:getSide(),
		modelId = arg_7_0._deadEntity:getMO().modelId
	}

	if FightController.instance:GuideFlowPauseAndContinue(var_7_2, var_7_3, var_7_4, var_7_5, var_7_6, var_7_7) then
		arg_7_0:com_cancelTimer(arg_7_0.delayDoneTimer)
	end

	if arg_7_0._deadEntity.nameUI then
		arg_7_0._deadEntity.nameUI:playDeadEffect()
	end

	FightAudioMgr.instance:playHeroVoiceRandom(arg_7_0._deadEntity:getMO().modelId, CharacterEnum.VoiceType.FightDie)
end

function var_0_0._getDieActName(arg_8_0, arg_8_1)
	if lua_fight_skin_dead_performance.configDict[arg_8_1.skin] then
		return nil
	end

	local var_8_0 = SpineAnimState.die
	local var_8_1 = lua_fight_die_act_enemyus.configDict[arg_8_1.skin]

	if var_8_1 then
		if arg_8_0._deadEntity:isMySide() then
			var_8_1 = var_8_1[1]
		else
			var_8_1 = var_8_1[2]
		end

		if var_8_1 then
			arg_8_0._showDeadEffect = var_8_1.playEffect
			var_8_0 = var_8_1.act
		end
	end

	return var_8_0
end

function var_0_0._deadContinue(arg_9_0)
	local var_9_0 = arg_9_0._deadEntity:getMO()

	if lua_fight_skin_dead_performance.configDict[var_9_0.skin] then
		arg_9_0:_delayNoDeadEffectDone()
	else
		local var_9_1 = arg_9_0._deadEntity.spine:getSkeletonAnim()

		if gohelper.isNil(var_9_1) then
			-- block empty
		end

		local var_9_2 = var_9_1 and var_9_1:GetCurAnimDuration() or 0.01
		local var_9_3 = FightConfig.instance:getSkinSpineActionDict(arg_9_0._deadEntity:getMO().skin)
		local var_9_4 = var_9_3 and var_9_3[SpineAnimState.die]

		if var_9_4 and var_9_4.effectRemoveTime ~= 0 then
			var_9_2 = var_9_4.effectRemoveTime
		end

		local var_9_5 = var_9_2 / FightModel.instance:getSpeed()

		if arg_9_0:_isNoDeadEffect() then
			TaskDispatcher.runDelay(arg_9_0._delayNoDeadEffectDone, arg_9_0, var_9_5)
		else
			local var_9_6 = arg_9_0._deadEntity and arg_9_0._deadEntity:getMO()
			local var_9_7 = var_9_6 and var_9_6:isCharacter() and var_0_2 or var_0_5

			TaskDispatcher.runDelay(arg_9_0._deadComplete, arg_9_0, var_9_5 * var_9_7)
		end
	end

	if FightReplayModel.instance:isReplay() then
		TaskDispatcher.runRepeat(arg_9_0._tick, arg_9_0, 1, 10)
	end
end

function var_0_0._tick(arg_10_0)
	if FightReplayModel.instance:isReplay() then
		FightController.instance:dispatchEvent(FightEvent.ReplayTick)
	end
end

function var_0_0._deadComplete(arg_11_0)
	local var_11_0 = arg_11_0._deadEntity:getMO()
	local var_11_1 = var_11_0 and var_11_0:isCharacter() and true or false
	local var_11_2 = arg_11_0:_getDeadEffectType()

	if var_11_2 == FightEnum.DeadEffectType.NormalEffect then
		local var_11_3 = var_11_1 and var_0_3 or var_0_6

		TaskDispatcher.runDelay(arg_11_0._deadPlayEffect, arg_11_0, var_11_3 / FightModel.instance:getSpeed())
	end

	arg_11_0._dissolveWork = SpineDissolveWork.New()

	arg_11_0._dissolveWork:registerDoneListener(arg_11_0._onDissolveDone, arg_11_0)

	local var_11_4 = {
		dissolveEntity = arg_11_0._deadEntity,
		dissolveType = arg_11_0:_getDissolveType(var_11_2, var_11_1),
		timeScale = var_11_1 and var_0_1 or var_0_4
	}

	arg_11_0._dissolveWork:onStart(var_11_4)
end

function var_0_0._getDissolveType(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == FightEnum.DeadEffectType.NormalEffect then
		return arg_12_2 and FightEnum.DissolveType.Player or FightEnum.DissolveType.Monster
	elseif arg_12_1 == FightEnum.DeadEffectType.ZaoWu then
		return FightEnum.DissolveType.ZaoWu
	elseif arg_12_1 == FightEnum.DeadEffectType.Abjqr4 then
		return FightEnum.DissolveType.Abjqr4
	else
		return arg_12_2 and FightEnum.DissolveType.Player or FightEnum.DissolveType.Monster
	end
end

function var_0_0._deadPlayEffect(arg_13_0)
	local var_13_0 = arg_13_0._deadEntity:isMySide() and FightPreloadEffectWork.buff_siwang or FightPreloadEffectWork.buff_siwang_monster

	if var_13_0 == FightPreloadEffectWork.buff_siwang_monster then
		AudioMgr.instance:trigger(410000079)
	end

	if arg_13_0._deadEntity.effect:isDestroyed() then
		return
	end

	arg_13_0._effectWrap = arg_13_0._deadEntity.effect:addHangEffect(var_13_0, ModuleEnum.SpineHangPointRoot)

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_13_0._deadEntity.id, arg_13_0._effectWrap)
	arg_13_0._effectWrap:setLocalPos(0, 0, 0)
end

function var_0_0._onDissolveDone(arg_14_0)
	arg_14_0:_doneAndRemoveEntity()
end

function var_0_0._delayNoDeadEffectDone(arg_15_0)
	if arg_15_0._direct_end_work then
		arg_15_0:_checkDieDialogAfter()

		return
	end

	arg_15_0:_doneAndRemoveEntity()
end

function var_0_0._delayDone(arg_16_0)
	if FightTLEventPlayEffectByOperation.playing then
		arg_16_0.delayDoneTimer = arg_16_0:com_registTimer(arg_16_0._delayDone, 20)

		return
	end

	logError("dead step play timeout, targetId = " .. arg_16_0.actEffectData.targetId)
	arg_16_0:_doneAndRemoveEntity()
end

function var_0_0._doneAndRemoveEntity(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._deadPlayEffect, arg_17_0)

	arg_17_0._afterDeadFlow = FlowSequence.New()

	local var_17_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_17_1 = arg_17_0._deadEntity:isMySide()
	local var_17_2 = arg_17_0._deadEntity:getMO()
	local var_17_3 = lua_fight_dead_entity_mgr.configDict[var_17_2.skin]
	local var_17_4 = lua_fight_skin_dead_performance.configDict[var_17_2.skin]

	if var_17_3 then
		var_17_0:removeUnitData(arg_17_0._deadEntity:getTag(), arg_17_0._deadEntity.id)
		FightController.instance:dispatchEvent(FightEvent.EntrustEntity, arg_17_0._deadEntity)
		arg_17_0._afterDeadFlow:addWork(WorkWaitSeconds.New(var_17_3.playTime / 1000))
	elseif var_17_4 then
		arg_17_0:com_cancelTimer(arg_17_0.delayDoneTimer)
		arg_17_0._afterDeadFlow:addWork(FightHelper.buildDeadPerformanceWork(var_17_4, arg_17_0._deadEntity))
		arg_17_0._afterDeadFlow:addWork(FunctionWork.New(function()
			var_17_0:removeUnit(arg_17_0._deadEntity:getTag(), arg_17_0._deadEntity.id)
		end))
	else
		var_17_0:removeUnit(arg_17_0._deadEntity:getTag(), arg_17_0._deadEntity.id)
	end

	arg_17_0._afterDeadFlow:addWork(FunctionWork.New(arg_17_0._dispatchDead, arg_17_0))

	if var_17_1 then
		arg_17_0:com_cancelTimer(arg_17_0.delayDoneTimer)
		arg_17_0._afterDeadFlow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.CheckDeadEntityCount))
	end

	arg_17_0._afterDeadFlow:registerDoneListener(arg_17_0._checkDieDialogAfter, arg_17_0)
	arg_17_0._afterDeadFlow:start()
end

function var_0_0._dispatchDead(arg_19_0)
	FightController.instance:dispatchEvent(FightEvent.OnEntityDead, arg_19_0._deadEntity.id)
end

function var_0_0._checkDieDialogAfter(arg_20_0)
	var_0_0.needStopDeadWork = nil

	if arg_20_0._deadEntityModelId then
		FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.MonsterDieP, arg_20_0._deadEntityModelId)

		if var_0_0.needStopDeadWork then
			arg_20_0:com_cancelTimer(arg_20_0.delayDoneTimer)
			FightController.instance:registerCallback(FightEvent.FightDialogEnd, arg_20_0._onFightDialogEnd, arg_20_0)
		else
			arg_20_0:_onFinish()
		end
	else
		arg_20_0:_onFinish()
	end
end

function var_0_0._onFightDialogEnd(arg_21_0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, arg_21_0._onFightDialogEnd, arg_21_0)
	arg_21_0:_onFinish()
end

function var_0_0._onFinish(arg_22_0)
	FightController.instance:dispatchEvent(FightEvent.EntityDeadFinish, arg_22_0._deadEntityModelId)
	arg_22_0:onDone(true)
end

function var_0_0.clearWork(arg_23_0)
	if arg_23_0._afterDeadFlow then
		arg_23_0._afterDeadFlow:unregisterDoneListener(arg_23_0._checkDieDialogAfter, arg_23_0)
		arg_23_0._afterDeadFlow:stop()

		arg_23_0._afterDeadFlow = nil
	end

	TaskDispatcher.cancelTask(arg_23_0._tick, arg_23_0)

	if arg_23_0._dissolveWork then
		arg_23_0._dissolveWork:onStop()
		arg_23_0._dissolveWork:unregisterDoneListener(arg_23_0._onDissolveDone, arg_23_0)

		arg_23_0._dissolveWork = nil
	end

	FightController.instance:unregisterCallback(FightEvent.InvokeEntityDeadImmediately, arg_23_0._invokeEntityDeadImmediately, arg_23_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillLastHit, arg_23_0._onLastHit, arg_23_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_23_0._onSkillPlayFinish, arg_23_0)
	FightController.instance:unregisterCallback(FightEvent.FightDialogEnd, arg_23_0._onFightDialogEnd, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._deadPlayEffect, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._deadComplete, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._delayNoDeadEffectDone, arg_23_0)

	arg_23_0.fightStepData = nil
	arg_23_0.actEffectData = nil
end

function var_0_0.onResume(arg_24_0)
	logError("dead step can't resume")
end

function var_0_0._isNoDeadEffect(arg_25_0)
	if arg_25_0._showDeadEffect == 0 then
		return true
	elseif arg_25_0._showDeadEffect == 1 then
		return false
	end

	local var_25_0 = arg_25_0._deadEntity and arg_25_0._deadEntity:getMO()
	local var_25_1 = var_25_0 and var_25_0.skin

	if not var_25_1 then
		local var_25_2 = var_25_0 and var_25_0:getCO()

		var_25_1 = var_25_2 and var_25_2.skinId
	end

	local var_25_3 = FightConfig.instance:getSkinCO(var_25_1)

	return var_25_3 and var_25_3.noDeadEffect == FightEnum.DeadEffectType.NoEffect
end

function var_0_0._getDeadEffectType(arg_26_0)
	local var_26_0 = arg_26_0._deadEntity and arg_26_0._deadEntity:getMO()
	local var_26_1 = var_26_0 and FightConfig.instance:getSkinCO(var_26_0.skin)

	return var_26_1 and var_26_1.noDeadEffect
end

return var_0_0
