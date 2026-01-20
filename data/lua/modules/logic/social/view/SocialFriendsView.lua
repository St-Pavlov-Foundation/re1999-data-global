-- chunkname: @modules/logic/social/view/SocialFriendsView.lua

module("modules.logic.social.view.SocialFriendsView", package.seeall)

local SocialFriendsView = class("SocialFriendsView", BaseView)

function SocialFriendsView:onInitView()
	self._gohas = gohelper.findChild(self.viewGO, "#go_has")
	self._gono = gohelper.findChild(self.viewGO, "#go_no")
	self._simagecharbg = gohelper.findChildSingleImage(self.viewGO, "#go_has/right/#simage_chartbg")
	self._goSkinbg = gohelper.findChild(self.viewGO, "#go_has/right/#go_skinbg")
	self._gomessage = gohelper.findChild(self.viewGO, "#go_has/right/#go_message")
	self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/right/#go_settingbackground/btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "#go_has/right/#go_settingbackground/btn_click/selected")
	self._gounselect = gohelper.findChild(self.viewGO, "#go_has/right/#go_settingbackground/btn_click/unselect")
	self._gotips = gohelper.findChild(self.viewGO, "#go_has/right/#go_settingbackground/go_tips")
	self._btnclosetips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/right/#go_settingbackground/go_tips/#btn_close")
	self._inputsend = gohelper.findChildTextMeshInputField(self.viewGO, "#go_has/right/#go_message/send/#input_send")
	self._scrollmessage = gohelper.findChildScrollRect(self.viewGO, "#go_has/right/#go_message/#scroll_message")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_has/right/#go_message/#scroll_message/viewport/#go_content")
	self._btnsend = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/right/#go_message/send/#btn_send")
	self._txtcd = gohelper.findChildText(self.viewGO, "#go_has/right/#go_message/send/#btn_send/#txt_cd")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_has/right/#txt_name")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._isSelectBtn = false
	self._isSelfBg = true
	self._isopen = false
	self._selectitemList = {}
	self._currentselectbg = nil

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialFriendsView:addEvents()
	self._btnsend:AddClickListener(self._btnsendOnClick, self)
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	self._btnclosetips:AddClickListener(self._btnclosetipsOnClick, self)
end

function SocialFriendsView:removeEvents()
	self._btnsend:RemoveClickListener()
	self._btnselect:RemoveClickListener()
	self._btnclosetips:RemoveClickListener()
end

function SocialFriendsView:_editableInitView()
	self._friendChatCD = nil
	self._txtcd.text = luaLang("social_chat_send")

	self._simagecharbg:LoadImage(ResUrl.getSocialIcon("img_chat_bg.png"))

	self.skinkey = PlayerPrefsKey.SocialFriendsViewSelectOwnSkin .. tostring(PlayerModel.instance:getPlayinfo().userId)
	self._isSelfBg = PlayerPrefsHelper.getNumber(self.skinkey, SocialEnum.SelectEnum.Self) == SocialEnum.SelectEnum.Self

	self:_refreshSelect()

	for i = 1, 2 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "#go_has/right/#go_settingbackground/go_tips/bg/item" .. i)
		item.btn = gohelper.findChildButton(item.go, "#btn_option")
		item.goselect = gohelper.findChild(item.go, "txt_option/selected")
		item.gounselect = gohelper.findChild(item.go, "txt_option/unselect")
		item.isSelf = i == SocialEnum.SelectEnum.Self

		item.btn:AddClickListener(self.selectUseSkin, self, item.isSelf)
		table.insert(self._selectitemList, item)
		gohelper.setActive(item.goselect, item.isSelf == self._isSelfBg)
		gohelper.setActive(item.gounselect, item.isSelf ~= self._isSelfBg)
	end
end

function SocialFriendsView:_btnselectOnClick()
	self._isSelectBtn = not self._isSelectBtn

	self:_refreshSelect()
end

function SocialFriendsView:_btnclosetipsOnClick()
	self._isSelectBtn = false

	self:_refreshSelect()
end

function SocialFriendsView:_refreshSelect()
	gohelper.setActive(self._goselect, self._isSelectBtn)
	gohelper.setActive(self._gounselect, not self._isSelectBtn)
	gohelper.setActive(self._gotips, self._isSelectBtn)
end

