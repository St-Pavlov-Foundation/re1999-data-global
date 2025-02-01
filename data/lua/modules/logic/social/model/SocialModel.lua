module("modules.logic.social.model.SocialModel", package.seeall)

slot0 = class("SocialModel", BaseModel)

function slot0.onInit(slot0)
	slot0._friendsMODict = {}
	slot0._blackListMODict = {}
	slot0._requestMODict = {}
	slot0._searchMODict = {}
	slot0._recommendMODict = {}
	slot0._friendUserIdDict = {}
	slot0._blackListUserIdDict = {}
	slot0._tempMODict = {}
	slot0._playerSelfMO = nil
	slot0._selectFriend = nil
	slot0.playSearchItemAnimDt = 0
	slot0.leftSendRecommendReqDt = 0
end

function slot0.reInit(slot0)
	SocialListModel.instance:reInit()

	slot0._friendsMODict = {}
	slot0._blackListMODict = {}
	slot0._requestMODict = {}
	slot0._searchMODict = {}
	slot0._recommendMODict = {}
	slot0._friendUserIdDict = {}
	slot0._blackListUserIdDict = {}
	slot0._tempMODict = {}
	slot0._playerSelfMO = nil
	slot0._selectFriend = nil
end

function slot0.getFriendIdDict(slot0)
	return slot0._friendUserIdDict
end

function slot0.updateSocialInfosList(slot0, slot1, slot2)
	slot0._friendUserIdDict = {}
	slot0._blackListUserIdDict = {}

	if slot1 and #slot1 > 0 then
		for slot6, slot7 in ipairs(slot1) do
			slot0._friendUserIdDict[slot7] = true
		end
	end

	if slot2 and #slot2 > 0 then
		for slot6, slot7 in ipairs(slot2) do
			slot0._blackListUserIdDict[slot7] = true
		end
	end

	SocialMessageModel.instance:ensureDeleteSocialMessage()
end

function slot0.updateFriendList(slot0, slot1)
	slot0._friendsMODict = {}
	slot0._friendUserIdDict = {}

	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = SocialPlayerMO.New()

			slot7:init(slot6)

			slot0._friendsMODict[slot7.userId] = slot7
			slot0._friendUserIdDict[slot7.userId] = true

			slot0:_addTempMO(slot7)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Friend, slot0._friendsMODict)
end

function slot0.updateBlackList(slot0, slot1)
	slot0._blackListMODict = {}
	slot0._blackListUserIdDict = {}

	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = SocialPlayerMO.New()

			slot7:init(slot6)

			slot0._blackListMODict[slot7.userId] = slot7
			slot0._blackListUserIdDict[slot7.userId] = true

			slot0:_addTempMO(slot7)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Black, slot0._blackListMODict)
end

function slot0.updateRequestList(slot0, slot1)
	slot0._requestMODict = {}

	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = SocialPlayerMO.New()

			slot7:init(slot6)

			slot0._requestMODict[slot7.userId] = slot7

			slot0:_addTempMO(slot7)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Request, slot0._requestMODict)
end

function slot0.updateRecommendList(slot0, slot1)
	slot0._recommendMODict = {}

	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = SocialPlayerMO.New()

			slot7:init(slot6)

			slot0._recommendMODict[slot7.userId] = slot7

			slot0:_addTempMO(slot7)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Recommend, slot0._recommendMODict)
end

function slot0.updateSearchList(slot0, slot1)
	slot0._searchMODict = {}

	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = SocialPlayerMO.New()

			slot7:init(slot6)

			slot0._searchMODict[slot7.userId] = slot7

			slot0:_addTempMO(slot7)
		end
	else
		GameFacade.showToast(ToastEnum.SocialNoSearch)
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Search, slot0._searchMODict)
end

function slot0.addFriendsByUserIds(slot0, slot1)
	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			if slot0:getPlayerMO(slot6) and not slot0._friendsMODict[slot7.userId] then
				slot0._friendsMODict[slot7.userId] = slot7
			end

			slot0._friendUserIdDict[slot6] = true
		end

		SocialListModel.instance:setModelList(SocialEnum.Type.Friend, slot0._friendsMODict)
	end
end

