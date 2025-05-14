module("modules.logic.social.rpc.FriendRpc", package.seeall)

local var_0_0 = class("FriendRpc", BaseRpc)

function var_0_0.sendGetFriendInfoListRequest(arg_1_0)
	local var_1_0 = FriendModule_pb.GetFriendInfoListRequest()

	return arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetFriendInfoListReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		SocialModel.instance:updateFriendList(arg_2_2.info)
		SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
	end
end

function var_0_0.sendRemoveFriendRequest(arg_3_0, arg_3_1)
	local var_3_0 = FriendModule_pb.RemoveFriendRequest()

	var_3_0.friendId = arg_3_1

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveRemoveFriendReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		SocialModel.instance:removeFriendByUserId(arg_4_2.friendId)
		SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
	end
end

function var_0_0.changeDesc(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = FriendModule_pb.FriendDescChangeRequest()

	var_5_0.friendId = arg_5_1
	var_5_0.desc = arg_5_2

	return arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveFriendDescChangeReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		local var_6_0 = SocialModel.instance:getPlayerMO(arg_6_2.friendId)

		if not var_6_0 then
			return
		end

		GameFacade.showToast(ToastEnum.FriendDescChange)

		var_6_0.desc = arg_6_2.desc

		SocialController.instance:dispatchEvent(SocialEvent.FriendDescChange, arg_6_2.friendId)
	end
end

function var_0_0.onReceiveFriendChangePush(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		if arg_7_2.isAdd then
			local var_7_0 = {}

			table.insert(var_7_0, arg_7_2.friendId)
			SocialModel.instance:addFriendsByUserIds(var_7_0)
			SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
			SocialController.instance:dispatchEvent(SocialEvent.AddUnknownFriend)
		else
			SocialModel.instance:removeFriendByUserId(arg_7_2.friendId)
			SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
		end
	end
end

function var_0_0.sendGetApplyListRequest(arg_8_0)
	local var_8_0 = FriendModule_pb.GetApplyListRequest()

	return arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveGetApplyListReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		SocialModel.instance:updateRequestList(arg_9_2.info)
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
	end
end

function var_0_0.sendGetRecommendRequest(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = FriendModule_pb.GetRecommendedFriendsRequest()

	return arg_10_0:sendMsg(var_10_0, arg_10_1, arg_10_2)
end

function var_0_0.onReceiveGetRecommendedFriendsReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		SocialModel.instance.playSearchItemAnimDt = UnityEngine.Time.realtimeSinceStartup
		SocialModel.instance.leftSendRecommendReqDt = UnityEngine.Time.realtimeSinceStartup

		SocialModel.instance:updateRecommendList(arg_11_2.info)
		SocialController.instance:dispatchEvent(SocialEvent.RecommendChanged)
	end
end

function var_0_0.sendHandleApplyRequest(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = FriendModule_pb.HandleApplyRequest()

	var_12_0.friendId = arg_12_1
	var_12_0.isAgree = arg_12_2

	return arg_12_0:sendMsg(var_12_0)
end

function var_0_0.onReceiveHandleApplyReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		if arg_13_2.friendId and arg_13_2.friendId ~= 0 and arg_13_2.friendId ~= "0" and not string.nilorempty(arg_13_2.friendId) then
			SocialModel.instance:removeRequestByUserId(arg_13_2.friendId)
			SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
		end

		if not string.nilorempty(arg_13_2.messsage) then
			GameFacade.showToast(ToastEnum.IconId, arg_13_2.messsage)
		end
	end
end

function var_0_0.sendAgreeAllRequest(arg_14_0)
	local var_14_0 = FriendModule_pb.AgreeAllRequest()

	return arg_14_0:sendMsg(var_14_0)
end

function var_0_0.onReceiveAgreeAllReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		SocialModel.instance:updateRequestList(arg_15_2.applyList)
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)

		if arg_15_2.resultCode and #arg_15_2.resultCode > 0 then
			local var_15_0 = arg_15_2.resultCode[1]

			if var_15_0 < 0 then
				if not lua_toast.configDict[var_15_0] then
					logError("FriendRpc:onReceiveAgreeAllReply 没有为业务错误码：" .. var_15_0 .. " 配置提示语！！《P飘字表》- export_飘字表")

					return
				end

				GameFacade.showToast(var_15_0)
			end
		end
	end
end

function var_0_0.sendRejectAllRequest(arg_16_0)
	local var_16_0 = FriendModule_pb.RejectAllRequest()

	return arg_16_0:sendMsg(var_16_0)
end

function var_0_0.onReceiveRejectAllReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		SocialModel.instance:clearRequestList()
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
	end
end

function var_0_0.sendApplyRequest(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = FriendModule_pb.ApplyRequest()

	var_18_0.friendId = arg_18_1

	return arg_18_0:sendMsg(var_18_0, arg_18_2, arg_18_3)
end

function var_0_0.onReceiveApplyReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == 0 then
		if not string.nilorempty(arg_19_2.messsage) then
			GameFacade.showToast(ToastEnum.IconId, arg_19_2.messsage)
		end

		if arg_19_2.friendId and arg_19_2.friendId ~= 0 and arg_19_2.friendId ~= "0" and not string.nilorempty(arg_19_2.friendId) then
			GameFacade.showToast(ToastEnum.OnReceiveApplyFriend)
			SocialModel.instance:removeBlackListByUserId(arg_19_2.friendId)
			SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
		end
	end
end

function var_0_0.sendSearchRequest(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = FriendModule_pb.SearchRequest()

	var_20_0.value = arg_20_1

	return arg_20_0:sendMsg(var_20_0, arg_20_2, arg_20_3)
end

function var_0_0.onReceiveSearchReply(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == 0 then
		SocialModel.instance.playSearchItemAnimDt = UnityEngine.Time.realtimeSinceStartup

		SocialModel.instance:updateSearchList(arg_21_2.info)
		SocialController.instance:dispatchEvent(SocialEvent.SearchInfoChanged)
	end
end

function var_0_0.sendGetBlacklistRequest(arg_22_0)
	local var_22_0 = FriendModule_pb.GetBlacklistRequest()

	return arg_22_0:sendMsg(var_22_0)
end

function var_0_0.onReceiveGetBlacklistReply(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == 0 then
		SocialModel.instance:updateBlackList(arg_23_2.info)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
	end
end

function var_0_0.sendAddBlacklistRequest(arg_24_0, arg_24_1)
	local var_24_0 = FriendModule_pb.AddBlacklistRequest()

	var_24_0.friendId = arg_24_1

	return arg_24_0:sendMsg(var_24_0)
end

function var_0_0.onReceiveAddBlacklistReply(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 == 0 then
		SocialModel.instance:addBlackListByUserId(arg_25_2.friendId)
		SocialModel.instance:removeRequestByUserId(arg_25_2.friendId)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
	end
end

function var_0_0.sendRemoveBlacklistRequest(arg_26_0, arg_26_1)
	local var_26_0 = FriendModule_pb.RemoveBlacklistRequest()

	var_26_0.friendId = arg_26_1

	return arg_26_0:sendMsg(var_26_0)
end

function var_0_0.onReceiveRemoveBlacklistReply(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == 0 then
		SocialModel.instance:removeBlackListByUserId(arg_27_2.friendId)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
	end
end

function var_0_0.onReceiveBlacklistChangePush(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 == 0 then
		if arg_28_2.change > 0 then
			SocialModel.instance:addBlackListByUserId(arg_28_2.userId)
			SocialModel.instance:removeRequestByUserId(arg_28_2.userId)
			SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
			SocialController.instance:dispatchEvent(SocialEvent.AddUnknownBlackList)
			SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
		elseif arg_28_2.change < 0 then
			SocialModel.instance:removeBlackListByUserId(arg_28_2.userId)
			SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
		end
	end
end

function var_0_0.sendLoadFriendInfosRequest(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = FriendModule_pb.LoadFriendInfosRequest()

	return arg_29_0:sendMsg(var_29_0, arg_29_1, arg_29_2)
end

function var_0_0.onReceiveLoadFriendInfosReply(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 == 0 then
		SocialModel.instance:updateSocialInfosList(arg_30_2.friendIds, arg_30_2.blackListIds)
		SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
