module("modules.logic.gm.controller.SendWeWorkFileHelper", package.seeall)

local var_0_0 = class("SendWeWorkFileHelper")
local var_0_1 = "https://qyapi.weixin.qq.com/cgi-bin/webhook/upload_media?key=eea1a1a3-ed85-49a2-9178-449d249f1329&type=file"
local var_0_2 = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=eea1a1a3-ed85-49a2-9178-449d249f1329"

function var_0_0.SendUserInfo(arg_1_0, arg_1_1)
	local var_1_0 = UnityEngine.SystemInfo.deviceModel
	local var_1_1 = PlayerModel.instance:getPlayinfo()
	local var_1_2 = ""
	local var_1_3 = string.format("**角色ID：**<font color=\"info\">%s</font>\n**角色名：**%s\n**设备：**%s", tostring(var_1_1 and var_1_1.userId), tostring(var_1_1 and var_1_1.name), tostring(var_1_0))
	local var_1_4 = string.format("%s\n**服务器：**%s\n", var_1_3, LoginModel.instance.serverName)
	local var_1_5 = {
		msgtype = "markdown",
		markdown = {
			content = var_1_4
		}
	}
	local var_1_6 = cjson.encode(var_1_5)

	SLFramework.SLWebRequest.Instance:PostJson(var_0_2, var_1_6, arg_1_0 or var_0_0.onSendSuccess, arg_1_1)
end

function var_0_0.onSendSuccess(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 then
		GameFacade.showToast(ToastEnum.IconId, "send success")
	else
		GameFacade.showToast(ToastEnum.IconId, "send fail " .. tostring(arg_2_2))
	end
end

function var_0_0.SendFile(arg_3_0, arg_3_1, arg_3_2)
	ZProj.SendWeWorkFileHelper.Instance:SendFile(var_0_1, var_0_2, arg_3_0, arg_3_1 or var_0_0.SendUserInfo, arg_3_2)
end

function var_0_0.SendPersistentFile(arg_4_0)
	ZProj.SendWeWorkFileHelper.Instance:SendPersistentFile(var_0_1, var_0_2, arg_4_0, var_0_0.SendUserInfo)
end

function var_0_0.SendCurLogFile()
	ZProj.SendWeWorkFileHelper.Instance:SendCurLogFile(var_0_1, var_0_2, var_0_0.SendUserInfo)
end

function var_0_0.SendLastLogFile()
	local var_6_0

	if SLFramework.FrameworkSettings.IsEditor then
		var_6_0 = string.gsub(UnityEngine.Application.dataPath, "Assets", "")
	else
		var_6_0 = UnityEngine.Application.persistentDataPath
	end

	local var_6_1 = System.IO.Path.Combine(var_6_0, "logicLog.old")

	ZProj.SendWeWorkFileHelper.Instance:SendFile(var_0_1, var_0_2, var_6_1, var_0_0.SendUserInfo)
end

var_0_0.SendFightLogKey = "send fight log"

function var_0_0.sendFightLogFile()
	var_0_0.clearFlow()

	local var_7_0 = FightDataHelper.roundMgr:getAllOriginRoundData()

	if not var_7_0 then
		return
	end

	var_0_0.sendFightLogFlow = FlowSequence.New()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		var_0_0.sendFightLogFlow:addWork(SendFightLogWork.New(iter_7_0, iter_7_1))
	end

	var_0_0.sendFightLogFlow:addWork(SendUserInfoLogWork.New())
	UIBlockMgr.instance:startBlock(var_0_0.SendFightLogKey)
	var_0_0.sendFightLogFlow:registerDoneListener(var_0_0.onSendFlowDone)
	var_0_0.sendFightLogFlow:start(FightModel.instance:getFightParam())
end

function var_0_0.clearFlow()
	if var_0_0.sendFightLogFlow then
		var_0_0.sendFightLogFlow:stop()
		var_0_0.sendFightLogFlow:destroy()

		var_0_0.sendFightLogFlow = nil
	end

	UIBlockMgr.instance:endBlock(var_0_0.SendFightLogKey)
end

function var_0_0.onSendFlowDone()
	UIBlockMgr.instance:endBlock(var_0_0.SendFightLogKey)

	var_0_0.sendFightLogFlow = nil
end

return var_0_0
