module("modules.logic.fight.system.work.specialdelay.FightWorkSpecialDelayModelId3070", package.seeall)

local var_0_0 = class("FightWorkSpecialDelayModelId3070", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._parentClass = arg_1_1
	arg_1_0.fightStepData = arg_1_2

	arg_1_0:onStart()
end

local var_0_1 = 0.4
local var_0_2 = 0.45

function var_0_0.onStart(arg_2_0)
	if arg_2_0.fightStepData.actType == FightEnum.ActType.SKILL then
		local var_2_0 = FightHelper.getEntity(arg_2_0.fightStepData.fromId)

		if var_2_0 and var_2_0:getMO() then
			local var_2_1 = 0
			local var_2_2

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.fightStepData.actEffect) do
				if iter_2_1.effectType == FightEnum.EffectType.BUFFADD and iter_2_1.buff then
					local var_2_3 = lua_skill_buff.configDict[iter_2_1.buff.buffId]

					if var_2_3 and FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[var_2_3.typeId] then
						var_2_1 = var_2_1 + 1

						local var_2_4 = lua_skill_bufftype.configDict[var_2_3.typeId]

						var_2_2 = var_2_2 or tonumber(string.split(var_2_4.includeTypes, "#")[2])
					end
				end
			end

			if var_2_1 > 0 then
				local var_2_5 = math.min(var_2_1, var_2_2)

				TaskDispatcher.runDelay(arg_2_0._delay, arg_2_0, var_0_2 + var_0_1 * var_2_5 / FightModel.instance:getSpeed())

				return
			end
		end
	end

	arg_2_0:_delay()
end

function var_0_0._delay(arg_3_0)
	arg_3_0._parentClass:_delayDone()
end

function var_0_0.releaseSelf(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delay, arg_4_0)
	arg_4_0:__onDispose()
end

return var_0_0
