module("modules.logic.social.model.SocialModel", package.seeall)

local var_0_0 = class("SocialModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._friendsMODict = {}
	arg_1_0._blackListMODict = {}
	arg_1_0._requestMODict = {}
	arg_1_0._searchMODict = {}
	arg_1_0._recommendMODict = {}
	arg_1_0._friendUserIdDict = {}
	arg_1_0._blackListUserIdDict = {}
	arg_1_0._tempMODict = {}
	arg_1_0._playerSelfMO = nil
	arg_1_0._selectFriend = nil
	arg_1_0.playSearchItemAnimDt = 0
	arg_1_0.leftSendRecommendReqDt = 0
end

function var_0_0.reInit(arg_2_0)
	SocialListModel.instance:reInit()

	arg_2_0._friendsMODict = {}
	arg_2_0._blackListMODict = {}
	arg_2_0._requestMODict = {}
	arg_2_0._searchMODict = {}
	arg_2_0._recommendMODict = {}
	arg_2_0._friendUserIdDict = {}
	arg_2_0._blackListUserIdDict = {}
	arg_2_0._tempMODict = {}
	arg_2_0._playerSelfMO = nil
	arg_2_0._selectFriend = nil
end

function var_0_0.getFriendIdDict(arg_3_0)
	return arg_3_0._friendUserIdDict
end

function var_0_0.updateSocialInfosList(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._friendUserIdDict = {}
	arg_4_0._blackListUserIdDict = {}

	if arg_4_1 and #arg_4_1 > 0 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			arg_4_0._friendUserIdDict[iter_4_1] = true
		end
	end

	if arg_4_2 and #arg_4_2 > 0 then
		for iter_4_2, iter_4_3 in ipairs(arg_4_2) do
			arg_4_0._blackListUserIdDict[iter_4_3] = true
		end
	end

	SocialMessageModel.instance:ensureDeleteSocialMessage()
end

function var_0_0.updateFriendList(arg_5_0, arg_5_1)
	arg_5_0._friendsMODict = {}
	arg_5_0._friendUserIdDict = {}

	if arg_5_1 and #arg_5_1 > 0 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			local var_5_0 = SocialPlayerMO.New()

			var_5_0:init(iter_5_1)

			arg_5_0._friendsMODict[var_5_0.userId] = var_5_0
			arg_5_0._friendUserIdDict[var_5_0.userId] = true

			arg_5_0:_addTempMO(var_5_0)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Friend, arg_5_0._friendsMODict)
end

function var_0_0.updateBlackList(arg_6_0, arg_6_1)
	arg_6_0._blackListMODict = {}
	arg_6_0._blackListUserIdDict = {}

	if arg_6_1 and #arg_6_1 > 0 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			local var_6_0 = SocialPlayerMO.New()

			var_6_0:init(iter_6_1)

			arg_6_0._blackListMODict[var_6_0.userId] = var_6_0
			arg_6_0._blackListUserIdDict[var_6_0.userId] = true

			arg_6_0:_addTempMO(var_6_0)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Black, arg_6_0._blackListMODict)
end

function var_0_0.updateRequestList(arg_7_0, arg_7_1)
	arg_7_0._requestMODict = {}

	if arg_7_1 and #arg_7_1 > 0 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			local var_7_0 = SocialPlayerMO.New()

			var_7_0:init(iter_7_1)

			arg_7_0._requestMODict[var_7_0.userId] = var_7_0

			arg_7_0:_addTempMO(var_7_0)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Request, arg_7_0._requestMODict)
end

function var_0_0.updateRecommendList(arg_8_0, arg_8_1)
	arg_8_0._recommendMODict = {}

	if arg_8_1 and #arg_8_1 > 0 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			local var_8_0 = SocialPlayerMO.New()

			var_8_0:init(iter_8_1)

			arg_8_0._recommendMODict[var_8_0.userId] = var_8_0

			arg_8_0:_addTempMO(var_8_0)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Recommend, arg_8_0._recommendMODict)
end

function var_0_0.updateSearchList(arg_9_0, arg_9_1)
	arg_9_0._searchMODict = {}

	if arg_9_1 and #arg_9_1 > 0 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			local var_9_0 = SocialPlayerMO.New()

			var_9_0:init(iter_9_1)

			arg_9_0._searchMODict[var_9_0.userId] = var_9_0

			arg_9_0:_addTempMO(var_9_0)
		end
	else
		GameFacade.showToast(ToastEnum.SocialNoSearch)
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Search, arg_9_0._searchMODict)
end

function var_0_0.addFriendsByUserIds(arg_10_0, arg_10_1)
	if arg_10_1 and #arg_10_1 > 0 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
			local var_10_0 = arg_10_0:getPlayerMO(iter_10_1)

			if var_10_0 and not arg_10_0._friendsMODict[var_10_0.userId] then
				arg_10_0._friendsMODict[var_10_0.userId] = var_10_0
			end

			arg_10_0._friendUserIdDict[iter_10_1] = true
		end

		SocialListModel.instance:setModelList(SocialEnum.Type.Friend, arg_10_0._friendsMODict)
	end
end

