-- chunkname: @modules/logic/main/view/MainActivityCenterView.lua

module("modules.logic.main.view.MainActivityCenterView", package.seeall)

local MainActivityCenterView = class("MainActivityCenterView", BaseView)

function MainActivityCenterView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainActivityCenterView:addEvents()
	return
end

function MainActivityCenterView:removeEvents()
	return
end

function MainActivityCenterView:_editableInitView()
	self._itemGoParent = gohelper.findChild(self.viewGO, "left/#go_activity")
	self._itemGoParentTran = self._itemGoParent.transform
	self._itemGo = gohelper.findChild(self.viewGO, "left/#go_activity/scroll_view/Viewport/Content/actcenteritem")

	gohelper.setActive(self._itemGo, false)

	self._centerItems = self:getUserDataTb_()
	self._turnbackItems = self:getUserDataTb_()
	self._sortBtnList = self:getUserDataTb_()
	self._checkBtnList = self:getUserDataTb_()
	self._index2Id = {}
	self._bpItem = nil
	self._bpSpItem = nil
	self._turnbackItem = nil
	self._goactivity = gohelper.findChild(self.viewGO, "left/#go_activity")
	self._activityLogo = gohelper.findChild(self.viewGO, "left/#go_activity/actlogo")
	self._goactbg = gohelper.findChild(self.viewGO, "left/#go_activity/scroll_view/#go_actbg")
	self._goactbgTrans = self._goactbg.transform
	self._goactbgOffsetX = recthelper.getAnchorX(self._goactbgTrans)

	local logoClick = gohelper.findChildClickWithAudio(self.viewGO, "left/#go_activity/actlogo/click")

	if logoClick then
		self._activityAnimator = self._goactivity:GetComponent(gohelper.Type_Animator)

		self:addClickCb(logoClick, self._logoClickHandler, self)
	end

	self._itemSize = 113
	self._needCheckPosX = 610
	self._needCheckArrowValue = 0.9
	self._goactivityadapter = gohelper.findChild(self.viewGO, "#go_activity_adapter")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "left/#go_activity/scroll_view")
	self._scrollcontent = gohelper.findChild(self.viewGO, "left/#go_activity/scroll_view/Viewport/Content")
	self._scrollarrow = gohelper.findChild(self.viewGO, "left/#go_activity/arrow")
	self._scrollarrowpos = gohelper.findChild(self.viewGO, "left/#go_activity/scroll_view/arrow_pos")
	self._scrollreddot = gohelper.findChild(self._scrollarrow, "#go_reddot")
	self._horizontal = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))

	local isShow = ActivityModel.showActivityEffect()

	self._horizontal.spacing = isShow and self._horizontal.spacing or 0
	self._horizontalLeft = self._horizontal.padding.left
	self._horizontalRight = self._horizontal.padding.right

	self._scrollview:AddOnValueChanged(self._onContentScrollValueChanged, self)
	self:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)

	self._btnarrow = gohelper.findChildClick(self.viewGO, "left/#go_activity/arrow")

	self._btnarrow:AddClickListener(self._btnarrowOnClick, self)
	gohelper.addUIClickAudio(self._btnarrow.gameObject)
end

function MainActivityCenterView:_logoClickHandler()
	local config = ActivityConfig.instance:getMainActAtmosphereConfig()

	if self._clickLogoTime and config and Time.time - self._clickLogoTime < config.effectDuration then
		return
	end

	if self._activityAnimator then
		self._activityAnimator:Play("click", 0, 0)
	end

	self._clickLogoTime = Time.time
end

function MainActivityCenterView:_btnarrowOnClick()
	self._scrollview.horizontalNormalizedPosition = 1
end

function MainActivityCenterView:_onScreenResize()
	local adapterWidth = recthelper.getWidth(self._goactivityadapter.transform)
	local num = self:_getContentItemNum()
	local width = num * self._itemSize + self._horizontalLeft + self._horizontalRight

	if adapterWidth < width then
		recthelper.setWidth(self._scrollview.transform, adapterWidth)
	else
		recthelper.setWidth(self._scrollview.transform, width)
	end

	self._scrollview.horizontalNormalizedPosition = 0
	self._scrollarrow.transform.position = self._scrollarrowpos.transform.position

	self:_refreshActBgWidth()

	local needCheckPos = recthelper.rectToRelativeAnchorPos(self._scrollarrowpos.transform.position, self._scrollview.transform)

	self._needCheckPosX = math.max(0, needCheckPos.x - 32)
end

