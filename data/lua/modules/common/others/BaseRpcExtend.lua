module("modules.common.others.BaseRpcExtend", package.seeall)

slot0 = class("BaseRpcExtend", BaseRpc)

function slot0.onInitInternal(slot0)
	slot0._getter = GameUtil.getUniqueTb(10000)
	slot0._waitCallBackDict = {}

	uv0.super.onInitInternal(slot0)
end

function slot0.reInitInternal(slot0)
	slot0._waitCallBackDict = {}

	uv0.super.reInitInternal(slot0)
end

function slot0.sendMsg(slot0, slot1, slot2, slot3, slot4)
	if not slot0._waitCallBackDict[LuaSocketMgr.instance:getCmdByPbStructName(slot1.__cname)] then
		slot0._waitCallBackDict[slot5] = {}
	end

	if slot0._waitCallBackDict[slot5][1] ~= nil then
		uv0.super.sendMsg(slot0, slot1, nil, , slot4)
	else
		uv0.super.sendMsg(slot0, slot1, slot0.onReceiveMsgExtend, slot0, slot4)
	end

	if slot2 then
		slot6 = LuaGeneralCallback.getPool():getObject()
		slot6.callback = slot2

		slot6:setCbObj(slot3)

		slot6.id = slot0._getter()

		table.insert(slot0._waitCallBackDict[slot5], slot6)

		return slot6.id
	else
		table.insert(slot0._waitCallBackDict[slot5], false)
	end
end

function slot0.removeCallbackByIdExtend(slot0, slot1)
	for slot5, slot6 in pairs(slot0._waitCallBackDict) do
		for slot10, slot11 in ipairs(slot6) do
			if slot11 and slot11.id == slot1 then
				slot6[slot10] = false

				LuaGeneralCallback.getPool():putObject(slot11)

				return
			end
		end
	end
end

function slot0.onReceiveMsgExtend(slot0, slot1, slot2, slot3)
	if not slot0._waitCallBackDict[slot1] then
		return
	end

	slot4 = table.remove(slot0._waitCallBackDict[slot1], 1)

	if slot0._waitCallBackDict[slot1][1] ~= nil then
		slot0:addCallback(slot1, slot0.onReceiveMsgExtend, slot0)
	end

	if slot4 then
		slot4:invoke(slot1, slot2, slot3)
		LuaGeneralCallback.getPool():putObject(slot4)
	end
end

return slot0
