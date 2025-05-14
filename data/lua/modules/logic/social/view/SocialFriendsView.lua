module("modules.logic.social.view.SocialFriendsView", package.seeall)

local var_0_0 = class("SocialFriendsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "#go_has")
	arg_1_0._gono = gohelper.findChild(arg_1_0.viewGO, "#go_no")
	arg_1_0._simagecharbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_has/right/#simage_chartbg")
	arg_1_0._goSkinbg = gohelper.findChild(arg_1_0.viewGO, "#go_has/right/#go_skinbg")
	arg_1_0._gomessage = gohelper.findChild(arg_1_0.viewGO, "#go_has/right/#go_message")
	arg_1_0._inputsend = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_has/right/#go_message/send/#input_send")
	arg_1_0._scrollmessage = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_has/right/#go_message/#scroll_message")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_has/right/#go_message/#scroll_message/viewport/#go_content")
	arg_1_0._btnsend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_has/right/#go_message/send/#btn_send")
	arg_1_0._txtcd = gohelper.findChildText(arg_1_0.viewGO, "#go_has/right/#go_message/send/#btn_send/#txt_cd")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_has/right/#txt_name")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsend:AddClickListener(arg_2_0._btnsendOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsend:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._friendChatCD = nil
	arg_4_0._txtcd.text = luaLang("social_chat_send")

	arg_4_0._simagecharbg:LoadImage(ResUrl.getSocialIcon("img_chat_bg.png"))
	arg_4_0:_loadBg()
end

function var_0_0._loadBg(arg_5_0)
	local var_5_0 = PlayerCardModel.instance:getPlayerCardSkinId()

	if var_5_0 and var_5_0 ~= 0 then
		arg_5_0._hasSkin = true
		arg_5_0._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", var_5_0)
		arg_5_0._loader = MultiAbLoader.New()

		arg_5_0._loader:addPath(arg_5_0._skinPath)
		arg_5_0._loader:startLoad(arg_5_0._onLoadFinish, arg_5_0)
	else
		arg_5_0._hasSkin = false
	end

	gohelper.setActive(arg_5_0._goSkinbg, arg_5_0._hasSkin)
	gohelper.setActive(arg_5_0._simagecharbg.gameObject, not arg_5_0._hasSkin)
end

function var_0_0._onLoadFinish(arg_6_0)
	local var_6_0 = arg_6_0._loader:getAssetItem(arg_6_0._skinPath):GetResource(arg_6_0._skinPath)

	arg_6_0._goskinEffect = gohelper.clone(var_6_0, arg_6_0._goSkinbg)
end

function var_0_0._btnsendOnClick(arg_7_0)
	if arg_7_0._friendChatCD then
		GameFacade.showToast(ToastEnum.SocialFriends1)

		return
	end

	local var_7_0 = arg_7_0._inputsend:GetText()

	if string.nilorempty(var_7_0) then
		GameFacade.showToast(ToastEnum.SocialFriends2)

		return
	end

	local var_7_1 = string.gsub(var_7_0, " ", "")

	if string.nilorempty(var_7_1) then
		GameFacade.showToast(ToastEnum.SocialFriends2)
		arg_7_0._inputsend:SetText("")

		return
	end

	arg_7_0._friendChatCD = SocialEnum.FriendChatCD
	arg_7_0._txtcd.text = string.format("%ds", math.ceil(arg_7_0._friendChatCD))
	arg_7_0._tweenId = ZProj.TweenHelper.DOTweenFloat(SocialEnum.FriendChatCD, 0, SocialEnum.FriendChatCD, arg_7_0._onTimeUpdate, arg_7_0._onTimeEnd, arg_7_0, nil, EaseType.Linear)
	arg_7_0._scrollmessage.verticalNormalizedPosition = 0

	local var_7_2 = 0
	local var_7_3 = ""

	if arg_7_0._preSendInfo and arg_7_0._preSendInfo.recipientId == arg_7_0._selectFriend then
		var_7_2 = arg_7_0._preSendInfo.msgType
		var_7_3 = arg_7_0._preSendInfo.extData

		arg_7_0:_clearPreSendInfo()
	end

	ChatRpc.instance:sendSendMsgRequest(SocialEnum.ChannelType.Friend, arg_7_0._selectFriend, var_7_0, var_7_2, var_7_3, arg_7_0._onSendMsgReply, arg_7_0)
end

function var_0_0._onSendMsgReply(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 == 0 then
		arg_8_0._inputsend:SetText("")

		local var_8_0 = arg_8_0._preSendInfo

		if var_8_0 and arg_8_3.recipientId == var_8_0.recipientId and arg_8_3.msgType == arg_8_3.msgType then
			arg_8_0:_clearPreSendInfo()
		end
	end
end

function var_0_0._clearPreSendInfo(arg_9_0)
	arg_9_0._preSendInfo = nil

	if arg_9_0.viewParam and arg_9_0.viewParam.preSendInfo then
		arg_9_0.viewParam.preSendInfo = nil
	end
end

function var_0_0._onTimeUpdate(arg_10_0, arg_10_1)
	arg_10_0._friendChatCD = arg_10_1
	arg_10_0._txtcd.text = string.format("%ds", math.ceil(arg_10_0._friendChatCD))
end

function var_0_0._onTimeEnd(arg_11_0)
	arg_11_0._friendChatCD = nil
	arg_11_0._txtcd.text = luaLang("social_chat_send")
	arg_11_0._tweenId = nil
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, arg_12_0._refreshUI, arg_12_0)
	arg_12_0:addEventCb(SocialController.instance, SocialEvent.SelectFriend, arg_12_0._refreshMessageView, arg_12_0)
	arg_12_0:addEventCb(SocialController.instance, SocialEvent.MessageInfoChanged, arg_12_0._refreshMessageView, arg_12_0)
	arg_12_0:addEventCb(SocialController.instance, SocialEvent.AddUnknownFriend, arg_12_0._onAddUnknownFriend, arg_12_0)
	arg_12_0:addEventCb(SocialController.instance, SocialEvent.FriendDescChange, arg_12_0._ondescChange, arg_12_0)
	SocialListModel.instance:sortFriendList()
	FriendRpc.instance:sendGetFriendInfoListRequest()

	if arg_12_0._notFirst then
		arg_12_0:_refreshUI()
	else
		arg_12_0:_refreshUI(true)
	end

	arg_12_0._notFirst = true
	arg_12_0._preSendInfo = nil

	if arg_12_0.viewParam and arg_12_0.viewParam.preSendInfo then
		arg_12_0._preSendInfo = arg_12_0.viewParam.preSendInfo

		arg_12_0._inputsend:SetText(arg_12_0._preSendInfo.content)
	end
end

function var_0_0._onAddUnknownFriend(arg_13_0)
	FriendRpc.instance:sendGetFriendInfoListRequest()
end

function var_0_0.onClose(arg_14_0)
	arg_14_0:removeEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, arg_14_0._refreshUI, arg_14_0)
	arg_14_0:removeEventCb(SocialController.instance, SocialEvent.SelectFriend, arg_14_0._refreshMessageView, arg_14_0)
	arg_14_0:removeEventCb(SocialController.instance, SocialEvent.MessageInfoChanged, arg_14_0._refreshMessageView, arg_14_0)
	arg_14_0:removeEventCb(SocialController.instance, SocialEvent.AddUnknownFriend, arg_14_0._onAddUnknownFriend, arg_14_0)
	arg_14_0:removeEventCb(SocialController.instance, SocialEvent.FriendDescChange, arg_14_0._ondescChange, arg_14_0)
