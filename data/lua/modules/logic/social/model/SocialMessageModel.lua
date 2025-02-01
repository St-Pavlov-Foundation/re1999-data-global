module("modules.logic.social.model.SocialMessageModel", package.seeall)

slot0 = class("SocialMessageModel", BaseModel)

function slot0.onInit(slot0)
	slot0._socialMessageMOListDict = {
		[SocialEnum.ChannelType.Friend] = {}
	}
	slot0._messageUnreadDict = nil
end

function slot0.reInit(slot0)
	slot0._socialMessageMOListDict = {
		[SocialEnum.ChannelType.Friend] = {}
	}
	slot0._messageUnreadDict = nil
end

function slot0.loadSocialMessages(slot0, slot1, slot2, slot3)
	if not slot0._socialMessageMOListDict[slot1][slot2] then
		slot4 = {}

		for slot8, slot9 in ipairs(slot3) do
			slot10 = SocialMessageMO.New()

			slot10:init(slot9)
			table.insert(slot4, slot10)
		end

		slot0._socialMessageMOListDict[slot1][slot2] = slot4
	end
end

function slot0.saveSocialMessages(slot0, slot1, slot2)
	if slot0._socialMessageMOListDict[slot1][slot2] then
		SocialMessageController.instance:writeSocialMessages(slot1, slot2, slot0._socialMessageMOListDict[slot1][slot2])
	end
end

function slot0.getSocialMessageMOList(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if not slot0._socialMessageMOListDict[slot1][slot2] then
		SocialMessageController.instance:readSocialMessages(slot1, slot2)
	end

	return slot0._socialMessageMOListDict[slot1][slot2]
end

function slot0.loadMessageUnread(slot0, slot1)
	slot0._messageUnreadDict = slot1
end

function slot0.saveMessageUnread(slot0)
	if slot0._messageUnreadDict then
		SocialMessageController.instance:writeMessageUnread(slot0._messageUnreadDict)
	end
end

function slot0.getMessageUnread(slot0)
	if not slot0._messageUnreadDict then
		SocialMessageController.instance:readMessageUnread()
	end

	return slot0._messageUnreadDict
end

function slot0.getUnReadLastMsgTime(slot0, slot1)
	if not slot0._messageUnreadDict then
		slot0._messageUnreadDict = slot0:getMessageUnread()
	end

	slot0._messageUnreadDict[SocialEnum.ChannelType.Friend] = slot0._messageUnreadDict[SocialEnum.ChannelType.Friend] or {}

	if not slot0._messageUnreadDict[SocialEnum.ChannelType.Friend][slot1] then
		return 0
	end

	return slot0._messageUnreadDict[SocialEnum.ChannelType.Friend][slot1].lastTime
end

function slot0.addMessageUnread(slot0, slot1, slot2, slot3, slot4)
	if not slot0._messageUnreadDict then
		slot0._messageUnreadDict = slot0:getMessageUnread()
	end

	slot0._messageUnreadDict[slot1] = slot0._messageUnreadDict[slot1] or {}
	slot0._messageUnreadDict[slot1][slot2] = slot0._messageUnreadDict[slot1][slot2] or {
		count = 0,
		lastTime = 0
	}
	slot0._messageUnreadDict[slot1][slot2].count = slot0._messageUnreadDict[slot1][slot2].count + slot3

	if slot4 and slot0._messageUnreadDict[slot1][slot2].lastTime < tonumber(slot4) then
		slot0._messageUnreadDict[slot1][slot2].lastTime = slot5
	end

	if slot3 ~= 0 then
		slot0:updateRedDotGroup()
	end

	slot0:saveMessageUnread()
end

function slot0.clearMessageUnread(slot0, slot1, slot2, slot3)
	if not slot0._messageUnreadDict then
		slot0._messageUnreadDict = slot0:getMessageUnread()
	end

	slot0._messageUnreadDict[slot1] = slot0._messageUnreadDict[slot1] or {}

	if slot3 then
		slot0._messageUnreadDict[slot1][slot2] = nil
	elseif slot0._messageUnreadDict[slot1][slot2] then
		slot0._messageUnreadDict[slot1][slot2].count = 0
		slot0._messageUnreadDict[slot1][slot2].lastTime = 0
	end

	slot0:updateRedDotGroup()
	slot0:saveMessageUnread()
end

function slot0.getFriendMessageUnread(slot0, slot1)
	if not slot0._messageUnreadDict then
		slot0._messageUnreadDict = slot0:getMessageUnread()
	end

	slot0._messageUnreadDict[SocialEnum.ChannelType.Friend] = slot0._messageUnreadDict[SocialEnum.ChannelType.Friend] or {}

	return slot0._messageUnreadDict[SocialEnum.ChannelType.Friend][slot1] and slot2.count or 0
end

function slot0.getMessageUnreadRedDotGroup(slot0)
	slot1 = {
		defineId = 1006
	}
	slot2 = {}

	for slot7, slot8 in pairs(SocialModel.instance:getFriendIdDict()) do
		table.insert(slot2, {
			id = tonumber(slot7),
			value = slot0:getFriendMessageUnread(slot7),
			time = 0,
			ext = ""
		})
	end

	if #slot2 <= 0 then
		table.insert(slot2, {
			id = 0,
			value = 0,
			time = 0
		})
	end

	slot1.infos = slot2
	slot1.replaceAll = true

	return slot1
end

function slot0.updateRedDotGroup(slot0)
	slot1 = {
		redDotInfos = slot2,
		replaceAll = false
	}

	table.insert({}, slot0:getMessageUnreadRedDotGroup())
	RedDotModel.instance:updateRedDotInfo(slot1.redDotInfos)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateFriendInfoDot, slot1.redDotInfos)
