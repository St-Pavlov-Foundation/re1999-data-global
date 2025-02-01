module("modules.logic.social.model.SocialPlayerMO", package.seeall)

slot0 = pureTable("SocialPlayerMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.userId
	slot0.userId = slot1.userId
	slot0.name = slot1.name
	slot0.level = slot1.level
	slot0.portrait = slot1.portrait
	slot0.time = slot1.time
	slot0.desc = slot1.desc
	slot0.infos = slot1.infos
	slot0.bg = slot1.bg or 0
end

function slot0.isSendAddFriend(slot0)
	return slot0._isAdded or false
end

function slot0.setAddedFriend(slot0)
	slot0._isAdded = true
end

function slot0.isMyFriend(slot0)
	return SocialModel.instance:isMyFriendByUserId(slot0.userId)
end

function slot0.isMyBlackList(slot0)
	return SocialModel.instance:isMyBlackListByUserId(slot0.userId)
end

return slot0
