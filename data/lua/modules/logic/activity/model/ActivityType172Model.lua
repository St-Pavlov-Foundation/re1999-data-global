module("modules.logic.activity.model.ActivityType172Model", package.seeall)

local var_0_0 = class("ActivityType172Model", BaseModel)
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._type172Info = {}
end

function var_0_0.setType172Info(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ActivityType172InfoMo.New()

	var_3_0:init(arg_3_2.useItemTaskIds)

	arg_3_0._type172Info[arg_3_1] = var_3_0
end

function var_0_0.updateType172Info(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._type172Info[arg_4_1] then
		local var_4_0 = ActivityType172InfoMo.New()

		var_4_0:init(arg_4_2)

		arg_4_0._type172Info[arg_4_1] = var_4_0
	else
		arg_4_0._type172Info[arg_4_1]:update(arg_4_2)
	end
end

function var_0_0.isTaskHasUsed(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._type172Info[arg_5_1] then
		return false
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0._type172Info[arg_5_1].useItemTaskIds) do
		if iter_5_1 == arg_5_2 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
