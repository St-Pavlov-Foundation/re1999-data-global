module("modules.logic.prototest.core.ProtoTestPreSender", package.seeall)

local var_0_0 = class("ProtoTestPreSender", BasePreSender)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.preSendSysMsg(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	return
end

function var_0_0.preSendProto(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not ProtoEnum.IgnoreCmdList[arg_3_1] then
		local var_3_0 = ProtoTestCaseMO.New()

		var_3_0:initFromProto(arg_3_1, arg_3_2)
		ProtoTestCaseModel.instance:addAtLast(var_3_0)
	end
end

return var_0_0
