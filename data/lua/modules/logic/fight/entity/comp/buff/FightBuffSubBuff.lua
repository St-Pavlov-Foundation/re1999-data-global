module("modules.logic.fight.entity.comp.buff.FightBuffSubBuff", package.seeall)

local var_0_0 = class("FightBuffSubBuff")

function var_0_0.onBuffStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entity = arg_1_1
	arg_1_0.entityId = arg_1_1.id
	arg_1_0.existCount = 0
	arg_1_0.effectList = {}

	FightController.instance:registerCallback(FightEvent.ASFD_PullOut, arg_1_0.pullOutAllEffect, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_1_0.onSpineLoaded, arg_1_0)

	arg_1_0.buffMo = arg_1_2

	arg_1_0:tryCreateALFResidualEffect(arg_1_2)
end

function var_0_0.onSpineLoaded(arg_2_0, arg_2_1)
	if arg_2_1.unitSpawn ~= arg_2_0.entity then
		return
	end

	arg_2_0:tryCreateALFResidualEffect(arg_2_0.buffMo)
end

function var_0_0.log(arg_3_0, arg_3_1, arg_3_2)
	logError(string.format("[%s] entityId : %s, entityName : %s, subBuffComp : %s, buffUid : %s, buffCoId : %s, buffName : %s, buffLayer : %s", arg_3_1, arg_3_0.entityId, FightHelper.getEntityName(arg_3_0.entity), arg_3_0, arg_3_2 and arg_3_2.uid, arg_3_2 and arg_3_2.buffId, arg_3_2 and arg_3_2:getCO().name, arg_3_2 and arg_3_2.layer))
end

function var_0_0.onBuffUpdate(arg_4_0, arg_4_1)
	arg_4_0.buffMo = arg_4_1

	arg_4_0:tryCreateALFResidualEffect(arg_4_1)
end

function var_0_0.tryCreateALFResidualEffect(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.entity.spine
	local var_5_1 = var_5_0 and var_5_0:getSpineGO()

	if gohelper.isNil(var_5_1) then
		return
	end

	while arg_5_0.existCount < arg_5_1.layer do
		if not FightDataHelper.ASFDDataMgr:checkCanAddALFResidual(arg_5_0.entityId) then
			break
		end

		local var_5_2 = FightDataHelper.ASFDDataMgr:popEntityResidualData(arg_5_0.entityId)
		local var_5_3

		if var_5_2 and var_5_2.missileRes then
			var_5_3 = lua_fight_sp_effect_alf.configDict[var_5_2.missileRes]
		else
			var_5_3 = FightHeroSpEffectConfig.instance:getRandomAlfASFDMissileRes()
		end

		local var_5_4 = var_5_3 and var_5_3.residualRes

		if not string.nilorempty(var_5_4) then
			local var_5_5 = arg_5_0.entity.effect:addHangEffect(var_5_4, ModuleEnum.SpineHangPoint.mountbody)

			FightRenderOrderMgr.instance:addEffectWrapByOrder(arg_5_0.entityId, var_5_5, FightRenderOrderMgr.MaxOrder)
			var_5_5:setLocalPos(0, 0, 0)

			local var_5_6 = var_5_2 and var_5_2.startPos
			local var_5_7 = var_5_2 and var_5_2.endPos
			local var_5_8

			if var_5_6 and var_5_7 then
				var_5_8 = FightASFDHelper.getZRotation(var_5_6.x, var_5_6.y, var_5_7.x, var_5_7.y)
			else
				var_5_8 = math.random(-30, 30)
			end

			arg_5_0:setRotation(var_5_5.containerGO.transform, var_5_8)
			table.insert(arg_5_0.effectList, {
				var_5_5,
				var_5_3,
				var_5_8
			})
			arg_5_0.entity.buff:addLoopBuff(var_5_5)
		end

		arg_5_0.existCount = arg_5_0.existCount + 1

		FightDataHelper.ASFDDataMgr:addALFResidual(arg_5_0.entityId, 1)
	end
end

function var_0_0.pullOutAllEffect(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.effectList) do
		local var_6_0 = iter_6_1[1]
		local var_6_1 = iter_6_1[2]
		local var_6_2 = iter_6_1[3]

		if arg_6_0.entity then
			arg_6_0.entity.buff:removeLoopBuff(var_6_0)
			arg_6_0.entity.effect:removeEffect(var_6_0)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_6_0.entityId, var_6_0)

		if var_6_1 and arg_6_0.entity then
			if arg_6_0.entity.effect:isDestroyed() then
				if isDebugBuild then
					logError(string.format("entityName : %s, effectComp is destroyed", FightHelper.getEntityName(arg_6_0.entity)))
				end
			else
				local var_6_3 = arg_6_0.entity.effect:addHangEffect(var_6_1.pullOutRes, ModuleEnum.SpineHangPoint.mountmiddle, nil, 1)

				var_6_3:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:addEffectWrapByOrder(arg_6_0.entityId, var_6_3, FightRenderOrderMgr.MaxOrder)
				arg_6_0:setRotation(var_6_3.containerGO.transform, var_6_2)
				arg_6_0:playAudio(var_6_1.audioId)
			end
		end
	end

	FightDataHelper.ASFDDataMgr:removeALFResidual(arg_6_0.entityId, #arg_6_0.effectList)
	tabletool.clear(arg_6_0.effectList)
end

function var_0_0.setRotation(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1.parent
	local var_7_1, var_7_2, var_7_3 = transformhelper.getLocalRotation(var_7_0)

	arg_7_2 = 180 - arg_7_2 + var_7_3

	transformhelper.setLocalRotation(arg_7_1, 0, 0, arg_7_2)
end

function var_0_0.playAudio(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	if arg_8_1 ~= 0 then
		AudioMgr.instance:trigger(arg_8_1)
	end
end

function var_0_0.onOpenView(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.FightFocusView then
		arg_9_0:setEffectActive(false)
	end
end

function var_0_0.onCloseViewFinish(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.FightFocusView then
		arg_10_0:setEffectActive(true)
	end
end

function var_0_0.onSkillPlayStart(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1:getMO() and FightCardDataHelper.isBigSkill(arg_11_2) then
		arg_11_0:setEffectActive(false)
	end
end

function var_0_0.onSkillPlayFinish(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_1:getMO() and FightCardDataHelper.isBigSkill(arg_12_2) then
		arg_12_0:setEffectActive(true)
	end
end

function var_0_0.setEffectActive(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.effectList) do
		iter_13_1[1]:setActive(arg_13_1)
	end
end

function var_0_0.clear(arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.ASFD_PullOut, arg_14_0.pullOutAllEffect, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_14_0.onSpineLoaded, arg_14_0)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.effectList) do
		local var_14_0 = iter_14_1[1]

		if arg_14_0.entity then
			arg_14_0.entity.buff:removeLoopBuff(var_14_0)
			arg_14_0.entity.effect:removeEffect(var_14_0)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_14_0.entityId, var_14_0)
	end

	FightDataHelper.ASFDDataMgr:removeALFResidual(arg_14_0.entityId, #arg_14_0.effectList)
	tabletool.clear(arg_14_0.effectList)
end

function var_0_0.onBuffEnd(arg_15_0)
	arg_15_0:clear()
end

function var_0_0.dispose(arg_16_0)
	arg_16_0:clear()
end

return var_0_0
