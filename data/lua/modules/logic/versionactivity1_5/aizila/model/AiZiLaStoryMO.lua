module("modules.logic.versionactivity1_5.aizila.model.AiZiLaStoryMO", package.seeall)

local var_0_0 = pureTable("AiZiLaStoryMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_2.id or arg_1_1
	arg_1_0.index = arg_1_1
	arg_1_0.storyId = arg_1_2.id
	arg_1_0.config = arg_1_2
end

function var_0_0.isLocked(arg_2_0)
	if StoryModel.instance:isStoryHasPlayed(arg_2_0.storyId) then
		return false
	end

	return true
end

return var_0_0
