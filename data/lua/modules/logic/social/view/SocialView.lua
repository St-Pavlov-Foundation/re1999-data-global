-- chunkname: @modules/logic/social/view/SocialView.lua

module("modules.logic.social.view.SocialView", package.seeall)

local SocialView = class("SocialView", BaseView)

function SocialView:onInitView()
	self._gorequestreddot1 = gohelper.findChild(self.viewGO, "container/tabbuttons/request/#btn_request/#txt_itemcn1/#go_requestreddot1")
	self._gorequestreddot2 = gohelper.findChild(self.viewGO, "container/tabbuttons/request/#go_requestselected/#txt_itemcn2/#go_requestreddot2")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btnfriend = gohelper.findChildButtonWithAudio(self.viewGO, "container/tabbuttons/friend/#btn_friend")
	self._gofriendselected = gohelper.findChild(self.viewGO, "container/tabbuttons/friend/#go_friendselected")
	self._gofriendreddot = gohelper.findChild(self.viewGO, "container/tabbuttons/friend/#go_friendreddot")
	self._btnsearch = gohelper.findChildButtonWithAudio(self.viewGO, "container/tabbuttons/search/#btn_search")
	self._gosearchselected = gohelper.findChild(self.viewGO, "container/tabbuttons/search/#go_searchselected")
	self._btnrequest = gohelper.findChildButtonWithAudio(self.viewGO, "container/tabbuttons/request/#btn_request")
	self._gorequestselected = gohelper.findChild(self.viewGO, "container/tabbuttons/request/#go_requestselected")
	self._btnblacklist = gohelper.findChildButtonWithAudio(self.viewGO, "container/tabbuttons/blacklist/#btn_blacklist")
	self._goblacklistselected = gohelper.findChild(self.viewGO, "container/tabbuttons/blacklist/#go_blacklistselected")
	self._gobottom = gohelper.findChild(self.viewGO, "#go_bottom")
	self._txtfriendscount = gohelper.findChildText(self.viewGO, "#go_bottom/#txt_friendscount")
	self._txtfriends = gohelper.findChildText(self.viewGO, "#go_bottom/#txt_friends")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SocialView:addEvents()
	self._btnfriend:AddClickListener(self._switchTab, self, SocialEnum.TabIndex.Friend)
	self._btnsearch:AddClickListener(self._switchTab, self, SocialEnum.TabIndex.Search)
	self._btnrequest:AddClickListener(self._switchTab, self, SocialEnum.TabIndex.Request)
	self._btnblacklist:AddClickListener(self._switchTab, self, SocialEnum.TabIndex.Black)
end

function SocialView:removeEvents()
	self._btnfriend:RemoveClickListener()
	self._btnsearch:RemoveClickListener()
	self._btnrequest:RemoveClickListener()
	self._btnblacklist:RemoveClickListener()
end

function SocialView:_switchTab(index, firstEnter)
	if index == self._selectTabIndex then
		return
	end

	for i = 1, #self._tabSelected do
		gohelper.setActive(self._tabSelected[i], i == index)
	end

	for i = 1, #self._tabButton do
		gohelper.setActive(self._tabButton[i].gameObject, i ~= index)
	end

	self._selectTabIndex = index

	self.viewContainer:switchTab(index)
	self:_refreshTabViewInfo()
end

