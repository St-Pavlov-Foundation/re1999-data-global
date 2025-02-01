module("modules.logic.social.rpc.FriendRpc", package.seeall)

slot0 = class("FriendRpc", BaseRpc)

function slot0.sendGetFriendInfoListRequest(slot0)
	return slot0:sendMsg(FriendModule_pb.GetFriendInfoListRequest())
end

function slot0.onReceiveGetFriendInfoListReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance:updateFriendList(slot2.info)
		SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
	end
end

function slot0.sendRemoveFriendRequest(slot0, slot1)
	slot2 = FriendModule_pb.RemoveFriendRequest()
	slot2.friendId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveRemoveFriendReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance:removeFriendByUserId(slot2.friendId)
		SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
	end
end

function slot0.changeDesc(slot0, slot1, slot2)
	slot3 = FriendModule_pb.FriendDescChangeRequest()
	slot3.friendId = slot1
	slot3.desc = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveFriendDescChangeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if not SocialModel.instance:getPlayerMO(slot2.friendId) then
			return
		end

		GameFacade.showToast(ToastEnum.FriendDescChange)

		slot3.desc = slot2.desc

		SocialController.instance:dispatchEvent(SocialEvent.FriendDescChange, slot2.friendId)
	end
end

function slot0.onReceiveFriendChangePush(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.isAdd then
			slot3 = {}

			table.insert(slot3, slot2.friendId)
			SocialModel.instance:addFriendsByUserIds(slot3)
			SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
			SocialController.instance:dispatchEvent(SocialEvent.AddUnknownFriend)
		else
			SocialModel.instance:removeFriendByUserId(slot2.friendId)
			SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
		end
	end
end

function slot0.sendGetApplyListRequest(slot0)
	return slot0:sendMsg(FriendModule_pb.GetApplyListRequest())
end

function slot0.onReceiveGetApplyListReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance:updateRequestList(slot2.info)
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
	end
end

function slot0.sendGetRecommendRequest(slot0, slot1, slot2)
	return slot0:sendMsg(FriendModule_pb.GetRecommendedFriendsRequest(), slot1, slot2)
end

function slot0.onReceiveGetRecommendedFriendsReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance.playSearchItemAnimDt = UnityEngine.Time.realtimeSinceStartup
		SocialModel.instance.leftSendRecommendReqDt = UnityEngine.Time.realtimeSinceStartup

		SocialModel.instance:updateRecommendList(slot2.info)
		SocialController.instance:dispatchEvent(SocialEvent.RecommendChanged)
	end
end

function slot0.sendHandleApplyRequest(slot0, slot1, slot2)
	slot3 = FriendModule_pb.HandleApplyRequest()
	slot3.friendId = slot1
	slot3.isAgree = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveHandleApplyReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.friendId and slot2.friendId ~= 0 and slot2.friendId ~= "0" and not string.nilorempty(slot2.friendId) then
			SocialModel.instance:removeRequestByUserId(slot2.friendId)
			SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
		end

		if not string.nilorempty(slot2.messsage) then
			GameFacade.showToast(ToastEnum.IconId, slot2.messsage)
		end
	end
end

function slot0.sendAgreeAllRequest(slot0)
	return slot0:sendMsg(FriendModule_pb.AgreeAllRequest())
end

function slot0.onReceiveAgreeAllReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance:updateRequestList(slot2.applyList)
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)

		if slot2.resultCode and #slot2.resultCode > 0 and slot2.resultCode[1] < 0 then
			if not lua_toast.configDict[slot3] then
				logError("FriendRpc:onReceiveAgreeAllReply 没有为业务错误码：" .. slot3 .. " 配置提示语！！《P飘字表》- export_飘字表")

				return
			end

			GameFacade.showToast(slot3)
		end
	end
end

function slot0.sendRejectAllRequest(slot0)
	return slot0:sendMsg(FriendModule_pb.RejectAllRequest())
end

function slot0.onReceiveRejectAllReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance:clearRequestList()
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
	end
end

function slot0.sendApplyRequest(slot0, slot1, slot2, slot3)
	slot4 = FriendModule_pb.ApplyRequest()
	slot4.friendId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveApplyReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if not string.nilorempty(slot2.messsage) then
			GameFacade.showToast(ToastEnum.IconId, slot2.messsage)
		end

		if slot2.friendId and slot2.friendId ~= 0 and slot2.friendId ~= "0" and not string.nilorempty(slot2.friendId) then
			GameFacade.showToast(ToastEnum.OnReceiveApplyFriend)
			SocialModel.instance:removeBlackListByUserId(slot2.friendId)
			SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
		end
	end
end

function slot0.sendSearchRequest(slot0, slot1, slot2, slot3)
	slot4 = FriendModule_pb.SearchRequest()
	slot4.value = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveSearchReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance.playSearchItemAnimDt = UnityEngine.Time.realtimeSinceStartup

		SocialModel.instance:updateSearchList(slot2.info)
		SocialController.instance:dispatchEvent(SocialEvent.SearchInfoChanged)
	end
end

function slot0.sendGetBlacklistRequest(slot0)
	return slot0:sendMsg(FriendModule_pb.GetBlacklistRequest())
end

function slot0.onReceiveGetBlacklistReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance:updateBlackList(slot2.info)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
	end
end

function slot0.sendAddBlacklistRequest(slot0, slot1)
	slot2 = FriendModule_pb.AddBlacklistRequest()
	slot2.friendId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveAddBlacklistReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance:addBlackListByUserId(slot2.friendId)
		SocialModel.instance:removeRequestByUserId(slot2.friendId)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
		SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
	end
end

function slot0.sendRemoveBlacklistRequest(slot0, slot1)
	slot2 = FriendModule_pb.RemoveBlacklistRequest()
	slot2.friendId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveRemoveBlacklistReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance:removeBlackListByUserId(slot2.friendId)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
	end
end

function slot0.onReceiveBlacklistChangePush(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.change > 0 then
			SocialModel.instance:addBlackListByUserId(slot2.userId)
			SocialModel.instance:removeRequestByUserId(slot2.userId)
			SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
			SocialController.instance:dispatchEvent(SocialEvent.AddUnknownBlackList)
			SocialController.instance:dispatchEvent(SocialEvent.RequestInfoChanged)
		elseif slot2.change < 0 then
			SocialModel.instance:removeBlackListByUserId(slot2.userId)
			SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
		end
	end
end

function slot0.sendLoadFriendInfosRequest(slot0, slot1, slot2)
	return slot0:sendMsg(FriendModule_pb.LoadFriendInfosRequest(), slot1, slot2)
end

function slot0.onReceiveLoadFriendInfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		SocialModel.instance:updateSocialInfosList(slot2.friendIds, slot2.blackListIds)
		SocialController.instance:dispatchEvent(SocialEvent.FriendsInfoChanged)
		SocialController.instance:dispatchEvent(SocialEvent.BlackListInfoChanged)
	end
end

slot0.instance = slot0.New()

return slot0
