module("modules.logic.main.view.MainActivityCenterView", package.seeall)

local var_0_0 = class("MainActivityCenterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._itemGoParent = gohelper.findChild(arg_4_0.viewGO, "left/#go_activity")
	arg_4_0._itemGoParentTran = arg_4_0._itemGoParent.transform
	arg_4_0._itemGo = gohelper.findChild(arg_4_0.viewGO, "left/#go_activity/scroll_view/Viewport/Content/actcenteritem")
	arg_4_0._centerItems = arg_4_0:getUserDataTb_()
	arg_4_0._turnbackItems = arg_4_0:getUserDataTb_()
	arg_4_0._sortBtnList = arg_4_0:getUserDataTb_()
	arg_4_0._checkBtnList = arg_4_0:getUserDataTb_()
	arg_4_0._index2Id = {}
	arg_4_0._bpItem = nil
	arg_4_0._bpSpItem = nil
	arg_4_0._turnbackItem = nil
	arg_4_0._goactivity = gohelper.findChild(arg_4_0.viewGO, "left/#go_activity")
	arg_4_0._activityLogo = gohelper.findChild(arg_4_0.viewGO, "left/#go_activity/actlogo")
	arg_4_0._goactbg = gohelper.findChild(arg_4_0.viewGO, "left/#go_activity/scroll_view/#go_actbg")
	arg_4_0._goactbgTrans = arg_4_0._goactbg.transform
	arg_4_0._goactbgOffsetX = recthelper.getAnchorX(arg_4_0._goactbgTrans)

	local var_4_0 = gohelper.findChildClickWithAudio(arg_4_0.viewGO, "left/#go_activity/actlogo/click")

	if var_4_0 then
		arg_4_0._activityAnimator = arg_4_0._goactivity:GetComponent(gohelper.Type_Animator)

		arg_4_0:addClickCb(var_4_0, arg_4_0._logoClickHandler, arg_4_0)
	end

	arg_4_0._itemSize = 113
	arg_4_0._needCheckPosX = 610
	arg_4_0._needCheckArrowValue = 0.9
	arg_4_0._goactivityadapter = gohelper.findChild(arg_4_0.viewGO, "#go_activity_adapter")
	arg_4_0._scrollview = gohelper.findChildScrollRect(arg_4_0.viewGO, "left/#go_activity/scroll_view")
	arg_4_0._scrollcontent = gohelper.findChild(arg_4_0.viewGO, "left/#go_activity/scroll_view/Viewport/Content")
	arg_4_0._scrollarrow = gohelper.findChild(arg_4_0.viewGO, "left/#go_activity/arrow")
	arg_4_0._scrollarrowpos = gohelper.findChild(arg_4_0.viewGO, "left/#go_activity/scroll_view/arrow_pos")
	arg_4_0._scrollreddot = gohelper.findChild(arg_4_0._scrollarrow, "#go_reddot")
	arg_4_0._horizontal = arg_4_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))

	local var_4_1 = ActivityModel.showActivityEffect()

	arg_4_0._horizontal.spacing = var_4_1 and arg_4_0._horizontal.spacing or 0
	arg_4_0._horizontalLeft = arg_4_0._horizontal.padding.left
	arg_4_0._horizontalRight = arg_4_0._horizontal.padding.right

	arg_4_0._scrollview:AddOnValueChanged(arg_4_0._onContentScrollValueChanged, arg_4_0)
	arg_4_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenResize, arg_4_0)

	arg_4_0._btnarrow = gohelper.findChildClick(arg_4_0.viewGO, "left/#go_activity/arrow")

	arg_4_0._btnarrow:AddClickListener(arg_4_0._btnarrowOnClick, arg_4_0)
	gohelper.addUIClickAudio(arg_4_0._btnarrow.gameObject)
end

function var_0_0._logoClickHandler(arg_5_0)
	local var_5_0 = ActivityConfig.instance:getMainActAtmosphereConfig()

	if arg_5_0._clickLogoTime and var_5_0 and Time.time - arg_5_0._clickLogoTime < var_5_0.effectDuration then
		return
	end

	if arg_5_0._activityAnimator then
		arg_5_0._activityAnimator:Play("click", 0, 0)
	end

	arg_5_0._clickLogoTime = Time.time
