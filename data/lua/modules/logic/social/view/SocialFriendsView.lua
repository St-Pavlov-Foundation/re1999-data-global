module("modules.logic.social.view.SocialFriendsView", package.seeall)

slot0 = class("SocialFriendsView", BaseView)

function slot0.onInitView(slot0)
	slot0._gohas = gohelper.findChild(slot0.viewGO, "#go_has")
	slot0._gono = gohelper.findChild(slot0.viewGO, "#go_no")
	slot0._simagecharbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_has/right/#simage_chartbg")
	slot0._goSkinbg = gohelper.findChild(slot0.viewGO, "#go_has/right/#go_skinbg")
	slot0._gomessage = gohelper.findChild(slot0.viewGO, "#go_has/right/#go_message")
	slot0._inputsend = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_has/right/#go_message/send/#input_send")
	slot0._scrollmessage = gohelper.findChildScrollRect(slot0.viewGO, "#go_has/right/#go_message/#scroll_message")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_has/right/#go_message/#scroll_message/viewport/#go_content")
	slot0._btnsend = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_has/right/#go_message/send/#btn_send")
	slot0._txtcd = gohelper.findChildText(slot0.viewGO, "#go_has/right/#go_message/send/#btn_send/#txt_cd")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_has/right/#txt_name")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsend:AddClickListener(slot0._btnsendOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsend:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._friendChatCD = nil
	slot0._txtcd.text = luaLang("social_chat_send")

	slot0._simagecharbg:LoadImage(ResUrl.getSocialIcon("img_chat_bg.png"))
	slot0:_loadBg()
end

function slot0._loadBg(slot0)
	if PlayerCardModel.instance:getPlayerCardSkinId() and slot1 ~= 0 then
		slot0._hasSkin = true
		slot0._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", slot1)
		slot0._loader = MultiAbLoader.New()

		slot0._loader:addPath(slot0._skinPath)
		slot0._loader:startLoad(slot0._onLoadFinish, slot0)
	else
		slot0._hasSkin = false
	end

	gohelper.setActive(slot0._goSkinbg, slot0._hasSkin)
	gohelper.setActive(slot0._simagecharbg.gameObject, not slot0._hasSkin)
end

function slot0._onLoadFinish(slot0)
	slot0._goskinEffect = gohelper.clone(slot0._loader:getAssetItem(slot0._skinPath):GetResource(slot0._skinPath), slot0._goSkinbg)
end

function slot0._btnsendOnClick(slot0)
	if slot0._friendChatCD then
		GameFacade.showToast(ToastEnum.SocialFriends1)

		return
	end

	if string.nilorempty(slot0._inputsend:GetText()) then
		GameFacade.showToast(ToastEnum.SocialFriends2)

		return
	end

	if string.nilorempty(string.gsub(slot1, " ", "")) then
		GameFacade.showToast(ToastEnum.SocialFriends2)
		slot0._inputsend:SetText("")

		return
	end

	slot0._friendChatCD = SocialEnum.FriendChatCD
	slot0._txtcd.text = string.format("%ds", math.ceil(slot0._friendChatCD))
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(SocialEnum.FriendChatCD, 0, SocialEnum.FriendChatCD, slot0._onTimeUpdate, slot0._onTimeEnd, slot0, nil, EaseType.Linear)
	slot0._scrollmessage.verticalNormalizedPosition = 0
	slot3 = 0
	slot4 = ""

	if slot0._preSendInfo and slot0._preSendInfo.recipientId == slot0._selectFriend then
		slot3 = slot0._preSendInfo.msgType
		slot4 = slot0._preSendInfo.extData

		slot0:_clearPreSendInfo()
	end

	ChatRpc.instance:sendSendMsgRequest(SocialEnum.ChannelType.Friend, slot0._selectFriend, slot1, slot3, slot4, slot0._onSendMsgReply, slot0)
end

function slot0._onSendMsgReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0._inputsend:SetText("")

		if slot0._preSendInfo and slot3.recipientId == slot4.recipientId and slot3.msgType == slot3.msgType then
			slot0:_clearPreSendInfo()
		end
	end
end

