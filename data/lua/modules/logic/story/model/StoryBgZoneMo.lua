module("modules.logic.story.model.StoryBgZoneMo", package.seeall)

local var_0_0 = pureTable("StoryBgZoneMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.path = ""
	arg_1_0.sourcePath = ""
	arg_1_0.offsetX = 0
	arg_1_0.offsetY = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.path = arg_2_1[1]
	arg_2_0.sourcePath = arg_2_1[2]
	arg_2_0.offsetX = arg_2_1[3]
	arg_2_0.offsetY = arg_2_1[4]
end

return var_0_0
