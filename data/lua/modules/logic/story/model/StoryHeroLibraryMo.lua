module("modules.logic.story.model.StoryHeroLibraryMo", package.seeall)

local var_0_0 = pureTable("StoryHeroLibraryMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.index = 0
	arg_1_0.type = 0
	arg_1_0.tag = false
	arg_1_0.name = ""
	arg_1_0.nameEn = ""
	arg_1_0.icon = ""
	arg_1_0.leftParam = ""
	arg_1_0.midParam = ""
	arg_1_0.rightParam = ""
	arg_1_0.live2dLeftParam = ""
	arg_1_0.live2dMidParam = ""
	arg_1_0.live2dRightParam = ""
	arg_1_0.prefab = ""
	arg_1_0.live2dPrefab = ""
	arg_1_0.hideNodes = ""
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.index = arg_2_1[1]
	arg_2_0.type = arg_2_1[2]
	arg_2_0.tag = arg_2_1[3]
	arg_2_0.name = arg_2_1[4]
	arg_2_0.nameEn = arg_2_1[5]
	arg_2_0.icon = arg_2_1[6]
	arg_2_0.leftParam = arg_2_1[7]
	arg_2_0.midParam = arg_2_1[8]
	arg_2_0.rightParam = arg_2_1[9]
	arg_2_0.live2dLeftParam = arg_2_1[10]
	arg_2_0.live2dMidParam = arg_2_1[11]
	arg_2_0.live2dRightParam = arg_2_1[12]
	arg_2_0.prefab = arg_2_1[13]
	arg_2_0.live2dPrefab = arg_2_1[14]
	arg_2_0.hideNodes = arg_2_1[15]
end

return var_0_0
