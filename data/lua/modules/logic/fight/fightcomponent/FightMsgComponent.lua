module("modules.logic.fight.fightcomponent.FightMsgComponent", package.seeall)

local var_0_0 = class("FightMsgComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._msgItems = {}
end

function var_0_0.registMsg(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = FightMsgMgr.registMsg(arg_2_1, arg_2_2, arg_2_3)

	table.insert(arg_2_0._msgItems, var_2_0)

	if arg_2_0._lock then
		FightMsgMgr.lockItem(var_2_0)
	end

	return var_2_0
end

function var_0_0.removeMsg(arg_3_0, arg_3_1)
	FightMsgMgr.removeMsg(arg_3_1)
end

function var_0_0.sendMsg(arg_4_0, arg_4_1, ...)
	return FightMsgMgr.sendMsg(arg_4_1, ...)
end

function var_0_0.replyMsg(arg_5_0, arg_5_1, arg_5_2)
	FightMsgMgr.replyMsg(arg_5_1, arg_5_2)
end

function var_0_0.lockMsg(arg_6_0)
	arg_6_0._lock = true

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._msgItems) do
		FightMsgMgr.lockItem(iter_6_1)
	end
end

function var_0_0.unlockMsg(arg_7_0)
	arg_7_0._lock = false

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._msgItems) do
		FightMsgMgr.unlockItem(iter_7_1)
	end
end

function var_0_0.onDestructor(arg_8_0)
	for iter_8_0 = #arg_8_0._msgItems, 1, -1 do
		FightMsgMgr.removeMsg(arg_8_0._msgItems[iter_8_0])
	end
end

return var_0_0
