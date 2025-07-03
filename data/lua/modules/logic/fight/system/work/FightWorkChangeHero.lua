module("modules.logic.fight.system.work.FightWorkChangeHero", package.seeall)

local var_0_0 = class("FightWorkChangeHero", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if FightModel.instance:getVersion() < 4 then
		arg_1_0:onDone(true)

		return
	end

	if not arg_1_0.actEffectData.entity then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0:com_registTimer(arg_1_0._delayDone, 5)

	arg_1_0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	arg_1_0._targetId = arg_1_0.actEffectData.targetId

	FightRenderOrderMgr.instance:unregister(arg_1_0._targetId)

	arg_1_0._targetEntity = FightHelper.getEntity(arg_1_0._targetId)

	if FightEntityDataHelper.isPlayerUid(arg_1_0._targetId) then
		arg_1_0._targetEntity = nil
	end

	arg_1_0._changedId = arg_1_0.actEffectData.entity.id
	arg_1_0._changedSubEntity = FightHelper.getEntity(arg_1_0._changedId)
	arg_1_0._changedEntityMO = FightDataHelper.entityMgr:getById(arg_1_0._changedId)

	FightController.instance:dispatchEvent(FightEvent.BeforeChangeSubHero, arg_1_0._targetId, arg_1_0._changedId)

	arg_1_0._seasonUseChangeHero = FightModel.instance:isSeason2() and arg_1_0.actEffectData.configEffect == 1

	if arg_1_0._changedEntityMO.side == FightEnum.EntitySide.MySide then
		if arg_1_0._seasonUseChangeHero then
			arg_1_0:_startChangeHero()
		elseif arg_1_0._changedSubEntity and arg_1_0._changedSubEntity.spine:getSpineGO() ~= nil then
			arg_1_0:_startChangeHero()
		else
			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_1_0._onSubSpineLoaded, arg_1_0)

			arg_1_0._toBuildSubId = arg_1_0._changedEntityMO.id

			if not arg_1_0._changedSubEntity then
				local var_1_0 = arg_1_0._entityMgr:buildSubSpine(arg_1_0._changedEntityMO)

				if var_1_0 then
					local var_1_1 = lua_stance.configDict[FightHelper.getEntityStanceId(arg_1_0._changedEntityMO)]

					if var_1_1 then
						local var_1_2 = var_1_1.subPos1

						transformhelper.setLocalPos(var_1_0.go.transform, var_1_2[1] or 0, var_1_2[2] or 0, var_1_2[3] or 0)
					end
				end
			end
		end
	else
		arg_1_0:_startChangeHero()
	end
end

function var_0_0._startChangeHero(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.OnStartChangeEntity, arg_2_0._changedEntityMO)

	if arg_2_0._targetEntity then
		local var_2_0 = FightModel.instance:getSpeed()

		if arg_2_0._targetEntity.spineRenderer then
			arg_2_0._targetEntity.spineRenderer:setAlpha(0, 0.4 / var_2_0)

			local var_2_1 = "always/ui_renwuxiaoshi"
			local var_2_2

			if arg_2_0.actEffectData.configEffect == 1 then
				var_2_1 = "buff/buff_huanren"
				var_2_2 = ModuleEnum.SpineHangPoint.mountmiddle
			end

			if not arg_2_0._seasonUseChangeHero then
				local var_2_3 = arg_2_0._targetEntity.effect:addHangEffect(var_2_1, var_2_2)

				var_2_3:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:onAddEffectWrap(arg_2_0._targetEntity.id, var_2_3)
			end
		end

		if FightModel.instance:isSeason2() then
			arg_2_0:_targetEntityQuitFinish()
			AudioMgr.instance:trigger(410000103)
		else
			TaskDispatcher.runDelay(arg_2_0._targetEntityQuitFinish, arg_2_0, 0.4 / var_2_0)
		end
	else
		arg_2_0:_targetEntityQuitFinish()
	end
end

function var_0_0._targetEntityQuitFinish(arg_3_0)
	if arg_3_0._targetEntity then
		arg_3_0._entityMgr:removeUnit(arg_3_0._targetEntity:getTag(), arg_3_0._targetEntity.id)
	end

	if arg_3_0._changedEntityMO.side == FightEnum.EntitySide.MySide and not arg_3_0._seasonUseChangeHero then
		arg_3_0:_playJumpTimeline()
	else
		arg_3_0:_entityEnter()
	end
end

function var_0_0._playJumpTimeline(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = FightHelper.getEntityStandPos(arg_4_0._changedEntityMO)
	local var_4_3 = {
		actId = 0,
		customType = "change_hero",
		actEffect = {
			{
				targetId = arg_4_0._targetId
			}
		},
		fromId = arg_4_0._changedId,
		toId = arg_4_0._targetId,
		actType = FightEnum.ActType.SKILL,
		forcePosX = var_4_0,
		forcePosY = var_4_1,
		forcePosZ = var_4_2
	}
	local var_4_4
	local var_4_5 = SkinConfig.instance:getSkinCo(arg_4_0._changedEntityMO.skin)

	if var_4_5 and not string.nilorempty(var_4_5.alternateSpineJump) then
		var_4_4 = var_4_5.alternateSpineJump
	end

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_4_0._onSkillPlayStart, arg_4_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_4_0._onSkillPlayFinish, arg_4_0)

	arg_4_0._subEntity = GameSceneMgr.instance:getCurScene().entityMgr:buildTempSceneEntity("tibushangzhen" .. arg_4_0._changedEntityMO.id)
	var_0_0.playingChangeHero = true

	arg_4_0._subEntity.skill:playTimeline(var_4_4 or "change_hero_common", var_4_3)
end