function SocialFriendsView:_loadBg()
	local skinId = PlayerCardModel.instance:getPlayerCardSkinId()

	if not self._isSelfBg then
		if not self._selectFriend then
			return
		end

		local playerMO = SocialModel.instance:getPlayerMO(self._selectFriend)

		skinId = playerMO.bg
	end

	if skinId == self._currentselectbg then
		return
	end

	if self._goskinEffect then
		gohelper.destroy(self._goskinEffect)

		self._goskinEffect = nil
	end

	if skinId and skinId ~= 0 then
		self._hasSkin = true
		self._skinPath = string.format("ui/viewres/player/playercard/playercardskinpreview_%s.prefab", skinId)
		self._loader = MultiAbLoader.New()

		self._loader:addPath(self._skinPath)
		self._loader:startLoad(self._onLoadFinish, self)
	else
		self._hasSkin = false
	end

	gohelper.setActive(self._goSkinbg, self._hasSkin)
	gohelper.setActive(self._simagecharbg.gameObject, not self._hasSkin)

	if self._isopen and not self._hasSkin then
		self._animator.enabled = true

		self._animator:Play("open", 0, 0)
	end

	self._currentselectbg = skinId
end

function SocialFriendsView:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._skinPath)
	local viewPrefab = assetItem:GetResource(self._skinPath)

	self._goskinEffect = gohelper.clone(viewPrefab, self._goSkinbg)
	self._animator.enabled = true

	self._animator:Play("open", 0, 0)
end

function SocialFriendsView:_btnsendOnClick()
	if self._friendChatCD then
		GameFacade.showToast(ToastEnum.SocialFriends1)

		return
	end

	local sendValue = self._inputsend:GetText()

	if string.nilorempty(sendValue) then
		GameFacade.showToast(ToastEnum.SocialFriends2)

		return
	end

	local replacedSpaceValue = string.gsub(sendValue, " ", "")

	if string.nilorempty(replacedSpaceValue) then
		GameFacade.showToast(ToastEnum.SocialFriends2)
		self._inputsend:SetText("")

		return
	end

	self._friendChatCD = SocialEnum.FriendChatCD
	self._txtcd.text = string.format("%ds", math.ceil(self._friendChatCD))
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(SocialEnum.FriendChatCD, 0, SocialEnum.FriendChatCD, self._onTimeUpdate, self._onTimeEnd, self, nil, EaseType.Linear)
	self._scrollmessage.verticalNormalizedPosition = 0

	local msgType = 0
	local extData = ""

	if self._preSendInfo and self._preSendInfo.recipientId == self._selectFriend then
		msgType = self._preSendInfo.msgType
		extData = self._preSendInfo.extData

		self:_clearPreSendInfo()
	end

	ChatRpc.instance:sendSendMsgRequest(SocialEnum.ChannelType.Friend, self._selectFriend, sendValue, msgType, extData, self._onSendMsgReply, self)
end

function SocialFriendsView:_onSendMsgReply(cmd, resultCode, msg)
	if resultCode == 0 then
		self._inputsend:SetText("")

		local info = self._preSendInfo

		if info and msg.recipientId == info.recipientId and msg.msgType == msg.msgType then
			self:_clearPreSendInfo()
		end
	end
end

function SocialFriendsView:_clearPreSendInfo()
	self._preSendInfo = nil

	if self.viewParam and self.viewParam.preSendInfo then
		self.viewParam.preSendInfo = nil
	end
end

function SocialFriendsView:_onTimeUpdate(value)
	self._friendChatCD = value
	self._txtcd.text = string.format("%ds", math.ceil(self._friendChatCD))
end

function SocialFriendsView:_onTimeEnd()
	self._friendChatCD = nil
	self._txtcd.text = luaLang("social_chat_send")
	self._tweenId = nil
end

function SocialFriendsView:onOpen()
	self:addEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, self._refreshUI, self)
	self:addEventCb(SocialController.instance, SocialEvent.SelectFriend, self._refreshMessageView, self)
	self:addEventCb(SocialController.instance, SocialEvent.MessageInfoChanged, self._refreshMessageView, self)
	self:addEventCb(SocialController.instance, SocialEvent.AddUnknownFriend, self._onAddUnknownFriend, self)
	self:addEventCb(SocialController.instance, SocialEvent.FriendDescChange, self._ondescChange, self)
	SocialListModel.instance:sortFriendList()
	FriendRpc.instance:sendGetFriendInfoListRequest()

	if self._notFirst then
		self:_refreshUI()
	else
		self:_refreshUI(true)
	end

	self._notFirst = true
	self._preSendInfo = nil

	if self.viewParam and self.viewParam.preSendInfo then
		self._preSendInfo = self.viewParam.preSendInfo

		self._inputsend:SetText(self._preSendInfo.content)
	end

	self:_loadBg()

	self._isopen = true