end

function var_0_0._btnarrowOnClick(arg_6_0)
	arg_6_0._scrollview.horizontalNormalizedPosition = 1
end

function var_0_0._onScreenResize(arg_7_0)
	local var_7_0 = recthelper.getWidth(arg_7_0._goactivityadapter.transform)
	local var_7_1 = arg_7_0:_getContentItemNum() * arg_7_0._itemSize + arg_7_0._horizontalLeft + arg_7_0._horizontalRight

	if var_7_0 < var_7_1 then
		recthelper.setWidth(arg_7_0._scrollview.transform, var_7_0)
	else
		recthelper.setWidth(arg_7_0._scrollview.transform, var_7_1)
	end

	arg_7_0._scrollview.horizontalNormalizedPosition = 0
	arg_7_0._scrollarrow.transform.position = arg_7_0._scrollarrowpos.transform.position

	arg_7_0:_refreshActBgWidth()

	local var_7_2 = recthelper.rectToRelativeAnchorPos(arg_7_0._scrollarrowpos.transform.position, arg_7_0._scrollview.transform)

	arg_7_0._needCheckPosX = math.max(0, var_7_2.x - 32)
end

function var_0_0._getViewShowNum(arg_8_0)
	local var_8_0 = (recthelper.getWidth(arg_8_0._scrollview.transform) - arg_8_0._horizontalLeft - arg_8_0._horizontalRight) / arg_8_0._itemSize

	return (math.floor(var_8_0))
end

function var_0_0._getContentItemNum(arg_9_0)
	local var_9_0 = 0
	local var_9_1 = arg_9_0._scrollcontent.transform
	local var_9_2 = var_9_1.childCount

	for iter_9_0 = 0, var_9_2 - 1 do
		if var_9_1:GetChild(iter_9_0).gameObject.activeSelf then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function var_0_0._onContentScrollValueChanged(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 < arg_10_0._needCheckArrowValue

	if var_10_0 and recthelper.getWidth(arg_10_0._scrollview.transform) >= recthelper.getWidth(arg_10_0._scrollcontent.transform) then
		var_10_0 = false
	end

	gohelper.setActive(arg_10_0._scrollarrow, var_10_0)
	gohelper.setActive(arg_10_0._scrollreddot, false)

	if not var_10_0 then
		return
	end

	local var_10_1 = arg_10_0._index2Id or {}

	for iter_10_0 = #var_10_1, 1, -1 do
		local var_10_2 = var_10_1[iter_10_0]
		local var_10_3 = arg_10_0._sortBtnList[var_10_2]

		if var_10_3:isShowRedDot() then
			local var_10_4 = var_10_3.go

			if not gohelper.isNil(var_10_4) and recthelper.rectToRelativeAnchorPos(var_10_4.transform.position, arg_10_0._scrollview.transform).x >= arg_10_0._needCheckPosX then
				gohelper.setActive(arg_10_0._scrollreddot, true)

				break
			end
		end
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_12_0._freshBtns, arg_12_0)
	arg_12_0:addEventCb(BpController.instance, BpEvent.OnGetInfo, arg_12_0._freshBtns, arg_12_0)
	arg_12_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_12_0._freshBtns, arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_12_0._onCloseFullView, arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_12_0._onCloseView, arg_12_0)
	arg_12_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_12_0._freshBtns, arg_12_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_12_0._onDailyRefresh, arg_12_0)
	arg_12_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_12_0._refreshNorSignActivity, arg_12_0, LuaEventSystem.Low)
	arg_12_0:addEventCb(Activity160Controller.instance, Activity160Event.InfoUpdate, arg_12_0._freshBtns, arg_12_0)
	arg_12_0:_freshBtns()
end

function var_0_0._onCloseFullView(arg_13_0, arg_13_1)
	if not ViewMgr.instance:hasOpenFullView() then
		arg_13_0:_freshBtns()
	end
end

