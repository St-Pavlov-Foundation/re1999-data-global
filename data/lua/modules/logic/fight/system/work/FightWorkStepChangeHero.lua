module("modules.logic.fight.system.work.FightWorkStepChangeHero", package.seeall)

local var_0_0 = class("FightWorkStepChangeHero", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.isMySide(arg_2_0)
	local var_2_0 = FightDataHelper.entityMgr:getById(arg_2_0.fightStepData.fromId)

	if var_2_0 then
		return var_2_0.side == FightEnum.EntitySide.MySide
	end

	return tonumber(arg_2_0.fightStepData.fromId) > 0
end

function var_0_0.onStart(arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 5)

	arg_3_0.from_id = arg_3_0.fightStepData.fromId
	arg_3_0.to_id = arg_3_0.fightStepData.toId

	FightDataHelper.calMgr:playChangeHero(arg_3_0.fightStepData)

	arg_3_0._changedEntityMO = FightDataHelper.entityMgr:getById(arg_3_0.from_id)
	arg_3_0.entityMgr = GameSceneMgr.instance:getCurScene().entityMgr

	FightController.instance:dispatchEvent(FightEvent.BeforeChangeSubHero, arg_3_0.to_id)

	local var_3_0 = FightHelper.getEntity(arg_3_0.from_id)

	if var_3_0 and var_3_0.spine:getSpineGO() ~= nil then
		arg_3_0:_startChangeHero()
	else
		local var_3_1 = FightDataHelper.entityMgr:getById(arg_3_0.from_id)
		local var_3_2 = FightHelper.getSubEntity(var_3_1.side)

		if var_3_1 and var_3_2 then
			arg_3_0.entityMgr:removeUnit(var_3_2:getTag(), var_3_2.id)
			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_3_0._onSubSpineLoaded, arg_3_0)

			arg_3_0._toBuildSubId = var_3_1.id

			local var_3_3 = arg_3_0.entityMgr:buildSubSpine(var_3_1)

			if var_3_3 then
				local var_3_4 = lua_stance.configDict[FightHelper.getEntityStanceId(arg_3_0._changedEntityMO)]

				if var_3_4 then
					local var_3_5 = var_3_4.subPos1

					transformhelper.setLocalPos(var_3_3.go.transform, var_3_5[1] or 0, var_3_5[2] or 0, var_3_5[3] or 0)
				end
			end
		else
			arg_3_0:_startChangeHero()
		end
	end
end

function var_0_0._startChangeHero(arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.OnStartChangeEntity, arg_4_0._fromEntityMO)

	arg_4_0.from_entity = arg_4_0.entityMgr:getEntity(arg_4_0.from_id)
	arg_4_0.from_entity_mo = FightDataHelper.entityMgr:getById(arg_4_0.from_id)
	arg_4_0.to_entity = arg_4_0.entityMgr:getEntity(arg_4_0.to_id)
	arg_4_0.to_entity_mo = FightDataHelper.entityMgr:getById(arg_4_0.to_id)

	if arg_4_0.to_entity then
		local var_4_0 = FightModel.instance:getSpeed()

		if arg_4_0.to_entity.spineRenderer then
			arg_4_0.to_entity.spineRenderer:setAlpha(0, 0.4 / var_4_0)

			local var_4_1 = arg_4_0.to_entity.effect:addHangEffect("always/ui_renwuxiaoshi")

			var_4_1:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(arg_4_0.to_entity.id, var_4_1)
		end

		TaskDispatcher.runDelay(arg_4_0._targetEntityQuitFinish, arg_4_0, 0.4 / var_4_0)
	else
		arg_4_0:_targetEntityQuitFinish()
	end
end

function var_0_0._targetEntityQuitFinish(arg_5_0)
	arg_5_0._jump_end_pos = {}
	arg_5_0._jump_end_pos.x, arg_5_0._jump_end_pos.y, arg_5_0._jump_end_pos.z = FightHelper.getEntityStandPos(arg_5_0._changedEntityMO)

	if arg_5_0.to_entity then
		arg_5_0.entityMgr:removeUnit(arg_5_0.to_entity:getTag(), arg_5_0.to_entity.id)

		arg_5_0.to_entity = nil
	end

	if arg_5_0.from_entity_mo.side == FightEnum.EntitySide.MySide then
		arg_5_0:_playJumpTimeline()
	else
		arg_5_0:_entityEnter()
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

function var_0_0._playJumpTimeline(arg_8_0)
	local var_8_0 = {
		actId = 0,
		customType = "change_hero",
		actEffect = {
			{
				targetId = arg_8_0.to_id
			}
		},
		fromId = arg_8_0.from_id,
		toId = arg_8_0.to_id,
		actType = FightEnum.ActType.SKILL,
		forcePosX = arg_8_0._jump_end_pos.x,
		forcePosY = arg_8_0._jump_end_pos.y,
		forcePosZ = arg_8_0._jump_end_pos.z
	}
	local var_8_1
	local var_8_2 = SkinConfig.instance:getSkinCo(arg_8_0.from_entity_mo.skin)

	if var_8_2 and not string.nilorempty(var_8_2.alternateSpineJump) then
		var_8_1 = var_8_2.alternateSpineJump
	end

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_8_0._onSkillPlayStart, arg_8_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_8_0._onSkillPlayFinish, arg_8_0)

	arg_8_0._subEntity = GameSceneMgr.instance:getCurScene().entityMgr:buildTempSceneEntity(arg_8_0.from_id)
	var_0_0.playingChangeHero = true

	arg_8_0._subEntity.skill:playTimeline(var_8_1 or "change_hero_common", var_8_0)
end

