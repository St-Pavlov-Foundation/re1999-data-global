module("modules.logic.fight.controller.FightASFDMgr", package.seeall)

slot0 = class("FightASFDMgr", FightUserDataBaseClass)
slot0.LoadingStatus = {
	NotLoad = 1,
	Loaded = 3,
	Loading = 2
}

function slot0.init(slot0)
	uv0.super.init(slot0)

	slot0.effectWrap2EntityIdDict = {}
	slot0.sideEmitterWrap = nil
	slot0.missileWrapList = {}
	slot0.missileMoverList = {}
	slot0.explosionWrapList = {}
	slot0.playHitAnimEntityIdDict = {}
	slot0.startAnimLoadingStatus = uv0.LoadingStatus.NotLoad
	slot0.endAnimLoadingStatus = uv0.LoadingStatus.NotLoad

	slot0:addEventCb(FightController.instance, FightEvent.AddUseCard, slot0.onAddUseCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, slot0.onMySideRoundEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforePlayUniqueSkill, slot0.onBeforePlayUniqueSkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AfterPlayUniqueSkill, slot0.onAfterPlayUniqueSkill, slot0)
end

function slot0.playAudio(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1 ~= 0 then
		AudioMgr.instance:trigger(slot1)
	end
end

function slot0.onBeforePlayUniqueSkill(slot0)
	if slot0.bornEffectWrap then
		slot0.bornEffectWrap:setActive(false)
	end
end

function slot0.onAfterPlayUniqueSkill(slot0)
	if slot0.bornEffectWrap then
		slot0.bornEffectWrap:setActive(true)
	end
end

function slot0.onAddUseCard(slot0, slot1)
	if not (FightPlayCardModel.instance:getUsedCards() and slot2[slot1]) then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot3.uid) then
		return
	end

	if not slot5:isASFDEmitter() then
		return
	end

	if not (slot4 and FightHelper.getEntity(slot4)) then
		logError("没有找到发射奥术飞弹的实体" .. tostring(slot4))

		return
	end

	slot7 = FightASFDHelper.getBornCo(slot4)
	slot0.curBornCo = slot7
	slot0.bornEntity = slot6
	slot0.bornEffectWrap = slot6.effect:addGlobalEffect(slot7.res)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(slot4, slot0.bornEffectWrap, FightRenderOrderMgr.MaxOrder)
	slot0.bornEffectWrap:setLocalPos(FightASFDHelper.getEmitterPos(slot5.side))

	if slot7.scale == 0 then
		slot9 = 1
	end

	slot0.bornEffectWrap:setEffectScale(slot9)
	slot0:playAudio(slot7.audio)

	slot0.effectWrap2EntityIdDict[slot0.bornEffectWrap] = slot4
end

function slot0.onMySideRoundEnd(slot0)
	slot0:clearBornEffect()
end

function slot0.createEmitterWrap(slot0, slot1)
	if not slot1 then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot1.fromId) then
		logError("没有找到发射奥术飞弹的实体 mo")

		return
	end

	if slot0.sideEmitterWrap then
		return
	end

	if not FightHelper.getEntity(slot2) then
		logError("没有找到发射奥术飞弹的实体")

		return
	end

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnStart, slot4, FightASFDConfig.instance.skillId, slot1)
	slot0:clearBornEffect(true)

	slot5 = FightASFDHelper.getEmitterCo(slot2)
	slot7 = slot4.effect:addGlobalEffect(slot5.res)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(slot2, slot7, FightRenderOrderMgr.MaxOrder)
	slot7:setLocalPos(FightASFDHelper.getEmitterPos(slot3.side))

	if slot5.scale == 0 then
		slot8 = 1
	end

	slot7:setEffectScale(slot8)
	slot0:playAudio(slot5.audio)

	slot0.sideEmitterWrap = slot7
	slot0.effectWrap2EntityIdDict[slot7] = slot2

	slot0:preloadEmitterRemoveRes(slot5)
	slot0:playStartASFDAnim()

	return slot7
end

function slot0.preloadEmitterRemoveRes(slot0, slot1)
	loadAbAsset(FightHelper.getEffectUrlWithLod(FightASFDHelper.getASFDEmitterRemoveRes(slot1)), true)
end

function slot0.emitMissile(slot0, slot1, slot2)
	if not slot1 then
		return slot0:emitterFail(slot1)
	end

	slot0.curStepMo = slot1
	slot0.arriveCount = 0
	slot0.missileCount = 0
	slot3 = true

	if not ((not FightASFDHelper.hasASFDFissionEffect(slot1) or slot0:emitterFissionMissile(slot1, slot2)) and slot0:emitterNormalMissile(slot1, slot2)) then
		return slot0:emitterFail(slot1)
	end