function var_0_0._onCloseView(arg_14_0, arg_14_1)
	arg_14_0._scrollview.horizontalNormalizedPosition = 0

	if arg_14_1 == ViewName.ActivityBeginnerView then
		arg_14_0:_freshBtns()
	end
end

function var_0_0._freshBtns(arg_15_0)
	arg_15_0:_checkBpBtn()
	arg_15_0:_refreshActCenter()
	arg_15_0:_checkTestTaskBtn()
	arg_15_0:_checkTurnbackBtn()
	arg_15_0:_checkRoleSignViewBtn()
	arg_15_0:_checkSpringSignViewBtn()
	arg_15_0:_checkActivity186Btn()
	arg_15_0:_checkActivityImgVisible()
	arg_15_0:_sortBtns()
end

function var_0_0._checkActivityImgVisible(arg_16_0)
	local var_16_0 = ActivityModel.showActivityEffect()
	local var_16_1 = var_16_0 and ActivityModel.checkIsShowLogoVisible()
	local var_16_2 = var_16_0 and ActivityModel.checkIsShowActBgVisible()

	gohelper.setActive(arg_16_0._activityLogo, var_16_1)
	gohelper.setActive(arg_16_0._goactbg, var_16_2)

	local var_16_3 = ActivityConfig.instance:getMainActAtmosphereConfig()

	if var_16_3 then
		for iter_16_0, iter_16_1 in ipairs(var_16_3.mainView) do
			local var_16_4 = gohelper.findChild(arg_16_0.viewGO, iter_16_1)

			if var_16_4 then
				gohelper.setActive(var_16_4, var_16_0)
			end
		end
	end
end

function var_0_0._refreshNorSignActivity(arg_17_0)
	arg_17_0:_sortBtns()
	arg_17_0:_onContentScrollValueChanged(arg_17_0._scrollview.horizontalNormalizedPosition)
end

function var_0_0._addSortBtn(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._sortBtnList[arg_18_1] = arg_18_2
end

function var_0_0._sortBtns(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(arg_19_0._sortBtnList) do
		if iter_19_0 ~= ActivityEnum.MainActivityCenterViewClientId.Bp and iter_19_0 ~= ActivityEnum.MainActivityCenterViewClientId.BpSP then
			table.insert(var_19_0, iter_19_0)
		end
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_19_0._sortBtnList[arg_20_0]
		local var_20_1 = arg_19_0._sortBtnList[arg_20_1]
		local var_20_2 = var_20_0:isShowRedDot() and 1 or 0
		local var_20_3 = var_20_1:isShowRedDot() and 1 or 0

		if var_20_2 ~= var_20_3 then
			return var_20_3 < var_20_2
		end

		return (ActivityEnum.ActivitySortWeight[arg_20_0] or 100) < (ActivityEnum.ActivitySortWeight[arg_20_1] or 100)
	end)

	arg_19_0._index2Id = var_19_0

	for iter_19_2, iter_19_3 in ipairs(var_19_0) do
		gohelper.setAsLastSibling(arg_19_0._sortBtnList[iter_19_3].go)
	end

	for iter_19_4, iter_19_5 in ipairs(arg_19_0._centerItems) do
		gohelper.setSibling(iter_19_5.go, 0)
	end

	if arg_19_0._bpSpItem then
		gohelper.setSibling(arg_19_0._bpSpItem.go, 0)
	end

	if arg_19_0._bpItem then
		gohelper.setSibling(arg_19_0._bpItem.go, 0)
	end

	if arg_19_0._act186Item then
		gohelper.setSibling(arg_19_0._act186Item.go, 2)
	end

	for iter_19_6, iter_19_7 in pairs(arg_19_0._checkBtnList) do
		rawset(arg_19_0._checkBtnList, iter_19_6, nil)
	end

	local var_19_1 = arg_19_0:_getContentItemNum()
	local var_19_2 = var_19_1 - arg_19_0:_getViewShowNum()

	if var_19_2 > 0 then
		for iter_19_8 = #var_19_0, 1, -1 do
			table.insert(arg_19_0._checkBtnList, arg_19_0._sortBtnList[var_19_0[iter_19_8]])

			if var_19_2 <= #arg_19_0._checkBtnList then
				break
			end
		end
	end

	if arg_19_0._contentItemNum ~= var_19_1 then
		arg_19_0._contentItemNum = var_19_1

		arg_19_0:_onScreenResize()
	end

	arg_19_0._scrollview.horizontalNormalizedPosition = 0

	arg_19_0:_refreshActBgWidth()
end

function var_0_0._checkBpBtn(arg_21_0)
	if BpModel.instance:isEnd() then
		GameUtil.onDestroyViewMember(arg_21_0, "_bpItem")
		GameUtil.onDestroyViewMember(arg_21_0, "_bpSpItem")

		return
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BP) or arg_21_0._bpItem then
		return
	end

	arg_21_0._bpItem = BpMainBtnItem.New()

	arg_21_0._bpItem:init(arg_21_0._itemGo)
	arg_21_0:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.Bp, arg_21_0._bpItem)

	local var_21_0 = BpConfig.instance:getBpCO(BpModel.instance.id)

	if var_21_0 and var_21_0.isSp then
		if ActivityHelper.getActivityStatus(VersionActivity2_2Enum.ActivityId.BPSP, true) ~= ActivityEnum.ActivityStatus.Normal then
			return
		end

		arg_21_0._bpSpItem = BpSPMainBtnItem.New()

		arg_21_0._bpSpItem:init(arg_21_0._itemGo)
		arg_21_0:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.BpSP, arg_21_0._bpSpItem)
	end
