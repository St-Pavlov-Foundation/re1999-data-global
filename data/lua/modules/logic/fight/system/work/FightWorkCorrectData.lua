module("modules.logic.fight.system.work.FightWorkCorrectData", package.seeall)

local var_0_0 = class("FightWorkCorrectData", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = FightDataHelper.roundMgr:getRoundData()
	local var_1_1 = var_1_0 and var_1_0.exPointInfo

	if var_1_1 then
		for iter_1_0, iter_1_1 in pairs(var_1_1) do
			local var_1_2 = FightDataHelper.entityMgr:getById(iter_1_0)

			if var_1_2 and iter_1_1.currentHp and iter_1_1.currentHp ~= var_1_2.currentHp then
				var_1_2:setHp(iter_1_1.currentHp)
				FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, iter_1_0)
			end
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
