module("modules.logic.login.model.LoginModel", package.seeall)

slot0 = class("LoginModel", BaseModel)
slot1 = {
	DoingLogin = 2,
	DoneLogin = 3,
	NotLogin = 1
}
slot0.FailAlertCount = 3

function slot0.onInit(slot0)
	slot0.serverIp = nil
	slot0.serverPort = nil
	slot0.serverBakIp = nil
	slot0.serverBakPort = nil
	slot0.serverName = nil
	slot0.serverId = nil
	slot0.userName = nil
	slot0.sessionId = nil
	slot0.channelSessionId = nil
	slot0.channelUserId = nil
	slot0.channelId = nil
	slot0.channelGameCode = nil
	slot0.channelGameId = nil
	slot0._useBackupUrl = false

	slot0:notLogin()
end

function slot0.reInit(slot0)
	slot0:notLogin()
end

function slot0.isNotLogin(slot0)
	return slot0._loginStatus == uv0.NotLogin
end

function slot0.isDoingLogin(slot0)
	return slot0._loginStatus == uv0.DoingLogin
end

function slot0.isDoneLogin(slot0)
	return slot0._loginStatus == uv0.DoneLogin
end

function slot0.notLogin(slot0)
	slot0._loginStatus = uv0.NotLogin
end

function slot0.doingLogin(slot0)
	slot0._loginStatus = uv0.DoingLogin
end

function slot0.doneLogin(slot0)
	slot0._loginStatus = uv0.DoneLogin
end

function slot0.clearDatas(slot0)
	slot0:onInit()
end

function slot0.setChannelParam(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.channelSessionId = slot1
	slot0.channelUserId = slot2
	slot0.channelId = slot3
	slot0.channelGameCode = slot4
	slot0.channelGameId = slot5
end

function slot0.getUseBackup(slot0)
	if HotUpdateMgr.getUseBackup then
		return HotUpdateMgr.instance:getUseBackup()
	end

	return slot0._useBackupUrl
end

function slot0.inverseUseBackup(slot0)
	if HotUpdateMgr.inverseUseBackup then
		HotUpdateMgr.instance:inverseUseBackup()

		return
	end

	slot0._useBackupUrl = not slot0._useBackupUrl
end

function slot0.getFailCount(slot0)
	return slot0._failCount or 0
end

function slot0.resetFailCount(slot0)
	slot0._failCount = 0
	slot0._failAlertCount = 0
end

function slot0.incFailCount(slot0)
	slot0._failCount = slot0._failCount and slot0._failCount + 1 or 1
	slot0._failAlertCount = slot0._failAlertCount and slot0._failAlertCount + 1 or 1
end

function slot0.getFailAlertCount(slot0)
	return slot0._failAlertCount or 0
end

function slot0.resetFailAlertCount(slot0)
	slot0._failAlertCount = 0
end

function slot0.isFailNeedAlert(slot0)
	return uv0.FailAlertCount <= slot0._failAlertCount
end

function slot0.getFailCountBlockStr(slot0, slot1)
	return string.format("CONNECTING...(%d)", slot1 or slot0:getFailAlertCount())
end

slot0.instance = slot0.New()

return slot0
