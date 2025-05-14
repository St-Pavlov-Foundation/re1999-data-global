module("framework.network.socket.pre.AliveCheckPreSender", package.seeall)

local var_0_0 = class("AliveCheckPreSender", BasePreSender)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._sendCmdInfoList = {}
end

function var_0_0.getFirstUnresponsiveMsg(arg_2_0)
	return arg_2_0._sendCmdInfoList[1]
end

function var_0_0.getUnresponsiveMsgList(arg_3_0)
	return arg_3_0._sendCmdInfoList
end

function var_0_0.clear(arg_4_0)
	arg_4_0._sendCmdInfoList = {}
end

function var_0_0.preSendSysMsg(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	return
end

function var_0_0.preSendProto(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {
		cmd = arg_6_1,
		msg = arg_6_2,
		socketId = arg_6_3,
		time = Time.realtimeSinceStartup
	}

	table.insert(arg_6_0._sendCmdInfoList, var_6_0)
end

function var_0_0.onReceiveMsg(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._sendCmdInfoList) do
		if iter_7_1.cmd == arg_7_1 then
			table.remove(arg_7_0._sendCmdInfoList, iter_7_0)

			if iter_7_0 ~= 1 then
				local var_7_0 = arg_7_0._sendCmdInfoList[1] and arg_7_0._sendCmdInfoList[1].cmd

				logError("打个log：消息不是按顺序收到的！跳跃了 " .. iter_7_0 - 1 .. " 个包 期待的cmd = " .. var_7_0)
			end

			break
		end
	end
end

function var_0_0.ignoreUnimportantCmds(arg_8_0, arg_8_1)
	for iter_8_0 = #arg_8_0._sendCmdInfoList, 1, -1 do
		local var_8_0 = arg_8_0._sendCmdInfoList[iter_8_0]

		if GameMsgLockState.IgnoreCmds[var_8_0.cmd] then
			table.remove(arg_8_0._sendCmdInfoList, iter_8_0)
		end
	end
end

return var_0_0
