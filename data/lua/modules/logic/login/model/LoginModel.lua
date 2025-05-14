module("modules.logic.login.model.LoginModel", package.seeall)

local var_0_0 = class("LoginModel", BaseModel)
local var_0_1 = {
	DoingLogin = 2,
	DoneLogin = 3,
	NotLogin = 1
}

var_0_0.FailAlertCount = 3

function var_0_0.onInit(arg_1_0)
	arg_1_0.serverIp = nil
	arg_1_0.serverPort = nil
	arg_1_0.serverBakIp = nil
	arg_1_0.serverBakPort = nil
	arg_1_0.serverName = nil
	arg_1_0.serverId = nil
	arg_1_0.userName = nil
	arg_1_0.sessionId = nil
	arg_1_0.channelSessionId = nil
	arg_1_0.channelUserId = nil
	arg_1_0.channelId = nil
	arg_1_0.channelGameCode = nil
	arg_1_0.channelGameId = nil
	arg_1_0._useBackupUrl = false

	arg_1_0:notLogin()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:notLogin()
end

function var_0_0.isNotLogin(arg_3_0)
	return arg_3_0._loginStatus == var_0_1.NotLogin
end

function var_0_0.isDoingLogin(arg_4_0)
	return arg_4_0._loginStatus == var_0_1.DoingLogin
end

function var_0_0.isDoneLogin(arg_5_0)
	return arg_5_0._loginStatus == var_0_1.DoneLogin
end

function var_0_0.notLogin(arg_6_0)
	arg_6_0._loginStatus = var_0_1.NotLogin
end

function var_0_0.doingLogin(arg_7_0)
	arg_7_0._loginStatus = var_0_1.DoingLogin
end

function var_0_0.doneLogin(arg_8_0)
	arg_8_0._loginStatus = var_0_1.DoneLogin
end

function var_0_0.clearDatas(arg_9_0)
	arg_9_0:onInit()
end

function var_0_0.setChannelParam(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	arg_10_0.channelSessionId = arg_10_1
	arg_10_0.channelUserId = arg_10_2
	arg_10_0.channelId = arg_10_3
	arg_10_0.channelGameCode = arg_10_4
	arg_10_0.channelGameId = arg_10_5
end

function var_0_0.getUseBackup(arg_11_0)
	if HotUpdateMgr.getUseBackup then
		return HotUpdateMgr.instance:getUseBackup()
	end

	return arg_11_0._useBackupUrl
end

function var_0_0.inverseUseBackup(arg_12_0)
	if HotUpdateMgr.inverseUseBackup then
		HotUpdateMgr.instance:inverseUseBackup()

		return
	end

	arg_12_0._useBackupUrl = not arg_12_0._useBackupUrl
end

function var_0_0.getFailCount(arg_13_0)
	return arg_13_0._failCount or 0
end

function var_0_0.resetFailCount(arg_14_0)
	arg_14_0._failCount = 0
	arg_14_0._failAlertCount = 0
end

function var_0_0.incFailCount(arg_15_0)
	arg_15_0._failCount = arg_15_0._failCount and arg_15_0._failCount + 1 or 1
	arg_15_0._failAlertCount = arg_15_0._failAlertCount and arg_15_0._failAlertCount + 1 or 1
end

function var_0_0.getFailAlertCount(arg_16_0)
	return arg_16_0._failAlertCount or 0
end

function var_0_0.resetFailAlertCount(arg_17_0)
	arg_17_0._failAlertCount = 0
end

function var_0_0.isFailNeedAlert(arg_18_0)
	return arg_18_0._failAlertCount >= var_0_0.FailAlertCount
end

function var_0_0.getFailCountBlockStr(arg_19_0, arg_19_1)
	return string.format("CONNECTING...(%d)", arg_19_1 or arg_19_0:getFailAlertCount())
end

var_0_0.instance = var_0_0.New()

return var_0_0