function SocialView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getSocialIcon("full/bg.png"))

	self._tabSelected = self:getUserDataTb_()
	self._tabButton = self:getUserDataTb_()

	table.insert(self._tabSelected, self._gofriendselected)
	table.insert(self._tabSelected, self._gosearchselected)
	table.insert(self._tabSelected, self._gorequestselected)
	table.insert(self._tabSelected, self._goblacklistselected)
	table.insert(self._tabButton, self._btnfriend)
	table.insert(self._tabButton, self._btnsearch)
	table.insert(self._tabButton, self._btnrequest)
	table.insert(self._tabButton, self._btnblacklist)
	gohelper.addUIClickAudio(self._btnfriend.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(self._btnsearch.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(self._btnblacklist.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function SocialView:onOpen()
	RedDotController.instance:addRedDot(self._gorequestreddot1, RedDotEnum.DotNode.AddFriendTab)
	RedDotController.instance:addRedDot(self._gorequestreddot2, RedDotEnum.DotNode.AddFriendTab)
	RedDotController.instance:addRedDot(self._gofriendreddot, RedDotEnum.DotNode.FriendInfoTab)

	local tabIndex = 1

	if self.viewParam and self.viewParam.defaultTabIds and self.viewParam.defaultTabIds[2] then
		tabIndex = self.viewParam.defaultTabIds[2]
	end

	self:_switchTab(tabIndex)
	self:addEventCb(SocialController.instance, SocialEvent.SubTabSwitch, self._onSubTabSwitch, self)
	self:addEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, self._refreshTabViewInfo, self)
	self:addEventCb(SocialController.instance, SocialEvent.RequestInfoChanged, self._refreshTabViewInfo, self)
	self:addEventCb(SocialController.instance, SocialEvent.BlackListInfoChanged, self._refreshTabViewInfo, self)
	self:addEventCb(SocialController.instance, SocialEvent.RecommendChanged, self._refreshTabViewInfo, self)
end

function SocialView:onOpenFinish()
	self._anim.enabled = true
end

function SocialView:_refreshTabViewInfo()
	if self._selectTabIndex == SocialEnum.TabIndex.Friend then
		local friendcount = SocialModel.instance:getFriendsCount()

		gohelper.setActive(self._gobottom, friendcount > 0)

		self._txtfriendscount.text = string.format("%d/%d", friendcount, SocialConfig.instance:getMaxFriendsCount())
		self._txtfriends.text = luaLang("social_tabviewinfo_friends")

		recthelper.setAnchorY(self._gobottom.transform, 69)
	elseif self._selectTabIndex == SocialEnum.TabIndex.Black then
		local blacklistcount = SocialModel.instance:getBlackListCount()

		gohelper.setActive(self._gobottom, blacklistcount > 0)

		self._txtfriendscount.text = string.format("%d/%d", blacklistcount, SocialConfig.instance:getMaxBlackListCount())
		self._txtfriends.text = luaLang("social_tabviewinfo_blacklist")

		recthelper.setAnchorY(self._gobottom.transform, 118)
	else
		gohelper.setActive(self._gobottom, false)
	end

	local baseTxt1, baseTxt2
	local redDotOffsetX, redDotOffsetY = 0, 0

	if self._selectTabIndex == 1 then
		baseTxt1 = gohelper.findChild(self._gofriendselected, "txtlayout/#txt_itemcn2")
		baseTxt2 = gohelper.findChild(self._btnsearch.gameObject, "txtlayout/#txt_itemcn1")
	elseif self._selectTabIndex == 2 then
		baseTxt1 = gohelper.findChild(self._btnfriend.gameObject, "txtlayout/#txt_itemcn1")
		baseTxt2 = gohelper.findChild(self._gosearchselected, "txtlayout/#txt_itemcn2")
	elseif self._selectTabIndex == 3 then
		baseTxt1 = gohelper.findChild(self._btnfriend.gameObject, "txtlayout/#txt_itemcn1")
		baseTxt2 = gohelper.findChild(self._btnsearch.gameObject, "txtlayout/#txt_itemcn1")
	elseif self._selectTabIndex == SocialEnum.TabIndex.Request then
		baseTxt1 = gohelper.findChild(self._btnfriend.gameObject, "txtlayout/#txt_itemcn1")
		baseTxt2 = gohelper.findChild(self._gorequestselected, "#txt_itemcn2")
	else
		return
	end

	ZProj.UGUIHelper.RebuildLayout(baseTxt1.transform)
	ZProj.UGUIHelper.RebuildLayout(baseTxt2.transform)

	local localPosX, localPosY = transformhelper.getLocalPos(baseTxt1.transform)

	transformhelper.setLocalPosXY(self._gofriendreddot.transform, localPosX + recthelper.getWidth(baseTxt1.transform) + redDotOffsetX, localPosY + recthelper.getHeight(baseTxt1.transform) / 2 + redDotOffsetY)

	localPosX, localPosY = transformhelper.getLocalPos(baseTxt2.transform)
end

function SocialView:_onSubTabSwitch(index)
	self._selectSubTabIndex = index

	self:_refreshTabViewInfo()
end

function SocialView:onClose()
	self:removeEventCb(SocialController.instance, SocialEvent.SubTabSwitch, self._onSubTabSwitch, self)
	self:removeEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, self._refreshTabViewInfo, self)
	self:removeEventCb(SocialController.instance, SocialEvent.RequestInfoChanged, self._refreshTabViewInfo, self)
	self:removeEventCb(SocialController.instance, SocialEvent.BlackListInfoChanged, self._refreshTabViewInfo, self)
	self:removeEventCb(SocialController.instance, SocialEvent.RecommendChanged, self._refreshTabViewInfo, self)
end

function SocialView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return SocialView
