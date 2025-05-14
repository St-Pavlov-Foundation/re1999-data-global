module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114KeyDayCheckResultWork", package.seeall)

local var_0_0 = class("Activity114KeyDayCheckResultWork", Activity114BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0:getFlow():addWork(Activity114StopStoryWork.New())
	arg_1_0:getFlow():addWork(Activity114OpenAttrViewWork.New())

	local var_1_0 = Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, arg_1_0.context.nowDay)
	local var_1_1 = false

	if not var_1_0 then
		local var_1_2, var_1_3, var_1_4, var_1_5 = Activity114Helper.getWeekEndScore()

		var_1_1 = var_1_5 < Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId.ScoreC)

		arg_1_0:getFlow():addWork(Activity114WeekEndWork.New())
	end

	arg_1_0.context.storyId = nil

	local var_1_6 = arg_1_0.context.eventCo

	if arg_1_0.context.result == Activity114Enum.Result.None then
		-- block empty
	elseif var_1_0 and arg_1_0.context.result == Activity114Enum.Result.Success or not var_1_0 and not var_1_1 then
		arg_1_0:getFlow():addWork(Activity114StoryWork.New(var_1_6.config.successStoryId, Activity114Enum.StoryType.Result))
	elseif var_1_0 and arg_1_0.context.result == Activity114Enum.Result.Fail or not var_1_0 and var_1_1 then
		arg_1_0:getFlow():addWork(Activity114StoryWork.New(var_1_6.config.failureStoryId, Activity114Enum.StoryType.Result))
	else
		logError("error :" .. tostring(var_1_1) .. " +++ " .. tostring(arg_1_0.context.nowDay))
	end

	arg_1_0:getFlow():addWork(Activity114StopStoryWork.New())
	arg_1_0:startFlow()
end

return var_0_0