end

function SocialFriendsView:selectUseSkin(isSelf)
	if isSelf then
		self._isSelfBg = true

		PlayerPrefsHelper.setNumber(self.skinkey, SocialEnum.SelectEnum.Self)
	else
		self._isSelfBg = false

		PlayerPrefsHelper.setNumber(self.skinkey, SocialEnum.SelectEnum.Friend)
	end

	self:_loadBg()

	for _, item in ipairs(self._selectitemList) do
		gohelper.setActive(item.goselect, item.isSelf == self._isSelfBg)
		gohelper.setActive(item.gounselect, item.isSelf ~= self._isSelfBg)
	end

	self:_btnclosetipsOnClick()
end

function SocialFriendsView:_onAddUnknownFriend()
	FriendRpc.instance:sendGetFriendInfoListRequest()
end

function SocialFriendsView:onClose()
	self:removeEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, self._refreshUI, self)
	self:removeEventCb(SocialController.instance, SocialEvent.SelectFriend, self._refreshMessageView, self)
	self:removeEventCb(SocialController.instance, SocialEvent.MessageInfoChanged, self._refreshMessageView, self)
	self:removeEventCb(SocialController.instance, SocialEvent.AddUnknownFriend, self._onAddUnknownFriend, self)
	self:removeEventCb(SocialController.instance, SocialEvent.FriendDescChange, self._ondescChange, self)
end

function SocialFriendsView:_refreshUI(open)
	local friendsCount = SocialModel.instance:getFriendsCount()

	if not open then
		gohelper.setActive(self._gohas, friendsCount > 0)
		gohelper.setActive(self._gono, friendsCount <= 0)
	else
		gohelper.setActive(self._gohas, friendsCount > 0)
		gohelper.setActive(self._gono, false)
	end

	local selectFriend = SocialModel.instance:getSelectFriend()

	if not selectFriend then
		local friendList = SocialListModel.instance:getModel(SocialEnum.Type.Friend):getList()

		if friendList and #friendList > 0 then
			local playerMO = friendList[1]

			SocialModel.instance:setSelectFriend(playerMO.userId)
		end
	end

	self:_refreshMessageView()
end

function SocialFriendsView:_refreshMessageView()
	local selectFriend = SocialModel.instance:getSelectFriend()

	if not selectFriend then
		gohelper.setActive(self._gomessage, false)

		self._txtname.text = ""
		self._selectFriend = nil

		return
	end

	gohelper.setActive(self._gomessage, true)
	SocialMessageModel.instance:clearMessageUnread(SocialEnum.ChannelType.Friend, selectFriend)

	local bottom = recthelper.getHeight(self._scrollmessage.transform) >= recthelper.getHeight(self._gocontent.transform) or self._scrollmessage.verticalNormalizedPosition <= 0.01 or self._selectFriend ~= selectFriend
	local changed = self._selectFriend ~= selectFriend

	if changed then
		self._inputsend:SetText("")

		if self._preSendInfo and self._preSendInfo.recipientId == self._selectFriend then
			self:_clearPreSendInfo()
		end
	end

	self._selectFriend = selectFriend

	self:_ondescChange()

	local messageMOList = SocialMessageModel.instance:getSocialMessageMOList(SocialEnum.ChannelType.Friend, self._selectFriend)

	SocialMessageListModel.instance:setMessageList(messageMOList)

	if bottom then
		self._scrollmessage.verticalNormalizedPosition = 0
	end

	self:selectUseSkin(self._isSelfBg)
end

function SocialFriendsView:_ondescChange(id)
	if id and id ~= self._selectFriend then
		return
	end

	local playerMO = SocialModel.instance:getPlayerMO(self._selectFriend)

	if string.nilorempty(playerMO.desc) then
		self._txtname.text = tostring(playerMO.name)
	else
		self._txtname.text = playerMO.desc
	end
end

function SocialFriendsView:onUpdateParam()
	return
end

function SocialFriendsView:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	for _, item in ipairs(self._selectitemList) do
		item.btn:RemoveClickListener()
	end

	self._simagecharbg:UnLoadImage()
end

return SocialFriendsView