end

function var_0_0._refreshUI(arg_15_0, arg_15_1)
	local var_15_0 = SocialModel.instance:getFriendsCount()

	if not arg_15_1 then
		gohelper.setActive(arg_15_0._gohas, var_15_0 > 0)
		gohelper.setActive(arg_15_0._gono, var_15_0 <= 0)
	else
		gohelper.setActive(arg_15_0._gohas, var_15_0 > 0)
		gohelper.setActive(arg_15_0._gono, false)
	end

	if not SocialModel.instance:getSelectFriend() then
		local var_15_1 = SocialListModel.instance:getModel(SocialEnum.Type.Friend):getList()

		if var_15_1 and #var_15_1 > 0 then
			local var_15_2 = var_15_1[1]

			SocialModel.instance:setSelectFriend(var_15_2.userId)
		end
	end

	arg_15_0:_refreshMessageView()
end

function var_0_0._refreshMessageView(arg_16_0)
	local var_16_0 = SocialModel.instance:getSelectFriend()

	if not var_16_0 then
		gohelper.setActive(arg_16_0._gomessage, false)

		arg_16_0._txtname.text = ""
		arg_16_0._selectFriend = nil

		return
	end

	gohelper.setActive(arg_16_0._gomessage, true)
	SocialMessageModel.instance:clearMessageUnread(SocialEnum.ChannelType.Friend, var_16_0)

	local var_16_1 = recthelper.getHeight(arg_16_0._scrollmessage.transform) >= recthelper.getHeight(arg_16_0._gocontent.transform) or arg_16_0._scrollmessage.verticalNormalizedPosition <= 0.01 or arg_16_0._selectFriend ~= var_16_0

	if arg_16_0._selectFriend ~= var_16_0 then
		arg_16_0._inputsend:SetText("")

		if arg_16_0._preSendInfo and arg_16_0._preSendInfo.recipientId == arg_16_0._selectFriend then
			arg_16_0:_clearPreSendInfo()
		end
	end

	arg_16_0._selectFriend = var_16_0

	arg_16_0:_ondescChange()

	local var_16_2 = SocialMessageModel.instance:getSocialMessageMOList(SocialEnum.ChannelType.Friend, arg_16_0._selectFriend)

	SocialMessageListModel.instance:setMessageList(var_16_2)

	if var_16_1 then
		arg_16_0._scrollmessage.verticalNormalizedPosition = 0
	end
end

function var_0_0._ondescChange(arg_17_0, arg_17_1)
	if arg_17_1 and arg_17_1 ~= arg_17_0._selectFriend then
		return
	end

	local var_17_0 = SocialModel.instance:getPlayerMO(arg_17_0._selectFriend)

	if string.nilorempty(var_17_0.desc) then
		arg_17_0._txtname.text = tostring(var_17_0.name)
	else
		arg_17_0._txtname.text = var_17_0.desc
	end
end

function var_0_0.onUpdateParam(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	if arg_19_0._tweenId then
		ZProj.TweenHelper.KillById(arg_19_0._tweenId)
	end

	if arg_19_0._loader then
		arg_19_0._loader:dispose()

		arg_19_0._loader = nil
	end

	arg_19_0._simagecharbg:UnLoadImage()
end

return var_0_0
