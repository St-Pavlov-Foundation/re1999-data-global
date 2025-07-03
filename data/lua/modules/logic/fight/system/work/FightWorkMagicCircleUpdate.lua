module("modules.logic.fight.system.work.FightWorkMagicCircleUpdate", package.seeall)

local var_0_0 = class("FightWorkMagicCircleUpdate", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance:getMagicCircleInfo()

	if var_1_0 then
		local var_1_1 = arg_1_0.actEffectData.magicCircle.magicCircleId

		if var_1_0.magicCircleId == var_1_1 then
			var_1_0:refreshData(arg_1_0.actEffectData.magicCircle)
		end

		if lua_magic_circle.configDict[var_1_1] then
			FightController.instance:dispatchEvent(FightEvent.UpdateMagicCircile, var_1_1)
		else
			logError("术阵表找不到id:" .. var_1_1)
		end
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