function MainActivityCenterView:_getViewShowNum()
	local viewWidth = recthelper.getWidth(self._scrollview.transform)
	local num = (viewWidth - self._horizontalLeft - self._horizontalRight) / self._itemSize

	num = math.floor(num)

	return num
end

function MainActivityCenterView:_getContentItemNum()
	local num = 0
	local tr = self._scrollcontent.transform
	local childCount = tr.childCount

	for i = 0, childCount - 1 do
		local child = tr:GetChild(i)

		if child.gameObject.activeSelf then
			num = num + 1
		end
	end

	return num
end

function MainActivityCenterView:_onContentScrollValueChanged(value)
	local showArrow = value < self._needCheckArrowValue

	if showArrow then
		local viewWidth = recthelper.getWidth(self._scrollview.transform)
		local contentWidth = recthelper.getWidth(self._scrollcontent.transform)

		if contentWidth <= viewWidth then
			showArrow = false
		end
	end

	gohelper.setActive(self._scrollarrow, showArrow)
	gohelper.setActive(self._scrollreddot, false)

	if not showArrow then
		return
	end

	local list = self._index2Id or {}

	for i = #list, 1, -1 do
		local id = list[i]
		local v = self._sortBtnList[id]

		if v:isShowRedDot() then
			local go = v.go

			if not gohelper.isNil(go) then
				local pos = recthelper.rectToRelativeAnchorPos(go.transform.position, self._scrollview.transform)

				if pos.x >= self._needCheckPosX then
					gohelper.setActive(self._scrollreddot, true)

					break
				end
			end
		end
	end
end

function MainActivityCenterView:onUpdateParam()
	return
end

function MainActivityCenterView:onOpen()
	self:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, self._freshBtns, self)
	self:addEventCb(BpController.instance, BpEvent.OnGetInfo, self._freshBtns, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._freshBtns, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self._freshBtns, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshNorSignActivity, self, LuaEventSystem.Low)
	self:addEventCb(Activity160Controller.instance, Activity160Event.InfoUpdate, self._freshBtns, self)
	self:_freshBtns()
end

function MainActivityCenterView:_onCloseFullView(viewName)
	if not ViewMgr.instance:hasOpenFullView() then
		self:_freshBtns()
	end
end

function MainActivityCenterView:_onCloseView(viewName)
	self._scrollview.horizontalNormalizedPosition = 0

	if viewName == ViewName.ActivityBeginnerView then
		self:_freshBtns()
	end
end

function MainActivityCenterView:_freshBtns()
	self:_checkBpBtn()
	self:_refreshActCenter()
	self:_checkTestTaskBtn()
	self:_checkTurnbackBtn()
	self:_checkRoleSignViewBtn()
	self:_checkSpringSignViewBtn()
	self:_checkActivity186Btn()
	self:_checkActivity204Btn()
	self:_checkActivityCruiseBtn()
	self:_checkActivity2ndCollectionPageViewBtn()
	self:_checkActivityImgVisible()
	self:_sortBtns()
end

function MainActivityCenterView:_checkActivityImgVisible()
	local isShow = ActivityModel.showActivityEffect()
	local showLogo = isShow and ActivityModel.checkIsShowLogoVisible()
	local showActBg = isShow and ActivityModel.checkIsShowActBgVisible()

	gohelper.setActive(self._activityLogo, showLogo)
	gohelper.setActive(self._goactbg, showActBg)

	local config = ActivityConfig.instance:getMainActAtmosphereConfig()

	if config then
		for _, path in ipairs(config.mainView) do
			local go = gohelper.findChild(self.viewGO, path)

			if go then
				gohelper.setActive(go, isShow)
			end
		end
	end
end

function MainActivityCenterView:_refreshNorSignActivity()
	self:_sortBtns()
	self:_onContentScrollValueChanged(self._scrollview.horizontalNormalizedPosition)
end

function MainActivityCenterView:_addSortBtn(activityId, btn)
	self._sortBtnList[activityId] = btn
end

