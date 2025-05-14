module("modules.logic.story.model.StoryStepModel", package.seeall)

local var_0_0 = class("StoryStepModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._stepList = {}
end

function var_0_0.setStepList(arg_2_0, arg_2_1)
	arg_2_0._stepList = {}

	if arg_2_1 then
		for iter_2_0, iter_2_1 in pairs(arg_2_1) do
			local var_2_0 = StoryStepMo.New()

			var_2_0:init(iter_2_1)
			table.insert(arg_2_0._stepList, var_2_0)
		end
	end

	arg_2_0:setList(arg_2_0._stepList)
end

function var_0_0.getStepList(arg_3_0)
	return arg_3_0._stepList
end

function var_0_0.getStepListById(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._stepList) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function var_0_0.getStepFavor(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getStepListById(arg_5_1).optList
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if iter_5_1.feedbackType == 1 then
			var_5_1 = var_5_1 + iter_5_1.feedbackValue
		end
	end

	return var_5_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
