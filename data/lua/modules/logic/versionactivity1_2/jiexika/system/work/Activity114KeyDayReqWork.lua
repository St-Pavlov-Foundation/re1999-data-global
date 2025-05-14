module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114KeyDayReqWork", package.seeall)

local var_0_0 = class("Activity114KeyDayReqWork", Activity114BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	Activity114Rpc.instance:keyDayRequest(Activity114Model.instance.id, arg_1_0.onReply, arg_1_0)
end

function var_0_0.onReply(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:onDone(arg_2_2 == 0)
end

return var_0_0
