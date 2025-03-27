module("modules.common.global.screen.GameMsgLockState", package.seeall)

slot0 = class("GameMsgLockState")
slot0.IgnoreCmds = {
	[24032.0] = true,
	[-31567.0] = true
}
slot0.IgnoreExceptionCmd = {
	25708
}
slot0.IgnoreExceptionStatus = {
	-274,
	-275,
	-276,
	-277,
	-278,
	-123,
	-124,
	-15,
	-13,
	-26,
	-310,
	-311,
	-312,
	-314,
	-321
}

function slot0.ctor(slot0)
	slot0._sendCmdList = {}
	slot0._sendProtoList = {}
	slot0._ignoreExceptionCmd = {}
	slot0._ignoreExceptionStatus = {}
	slot0._blockCmdDict = {}
	slot0._blockCount = 0

	slot0:addConstEvents()
end

function slot0.addConstEvents(slot0)
	LuaSocketMgr.instance:registerPreSender(slot0)
	LuaSocketMgr.instance:registerPreReceiver(slot0)
	slot0:setIgnoreException(uv0.IgnoreExceptionCmd, uv0.IgnoreExceptionStatus)
	LoginController.instance:registerCallback(LoginEvent.OnLogout, slot0._endBlock, slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, slot0._endBlock, slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnMsgTimeout, slot0._endBlock, slot0)
end

function slot0.preSendProto(slot0, slot1, slot2, slot3)
	if uv0.IgnoreCmds[slot1] then
		return
	end

	if slot0._blockCount == 0 then
		UIBlockMgr.instance:startBlock(UIBlockKey.MsgLock)
	end

	slot0._blockCmdDict[slot1] = slot0._blockCmdDict[slot1] and slot0._blockCmdDict[slot1] + 1 or 1
	slot0._blockCount = slot0._blockCount + 1

	TaskDispatcher.cancelTask(slot0._onDelayCancelLock, slot0)
	TaskDispatcher.runDelay(slot0._onDelayCancelLock, slot0, 30)
	table.insert(slot0._sendCmdList, slot1)
	table.insert(slot0._sendProtoList, slot2)
end

function slot0.preReceiveMsg(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if uv0.IgnoreCmds[slot2] then
		return
	end

	slot7 = nil

	while #slot0._sendCmdList > 0 do
		if table.remove(slot0._sendCmdList, #slot0._sendCmdList) == slot2 then
			slot7 = table.remove(slot0._sendProtoList, #slot0._sendProtoList)

			break
		end
	end

	if slot1 ~= 0 and slot0:_canLogException(slot2, slot1) then
		logError(string.format("<== Recv Msg, cmd:%d %s resultCode:%d desc:%s param:%s", slot2, slot3, slot1, lua_toast.configDict[slot1] and slot8.tips or "", slot7 and tostring(slot7) or ""))
	end

	if slot0._blockCmdDict[slot2] and slot8 > 0 then
		if slot8 == 1 then
			slot0._blockCmdDict[slot2] = nil
		else
			slot0._blockCmdDict[slot2] = slot8 - 1
		end

		slot0._blockCount = slot0._blockCount - 1

		if slot0._blockCount == 0 then
			UIBlockMgr.instance:endBlock(UIBlockKey.MsgLock)
			TaskDispatcher.cancelTask(slot0._onDelayCancelLock, slot0)
		end
	end
end

function slot0._onDelayCancelLock(slot0)
	for slot5, slot6 in pairs(slot0._blockCmdDict) do
		table.insert({}, module_cmd[slot5][2])
	end

	slot0:_endBlock()

	if isDebugBuild then
		logError("msg lock: " .. table.concat(slot1, " "))
	end
end

function slot0._endBlock(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayCancelLock, slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.MsgLock)

	slot0._sendCmdList = {}
	slot0._sendProtoList = {}
	slot0._blockCmdDict = {}
	slot0._blockCount = 0
end

function slot0.setIgnoreException(slot0, slot1, slot2)
	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot0._ignoreExceptionCmd[slot7] = true
		end
	end

	if slot2 then
		for slot6, slot7 in ipairs(slot2) do
			slot0._ignoreExceptionStatus[slot7] = true
		end
	end
end

function slot0._canLogException(slot0, slot1, slot2)
	return not slot0._ignoreExceptionCmd[slot1] and not slot0._ignoreExceptionStatus[slot2]
end

return slot0
