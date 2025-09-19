module("modules.logic.fight.entity.comp.buff.FightBuffSubBuff", package.seeall)

local var_0_0 = class("FightBuffSubBuff")

function var_0_0.onBuffStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entity = arg_1_1
	arg_1_0.entityId = arg_1_1.id
	arg_1_0.existCount = 0
	arg_1_0.effectList = {}

	FightController.instance:registerCallback(FightEvent.ASFD_PullOut, arg_1_0.pullOutAllEffect, arg_1_0)
	arg_1_0:tryCreateALFResidualEffect(arg_1_2)
end

function var_0_0.log(arg_2_0, arg_2_1, arg_2_2)
	logError(string.format("[%s] entityId : %s, entityName : %s, subBuffComp : %s, buffUid : %s, buffCoId : %s, buffName : %s, buffLayer : %s", arg_2_1, arg_2_0.entityId, FightHelper.getEntityName(arg_2_0.entity), arg_2_0, arg_2_2 and arg_2_2.uid, arg_2_2 and arg_2_2.buffId, arg_2_2 and arg_2_2:getCO().name, arg_2_2 and arg_2_2.layer))
end

function var_0_0.onBuffUpdate(arg_3_0, arg_3_1)
	arg_3_0:tryCreateALFResidualEffect(arg_3_1)
end

function var_0_0.tryCreateALFResidualEffect(arg_4_0, arg_4_1)
	while arg_4_0.existCount < arg_4_1.layer do
		if not FightDataHelper.ASFDDataMgr:checkCanAddALFResidual(arg_4_0.entityId) then
			break
		end

		local var_4_0 = FightDataHelper.ASFDDataMgr:popEntityResidualData(arg_4_0.entityId)
		local var_4_1

		if var_4_0 and var_4_0.missileRes then
			var_4_1 = lua_fight_sp_effect_alf.configDict[var_4_0.missileRes]
		else
			var_4_1 = FightHeroSpEffectConfig.instance:getRandomAlfASFDMissileRes()
		end

		local var_4_2 = var_4_1 and var_4_1.residualRes

		if not string.nilorempty(var_4_2) then
			local var_4_3 = arg_4_0.entity.effect:addHangEffect(var_4_2, ModuleEnum.SpineHangPoint.mountbody)

			FightRenderOrderMgr.instance:addEffectWrapByOrder(arg_4_0.entityId, var_4_3, FightRenderOrderMgr.MaxOrder)
			var_4_3:setLocalPos(0, 0, 0)

			local var_4_4 = var_4_0 and var_4_0.startPos
			local var_4_5 = var_4_0 and var_4_0.endPos
			local var_4_6

			if var_4_4 and var_4_5 then
				var_4_6 = FightASFDHelper.getZRotation(var_4_4.x, var_4_4.y, var_4_5.x, var_4_5.y)
			else
				var_4_6 = math.random(-30, 30)
			end

			arg_4_0:setRotation(var_4_3.containerGO.transform, var_4_6)
			table.insert(arg_4_0.effectList, {
				var_4_3,
				var_4_1,
				var_4_6
			})
			arg_4_0.entity.buff:addLoopBuff(var_4_3)
		end

		arg_4_0.existCount = arg_4_0.existCount + 1

		FightDataHelper.ASFDDataMgr:addALFResidual(arg_4_0.entityId, 1)
	end
end

function var_0_0.pullOutAllEffect(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.effectList) do
		local var_5_0 = iter_5_1[1]
		local var_5_1 = iter_5_1[2]
		local var_5_2 = iter_5_1[3]

		if arg_5_0.entity then
			arg_5_0.entity.buff:removeLoopBuff(var_5_0)
			arg_5_0.entity.effect:removeEffect(var_5_0)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_5_0.entityId, var_5_0)

		if var_5_1 and arg_5_0.entity then
			if arg_5_0.entity.effect:isDestroyed() then
				if isDebugBuild then
					logError(string.format("entityName : %s, effectComp is destroyed", FightHelper.getEntityName(arg_5_0.entity)))
				end
			else
				local var_5_3 = arg_5_0.entity.effect:addHangEffect(var_5_1.pullOutRes, ModuleEnum.SpineHangPoint.mountmiddle, nil, 1)

				var_5_3:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:addEffectWrapByOrder(arg_5_0.entityId, var_5_3, FightRenderOrderMgr.MaxOrder)
				arg_5_0:setRotation(var_5_3.containerGO.transform, var_5_2)
				arg_5_0:playAudio(var_5_1.audioId)
			end
		end
	end

	FightDataHelper.ASFDDataMgr:removeALFResidual(arg_5_0.entityId, #arg_5_0.effectList)
	tabletool.clear(arg_5_0.effectList)
end

function var_0_0.setRotation(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1.parent
	local var_6_1, var_6_2, var_6_3 = transformhelper.getLocalRotation(var_6_0)

	arg_6_2 = 180 - arg_6_2 + var_6_3

	transformhelper.setLocalRotation(arg_6_1, 0, 0, arg_6_2)
end

function var_0_0.playAudio(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	if arg_7_1 ~= 0 then
		AudioMgr.instance:trigger(arg_7_1)
	end
end

function var_0_0.onOpenView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.FightFocusView then
		arg_8_0:setEffectActive(false)
	end
end

function var_0_0.onCloseViewFinish(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.FightFocusView then
		arg_9_0:setEffectActive(true)
	end
end

function var_0_0.onSkillPlayStart(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_1:getMO() and FightCardDataHelper.isBigSkill(arg_10_2) then
		arg_10_0:setEffectActive(false)
	end
end

function var_0_0.onSkillPlayFinish(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1:getMO() and FightCardDataHelper.isBigSkill(arg_11_2) then
		arg_11_0:setEffectActive(true)
	end
end

function var_0_0.setEffectActive(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.effectList) do
		iter_12_1[1]:setActive(arg_12_1)
	end
end

function var_0_0.clear(arg_13_0)
	FightController.instance:unregisterCallback(FightEvent.ASFD_PullOut, arg_13_0.pullOutAllEffect, arg_13_0)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.effectList) do
		local var_13_0 = iter_13_1[1]

		if arg_13_0.entity then
			arg_13_0.entity.buff:removeLoopBuff(var_13_0)
			arg_13_0.entity.effect:removeEffect(var_13_0)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_13_0.entityId, var_13_0)
	end

	FightDataHelper.ASFDDataMgr:removeALFResidual(arg_13_0.entityId, #arg_13_0.effectList)
	tabletool.clear(arg_13_0.effectList)
end

function var_0_0.onBuffEnd(arg_14_0)
	arg_14_0:clear()
end

function var_0_0.dispose(arg_15_0)
	arg_15_0:clear()
end

return var_0_0