end

function var_0_0._refreshActCenter(arg_22_0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Activity) then
		return
	end

	GameUtil.onDestroyViewMemberList(arg_22_0, "_centerItems")

	local var_22_0 = ActivityModel.instance:getActivityCenter()

	arg_22_0._centerItems = arg_22_0:getUserDataTb_()

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		if iter_22_0 == ActivityEnum.ActivityType.Beginner then
			ActivityModel.instance:removeFinishedCategory(iter_22_1)
			ActivityModel.instance:removeUnExitAct(iter_22_1)
		elseif iter_22_0 == ActivityEnum.ActivityType.Welfare then
			ActivityModel.instance:removeFinishedWelfare(iter_22_1)
			ActivityModel.instance:removeUnExitAct(iter_22_1)
		end

		if GameUtil.getTabLen(iter_22_1) ~= 0 then
			local var_22_1 = ActivityMainBtnItem.New()

			var_22_1:init(iter_22_0, arg_22_0._itemGo)
			table.insert(arg_22_0._centerItems, var_22_1)
		end
	end

	table.sort(arg_22_0._centerItems, function(arg_23_0, arg_23_1)
		return arg_23_0:getSortPriority() > arg_23_1:getSortPriority()
	end)
end

function var_0_0._checkTurnbackBtn(arg_24_0)
	if not TurnbackModel.instance:isInOpenTime() or not TurnbackModel.instance:getCurTurnbackMo() then
		GameUtil.onDestroyViewMember(arg_24_0, "_turnbackItem")

		return
	end

	if arg_24_0._turnbackItem then
		arg_24_0._turnbackItem:_refreshItem()

		return
	end

	arg_24_0._turnbackItem = TurnbackMainBtnItem.New()

	arg_24_0._turnbackItem:init(arg_24_0._itemGo, TurnbackModel.instance:getCurTurnbackId())
	arg_24_0:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.TurnBack, arg_24_0._turnbackItem)
end

function var_0_0._checkTestTaskBtn(arg_25_0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.TestTask) then
		GameUtil.onDestroyViewMember(arg_25_0, "_testTaskItem")

		return
	end

	if arg_25_0._testTaskItem then
		arg_25_0._testTaskItem:_refreshItem()

		return
	end

	arg_25_0._testTaskItem = TestTaskMainBtnItem.New()

	arg_25_0._testTaskItem:init(arg_25_0._itemGo)
	arg_25_0:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.TestTask, arg_25_0._testTaskItem)
end