end

function slot0.emitterNormalMissile(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot0:_emitterOneMissile(slot1, FightASFDHelper.getMissileTargetId(slot1), slot2) then
		slot0.missileCount = slot0.missileCount + 1

		return true
	end
end

function slot0.emitterFissionMissile(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0.targetDict = slot0.targetDict or {}

	tabletool.clear(slot0.targetDict)

	for slot6, slot7 in ipairs(slot1.actEffectMOs) do
		if FightASFDHelper.isDamageEffect(slot7.effectType) then
			slot0.targetDict[slot7.targetId] = true
		end
	end

	slot3 = true

	for slot7, slot8 in pairs(slot0.targetDict) do
		if slot0:_emitterOneMissile(slot1, slot7, slot2) then
			slot3 = false
			slot0.missileCount = slot0.missileCount + 1

			slot9:setEffectScale(FightASFDConfig.instance.fissionScale)
		end
	end

	tabletool.clear(slot0.targetDict)

	return not slot3
end

function slot0._emitterOneMissile(slot0, slot1, slot2, slot3)
	if not FightHelper.getEntity(slot1.fromId) then
		logError("没有找到发射奥术飞弹的实体, entityId : " .. tostring(slot4))

		return
	end

	if not FightHelper.getEntity(slot2) then
		logError("没有找到奥术飞弹 命中实体, toId : " .. tostring(slot2))

		return
	end

	slot9 = FightASFDHelper.getMissileCo(slot4)
	slot11 = slot5.effect:addGlobalEffect(slot9.res)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(slot4, slot11, FightRenderOrderMgr.MaxOrder)

	slot12 = MonoHelper.addLuaComOnceToGo(slot11.containerGO, UnitMoverBezier3)

	MonoHelper.addLuaComOnceToGo(slot11.containerGO, UnitMoverHandler)
	slot12:registerCallback(UnitMoveEvent.Arrive, slot0.onArrived, slot0)

	slot12.missileWrap = slot11
	slot12.stepMo = slot1
	slot12.toId = slot2

	FightASFDHelper.changeRandomArea()

	slot13 = FightASFDHelper.getStartPos(slot5:getMO().side)
	slot14 = FightASFDHelper.getEndPos(slot2)
	slot15 = slot13
	slot17 = FightASFDHelper.getRandomPos(slot13, slot14, slot9)
	slot18 = slot14

	slot11:setWorldPos(slot13.x, slot13.y, slot13.z)

	if slot9.scale == 0 then
		slot19 = 1
	end

	slot11:setEffectScale(slot19)
	slot0:playAudio(slot9.audio)
	slot12:setEaseType(FightASFDConfig.instance.lineType)
	slot12:simpleMove(slot15, slot16, slot17, slot18, FightASFDConfig.instance:getFlyDuration(slot3) / FightModel.instance:getSpeed())
	table.insert(slot0.missileMoverList, slot12)
	table.insert(slot0.missileWrapList, slot11)

	slot0.effectWrap2EntityIdDict[slot11] = slot4

	return slot11
end

function slot0.emitterFail(slot0, slot1)
	return slot0:onASFDArrived(slot1)
end

function slot0.onArrived(slot0, slot1)
	slot0.arriveCount = slot0.arriveCount + 1

	slot0:createExplosionEffect(slot1.stepMo, slot1.toId)
	slot0:playHitAction(slot1.toId)
	slot0:clearMover(slot1)

	if slot0.missileCount <= slot0.arriveCount then
		return slot0:onASFDArrived(slot2)
	end
end

function slot0.onASFDArrived(slot0, slot1)
	return FightController.instance:dispatchEvent(FightEvent.ASFD_OnASFDArrivedDone)
end

function slot0.createExplosionEffect(slot0, slot1, slot2)
	if not FightHelper.getEntity(slot2) then
		return
	end

	slot4 = FightASFDHelper.getExplosionCo(slot1 and slot1.fromId)
	slot5 = FightASFDConfig.instance.explosionDuration / FightModel.instance:getSpeed()
	slot6 = slot3.effect:addHangEffect(slot4.res, ModuleEnum.SpineHangPoint.mountbody, nil, slot5)

	slot6:setLocalPos(0, 0, 0)
	slot6:setEffectScale(FightASFDHelper.getASFDExplosionScale(slot1, slot4, slot2))
	slot0:playAudio(slot4.audio)
	FightRenderOrderMgr.instance:addEffectWrapByOrder(slot2, slot6, FightRenderOrderMgr.MaxOrder)

	slot0.effectWrap2EntityIdDict[slot6] = slot2

	table.insert(slot0.explosionWrapList, slot6)
	TaskDispatcher.cancelTask(slot0.onExplosionEffectDone, slot0)
	TaskDispatcher.runDelay(slot0.onExplosionEffectDone, slot0, slot5)
end

function slot0.onExplosionEffectDone(slot0)
	FightController.instance:dispatchEvent(FightEvent.ASFD_OnASFDExplosionDone)
end

function slot0.playHitAction(slot0, slot1)
	if not FightHelper.getEntity(slot1) then
		return
	end

	slot3 = FightHelper.processEntityActionName(slot2, "hit")

	slot2.spine:play(slot3, false, true, true)
	slot2.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
	slot2.spine:addAnimEventCallback(slot0._onAnimEvent, slot0, {
		slot2,
		slot3
	})

	slot0.playHitAnimEntityIdDict[slot1] = true
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot4[1]

	if slot2 == SpineAnimEvent.ActionComplete and slot1 == slot4[2] then
		slot5.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		slot5:resetAnimState()
	end
end

function slot0.onContinueASFDFlowDone(slot0)
	slot0.curStepMo = nil

	TaskDispatcher.cancelTask(slot0.onExplosionEffectDone, slot0)
end

function slot0.onASFDFlowDone(slot0, slot1)
	slot0.curStepMo = nil

	slot0:clearBornEffect(true)
	slot0:clearEmitterEffect(slot1)
	slot0:clearMissileEffect()
	slot0:clearExplosionEffect()
	tabletool.clear(slot0.effectWrap2EntityIdDict)
	TaskDispatcher.cancelTask(slot0.onExplosionEffectDone, slot0)
	slot0:resetSpineAnim()
end

function slot0.clearBornEffect(slot0, slot1)
	if not slot0.bornEffectWrap then
		return
	end

	slot0:removeEffect(slot0.bornEffectWrap)

	slot0.bornEffectWrap = nil

	if not slot1 then
		slot0:createBornRemoveEffect()
	end

	slot0.curBornCo = nil
	slot0.bornEntity = nil
end

function slot0.createBornRemoveEffect(slot0)
	if slot0.curBornCo and slot0.bornEntity then
		slot2 = slot0.bornEntity.effect:addGlobalEffect(FightASFDHelper.getASFDBornRemoveRes(slot0.curBornCo), nil, 1)

		FightRenderOrderMgr.instance:addEffectWrapByOrder(slot0.bornEntity.id, slot2, FightRenderOrderMgr.MaxOrder)
		slot2:setLocalPos(FightASFDHelper.getEmitterPos(slot0.bornEntity:getMO().side))

		if slot0.curBornCo.scale == 0 then
			slot4 = 1
		end

		slot2:setEffectScale(slot4)
	end
end

function slot0.clearEmitterEffect(slot0, slot1)
	if not slot0.sideEmitterWrap then
		return
	end

	slot0:removeEffect(slot0.sideEmitterWrap)
	slot0:createRemoveEmitterEffect(slot1)
	slot0:playEndASFDAnim()

	slot0.sideEmitterWrap = nil
end

function slot0.createRemoveEmitterEffect(slot0, slot1)
	if not slot1 then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot1.fromId) then
		return
	end

	if not FightHelper.getEntity(slot2) then
		return
	end

	slot5 = FightASFDHelper.getEmitterCo(slot2)
	slot7 = slot4.effect:addGlobalEffect(FightASFDHelper.getASFDEmitterRemoveRes(slot5), nil, 1)

	FightRenderOrderMgr.instance:addEffectWrapByOrder(slot2, slot7, FightRenderOrderMgr.MaxOrder)
	slot7:setLocalPos(FightASFDHelper.getEmitterPos(slot3.side))

	if slot5.scale == 0 then
		slot8 = 1
	end

	slot7:setEffectScale(slot8)
end

function slot0.clearMissileEffect(slot0)
	if slot0.missileWrapList then
		for slot4, slot5 in ipairs(slot0.missileWrapList) do
			slot0:removeEffect(slot5)
		end

		tabletool.clear(slot0.missileWrapList)
	end

	if slot0.missileMoverList then
		for slot4, slot5 in ipairs(slot0.missileMoverList) do
			slot0:clearMover(slot5)
		end

		tabletool.clear(slot0.missileMoverList)
	end
end

function slot0.clearMover(slot0, slot1)
	if not slot1 then
		return
	end

	slot1:unregisterCallback(UnitMoveEvent.Arrive, slot0.onArrived, slot0)

	slot1.missileWrap = nil
	slot1.stepMo = nil
	slot1.toId = nil
end

function slot0.clearExplosionEffect(slot0)
	if not slot0.explosionWrapList then
		return
	end

	for slot4, slot5 in ipairs(slot0.explosionWrapList) do
		slot0:removeEffect(slot5)
	end

	tabletool.clear(slot0.explosionWrapList)
end

function slot0.removeEffect(slot0, slot1)
	if not slot1 then
		return
	end

	if FightHelper.getEntity(slot0.effectWrap2EntityIdDict[slot1]) then
		slot3.effect:removeEffect(slot1)
	end

	FightRenderOrderMgr.instance:onRemoveEffectWrap(slot2, slot1)
end

function slot0.resetSpineAnim(slot0)
	if not slot0.playHitAnimEntityIdDict then
		return
	end

	for slot4, slot5 in pairs(slot0.playHitAnimEntityIdDict) do
		if FightHelper.getEntity(slot4) then
			slot6.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
			slot6:resetAnimState()
		end
	end

	tabletool.clear(slot0.playHitAnimEntityIdDict)
end

function slot0.playStartASFDAnim(slot0)
	if slot0.startAnimLoadingStatus == uv0.LoadingStatus.NotLoad then
		loadAbAsset(FightASFDConfig.instance.startAnimAbUrl, false, slot0.loadStartAnimCallback, slot0)

		slot0.startAnimLoadingStatus = uv0.LoadingStatus.Loading

		return
	end

	if slot0.startAnimLoadingStatus == uv0.LoadingStatus.Loading then
		return
	end

	if CameraMgr.instance:getCameraRootAnimator() then
		slot1.enabled = true
		slot1.runtimeAnimatorController = slot0.startAnimController

		slot1:Play("v2a4_asfd_start", 0, 0)
	end
end

function slot0.loadStartAnimCallback(slot0, slot1)
	if not slot1.IsLoadSuccess then
		slot0.startAnimLoadingStatus = uv0.LoadingStatus.NotLoad

		return
	end

	slot0.startAnimLoadingStatus = uv0.LoadingStatus.Loaded
	slot0.startAssetItem = slot1

	slot1:Retain()

	slot0.startAnimController = slot1:GetResource(FightASFDConfig.instance.startAnim)

	return slot0:playStartASFDAnim()
end

function slot0.playEndASFDAnim(slot0)
	if slot0.endAnimLoadingStatus == uv0.LoadingStatus.NotLoad then
		loadAbAsset(FightASFDConfig.instance.endAnimAbUrl, false, slot0.loadEndAnimCallback, slot0)

		slot0.endAnimLoadingStatus = uv0.LoadingStatus.Loading

		return
	end

	if slot0.endAnimLoadingStatus == uv0.LoadingStatus.Loading then
		return
	end

	if CameraMgr.instance:getCameraRootAnimator() then
		slot1.enabled = true
		slot1.runtimeAnimatorController = slot0.endAnimController

		slot1:Play("v2a4_asfd_end", 0, 0)
	end
end

function slot0.loadEndAnimCallback(slot0, slot1)
	if not slot1.IsLoadSuccess then
		slot0.endAnimLoadingStatus = uv0.LoadingStatus.NotLoad

		return
	end

	slot0.endAnimLoadingStatus = uv0.LoadingStatus.Loaded
	slot0.endAssetItem = slot1

	slot1:Retain()

	slot0.endAnimController = slot1:GetResource(FightASFDConfig.instance.endAnim)

	return slot0:playEndASFDAnim()
end

function slot0.removeLoader(slot0)
	removeAssetLoadCb(FightASFDConfig.instance.startAnimAbUrl, slot0.loadStartAnimCallback, slot0)

	if slot0.startAssetItem then
		slot0.startAssetItem:Release()

		slot0.startAssetItem = nil
	end

	removeAssetLoadCb(FightASFDConfig.instance.endAnimAbUrl, slot0.loadEndAnimCallback, slot0)

	if slot0.endAssetItem then
		slot0.endAssetItem:Release()

		slot0.endAssetItem = nil
	end
end

function slot0.dispose(slot0)
	slot0:onASFDFlowDone()
	slot0:removeLoader()
	uv0.super.dispose(slot0)
end

return slot0
