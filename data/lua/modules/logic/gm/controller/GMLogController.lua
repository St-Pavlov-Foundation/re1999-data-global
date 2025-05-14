module("modules.logic.gm.controller.GMLogController", package.seeall)

local var_0_0 = class("GMLogController", BaseController)
local var_0_1 = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=8feabd52-f611-4a10-8ad8-5b3c94c79bd2"
local var_0_2 = 1600
local var_0_3 = 1
local var_0_4 = 20

function var_0_0.onInitFinish(arg_1_0)
	if isDebugBuild then
		arg_1_0._msgCounter = var_0_4

		SLFramework.SLLogger.SetErrorCallback(arg_1_0._onErrorMsg, arg_1_0)
		TaskDispatcher.runRepeat(arg_1_0._onCoolDown, arg_1_0, var_0_3)
		TaskDispatcher.runRepeat(arg_1_0._onTick, arg_1_0, 1)
		GMController.instance:registerCallback(GMEvent.GMLog_UpdateCount, arg_1_0._updateCount, arg_1_0)

		arg_1_0._logQueue = {}
	end

	arg_1_0._errorAlertGO = nil
end

function var_0_0.block(arg_2_0)
	arg_2_0:hideAlert()
	SLFramework.SLLogger.SetErrorCallback(nil, nil)
	TaskDispatcher.cancelTask(arg_2_0._onCoolDown, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._onTick, arg_2_0)
end

function var_0_0.cancelBlock(arg_3_0)
	arg_3_0:showAlert()
	arg_3_0:_updateCount()
	SLFramework.SLLogger.SetErrorCallback(arg_3_0._onErrorMsg, arg_3_0)
	TaskDispatcher.runRepeat(arg_3_0._onCoolDown, arg_3_0, var_0_3)
end

function var_0_0._onCoolDown(arg_4_0)
	if arg_4_0._msgCounter < var_0_4 then
		arg_4_0._msgCounter = arg_4_0._msgCounter + 1
	end
end

function var_0_0._onTick(arg_5_0)
	if not arg_5_0._logQueue or #arg_5_0._logQueue == 0 then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._logQueue) do
		local var_5_0 = iter_5_1.logString
		local var_5_1 = iter_5_1.stackTrace
		local var_5_2 = iter_5_1.logType

		GMLogModel.instance:addMsg(var_5_0, var_5_1, var_5_2)

		if var_5_2 == 0 then
			if not arg_5_0._errorAlertGO then
				local var_5_3 = ViewMgr.instance:getUILayer(UILayerName.Top)

				arg_5_0._errorAlertGO = GMController.instance:getGMNode("erroralert", var_5_3)

				if arg_5_0._errorAlertGO then
					arg_5_0._btnAlert = gohelper.findChildButtonWithAudio(arg_5_0._errorAlertGO, "btnAlert")

					arg_5_0._btnAlert:AddClickListener(arg_5_0._onClickAlert, arg_5_0)

					arg_5_0._txtCount = gohelper.findChildText(arg_5_0._errorAlertGO, "btnAlert/image/txtCount")
				end
			end

			if arg_5_0._errorAlertGO then
				gohelper.setActive(arg_5_0._errorAlertGO, true)
				arg_5_0:_updateCount()
			end
		end

		GMController.instance:dispatchEvent(GMEvent.GMLog_Trigger, var_5_0, var_5_1, var_5_2)
	end

	tabletool.clear(arg_5_0._logQueue)
end

function var_0_0._onErrorMsg(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._msgCounter = arg_6_0._msgCounter - 1

	if arg_6_0._msgCounter < 0 then
		arg_6_0._msgCounter = 0

		return
	end

	table.insert(arg_6_0._logQueue, {
		logString = arg_6_1,
		stackTrace = arg_6_2,
		logType = arg_6_3
	})
end

function var_0_0.showAlert(arg_7_0)
	gohelper.setActive(arg_7_0._errorAlertGO, true)
end

function var_0_0.hideAlert(arg_8_0)
	gohelper.setActive(arg_8_0._errorAlertGO, false)
end

function var_0_0._updateCount(arg_9_0)
	if arg_9_0._txtCount then
		arg_9_0._txtCount.text = tostring(GMLogModel.instance.errorModel:getCount())
	end
end

function var_0_0._onClickAlert(arg_10_0)
	if not ViewMgr.instance:isOpen(ViewName.GMErrorView) then
		ViewMgr.instance:openView(ViewName.GMErrorView)
	end
end

function var_0_0.sendRobotMsg(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = string.split(arg_11_1, "stack traceback:")

	logWarn(var_11_0[1])

	local var_11_1 = UnityEngine.SystemInfo.deviceModel
	local var_11_2 = PlayerModel.instance:getPlayinfo()

	if var_11_2 and not string.nilorempty(var_11_2.userId) and var_11_2.userId ~= 0 then
		var_11_1 = string.format("**角色ID：**<font color=\"info\">%s</font>\n**角色名：**%s\n**设备：**%s", tostring(var_11_2.userId), tostring(var_11_2.name), tostring(var_11_1))
	end

	if not string.nilorempty(LoginModel.instance.serverName) then
		var_11_1 = string.format("%s\n**服务器：**%s\n", var_11_1, LoginModel.instance.serverName)
	end

	if not string.nilorempty(var_11_0[2]) then
		arg_11_1 = string.format("%s\n**报错：**<font color=\"warning\">%s</font>\n**stack traceback：**\n%s\n \n%s", tostring(var_11_1), tostring(var_11_0[1]), tostring(var_11_0[2]), tostring(arg_11_2))
	else
		arg_11_1 = string.format("%s\n**报错：**<font color=\"warning\">%s</font>\n**stack traceback：**\n \n%s", tostring(var_11_1), tostring(var_11_0[1]), tostring(arg_11_2))
	end

	if string.len(arg_11_1) > var_0_2 then
		arg_11_1 = string.sub(arg_11_1, 1, var_0_2)
	end

	local var_11_3 = {
		msgtype = "markdown",
		markdown = {
			content = arg_11_1
		}
	}
	local var_11_4 = cjson.encode(var_11_3)

	SLFramework.SLWebRequest.Instance:PostJson(var_0_1, var_11_4, arg_11_0._onSendSucc, arg_11_0)
end

function var_0_0._onSendSucc(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 then
		GameFacade.showToast(ToastEnum.IconId, "send success")
	else
		GameFacade.showToast(ToastEnum.IconId, "send fail " .. arg_12_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
