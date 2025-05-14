module("framework.core.workflow.flow.FlowSequence", package.seeall)

local var_0_0 = class("FlowSequence", BaseFlow)

function var_0_0.ctor(arg_1_0)
	arg_1_0._workList = {}
	arg_1_0._curIndex = 0
end

function var_0_0.addWork(arg_2_0, arg_2_1)
	var_0_0.super.addWork(arg_2_0, arg_2_1)
	table.insert(arg_2_0._workList, arg_2_1)
end

function var_0_0.onWorkDone(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._workList[arg_3_0._curIndex]

	if var_3_0 and arg_3_1 ~= var_3_0 then
		return
	end

	if arg_3_1.isSuccess then
		arg_3_1:onResetInternal()

		return arg_3_0:_runNext()
	else
		arg_3_1:onResetInternal()

		return arg_3_0:onDone(false)
	end
end

function var_0_0.getWorkList(arg_4_0)
	return arg_4_0._workList
end

function var_0_0.onStartInternal(arg_5_0, arg_5_1)
	var_0_0.super.onStartInternal(arg_5_0, arg_5_1)

	arg_5_0._curIndex = 0

	return arg_5_0:_runNext()
end

function var_0_0.onStopInternal(arg_6_0)
	var_0_0.super.onStopInternal(arg_6_0)

	local var_6_0 = arg_6_0._workList[arg_6_0._curIndex]

	if var_6_0 and var_6_0.status == WorkStatus.Running then
		var_6_0:onStopInternal()
	end
end

function var_0_0.onResumeInternal(arg_7_0)
	var_0_0.super.onResumeInternal(arg_7_0)

	local var_7_0 = arg_7_0._workList[arg_7_0._curIndex]

	if var_7_0 and var_7_0.status == WorkStatus.Stopped then
		var_7_0:onResumeInternal()
	end
end

function var_0_0.onResetInternal(arg_8_0)
	var_0_0.super.onResetInternal(arg_8_0)

	if arg_8_0.status == WorkStatus.Running or arg_8_0.status == WorkStatus.Stopped then
		local var_8_0 = arg_8_0._workList[arg_8_0._curIndex]

		if var_8_0 and (var_8_0.status == WorkStatus.Running or var_8_0.status == WorkStatus.Stopped) then
			var_8_0:onResetInternal()
		end
	end

	arg_8_0._curIndex = 0
end

function var_0_0.onDestroyInternal(arg_9_0)
	var_0_0.super.onDestroyInternal(arg_9_0)

	if not arg_9_0._workList then
		return
	end

	if arg_9_0.status == WorkStatus.Running or arg_9_0.status == WorkStatus.Stopped then
		local var_9_0 = arg_9_0._workList[arg_9_0._curIndex]

		if var_9_0 then
			var_9_0:onStopInternal()
			var_9_0:onResetInternal()
		end
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._workList) do
		iter_9_1:onDestroyInternal()
	end

	arg_9_0._workList = nil
	arg_9_0._curIndex = nil
end

function var_0_0._runNext(arg_10_0)
	arg_10_0._curIndex = arg_10_0._curIndex + 1

	if arg_10_0._curIndex <= #arg_10_0._workList then
		return arg_10_0._workList[arg_10_0._curIndex]:onStartInternal(arg_10_0.context)
	else
		return arg_10_0:onDone(true)
	end
end

return var_0_0