function slot0._clearPreSendInfo(slot0)
	slot0._preSendInfo = nil

	if slot0.viewParam and slot0.viewParam.preSendInfo then
		slot0.viewParam.preSendInfo = nil
	end
end

function slot0._onTimeUpdate(slot0, slot1)
	slot0._friendChatCD = slot1
	slot0._txtcd.text = string.format("%ds", math.ceil(slot0._friendChatCD))
end

function slot0._onTimeEnd(slot0)
	slot0._friendChatCD = nil
	slot0._txtcd.text = luaLang("social_chat_send")
	slot0._tweenId = nil
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, slot0._refreshUI, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.SelectFriend, slot0._refreshMessageView, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.MessageInfoChanged, slot0._refreshMessageView, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.AddUnknownFriend, slot0._onAddUnknownFriend, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.FriendDescChange, slot0._ondescChange, slot0)
	SocialListModel.instance:sortFriendList()
	FriendRpc.instance:sendGetFriendInfoListRequest()

	if slot0._notFirst then
		slot0:_refreshUI()
	else
		slot0:_refreshUI(true)
	end

	slot0._notFirst = true
	slot0._preSendInfo = nil

	if slot0.viewParam and slot0.viewParam.preSendInfo then
		slot0._preSendInfo = slot0.viewParam.preSendInfo

		slot0._inputsend:SetText(slot0._preSendInfo.content)
	end
end

function slot0._onAddUnknownFriend(slot0)
	FriendRpc.instance:sendGetFriendInfoListRequest()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, slot0._refreshUI, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.SelectFriend, slot0._refreshMessageView, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.MessageInfoChanged, slot0._refreshMessageView, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.AddUnknownFriend, slot0._onAddUnknownFriend, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.FriendDescChange, slot0._ondescChange, slot0)
end

function slot0._refreshUI(slot0, slot1)
	slot2 = SocialModel.instance:getFriendsCount()

	if not slot1 then
		gohelper.setActive(slot0._gohas, slot2 > 0)
		gohelper.setActive(slot0._gono, slot2 <= 0)
	else
		gohelper.setActive(slot0._gohas, slot2 > 0)
		gohelper.setActive(slot0._gono, false)
	end

	if not SocialModel.instance:getSelectFriend() and SocialListModel.instance:getModel(SocialEnum.Type.Friend):getList() and #slot4 > 0 then
		SocialModel.instance:setSelectFriend(slot4[1].userId)
	end

	slot0:_refreshMessageView()
end

function slot0._refreshMessageView(slot0)
	if not SocialModel.instance:getSelectFriend() then
		gohelper.setActive(slot0._gomessage, false)

		slot0._txtname.text = ""
		slot0._selectFriend = nil

		return
	end

	gohelper.setActive(slot0._gomessage, true)
	SocialMessageModel.instance:clearMessageUnread(SocialEnum.ChannelType.Friend, slot1)

	slot2 = recthelper.getHeight(slot0._gocontent.transform) <= recthelper.getHeight(slot0._scrollmessage.transform) or slot0._scrollmessage.verticalNormalizedPosition <= 0.01 or slot0._selectFriend ~= slot1

	if slot0._selectFriend ~= slot1 then
		slot0._inputsend:SetText("")

		if slot0._preSendInfo and slot0._preSendInfo.recipientId == slot0._selectFriend then
			slot0:_clearPreSendInfo()
		end
	end

	slot0._selectFriend = slot1

	slot0:_ondescChange()
	SocialMessageListModel.instance:setMessageList(SocialMessageModel.instance:getSocialMessageMOList(SocialEnum.ChannelType.Friend, slot0._selectFriend))

	if slot2 then
		slot0._scrollmessage.verticalNormalizedPosition = 0
	end
end

function slot0._ondescChange(slot0, slot1)
	if slot1 and slot1 ~= slot0._selectFriend then
		return
	end

	if string.nilorempty(SocialModel.instance:getPlayerMO(slot0._selectFriend).desc) then
		slot0._txtname.text = tostring(slot2.name)
	else
		slot0._txtname.text = slot2.desc
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0._simagecharbg:UnLoadImage()
end

return slot0
