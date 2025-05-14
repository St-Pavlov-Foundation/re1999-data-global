module("modules.logic.fight.controller.FightASFDMgr", package.seeall)

local var_0_0 = class("FightASFDMgr", FightUserDataBaseClass)

var_0_0.LoadingStatus = {
	NotLoad = 1,
	Loaded = 3,
	Loading = 2
}

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)

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

function var_0_0.onAddUseCard(arg_5_0, arg_5_1)
	local var_5_0 = FightPlayCardModel.instance:getUsedCards()
	local var_5_1 = var_5_0 and var_5_0[arg_5_1]

	if not var_5_1 then
		return
	end

	local var_5_2 = var_5_1.uid
	local var_5_3 = FightDataHelper.entityMgr:getById(var_5_2)

	if not var_5_3 then
		return
	end

	if not var_5_3:isASFDEmitter() then
		return
	end

	local var_5_4 = var_5_2 and FightHelper.getEntity(var_5_2)

	if not var_5_4 then
		logError("没有找到发射奥术飞弹的实体" .. tostring(var_5_2))

		return
	end

	local var_5_5 = FightASFDHelper.getBornCo(var_5_2)
	local var_5_6 = var_5_5.res

	arg_5_0.curBornCo = var_5_5
	arg_5_0.bornEntity = var_5_4
	arg_5_0.bornEffectWrap = var_5_4.effect:addGlobalEffect(var_5_6)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(var_5_2, arg_5_0.bornEffectWrap, FightRenderOrderMgr.MaxOrder)
	arg_5_0.bornEffectWrap:setLocalPos(FightASFDHelper.getEmitterPos(var_5_3.side))

	local var_5_7 = var_5_5.scale

	if var_5_7 == 0 then
		var_5_7 = 1
	end

	arg_5_0.bornEffectWrap:setEffectScale(var_5_7)
	arg_5_0:playAudio(var_5_5.audio)

	arg_5_0.effectWrap2EntityIdDict[arg_5_0.bornEffectWrap] = var_5_2
end

function var_0_0.onMySideRoundEnd(arg_6_0)
	arg_6_0:clearBornEffect()
end

function var_0_0.createEmitterWrap(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = arg_7_1.fromId
	local var_7_1 = FightDataHelper.entityMgr:getById(var_7_0)

	if not var_7_1 then
		logError("没有找到发射奥术飞弹的实体 mo")

		return
	end

	if arg_7_0.sideEmitterWrap then
		return
	end

	local var_7_2 = FightHelper.getEntity(var_7_0)

	if not var_7_2 then
		logError("没有找到发射奥术飞弹的实体")

		return
	end

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnStart, var_7_2, FightASFDConfig.instance.skillId, arg_7_1)
	arg_7_0:clearBornEffect(true)

	local var_7_3 = FightASFDHelper.getEmitterCo(var_7_0)
	local var_7_4 = var_7_3.res
	local var_7_5 = var_7_2.effect:addGlobalEffect(var_7_4)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(var_7_0, var_7_5, FightRenderOrderMgr.MaxOrder)
	var_7_5:setLocalPos(FightASFDHelper.getEmitterPos(var_7_1.side))

	local var_7_6 = var_7_3.scale

	if var_7_6 == 0 then
		var_7_6 = 1
	end

	var_7_5:setEffectScale(var_7_6)
	arg_7_0:playAudio(var_7_3.audio)

	arg_7_0.sideEmitterWrap = var_7_5
	arg_7_0.effectWrap2EntityIdDict[var_7_5] = var_7_0

	arg_7_0:preloadEmitterRemoveRes(var_7_3)
	arg_7_0:playStartASFDAnim()

	return var_7_5
end

function var_0_0.preloadEmitterRemoveRes(arg_8_0, arg_8_1)
	local var_8_0 = FightASFDHelper.getASFDEmitterRemoveRes(arg_8_1)
	local var_8_1 = FightHelper.getEffectUrlWithLod(var_8_0)

	loadAbAsset(var_8_1, true)
end