function var_0_0._checkSelfSelectCharacterBtn(arg_26_0)
	if not Activity136Model.instance:isActivity136InOpen() then
		GameUtil.onDestroyViewMember(arg_26_0, "_selfSelectCharacterBtn")

		return
	end

	if arg_26_0._selfSelectCharacterBtn then
		arg_26_0._selfSelectCharacterBtn:refresh()
	else
		local var_26_0 = gohelper.cloneInPlace(arg_26_0._itemGo)

		arg_26_0._selfSelectCharacterBtn = MonoHelper.addNoUpdateLuaComOnceToGo(var_26_0, Activity136MainBtnItem)

		arg_26_0:_addSortBtn(Activity136Model.instance:getCurActivity136Id(), arg_26_0._selfSelectCharacterBtn)
	end
end

local var_0_1 = {
	ActivityEnum.Activity.RoleSignViewPart1_1_6,
	ActivityEnum.Activity.RoleSignViewPart2_1_6
}

function var_0_0._checkRoleSignViewBtn(arg_27_0)
	local var_27_0 = {
		ViewName.V1a6_Role_PanelSignView_Part1,
		ViewName.V1a6_Role_PanelSignView_Part2
	}
	local var_27_1 = false
	local var_27_2
	local var_27_3

	for iter_27_0, iter_27_1 in ipairs(var_0_1) do
		if ActivityType101Model.instance:isOpen(iter_27_1) then
			var_27_1 = true
			var_27_2 = iter_27_1
			var_27_3 = var_27_0[iter_27_0]

			break
		end
	end

	if not var_27_1 then
		GameUtil.onDestroyViewMember(arg_27_0, "_roleSignViewBtn")

		return
	end

	local var_27_4 = {
		viewName = var_27_3,
		viewParam = {
			actId = var_27_2
		}
	}

	if arg_27_0._roleSignViewBtn then
		arg_27_0._roleSignViewBtn:setCustomData(var_27_4)
		arg_27_0._roleSignViewBtn:refresh()

		return
	end

	arg_27_0._roleSignViewBtn = arg_27_0:_createActCenterItem(V1a6_Role_PanelSignView_ActCenterItemBtn)

	arg_27_0._roleSignViewBtn:setCustomData(var_27_4)
	arg_27_0._roleSignViewBtn:refresh()
	arg_27_0:_addSortBtn(var_27_2, arg_27_0._roleSignViewBtn)
end

function var_0_0._checkGoldenMilletPresentBtn(arg_28_0)
	if GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen() then
		if not arg_28_0._goldenMilletPresentBtn then
			arg_28_0._goldenMilletPresentBtn = arg_28_0:_createActCenterItem(GoldenMilletPresentMainBtnItem)

			arg_28_0:_addSortBtn(GoldenMilletPresentModel.instance:getGoldenMilletPresentActId(), arg_28_0._goldenMilletPresentBtn)
		end

		arg_28_0._goldenMilletPresentBtn:refreshRedDot()
	elseif arg_28_0._goldenMilletPresentBtn then
		arg_28_0._goldenMilletPresentBtn:destroy()

		arg_28_0._goldenMilletPresentBtn = nil
	end
end

function var_0_0._checkSpringSignViewBtn(arg_29_0)
	local var_29_0 = ActivityEnum.Activity.SpringSign
	local var_29_1 = ViewName.V1a6_Spring_PanelSignView

	if not ActivityType101Model.instance:isOpen(var_29_0) then
		GameUtil.onDestroyViewMember(arg_29_0, "_springSignViewBtn")

		return
	end

	local var_29_2 = {
		viewName = var_29_1,
		viewParam = {
			actId = var_29_0
		}
	}

	if arg_29_0._springSignViewBtn then
		arg_29_0._springSignViewBtn:setCustomData(var_29_2)
		arg_29_0._springSignViewBtn:refresh()

		return
	end

	arg_29_0._springSignViewBtn = arg_29_0:_createActCenterItem(ActCenterItem_SpringSignViewBtn_1_6)

	arg_29_0._springSignViewBtn:setCustomData(var_29_2)
	arg_29_0._springSignViewBtn:refresh()
	arg_29_0:_addSortBtn(var_29_0, arg_29_0._springSignViewBtn)
