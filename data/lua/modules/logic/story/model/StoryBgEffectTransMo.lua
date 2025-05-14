module("modules.logic.story.model.StoryBgEffectTransMo", package.seeall)

local var_0_0 = pureTable("StoryBgEffectTransMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.type = 0
	arg_1_0.name = ""
	arg_1_0.mat = ""
	arg_1_0.prefab = ""
	arg_1_0.aniName = ""
	arg_1_0.transTime = 0
	arg_1_0.extraParam = ""
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.type = arg_2_1[1]
	arg_2_0.name = arg_2_1[2]
	arg_2_0.mat = arg_2_1[3]
	arg_2_0.prefab = string.split(arg_2_1[4], ".")[1]
	arg_2_0.aniName = arg_2_1[5]
	arg_2_0.transTime = arg_2_1[6]
	arg_2_0.extraParam = arg_2_1[7]
end

return var_0_0