function var_0_0.emitMissile(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 then
		return arg_9_0:emitterFail(arg_9_1)
	end

	arg_9_0.curStepMo = arg_9_1
	arg_9_0.arriveCount = 0
	arg_9_0.missileCount = 0

	local var_9_0 = true

	if FightASFDHelper.hasASFDFissionEffect(arg_9_1) then
		var_9_0 = arg_9_0:emitterFissionMissile(arg_9_1, arg_9_2)
	else
		var_9_0 = arg_9_0:emitterNormalMissile(arg_9_1, arg_9_2)
	end

	if not var_9_0 then
		return arg_9_0:emitterFail(arg_9_1)
	end
end

function var_0_0.emitterNormalMissile(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		return
	end

	local var_10_0 = FightASFDHelper.getMissileTargetId(arg_10_1)

	if arg_10_0:_emitterOneMissile(arg_10_1, var_10_0, arg_10_2) then
		arg_10_0.missileCount = arg_10_0.missileCount + 1

		return true
	end
end

function var_0_0.emitterFissionMissile(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_1 then
		return
	end

	arg_11_0.targetDict = arg_11_0.targetDict or {}

	tabletool.clear(arg_11_0.targetDict)

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.actEffectMOs) do
		if FightASFDHelper.isDamageEffect(iter_11_1.effectType) then
			arg_11_0.targetDict[iter_11_1.targetId] = true
		end
	end

	local var_11_0 = true

	for iter_11_2, iter_11_3 in pairs(arg_11_0.targetDict) do
		local var_11_1 = arg_11_0:_emitterOneMissile(arg_11_1, iter_11_2, arg_11_2)

		if var_11_1 then
			var_11_0 = false
			arg_11_0.missileCount = arg_11_0.missileCount + 1

			var_11_1:setEffectScale(FightASFDConfig.instance.fissionScale)
		end
	end

	tabletool.clear(arg_11_0.targetDict)

	return not var_11_0
end

function var_0_0._emitterOneMissile(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1.fromId
	local var_12_1 = FightHelper.getEntity(var_12_0)

	if not var_12_1 then
		logError("没有找到发射奥术飞弹的实体, entityId : " .. tostring(var_12_0))

		return
	end

	if not FightHelper.getEntity(arg_12_2) then
		logError("没有找到奥术飞弹 命中实体, toId : " .. tostring(arg_12_2))

		return
	end

	local var_12_2 = var_12_1:getMO().side
	local var_12_3 = FightASFDHelper.getMissileCo(var_12_0)
	local var_12_4 = var_12_3.res
	local var_12_5 = var_12_1.effect:addGlobalEffect(var_12_4)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(var_12_0, var_12_5, FightRenderOrderMgr.MaxOrder)

	local var_12_6 = MonoHelper.addLuaComOnceToGo(var_12_5.containerGO, UnitMoverBezier3)

	MonoHelper.addLuaComOnceToGo(var_12_5.containerGO, UnitMoverHandler)
	var_12_6:registerCallback(UnitMoveEvent.Arrive, arg_12_0.onArrived, arg_12_0)

	var_12_6.missileWrap = var_12_5
	var_12_6.stepMo = arg_12_1
	var_12_6.toId = arg_12_2

	FightASFDHelper.changeRandomArea()

	local var_12_7 = FightASFDHelper.getStartPos(var_12_2)
	local var_12_8 = FightASFDHelper.getEndPos(arg_12_2)
	local var_12_9 = var_12_7
	local var_12_10 = FightASFDHelper.getRandomPos(var_12_7, var_12_8, var_12_3)
	local var_12_11 = var_12_10
	local var_12_12 = var_12_8

	var_12_5:setWorldPos(var_12_7.x, var_12_7.y, var_12_7.z)

	local var_12_13 = var_12_3.scale

	if var_12_13 == 0 then
		var_12_13 = 1
	end

	var_12_5:setEffectScale(var_12_13)
	arg_12_0:playAudio(var_12_3.audio)
	var_12_6:setEaseType(FightASFDConfig.instance.lineType)

	local var_12_14 = FightASFDConfig.instance:getFlyDuration(arg_12_3) / FightModel.instance:getSpeed()

	var_12_6:simpleMove(var_12_9, var_12_10, var_12_11, var_12_12, var_12_14)
	table.insert(arg_12_0.missileMoverList, var_12_6)
	table.insert(arg_12_0.missileWrapList, var_12_5)

	arg_12_0.effectWrap2EntityIdDict[var_12_5] = var_12_0

	return var_12_5
end

function var_0_0.emitterFail(arg_13_0, arg_13_1)
	return arg_13_0:onASFDArrived(arg_13_1)
end

function var_0_0.onArrived(arg_14_0, arg_14_1)
	arg_14_0.arriveCount = arg_14_0.arriveCount + 1

	local var_14_0 = arg_14_1.stepMo

	arg_14_0:createExplosionEffect(var_14_0, arg_14_1.toId)
	arg_14_0:playHitAction(arg_14_1.toId)
	arg_14_0:clearMover(arg_14_1)

	if arg_14_0.arriveCount >= arg_14_0.missileCount then
		return arg_14_0:onASFDArrived(var_14_0)
	end
end

function var_0_0.onASFDArrived(arg_15_0, arg_15_1)
	return FightController.instance:dispatchEvent(FightEvent.ASFD_OnASFDArrivedDone)
end

function var_0_0.createExplosionEffect(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = FightHelper.getEntity(arg_16_2)

	if not var_16_0 then
		return
	end

	local var_16_1 = FightASFDHelper.getExplosionCo(arg_16_1 and arg_16_1.fromId)
	local var_16_2 = FightASFDConfig.instance.explosionDuration / FightModel.instance:getSpeed()
	local var_16_3 = var_16_0.effect:addHangEffect(var_16_1.res, ModuleEnum.SpineHangPoint.mountbody, nil, var_16_2)

	var_16_3:setLocalPos(0, 0, 0)

	local var_16_4 = FightASFDHelper.getASFDExplosionScale(arg_16_1, var_16_1, arg_16_2)

	var_16_3:setEffectScale(var_16_4)
	arg_16_0:playAudio(var_16_1.audio)
	FightRenderOrderMgr.instance:addEffectWrapByOrder(arg_16_2, var_16_3, FightRenderOrderMgr.MaxOrder)

	arg_16_0.effectWrap2EntityIdDict[var_16_3] = arg_16_2

	table.insert(arg_16_0.explosionWrapList, var_16_3)
	TaskDispatcher.cancelTask(arg_16_0.onExplosionEffectDone, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0.onExplosionEffectDone, arg_16_0, var_16_2)
end

function var_0_0.onExplosionEffectDone(arg_17_0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_OnASFDExplosionDone)
end

function var_0_0.playHitAction(arg_18_0, arg_18_1)
	local var_18_0 = FightHelper.getEntity(arg_18_1)

	if not var_18_0 then
		return
	end

	local var_18_1 = FightHelper.processEntityActionName(var_18_0, "hit")

	var_18_0.spine:play(var_18_1, false, true, true)
	var_18_0.spine:removeAnimEventCallback(arg_18_0._onAnimEvent, arg_18_0)
	var_18_0.spine:addAnimEventCallback(arg_18_0._onAnimEvent, arg_18_0, {
		var_18_0,
		var_18_1
	})

	arg_18_0.playHitAnimEntityIdDict[arg_18_1] = true
end

function var_0_0._onAnimEvent(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = arg_19_4[1]
	local var_19_1 = arg_19_4[2]

	if arg_19_2 == SpineAnimEvent.ActionComplete and arg_19_1 == var_19_1 then
		var_19_0.spine:removeAnimEventCallback(arg_19_0._onAnimEvent, arg_19_0)
		var_19_0:resetAnimState()
	end
end

function var_0_0.onContinueASFDFlowDone(arg_20_0)
	arg_20_0.curStepMo = nil

	TaskDispatcher.cancelTask(arg_20_0.onExplosionEffectDone, arg_20_0)
end

function var_0_0.onASFDFlowDone(arg_21_0, arg_21_1)
	arg_21_0.curStepMo = nil

	arg_21_0:clearBornEffect(true)
	arg_21_0:clearEmitterEffect(arg_21_1)
	arg_21_0:clearMissileEffect()
	arg_21_0:clearExplosionEffect()
	tabletool.clear(arg_21_0.effectWrap2EntityIdDict)
	TaskDispatcher.cancelTask(arg_21_0.onExplosionEffectDone, arg_21_0)
	arg_21_0:resetSpineAnim()
end

function var_0_0.clearBornEffect(arg_22_0, arg_22_1)
	if not arg_22_0.bornEffectWrap then
		return
	end

	arg_22_0:removeEffect(arg_22_0.bornEffectWrap)

	arg_22_0.bornEffectWrap = nil

	if not arg_22_1 then
		arg_22_0:createBornRemoveEffect()
	end

	arg_22_0.curBornCo = nil
	arg_22_0.bornEntity = nil
end

function var_0_0.createBornRemoveEffect(arg_23_0)
	if arg_23_0.curBornCo and arg_23_0.bornEntity then
		local var_23_0 = FightASFDHelper.getASFDBornRemoveRes(arg_23_0.curBornCo)
		local var_23_1 = arg_23_0.bornEntity.effect:addGlobalEffect(var_23_0, nil, 1)

		FightRenderOrderMgr.instance:addEffectWrapByOrder(arg_23_0.bornEntity.id, var_23_1, FightRenderOrderMgr.MaxOrder)

		local var_23_2 = arg_23_0.bornEntity:getMO()

		var_23_1:setLocalPos(FightASFDHelper.getEmitterPos(var_23_2.side))

		local var_23_3 = arg_23_0.curBornCo.scale

		if var_23_3 == 0 then
			var_23_3 = 1
		end

		var_23_1:setEffectScale(var_23_3)
	end
end

function var_0_0.clearEmitterEffect(arg_24_0, arg_24_1)
	if not arg_24_0.sideEmitterWrap then
		return
	end

	arg_24_0:removeEffect(arg_24_0.sideEmitterWrap)
	arg_24_0:createRemoveEmitterEffect(arg_24_1)
	arg_24_0:playEndASFDAnim()

	arg_24_0.sideEmitterWrap = nil
end

function var_0_0.createRemoveEmitterEffect(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return
	end

	local var_25_0 = arg_25_1.fromId
	local var_25_1 = FightDataHelper.entityMgr:getById(var_25_0)

	if not var_25_1 then
		return
	end

	local var_25_2 = FightHelper.getEntity(var_25_0)

	if not var_25_2 then
		return
	end

	local var_25_3 = FightASFDHelper.getEmitterCo(var_25_0)
	local var_25_4 = FightASFDHelper.getASFDEmitterRemoveRes(var_25_3)
	local var_25_5 = var_25_2.effect:addGlobalEffect(var_25_4, nil, 1)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(var_25_0, var_25_5, FightRenderOrderMgr.MaxOrder)
	var_25_5:setLocalPos(FightASFDHelper.getEmitterPos(var_25_1.side))

	local var_25_6 = var_25_3.scale

	if var_25_6 == 0 then
		var_25_6 = 1
	end

	var_25_5:setEffectScale(var_25_6)
end

function var_0_0.clearMissileEffect(arg_26_0)
	if arg_26_0.missileWrapList then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0.missileWrapList) do
			arg_26_0:removeEffect(iter_26_1)
		end

		tabletool.clear(arg_26_0.missileWrapList)
	end

	if arg_26_0.missileMoverList then
		for iter_26_2, iter_26_3 in ipairs(arg_26_0.missileMoverList) do
			arg_26_0:clearMover(iter_26_3)
		end

		tabletool.clear(arg_26_0.missileMoverList)
	end
end

function var_0_0.clearMover(arg_27_0, arg_27_1)
	if not arg_27_1 then
		return
	end

	arg_27_1:unregisterCallback(UnitMoveEvent.Arrive, arg_27_0.onArrived, arg_27_0)

	arg_27_1.missileWrap = nil
	arg_27_1.stepMo = nil
	arg_27_1.toId = nil
end

function var_0_0.clearExplosionEffect(arg_28_0)
	if not arg_28_0.explosionWrapList then
		return
	end

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.explosionWrapList) do
		arg_28_0:removeEffect(iter_28_1)
	end

	tabletool.clear(arg_28_0.explosionWrapList)
end

function var_0_0.removeEffect(arg_29_0, arg_29_1)
	if not arg_29_1 then
		return
	end

	local var_29_0 = arg_29_0.effectWrap2EntityIdDict[arg_29_1]
	local var_29_1 = FightHelper.getEntity(var_29_0)

	if var_29_1 then
		var_29_1.effect:removeEffect(arg_29_1)
	end

	FightRenderOrderMgr.instance:onRemoveEffectWrap(var_29_0, arg_29_1)
end

function var_0_0.resetSpineAnim(arg_30_0)
	if not arg_30_0.playHitAnimEntityIdDict then
		return
	end

	for iter_30_0, iter_30_1 in pairs(arg_30_0.playHitAnimEntityIdDict) do
		local var_30_0 = FightHelper.getEntity(iter_30_0)

		if var_30_0 then
			var_30_0.spine:removeAnimEventCallback(arg_30_0._onAnimEvent, arg_30_0)
			var_30_0:resetAnimState()
		end
	end

	tabletool.clear(arg_30_0.playHitAnimEntityIdDict)
end

function var_0_0.playStartASFDAnim(arg_31_0)
	if arg_31_0.startAnimLoadingStatus == var_0_0.LoadingStatus.NotLoad then
		loadAbAsset(FightASFDConfig.instance.startAnimAbUrl, false, arg_31_0.loadStartAnimCallback, arg_31_0)

		arg_31_0.startAnimLoadingStatus = var_0_0.LoadingStatus.Loading

		return
	end

	if arg_31_0.startAnimLoadingStatus == var_0_0.LoadingStatus.Loading then
		return
	end

	local var_31_0 = CameraMgr.instance:getCameraRootAnimator()

	if var_31_0 then
		var_31_0.enabled = true
		var_31_0.runtimeAnimatorController = arg_31_0.startAnimController

		var_31_0:Play("v2a4_asfd_start", 0, 0)
	end
end

function var_0_0.loadStartAnimCallback(arg_32_0, arg_32_1)
	if not arg_32_1.IsLoadSuccess then
		arg_32_0.startAnimLoadingStatus = var_0_0.LoadingStatus.NotLoad

		return
	end

	arg_32_0.startAnimLoadingStatus = var_0_0.LoadingStatus.Loaded
	arg_32_0.startAssetItem = arg_32_1

	arg_32_1:Retain()

	arg_32_0.startAnimController = arg_32_1:GetResource(FightASFDConfig.instance.startAnim)

	return arg_32_0:playStartASFDAnim()
end

function var_0_0.playEndASFDAnim(arg_33_0)
	if arg_33_0.endAnimLoadingStatus == var_0_0.LoadingStatus.NotLoad then
		loadAbAsset(FightASFDConfig.instance.endAnimAbUrl, false, arg_33_0.loadEndAnimCallback, arg_33_0)

		arg_33_0.endAnimLoadingStatus = var_0_0.LoadingStatus.Loading

		return
	end

	if arg_33_0.endAnimLoadingStatus == var_0_0.LoadingStatus.Loading then
		return
	end

	local var_33_0 = CameraMgr.instance:getCameraRootAnimator()

	if var_33_0 then
		var_33_0.enabled = true
		var_33_0.runtimeAnimatorController = arg_33_0.endAnimController

		var_33_0:Play("v2a4_asfd_end", 0, 0)
	end
end

function var_0_0.loadEndAnimCallback(arg_34_0, arg_34_1)
	if not arg_34_1.IsLoadSuccess then
		arg_34_0.endAnimLoadingStatus = var_0_0.LoadingStatus.NotLoad

		return
	end

	arg_34_0.endAnimLoadingStatus = var_0_0.LoadingStatus.Loaded
	arg_34_0.endAssetItem = arg_34_1

	arg_34_1:Retain()

	arg_34_0.endAnimController = arg_34_1:GetResource(FightASFDConfig.instance.endAnim)

	return arg_34_0:playEndASFDAnim()
end

function var_0_0.removeLoader(arg_35_0)
	removeAssetLoadCb(FightASFDConfig.instance.startAnimAbUrl, arg_35_0.loadStartAnimCallback, arg_35_0)

	if arg_35_0.startAssetItem then
		arg_35_0.startAssetItem:Release()

		arg_35_0.startAssetItem = nil
	end

	removeAssetLoadCb(FightASFDConfig.instance.endAnimAbUrl, arg_35_0.loadEndAnimCallback, arg_35_0)

	if arg_35_0.endAssetItem then
		arg_35_0.endAssetItem:Release()

		arg_35_0.endAssetItem = nil
	end
end

function var_0_0.dispose(arg_36_0)
	arg_36_0:onASFDFlowDone()
	arg_36_0:removeLoader()
	var_0_0.super.dispose(arg_36_0)
end

return var_0_0
