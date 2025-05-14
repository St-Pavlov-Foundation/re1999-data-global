module("modules.logic.social.view.SocialView", package.seeall)

local var_0_0 = class("SocialView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorequestreddot1 = gohelper.findChild(arg_1_0.viewGO, "container/tabbuttons/request/#btn_request/#txt_itemcn1/#go_requestreddot1")
	arg_1_0._gorequestreddot2 = gohelper.findChild(arg_1_0.viewGO, "container/tabbuttons/request/#go_requestselected/#txt_itemcn2/#go_requestreddot2")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btnfriend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/tabbuttons/friend/#btn_friend")
	arg_1_0._gofriendselected = gohelper.findChild(arg_1_0.viewGO, "container/tabbuttons/friend/#go_friendselected")
	arg_1_0._gofriendreddot = gohelper.findChild(arg_1_0.viewGO, "container/tabbuttons/friend/#go_friendreddot")
	arg_1_0._btnsearch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/tabbuttons/search/#btn_search")
	arg_1_0._gosearchselected = gohelper.findChild(arg_1_0.viewGO, "container/tabbuttons/search/#go_searchselected")
	arg_1_0._btnrequest = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/tabbuttons/request/#btn_request")
	arg_1_0._gorequestselected = gohelper.findChild(arg_1_0.viewGO, "container/tabbuttons/request/#go_requestselected")
	arg_1_0._btnblacklist = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/tabbuttons/blacklist/#btn_blacklist")
	arg_1_0._goblacklistselected = gohelper.findChild(arg_1_0.viewGO, "container/tabbuttons/blacklist/#go_blacklistselected")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#go_bottom")
	arg_1_0._txtfriendscount = gohelper.findChildText(arg_1_0.viewGO, "#go_bottom/#txt_friendscount")
	arg_1_0._txtfriends = gohelper.findChildText(arg_1_0.viewGO, "#go_bottom/#txt_friends")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfriend:AddClickListener(arg_2_0._switchTab, arg_2_0, SocialEnum.TabIndex.Friend)
	arg_2_0._btnsearch:AddClickListener(arg_2_0._switchTab, arg_2_0, SocialEnum.TabIndex.Search)
	arg_2_0._btnrequest:AddClickListener(arg_2_0._switchTab, arg_2_0, SocialEnum.TabIndex.Request)
	arg_2_0._btnblacklist:AddClickListener(arg_2_0._switchTab, arg_2_0, SocialEnum.TabIndex.Black)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfriend:RemoveClickListener()
	arg_3_0._btnsearch:RemoveClickListener()
	arg_3_0._btnrequest:RemoveClickListener()
	arg_3_0._btnblacklist:RemoveClickListener()
end

function var_0_0._switchTab(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == arg_4_0._selectTabIndex then
		return
	end

	for iter_4_0 = 1, #arg_4_0._tabSelected do
		gohelper.setActive(arg_4_0._tabSelected[iter_4_0], iter_4_0 == arg_4_1)
	end

	for iter_4_1 = 1, #arg_4_0._tabButton do
		gohelper.setActive(arg_4_0._tabButton[iter_4_1].gameObject, iter_4_1 ~= arg_4_1)
	end

	arg_4_0._selectTabIndex = arg_4_1

	arg_4_0.viewContainer:switchTab(arg_4_1)
	arg_4_0:_refreshTabViewInfo()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getSocialIcon("full/bg.png"))

	arg_5_0._tabSelected = arg_5_0:getUserDataTb_()
	arg_5_0._tabButton = arg_5_0:getUserDataTb_()

	table.insert(arg_5_0._tabSelected, arg_5_0._gofriendselected)
	table.insert(arg_5_0._tabSelected, arg_5_0._gosearchselected)
	table.insert(arg_5_0._tabSelected, arg_5_0._gorequestselected)
	table.insert(arg_5_0._tabSelected, arg_5_0._goblacklistselected)
	table.insert(arg_5_0._tabButton, arg_5_0._btnfriend)
	table.insert(arg_5_0._tabButton, arg_5_0._btnsearch)
	table.insert(arg_5_0._tabButton, arg_5_0._btnrequest)
	table.insert(arg_5_0._tabButton, arg_5_0._btnblacklist)
	gohelper.addUIClickAudio(arg_5_0._btnfriend.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(arg_5_0._btnsearch.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(arg_5_0._btnblacklist.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function var_0_0.onOpen(arg_6_0)
	RedDotController.instance:addRedDot(arg_6_0._gorequestreddot1, RedDotEnum.DotNode.AddFriendTab)
	RedDotController.instance:addRedDot(arg_6_0._gorequestreddot2, RedDotEnum.DotNode.AddFriendTab)
	RedDotController.instance:addRedDot(arg_6_0._gofriendreddot, RedDotEnum.DotNode.FriendInfoTab)

	local var_6_0 = 1

	if arg_6_0.viewParam and arg_6_0.viewParam.defaultTabIds and arg_6_0.viewParam.defaultTabIds[2] then
		var_6_0 = arg_6_0.viewParam.defaultTabIds[2]
	end

	arg_6_0:_switchTab(var_6_0)
	arg_6_0:addEventCb(SocialController.instance, SocialEvent.SubTabSwitch, arg_6_0._onSubTabSwitch, arg_6_0)
	arg_6_0:addEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, arg_6_0._refreshTabViewInfo, arg_6_0)
	arg_6_0:addEventCb(SocialController.instance, SocialEvent.RequestInfoChanged, arg_6_0._refreshTabViewInfo, arg_6_0)
	arg_6_0:addEventCb(SocialController.instance, SocialEvent.BlackListInfoChanged, arg_6_0._refreshTabViewInfo, arg_6_0)
	arg_6_0:addEventCb(SocialController.instance, SocialEvent.RecommendChanged, arg_6_0._refreshTabViewInfo, arg_6_0)
end

function var_0_0.onOpenFinish(arg_7_0)
	arg_7_0._anim.enabled = true
end

function var_0_0._refreshTabViewInfo(arg_8_0)
	if arg_8_0._selectTabIndex == SocialEnum.TabIndex.Friend then
		local var_8_0 = SocialModel.instance:getFriendsCount()

		gohelper.setActive(arg_8_0._gobottom, var_8_0 > 0)

		arg_8_0._txtfriendscount.text = string.format("%d/%d", var_8_0, SocialConfig.instance:getMaxFriendsCount())
		arg_8_0._txtfriends.text = luaLang("social_tabviewinfo_friends")

		recthelper.setAnchorY(arg_8_0._gobottom.transform, 69)
	elseif arg_8_0._selectTabIndex == SocialEnum.TabIndex.Black then
		local var_8_1 = SocialModel.instance:getBlackListCount()

		gohelper.setActive(arg_8_0._gobottom, var_8_1 > 0)

		arg_8_0._txtfriendscount.text = string.format("%d/%d", var_8_1, SocialConfig.instance:getMaxBlackListCount())
		arg_8_0._txtfriends.text = luaLang("social_tabviewinfo_blacklist")

		recthelper.setAnchorY(arg_8_0._gobottom.transform, 118)
	else
		gohelper.setActive(arg_8_0._gobottom, false)
	end

	local var_8_2
	local var_8_3
	local var_8_4 = 0
	local var_8_5 = 0

	if arg_8_0._selectTabIndex == 1 then
		var_8_2 = gohelper.findChild(arg_8_0._gofriendselected, "txtlayout/#txt_itemcn2")
		var_8_3 = gohelper.findChild(arg_8_0._btnsearch.gameObject, "txtlayout/#txt_itemcn1")
	elseif arg_8_0._selectTabIndex == 2 then
		var_8_2 = gohelper.findChild(arg_8_0._btnfriend.gameObject, "txtlayout/#txt_itemcn1")
		var_8_3 = gohelper.findChild(arg_8_0._gosearchselected, "txtlayout/#txt_itemcn2")
	elseif arg_8_0._selectTabIndex == 3 then
		var_8_2 = gohelper.findChild(arg_8_0._btnfriend.gameObject, "txtlayout/#txt_itemcn1")
		var_8_3 = gohelper.findChild(arg_8_0._btnsearch.gameObject, "txtlayout/#txt_itemcn1")
	elseif arg_8_0._selectTabIndex == SocialEnum.TabIndex.Request then
		var_8_2 = gohelper.findChild(arg_8_0._btnfriend.gameObject, "txtlayout/#txt_itemcn1")
		var_8_3 = gohelper.findChild(arg_8_0._gorequestselected, "#txt_itemcn2")
	else
		return
	end

	ZProj.UGUIHelper.RebuildLayout(var_8_2.transform)
	ZProj.UGUIHelper.RebuildLayout(var_8_3.transform)

	local var_8_6, var_8_7 = transformhelper.getLocalPos(var_8_2.transform)

	transformhelper.setLocalPosXY(arg_8_0._gofriendreddot.transform, var_8_6 + recthelper.getWidth(var_8_2.transform) + var_8_4, var_8_7 + recthelper.getHeight(var_8_2.transform) / 2 + var_8_5)

	local var_8_8, var_8_9 = transformhelper.getLocalPos(var_8_3.transform)
end

function var_0_0._onSubTabSwitch(arg_9_0, arg_9_1)
	arg_9_0._selectSubTabIndex = arg_9_1

	arg_9_0:_refreshTabViewInfo()
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:removeEventCb(SocialController.instance, SocialEvent.SubTabSwitch, arg_10_0._onSubTabSwitch, arg_10_0)
	arg_10_0:removeEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, arg_10_0._refreshTabViewInfo, arg_10_0)
	arg_10_0:removeEventCb(SocialController.instance, SocialEvent.RequestInfoChanged, arg_10_0._refreshTabViewInfo, arg_10_0)
	arg_10_0:removeEventCb(SocialController.instance, SocialEvent.BlackListInfoChanged, arg_10_0._refreshTabViewInfo, arg_10_0)
	arg_10_0:removeEventCb(SocialController.instance, SocialEvent.RecommendChanged, arg_10_0._refreshTabViewInfo, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
end

return var_0_0
