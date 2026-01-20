-- chunkname: @modules/logic/gm/controller/SendWeWorkFileHelper.lua

module("modules.logic.gm.controller.SendWeWorkFileHelper", package.seeall)

local SendWeWorkFileHelper = class("SendWeWorkFileHelper")
local uploadUrl = "https://qyapi.weixin.qq.com/cgi-bin/webhook/upload_media?key=eea1a1a3-ed85-49a2-9178-449d249f1329&type=file"
local sendMsgUrl = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=eea1a1a3-ed85-49a2-9178-449d249f1329"

function SendWeWorkFileHelper.SendUserInfo(callback, callbackObj)
	local deviceUser = UnityEngine.SystemInfo.deviceModel
	local playerInfo = PlayerModel.instance:getPlayinfo()
	local msg = ""

	msg = string.format("**角色ID：**<font color=\"info\">%s</font>\n**角色名：**%s\n**设备：**%s", tostring(playerInfo and playerInfo.userId), tostring(playerInfo and playerInfo.name), tostring(deviceUser))
	msg = string.format("%s\n**服务器：**%s\n", msg, LoginModel.instance.serverName)

	local msgJson = {
		msgtype = "markdown",
		markdown = {
			content = msg
		}
	}
	local msgJsonStr = cjson.encode(msgJson)

	SLFramework.SLWebRequestClient.Instance:PostJson(sendMsgUrl, msgJsonStr, callback or SendWeWorkFileHelper.onSendSuccess, callbackObj)
end

function SendWeWorkFileHelper.onSendSuccess(_, isSuccess, msg)
	if isSuccess then
		GameFacade.showToast(ToastEnum.IconId, "send success")
	else
		GameFacade.showToast(ToastEnum.IconId, "send fail " .. tostring(msg))
	end
end

function SendWeWorkFileHelper.SendFile(filePath, callback, callbackObj)
	ZProj.SendWeWorkFileHelper.Instance:SendFile(uploadUrl, sendMsgUrl, filePath, callback or SendWeWorkFileHelper.SendUserInfo, callbackObj)
end

function SendWeWorkFileHelper.SendPersistentFile(filePath)
	ZProj.SendWeWorkFileHelper.Instance:SendPersistentFile(uploadUrl, sendMsgUrl, filePath, SendWeWorkFileHelper.SendUserInfo)
end

function SendWeWorkFileHelper.SendCurLogFile()
	ZProj.SendWeWorkFileHelper.Instance:SendCurLogFile(uploadUrl, sendMsgUrl, SendWeWorkFileHelper.SendUserInfo)
end

function SendWeWorkFileHelper.SendLastLogFile()
	local dir

	if SLFramework.FrameworkSettings.IsEditor then
		dir = string.gsub(UnityEngine.Application.dataPath, "Assets", "")
	else
		dir = UnityEngine.Application.persistentDataPath
	end

	local filePath = System.IO.Path.Combine(dir, "logicLog.old")

	ZProj.SendWeWorkFileHelper.Instance:SendFile(uploadUrl, sendMsgUrl, filePath, SendWeWorkFileHelper.SendUserInfo)
end

SendWeWorkFileHelper.SendFightLogKey = "send fight log"

function SendWeWorkFileHelper.sendFightLogFile()
	SendWeWorkFileHelper.clearFlow()

	local roundDataList = FightDataHelper.roundMgr:getAllOriginRoundData()

	if not roundDataList then
		return
	end

	SendWeWorkFileHelper.sendFightLogFlow = FlowSequence.New()

	for roundIndex, roundData in ipairs(roundDataList) do
		SendWeWorkFileHelper.sendFightLogFlow:addWork(SendFightLogWork.New(roundIndex, roundData))
	end

	SendWeWorkFileHelper.sendFightLogFlow:addWork(SendUserInfoLogWork.New())
	UIBlockMgr.instance:startBlock(SendWeWorkFileHelper.SendFightLogKey)
	SendWeWorkFileHelper.sendFightLogFlow:registerDoneListener(SendWeWorkFileHelper.onSendFlowDone)
	SendWeWorkFileHelper.sendFightLogFlow:start(FightModel.instance:getFightParam())
end

function SendWeWorkFileHelper.clearFlow()
	if SendWeWorkFileHelper.sendFightLogFlow then
		SendWeWorkFileHelper.sendFightLogFlow:stop()
		SendWeWorkFileHelper.sendFightLogFlow:destroy()

		SendWeWorkFileHelper.sendFightLogFlow = nil
	end

	UIBlockMgr.instance:endBlock(SendWeWorkFileHelper.SendFightLogKey)
end

function SendWeWorkFileHelper.onSendFlowDone()
	UIBlockMgr.instance:endBlock(SendWeWorkFileHelper.SendFightLogKey)

	SendWeWorkFileHelper.sendFightLogFlow = nil
end

return SendWeWorkFileHelper
