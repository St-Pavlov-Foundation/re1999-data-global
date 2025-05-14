module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114CheckResultWork", package.seeall)

local var_0_0 = class("Activity114CheckResultWork", Activity114BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.context.eventCo

	if var_1_0.config.isCheckEvent == 1 then
		arg_1_0:getFlow():addWork(Activity114StopStoryWork.New())
	end

	if arg_1_0.context.result == Activity114Enum.Result.None then
		arg_1_0.context.storyId = nil
	elseif arg_1_0.context.result == Activity114Enum.Result.Success then
		arg_1_0:getFlow():addWork(Activity114StoryWork.New(var_1_0.config.successStoryId, Activity114Enum.StoryType.Result))
		arg_1_0:getFlow():addWork(Activity114StopStoryWork.New())
		arg_1_0:getFlow():addWork(Activity114OpenAttrViewWork.New())
	elseif arg_1_0.context.result == Activity114Enum.Result.Fail then
		arg_1_0:getFlow():addWork(Activity114StoryWork.New(var_1_0.config.failureStoryId, Activity114Enum.StoryType.Result))

		if var_1_0.config.battleId > 0 then
			arg_1_0:getFlow():addWork(Activity114StopStoryWork.New())
			arg_1_0:getFlow():addWork(Activity114FightWork.New())
			arg_1_0:getFlow():addWork(Activity114FightResultWork.New())
			arg_1_0:getFlow():addWork(Activity114OpenAttrViewWork.New())
		else
			arg_1_0:getFlow():addWork(Activity114StopStoryWork.New())
			arg_1_0:getFlow():addWork(Activity114OpenAttrViewWork.New())
		end
	end

	arg_1_0:startFlow()
end

return var_0_0
