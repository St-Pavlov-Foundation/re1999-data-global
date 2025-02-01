module("modules.logic.reddot.rpc.RedDotRpc", package.seeall)

slot0 = class("RedDotRpc", BaseRpc)

function slot0.sendGetRedDotInfosRequest(slot0, slot1, slot2, slot3)
	slot4 = RedDotModule_pb.GetRedDotInfosRequest()

	if slot1 then
		for slot8, slot9 in ipairs(slot1) do
			table.insert(slot4.ids, slot9)
		end
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetRedDotInfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		RedDotModel.instance:setRedDotInfo(slot2.redDotInfos)

		slot3 = {}

		for slot7, slot8 in ipairs(slot2.redDotInfos) do
			for slot13, slot14 in pairs(RedDotModel.instance:_getAssociateRedDots(slot8.defineId)) do
				slot3[slot14] = true
			end
		end

		RedDotController.instance:CheckExpireDot()
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, slot3)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function slot0.onReceiveUpdateRedDotPush(slot0, slot1, slot2)
	if slot1 == 0 then
		RedDotModel.instance:updateRedDotInfo(slot2.redDotInfos)

		slot3 = {}

		for slot7, slot8 in ipairs(slot2.redDotInfos) do
			for slot13, slot14 in pairs(RedDotModel.instance:_getAssociateRedDots(slot8.defineId)) do
				slot3[slot14] = true
			end
		end

		RedDotController.instance:CheckExpireDot()
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, slot3)
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function slot0.sendShowRedDotRequest(slot0, slot1, slot2)
	slot3 = RedDotModule_pb.ShowRedDotRequest()
	slot3.defineId = slot1
	slot3.isVisible = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveShowRedDotReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.clientAddRedDotGroupList(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot3[slot8.id] = slot3[slot8.id] or {}

		table.insert(slot3[slot8.id], slot0:clientMakeRedDotGroupItem(slot8.uid, slot8.value))
	end

	slot4 = {
		redDotInfos = {},
		replaceAll = slot2 or false
	}

	for slot8, slot9 in pairs(slot3) do
		table.insert(slot4.redDotInfos, slot0:clientMakeRedDotGroup(slot8, slot9, slot2))
	end

	slot0:onReceiveUpdateRedDotPush(0, slot4)
end

function slot0.clientMakeRedDotGroupItem(slot0, slot1, slot2, slot3, slot4)
	return {
		id = slot1 or 0,
		value = slot2 or 0,
		time = slot3 or 0,
		ext = slot4 or ""
	}
end

function slot0.clientMakeRedDotGroup(slot0, slot1, slot2, slot3)
	return {
		defineId = slot1,
		infos = slot2,
		replaceAll = slot3 or false
	}
end

slot0.instance = slot0.New()

return slot0
