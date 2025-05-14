module("modules.logic.story.model.StoryStepHeroMo", package.seeall)

local var_0_0 = pureTable("StoryStepHeroMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.heroIndex = 0
	arg_1_0.heroDir = 1
	arg_1_0.heroPos = {
		0,
		0
	}
	arg_1_0.heroScale = 1
	arg_1_0.isFollow = false
	arg_1_0.mouses = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	arg_1_0.anims = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	arg_1_0.expressions = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	arg_1_0.effs = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.heroIndex = arg_2_1[1]

	local var_2_0 = StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(arg_2_1[1])

	arg_2_0.heroDir = arg_2_1[2]

	if var_2_0 then
		local var_2_1 = ""

		if arg_2_1[2] == 0 then
			var_2_1 = var_2_0.type == 0 and var_2_0.leftParam or var_2_0.live2dLeftParam
		elseif arg_2_1[2] == 1 then
			var_2_1 = var_2_0.type == 0 and var_2_0.midParam or var_2_0.live2dMidParam
		elseif arg_2_1[2] == 2 then
			var_2_1 = var_2_0.type == 0 and var_2_0.rightParam or var_2_0.live2dRightParam
		end

		local var_2_2 = string.split(var_2_1, "#")

		arg_2_0.heroPos = {
			tonumber(var_2_2[1]),
			tonumber(var_2_2[2])
		}
		arg_2_0.heroScale = tonumber(var_2_2[3])
	end

	arg_2_0.isFollow = arg_2_1[3]
	arg_2_0.mouses = arg_2_1[4]
	arg_2_0.anims = arg_2_1[5]
	arg_2_0.expressions = arg_2_1[6]
	arg_2_0.effs = arg_2_1[7]
end

return var_0_0