end

function var_0_0._checkActivity186Btn(arg_30_0)
	if not Activity186Model.instance:isActivityOnline() then
		GameUtil.onDestroyViewMember(arg_30_0, "_act186Item")

		return
	end

	if not arg_30_0._act186Item then
		local var_30_0 = gohelper.cloneInPlace(arg_30_0._itemGo)

		arg_30_0._act186Item = MonoHelper.addNoUpdateLuaComOnceToGo(var_30_0, Activity186MainBtnItem)

		arg_30_0:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.Act186, arg_30_0._act186Item)
	end

	arg_30_0._act186Item:refresh()
end

function var_0_0._createActCenterItem(arg_31_0, arg_31_1)
	local var_31_0 = gohelper.cloneInPlace(arg_31_0._itemGo)

	arg_31_0:_refreshActBgWidth()

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_31_0, arg_31_1)
end

function var_0_0.onClose(arg_32_0)
	arg_32_0._scrollview:RemoveOnValueChanged()
	arg_32_0._btnarrow:RemoveClickListener()
end

function var_0_0.onDestroyView(arg_33_0)
	GameUtil.onDestroyViewMemberList(arg_33_0, "_centerItems")
	GameUtil.onDestroyViewMember(arg_33_0, "_bpItem")
	GameUtil.onDestroyViewMember(arg_33_0, "_bpSpItem")
	GameUtil.onDestroyViewMember(arg_33_0, "_testTaskItem")
	GameUtil.onDestroyViewMember(arg_33_0, "_turnbackItem")
	GameUtil.onDestroyViewMember(arg_33_0, "_selfSelectCharacterBtn")
	GameUtil.onDestroyViewMember(arg_33_0, "_act186Item")
	GameUtil.onDestroyViewMember(arg_33_0, "_roleSignViewBtn")
	GameUtil.onDestroyViewMember(arg_33_0, "_springSignViewBtn")
	arg_33_0:removeEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_33_0._freshBtns, arg_33_0)
	arg_33_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_33_0._onCloseFullView, arg_33_0)
	arg_33_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_33_0._freshBtns, arg_33_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_33_0._onDailyRefresh, arg_33_0)
end

function var_0_0._updateRoleSignViewBtn(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs(var_0_1) do
		if ActivityType101Model.instance:isOpen(iter_34_1) then
			Activity101Rpc.instance:sendGet101InfosRequest(iter_34_1)
		end
	end
end

function var_0_0._updateSpringSignViewBtn(arg_35_0)
	local var_35_0 = ActivityEnum.Activity.SpringSign

	if ActivityType101Model.instance:isOpen(var_35_0) then
		Activity101Rpc.instance:sendGet101InfosRequest(var_35_0)
	end
end

function var_0_0._onDailyRefresh(arg_36_0)
	arg_36_0:_freshBtns()
	arg_36_0:_updateRoleSignViewBtn()
	arg_36_0:_updateSpringSignViewBtn()
end

local var_0_2 = 840.4

function var_0_0._refreshActBgWidth(arg_37_0)
	local var_37_0 = ActivityModel.checkIsShowLogoVisible()
	local var_37_1 = 0

	if arg_37_0._sortBtnList then
		for iter_37_0, iter_37_1 in pairs(arg_37_0._sortBtnList) do
			var_37_1 = var_37_1 + 1
		end
	end

	if arg_37_0._centerItems then
		var_37_1 = var_37_1 + #arg_37_0._centerItems
	end

	local var_37_2 = arg_37_0._horizontal.spacing
	local var_37_3 = (var_37_1 - 1) * var_37_2
	local var_37_4 = var_37_1 * arg_37_0._itemSize + arg_37_0._horizontalLeft
	local var_37_5 = 0

	if not var_37_0 then
		var_37_5 = -math.min(0, arg_37_0._goactbgOffsetX) * 2
	end

	local var_37_6 = var_37_4 + var_37_5

	recthelper.setWidth(arg_37_0._goactbgTrans, GameUtil.clamp(var_37_6, 0, var_0_2))
end

return var_0_0
