module("modules.logic.social.view.SocialSearchView", package.seeall)

local var_0_0 = class("SocialSearchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorecommend = gohelper.findChild(arg_1_0.viewGO, "container/#go_recommend")
	arg_1_0._gonorecommend = gohelper.findChild(arg_1_0.viewGO, "container/#go_recommend/#go_norecommend")
	arg_1_0._gohaverecommend = gohelper.findChild(arg_1_0.viewGO, "container/#go_recommend/#go_haverecommend")
	arg_1_0._gosearchresults = gohelper.findChild(arg_1_0.viewGO, "container/#go_searchresults")
	arg_1_0._btnchangerecommend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#go_recommend/#go_haverecommend/#btn_change")
	arg_1_0._btnreturn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "search/#btn_return")
	arg_1_0._btnsearch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "search/#btn_search")
	arg_1_0._inputsearch = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "search/#input_search")
	arg_1_0._gonosearch = gohelper.findChild(arg_1_0.viewGO, "container/#go_searchresults/#go_nosearch")
	arg_1_0._scrollsearch = gohelper.findChildScrollRect(arg_1_0.viewGO, "container/#go_searchresults/scrollview")
	arg_1_0._scrollrecommend = gohelper.findChildScrollRect(arg_1_0.viewGO, "container/#go_recommend/scrollview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchangerecommend:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._btnreturn:AddClickListener(arg_2_0._btnreturnOnClick, arg_2_0)
	arg_2_0._btnsearch:AddClickListener(arg_2_0._btnsearchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchangerecommend:RemoveClickListener()
	arg_3_0._btnreturn:RemoveClickListener()
	arg_3_0._btnsearch:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._viewAnim = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(arg_4_0._btnsearch.gameObject, AudioEnum.UI.UI_Common_Click)
end

function var_0_0._btnchangeOnClick(arg_5_0)
	if arg_5_0._searchFriendCD then
		GameFacade.showToast(ToastEnum.SocialSearch2)
	else
		arg_5_0._searchFriendCD = SocialEnum.SearchFriendCD

		TaskDispatcher.runDelay(arg_5_0._onTimeEnd, arg_5_0, arg_5_0._searchFriendCD)
		arg_5_0:_switchTab(1)
		SocialModel.instance:clearRecommendList()
		FriendRpc.instance:sendGetRecommendRequest(arg_5_0._playSwitchAnim, arg_5_0)
	end
end

function var_0_0._inputValueChanged(arg_6_0)
	local var_6_0 = arg_6_0._inputsearch:GetText()

	if var_6_0 == arg_6_0._searchValue then
		return
	end

	arg_6_0._searchValue = GameUtil.utf8sub(var_6_0, 1, math.min(GameUtil.utf8len(var_6_0), 18))

	arg_6_0._inputsearch:SetText(arg_6_0._searchValue)
end

function var_0_0._btnreturnOnClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)
	arg_7_0:_resetView()
end

function var_0_0._btnsearchOnClick(arg_8_0)
	if string.nilorempty(arg_8_0._searchValue) then
		GameFacade.showToast(ToastEnum.SocialSearch1)

		return
	end

	if arg_8_0._searchFriendCD then
		GameFacade.showToast(ToastEnum.SocialSearch2)
	else
		arg_8_0._searchFriendCD = SocialEnum.SearchFriendCD

		TaskDispatcher.runDelay(arg_8_0._onTimeEnd, arg_8_0, arg_8_0._searchFriendCD)
		arg_8_0:_switchTab(2)
		SocialModel.instance:clearSearchList()
		SocialController.instance:dispatchEvent(SocialEvent.SearchInfoChanged)
		FriendRpc.instance:sendSearchRequest(arg_8_0._searchValue, arg_8_0._playSwitchAnim, arg_8_0)
	end
end

function var_0_0._playSwitchAnim(arg_9_0)
	if arg_9_0._viewAnim then
		arg_9_0._viewAnim:Play("switch", 0, 0)
	end
end

function var_0_0._onTimeEnd(arg_10_0)
	arg_10_0._searchFriendCD = nil
end

function var_0_0._switchTab(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._selectIndex = arg_11_1

	SocialController.instance:dispatchEvent(SocialEvent.SubTabSwitch, arg_11_1)
	gohelper.setActive(arg_11_0._gorecommend, arg_11_1 == 1)
	gohelper.setActive(arg_11_0._gosearchresults, arg_11_1 == 2)
	gohelper.setActive(arg_11_0._btnreturn.gameObject, arg_11_1 == 2)
	arg_11_0:_refreshUI(arg_11_2)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._inputsearch:AddOnValueChanged(arg_12_0._inputValueChanged, arg_12_0)
	arg_12_0:addEventCb(SocialController.instance, SocialEvent.RecommendChanged, arg_12_0._refreshUI, arg_12_0)
	arg_12_0:addEventCb(SocialController.instance, SocialEvent.SearchInfoChanged, arg_12_0._refreshUI, arg_12_0)

	if arg_12_0._notFirst then
		arg_12_0:_resetView()
	else
		arg_12_0:_resetView(true)
	end

	arg_12_0._notFirst = true
end

function var_0_0._resetView(arg_13_0, arg_13_1)
	arg_13_0._searchValue = ""

	arg_13_0._inputsearch:SetText(arg_13_0._searchValue)
	arg_13_0:_switchTab(1, arg_13_1)

	if UnityEngine.Time.realtimeSinceStartup - SocialModel.instance.leftSendRecommendReqDt > SocialEnum.SearchFriendCD then
		SocialModel.instance:clearRecommendList()
		FriendRpc.instance:sendGetRecommendRequest()

		arg_13_0._searchFriendCD = SocialEnum.SearchFriendCD

		TaskDispatcher.runDelay(arg_13_0._onTimeEnd, arg_13_0, arg_13_0._searchFriendCD)
	end
end

function var_0_0._refreshUI(arg_14_0, arg_14_1)
	local var_14_0 = SocialModel.instance:getRecommendCount()
	local var_14_1 = SocialModel.instance:getSearchCount()

	gohelper.setActive(arg_14_0._gonorecommend, not arg_14_1 and var_14_0 <= 0)
	gohelper.setActive(arg_14_0._gohaverecommend, not arg_14_1 and var_14_0 > 0)
	gohelper.setActive(arg_14_0._gonosearch, not arg_14_1 and var_14_1 <= 0)

	if arg_14_0._selectIndex == 1 then
		arg_14_0._scrollrecommend.verticalNormalizedPosition = 1
	elseif arg_14_0._selectIndex == 2 then
		arg_14_0._scrollsearch.verticalNormalizedPosition = 1
	end
end

function var_0_0.onClose(arg_15_0)
	arg_15_0._inputsearch:RemoveOnValueChanged()
	arg_15_0:removeEventCb(SocialController.instance, SocialEvent.RecommendChanged, arg_15_0._refreshUI, arg_15_0)
	arg_15_0:removeEventCb(SocialController.instance, SocialEvent.SearchInfoChanged, arg_15_0._refreshUI, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._onTimeEnd, arg_16_0)
end

return var_0_0
