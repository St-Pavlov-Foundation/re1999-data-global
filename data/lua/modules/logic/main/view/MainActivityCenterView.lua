module("modules.logic.main.view.MainActivityCenterView", package.seeall)

slot0 = class("MainActivityCenterView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._itemGoParent = gohelper.findChild(slot0.viewGO, "left/#go_activity")
	slot0._itemGoParentTran = slot0._itemGoParent.transform
	slot0._itemGo = gohelper.findChild(slot0.viewGO, "left/#go_activity/scroll_view/Viewport/Content/actcenteritem")
	slot0._centerItems = slot0:getUserDataTb_()
	slot0._turnbackItems = slot0:getUserDataTb_()
	slot0._sortBtnList = slot0:getUserDataTb_()
	slot0._checkBtnList = slot0:getUserDataTb_()
	slot0._index2Id = {}
	slot0._bpItem = nil
	slot0._bpSpItem = nil
	slot0._turnbackItem = nil
	slot0._activityImg = gohelper.findChildImage(slot0.viewGO, "left/#go_activity")
	slot0._activityLogo = gohelper.findChild(slot0.viewGO, "left/#go_activity/actlogo")

	if gohelper.findChildClickWithAudio(slot0.viewGO, "left/#go_activity/actlogo/click") then
		slot0._activityAnimator = slot0._activityImg:GetComponent("Animator")

		slot0:addClickCb(slot1, slot0._logoClickHandler, slot0)
	end

	slot0._itemSize = 113
	slot0._needCheckPosX = 610
	slot0._needCheckArrowValue = 0.9
	slot0._goactivityadapter = gohelper.findChild(slot0.viewGO, "#go_activity_adapter")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "left/#go_activity/scroll_view")
	slot0._scrollcontent = gohelper.findChild(slot0.viewGO, "left/#go_activity/scroll_view/Viewport/Content")
	slot0._scrollarrow = gohelper.findChild(slot0.viewGO, "left/#go_activity/arrow")
	slot0._scrollarrowpos = gohelper.findChild(slot0.viewGO, "left/#go_activity/scroll_view/arrow_pos")
	slot0._scrollreddot = gohelper.findChild(slot0._scrollarrow, "#go_reddot")
	slot0._horizontal = slot0._scrollcontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	slot0._horizontalLeft = slot0._horizontal.padding.left
	slot0._horizontalRight = slot0._horizontal.padding.right

	slot0._scrollview:AddOnValueChanged(slot0._onContentScrollValueChanged, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)

	slot0._btnarrow = gohelper.findChildClick(slot0.viewGO, "left/#go_activity/arrow")

	slot0._btnarrow:AddClickListener(slot0._btnarrowOnClick, slot0)
	gohelper.addUIClickAudio(slot0._btnarrow.gameObject)
end

function slot0._logoClickHandler(slot0)
	slot1 = ActivityConfig.instance:getMainActAtmosphereConfig()

	if slot0._clickLogoTime and slot1 and Time.time - slot0._clickLogoTime < slot1.effectDuration then
		return
	end

	if slot0._activityAnimator then
		slot0._activityAnimator:Play("click", 0, 0)
	end

	slot0._clickLogoTime = Time.time
end

function slot0._btnarrowOnClick(slot0)
	slot0._scrollview.horizontalNormalizedPosition = 1
end

function slot0._onScreenResize(slot0)
	if recthelper.getWidth(slot0._goactivityadapter.transform) < slot0:_getContentItemNum() * slot0._itemSize + slot0._horizontalLeft + slot0._horizontalRight then
		recthelper.setWidth(slot0._scrollview.transform, slot1)
	else
		recthelper.setWidth(slot0._scrollview.transform, slot3)
	end

	slot0._scrollview.horizontalNormalizedPosition = 0
	slot0._scrollarrow.transform.position = slot0._scrollarrowpos.transform.position
	slot0._needCheckPosX = math.max(0, recthelper.rectToRelativeAnchorPos(slot0._scrollarrowpos.transform.position, slot0._scrollview.transform).x - 32)
end

function slot0._getViewShowNum(slot0)
	return math.floor((recthelper.getWidth(slot0._scrollview.transform) - slot0._horizontalLeft - slot0._horizontalRight) / slot0._itemSize)
end

