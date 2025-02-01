module("modules.logic.social.view.SocialView", package.seeall)

slot0 = class("SocialView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorequestreddot1 = gohelper.findChild(slot0.viewGO, "container/tabbuttons/request/#btn_request/#txt_itemcn1/#go_requestreddot1")
	slot0._gorequestreddot2 = gohelper.findChild(slot0.viewGO, "container/tabbuttons/request/#go_requestselected/#txt_itemcn2/#go_requestreddot2")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btnfriend = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/tabbuttons/friend/#btn_friend")
	slot0._gofriendselected = gohelper.findChild(slot0.viewGO, "container/tabbuttons/friend/#go_friendselected")
	slot0._gofriendreddot = gohelper.findChild(slot0.viewGO, "container/tabbuttons/friend/#go_friendreddot")
	slot0._btnsearch = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/tabbuttons/search/#btn_search")
	slot0._gosearchselected = gohelper.findChild(slot0.viewGO, "container/tabbuttons/search/#go_searchselected")
	slot0._btnrequest = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/tabbuttons/request/#btn_request")
	slot0._gorequestselected = gohelper.findChild(slot0.viewGO, "container/tabbuttons/request/#go_requestselected")
	slot0._btnblacklist = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/tabbuttons/blacklist/#btn_blacklist")
	slot0._goblacklistselected = gohelper.findChild(slot0.viewGO, "container/tabbuttons/blacklist/#go_blacklistselected")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "#go_bottom")
	slot0._txtfriendscount = gohelper.findChildText(slot0.viewGO, "#go_bottom/#txt_friendscount")
	slot0._txtfriends = gohelper.findChildText(slot0.viewGO, "#go_bottom/#txt_friends")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfriend:AddClickListener(slot0._switchTab, slot0, SocialEnum.TabIndex.Friend)
	slot0._btnsearch:AddClickListener(slot0._switchTab, slot0, SocialEnum.TabIndex.Search)
	slot0._btnrequest:AddClickListener(slot0._switchTab, slot0, SocialEnum.TabIndex.Request)
	slot0._btnblacklist:AddClickListener(slot0._switchTab, slot0, SocialEnum.TabIndex.Black)
end

function slot0.removeEvents(slot0)
	slot0._btnfriend:RemoveClickListener()
	slot0._btnsearch:RemoveClickListener()
	slot0._btnrequest:RemoveClickListener()
	slot0._btnblacklist:RemoveClickListener()
end

