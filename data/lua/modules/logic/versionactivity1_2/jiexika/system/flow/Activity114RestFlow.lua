module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114RestFlow", package.seeall)

local var_0_0 = class("Activity114RestFlow", Activity114BaseFlow)

function var_0_0.addEventWork(arg_1_0)
	arg_1_0:addWork(Activity114StoryWork.New(arg_1_0.context.eventCo.config.successStoryId, Activity114Enum.StoryType.Result))
	arg_1_0:addWork(Activity114StopStoryWork.New())
	arg_1_0:addWork(Activity114OpenViewWork.New(ViewName.Activity114TransitionView))
	arg_1_0:addWork(Activity114OpenAttrViewWork.New())
end

return var_0_0
