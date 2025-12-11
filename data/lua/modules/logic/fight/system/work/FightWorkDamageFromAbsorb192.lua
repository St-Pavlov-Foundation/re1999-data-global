module("modules.logic.fight.system.work.FightWorkDamageFromAbsorb192", package.seeall)

local var_0_0 = class("FightWorkDamageFromAbsorb192", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.hurtInfo
	local var_1_1 = var_1_0.damage
	local var_1_2 = var_1_0.reduceHp
	local var_1_3 = var_1_0.reduceShield
	local var_1_4 = arg_1_0.actEffectData.targetId
	local var_1_5 = FightHelper.getEntity(var_1_4)

	if var_1_5 then
		if var_1_1 > 0 then
			local var_1_6 = var_1_5:isMySide() and -var_1_1 or var_1_1

			FightFloatMgr.instance:float(var_1_5.id, FightEnum.FloatType.damage, var_1_6, nil, var_1_0.assassinate)

			if var_1_5.nameUI then
				var_1_5.nameUI:addHp(-var_1_2)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_5, -var_1_2)
		end

		if not var_1_5.effect then
			arg_1_0:onDone(true)

			return
		end

		local var_1_7 = var_1_5.spine and var_1_5.spine:getSpineGO()

		if not var_1_7 then
			arg_1_0:onDone(true)

			return
		end

		local var_1_8 = gohelper.findChild(var_1_7, ModuleEnum.SpineHangPointRoot)

		if not (var_1_8 and gohelper.findChild(var_1_8, "special1")) then
			arg_1_0:onDone(true)

			return
		end

		local var_1_9 = FightDataHelper.entityMgr:getById(var_1_5.id)

		if not var_1_9 then
			arg_1_0:onDone(true)

			return
		end

		local var_1_10 = lua_fight_sp_effect_kkny_bear_damage.configDict[var_1_9.skin]

		if not var_1_10 then
			arg_1_0:onDone(true)

			return
		end

		local var_1_11 = var_1_5.effect:addHangEffect(var_1_10.path, var_1_10.hangPoint, nil, 1.2 / FightModel.instance:getSpeed())

		FightAudioMgr.instance:playAudio(var_1_10.audio)
		FightRenderOrderMgr.instance:onAddEffectWrap(var_1_5.id, var_1_11)
		var_1_11:setLocalPos(0, 0, 0)
	end

	FightMsgMgr.sendMsg(FightMsgId.EntityHurt, var_1_4, var_1_0)
	arg_1_0:onDone(true)
end

return var_0_0
