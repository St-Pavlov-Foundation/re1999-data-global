module("modules.logic.fight.system.work.FightWorkInjuryBankHeal", package.seeall)

local var_0_0 = class("FightWorkInjuryBankHeal", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = 2 / FightModel.instance:getSpeed()
	local var_1_1 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if var_1_1 then
		if var_1_1.nameUI then
			local var_1_2 = arg_1_0.actEffectData.effectNum
			local var_1_3 = FightEnum.FloatType.heal

			FightFloatMgr.instance:float(var_1_1.id, var_1_3, var_1_2, nil, arg_1_0.actEffectData.effectNum1 == 1)
			var_1_1.nameUI:addHp(var_1_2)
			FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_1, var_1_2)
		end

		local var_1_4 = var_1_1.spine and var_1_1.spine:getSpineGO()

		if not var_1_4 then
			arg_1_0:onDone(true)

			return
		end

		if not var_1_1.effect then
			arg_1_0:onDone(true)

			return
		end

		local var_1_5 = var_1_1.effect:addHangEffect("buff/buff_jiaxue", nil, nil, var_1_0)

		FightRenderOrderMgr.instance:onAddEffectWrap(var_1_1.id, var_1_5)
		var_1_5:setLocalPos(0, 0, 0)
		FightAudioMgr.instance:playAudio(410000015)

		local var_1_6 = FightDataHelper.entityMgr:getById(var_1_1.id)

		if not var_1_6 then
			arg_1_0:onDone(true)

			return
		end

		local var_1_7 = var_1_6:getBuffDic()
		local var_1_8 = false

		for iter_1_0, iter_1_1 in pairs(var_1_7) do
			if FightConfig.instance:hasBuffFeature(iter_1_1.buffId, FightEnum.BuffFeature.InjuryBank) then
				var_1_8 = true

				break
			end
		end

		if var_1_8 then
			local var_1_9 = gohelper.findChild(var_1_4, ModuleEnum.SpineHangPointRoot)

			if not (var_1_9 and gohelper.findChild(var_1_9, "special1")) then
				arg_1_0:onDone(true)

				return
			end

			local var_1_10 = lua_fight_sp_effect_kkny_heal.configDict[var_1_6.skin]

			if not var_1_10 then
				arg_1_0:onDone(true)

				return
			end

			local var_1_11 = var_1_1.effect:addHangEffect(var_1_10.path, var_1_10.hangPoint, nil, var_1_0)

			FightRenderOrderMgr.instance:onAddEffectWrap(var_1_1.id, var_1_11)
			var_1_11:setLocalPos(0, 0, 0)
			FightAudioMgr.instance:playAudio(var_1_10.audio)
		end
	end

	arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, var_1_0)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