function var_0_0._removeSubEntity(arg_5_0)
	if arg_5_0._changedSubEntity and arg_5_0._changedSubEntity.go then
		arg_5_0._entityMgr:destroyUnit(arg_5_0._changedSubEntity)

		arg_5_0._changedSubEntity = nil
	end
end

function var_0_0._onSkillPlayFinish(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0._subEntity then
		arg_6_0:_removeSubEntity()
	end
end

function var_0_0._onSkillPlayStart(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._subEntity then
		arg_7_0._timeline_duration = arg_7_1.skill and arg_7_1.skill:getCurTimelineDuration()

		TaskDispatcher.runDelay(arg_7_0._entityEnter, arg_7_0, arg_7_0._timeline_duration * 0.8)
	end
end

function var_0_0._entityEnter(arg_8_0)
	if arg_8_0._changedSubEntity then
		if arg_8_0._timeline_duration then
			local var_8_0 = arg_8_0._timeline_duration * 0.2 / FightModel.instance:getSpeed()

			arg_8_0._changedSubEntity:setAlpha(0, var_8_0)

			arg_8_0._need_invoke_remove_sub_entity = true

			arg_8_0._entityMgr:removeUnitData(arg_8_0._changedSubEntity:getTag(), arg_8_0._changedSubEntity.id)
		else
			arg_8_0._entityMgr:removeUnit(arg_8_0._changedSubEntity:getTag(), arg_8_0._changedSubEntity.id)
		end
	end

	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_8_0._onEnterEntitySpineLoadFinish, arg_8_0)

	arg_8_0._newEntity = arg_8_0._entityMgr:buildSpine(arg_8_0._changedEntityMO)
end

function var_0_0._onEnterEntitySpineLoadFinish(arg_9_0, arg_9_1)
	if arg_9_1.unitSpawn.id == arg_9_0._changedEntityMO.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_9_0._onEnterEntitySpineLoadFinish, arg_9_0)

		local var_9_0 = arg_9_0._entityMgr:getEntity(arg_9_0._changedEntityMO.id)

		if arg_9_0._seasonUseChangeHero then
			if var_9_0 then
				var_9_0:resetEntity()
			end

			arg_9_0:_onEntityBornDone()

			local var_9_1 = "always/ui_renwuxiaoshi"
			local var_9_2

			if arg_9_0.actEffectData.configEffect == 1 then
				var_9_1 = "buff/buff_huanren"
				var_9_2 = ModuleEnum.SpineHangPoint.mountmiddle
			end

			local var_9_3 = var_9_0.effect:addHangEffect(var_9_1, var_9_2, nil, 2)

			var_9_3:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(var_9_0.id, var_9_3)

			local var_9_4 = var_9_0 and var_9_0.buff

			if var_9_4 then
				xpcall(var_9_4.dealStartBuff, __G__TRACKBACK__, var_9_4)
			end

			return
		end

		arg_9_0._work = FightWorkStartBornNormal.New(var_9_0, false)

		arg_9_0._work:registerDoneListener(arg_9_0._onEntityBornDone, arg_9_0)
		arg_9_0._work:onStart()

		if var_9_0:isMySide() then
			FightAudioMgr.instance:playHeroVoiceRandom(arg_9_0._changedEntityMO.modelId, CharacterEnum.VoiceType.EnterFight)
		end
	end
end

function var_0_0.sortSubList()
	return
end

function var_0_0._onEntityBornDone(arg_11_0)
	if arg_11_0._work then
		arg_11_0._work:unregisterDoneListener(arg_11_0._onEntityBornDone, arg_11_0)
	end

	FightController.instance:dispatchEvent(FightEvent.OnChangeEntity, arg_11_0._newEntity)
	GameSceneMgr.instance:getCurScene().entityMgr:showSubEntity()
	arg_11_0:onDone(true)
end

function var_0_0._onSubSpineLoaded(arg_12_0, arg_12_1)
	if arg_12_1.unitSpawn.id == arg_12_0._toBuildSubId then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_12_0._onSubSpineLoaded, arg_12_0)

		arg_12_0._changedSubEntity = FightHelper.getEntity(arg_12_0._changedId)

		arg_12_0:_startChangeHero()
	end
end

function var_0_0._delayDone(arg_13_0)
	logError("换人超时")
	arg_13_0:onDone(true)
end

function var_0_0.clearWork(arg_14_0)
	var_0_0.playingChangeHero = false

	if arg_14_0._subEntity then
		local var_14_0 = GameSceneMgr.instance:getCurScene().entityMgr

		if var_14_0 then
			var_14_0:removeUnit(arg_14_0._subEntity:getTag(), arg_14_0._subEntity.id)
		end

		arg_14_0._subEntity = nil
	end

	if arg_14_0._need_invoke_remove_sub_entity then
		arg_14_0:_removeSubEntity()
	end

	TaskDispatcher.cancelTask(arg_14_0._targetEntityQuitFinish, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._entityEnter, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_14_0._onSubSpineLoaded, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_14_0._onSkillPlayStart, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_14_0._onSkillPlayFinish, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_14_0._onNextSubSpineLoaded, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_14_0._onEnterEntitySpineLoadFinish, arg_14_0)

	arg_14_0.fightStepData = nil

	if arg_14_0._work then
		arg_14_0._work:unregisterDoneListener(arg_14_0._onEntityBornDone, arg_14_0)
		arg_14_0._work:onStop()

		arg_14_0._work = nil
	end

	arg_14_0._timeline_duration = nil
end

function var_0_0.onDestroy(arg_15_0)
	if arg_15_0._nextSubBornFlow then
		arg_15_0._nextSubBornFlow:stop()

		arg_15_0._nextSubBornFlow = nil
	end

	var_0_0.super.onDestroy(arg_15_0)
end

return var_0_0