function MainActivityCenterView:_sortBtns()
	local list = {}

	for k, _ in pairs(self._sortBtnList) do
		if k ~= ActivityEnum.MainActivityCenterViewClientId.Bp and k ~= ActivityEnum.MainActivityCenterViewClientId.BpSP then
			table.insert(list, k)
		end
	end

	table.sort(list, function(a, b)
		local aBtn = self._sortBtnList[a]
		local bBtn = self._sortBtnList[b]
		local aRedDot = aBtn:isShowRedDot() and 1 or 0
		local bRedDot = bBtn:isShowRedDot() and 1 or 0

		if aRedDot ~= bRedDot then
			return bRedDot < aRedDot
		end

		local aWeight = ActivityEnum.ActivitySortWeight[a] or 100
		local bWeight = ActivityEnum.ActivitySortWeight[b] or 100

		return aWeight < bWeight
	end)

	self._index2Id = list

	for i, id in ipairs(list) do
		gohelper.setAsLastSibling(self._sortBtnList[id].go)
	end

	for _, item in ipairs(self._centerItems) do
		gohelper.setSibling(item.go, 0)
	end

	if self._bpSpItem then
		gohelper.setSibling(self._bpSpItem.go, 0)
	end

	if self._bpItem then
		gohelper.setSibling(self._bpItem.go, 0)
	end

	if self._act186Item then
		gohelper.setSibling(self._act186Item.go, 2)
	end

	if self._actCruiseItem then
		gohelper.setSibling(self._actCruiseItem.go, 3)
	end

	for k, v in pairs(self._checkBtnList) do
		rawset(self._checkBtnList, k, nil)
	end

	local contentNum = self:_getContentItemNum()
	local showNum = self:_getViewShowNum()
	local num = contentNum - showNum

	if num > 0 then
		for i = #list, 1, -1 do
			table.insert(self._checkBtnList, self._sortBtnList[list[i]])

			if num <= #self._checkBtnList then
				break
			end
		end
	end

	if self._contentItemNum ~= contentNum then
		self._contentItemNum = contentNum

		self:_onScreenResize()
	end

	self._scrollview.horizontalNormalizedPosition = 0

	self:_refreshActBgWidth()
end

function MainActivityCenterView:_checkBpBtn()
	if BpModel.instance:isEnd() then
		GameUtil.onDestroyViewMember(self, "_bpItem")
		GameUtil.onDestroyViewMember(self, "_bpSpItem")

		return
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BP) or self._bpItem then
		return
	end

	self._bpItem = BpMainBtnItem.New()

	self._bpItem:init(self._itemGo)
	self:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.Bp, self._bpItem)

	local bpCo = BpConfig.instance:getBpCO(BpModel.instance.id)

	if bpCo and bpCo.isSp then
		local status = ActivityHelper.getActivityStatus(BpConfig.instance:getSpActId(), true)

		if status ~= ActivityEnum.ActivityStatus.Normal then
			return
		end

		self._bpSpItem = BpSPMainBtnItem.New()

		self._bpSpItem:init(self._itemGo)
		self:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.BpSP, self._bpSpItem)
	end
end

function MainActivityCenterView:_refreshActCenter()
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Activity) then
		return
	end

	GameUtil.onDestroyViewMemberList(self, "_centerItems")

	local centerCo = ActivityModel.instance:getActivityCenter()

	self._centerItems = self:getUserDataTb_()

	for k, actIds in pairs(centerCo) do
		if k == ActivityEnum.ActivityType.Beginner then
			ActivityModel.instance:removeFinishedCategory(actIds)
			ActivityModel.instance:removeUnExitAct(actIds)
		elseif k == ActivityEnum.ActivityType.Welfare then
			ActivityModel.instance:removeFinishedWelfare(actIds)
			ActivityModel.instance:removeUnExitAct(actIds)
			ActivityModel.instance:removeSelectSixAfterRemoveFinished(actIds)
		end

		if GameUtil.getTabLen(actIds) ~= 0 then
			local item = ActivityMainBtnItem.New()

			item:init(k, self._itemGo)
			table.insert(self._centerItems, item)
		end
	end

	table.sort(self._centerItems, function(a, b)
		return a:getSortPriority() > b:getSortPriority()
	end)
end

function MainActivityCenterView:_checkActivity2ndCollectionPageViewBtn()
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Activity) then
		return
	end

	local actIds = tabletool.copy(Activity2ndEnum.ActivityOrder)

	table.insert(actIds, Activity196Enum.ActId)
	table.insert(actIds, Activity2ndEnum.ActivityId.MailActivty)
	table.insert(actIds, Activity2ndEnum.ActivityId.V2a8_PVPopupReward)

	local isOpen = false

	for _, actId in pairs(actIds) do
		if ActivityHelper.isOpen(actId) then
			isOpen = true

			break
		end
	end

	if not isOpen then
		GameUtil.onDestroyViewMember(self, "_2ndItem")

		return
	end

	if self._2ndItem then
		self._2ndItem:refresh()

		return
	else
		self._2ndItem = self:_createActCenterItem(Activity2ndBtnItem)
	end

	self:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.Act2nd, self._2ndItem)