function slot0._getContentItemNum(slot0)
	for slot7 = 0, slot0._scrollcontent.transform.childCount - 1 do
		if slot2:GetChild(slot7).gameObject.activeSelf then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0._onContentScrollValueChanged(slot0, slot1)
	if slot1 < slot0._needCheckArrowValue and recthelper.getWidth(slot0._scrollcontent.transform) <= recthelper.getWidth(slot0._scrollview.transform) then
		slot2 = false
	end

	gohelper.setActive(slot0._scrollarrow, slot2)
	gohelper.setActive(slot0._scrollreddot, false)

	if not slot2 then
		return
	end

	slot3 = slot0._index2Id or {}

	for slot7 = #slot3, 1, -1 do
		if slot0._sortBtnList[slot3[slot7]]:isShowRedDot() and not gohelper.isNil(slot9.go) and slot0._needCheckPosX <= recthelper.rectToRelativeAnchorPos(slot10.transform.position, slot0._scrollview.transform).x then
			gohelper.setActive(slot0._scrollreddot, true)

			break
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0._freshBtns, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.OnGetInfo, slot0._freshBtns, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._freshBtns, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._freshBtns, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0._refreshNorSignActivity, slot0, LuaEventSystem.Low)
	slot0:addEventCb(Activity160Controller.instance, Activity160Event.InfoUpdate, slot0._freshBtns, slot0)
	slot0:_freshBtns()
end

function slot0._onCloseFullView(slot0, slot1)
	if not ViewMgr.instance:hasOpenFullView() then
		slot0:_freshBtns()
	end
end

function slot0._onCloseView(slot0, slot1)
	slot0._scrollview.horizontalNormalizedPosition = 0

	if slot1 == ViewName.ActivityBeginnerView then
		slot0:_freshBtns()
	end
end

function slot0._freshBtns(slot0)
	slot0:_checkBpBtn()
	slot0:_refreshActCenter()
	slot0:_checkTestTaskBtn()
	slot0:_checkTurnbackBtn()
	slot0:_checkRoleSignViewBtn()
	slot0:_checkGoldenMilletPresentBtn()
	slot0:_checkSpringSignViewBtn()
	slot0:_checkActivityImgVisible()
	slot0:_sortBtns()
end

function slot0.showActivityEffect()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FastDungeon) then
		return false
	end

	if not DungeonModel.instance:hasPassLevelAndStory(ActivityEnum.ShowVersionActivityEpisode) then
		return false
	end

	if not ActivityConfig.instance:getMainActAtmosphereConfig() then
		return false
	end

	if ActivityHelper.getActivityStatus(slot1.id) == ActivityEnum.ActivityStatus.Normal or slot3 == ActivityEnum.ActivityStatus.NotUnlock then
		return true
	end

	return false
end

function slot0._checkActivityImgVisible(slot0)
	slot2 = uv0.showActivityEffect()

	if slot0._activityImg then
		slot0._activityImg.enabled = slot2
	end

	gohelper.setActive(slot0._activityLogo, slot2)

	if ActivityConfig.instance:getMainActAtmosphereConfig() then
		for slot7, slot8 in ipairs(slot3.mainView) do
			if gohelper.findChild(slot0.viewGO, slot8) then
				gohelper.setActive(slot9, slot1)
			end
		end
	end
end

function slot0._refreshNorSignActivity(slot0)
	slot0:_sortBtns()
	slot0:_onContentScrollValueChanged(slot0._scrollview.horizontalNormalizedPosition)
end

function slot0._addSortBtn(slot0, slot1, slot2)
	slot0._sortBtnList[slot1] = slot2
end

function slot0._sortBtns(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._sortBtnList) do
		if slot5 ~= ActivityEnum.MainActivityCenterViewClientId.Bp and slot5 ~= ActivityEnum.MainActivityCenterViewClientId.BpSP then
			table.insert(slot1, slot5)
		end
	end

	function slot5(slot0, slot1)
		if (uv0._sortBtnList[slot0]:isShowRedDot() and 1 or 0) ~= (uv0._sortBtnList[slot1]:isShowRedDot() and 1 or 0) then
			return slot5 < slot4
		end

		return (ActivityEnum.ActivitySortWeight[slot0] or 100) < (ActivityEnum.ActivitySortWeight[slot1] or 100)
	end

	table.sort(slot1, slot5)

	slot0._index2Id = slot1

	for slot5, slot6 in ipairs(slot1) do
		gohelper.setAsLastSibling(slot0._sortBtnList[slot6].go)
	end

	for slot5, slot6 in ipairs(slot0._centerItems) do
		gohelper.setSibling(slot6.go, 0)
	end

	if slot0._bpSpItem then
		gohelper.setSibling(slot0._bpSpItem.go, 0)
	end

	if slot0._bpItem then
		gohelper.setSibling(slot0._bpItem.go, 0)
	end

	for slot5, slot6 in pairs(slot0._checkBtnList) do
		rawset(slot0._checkBtnList, slot5, nil)
	end

	if slot0:_getContentItemNum() - slot0:_getViewShowNum() > 0 then
		for slot8 = #slot1, 1, -1 do
			table.insert(slot0._checkBtnList, slot0._sortBtnList[slot1[slot8]])

			if slot4 <= #slot0._checkBtnList then
				break
			end
		end
	end

	if slot0._contentItemNum ~= slot2 then
		slot0._contentItemNum = slot2

		slot0:_onScreenResize()
	end

	slot0._scrollview.horizontalNormalizedPosition = 0