end

function slot0.addSocialMessage(slot0, slot1)
	slot3 = 0
	slot4 = false

	if slot1.channelType == SocialEnum.ChannelType.Friend then
		if PlayerModel.instance:getMyUserId() == slot1.senderId then
			slot3 = slot1.recipientId
			slot4 = true
		else
			slot3 = slot1.senderId
		end
	end

	if not slot0._socialMessageMOListDict[slot2][slot3] then
		slot0._socialMessageMOListDict[slot2][slot3] = slot0:getSocialMessageMOList(slot2, slot3)
	end

	for slot9, slot10 in ipairs(slot0._socialMessageMOListDict[slot2][slot3]) do
		if slot10.msgId == slot1.msgId then
			return
		end
	end

	slot6 = SocialMessageMO.New()

	slot6:init(slot1)
	table.insert(slot5, slot6)
	slot0:saveSocialMessages(slot2, slot3)

	if slot4 then
		slot0:addMessageUnread(slot2, slot3, 0)
	else
		slot0:addMessageUnread(slot2, slot3, 1, slot1.sendTime)
	end

	SocialController.instance:dispatchEvent(SocialEvent.MessageInfoChanged)
end

function slot0.deleteSocialMessage(slot0, slot1, slot2)
	slot0._socialMessageMOListDict[slot1][slot2] = {}

	slot0:saveSocialMessages(slot1, slot2)
	slot0:clearMessageUnread(slot1, slot2, true)
	SocialController.instance:dispatchEvent(SocialEvent.MessageInfoChanged)
end

function slot0.ensureDeleteSocialMessage(slot0)
	if not slot0:getMessageUnread()[SocialEnum.ChannelType.Friend] then
		return
	end

	for slot6, slot7 in pairs(slot2) do
		if not SocialModel.instance:isMyFriendByUserId(slot6) then
			slot0:deleteSocialMessage(SocialEnum.ChannelType.Friend, slot6)
		end
	end
end

slot0.instance = slot0.New()

return slot0
