module("modules.logic.fight.system.work.FightWorkDamageFromAbsorb", package.seeall)

local var_0_0 = class("FightWorkDamageFromAbsorb", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if var_1_0 then
		local var_1_1 = arg_1_0.actEffectData.effectNum

		if var_1_1 > 0 then
			local var_1_2 = var_1_0:isMySide() and -var_1_1 or var_1_1

			FightFloatMgr.instance:float(var_1_0.id, FightEnum.FloatType.damage, var_1_2)

			if var_1_0.nameUI then
				var_1_0.nameUI:addHp(-var_1_1)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_0, -var_1_1)
		end

		if not var_1_0.effect then
			arg_1_0:onDone(true)

			return
		end

		local var_1_3 = var_1_0.spine and var_1_0.spine:getSpineGO()

		if not var_1_3 then
			arg_1_0:onDone(true)

			return
		end

		local var_1_4 = gohelper.findChild(var_1_3, ModuleEnum.SpineHangPointRoot)

		if not (var_1_4 and gohelper.findChild(var_1_4, "special1")) then
			arg_1_0:onDone(true)

			return
		end

		local var_1_5 = FightDataHelper.entityMgr:getById(var_1_0.id)

		if not var_1_5 then
			arg_1_0:onDone(true)

			return
		end

		local var_1_6 = lua_fight_sp_effect_kkny_bear_damage.configDict[var_1_5.skin]

		if not var_1_6 then
			arg_1_0:onDone(true)

			return
		end

		local var_1_7 = var_1_0.effect:addHangEffect(var_1_6.path, var_1_6.hangPoint, nil, 1.2 / FightModel.instance:getSpeed())

		FightAudioMgr.instance:playAudio(var_1_6.audio)
		FightRenderOrderMgr.instance:onAddEffectWrap(var_1_0.id, var_1_7)
		var_1_7:setLocalPos(0, 0, 0)
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
