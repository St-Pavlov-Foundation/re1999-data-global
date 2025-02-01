module("modules.logic.common.prerecvmsg.PreReciveLogicMsg", package.seeall)

slot0 = class("PreReciveLogicMsg", BasePreReceiver)

function slot0.ctor(slot0)
end

function slot0.init(slot0)
	LuaSocketMgr.instance:registerPreReceiver(slot0)
end

function slot0.preReceiveMsg(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot1 == 0 then
		return
	end

	if not lua_toast.configDict[slot1] then
		logError("PreReciveLogicMsg:preReceiveMsg 没有为业务错误码：" .. slot1 .. " 配置提示语！！《P飘字表》- export_飘字表")

		return
	end

	GameFacade.showToast(slot1)
end

function slot0.preReceiveSysMsg(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot1 == 0 then
		return
	end

	LoginController.instance:_stopHeartBeat()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.StopLoading)
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.ForbidLogin, MsgBoxEnum.BoxType.Yes, function ()
		LoginController.instance:logout()
	end, nil, , , , , slot4.reason)
end

slot0.instance = slot0.New()

return slot0
