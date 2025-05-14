module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114BaseWork", package.seeall)

local var_0_0 = class("Activity114BaseWork", BaseWork)

function var_0_0.forceEndStory(arg_1_0)
	if arg_1_0._flow then
		local var_1_0 = arg_1_0._flow._workList[arg_1_0._flow._curIndex]

		if not var_1_0 then
			return
		end

		var_1_0:forceEndStory()
	end
end

function var_0_0.getFlow(arg_2_0)
	if not arg_2_0._flow then
		arg_2_0._flow = FlowSequence.New()
	end

	return arg_2_0._flow
end

function var_0_0.startFlow(arg_3_0)
	if arg_3_0._flow then
		arg_3_0._flow:registerDoneListener(arg_3_0.onDone, arg_3_0)
		arg_3_0._flow:start(arg_3_0.context)
	else
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._flow then
		arg_4_0._flow:onDestroy()

		arg_4_0._flow = nil
	end
end

return var_0_0