end

function slot0._checkBpBtn(slot0)
	if BpModel.instance:isEnd() then
		if slot0._bpItem then
			slot0._bpItem:destroy()

			slot0._bpItem = nil
		end

		if slot0._bpSpItem then
			slot0._bpSpItem:destroy()

			slot0._bpSpItem = nil
		end

		return
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BP) or slot0._bpItem then
		return
	end

	slot0._bpItem = BpMainBtnItem.New()

	slot0._bpItem:init(slot0._itemGo)
	slot0:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.Bp, slot0._bpItem)

	if BpConfig.instance:getBpCO(BpModel.instance.id) and slot1.isSp then
		if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.BPSP, true) ~= ActivityEnum.ActivityStatus.Normal then
			return
		end

		slot0._bpSpItem = BpSPMainBtnItem.New()

		slot0._bpSpItem:init(slot0._itemGo)
		slot0:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.BpSP, slot0._bpSpItem)
	end
end

function slot0._refreshActCenter(slot0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Activity) then
		return
	end

	slot1 = ActivityModel.instance:getActivityCenter()

	for slot5, slot6 in pairs(slot0._centerItems) do
		slot6:destroy()
	end

	slot0._centerItems = slot0:getUserDataTb_()

	for slot5, slot6 in pairs(slot1) do
		if slot5 == ActivityEnum.ActivityType.Beginner then
			ActivityModel.instance:removeFinishedCategory(slot6)
			ActivityModel.instance:removeUnExitAct(slot6)
		elseif slot5 == ActivityEnum.ActivityType.Welfare then
			ActivityModel.instance:removeFinishedWelfare(slot6)
			ActivityModel.instance:removeUnExitAct(slot6)
		end

		if GameUtil.getTabLen(slot6) ~= 0 then
			slot7 = ActivityMainBtnItem.New()

			slot7:init(slot5, slot0._itemGo)
			table.insert(slot0._centerItems, slot7)
		end
	end

	table.sort(slot0._centerItems, function (slot0, slot1)
		return slot1:getSortPriority() < slot0:getSortPriority()
	end)
end

function slot0._checkTurnbackBtn(slot0)
	if not TurnbackModel.instance:isInOpenTime() or not TurnbackModel.instance:getCurTurnbackMo() then
		if slot0._turnbackItem then
			slot0._turnbackItem:destroy()

			slot0._turnbackItem = nil
		end

		return
	end

	if slot0._turnbackItem then
		slot0._turnbackItem:_refreshItem()

		return
	end

	slot0._turnbackItem = TurnbackMainBtnItem.New()

	slot0._turnbackItem:init(slot0._itemGo, TurnbackModel.instance:getCurTurnbackId())
	slot0:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.TurnBack, slot0._turnbackItem)
end

function slot0._checkTestTaskBtn(slot0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.TestTask) then
		if slot0._testTaskItem then
			slot0._testTaskItem:destroy()

			slot0._testTaskItem = nil
		end

		return
	end

	if slot0._testTaskItem then
		slot0._testTaskItem:_refreshItem()

		return
	end

	slot0._testTaskItem = TestTaskMainBtnItem.New()

	slot0._testTaskItem:init(slot0._itemGo)
	slot0:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.TestTask, slot0._testTaskItem)
end

function slot0._checkSelfSelectCharacterBtn(slot0)
	if Activity136Model.instance:isActivity136InOpen() then
		if slot0._selfSelectCharacterBtn then
			slot0._selfSelectCharacterBtn:refreshRedDot()
		else
			slot0._selfSelectCharacterBtn = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._itemGo), Activity136MainBtnItem)

			slot0:_addSortBtn(Activity136Model.instance:getCurActivity136Id(), slot0._selfSelectCharacterBtn)
		end
	elseif slot0._selfSelectCharacterBtn then
		slot0._selfSelectCharacterBtn:destroy()

		slot0._selfSelectCharacterBtn = nil
	end
end

slot1 = {
	ActivityEnum.Activity.RoleSignViewPart1_1_6,
	ActivityEnum.Activity.RoleSignViewPart2_1_6
}

