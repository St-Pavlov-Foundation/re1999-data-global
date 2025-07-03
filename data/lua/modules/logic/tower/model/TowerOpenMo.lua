module("modules.logic.tower.model.TowerOpenMo", package.seeall)

local var_0_0 = pureTable("TowerOpenMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.type = arg_2_1.type
	arg_2_0.towerId = arg_2_1.towerId
	arg_2_0.id = arg_2_1.towerId
	arg_2_0.status = arg_2_1.status
	arg_2_0.round = arg_2_1.round
	arg_2_0.nextTime = arg_2_1.nextTime
	arg_2_0.towerStartTime = tonumber(arg_2_1.towerStartTime)
	arg_2_0.taskEndTime = tonumber(arg_2_1.taskEndTime)
end

function var_0_0.getTaskRemainTime(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.taskEndTime / 1000 - ServerTime.now()

	if var_3_0 > 0 then
		local var_3_1, var_3_2 = TimeUtil.secondToRoughTime(var_3_0, arg_3_1)

		return var_3_1, var_3_2
	else
		return nil
	end
end

return var_0_0
