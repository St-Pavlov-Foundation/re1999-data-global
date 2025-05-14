module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114ReqBaseWork", package.seeall)

local var_0_0 = class("Activity114ReqBaseWork", Activity114BaseWork)

function var_0_0.onReply(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:onDone(arg_1_2 == 0)
end

return var_0_0