end

function MainActivityCenterView:_checkTurnbackBtn()
	if not TurnbackModel.instance:isInOpenTime() or not TurnbackModel.instance:getCurTurnbackMo() then
		GameUtil.onDestroyViewMember(self, "_turnbackItem")

		return
	end

	if self._turnbackItem then
		self._turnbackItem:_refreshItem()

		return
	end

	self._turnbackItem = TurnbackMainBtnItem.New()

	self._turnbackItem:init(self._itemGo, TurnbackModel.instance:getCurTurnbackId())
	self:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.TurnBack, self._turnbackItem)
end

function MainActivityCenterView:_checkTestTaskBtn()
	local testTaskShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.TestTask)

	if not testTaskShow then
		GameUtil.onDestroyViewMember(self, "_testTaskItem")

		return
	end

	if self._testTaskItem then
		self._testTaskItem:_refreshItem()

		return
	end

	self._testTaskItem = TestTaskMainBtnItem.New()

	self._testTaskItem:init(self._itemGo)
	self:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.TestTask, self._testTaskItem)
end

function MainActivityCenterView:_checkSelfSelectCharacterBtn()
	if not Activity136Model.instance:isActivity136InOpen() then
		GameUtil.onDestroyViewMember(self, "_selfSelectCharacterBtn")

		return
	end

	if self._selfSelectCharacterBtn then
		self._selfSelectCharacterBtn:refresh()
	else
		local go = gohelper.cloneInPlace(self._itemGo)

		self._selfSelectCharacterBtn = MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity136MainBtnItem)

		self:_addSortBtn(Activity136Controller.instance:actId(), self._selfSelectCharacterBtn)
	end
end

local kRoleSignViewActIds = {
	ActivityEnum.Activity.RoleSignViewPart1_1_6,
	ActivityEnum.Activity.RoleSignViewPart2_1_6
}

function MainActivityCenterView:_checkRoleSignViewBtn()
	local viewNames = {
		ViewName.V1a6_Role_PanelSignView_Part1,
		ViewName.V1a6_Role_PanelSignView_Part2
	}
	local isOpen = false
	local actId, viewName

	for i, _actId in ipairs(kRoleSignViewActIds) do
		if ActivityType101Model.instance:isOpen(_actId) then
			isOpen = true
			actId = _actId
			viewName = viewNames[i]

			break
		end
	end

	if not isOpen then
		GameUtil.onDestroyViewMember(self, "_roleSignViewBtn")

		return
	end

	local data = {
		viewName = viewName,
		viewParam = {
			actId = actId
		}
	}

	if self._roleSignViewBtn then
		self._roleSignViewBtn:setCustomData(data)
		self._roleSignViewBtn:refresh()

		return
	end

	self._roleSignViewBtn = self:_createActCenterItem(V1a6_Role_PanelSignView_ActCenterItemBtn)

	self._roleSignViewBtn:setCustomData(data)
	self._roleSignViewBtn:refresh()
	self:_addSortBtn(actId, self._roleSignViewBtn)
end

function MainActivityCenterView:_checkGoldenMilletPresentBtn()
	local isOpen = GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen()

	if isOpen then
		if not self._goldenMilletPresentBtn then
			self._goldenMilletPresentBtn = self:_createActCenterItem(GoldenMilletPresentMainBtnItem)

			self:_addSortBtn(GoldenMilletPresentModel.instance:getGoldenMilletPresentActId(), self._goldenMilletPresentBtn)
		end

		self._goldenMilletPresentBtn:refreshRedDot()
	elseif self._goldenMilletPresentBtn then
		self._goldenMilletPresentBtn:destroy()

		self._goldenMilletPresentBtn = nil
	end
end

function MainActivityCenterView:_checkSpringSignViewBtn()
	local actId = ActivityEnum.Activity.SpringSign
	local viewName = ViewName.V1a6_Spring_PanelSignView
	local isOpen = ActivityType101Model.instance:isOpen(actId)

	if not isOpen then
		GameUtil.onDestroyViewMember(self, "_springSignViewBtn")

		return
	end

	local data = {
		viewName = viewName,
		viewParam = {
			actId = actId
		}
	}

	if self._springSignViewBtn then
		self._springSignViewBtn:setCustomData(data)
		self._springSignViewBtn:refresh()

		return
	end

	self._springSignViewBtn = self:_createActCenterItem(ActCenterItem_SpringSignViewBtn_1_6)

	self._springSignViewBtn:setCustomData(data)
	self._springSignViewBtn:refresh()
	self:_addSortBtn(actId, self._springSignViewBtn)
