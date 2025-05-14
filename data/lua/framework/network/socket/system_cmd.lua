module("framework.network.socket.system_cmd", package.seeall)

local var_0_0 = {
	{
		"Login",
		"LoginRequest",
		"LoginResponse"
	},
	[3] = {
		"Login",
		"GetLostCmdRespRequest",
		"GetLostCmdRespResponse"
	},
	[4] = {
		"Login",
		"",
		"ForceLogoutResponse"
	},
	[5] = {
		"Login",
		"",
		"GetLostCmdRespResponseStartTag"
	}
}

function var_0_0.GetSendMsg(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.GetRequestName(arg_1_0)

	if var_1_0 then
		return var_0_0[var_1_0](arg_1_1)
	else
		logError("request handler not exist, cmd = " .. arg_1_0)
	end
end

function var_0_0.GetReceiveMsg(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.GetResponseName(arg_2_0)

	if var_2_0 then
		return var_0_0[var_2_0](arg_2_1)
	else
		logError("response handler not exist, cmd = " .. arg_2_0)
	end
end

function var_0_0.GetRequestName(arg_3_0)
	return var_0_0[arg_3_0][2]
end

function var_0_0.GetResponseName(arg_4_0)
	return var_0_0[arg_4_0][3]
end

function var_0_0.LoginRequest(arg_5_0)
	return var_0_0.WriteString(arg_5_0.account) .. var_0_0.WriteString(arg_5_0.password) .. var_0_0.WriteByte(arg_5_0.connectWay)
end

function var_0_0.GetLostCmdRespRequest(arg_6_0)
	return (var_0_0.WriteByte(arg_6_0.downTag))
end

function var_0_0.LoginResponse(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = 1
	local var_7_2, var_7_3 = var_0_0.ReadString(arg_7_0, var_7_1)
	local var_7_4, var_7_5 = var_0_0.ReadLong(arg_7_0, var_7_2)

	var_7_0.reason = var_7_3
	var_7_0.userId = var_7_5

	return var_7_0
end

function var_0_0.LeaveResponse(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = 1
	local var_8_2, var_8_3 = var_0_0.ReadString(arg_8_0, var_8_1)

	var_8_0.reason = var_8_3

	return var_8_0
end

function var_0_0.GetLostCmdRespResponse(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = 1
	local var_9_2, var_9_3 = var_0_0.ReadBoolean(arg_9_0, var_9_1)

	var_9_0.canGet = var_9_3

	return var_9_0
end

function var_0_0.ForceLogoutResponse(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = 1
	local var_10_2, var_10_3 = var_0_0.ReadString(arg_10_0, var_10_1)

	var_10_0.reason = var_10_3

	return var_10_0
end

function var_0_0.GetLostCmdRespResponseStartTag(arg_11_0)
	return {}
end

local var_0_1 = 256

function var_0_0.ReadString(arg_12_0, arg_12_1)
	local var_12_0 = string.byte(arg_12_0, arg_12_1)
	local var_12_1 = string.byte(arg_12_0, arg_12_1 + 1)
	local var_12_2 = var_12_0 * var_0_1 + var_12_1
	local var_12_3 = string.sub(arg_12_0, arg_12_1 + 2, arg_12_1 + 2 + var_12_2 - 1)

	return arg_12_1 + 2 + var_12_2, var_12_3
end

function var_0_0.ReadLong(arg_13_0, arg_13_1)
	local var_13_0 = 0

	for iter_13_0 = arg_13_1, arg_13_1 + 8 - 1 do
		var_13_0 = var_13_0 * var_0_1 + string.byte(arg_13_0, iter_13_0)
	end

	return arg_13_1 + 8, var_13_0
end

function var_0_0.ReadBoolean(arg_14_0, arg_14_1)
	return arg_14_1 + 1, string.byte(arg_14_0, arg_14_1) ~= 0
end

function var_0_0.WriteString(arg_15_0)
	local var_15_0 = #arg_15_0
	local var_15_1 = math.floor(var_15_0 / var_0_1)
	local var_15_2 = math.floor(var_15_0 % var_0_1)

	return string.char(var_15_1) .. string.char(var_15_2) .. arg_15_0
end

function var_0_0.WriteByte(arg_16_0)
	return string.char(arg_16_0)
end

return var_0_0
