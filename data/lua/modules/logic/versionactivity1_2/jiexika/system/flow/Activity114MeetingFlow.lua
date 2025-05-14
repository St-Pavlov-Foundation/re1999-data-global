module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114MeetingFlow", package.seeall)

local var_0_0 = class("Activity114MeetingFlow", Activity114BaseFlow)

function var_0_0.addEventWork(arg_1_0)
	arg_1_0:addWork(Activity114CheckWork.New())
	arg_1_0:addWork(Activity114CheckOrAnswerWork.New())
end

return var_0_0