end

function MainActivityCenterView:_checkActivity186Btn()
	local isOnline = Activity186Model.instance:isActivityOnline()

	if not isOnline then
		GameUtil.onDestroyViewMember(self, "_act186Item")

		return
	end

	if not self._act186Item then
		local go = gohelper.cloneInPlace(self._itemGo)

		self._act186Item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity186MainBtnItem)

		self:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.Act186, self._act186Item)
	end

	self._act186Item:refresh()
end

function MainActivityCenterView:_checkActivity204Btn()
	local actId = ActivityEnum.Activity.V2a9_ActCollection
	local isOnline = ActivityHelper.isOpen(actId)

	if not isOnline then
		GameUtil.onDestroyViewMember(self, "_act204Item")

		return
	end

	if not self._act204Item then
		local go = gohelper.cloneInPlace(self._itemGo)

		self._act204Item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity204MainBtnItem)

		self:_addSortBtn(actId, self._act204Item)
	end

	self._act204Item:refresh()
end

function MainActivityCenterView:_checkActivityCruiseBtn()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseMain
	local isOnline = ActivityHelper.isOpen(actId)

	if not isOnline then
		GameUtil.onDestroyViewMember(self, "_actCruiseItem")

		return
	end

	if not self._actCruiseItem then
		local go = gohelper.cloneInPlace(self._itemGo)

		self._actCruiseItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, ActivityCruiseMainBtnItem)

		self:_addSortBtn(ActivityEnum.MainActivityCenterViewClientId.Cruise, self._actCruiseItem)
	end

	self._actCruiseItem:refresh()
end

function MainActivityCenterView:_createActCenterItem(class)
	local go = gohelper.cloneInPlace(self._itemGo)

	self:_refreshActBgWidth()

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, class)
end

function MainActivityCenterView:onClose()
	self._scrollview:RemoveOnValueChanged()
	self._btnarrow:RemoveClickListener()
end

function MainActivityCenterView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_centerItems")
	GameUtil.onDestroyViewMember(self, "_bpItem")
	GameUtil.onDestroyViewMember(self, "_bpSpItem")
	GameUtil.onDestroyViewMember(self, "_testTaskItem")
	GameUtil.onDestroyViewMember(self, "_turnbackItem")
	GameUtil.onDestroyViewMember(self, "_selfSelectCharacterBtn")
	GameUtil.onDestroyViewMember(self, "_act186Item")
	GameUtil.onDestroyViewMember(self, "_act204Item")
	GameUtil.onDestroyViewMember(self, "_actCruiseItem")
	GameUtil.onDestroyViewMember(self, "_roleSignViewBtn")
	GameUtil.onDestroyViewMember(self, "_springSignViewBtn")
	GameUtil.onDestroyViewMember(self, "_2ndItem")
	self:removeEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, self._freshBtns, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._freshBtns, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function MainActivityCenterView:_updateRoleSignViewBtn()
	for _, actId in ipairs(kRoleSignViewActIds) do
		if ActivityType101Model.instance:isOpen(actId) then
			Activity101Rpc.instance:sendGet101InfosRequest(actId)
		end
	end
end

function MainActivityCenterView:_updateSpringSignViewBtn()
	local actId = ActivityEnum.Activity.SpringSign

	if ActivityType101Model.instance:isOpen(actId) then
		Activity101Rpc.instance:sendGet101InfosRequest(actId)
	end
end

function MainActivityCenterView:_onDailyRefresh()
	self:_freshBtns()
	self:_updateRoleSignViewBtn()
	self:_updateSpringSignViewBtn()
end

local kMaxActBgWidth = 840.4

function MainActivityCenterView:_refreshActBgWidth()
	local showLogo = ActivityModel.checkIsShowLogoVisible()
	local num = 0

	if self._sortBtnList then
		for _, v in pairs(self._sortBtnList) do
			num = num + 1
		end
	end

	if self._centerItems then
		num = num + #self._centerItems
	end

	local spacing = self._horizontal.spacing
	local spacingX = (num - 1) * spacing
	local width = num * self._itemSize + self._horizontalLeft
	local offset = -math.min(0, self._goactbgOffsetX) * 2

	width = width + offset

	recthelper.setWidth(self._goactbgTrans, GameUtil.clamp(width, 0, kMaxActBgWidth))
end

return MainActivityCenterView
