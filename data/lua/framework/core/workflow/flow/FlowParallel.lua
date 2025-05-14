module("modules.core.workflow.flow.FlowParallel", package.seeall)

local var_0_0 = class("FlowParallel", BaseFlow)

function var_0_0.ctor(arg_1_0)
	arg_1_0._workList = {}
	arg_1_0._doneCount = 0
	arg_1_0._succCount = 0
end

function var_0_0.addWork(arg_2_0, arg_2_1)
	var_0_0.super.addWork(arg_2_0, arg_2_1)
	table.insert(arg_2_0._workList, arg_2_1)
end

function var_0_0.onWorkDone(arg_3_0, arg_3_1)
	arg_3_0._doneCount = arg_3_0._doneCount + 1

	if arg_3_1.isSuccess then
		arg_3_0._succCount = arg_3_0._succCount + 1
	end

	arg_3_1:onResetInternal()

	if arg_3_0._doneCount == #arg_3_0._workList then
		if arg_3_0._doneCount == arg_3_0._succCount then
			return arg_3_0:onDone(true)
		else
			return arg_3_0:onDone(false)
		end
	end
end

function var_0_0.getWorkList(arg_4_0)
	return arg_4_0._workList
end

function var_0_0.onStartInternal(arg_5_0, arg_5_1)
	var_0_0.super.onStartInternal(arg_5_0, arg_5_1)

	if #arg_5_0._workList == 0 then
		arg_5_0:onDone(true)

		return
	end

	arg_5_0._doneCount = 0
	arg_5_0._succCount = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._workList) do
		iter_5_1:onStartInternal(arg_5_1)
	end
end

function var_0_0.onStopInternal(arg_6_0)
	var_0_0.super.onStopInternal(arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._workList) do
		if iter_6_1.status == WorkStatus.Running then
			iter_6_1:onStopInternal()
		end
	end
end

function var_0_0.onResumeInternal(arg_7_0)
	var_0_0.super.onResumeInternal(arg_7_0)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._workList) do
		if iter_7_1.status == WorkStatus.Stopped then
			iter_7_1:onResumeInternal()
		end
	end
end

function var_0_0.onResetInternal(arg_8_0)
	var_0_0.super.onResetInternal(arg_8_0)

	if arg_8_0.status == WorkStatus.Running or arg_8_0.status == WorkStatus.Stopped then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._workList) do
			if iter_8_1.status == WorkStatus.Running or iter_8_1.status == WorkStatus.Stopped then
				iter_8_1:onResetInternal()
			end
		end
	end

	arg_8_0._doneCount = 0
	arg_8_0._succCount = 0
end

function var_0_0.onDestroyInternal(arg_9_0)
	var_0_0.super.onDestroyInternal(arg_9_0)

	if not arg_9_0._workList then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._workList) do
		iter_9_1:onStopInternal()
		iter_9_1:onResetInternal()
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_0._workList) do
		iter_9_3:onDestroyInternal()
	end

	arg_9_0._workList = nil
end

return var_0_0