function var_0_0.addFriendsByUserInfos(arg_11_0, arg_11_1)
	if arg_11_1 and #arg_11_1 > 0 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			if not arg_11_0._friendsMODict[iter_11_1.userId] then
				local var_11_0 = SocialPlayerMO.New()

				var_11_0:init(iter_11_1)

				arg_11_0._friendsMODict[var_11_0.userId] = var_11_0

				arg_11_0:_addTempMO(var_11_0)
			else
				local var_11_1 = arg_11_0._friendsMODict[iter_11_1.userId]

				var_11_1:init(iter_11_1)
				arg_11_0:_addTempMO(var_11_1)
			end

			arg_11_0._friendUserIdDict[iter_11_1.userId] = true
		end

		SocialListModel.instance:setModelList(SocialEnum.Type.Friend, arg_11_0._friendsMODict)
	end
end

function var_0_0.removeFriendByUserId(arg_12_0, arg_12_1)
	SocialMessageModel.instance:deleteSocialMessage(SocialEnum.ChannelType.Friend, arg_12_1)

	arg_12_0._friendsMODict[arg_12_1] = nil
	arg_12_0._friendUserIdDict[arg_12_1] = nil

	SocialListModel.instance:setModelList(SocialEnum.Type.Friend, arg_12_0._friendsMODict)
end

function var_0_0.addBlackListByUserId(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getPlayerMO(arg_13_1)

	if var_13_0 and not arg_13_0._blackListMODict[var_13_0.userId] then
		arg_13_0._blackListMODict[var_13_0.userId] = var_13_0
	end

	arg_13_0._blackListUserIdDict[arg_13_1] = true

	SocialListModel.instance:setModelList(SocialEnum.Type.Black, arg_13_0._blackListMODict)
end

function var_0_0.removeBlackListByUserId(arg_14_0, arg_14_1)
	arg_14_0._blackListMODict[arg_14_1] = nil
	arg_14_0._blackListUserIdDict[arg_14_1] = nil

	SocialListModel.instance:setModelList(SocialEnum.Type.Black, arg_14_0._blackListMODict)
end

function var_0_0.clearRequestList(arg_15_0)
	arg_15_0._requestMODict = {}

	SocialListModel.instance:setModelList(SocialEnum.Type.Request, arg_15_0._requestMODict)
end

function var_0_0.removeRequestByUserId(arg_16_0, arg_16_1)
	arg_16_0._requestMODict[arg_16_1] = nil

	SocialListModel.instance:setModelList(SocialEnum.Type.Request, arg_16_0._requestMODict)
end

function var_0_0.clearSearchList(arg_17_0)
	arg_17_0._searchMODict = {}

	SocialListModel.instance:setModelList(SocialEnum.Type.Search, arg_17_0._searchMODict)
end

function var_0_0.clearRecommendList(arg_18_0)
	arg_18_0._recommendMODict = {}

	SocialListModel.instance:setModelList(SocialEnum.Type.Recommend, arg_18_0._recommendMODict)
end

function var_0_0.isMyFriendByUserId(arg_19_0, arg_19_1)
	return arg_19_0._friendUserIdDict[arg_19_1] or arg_19_0._friendsMODict[arg_19_1]
end

function var_0_0.isMyBlackListByUserId(arg_20_0, arg_20_1)
	return arg_20_0._blackListUserIdDict[arg_20_1] or arg_20_0._blackListMODict[arg_20_1]
end

function var_0_0._addTempMO(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	arg_21_0._tempMODict[arg_21_1.userId] = arg_21_1
end

function var_0_0.clearSelfPlayerMO(arg_22_0)
	arg_22_0._playerSelfMO = nil
end

function var_0_0.getPlayerMO(arg_23_0, arg_23_1)
	if PlayerModel.instance:getMyUserId() == arg_23_1 then
		if not arg_23_0._playerSelfMO then
			local var_23_0 = PlayerModel.instance:getPlayinfo()

			arg_23_0._playerSelfMO = SocialPlayerMO.New()

			local var_23_1 = {
				userId = var_23_0.userId,
				name = var_23_0.name,
				level = var_23_0.level,
				portrait = var_23_0.portrait
			}

			var_23_1.time = 0
			var_23_1.bg = var_23_0.bg

			arg_23_0._playerSelfMO:init(var_23_1)
		end

		return arg_23_0._playerSelfMO
	end

	return arg_23_0._friendsMODict[arg_23_1] or arg_23_0._searchMODict[arg_23_1] or arg_23_0._recommendMODict[arg_23_1] or arg_23_0._requestMODict[arg_23_1] or arg_23_0._blackListMODict[arg_23_1] or arg_23_0._tempMODict[arg_23_1]
end

function var_0_0.getFriendsCount(arg_24_0)
	return tabletool.len(arg_24_0._friendUserIdDict)
end

function var_0_0.getRequestCount(arg_25_0)
	return tabletool.len(arg_25_0._requestMODict)
end

function var_0_0.getBlackListCount(arg_26_0)
	return tabletool.len(arg_26_0._blackListUserIdDict)
end

function var_0_0.getSearchCount(arg_27_0)
	return tabletool.len(arg_27_0._searchMODict)
end

function var_0_0.getRecommendCount(arg_28_0)
	return tabletool.len(arg_28_0._recommendMODict)
end

function var_0_0.setSelectFriend(arg_29_0, arg_29_1)
	arg_29_0._selectFriend = arg_29_1

	SocialController.instance:dispatchEvent(SocialEvent.SelectFriend)
end

function var_0_0.getSelectFriend(arg_30_0)
	if arg_30_0:isMyFriendByUserId(arg_30_0._selectFriend) then
		return arg_30_0._selectFriend
	else
		return nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
