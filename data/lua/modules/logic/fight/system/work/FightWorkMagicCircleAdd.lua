module("modules.logic.fight.system.work.FightWorkMagicCircleAdd", package.seeall)

local var_0_0 = class("FightWorkMagicCircleAdd", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance:getMagicCircleInfo()

	if var_1_0 then
		local var_1_1 = arg_1_0.actEffectData.magicCircle.magicCircleId

		var_1_0:refreshData(arg_1_0.actEffectData.magicCircle)

		local var_1_2 = lua_magic_circle.configDict[var_1_1]

		if var_1_2 then
			local var_1_3 = math.max(var_1_2.enterTime / 1000, 0.7)

			arg_1_0:com_registTimer(arg_1_0._delayDone, var_1_3 / FightModel.instance:getSpeed())
			FightController.instance:dispatchEvent(FightEvent.AddMagicCircile, var_1_1, arg_1_0.fightStepData.fromId)

			return
		end

		logError("术阵表找不到id:" .. var_1_1)
	end

	arg_1_0:_delayDone()
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
