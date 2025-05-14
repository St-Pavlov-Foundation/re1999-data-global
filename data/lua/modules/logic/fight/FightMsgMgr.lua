module("modules.logic.fight.FightMsgMgr", package.seeall)

local var_0_0 = class("FightMsgMgr")
local var_0_1 = {}
local var_0_2 = false
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}

function var_0_0.registMsg(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_1[arg_1_0]

	if not var_1_0 then
		var_1_0 = {}
		var_0_1[arg_1_0] = var_1_0
	end

	local var_1_1 = FightMsgItem.New(arg_1_0, arg_1_1, arg_1_2)

	table.insert(var_1_0, var_1_1)

	return var_1_1
end

function var_0_0.sendMsg(arg_2_0, ...)
	local var_2_0 = var_0_1[arg_2_0]

	if not var_2_0 then
		return
	end

	local var_2_1 = (var_0_3[arg_2_0] or 0) + 1

	var_0_3[arg_2_0] = var_2_1

	local var_2_2 = #var_2_0

	for iter_2_0 = 1, var_2_2 do
		local var_2_3 = var_2_0[iter_2_0]

		if not var_2_3.isDone and not var_2_3.isLock then
			var_2_3:sendMsg(...)
		end
	end

	var_0_3[arg_2_0] = var_2_1 - 1

	local var_2_4 = var_0_4[arg_2_0]

	if var_2_4 then
		local var_2_5 = var_2_4.list[var_2_1]

		if var_2_5 then
			var_2_4.list[var_2_1] = nil

			return var_2_5[1], var_2_5
		end
	end
end

function var_0_0.replyMsg(arg_3_0, arg_3_1)
	local var_3_0 = var_0_3[arg_3_0] or 0

	if var_3_0 == 0 then
		return
	end

	local var_3_1 = var_0_4[arg_3_0]

	if not var_3_1 then
		var_3_1 = {}
		var_0_4[arg_3_0] = var_3_1
		var_3_1.list = {}
	end

	local var_3_2 = var_3_1.list[var_3_0]

	if not var_3_2 then
		var_3_2 = {}
		var_3_1.list[var_3_0] = var_3_2
	end

	table.insert(var_3_2, arg_3_1)
end

function var_0_0.removeMsg(arg_4_0)
	if not arg_4_0 then
		return
	end

	arg_4_0.isDone = true
	var_0_5[arg_4_0.msgId] = true
	var_0_2 = true
end

function var_0_0.lockItem(arg_5_0)
	if not arg_5_0 then
		return
	end

	arg_5_0.isLock = true
end

function var_0_0.unlockItem(arg_6_0)
	if not arg_6_0 then
		return
	end

	arg_6_0.isLock = false
end

function var_0_0.clearMsg()
	if not var_0_2 then
		return
	end

	for iter_7_0, iter_7_1 in pairs(var_0_5) do
		local var_7_0 = var_0_1[iter_7_0]

		if var_7_0 then
			for iter_7_2 = #var_7_0, 1, -1 do
				if var_7_0[iter_7_2].isDone then
					table.remove(var_7_0, iter_7_2)
				end
			end

			if #var_7_0 == 0 then
				var_0_1[iter_7_0] = nil
				var_0_4[iter_7_0] = nil
			end
		end

		var_0_5[iter_7_0] = nil
	end

	var_0_2 = false
end

FightTimer.registRepeatTimer(var_0_0.clearMsg, var_0_0, 10, -1)

return var_0_0
