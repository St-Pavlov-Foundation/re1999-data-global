module("modules.logic.gm.controller.GMLogController", package.seeall)

slot0 = class("GMLogController", BaseController)
slot1 = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=8feabd52-f611-4a10-8ad8-5b3c94c79bd2"
slot2 = 1600
slot3 = 1
slot4 = 20

function slot0.onInitFinish(slot0)
	if isDebugBuild then
		slot0._msgCounter = uv0

		SLFramework.SLLogger.SetErrorCallback(slot0._onErrorMsg, slot0)
		TaskDispatcher.runRepeat(slot0._onCoolDown, slot0, uv1)
		TaskDispatcher.runRepeat(slot0._onTick, slot0, 1)
		GMController.instance:registerCallback(GMEvent.GMLog_UpdateCount, slot0._updateCount, slot0)

		slot0._logQueue = {}
	end

	slot0._errorAlertGO = nil
end

function slot0.block(slot0)
	slot0:hideAlert()
	SLFramework.SLLogger.SetErrorCallback(nil, )
	TaskDispatcher.cancelTask(slot0._onCoolDown, slot0)
	TaskDispatcher.cancelTask(slot0._onTick, slot0)
end

function slot0.cancelBlock(slot0)
	slot0:showAlert()
	slot0:_updateCount()
	SLFramework.SLLogger.SetErrorCallback(slot0._onErrorMsg, slot0)
	TaskDispatcher.runRepeat(slot0._onCoolDown, slot0, uv0)
end

function slot0._onCoolDown(slot0)
	if slot0._msgCounter < uv0 then
		slot0._msgCounter = slot0._msgCounter + 1
	end
end

function slot0._onTick(slot0)
	if not slot0._logQueue or #slot0._logQueue == 0 then
		return
	end

	for slot4, slot5 in ipairs(slot0._logQueue) do
		slot8 = slot5.logType

		GMLogModel.instance:addMsg(slot5.logString, slot5.stackTrace, slot8)

		if slot8 == 0 then
			if not slot0._errorAlertGO then
				slot0._errorAlertGO = GMController.instance:getGMNode("erroralert", ViewMgr.instance:getUILayer(UILayerName.Top))

				if slot0._errorAlertGO then
					slot0._btnAlert = gohelper.findChildButtonWithAudio(slot0._errorAlertGO, "btnAlert")

					slot0._btnAlert:AddClickListener(slot0._onClickAlert, slot0)

					slot0._txtCount = gohelper.findChildText(slot0._errorAlertGO, "btnAlert/image/txtCount")
				end
			end

			if slot0._errorAlertGO then
				gohelper.setActive(slot0._errorAlertGO, true)
				slot0:_updateCount()
			end
		end

		GMController.instance:dispatchEvent(GMEvent.GMLog_Trigger, slot6, slot7, slot8)
	end

	tabletool.clear(slot0._logQueue)
end

function slot0._onErrorMsg(slot0, slot1, slot2, slot3)
	slot0._msgCounter = slot0._msgCounter - 1

	if slot0._msgCounter < 0 then
		slot0._msgCounter = 0

		return
	end

	table.insert(slot0._logQueue, {
		logString = slot1,
		stackTrace = slot2,
		logType = slot3
	})
end

function slot0.showAlert(slot0)
	gohelper.setActive(slot0._errorAlertGO, true)
end

function slot0.hideAlert(slot0)
	gohelper.setActive(slot0._errorAlertGO, false)
end

function slot0._updateCount(slot0)
	if slot0._txtCount then
		slot0._txtCount.text = tostring(GMLogModel.instance.errorModel:getCount())
	end
end

function slot0._onClickAlert(slot0)
	if not ViewMgr.instance:isOpen(ViewName.GMErrorView) then
		ViewMgr.instance:openView(ViewName.GMErrorView)
	end
end

function slot0.sendRobotMsg(slot0, slot1, slot2)
	logWarn(string.split(slot1, "stack traceback:")[1])

	if PlayerModel.instance:getPlayinfo() and not string.nilorempty(slot5.userId) and slot5.userId ~= 0 then
		slot4 = string.format("**角色ID：**<font color=\"info\">%s</font>\n**角色名：**%s\n**设备：**%s", tostring(slot5.userId), tostring(slot5.name), tostring(UnityEngine.SystemInfo.deviceModel))
	end

	if not string.nilorempty(LoginModel.instance.serverName) then
		slot4 = string.format("%s\n**服务器：**%s\n", slot4, LoginModel.instance.serverName)
	end

	if uv0 < string.len((string.nilorempty(slot3[2]) or string.format([[
%s
**报错：**<font color="warning">%s</font>
**stack traceback：**
%s
 
%s]], tostring(slot4), tostring(slot3[1]), tostring(slot3[2]), tostring(slot2))) and string.format([[
%s
**报错：**<font color="warning">%s</font>
**stack traceback：**
 
%s]], tostring(slot4), tostring(slot3[1]), tostring(slot2))) then
		slot1 = string.sub(slot1, 1, uv0)
	end

	SLFramework.SLWebRequest.Instance:PostJson(uv1, cjson.encode({
		msgtype = "markdown",
		markdown = {
			content = slot1
		}
	}), slot0._onSendSucc, slot0)
end

function slot0._onSendSucc(slot0, slot1, slot2)
	if slot1 then
		GameFacade.showToast(ToastEnum.IconId, "send success")
	else
		GameFacade.showToast(ToastEnum.IconId, "send fail " .. slot2)
	end
end

slot0.instance = slot0.New()

return slot0
