module("modules.logic.fight.entity.comp.skill.FightTLEventCatapult", package.seeall)

local var_0_0 = class("FightTLEventCatapult", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._paramsArr = arg_1_3
	arg_1_0.fightStepData = arg_1_1
	arg_1_0._duration = arg_1_2
	arg_1_0.index = FightTLHelper.getNumberParam(arg_1_3[1])
	arg_1_0.effectName = arg_1_3[2]
	arg_1_0.hangPoint = arg_1_3[3]

	local var_1_0 = FightTLHelper.getTableParam(arg_1_3[4], ",", true)
	local var_1_1 = FightTLHelper.getTableParam(arg_1_3[5], ",", true)

	arg_1_0.bezierParam = arg_1_3[6]
	arg_1_0.catapultAudio = FightTLHelper.getNumberParam(arg_1_3[7])
	arg_1_0.hitEffectName = arg_1_3[8]
	arg_1_0.hitStartTime = FightTLHelper.getNumberParam(arg_1_3[9]) or 0.01
	arg_1_0.hitEffectHangPoint = arg_1_3[10]
	arg_1_0.hitAudio = FightTLHelper.getNumberParam(arg_1_3[11])
	arg_1_0.buffIdList = FightTLHelper.getTableParam(arg_1_3[12], "#", true)
	arg_1_0.buffStartTime = FightTLHelper.getNumberParam(arg_1_3[13]) or 0.01
	arg_1_0.alwaysForceLookForward = FightTLHelper.getBoolParam(arg_1_3[14])
	arg_1_0.catapultReleaseTime = FightTLHelper.getNumberParam(arg_1_3[15])
	arg_1_0.hitReleaseTime = FightTLHelper.getNumberParam(arg_1_3[16])

	if string.nilorempty(arg_1_0.effectName) then
		logError("effect name is nil")

		return
	end

	arg_1_0.skillUser = FightHelper.getEntity(arg_1_1.fromId)
	arg_1_0.side = arg_1_0.skillUser:getSide()
	arg_1_0.skillUserId = arg_1_0.skillUser.id

	local var_1_2 = arg_1_0:getStartEntity()
	local var_1_3 = arg_1_0:getEndEntity()

	if not var_1_2 then
		return
	end

	if not var_1_3 then
		return
	end

	arg_1_0.startEntity = var_1_2
	arg_1_0.endEntity = var_1_3
	arg_1_0.catapultBuffCount = arg_1_0:getCatapultBuffCount(arg_1_0.index + 1)

	local var_1_4 = var_1_2:getHangPoint(arg_1_0.hangPoint)
	local var_1_5 = var_1_3:getHangPoint(arg_1_0.hangPoint)
	local var_1_6, var_1_7, var_1_8 = transformhelper.getPos(var_1_4.transform)
	local var_1_9, var_1_10, var_1_11 = transformhelper.getPos(var_1_5.transform)

	arg_1_0.effectWrap = arg_1_0.skillUser.effect:addGlobalEffect(arg_1_0.effectName, nil, arg_1_0.catapultReleaseTime)

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_1_0.skillUserId, arg_1_0.effectWrap)
	arg_1_0:startBezierMove(var_1_6 + var_1_0[1], var_1_7 + var_1_0[2], var_1_8, var_1_9 + var_1_1[1], var_1_10 + var_1_1[2], var_1_11)
	arg_1_0:changeLookDir()
	arg_1_0:playHitEffect()
	arg_1_0:playAddBuff()
	arg_1_0:playAddFirstBuff()
end

function var_0_0.playAddFirstBuff(arg_2_0)
	if arg_2_0.index ~= 1 then
		return
	end

	local var_2_0 = arg_2_0:getCatapultBuffCount(arg_2_0.index)

	if var_2_0 < 1 then
		return
	end

	local var_2_1 = FightEnum.EffectType.BUFFADD
	local var_2_2 = arg_2_0.startEntity.id
	local var_2_3 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.fightStepData.actEffect) do
		if not iter_2_1:isDone() and var_2_2 == iter_2_1.targetId and iter_2_1.effectType == var_2_1 and arg_2_0:inCheckNeedPlayBuff(iter_2_1.effectNum) then
			var_2_3 = var_2_3 + 1

			FightSkillBuffMgr.instance:playSkillBuff(arg_2_0.fightStepData, iter_2_1)
			FightDataHelper.playEffectData(iter_2_1)

			if var_2_0 <= var_2_3 then
				return
			end
		end
	end
end

function var_0_0.getCatapultBuffCount(arg_3_0, arg_3_1)
	local var_3_0 = FightEnum.EffectType.CATAPULTBUFF

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.fightStepData.actEffect) do
		if iter_3_1.effectType == var_3_0 and iter_3_1.effectNum == arg_3_1 then
			return tonumber(iter_3_1.reserveId)
		end
	end

	return 0
end

