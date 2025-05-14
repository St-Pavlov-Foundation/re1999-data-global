module("modules.logic.versionactivity1_4.act133.config.Activity133Config", package.seeall)

local var_0_0 = class("Activity133Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act133taskList = {}
	arg_1_0._act133bonusList = {}
	arg_1_0._finalBonus = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity133_bonus",
		"activity133_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity133_task" then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			local var_3_0 = iter_3_1.id

			table.insert(arg_3_0._act133taskList, iter_3_1)
		end
	elseif arg_3_1 == "activity133_bonus" then
		for iter_3_2, iter_3_3 in ipairs(arg_3_2.configList) do
			local var_3_1 = iter_3_3.id

			if iter_3_3.finalBonus == 1 then
				arg_3_0._finalBonus = iter_3_3.bonus
			else
				arg_3_0._act133bonusList[var_3_1] = arg_3_0._act133bonusList[var_3_1] or {}

				table.insert(arg_3_0._act133bonusList[var_3_1], iter_3_3)
			end
		end
	end
end

function var_0_0.getFinalBonus(arg_4_0)
	return arg_4_0._finalBonus
end

function var_0_0.getBonusCoList(arg_5_0)
	return arg_5_0._act133bonusList
end

function var_0_0.getNeedFixNum(arg_6_0)
	return #arg_6_0._act133bonusList
end

function var_0_0.getTaskCoList(arg_7_0)
	return arg_7_0._act133taskList
end

function var_0_0.getTaskCo(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._act133taskList) do
		if iter_8_1.id == arg_8_1 then
			return iter_8_1
		end
	end

	return arg_8_0._act133taskList[arg_8_1]
end

function var_0_0.getBonusCo(arg_9_0, arg_9_1)
	return arg_9_0._act133bonusList[arg_9_1]
end

function var_0_0.IsActivityTask(arg_10_0, arg_10_1)
	if arg_10_0._act133taskList[arg_10_1].orActivity == "1" then
		return true
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
