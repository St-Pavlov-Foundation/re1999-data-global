module("modules.logic.social.view.SocialSearchView", package.seeall)

slot0 = class("SocialSearchView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorecommend = gohelper.findChild(slot0.viewGO, "container/#go_recommend")
	slot0._gonorecommend = gohelper.findChild(slot0.viewGO, "container/#go_recommend/#go_norecommend")
	slot0._gohaverecommend = gohelper.findChild(slot0.viewGO, "container/#go_recommend/#go_haverecommend")
	slot0._gosearchresults = gohelper.findChild(slot0.viewGO, "container/#go_searchresults")
	slot0._btnchangerecommend = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#go_recommend/#go_haverecommend/#btn_change")
	slot0._btnreturn = gohelper.findChildButtonWithAudio(slot0.viewGO, "search/#btn_return")
	slot0._btnsearch = gohelper.findChildButtonWithAudio(slot0.viewGO, "search/#btn_search")
	slot0._inputsearch = gohelper.findChildTextMeshInputField(slot0.viewGO, "search/#input_search")
	slot0._gonosearch = gohelper.findChild(slot0.viewGO, "container/#go_searchresults/#go_nosearch")
	slot0._scrollsearch = gohelper.findChildScrollRect(slot0.viewGO, "container/#go_searchresults/scrollview")
	slot0._scrollrecommend = gohelper.findChildScrollRect(slot0.viewGO, "container/#go_recommend/scrollview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnchangerecommend:AddClickListener(slot0._btnchangeOnClick, slot0)
	slot0._btnreturn:AddClickListener(slot0._btnreturnOnClick, slot0)
	slot0._btnsearch:AddClickListener(slot0._btnsearchOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnchangerecommend:RemoveClickListener()
	slot0._btnreturn:RemoveClickListener()
	slot0._btnsearch:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(slot0._btnsearch.gameObject, AudioEnum.UI.UI_Common_Click)
end

function slot0._btnchangeOnClick(slot0)
	if slot0._searchFriendCD then
		GameFacade.showToast(ToastEnum.SocialSearch2)
	else
		slot0._searchFriendCD = SocialEnum.SearchFriendCD

		TaskDispatcher.runDelay(slot0._onTimeEnd, slot0, slot0._searchFriendCD)
		slot0:_switchTab(1)
		SocialModel.instance:clearRecommendList()
		FriendRpc.instance:sendGetRecommendRequest(slot0._playSwitchAnim, slot0)
	end
end

function slot0._inputValueChanged(slot0)
	if slot0._inputsearch:GetText() == slot0._searchValue then
		return
	end

	slot0._searchValue = GameUtil.utf8sub(slot1, 1, math.min(GameUtil.utf8len(slot1), 18))

	slot0._inputsearch:SetText(slot0._searchValue)
end

function slot0._btnreturnOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_search_clear)
	slot0:_resetView()
end

function slot0._btnsearchOnClick(slot0)
	if string.nilorempty(slot0._searchValue) then
		GameFacade.showToast(ToastEnum.SocialSearch1)

		return
	end

	if slot0._searchFriendCD then
		GameFacade.showToast(ToastEnum.SocialSearch2)
	else
		slot0._searchFriendCD = SocialEnum.SearchFriendCD

		TaskDispatcher.runDelay(slot0._onTimeEnd, slot0, slot0._searchFriendCD)
		slot0:_switchTab(2)
		SocialModel.instance:clearSearchList()
		SocialController.instance:dispatchEvent(SocialEvent.SearchInfoChanged)
		FriendRpc.instance:sendSearchRequest(slot0._searchValue, slot0._playSwitchAnim, slot0)
	end
end

function slot0._playSwitchAnim(slot0)
	if slot0._viewAnim then
		slot0._viewAnim:Play("switch", 0, 0)
	end
end

function slot0._onTimeEnd(slot0)
	slot0._searchFriendCD = nil
end

function slot0._switchTab(slot0, slot1, slot2)
	slot0._selectIndex = slot1

	SocialController.instance:dispatchEvent(SocialEvent.SubTabSwitch, slot1)
	gohelper.setActive(slot0._gorecommend, slot1 == 1)
	gohelper.setActive(slot0._gosearchresults, slot1 == 2)
	gohelper.setActive(slot0._btnreturn.gameObject, slot1 == 2)
	slot0:_refreshUI(slot2)
end

function slot0.onOpen(slot0)
	slot0._inputsearch:AddOnValueChanged(slot0._inputValueChanged, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.RecommendChanged, slot0._refreshUI, slot0)
	slot0:addEventCb(SocialController.instance, SocialEvent.SearchInfoChanged, slot0._refreshUI, slot0)

	if slot0._notFirst then
		slot0:_resetView()
	else
		slot0:_resetView(true)
	end

	slot0._notFirst = true
end

function slot0._resetView(slot0, slot1)
	slot0._searchValue = ""

	slot0._inputsearch:SetText(slot0._searchValue)
	slot0:_switchTab(1, slot1)

	if SocialEnum.SearchFriendCD < UnityEngine.Time.realtimeSinceStartup - SocialModel.instance.leftSendRecommendReqDt then
		SocialModel.instance:clearRecommendList()
		FriendRpc.instance:sendGetRecommendRequest()

		slot0._searchFriendCD = SocialEnum.SearchFriendCD

		TaskDispatcher.runDelay(slot0._onTimeEnd, slot0, slot0._searchFriendCD)
	end
end

function slot0._refreshUI(slot0, slot1)
	slot2 = SocialModel.instance:getRecommendCount()

	gohelper.setActive(slot0._gonorecommend, not slot1 and slot2 <= 0)
	gohelper.setActive(slot0._gohaverecommend, not slot1 and slot2 > 0)
	gohelper.setActive(slot0._gonosearch, not slot1 and SocialModel.instance:getSearchCount() <= 0)

	if slot0._selectIndex == 1 then
		slot0._scrollrecommend.verticalNormalizedPosition = 1
	elseif slot0._selectIndex == 2 then
		slot0._scrollsearch.verticalNormalizedPosition = 1
	end
end

function slot0.onClose(slot0)
	slot0._inputsearch:RemoveOnValueChanged()
	slot0:removeEventCb(SocialController.instance, SocialEvent.RecommendChanged, slot0._refreshUI, slot0)
	slot0:removeEventCb(SocialController.instance, SocialEvent.SearchInfoChanged, slot0._refreshUI, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onTimeEnd, slot0)
end

return slot0
