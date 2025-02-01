module("modules.logic.social.model.SocialMessageMO", package.seeall)

slot0 = pureTable("SocialMessageMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.msgId
	slot0.msgId = slot1.msgId
	slot0.channelType = slot1.channelType
	slot0.senderId = slot1.senderId
	slot0.senderName = slot1.senderName
	slot0.portrait = slot1.portrait
	slot0.content = slot1.content
	slot0.sendTime = slot1.sendTime
	slot0.level = slot1.level
	slot0.recipientId = slot1.recipientId
	slot0.msgType = slot1.msgType
	slot0.extData = slot1.extData
end

function slot0.getSenderName(slot0)
	return SocialModel.instance:getPlayerMO(slot0.senderId) and slot1.name or slot0.senderName
end

function slot0.getPortrait(slot0)
	return SocialModel.instance:getPlayerMO(slot0.senderId) and slot1.portrait or slot0.portrait
end

function slot0.getLevel(slot0)
	return SocialModel.instance:getPlayerMO(slot0.senderId) and slot1.level or slot0.level
end

function slot0.isHasOp(slot0)
	if ChatEnum.MsgType.RoomSeekShare == slot0.msgType then
		return slot0.recipientId == PlayerModel.instance:getMyUserId()
	elseif ChatEnum.MsgType.RoomShareCode == slot0.msgType then
		return true
	end

	return false
end

return slot0
