module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114EduWork", package.seeall)

local var_0_0 = class("Activity114EduWork", Activity114ReqBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	Activity114Rpc.instance:eduRequest(Activity114Model.instance.id, tonumber(arg_1_0.context.eventCo.config.param), arg_1_0.onReply, arg_1_0)
end

return var_0_0