function slot0._switchTab(slot0, slot1, slot2)
	if slot1 == slot0._selectTabIndex then
		return
	end

	for slot6 = 1, #slot0._tabSelected do
		gohelper.setActive(slot0._tabSelected[slot6], slot6 == slot1)
	end

	for slot6 = 1, #slot0._tabButton do
		gohelper.setActive(slot0._tabButton[slot6].gameObject, slot6 ~= slot1)
	end

	slot0._selectTabIndex = slot1

	slot0.viewContainer:switchTab(slot1)
	slot0:_refreshTabViewInfo()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSocialIcon("full/bg.png"))

	slot0._tabSelected = slot0:getUserDataTb_()
	slot0._tabButton = slot0:getUserDataTb_()

	table.insert(slot0._tabSelected, slot0._gofriendselected)
	table.insert(slot0._tabSelected, slot0._gosearchselected)
	table.insert(slot0._tabSelected, slot0._gorequestselected)
	table.insert(slot0._tabSelected, slot0._goblacklistselected)
	table.insert(slot0._tabButton, slot0._btnfriend)
	table.insert(slot0._tabButton, slot0._btnsearch)
	table.insert(slot0._tabButton, slot0._btnrequest)
	table.insert(slot0._tabButton, slot0._btnblacklist)
	gohelper.addUIClickAudio(slot0._btnfriend.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(slot0._btnsearch.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(slot0._btnblacklist.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function slot0.onOpen(slot0)
	RedDotController.instance:addRedDot(slot0._gorequestreddot1, RedDotEnum.DotNode.AddFriendTab)
	RedDotController.instance:addRedDot(slot0._gorequestreddot2, RedDotEnum.DotNode.AddFriendTab)
	RedDotController.instance:addRedDot(slot0._gofriendreddot, RedDotEnum.DotNode.FriendInfoTab)

	slot1 = 1

	if slot0.viewParam and slot0.viewParam.defaultTabIds and slot0.viewParam.defaultTabIds[2] then
		slot1 = slot0.viewParam.defaultTabIds[2]
	end

	slot0:_switchTab(slot1)
	slot0:addEventCb(SocialController.instance, SocialEvent.SubTabSwitch, slot0._onSubTabSwitch, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, slot0._refreshTabViewInfo, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.RequestInfoChanged, slot0._refreshTabViewInfo, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.BlackListInfoChanged, slot0._refreshTabViewInfo, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.RecommendChanged, slot0._refreshTabViewInfo, slot0)
end

function slot0.onOpenFinish(slot0)
	slot0._anim.enabled = true
end

function slot0._refreshTabViewInfo(slot0)
	if slot0._selectTabIndex == SocialEnum.TabIndex.Friend then
		gohelper.setActive(slot0._gobottom, SocialModel.instance:getFriendsCount() > 0)

		slot0._txtfriendscount.text = string.format("%d/%d", slot1, SocialConfig.instance:getMaxFriendsCount())
		slot0._txtfriends.text = luaLang("social_tabviewinfo_friends")

		recthelper.setAnchorY(slot0._gobottom.transform, 69)
	elseif slot0._selectTabIndex == SocialEnum.TabIndex.Black then
		gohelper.setActive(slot0._gobottom, SocialModel.instance:getBlackListCount() > 0)

		slot0._txtfriendscount.text = string.format("%d/%d", slot1, SocialConfig.instance:getMaxBlackListCount())
		slot0._txtfriends.text = luaLang("social_tabviewinfo_blacklist")

		recthelper.setAnchorY(slot0._gobottom.transform, 118)
	else
		gohelper.setActive(slot0._gobottom, false)
	end

	slot1, slot2 = nil
	slot3 = 0
	slot4 = 0

	if slot0._selectTabIndex == 1 then
		slot1 = gohelper.findChild(slot0._gofriendselected, "txtlayout/#txt_itemcn2")
		slot2 = gohelper.findChild(slot0._btnsearch.gameObject, "txtlayout/#txt_itemcn1")
	elseif slot0._selectTabIndex == 2 then
		slot1 = gohelper.findChild(slot0._btnfriend.gameObject, "txtlayout/#txt_itemcn1")
		slot2 = gohelper.findChild(slot0._gosearchselected, "txtlayout/#txt_itemcn2")
	elseif slot0._selectTabIndex == 3 then
		slot1 = gohelper.findChild(slot0._btnfriend.gameObject, "txtlayout/#txt_itemcn1")
		slot2 = gohelper.findChild(slot0._btnsearch.gameObject, "txtlayout/#txt_itemcn1")
	elseif slot0._selectTabIndex == SocialEnum.TabIndex.Request then
		slot1 = gohelper.findChild(slot0._btnfriend.gameObject, "txtlayout/#txt_itemcn1")
		slot2 = gohelper.findChild(slot0._gorequestselected, "#txt_itemcn2")
	else
		return
	end

	ZProj.UGUIHelper.RebuildLayout(slot1.transform)
	ZProj.UGUIHelper.RebuildLayout(slot2.transform)

	slot5, slot6 = transformhelper.getLocalPos(slot1.transform)

	transformhelper.setLocalPosXY(slot0._gofriendreddot.transform, slot5 + recthelper.getWidth(slot1.transform) + slot3, slot6 + recthelper.getHeight(slot1.transform) / 2 + slot4)

	slot5, slot6 = transformhelper.getLocalPos(slot2.transform)
end

function slot0._onSubTabSwitch(slot0, slot1)
	slot0._selectSubTabIndex = slot1

	slot0:_refreshTabViewInfo()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.SubTabSwitch, slot0._onSubTabSwitch, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, slot0._refreshTabViewInfo, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.RequestInfoChanged, slot0._refreshTabViewInfo, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.BlackListInfoChanged, slot0._refreshTabViewInfo, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.RecommendChanged, slot0._refreshTabViewInfo, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
