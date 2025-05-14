module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114FightResultWork", package.seeall)

local var_0_0 = class("Activity114FightResultWork", Activity114BaseWork)

function var_0_0.onStart(arg_1_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnFightResult, arg_1_0.onFightResult, arg_1_0)
end

function var_0_0.onFightResult(arg_2_0, arg_2_1)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnFightResult, arg_2_0.onFightResult, arg_2_0)

	arg_2_0.context.result = arg_2_1

	if arg_2_0.context.type == Activity114Enum.EventType.KeyDay then
		arg_2_0.context.storyId = arg_2_1 == Activity114Enum.Result.Success and arg_2_0.context.eventCo.config.successStoryId or arg_2_0.context.eventCo.config.failureStoryId
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnFightResult, arg_3_0.onFightResult, arg_3_0)
	var_0_0.super.clearWork(arg_3_0)
end

return var_0_0
