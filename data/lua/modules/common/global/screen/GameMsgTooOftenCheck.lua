module("modules.common.global.screen.GameMsgTooOftenCheck", package.seeall)

slot0 = class("GameMsgTooOftenCheck", BasePreSender)
slot1 = 1
slot2 = 90
slot3 = 3
slot4 = {}

function slot0.ctor(slot0)
	slot0._sendProtoTime = {}
	slot0._sendProtoList = {}
	slot0._toSendProtoTime = {}
	slot0._toSendProtoList = {}

	slot0:addConstEvents()
end

function slot0.addConstEvents(slot0)
	if isDebugBuild then
		LuaSocketMgr.instance:registerPreSender(slot0)
	end
end

function slot0.blockSendProto(slot0, slot1, slot2, slot3)
	if not slot2 then
		return
	end

	if uv0[slot1] then
		return
	end

	slot0:_removeOutdatedProto(slot0._sendProtoTime, slot0._sendProtoList)
	slot0:_removeOutdatedProto(slot0._toSendProtoTime, slot0._toSendProtoList)
	table.insert(slot0._toSendProtoTime, Time.realtimeSinceStartup)
	table.insert(slot0._toSendProtoList, slot2)

	for slot10, slot11 in ipairs(slot0._toSendProtoList) do
		if slot2.__cname == slot11.__cname and (nil or tostring(slot2)) == tostring(slot11) and uv1 < 0 + 1 then
			logError(string.format("发完全相同的包过于频繁，%d秒%d个\n%s", uv2, slot5, slot2.__cname .. "{\n" .. slot6 .. "}"))

			break
		end
	end

	if uv3 < #slot0._sendProtoList then
		logError(string.format("发包过于频繁，%d秒%d个，请求已被拦截\n%s", uv2, #slot0._toSendProtoList, slot2.__cname .. "{\n" .. slot6 .. "}"))

		return true
	end

	table.insert(slot0._sendProtoTime, slot4)
	table.insert(slot0._sendProtoList, slot2)
end

function slot0._removeOutdatedProto(slot0, slot1, slot2)
	for slot8 = 1, #slot1 do
		if uv0 <= Time.realtimeSinceStartup - slot1[1] then
			table.remove(slot1, 1)
			table.remove(slot2, 1)
		else
			break
		end
	end
end

return slot0