function var_0_0.getStartEntity(arg_4_0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return arg_4_0:getPosEntity(arg_4_0.index)
	else
		return arg_4_0:get217EffectEntity(arg_4_0.index)
	end
end

function var_0_0.getEndEntity(arg_5_0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return arg_5_0:getPosEntity(arg_5_0.index + 1)
	else
		return arg_5_0:get217EffectEntity(arg_5_0.index + 1)
	end
end

function var_0_0.get217EffectEntity(arg_6_0, arg_6_1)
	local var_6_0 = FightEnum.EffectType.CATAPULTBUFF

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.fightStepData.actEffect) do
		if iter_6_1.effectType == var_6_0 and iter_6_1.effectNum == arg_6_1 then
			local var_6_1 = iter_6_1.targetId

			return (GameSceneMgr.instance:getCurScene().entityMgr:getEntity(var_6_1))
		end
	end
end

function var_0_0.getPosEntity(arg_7_0, arg_7_1)
	local var_7_0 = GameSceneMgr.instance:getCurScene()

	return var_7_0.entityMgr:getEntityByPosId(SceneTag.UnitMonster, arg_7_1) or var_7_0.entityMgr:getEntityByPosId(SceneTag.UnitMonster, 1)
end

function var_0_0.startBezierMove(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	arg_8_0.effectWrap:setWorldPos(arg_8_1, arg_8_2, arg_8_3)

	arg_8_0.mover = MonoHelper.addLuaComOnceToGo(arg_8_0.effectWrap.containerGO, UnitMoverBezier)

	MonoHelper.addLuaComOnceToGo(arg_8_0.effectWrap.containerGO, UnitMoverHandler)
	arg_8_0.mover:setBezierParam(arg_8_0.bezierParam)
	arg_8_0.mover:simpleMove(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_0._duration)
	FightAudioMgr.instance:playAudio(arg_8_0.catapultAudio)
end

function var_0_0.changeLookDir(arg_9_0)
	if not arg_9_0.alwaysForceLookForward then
		return
	end

	arg_9_0.tempForwards = Vector3.New()

	arg_9_0.mover:registerCallback(UnitMoveEvent.PosChanged, arg_9_0._onPosChange, arg_9_0)
end

function var_0_0.playHitEffect(arg_10_0)
	if string.nilorempty(arg_10_0.hitEffectName) then
		return
	end

	TaskDispatcher.cancelTask(arg_10_0._playHitEffect, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0._playHitEffect, arg_10_0, arg_10_0.hitStartTime)
end

function var_0_0._playHitEffect(arg_11_0)
	local var_11_0 = arg_11_0.endEntity.effect:addHangEffect(arg_11_0.hitEffectName, arg_11_0.hitEffectHangPoint, nil, arg_11_0.hitReleaseTime)

	var_11_0:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_11_0.endEntity.id, var_11_0)
	FightAudioMgr.instance:playAudio(arg_11_0.hitAudio)
end

function var_0_0.playAddBuff(arg_12_0)
	if not arg_12_0.buffIdList then
		return
	end

	TaskDispatcher.cancelTask(arg_12_0._playAddBuff, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0._playAddBuff, arg_12_0, arg_12_0.buffStartTime)
end

function var_0_0._playAddBuff(arg_13_0)
	local var_13_0 = FightEnum.EffectType.BUFFADD
	local var_13_1 = arg_13_0.endEntity.id
	local var_13_2 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.fightStepData.actEffect) do
		if not iter_13_1:isDone() and var_13_1 == iter_13_1.targetId and iter_13_1.effectType == var_13_0 and arg_13_0:inCheckNeedPlayBuff(iter_13_1.effectNum) then
			var_13_2 = var_13_2 + 1

			FightSkillBuffMgr.instance:playSkillBuff(arg_13_0.fightStepData, iter_13_1)
			FightDataHelper.playEffectData(iter_13_1)

			if var_13_2 >= arg_13_0.catapultBuffCount then
				return
			end
		end
	end
end

function var_0_0.inCheckNeedPlayBuff(arg_14_0, arg_14_1)
	return arg_14_0.buffIdList and arg_14_1 and tabletool.indexOf(arg_14_0.buffIdList, arg_14_1)
end

function var_0_0._onPosChange(arg_15_0, arg_15_1)
	local var_15_0, var_15_1, var_15_2 = arg_15_1:getPos()
	local var_15_3, var_15_4, var_15_5 = arg_15_1:getPrePos()

	arg_15_0.tempForwards:Set(var_15_0 - var_15_3, var_15_1 - var_15_4, var_15_2 - var_15_5)

	if arg_15_0.tempForwards:Magnitude() < 1e-06 then
		return
	end

	local var_15_6 = Quaternion.LookRotation(arg_15_0.tempForwards, Vector3.up)
	local var_15_7 = FightHelper.getEffectLookDirQuaternion(arg_15_0.side)
	local var_15_8 = FightEnum.RotationQuaternion.Ninety
	local var_15_9 = var_15_6 * var_15_7 * var_15_8

	transformhelper.setRotation(arg_15_0.effectWrap.containerTr, var_15_9.x, var_15_9.y, var_15_9.z, var_15_9.w)
end

function var_0_0.removeEffectMover(arg_16_0)
	local var_16_0 = arg_16_0.effectWrap

	if not var_16_0 then
		return
	end

	MonoHelper.removeLuaComFromGo(var_16_0.containerGO, UnitMoverBezier)
	MonoHelper.removeLuaComFromGo(var_16_0.containerGO, UnitMoverHandler)

	arg_16_0.effectWrap = nil
end

function var_0_0.onTrackEnd(arg_17_0)
	return
end

function var_0_0.onDestructor(arg_18_0)
	arg_18_0:removeEffectMover()
	TaskDispatcher.cancelTask(arg_18_0._playHitEffect, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._playAddBuff, arg_18_0)

	arg_18_0.mover = nil
	arg_18_0.skillUser = nil
	arg_18_0.skillUser = nil
	arg_18_0.side = nil
	arg_18_0.skillUserId = nil
	arg_18_0.startEntity = nil
	arg_18_0.endEntity = nil
end

return var_0_0
