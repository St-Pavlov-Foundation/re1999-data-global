module("modules.logic.fight.controller.FightASFDMgr", package.seeall)

local var_0_0 = class("FightASFDMgr", FightUserDataBaseClass)

var_0_0.LoadingStatus = {
	NotLoad = 1,
	Loaded = 3,
	Loading = 2
}

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)

	arg_1_0.fightStepDataArrivedCount = {}
	arg_1_0.effectWrap2EntityIdDict = {}
	arg_1_0.sideEmitterWrap = nil
	arg_1_0.missileWrapList = {}
	arg_1_0.missileMoverList = {}
	arg_1_0.explosionWrapList = {}
	arg_1_0.playHitAnimEntityIdDict = {}
	arg_1_0.startAnimLoadingStatus = var_0_0.LoadingStatus.NotLoad
	arg_1_0.endAnimLoadingStatus = var_0_0.LoadingStatus.NotLoad

	arg_1_0:addEventCb(FightController.instance, FightEvent.AddUseCard, arg_1_0.onAddUseCard, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, arg_1_0.onMySideRoundEnd, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforePlayUniqueSkill, arg_1_0.onBeforePlayUniqueSkill, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.AfterPlayUniqueSkill, arg_1_0.onAfterPlayUniqueSkill, arg_1_0)
end

