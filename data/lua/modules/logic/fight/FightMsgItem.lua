module("modules.logic.fight.FightMsgItem", package.seeall)

local var_0_0 = class("FightMsgItem")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.msgId = arg_1_1
	arg_1_0.callback = arg_1_2
	arg_1_0.handle = arg_1_3
	arg_1_0.msgName = FightMsgId.id2Name[arg_1_1]
end

function var_0_0.sendMsg(arg_2_0, ...)
	xpcall(arg_2_0.callback, __G__TRACKBACK__, arg_2_0.handle, ...)
end

return var_0_0
