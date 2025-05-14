module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114KeyDayFlow", package.seeall)

local var_0_0 = class("Activity114KeyDayFlow", Activity114BaseFlow)

function var_0_0.addEventWork(arg_1_0)
	if Activity114Model.instance.serverData.checkEventId <= 0 and Activity114Model.instance.serverData.testEventId <= 0 then
		arg_1_0:addWork(Activity114KeyDayReqWork.New())
	end

	if arg_1_0.context.eventCo.config.testId > 0 then
		arg_1_0:addWork(Activity114AnswerWork.New())
	end

	if arg_1_0.context.eventCo.config.isCheckEvent == 1 then
		arg_1_0:addWork(Activity114DelayWork.New(0.2))
		arg_1_0:addWork(Activity114CheckWork.New())
		arg_1_0:addWork(Activity114DiceViewWork.New())
		arg_1_0:addWork(Activity114KeyDayCheckResultWork.New())
	else
		arg_1_0:addWork(Activity114StopStoryWork.New())

		if arg_1_0.context.eventCo.config.testId > 0 then
			arg_1_0:addWork(Activity114OpenViewWork.New(ViewName.Activity114TransitionView))
		end
	end
end

return var_0_0
