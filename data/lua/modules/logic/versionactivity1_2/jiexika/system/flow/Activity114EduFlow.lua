module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114EduFlow", package.seeall)

local var_0_0 = class("Activity114EduFlow", Activity114BaseFlow)

function var_0_0.addEventWork(arg_1_0)
	arg_1_0:addWork(Activity114EduWork.New())
	arg_1_0:addWork(Activity114StoryWork.New(nil, Activity114Enum.StoryType.Result))
	arg_1_0:addWork(Activity114StopStoryWork.New())
	arg_1_0:addWork(Activity114OpenTransitionViewByEventCoWork.New())
	arg_1_0:addWork(Activity114OpenAttrViewWork.New())
end

return var_0_0
