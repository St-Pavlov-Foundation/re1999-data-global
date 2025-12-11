module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWorkBase", package.seeall)

local var_0_0 = class("GaoSiNiaoWorkBase", BaseWork)
local var_0_1 = 3

function var_0_0.startBlock(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1 or arg_1_0.class.__cname

	UIBlockHelper.instance:startBlock(var_1_0, arg_1_2 or var_0_1)

	return var_1_0
end

function var_0_0.endBlock(arg_2_0, arg_2_1)
	UIBlockHelper.instance:endBlock(arg_2_1 or arg_2_0.class.__cname)
end

function var_0_0.onSucc(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.onFail(arg_4_0)
	arg_4_0:onDone(false)
end

function var_0_0.onStart(arg_5_0)
	arg_5_0:onSucc()
end

function var_0_0.clearWork(arg_6_0)
	arg_6_0:endBlock()
end

return var_0_0
