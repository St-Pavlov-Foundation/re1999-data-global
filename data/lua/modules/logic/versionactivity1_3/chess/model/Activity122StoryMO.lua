module("modules.logic.versionactivity1_3.chess.model.Activity122StoryMO", package.seeall)

local var_0_0 = pureTable("Activity122StoryMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.index = arg_1_1
	arg_1_0.cfg = arg_1_2
	arg_1_0.storyId = arg_1_2.id
end

function var_0_0.isLocked(arg_2_0)
	if StoryModel.instance:isStoryHasPlayed(arg_2_0.storyId) then
		return false
	end

	return true
end

return var_0_0