function slot0._checkRoleSignViewBtn(slot0)
	slot2 = false
	slot3, slot4 = nil

	for slot8, slot9 in ipairs(uv0) do
		if ActivityType101Model.instance:isOpen(slot9) then
			slot2 = true
			slot3 = slot9
			slot4 = ({
				ViewName.V1a6_Role_PanelSignView_Part1,
				ViewName.V1a6_Role_PanelSignView_Part2
			})[slot8]

			break
		end
	end

	if not slot2 then
		GameUtil.onDestroyViewMember(slot0, "_roleSignViewBtn")

		return
	end

	slot5 = {
		viewName = slot4,
		viewParam = {
			actId = slot3
		}
	}

	if slot0._roleSignViewBtn then
		slot0._roleSignViewBtn:setCustomData(slot5)
		slot0._roleSignViewBtn:refresh()

		return
	end

	slot0._roleSignViewBtn = slot0:_createActCenterItem(V1a6_Role_PanelSignView_ActCenterItemBtn)

	slot0._roleSignViewBtn:setCustomData(slot5)
	slot0._roleSignViewBtn:refresh()
	slot0:_addSortBtn(slot3, slot0._roleSignViewBtn)
end

function slot0._checkGoldenMilletPresentBtn(slot0)
	if GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen() then
		if not slot0._goldenMilletPresentBtn then
			slot0._goldenMilletPresentBtn = slot0:_createActCenterItem(GoldenMilletPresentMainBtnItem)

			slot0:_addSortBtn(GoldenMilletPresentModel.instance:getGoldenMilletPresentActId(), slot0._goldenMilletPresentBtn)
		end

		slot0._goldenMilletPresentBtn:refreshRedDot()
	elseif slot0._goldenMilletPresentBtn then
		slot0._goldenMilletPresentBtn:destroy()

		slot0._goldenMilletPresentBtn = nil
	end
end

function slot0._checkSpringSignViewBtn(slot0)
	slot2 = ViewName.V1a6_Spring_PanelSignView

	if not ActivityType101Model.instance:isOpen(ActivityEnum.Activity.SpringSign) then
		GameUtil.onDestroyViewMember(slot0, "_springSignViewBtn")

		return
	end

	slot4 = {
		viewName = slot2,
		viewParam = {
			actId = slot1
		}
	}

	if slot0._springSignViewBtn then
		slot0._springSignViewBtn:setCustomData(slot4)
		slot0._springSignViewBtn:refresh()

		return
	end

	slot0._springSignViewBtn = slot0:_createActCenterItem(ActCenterItem_SpringSignViewBtn_1_6)

	slot0._springSignViewBtn:setCustomData(slot4)
	slot0._springSignViewBtn:refresh()
	slot0:_addSortBtn(slot1, slot0._springSignViewBtn)
end

function slot0._createActCenterItem(slot0, slot1)
	return MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._itemGo), slot1)
end

function slot0.onClose(slot0)
	slot0._scrollview:RemoveOnValueChanged()
	slot0._btnarrow:RemoveClickListener()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._centerItems) do
		slot5:destroy()
	end

	if slot0._bpItem then
		slot0._bpItem:destroy()

		slot0._bpItem = nil
	end

	if slot0._bpSpItem then
		slot0._bpSpItem:destroy()

		slot0._bpSpItem = nil
	end

	if slot0._testTaskItem then
		slot0._testTaskItem:destroy()

		slot0._testTaskItem = nil
	end

	if slot0._turnbackItem then
		slot0._turnbackItem:destroy()

		slot0._turnbackItem = nil
	end

	if slot0._selfSelectCharacterBtn then
		slot0._selfSelectCharacterBtn:destroy()

		slot0._selfSelectCharacterBtn = nil
	end

	GameUtil.onDestroyViewMember(slot0, "_roleSignViewBtn")
	GameUtil.onDestroyViewMember(slot0, "_springSignViewBtn")
	slot0:removeEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0._freshBtns, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._freshBtns, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0._updateRoleSignViewBtn(slot0)
	for slot4, slot5 in ipairs(uv0) do
		if ActivityType101Model.instance:isOpen(slot5) then
			Activity101Rpc.instance:sendGet101InfosRequest(slot5)
		end
	end
end

function slot0._updateSpringSignViewBtn(slot0)
	if ActivityType101Model.instance:isOpen(ActivityEnum.Activity.SpringSign) then
		Activity101Rpc.instance:sendGet101InfosRequest(slot1)
	end
end

function slot0._onDailyRefresh(slot0)
	slot0:_freshBtns()
	slot0:_updateRoleSignViewBtn()
	slot0:_updateSpringSignViewBtn()
end

return slot0
