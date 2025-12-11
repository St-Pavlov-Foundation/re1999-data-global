module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoFlowSequence_Base", package.seeall)

local var_0_0 = _G.FlowSequence
local var_0_1 = class("GaoSiNiaoFlowSequence_Base", var_0_0)

function var_0_1.ctor(arg_1_0, ...)
	var_0_0.ctor(arg_1_0, ...)
end

function var_0_1.onDestroyView(arg_2_0)
	arg_2_0:destroy()
end

function var_0_1.addWork(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return nil
	end

	var_0_0.addWork(arg_3_0, arg_3_1)
	arg_3_1:setRootInternal(arg_3_0)

	return arg_3_1
end

function var_0_1.insertWork(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return nil
	end

	BaseFlow.addWork(arg_4_0, arg_4_1)
	arg_4_1:setRootInternal(arg_4_0)
	table.insert(arg_4_0._workList, arg_4_0:nextIndex(), arg_4_1)

	return arg_4_1
end

function var_0_1.appendFlow(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getWorkList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		arg_5_0:addWork(iter_5_1)
	end

	arg_5_1._workList = {}
	arg_5_1._curIndex = 0

	return arg_5_0
end

function var_0_1.curWork(arg_6_0)
	return arg_6_0._workList[arg_6_0._curIndex]
end

function var_0_1.nextIndex(arg_7_0)
	return arg_7_0._curIndex + 1
end

function var_0_1.onStart(arg_8_0)
	return
end

return var_0_1
