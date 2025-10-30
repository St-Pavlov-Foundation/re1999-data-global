module("modules.logic.fight.FightMsgItem", package.seeall)

local var_0_0 = class("FightMsgItem")
local var_0_1 = xpcall
local var_0_2 = __G__TRACKBACK__

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.msgId = arg_1_1
	arg_1_0.callback = arg_1_2
	arg_1_0.handle = arg_1_3
end

function var_0_0.sendMsg(arg_2_0, ...)
	var_0_1(arg_2_0.callback, var_0_2, arg_2_0.handle, ...)
end

return var_0_0
