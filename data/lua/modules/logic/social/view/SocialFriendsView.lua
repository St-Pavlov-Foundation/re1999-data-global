module("modules.logic.social.view.SocialFriendsView", package.seeall)

local var_0_0 = class("SocialFriendsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "#go_has")
	arg_1_0._gono = gohelper.findChild(arg_1_0.viewGO, "#go_no")
	arg_1_0._simagecharbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_has/right/#simage_chartbg")
	arg_1_0._goSkinbg = gohelper.findChild(arg_1_0.viewGO, "#go_has/right/#go_skinbg")
	arg_1_0._gomessage = gohelper.findChild(arg_1_0.viewGO, "#go_has/right/#go_message")
	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_has/right/#go_settingbackground/btn_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_has/right/#go_settingbackground/btn_click/selected")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.viewGO, "#go_has/right/#go_settingbackground/btn_click/unselect")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_has/right/#go_settingbackground/go_tips")
	arg_1_0._btnclosetips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_has/right/#go_settingbackground/go_tips/#btn_close")
	arg_1_0._inputsend = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_has/right/#go_message/send/#input_send")
	arg_1_0._scrollmessage = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_has/right/#go_message/#scroll_message")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_has/right/#go_message/#scroll_message/viewport/#go_content")
	arg_1_0._btnsend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_has/right/#go_message/send/#btn_send")
	arg_1_0._txtcd = gohelper.findChildText(arg_1_0.viewGO, "#go_has/right/#go_message/send/#btn_send/#txt_cd")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_has/right/#txt_name")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._isSelectBtn = false
	arg_1_0._isSelfBg = true
	arg_1_0._isopen = false
	arg_1_0._selectitemList = {}
	arg_1_0._currentselectbg = nil

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsend:AddClickListener(arg_2_0._btnsendOnClick, arg_2_0)
	arg_2_0._btnselect:AddClickListener(arg_2_0._btnselectOnClick, arg_2_0)
	arg_2_0._btnclosetips:AddClickListener(arg_2_0._btnclosetipsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsend:RemoveClickListener()
	arg_3_0._btnselect:RemoveClickListener()
	arg_3_0._btnclosetips:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._friendChatCD = nil
	arg_4_0._txtcd.text = luaLang("social_chat_send")

	arg_4_0._simagecharbg:LoadImage(ResUrl.getSocialIcon("img_chat_bg.png"))

	arg_4_0.skinkey = PlayerPrefsKey.SocialFriendsViewSelectOwnSkin .. tostring(PlayerModel.instance:getPlayinfo().userId)
	arg_4_0._isSelfBg = PlayerPrefsHelper.getNumber(arg_4_0.skinkey, SocialEnum.SelectEnum.Self) == SocialEnum.SelectEnum.Self

	arg_4_0:_refreshSelect()

	for iter_4_0 = 1, 2 do
		local var_4_0 = arg_4_0:getUserDataTb_()

		var_4_0.go = gohelper.findChild(arg_4_0.viewGO, "#go_has/right/#go_settingbackground/go_tips/bg/item" .. iter_4_0)
		var_4_0.btn = gohelper.findChildButton(var_4_0.go, "#btn_option")
		var_4_0.goselect = gohelper.findChild(var_4_0.go, "txt_option/selected")
		var_4_0.gounselect = gohelper.findChild(var_4_0.go, "txt_option/unselect")
		var_4_0.isSelf = iter_4_0 == SocialEnum.SelectEnum.Self

		var_4_0.btn:AddClickListener(arg_4_0.selectUseSkin, arg_4_0, var_4_0.isSelf)
		table.insert(arg_4_0._selectitemList, var_4_0)
		gohelper.setActive(var_4_0.goselect, var_4_0.isSelf == arg_4_0._isSelfBg)
		gohelper.setActive(var_4_0.gounselect, var_4_0.isSelf ~= arg_4_0._isSelfBg)
	end
end

function var_0_0._btnselectOnClick(arg_5_0)
	arg_5_0._isSelectBtn = not arg_5_0._isSelectBtn

	arg_5_0:_refreshSelect()
end

function var_0_0._btnclosetipsOnClick(arg_6_0)
	arg_6_0._isSelectBtn = false

	arg_6_0:_refreshSelect()
end

function var_0_0._refreshSelect(arg_7_0)
	gohelper.setActive(arg_7_0._goselect, arg_7_0._isSelectBtn)
	gohelper.setActive(arg_7_0._gounselect, not arg_7_0._isSelectBtn)
	gohelper.setActive(arg_7_0._gotips, arg_7_0._isSelectBtn)
end

function var_0_0._loadBg(arg_8_0)
	local var_8_0 = PlayerCardModel.instance:getPlayerCardSkinId()

	if not arg_8_0._isSelfBg then
		if not arg_8_0._selectFriend then
			return
		end

		var_8_0 = SocialModel.instance:getPlayerMO(arg_8_0._selectFriend).bg
	end

	if var_8_0 == arg_8_0._currentselectbg then
		return
	end

	if arg_8_0._goskinEffect then
		gohelper.destroy(arg_8_0._goskinEffect)

		arg_8_0._goskinEffect = nil
	end

	if var_8_0 and var_8_0 ~= 0 then
		arg_8_0._hasSkin = true
		arg_8_0._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", var_8_0)
		arg_8_0._loader = MultiAbLoader.New()

		arg_8_0._loader:addPath(arg_8_0._skinPath)
		arg_8_0._loader:startLoad(arg_8_0._onLoadFinish, arg_8_0)
	else
		arg_8_0._hasSkin = false
	end

	gohelper.setActive(arg_8_0._goSkinbg, arg_8_0._hasSkin)
	gohelper.setActive(arg_8_0._simagecharbg.gameObject, not arg_8_0._hasSkin)

	if arg_8_0._isopen and not arg_8_0._hasSkin then
		arg_8_0._animator.enabled = true

		arg_8_0._animator:Play("open", 0, 0)
	end

	arg_8_0._currentselectbg = var_8_0
end

function var_0_0._onLoadFinish(arg_9_0)
	local var_9_0 = arg_9_0._loader:getAssetItem(arg_9_0._skinPath):GetResource(arg_9_0._skinPath)

	arg_9_0._goskinEffect = gohelper.clone(var_9_0, arg_9_0._goSkinbg)
	arg_9_0._animator.enabled = true

	arg_9_0._animator:Play("open", 0, 0)
end

function var_0_0._btnsendOnClick(arg_10_0)
	if arg_10_0._friendChatCD then
		GameFacade.showToast(ToastEnum.SocialFriends1)

		return
	end

	local var_10_0 = arg_10_0._inputsend:GetText()

	if string.nilorempty(var_10_0) then
		GameFacade.showToast(ToastEnum.SocialFriends2)

		return
	end

	local var_10_1 = string.gsub(var_10_0, " ", "")

	if string.nilorempty(var_10_1) then
		GameFacade.showToast(ToastEnum.SocialFriends2)
		arg_10_0._inputsend:SetText("")

		return
	end

	arg_10_0._friendChatCD = SocialEnum.FriendChatCD
	arg_10_0._txtcd.text = string.format("%ds", math.ceil(arg_10_0._friendChatCD))
	arg_10_0._tweenId = ZProj.TweenHelper.DOTweenFloat(SocialEnum.FriendChatCD, 0, SocialEnum.FriendChatCD, arg_10_0._onTimeUpdate, arg_10_0._onTimeEnd, arg_10_0, nil, EaseType.Linear)
	arg_10_0._scrollmessage.verticalNormalizedPosition = 0

	local var_10_2 = 0
	local var_10_3 = ""

	if arg_10_0._preSendInfo and arg_10_0._preSendInfo.recipientId == arg_10_0._selectFriend then
		var_10_2 = arg_10_0._preSendInfo.msgType
		var_10_3 = arg_10_0._preSendInfo.extData

		arg_10_0:_clearPreSendInfo()
	end

	ChatRpc.instance:sendSendMsgRequest(SocialEnum.ChannelType.Friend, arg_10_0._selectFriend, var_10_0, var_10_2, var_10_3, arg_10_0._onSendMsgReply, arg_10_0)
end

function var_0_0._onSendMsgReply(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == 0 then
		arg_11_0._inputsend:SetText("")

		local var_11_0 = arg_11_0._preSendInfo

		if var_11_0 and arg_11_3.recipientId == var_11_0.recipientId and arg_11_3.msgType == arg_11_3.msgType then
			arg_11_0:_clearPreSendInfo()
		end
	end
end

function var_0_0._clearPreSendInfo(arg_12_0)
	arg_12_0._preSendInfo = nil

	if arg_12_0.viewParam and arg_12_0.viewParam.preSendInfo then
		arg_12_0.viewParam.preSendInfo = nil
	end
end

function var_0_0._onTimeUpdate(arg_13_0, arg_13_1)
	arg_13_0._friendChatCD = arg_13_1
	arg_13_0._txtcd.text = string.format("%ds", math.ceil(arg_13_0._friendChatCD))
end

function var_0_0._onTimeEnd(arg_14_0)
	arg_14_0._friendChatCD = nil
	arg_14_0._txtcd.text = luaLang("social_chat_send")
	arg_14_0._tweenId = nil
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:addEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, arg_15_0._refreshUI, arg_15_0)
	arg_15_0:addEventCb(SocialController.instance, SocialEvent.SelectFriend, arg_15_0._refreshMessageView, arg_15_0)
	arg_15_0:addEventCb(SocialController.instance, SocialEvent.MessageInfoChanged, arg_15_0._refreshMessageView, arg_15_0)
	arg_15_0:addEventCb(SocialController.instance, SocialEvent.AddUnknownFriend, arg_15_0._onAddUnknownFriend, arg_15_0)
	arg_15_0:addEventCb(SocialController.instance, SocialEvent.FriendDescChange, arg_15_0._ondescChange, arg_15_0)
	SocialListModel.instance:sortFriendList()
	FriendRpc.instance:sendGetFriendInfoListRequest()

	if arg_15_0._notFirst then
		arg_15_0:_refreshUI()
	else
		arg_15_0:_refreshUI(true)
	end

	arg_15_0._notFirst = true
	arg_15_0._preSendInfo = nil

	if arg_15_0.viewParam and arg_15_0.viewParam.preSendInfo then
		arg_15_0._preSendInfo = arg_15_0.viewParam.preSendInfo

		arg_15_0._inputsend:SetText(arg_15_0._preSendInfo.content)
	end

	arg_15_0:_loadBg()

	arg_15_0._isopen = true
end

function var_0_0.selectUseSkin(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0._isSelfBg = true

		PlayerPrefsHelper.setNumber(arg_16_0.skinkey, SocialEnum.SelectEnum.Self)
	else
		arg_16_0._isSelfBg = false

		PlayerPrefsHelper.setNumber(arg_16_0.skinkey, SocialEnum.SelectEnum.Friend)
	end

	arg_16_0:_loadBg()

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._selectitemList) do
		gohelper.setActive(iter_16_1.goselect, iter_16_1.isSelf == arg_16_0._isSelfBg)
		gohelper.setActive(iter_16_1.gounselect, iter_16_1.isSelf ~= arg_16_0._isSelfBg)
	end

	arg_16_0:_btnclosetipsOnClick()
end

function var_0_0._onAddUnknownFriend(arg_17_0)
	FriendRpc.instance:sendGetFriendInfoListRequest()
end

function var_0_0.onClose(arg_18_0)
	arg_18_0:removeEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, arg_18_0._refreshUI, arg_18_0)
	arg_18_0:removeEventCb(SocialController.instance, SocialEvent.SelectFriend, arg_18_0._refreshMessageView, arg_18_0)
	arg_18_0:removeEventCb(SocialController.instance, SocialEvent.MessageInfoChanged, arg_18_0._refreshMessageView, arg_18_0)
	arg_18_0:removeEventCb(SocialController.instance, SocialEvent.AddUnknownFriend, arg_18_0._onAddUnknownFriend, arg_18_0)
	arg_18_0:removeEventCb(SocialController.instance, SocialEvent.FriendDescChange, arg_18_0._ondescChange, arg_18_0)
end

function var_0_0._refreshUI(arg_19_0, arg_19_1)
	local var_19_0 = SocialModel.instance:getFriendsCount()

	if not arg_19_1 then
		gohelper.setActive(arg_19_0._gohas, var_19_0 > 0)
		gohelper.setActive(arg_19_0._gono, var_19_0 <= 0)
	else
		gohelper.setActive(arg_19_0._gohas, var_19_0 > 0)
		gohelper.setActive(arg_19_0._gono, false)
	end

	if not SocialModel.instance:getSelectFriend() then
		local var_19_1 = SocialListModel.instance:getModel(SocialEnum.Type.Friend):getList()

		if var_19_1 and #var_19_1 > 0 then
			local var_19_2 = var_19_1[1]

			SocialModel.instance:setSelectFriend(var_19_2.userId)
		end
	end

	arg_19_0:_refreshMessageView()
end

function var_0_0._refreshMessageView(arg_20_0)
	local var_20_0 = SocialModel.instance:getSelectFriend()

	if not var_20_0 then
		gohelper.setActive(arg_20_0._gomessage, false)

		arg_20_0._txtname.text = ""
		arg_20_0._selectFriend = nil

		return
	end

	gohelper.setActive(arg_20_0._gomessage, true)
	SocialMessageModel.instance:clearMessageUnread(SocialEnum.ChannelType.Friend, var_20_0)

	local var_20_1 = recthelper.getHeight(arg_20_0._scrollmessage.transform) >= recthelper.getHeight(arg_20_0._gocontent.transform) or arg_20_0._scrollmessage.verticalNormalizedPosition <= 0.01 or arg_20_0._selectFriend ~= var_20_0

	if arg_20_0._selectFriend ~= var_20_0 then
		arg_20_0._inputsend:SetText("")

		if arg_20_0._preSendInfo and arg_20_0._preSendInfo.recipientId == arg_20_0._selectFriend then
			arg_20_0:_clearPreSendInfo()
		end
	end

	arg_20_0._selectFriend = var_20_0

	arg_20_0:_ondescChange()

	local var_20_2 = SocialMessageModel.instance:getSocialMessageMOList(SocialEnum.ChannelType.Friend, arg_20_0._selectFriend)

	SocialMessageListModel.instance:setMessageList(var_20_2)

	if var_20_1 then
		arg_20_0._scrollmessage.verticalNormalizedPosition = 0
	end

	arg_20_0:selectUseSkin(arg_20_0._isSelfBg)
end

function var_0_0._ondescChange(arg_21_0, arg_21_1)
	if arg_21_1 and arg_21_1 ~= arg_21_0._selectFriend then
		return
	end

	local var_21_0 = SocialModel.instance:getPlayerMO(arg_21_0._selectFriend)

	if string.nilorempty(var_21_0.desc) then
		arg_21_0._txtname.text = tostring(var_21_0.name)
	else
		arg_21_0._txtname.text = var_21_0.desc
	end
end

function var_0_0.onUpdateParam(arg_22_0)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	if arg_23_0._tweenId then
		ZProj.TweenHelper.KillById(arg_23_0._tweenId)
	end

	if arg_23_0._loader then
		arg_23_0._loader:dispose()

		arg_23_0._loader = nil
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._selectitemList) do
		iter_23_1.btn:RemoveClickListener()
	end

	arg_23_0._simagecharbg:UnLoadImage()
end

return var_0_0
