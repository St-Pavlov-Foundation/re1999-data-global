module("modules.logic.story.model.StoryGroupMo", package.seeall)

local var_0_0 = pureTable("StoryGroupMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.branchId = 0
	arg_1_0.branchName = ""
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1[1]
	arg_2_0.branchId = arg_2_1[2]
	arg_2_0.branchName = arg_2_1[3]
end

return var_0_0
