module("modules.logic.fight.system.work.FightWorkMagicCircleDelete", package.seeall)

local var_0_0 = class("FightWorkMagicCircleDelete", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightModel.instance:getMagicCircleInfo()

	if var_1_0 then
		local var_1_1 = tonumber(arg_1_0.actEffectData.reserveId)

		if var_1_0:deleteData(var_1_1) then
			local var_1_2 = lua_magic_circle.configDict[var_1_1]

			if var_1_2 then
				local var_1_3 = math.max(var_1_2.closeTime / 1000, 0.3)

				arg_1_0:com_registTimer(arg_1_0._delayDone, var_1_3 / FightModel.instance:getSpeed())
				FightController.instance:dispatchEvent(FightEvent.DeleteMagicCircile, var_1_1)

				return
			end

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
