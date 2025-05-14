module("modules.logic.fight.view.work.FlowCondition", package.seeall)

local var_0_0 = class("FlowCondition", BaseFlow)

function var_0_0.ctor(arg_1_0)
	arg_1_0._conditionWork = nil
	arg_1_0._trueWork = nil
	arg_1_0._falseWork = nil
end

function var_0_0.addWork(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.addWork(arg_2_0, arg_2_1)
	var_0_0.super.addWork(arg_2_0, arg_2_2)
	var_0_0.super.addWork(arg_2_0, arg_2_3)

	arg_2_0._conditionWork = arg_2_1
	arg_2_0._trueWork = arg_2_2
	arg_2_0._falseWork = arg_2_3
end

function var_0_0.onWorkDone(arg_3_0, arg_3_1)
	if arg_3_1 == arg_3_0._conditionWork then
		if arg_3_1.isSuccess then
			arg_3_0._trueWork:onStartInternal(arg_3_0.context)
		else
			arg_3_0._falseWork:onStartInternal(arg_3_0.context)
		end
	else
		arg_3_0.status = arg_3_1.status

		arg_3_0:onDone(arg_3_1.isSuccess)
	end

	arg_3_1:onResetInternal()
end

function var_0_0.onStartInternal(arg_4_0, arg_4_1)
	var_0_0.super.onStartInternal(arg_4_0, arg_4_1)
	arg_4_0._conditionWork:onStartInternal(arg_4_0.context)
end

function var_0_0.onStopInternal(arg_5_0)
	var_0_0.super.onStopInternal(arg_5_0)

	if arg_5_0._trueWork.status == WorkStatus.Running then
		arg_5_0._trueWork:onStopInternal()
	elseif arg_5_0._falseWork.status == WorkStatus.Running then
		arg_5_0._falseWork:onStopInternal()
	end
end

function var_0_0.onResumeInternal(arg_6_0)
	var_0_0.super.onResumeInternal(arg_6_0)

	if arg_6_0._trueWork.status == WorkStatus.Stopped then
		arg_6_0._trueWork:onResumeInternal()
	elseif arg_6_0._falseWork.status == WorkStatus.Stopped then
		arg_6_0._falseWork:onResumeInternal()
	end
end

function var_0_0.onResetInternal(arg_7_0)
	var_0_0.super.onResetInternal(arg_7_0)

	if arg_7_0._trueWork.status == WorkStatus.Running or arg_7_0._trueWork.status == WorkStatus.Stopped then
		arg_7_0._trueWork:onResumeInternal()
	elseif arg_7_0._falseWork.status == WorkStatus.Running or arg_7_0._falseWork.status == WorkStatus.Stopped then
		arg_7_0._falseWork:onResumeInternal()
	end
end

function var_0_0.onDestroyInternal(arg_8_0)
	var_0_0.super.onDestroyInternal(arg_8_0)

	if arg_8_0._trueWork.status == WorkStatus.Running then
		arg_8_0._trueWork:onStopInternal()
	elseif arg_8_0._falseWork.status == WorkStatus.Running then
		arg_8_0._falseWork:onStopInternal()
	end

	if arg_8_0._trueWork.status == WorkStatus.Stopped then
		arg_8_0._trueWork:onResetInternal()
	elseif arg_8_0._falseWork.status == WorkStatus.Stopped then
		arg_8_0._falseWork:onResetInternal()
	end

	arg_8_0._conditionWork:onDestroyInternal()
	arg_8_0._trueWork:onDestroyInternal()
	arg_8_0._falseWork:onDestroyInternal()

	arg_8_0._conditionWork = nil
	arg_8_0._trueWork = nil
	arg_8_0._falseWork = nil
end

return var_0_0
