module("modules.logic.fight.view.work.WorkFlow", package.seeall)

local var_0_0 = class("WorkFlow", BaseFlow)

function var_0_0.ctor(arg_1_0)
	arg_1_0._work = nil
end

function var_0_0.deserialize(arg_2_0, arg_2_1)
	if arg_2_1 then
		local var_2_0 = arg_2_0:_parse(arg_2_1)

		arg_2_0:addChild(var_2_0)
	end
end

function var_0_0._parse(arg_3_0, arg_3_1)
	local var_3_0 = _G[arg_3_1.type]

	if var_3_0 then
		local var_3_1 = var_3_0.New(arg_3_1.paramTable)
		local var_3_2 = arg_3_0:_parse(arg_3_1)

		arg_3_0:addChild(var_3_1)
	end
end

function var_0_0.addWork(arg_4_0, arg_4_1)
	var_0_0.super.addWork(arg_4_0, arg_4_1)

	arg_4_0._work = arg_4_1
end

function var_0_0.onWorkDone(arg_5_0, arg_5_1)
	arg_5_0:onDone(arg_5_0._work.isSuccess)
	arg_5_0._work:onResetInternal()
end

function var_0_0.onStartInternal(arg_6_0, arg_6_1)
	var_0_0.super.onStartInternal(arg_6_0, arg_6_1)
	arg_6_0._work:onStartInternal(arg_6_0.context)
end

function var_0_0.onStopInternal(arg_7_0)
	var_0_0.super.onStopInternal(arg_7_0)

	if arg_7_0._work.status == WorkStatus.Running then
		arg_7_0._work:onStopInternal()
	end
end

function var_0_0.onResumeInternal(arg_8_0)
	var_0_0.super.onResumeInternal(arg_8_0)

	if arg_8_0._work.status == WorkStatus.Stopped then
		arg_8_0._work:onResumeInternal()
	end
end

function var_0_0.onResetInternal(arg_9_0)
	var_0_0.super.onResetInternal(arg_9_0)

	if arg_9_0._work.status == WorkStatus.Running or arg_9_0._work.status == WorkStatus.Stopped then
		arg_9_0._work:onResetInternal()
	end
end

function var_0_0.onDestroyInternal(arg_10_0)
	var_0_0.super.onDestroyInternal(arg_10_0)

	if arg_10_0._work.status == WorkStatus.Running then
		arg_10_0._work:onStopInternal()
	end

	arg_10_0._work:onResetInternal()

	arg_10_0._work = nil
end

return var_0_0