function var_0_0._removeSubEntity(arg_9_0)
	if arg_9_0.from_entity and arg_9_0.from_entity.go then
		arg_9_0.entityMgr:destroyUnit(arg_9_0.from_entity)

		arg_9_0.from_entity = nil
	end
end

function var_0_0._entityEnter(arg_10_0)
	if arg_10_0.from_entity then
		if arg_10_0._timeline_duration then
			local var_10_0 = arg_10_0._timeline_duration * 0.2 / FightModel.instance:getSpeed()

			arg_10_0.from_entity:setAlpha(0, var_10_0)

			arg_10_0._need_invoke_remove_sub_entity = true

			arg_10_0.entityMgr:removeUnitData(arg_10_0.from_entity:getTag(), arg_10_0.from_entity.id)
		else
			arg_10_0.entityMgr:removeUnit(arg_10_0.from_entity:getTag(), arg_10_0.from_entity.id)
		end
	end

	arg_10_0.from_entity_mo:onChangeHero()
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_10_0._onEnterEntitySpineLoadFinish, arg_10_0)

	arg_10_0._newEntity = arg_10_0.entityMgr:buildSpine(arg_10_0.from_entity_mo)
end

function var_0_0._onEnterEntitySpineLoadFinish(arg_11_0, arg_11_1)
	if arg_11_1.unitSpawn.id == arg_11_0.from_entity_mo.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_11_0._onEnterEntitySpineLoadFinish, arg_11_0)

		local var_11_0 = arg_11_0.entityMgr:getEntity(arg_11_0.from_entity_mo.id)

		arg_11_0._work = FightWorkStartBornNormal.New(var_11_0, false)

		arg_11_0._work:registerDoneListener(arg_11_0._onEntityBornDone, arg_11_0)
		arg_11_0._work:onStart()

		if var_11_0:isMySide() then
			FightAudioMgr.instance:playHeroVoiceRandom(arg_11_0.from_entity_mo.modelId, CharacterEnum.VoiceType.EnterFight)
		end
	end
end

function var_0_0._onEntityBornDone(arg_12_0)
	arg_12_0._work:unregisterDoneListener(arg_12_0._onEntityBornDone, arg_12_0)
	FightController.instance:dispatchEvent(FightEvent.OnChangeEntity, arg_12_0._newEntity)

	if arg_12_0.from_entity_mo and arg_12_0.from_entity_mo.side == FightEnum.EntitySide.MySide then
		local var_12_0 = FightDataHelper.entityMgr:getMySubList()[1]

		if var_12_0 then
			arg_12_0.nextSubEntityMO = var_12_0

			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_12_0._onNextSubSpineLoaded, arg_12_0)

			arg_12_0._nextSubEntity = arg_12_0.entityMgr:buildSubSpine(var_12_0)
		end
	end

	local var_12_1 = FightDataHelper.entityMgr:getById(arg_12_0.to_id)

	if var_12_1 then
		var_12_1:onChangeHero()
	end

	arg_12_0:onDone(true)
end

function var_0_0._onNextSubSpineLoaded(arg_13_0, arg_13_1)
	if arg_13_1.unitSpawn.id == arg_13_0.nextSubEntityMO.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_13_0._onNextSubSpineLoaded, arg_13_0)

		local var_13_0 = GameSceneMgr.instance:getCurScene().entityMgr:getEntity(arg_13_0.nextSubEntityMO.id)

		arg_13_0._nextSubBornFlow = FlowSequence.New()

		arg_13_0._nextSubBornFlow:addWork(FightWorkStartBornNormal.New(var_13_0, true))
		arg_13_0._nextSubBornFlow:start()
	end
end

function var_0_0._onSubSpineLoaded(arg_14_0, arg_14_1)
	if arg_14_1.unitSpawn.id == arg_14_0._toBuildSubId then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_14_0._onSubSpineLoaded, arg_14_0)
		arg_14_0:_startChangeHero()
	end
end

function var_0_0._delayDone(arg_15_0)
	logError("change entity step timeout, targetId = " .. arg_15_0.fightStepData.fromId .. " -> " .. arg_15_0.fightStepData.toId)
	arg_15_0:onDone(true)
end

function var_0_0.clearWork(arg_16_0)
	var_0_0.playingChangeHero = false

	if arg_16_0._subEntity then
		local var_16_0 = GameSceneMgr.instance:getCurScene().entityMgr

		if var_16_0 then
			var_16_0:removeUnit(arg_16_0._subEntity:getTag(), arg_16_0._subEntity.id)
		end

		arg_16_0._subEntity = nil
	end

	if arg_16_0._need_invoke_remove_sub_entity then
		arg_16_0:_removeSubEntity()
	end

	TaskDispatcher.cancelTask(arg_16_0._delayDone, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._targetEntityQuitFinish, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._entityEnter, arg_16_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_16_0._onSubSpineLoaded, arg_16_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_16_0._onSkillPlayStart, arg_16_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_16_0._onSkillPlayFinish, arg_16_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_16_0._onNextSubSpineLoaded, arg_16_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_16_0._onEnterEntitySpineLoadFinish, arg_16_0)

	arg_16_0.fightStepData = nil

	if arg_16_0._work then
		arg_16_0._work:unregisterDoneListener(arg_16_0._onEntityBornDone, arg_16_0)
		arg_16_0._work:onStop()

		arg_16_0._work = nil
	end

	arg_16_0._timeline_duration = nil
end

function var_0_0.onResume(arg_17_0)
	logError("change entity step can't resume")
end

function var_0_0.onDestroy(arg_18_0)
	if arg_18_0._nextSubBornFlow then
		arg_18_0._nextSubBornFlow:stop()

		arg_18_0._nextSubBornFlow = nil
	end

	var_0_0.super.onDestroy(arg_18_0)
end

return var_0_0
