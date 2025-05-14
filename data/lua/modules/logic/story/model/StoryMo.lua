module("modules.logic.story.model.StoryMo", package.seeall)

local var_0_0 = pureTable("StoryMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.finishList = nil
	arg_1_0.processList = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.finishList = {}

	if arg_2_1.finishList then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.finishList) do
			arg_2_0.finishList[iter_2_1] = true
		end
	end

	arg_2_0.processList = arg_2_1.processingList and arg_2_0:_getListInfo(arg_2_1.processingList, StoryProcessInfoMo) or {}
end

function var_0_0.update(arg_3_0, arg_3_1)
	local var_3_0 = false

	for iter_3_0, iter_3_1 in pairs(arg_3_0.processList) do
		if iter_3_1.storyId == arg_3_1.storyId then
			iter_3_1.stepId = arg_3_1.stepId
			iter_3_1.favor = arg_3_1.favor
			var_3_0 = true
		end
	end

	if not var_3_0 then
		local var_3_1 = StoryProcessInfoMo.New()

		var_3_1.storyId = arg_3_1.storyId
		var_3_1.stepId = arg_3_1.stepId
		var_3_1.favor = arg_3_1.favor

		table.insert(arg_3_0.processList, var_3_1)
	end
end

function var_0_0._getListInfo(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 then
		return {}
	end

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = iter_4_1

		if arg_4_2 then
			var_4_1 = arg_4_2.New()

			var_4_1:init(iter_4_1)
		end

		table.insert(var_4_0, var_4_1)
	end

	return var_4_0
end

return var_0_0