function var_0_0.playAudio(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	if arg_2_1 ~= 0 then
		AudioMgr.instance:trigger(arg_2_1)
	end
end

function var_0_0.onBeforePlayUniqueSkill(arg_3_0)
	if arg_3_0.bornEffectWrap then
		arg_3_0.bornEffectWrap:setActive(false)
	end
end

function var_0_0.onAfterPlayUniqueSkill(arg_4_0)
	if arg_4_0.bornEffectWrap then
		arg_4_0.bornEffectWrap:setActive(true)
	end
end

function var_0_0.getASFDEntityMo(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	local var_5_0 = FightPlayCardModel.instance:getUsedCards()

	if not var_5_0 then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_1 = var_5_0[iter_5_1]

		if var_5_1 then
			local var_5_2 = var_5_1.uid
			local var_5_3 = FightDataHelper.entityMgr:getById(var_5_2)

			if var_5_3 and var_5_3:isASFDEmitter() then
				return var_5_3
			end
		end
	end
end

function var_0_0.onAddUseCard(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getASFDEntityMo(arg_6_1)

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.id
	local var_6_2 = FightHelper.getEntity(var_6_1)

	if not var_6_2 then
		logError("没有找到发射奥术飞弹的实体" .. tostring(var_6_1))

		return
	end

	local var_6_3 = FightASFDHelper.getBornCo(var_6_1)
	local var_6_4 = FightASFDConfig.instance:getASFDCoRes(var_6_3)

	arg_6_0.curBornCo = var_6_3
	arg_6_0.bornEntity = var_6_2
	arg_6_0.bornEffectWrap = var_6_2.effect:addGlobalEffect(var_6_4)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(var_6_1, arg_6_0.bornEffectWrap, FightRenderOrderMgr.MaxOrder)
	arg_6_0.bornEffectWrap:setLocalPos(FightASFDHelper.getEmitterPos(var_6_0.side, var_6_3.sceneEmitterId))

	local var_6_5 = var_6_3.scale

	if var_6_5 == 0 then
		var_6_5 = 1
	end

	arg_6_0.bornEffectWrap:setEffectScale(var_6_5)
	arg_6_0:playAudio(var_6_3.audio)

	arg_6_0.effectWrap2EntityIdDict[arg_6_0.bornEffectWrap] = var_6_1
end

function var_0_0.onMySideRoundEnd(arg_7_0)
	arg_7_0:clearBornEffect()
end

function var_0_0.createEmitterWrap(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	local var_8_0 = arg_8_1.fromId
	local var_8_1 = FightDataHelper.entityMgr:getById(var_8_0)

	if not var_8_1 then
		logError("没有找到发射奥术飞弹的实体 mo")

		return
	end

	if arg_8_0.sideEmitterWrap then
		return
	end

	local var_8_2 = FightHelper.getEntity(var_8_0)

	if not var_8_2 then
		logError("没有找到发射奥术飞弹的实体")

		return
	end

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnStart, var_8_2, FightASFDConfig.instance.skillId, arg_8_1)
	arg_8_0:clearBornEffect(true)

	local var_8_3 = FightASFDHelper.getEmitterCo(var_8_0)
	local var_8_4 = FightASFDConfig.instance:getASFDCoRes(var_8_3)
	local var_8_5 = var_8_2.effect:addGlobalEffect(var_8_4)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(var_8_0, var_8_5, FightRenderOrderMgr.MaxOrder)
	var_8_5:setLocalPos(FightASFDHelper.getEmitterPos(var_8_1.side, var_8_3.sceneEmitterId))

	local var_8_6 = var_8_3.scale

	if var_8_6 == 0 then
		var_8_6 = 1
	end

	var_8_5:setEffectScale(var_8_6)
	arg_8_0:playAudio(var_8_3.audio)

	arg_8_0.sideEmitterWrap = var_8_5
	arg_8_0.effectWrap2EntityIdDict[var_8_5] = var_8_0

	arg_8_0:preloadEmitterRemoveRes(var_8_3)
	arg_8_0:playStartASFDAnim()

	return var_8_5
end

function var_0_0.preloadEmitterRemoveRes(arg_9_0, arg_9_1)
	local var_9_0 = FightASFDHelper.getASFDEmitterRemoveRes(arg_9_1)
	local var_9_1 = FightHelper.getEffectUrlWithLod(var_9_0)

	loadAbAsset(var_9_1, true)
end

function var_0_0.emitMissile(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		return arg_10_0:emitterFail(arg_10_1)
	end

	arg_10_0.curStepData = arg_10_1
	arg_10_0.fightStepDataArrivedCount[arg_10_1] = {
		0,
		0
	}

	local var_10_0 = true

	if arg_10_2 and arg_10_2.splitNum > 0 then
		var_10_0 = arg_10_0:emitterFissionMissile(arg_10_1, arg_10_2)
	else
		var_10_0 = arg_10_0:emitterNormalMissile(arg_10_1, arg_10_2)
	end

	if not var_10_0 then
		return arg_10_0:emitterFail(arg_10_1)
	end
end

function var_0_0.emitterNormalMissile(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_1 then
		return
	end

	local var_11_0 = FightASFDHelper.getMissileTargetId(arg_11_1)

	if arg_11_0:_emitterOneMissile(arg_11_1, var_11_0, arg_11_2) then
		arg_11_0.fightStepDataArrivedCount[arg_11_1][1] = arg_11_0.fightStepDataArrivedCount[arg_11_1][1] + 1

		return true
	end
end

function var_0_0.emitterFissionMissile(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_1 then
		return
	end

	arg_12_0.targetDict = arg_12_0.targetDict or {}

	tabletool.clear(arg_12_0.targetDict)

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.actEffect) do
		if FightASFDHelper.isDamageEffect(iter_12_1.effectType) then
			arg_12_0.targetDict[iter_12_1.targetId] = true
		end
	end

	local var_12_0 = true

	for iter_12_2, iter_12_3 in pairs(arg_12_0.targetDict) do
		local var_12_1 = arg_12_0:_emitterOneMissile(arg_12_1, iter_12_2, arg_12_2)

		if var_12_1 then
			var_12_0 = false
			arg_12_0.fightStepDataArrivedCount[arg_12_1][1] = arg_12_0.fightStepDataArrivedCount[arg_12_1][1] + 1

			var_12_1:setEffectScale(FightASFDConfig.instance.fissionScale)
		end
	end

	tabletool.clear(arg_12_0.targetDict)

	return not var_12_0
end

function var_0_0._emitterOneMissile(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1.fromId
	local var_13_1 = FightHelper.getEntity(var_13_0)

	if not var_13_1 then
		logError("没有找到发射奥术飞弹的实体, entityId : " .. tostring(var_13_0))

		return
	end

	if not FightHelper.getEntity(arg_13_2) then
		logError("没有找到奥术飞弹 命中实体, toId : " .. tostring(arg_13_2))

		return
	end

	local var_13_2 = FightASFDHelper.getMissileCo(var_13_0)
	local var_13_3 = FightASFDConfig.instance:getASFDCoRes(var_13_2)
	local var_13_4 = var_13_1.effect:addGlobalEffect(var_13_3)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(var_13_0, var_13_4, FightRenderOrderMgr.MaxOrder)

	local var_13_5 = FightASFDFlyPathHelper.getMissileMover(var_13_1, var_13_2, var_13_4, arg_13_2, arg_13_3, arg_13_0.onArrived, arg_13_0)

	var_13_5.missileWrap = var_13_4
	var_13_5.fightStepData = arg_13_1
	var_13_5.toId = arg_13_2
	var_13_5.asfdContext = arg_13_3
	var_13_5.missileRes = var_13_3

	local var_13_6 = var_13_2.scale

	if var_13_6 == 0 then
		var_13_6 = 1
	end

	var_13_4:setEffectScale(var_13_6)
	arg_13_0:playAudio(var_13_2.audio)
	table.insert(arg_13_0.missileMoverList, var_13_5)
	table.insert(arg_13_0.missileWrapList, var_13_4)

	arg_13_0.effectWrap2EntityIdDict[var_13_4] = var_13_0

	return var_13_4
end

function var_0_0.pullOut(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.alfResidualEffectList) do
		local var_14_0 = iter_14_1[1]
		local var_14_1 = iter_14_1[2]
		local var_14_2 = iter_14_1[3]
		local var_14_3 = FightHelper.getEntity(var_14_2)

		if var_14_3 then
			var_14_3.effect:removeEffect(var_14_0)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(var_14_2, var_14_0)

		if var_14_3 then
			local var_14_4 = lua_fight_sp_effect_alf.configDict[var_14_1]

			if var_14_4 then
				local var_14_5 = var_14_3.effect:addHangEffect(var_14_4.pullOutRes, ModuleEnum.SpineHangPoint.mountbody, nil, 1)

				var_14_5:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:addEffectWrapByOrder(var_14_2, var_14_5, FightRenderOrderMgr.MaxOrder)
				arg_14_0:playAudio(var_14_4.audioId)
			end
		end
	end

	tabletool.clear(arg_14_0.alfResidualEffectList)
end

function var_0_0.emitterFail(arg_15_0, arg_15_1)
	return arg_15_0:onASFDArrived(arg_15_1)
end

function var_0_0.onArrived(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.fightStepData
	local var_16_1 = arg_16_1.asfdContext
	local var_16_2 = arg_16_1.missileRes
	local var_16_3 = arg_16_0.fightStepDataArrivedCount[var_16_0] or {
		1,
		0
	}

	var_16_3[2] = var_16_3[2] + 1

	arg_16_0:tryAddALFResidualEffectData(var_16_2, arg_16_1)
	arg_16_0:createExplosionEffect(var_16_0, arg_16_1.toId, var_16_1)
	arg_16_0:playHitAction(arg_16_1.toId)
	arg_16_0:floatDamage(arg_16_1.fightStepData, arg_16_1.toId)
	arg_16_0:clearMover(arg_16_1)

	if var_16_3[2] >= var_16_3[1] then
		arg_16_0.fightStepDataArrivedCount[var_16_0] = nil

		return arg_16_0:onASFDArrived(var_16_0)
	end
end

function var_0_0.tryAddALFResidualEffectData(arg_17_0, arg_17_1, arg_17_2)
	if not lua_fight_sp_effect_alf.configDict[arg_17_1] then
		return
	end

	local var_17_0 = {
		missileRes = arg_17_1,
		entityId = arg_17_2.toId,
		startPos = arg_17_2:getLastStartPos(),
		endPos = arg_17_2:getLastEndPos()
	}

	FightDataHelper.ASFDDataMgr:addEntityResidualData(arg_17_2.toId, var_17_0)
end

function var_0_0.onASFDArrived(arg_18_0, arg_18_1)
	return FightController.instance:dispatchEvent(FightEvent.ASFD_OnASFDArrivedDone, arg_18_1)
end

function var_0_0.createExplosionEffect(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = FightHelper.getEntity(arg_19_2)

	if not var_19_0 then
		return
	end

	local var_19_1 = FightASFDHelper.getExplosionCo(arg_19_1 and arg_19_1.fromId)
	local var_19_2 = FightASFDConfig.instance.explosionDuration / FightModel.instance:getSpeed()
	local var_19_3 = FightASFDConfig.instance:getASFDCoRes(var_19_1)
	local var_19_4 = var_19_0.effect:addHangEffect(var_19_3, ModuleEnum.SpineHangPoint.mountbody, nil, var_19_2)

	var_19_4:setLocalPos(0, 0, 0)

	local var_19_5 = FightASFDHelper.getASFDExplosionScale(arg_19_1, var_19_1, arg_19_2)

	var_19_4:setEffectScale(var_19_5)
	arg_19_0:playAudio(var_19_1.audio)
	FightRenderOrderMgr.instance:addEffectWrapByOrder(arg_19_2, var_19_4, FightRenderOrderMgr.MaxOrder)

	arg_19_0.effectWrap2EntityIdDict[var_19_4] = arg_19_2

	table.insert(arg_19_0.explosionWrapList, var_19_4)
	TaskDispatcher.cancelTask(arg_19_0.onExplosionEffectDone, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0.onExplosionEffectDone, arg_19_0, var_19_2)
end

function var_0_0.onExplosionEffectDone(arg_20_0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_OnASFDExplosionDone)
end

function var_0_0.playHitAction(arg_21_0, arg_21_1)
	local var_21_0 = FightHelper.getEntity(arg_21_1)

	if not var_21_0 then
		return
	end

	local var_21_1 = FightHelper.processEntityActionName(var_21_0, "hit")

	var_21_0.spine:play(var_21_1, false, true, true)
	var_21_0.spine:removeAnimEventCallback(arg_21_0._onAnimEvent, arg_21_0)
	var_21_0.spine:addAnimEventCallback(arg_21_0._onAnimEvent, arg_21_0, {
		var_21_0,
		var_21_1
	})

	arg_21_0.playHitAnimEntityIdDict[arg_21_1] = true
end

function var_0_0._onAnimEvent(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = arg_22_4[1]
	local var_22_1 = arg_22_4[2]

	if arg_22_2 == SpineAnimEvent.ActionComplete and arg_22_1 == var_22_1 then
		var_22_0.spine:removeAnimEventCallback(arg_22_0._onAnimEvent, arg_22_0)
		var_22_0:resetAnimState()
	end
end

function var_0_0.floatDamage(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = FightWorkFlowSequence.New(arg_23_1)

	arg_23_0:addDamageWork(var_23_0, arg_23_1, arg_23_2)

	local var_23_1 = FightStepEffectWork.New()

	var_23_1:setFlow(var_23_0)
	var_23_1:onStartInternal()
end

function var_0_0.addDamageWork(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_2 and arg_24_2.actEffect

	if not var_24_0 then
		return
	end

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		local var_24_1 = iter_24_1.effectType

		if FightASFDHelper.isDamageEffect(var_24_1) and iter_24_1.targetId == arg_24_3 then
			local var_24_2 = FightStepBuilder.ActEffectWorkCls[var_24_1]

			if var_24_2 then
				arg_24_1:registWork(var_24_2, arg_24_2, iter_24_1)
			end
		elseif var_24_1 == FightEnum.EffectType.FIGHTSTEP then
			arg_24_0:addDamageWork(arg_24_1, iter_24_1.fightStep, arg_24_3)
		end
	end
end

function var_0_0.onContinueASFDFlowDone(arg_25_0)
	arg_25_0.curStepData = nil

	TaskDispatcher.cancelTask(arg_25_0.onExplosionEffectDone, arg_25_0)
end

function var_0_0.onASFDFlowDone(arg_26_0, arg_26_1)
	arg_26_0.curStepData = nil

	arg_26_0:clearBornEffect(true)
	arg_26_0:clearEmitterEffect(arg_26_1)
	arg_26_0:clearMissileEffect()
	arg_26_0:clearExplosionEffect()
	tabletool.clear(arg_26_0.effectWrap2EntityIdDict)
	TaskDispatcher.cancelTask(arg_26_0.onExplosionEffectDone, arg_26_0)
	arg_26_0:resetSpineAnim()
	tabletool.clear(arg_26_0.fightStepDataArrivedCount)
end

function var_0_0.clearBornEffect(arg_27_0, arg_27_1)
	if not arg_27_0.bornEffectWrap then
		return
	end

	arg_27_0:removeEffect(arg_27_0.bornEffectWrap)

	arg_27_0.bornEffectWrap = nil

	if not arg_27_1 then
		arg_27_0:createBornRemoveEffect()
	end

	arg_27_0.curBornCo = nil
	arg_27_0.bornEntity = nil
end

function var_0_0.createBornRemoveEffect(arg_28_0)
	if arg_28_0.curBornCo and arg_28_0.bornEntity then
		local var_28_0 = FightASFDHelper.getASFDBornRemoveRes(arg_28_0.curBornCo)
		local var_28_1 = arg_28_0.bornEntity.effect:addGlobalEffect(var_28_0, nil, 1)

		FightRenderOrderMgr.instance:addEffectWrapByOrder(arg_28_0.bornEntity.id, var_28_1, FightRenderOrderMgr.MaxOrder)

		local var_28_2 = arg_28_0.bornEntity:getMO()

		var_28_1:setLocalPos(FightASFDHelper.getEmitterPos(var_28_2.side, arg_28_0.curBornCo.sceneEmitterId))

		local var_28_3 = arg_28_0.curBornCo.scale

		if var_28_3 == 0 then
			var_28_3 = 1
		end

		var_28_1:setEffectScale(var_28_3)
	end
end

function var_0_0.clearEmitterEffect(arg_29_0, arg_29_1)
	if not arg_29_0.sideEmitterWrap then
		return
	end

	arg_29_0:removeEffect(arg_29_0.sideEmitterWrap)
	arg_29_0:createRemoveEmitterEffect(arg_29_1)
	arg_29_0:playEndASFDAnim()

	arg_29_0.sideEmitterWrap = nil
end

function var_0_0.createRemoveEmitterEffect(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return
	end

	local var_30_0 = arg_30_1.fromId
	local var_30_1 = FightDataHelper.entityMgr:getById(var_30_0)

	if not var_30_1 then
		return
	end

	local var_30_2 = FightHelper.getEntity(var_30_0)

	if not var_30_2 then
		return
	end

	local var_30_3 = FightASFDHelper.getEmitterCo(var_30_0)
	local var_30_4 = FightASFDHelper.getASFDEmitterRemoveRes(var_30_3)
	local var_30_5 = var_30_2.effect:addGlobalEffect(var_30_4, nil, 1)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(var_30_0, var_30_5, FightRenderOrderMgr.MaxOrder)
	var_30_5:setLocalPos(FightASFDHelper.getEmitterPos(var_30_1.side, var_30_3.sceneEmitterId))

	local var_30_6 = var_30_3.scale

	if var_30_6 == 0 then
		var_30_6 = 1
	end

	var_30_5:setEffectScale(var_30_6)
end

function var_0_0.clearMissileEffect(arg_31_0)
	if arg_31_0.missileWrapList then
		for iter_31_0, iter_31_1 in ipairs(arg_31_0.missileWrapList) do
			arg_31_0:removeEffect(iter_31_1)
		end

		tabletool.clear(arg_31_0.missileWrapList)
	end

	if arg_31_0.missileMoverList then
		for iter_31_2, iter_31_3 in ipairs(arg_31_0.missileMoverList) do
			arg_31_0:clearMover(iter_31_3)
		end

		tabletool.clear(arg_31_0.missileMoverList)
	end
end

function var_0_0.clearMover(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return
	end

	arg_32_1:unregisterCallback(UnitMoveEvent.Arrive, arg_32_0.onArrived, arg_32_0)

	arg_32_1.missileWrap = nil
	arg_32_1.fightStepData = nil
	arg_32_1.toId = nil
	arg_32_1.asfdContext = nil
	arg_32_1.missileRes = nil
end

function var_0_0.clearExplosionEffect(arg_33_0)
	if not arg_33_0.explosionWrapList then
		return
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.explosionWrapList) do
		arg_33_0:removeEffect(iter_33_1)
	end

	tabletool.clear(arg_33_0.explosionWrapList)
end

function var_0_0.removeEffect(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return
	end

	local var_34_0 = arg_34_0.effectWrap2EntityIdDict[arg_34_1]
	local var_34_1 = FightHelper.getEntity(var_34_0)

	if var_34_1 then
		var_34_1.effect:removeEffect(arg_34_1)
	end

	FightRenderOrderMgr.instance:onRemoveEffectWrap(var_34_0, arg_34_1)
end

function var_0_0.resetSpineAnim(arg_35_0)
	if not arg_35_0.playHitAnimEntityIdDict then
		return
	end

	for iter_35_0, iter_35_1 in pairs(arg_35_0.playHitAnimEntityIdDict) do
		local var_35_0 = FightHelper.getEntity(iter_35_0)

		if var_35_0 then
			var_35_0.spine:removeAnimEventCallback(arg_35_0._onAnimEvent, arg_35_0)
			var_35_0:resetAnimState()
		end
	end

	tabletool.clear(arg_35_0.playHitAnimEntityIdDict)
end

function var_0_0.playStartASFDAnim(arg_36_0)
	if arg_36_0.startAnimLoadingStatus == var_0_0.LoadingStatus.NotLoad then
		loadAbAsset(FightASFDConfig.instance.startAnimAbUrl, false, arg_36_0.loadStartAnimCallback, arg_36_0)

		arg_36_0.startAnimLoadingStatus = var_0_0.LoadingStatus.Loading

		return
	end

	if arg_36_0.startAnimLoadingStatus == var_0_0.LoadingStatus.Loading then
		return
	end

	local var_36_0 = CameraMgr.instance:getCameraRootAnimator()

	if var_36_0 then
		var_36_0.enabled = true
		var_36_0.runtimeAnimatorController = arg_36_0.startAnimController

		var_36_0:Play("v2a4_asfd_start", 0, 0)
	end
end

function var_0_0.loadStartAnimCallback(arg_37_0, arg_37_1)
	if not arg_37_1.IsLoadSuccess then
		arg_37_0.startAnimLoadingStatus = var_0_0.LoadingStatus.NotLoad

		return
	end

	arg_37_0.startAnimLoadingStatus = var_0_0.LoadingStatus.Loaded
	arg_37_0.startAssetItem = arg_37_1

	arg_37_1:Retain()

	arg_37_0.startAnimController = arg_37_1:GetResource(FightASFDConfig.instance.startAnim)

	return arg_37_0:playStartASFDAnim()
end

function var_0_0.playEndASFDAnim(arg_38_0)
	if arg_38_0.endAnimLoadingStatus == var_0_0.LoadingStatus.NotLoad then
		loadAbAsset(FightASFDConfig.instance.endAnimAbUrl, false, arg_38_0.loadEndAnimCallback, arg_38_0)

		arg_38_0.endAnimLoadingStatus = var_0_0.LoadingStatus.Loading

		return
	end

	if arg_38_0.endAnimLoadingStatus == var_0_0.LoadingStatus.Loading then
		return
	end

	local var_38_0 = CameraMgr.instance:getCameraRootAnimator()

	if var_38_0 then
		var_38_0.enabled = true
		var_38_0.runtimeAnimatorController = arg_38_0.endAnimController

		var_38_0:Play("v2a4_asfd_end", 0, 0)
	end
end

function var_0_0.loadEndAnimCallback(arg_39_0, arg_39_1)
	if not arg_39_1.IsLoadSuccess then
		arg_39_0.endAnimLoadingStatus = var_0_0.LoadingStatus.NotLoad

		return
	end

	arg_39_0.endAnimLoadingStatus = var_0_0.LoadingStatus.Loaded
	arg_39_0.endAssetItem = arg_39_1

	arg_39_1:Retain()

	arg_39_0.endAnimController = arg_39_1:GetResource(FightASFDConfig.instance.endAnim)

	return arg_39_0:playEndASFDAnim()
end

function var_0_0.removeLoader(arg_40_0)
	removeAssetLoadCb(FightASFDConfig.instance.startAnimAbUrl, arg_40_0.loadStartAnimCallback, arg_40_0)

	if arg_40_0.startAssetItem then
		arg_40_0.startAssetItem:Release()

		arg_40_0.startAssetItem = nil
	end

	removeAssetLoadCb(FightASFDConfig.instance.endAnimAbUrl, arg_40_0.loadEndAnimCallback, arg_40_0)

	if arg_40_0.endAssetItem then
		arg_40_0.endAssetItem:Release()

		arg_40_0.endAssetItem = nil
	end
end

function var_0_0.dispose(arg_41_0)
	arg_41_0:onASFDFlowDone()
	arg_41_0:removeLoader()
	var_0_0.super.dispose(arg_41_0)
end

return var_0_0