function slot0.addFriendsByUserInfos(slot0, slot1)
	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			if not slot0._friendsMODict[slot6.userId] then
				slot7 = SocialPlayerMO.New()

				slot7:init(slot6)

				slot0._friendsMODict[slot7.userId] = slot7

				slot0:_addTempMO(slot7)
			else
				slot7 = slot0._friendsMODict[slot6.userId]

				slot7:init(slot6)
				slot0:_addTempMO(slot7)
			end

			slot0._friendUserIdDict[slot6.userId] = true
		end

		SocialListModel.instance:setModelList(SocialEnum.Type.Friend, slot0._friendsMODict)
	end
end

function slot0.removeFriendByUserId(slot0, slot1)
	SocialMessageModel.instance:deleteSocialMessage(SocialEnum.ChannelType.Friend, slot1)

	slot0._friendsMODict[slot1] = nil
	slot0._friendUserIdDict[slot1] = nil

	SocialListModel.instance:setModelList(SocialEnum.Type.Friend, slot0._friendsMODict)
end

function slot0.addBlackListByUserId(slot0, slot1)
	if slot0:getPlayerMO(slot1) and not slot0._blackListMODict[slot2.userId] then
		slot0._blackListMODict[slot2.userId] = slot2
	end

	slot0._blackListUserIdDict[slot1] = true

	SocialListModel.instance:setModelList(SocialEnum.Type.Black, slot0._blackListMODict)
end

function slot0.removeBlackListByUserId(slot0, slot1)
	slot0._blackListMODict[slot1] = nil
	slot0._blackListUserIdDict[slot1] = nil

	SocialListModel.instance:setModelList(SocialEnum.Type.Black, slot0._blackListMODict)
end

function slot0.clearRequestList(slot0)
	slot0._requestMODict = {}

	SocialListModel.instance:setModelList(SocialEnum.Type.Request, slot0._requestMODict)
end

function slot0.removeRequestByUserId(slot0, slot1)
	slot0._requestMODict[slot1] = nil

	SocialListModel.instance:setModelList(SocialEnum.Type.Request, slot0._requestMODict)
end

function slot0.clearSearchList(slot0)
	slot0._searchMODict = {}

	SocialListModel.instance:setModelList(SocialEnum.Type.Search, slot0._searchMODict)
end

function slot0.clearRecommendList(slot0)
	slot0._recommendMODict = {}

	SocialListModel.instance:setModelList(SocialEnum.Type.Recommend, slot0._recommendMODict)
end

function slot0.isMyFriendByUserId(slot0, slot1)
	return slot0._friendUserIdDict[slot1] or slot0._friendsMODict[slot1]
end

function slot0.isMyBlackListByUserId(slot0, slot1)
	return slot0._blackListUserIdDict[slot1] or slot0._blackListMODict[slot1]
end

function slot0._addTempMO(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._tempMODict[slot1.userId] = slot1
end

function slot0.clearSelfPlayerMO(slot0)
	slot0._playerSelfMO = nil
end

function slot0.getPlayerMO(slot0, slot1)
	if PlayerModel.instance:getMyUserId() == slot1 then
		if not slot0._playerSelfMO then
			slot3 = PlayerModel.instance:getPlayinfo()
			slot0._playerSelfMO = SocialPlayerMO.New()

			slot0._playerSelfMO:init({
				userId = slot3.userId,
				name = slot3.name,
				level = slot3.level,
				portrait = slot3.portrait,
				time = 0,
				bg = slot3.bg
			})
		end

		return slot0._playerSelfMO
	end

	return slot0._friendsMODict[slot1] or slot0._searchMODict[slot1] or slot0._recommendMODict[slot1] or slot0._requestMODict[slot1] or slot0._blackListMODict[slot1] or slot0._tempMODict[slot1]
end

function slot0.getFriendsCount(slot0)
	return tabletool.len(slot0._friendUserIdDict)
end

function slot0.getRequestCount(slot0)
	return tabletool.len(slot0._requestMODict)
end

function slot0.getBlackListCount(slot0)
	return tabletool.len(slot0._blackListUserIdDict)
end

function slot0.getSearchCount(slot0)
	return tabletool.len(slot0._searchMODict)
end

function slot0.getRecommendCount(slot0)
	return tabletool.len(slot0._recommendMODict)
end

function slot0.setSelectFriend(slot0, slot1)
	slot0._selectFriend = slot1

	SocialController.instance:dispatchEvent(SocialEvent.SelectFriend)
end

function slot0.getSelectFriend(slot0)
	if slot0:isMyFriendByUserId(slot0._selectFriend) then
		return slot0._selectFriend
	else
		return nil
	end
end

slot0.instance = slot0.New()

return slot0
