module("modules.logic.store.view.RecommendStoreView", package.seeall)

slot0 = class("RecommendStoreView", BaseView)
slot0.AutoToNextTime = 4

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagerecommend = gohelper.findChildSingleImage(slot0.viewGO, "subViewContainer/#simage_recommend")
	slot0._gomonthcard = gohelper.findChild(slot0.viewGO, "subViewContainer/#go_monthcard")
	slot0._gostorecategoryitem = gohelper.findChild(slot0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	slot0._categorycontentTrans = gohelper.findChild(slot0.viewGO, "top/scroll_category/viewport/categorycontent").transform
	slot0._categoryscroll = gohelper.findChild(slot0.viewGO, "top/scroll_category")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnright:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
end

function slot0._onClickRecommend(slot0)
	if (slot0._selectThirdTabId ~= 0 and slot0._selectThirdTabId or slot0._selectSecondTabId) ~= 0 and string.nilorempty(StoreConfig.instance:getStoreRecommendConfig(slot1).systemJumpCode) == false then
		StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
			[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
			[StatEnum.EventProperties.RecommendPageId] = slot2.id,
			[StatEnum.EventProperties.RecommendPageName] = slot2.name
		})
		GameFacade.jumpByAdditionParam(slot2.systemJumpCode)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gostorecategoryitem, false)
	slot0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_shangpindiban"))

	slot0._click = gohelper.getClick(slot0._simagerecommend.gameObject)

	gohelper.addUIClickAudio(slot0._simagerecommend.gameObject, AudioEnum.UI.play_ui_common_pause)

	slot0._categoryItemContainer = {}
	slot0._tabView = StoreTabViewGroup.New(4, "subViewContainer/#go_monthcard")
	slot0._tabView.viewGO = slot0.viewGO
	slot0._tabView.viewContainer = slot0.viewContainer
	slot0._tabView.viewName = slot0.viewName

	slot0._tabView:onInitView()

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._ignoreClick = false
	slot0._gosubViewContainer = gohelper.findChild(slot0.viewGO, "subViewContainer")
	slot0._btnleft = gohelper.findChildButton(slot0.viewGO, "subViewContainer/#btn_left")
	slot0._btnright = gohelper.findChildButton(slot0.viewGO, "subViewContainer/#btn_right")
	slot0._sliderGo = gohelper.findChild(slot0.viewGO, "#go_slider/selectitem")

	gohelper.setActive(slot0._sliderGo, false)

	slot0.animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._startPos = slot2.position.x
	slot0._ignoreClick = false
end

function slot0._onDrag(slot0, slot1, slot2)
	slot0._ignoreClick = Mathf.Abs(slot0._startPos - slot2.position.x) > 300
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._ignoreClick = Mathf.Abs(slot2.position.x - slot0._startPos) > 300

	TaskDispatcher.runDelay(slot0._resetIgnoreClick, slot0, 0.1)

	if slot0._ignoreClick then
		slot0:_toNextTab(slot4 > 0 and -1 or 1)
	end
end

function slot0._btnrightOnClick(slot0)
	slot0:_toNextTab(1)
end

function slot0._btnleftOnClick(slot0)
	slot0:_toNextTab(-1)
end

function slot0._toNextTab(slot0, slot1)
	if slot0._nowIndex + (slot1 or 1) <= 0 then
		slot2 = #slot0._categoryItemContainer
	elseif slot2 > #slot0._categoryItemContainer then
		slot2 = 1
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	slot0:_switchTab(slot0._categoryItemContainer[slot2].tabId)
end

function slot0._switchTab(slot0, slot1)
	if slot0._selectSecondTabId ~= slot1 and slot0._jumpTab == nil then
		slot0._jumpTab = slot1

		if StoreConfig.instance:getStoreRecommendConfig(slot0._selectThirdTabId ~= 0 and slot0._selectThirdTabId or slot0._selectSecondTabId).prefab > 0 then
			if slot0._tabView._tabViews[slot3.prefab].switchClose then
				slot4:switchClose(slot0._onSwitchCloseAnimDone, slot0)
			else
				slot0:_onSwitchCloseAnimDone()
			end
		else
			slot0.animatorPlayer:Play(UIAnimationName.Close, slot0._onSwitchCloseAnimDone, slot0)
		end

		TaskDispatcher.runDelay(slot0._onSwitchCloseAnimDone, slot0, 2)

		slot0._selectSecondTabId = slot1

		slot0:_refreshTabsItem()
	end
end

function slot0._onSwitchCloseAnimDone(slot0)
	TaskDispatcher.cancelTask(slot0._onSwitchCloseAnimDone, slot0)
	slot0:_refreshTabs(slot0._jumpTab)
	slot0:refreshRightPage()
	StoreController.instance:statSwitchStore(slot0._jumpTab)

	slot0._jumpTab = nil
end

function slot0._resetIgnoreClick(slot0)
	slot0._ignoreClick = false
end

function slot0.onOpen(slot0)
	slot0._hasMonthCard = false

	if StoreModel.instance:getMonthCardInfo() ~= nil then
		slot0._hasMonthCard = slot1:getRemainDay() ~= StoreEnum.MonthCardStatus.NotPurchase
	end

	slot0._tabView:onOpen()
	slot0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, slot0._refreshTabsItem, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._refreshTabsItem, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.ChangeActivityStage, slot0._onRefreshRedDot, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.SetVisibleInternal, slot0._onSetVisibleInternal, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.SetAutoToNextPage, slot0._onSetAutoToNextPage, slot0)
	slot0._click:AddClickListener(slot0._onClickRecommend, slot0)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gosubViewContainer)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)

	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:refreshUI(slot0.viewContainer:getJumpTabId(), true)
end

function slot0.refreshUI(slot0, slot1, slot2)
	slot0:_refreshTabs(slot1, slot2)
end

function slot0._refreshTabs(slot0, slot1, slot2)
	TaskDispatcher.cancelTask(slot0._toNextTab, slot0)
	TaskDispatcher.runDelay(slot0._toNextTab, slot0, uv0.AutoToNextTime)

	slot3 = slot0._selectSecondTabId
	slot4 = slot0._selectThirdTabId
	slot0._selectSecondTabId = slot1
	slot0._selectThirdTabId = 0
	slot6 = StoreConfig.instance:getTabConfig(slot0._selectSecondTabId)
	slot7 = StoreConfig.instance:getTabConfig(slot0.viewContainer:getSelectFirstTabId())

	if StoreConfig.instance:getTabConfig(slot0._selectThirdTabId) and not string.nilorempty(slot5.showCost) then
		slot0.viewContainer:setCurrencyType(slot5.showCost)
	elseif slot6 and not string.nilorempty(slot6.showCost) then
		slot0.viewContainer:setCurrencyType(slot6.showCost)
	elseif slot7 and not string.nilorempty(slot7.showCost) then
		slot0.viewContainer:setCurrencyType(slot7.showCost)
	else
		slot0.viewContainer:setCurrencyType(nil)
	end

	if not slot2 and slot3 == slot0._selectSecondTabId and slot4 == slot0._selectThirdTabId then
		return
	end

	if #slot0:_refreshTabsItem() > 0 then
		StoreRpc.instance:sendGetStoreInfosRequest(slot8)
	end

	slot0:refreshRightPage()
end

function slot0._refreshTabsItem(slot0)
	slot1, slot2 = StoreHelper.getRecommendStoreSecondTabConfig()

	slot0:sortPage(slot1)

	slot3 = false

	for slot7, slot8 in ipairs(slot1) do
		if slot8.id == slot0._selectSecondTabId then
			slot3 = true

			break
		end
	end

	if not slot3 then
		slot0._selectSecondTabId = slot1[1].id
	end

	slot4 = {}

	for slot8 = 1, #slot1 do
		slot0:_refreshSecondTabs(slot8, slot1[slot8])
		gohelper.setActive(slot0._categoryItemContainer[slot8].go, true)
		gohelper.setActive(slot0._categoryItemContainer[slot8].sliderGo, true)

		if slot0._categoryItemContainer[slot8].go.transform.rect.width > 0 then
			slot10 = slot9
			slot11 = 0

			if slot8 > 1 and slot0._categoryItemContainer[slot8 - 1] and slot4[slot8 - 1] and slot4[slot8 - 1].totalWidth then
				slot11 = -(slot4[slot8 - 1].totalWidth + slot9) + slot0._categoryscroll.transform.rect.width
			end

			slot4[slot8] = {
				width = slot9,
				totalWidth = slot10,
				pos = Mathf.Min(slot11, 0)
			}
		end
	end

	slot8 = false

	gohelper.setActive(slot0._categoryItemContainer[#slot1].go_line, slot8)

	for slot8 = #slot1 + 1, #slot0._categoryItemContainer do
		slot0._categoryItemContainer[slot8].btn:RemoveClickListener()
		gohelper.destroy(slot0._categoryItemContainer[slot8].go)

		slot0._categoryItemContainer[slot8] = nil
	end

	if slot4 and slot4[slot0._nowIndex] and slot4[slot0._nowIndex].pos then
		recthelper.setAnchorX(slot0._categorycontentTrans, slot4[slot0._nowIndex].pos)
	else
		slot5 = -300 * (slot0._nowIndex - 5) - 50

		if recthelper.getAnchorX(slot0._categorycontentTrans) < -300 * (slot0._nowIndex - 1) then
			recthelper.setAnchorX(slot0._categorycontentTrans, slot6)
		elseif slot5 < slot7 then
			recthelper.setAnchorX(slot0._categorycontentTrans, slot5)
		end
	end

	slot0:_onRefreshRedDot()

	return slot2
end

function slot0._tabSortFunction(slot0, slot1, slot2)
	slot4 = string.splitToNumber(slot2.adjustOrder, "#")
	slot5 = slot1.order
	slot6 = slot2.order

	if slot0:_checkSortType(string.splitToNumber(slot1.adjustOrder, "#")) then
		slot5 = slot3[1]
	end

	if slot0:_checkSortType(slot4) then
		slot6 = slot4[1]
	end

	return slot5 < slot6
end

function slot0.sortPage(slot0, slot1)
	slot0:_cacheConfigGroupData(slot1)
	table.sort(slot1, function (slot0, slot1)
		return uv0:_tabSortGroupFunction(slot0, slot1)
	end)

	slot0._cacheConfigGroupDic = {}
	slot0._cacheConfigOrderDic = {}
end

function slot0._cacheConfigGroupData(slot0, slot1)
	slot0._cacheConfigGroupDic = {}
	slot0._cacheConfigOrderDic = {}

	if not slot1 or #slot1 <= 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0._cacheConfigGroupDic[slot6.id], slot0._cacheConfigOrderDic[slot6.id] = StoreHelper.getRecommendStoreGroupAndOrder(slot6, true)
	end
end

function slot0._tabSortGroupFunction(slot0, slot1, slot2)
	if slot0._cacheConfigGroupDic[slot1.id] == slot0._cacheConfigGroupDic[slot2.id] then
		return slot0._cacheConfigOrderDic[slot1.id] < slot0._cacheConfigOrderDic[slot2.id]
	end

	return slot3 < slot4
end

function slot0._checkSortType(slot0, slot1)
	if slot1[2] == StoreEnum.AdjustOrderType.MonthCard and slot0._hasMonthCard then
		return true
	end
end

function slot0._refreshSecondTabs(slot0, slot1, slot2)
	slot3 = slot0._categoryItemContainer[slot1] or slot0:initCategoryItemTable(slot1)
	slot3.tabConfig = slot2
	slot3.tabId = slot2.id
	slot3.txt_itemcn1.text = slot2.name
	slot3.txt_itemcn2.text = slot2.name
	slot3.txt_itemen1.text = slot2.nameEn
	slot3.txt_itemen2.text = slot2.nameEn

	gohelper.setActive(slot0._categoryItemContainer[slot1].go_line, true)

	if slot0._selectSecondTabId == slot2.id then
		slot0._nowIndex = slot1

		if slot0._categoryItemContainer[slot1 - 1] then
			gohelper.setActive(slot0._categoryItemContainer[slot1 - 1].go_line, false)
		end
	end

	gohelper.setActive(slot3.go_timelimit, not string.nilorempty(slot2.openTime) and not string.nilorempty(slot2.endTime))
	gohelper.setActive(slot3.go_unselected, not slot4)
	gohelper.setActive(slot3.go_sliderUnselected, not slot4)
	gohelper.setActive(slot3.go_selected, slot4)
	gohelper.setActive(slot3.go_sliderSelected, slot4)
end

function slot0.initCategoryItemTable(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._gostorecategoryitem, "item" .. slot1)
	slot2.go_unselected = gohelper.findChild(slot2.go, "go_unselected")
	slot2.go_selected = gohelper.findChild(slot2.go, "go_selected")
	slot2.go_timelimit = gohelper.findChild(slot2.go, "go_timellimit")
	slot2.go_reddot = gohelper.findChild(slot2.go, "#go_tabreddot1")
	slot2.go_reddotType1 = gohelper.findChild(slot2.go, "#go_tabreddot1/type1")
	slot2.go_reddotType5 = gohelper.findChild(slot2.go, "#go_tabreddot1/type5")
	slot2.txt_itemcn1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemcn1")
	slot2.txt_itemen1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemen1")
	slot2.txt_itemcn2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemcn2")
	slot2.txt_itemen2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemen2")
	slot2.go_childcategory = gohelper.findChild(slot2.go, "go_childcategory")
	slot2.go_childItem = gohelper.findChild(slot2.go, "go_childcategory/go_childitem")
	slot2.go_line = gohelper.findChild(slot2.go, "#go_line")
	slot2.btn = gohelper.getClickWithAudio(slot2.go, AudioEnum.UI.Play_UI_Universal_Click)
	slot2.tabId = 0
	slot2.sliderGo = gohelper.cloneInPlace(slot0._sliderGo, "item" .. slot1)
	slot2.go_sliderSelected = gohelper.findChild(slot2.sliderGo, "#go_lightstar")
	slot2.go_sliderUnselected = gohelper.findChild(slot2.sliderGo, "#go_nomalstar")

	slot2.btn:AddClickListener(function (slot0)
		slot1 = slot0.tabId

		StoreController.instance:enterRecommendStore(slot1)
		uv0:_switchTab(slot1)
	end, slot2)
	table.insert(slot0._categoryItemContainer, slot2)
	gohelper.setActive(slot2.go_childItem, false)

	return slot2
end

function slot0._onRefreshRedDot(slot0)
	for slot4, slot5 in pairs(slot0._categoryItemContainer) do
		if StoreModel.instance:isTabFirstRedDotShow(slot5.tabId) then
			gohelper.setActive(slot5.go_reddot, true)
			gohelper.setActive(slot5.go_reddotType1, true)
			gohelper.setActive(slot5.go_reddotType5, false)
		elseif StoreController.instance:isNeedShowRedDotNewTag(slot5.tabConfig) and not StoreController.instance:isEnteredRecommendStore(slot5.tabConfig.id) then
			gohelper.setActive(slot5.go_reddot, true)
			gohelper.setActive(slot5.go_reddotType1, false)
			gohelper.setActive(slot5.go_reddotType5, true)
		else
			gohelper.setActive(slot5.go_reddot, false)
		end
	end
end

function slot0.refreshRightPage(slot0)
	if StoreConfig.instance:getStoreRecommendConfig(slot0._selectThirdTabId ~= 0 and slot0._selectThirdTabId or slot0._selectSecondTabId).prefab > 0 then
		gohelper.setActive(slot0._gomonthcard, true)
		gohelper.setActive(slot0._simagerecommend.gameObject, false)

		if slot0._tabView and slot0._tabView._tabViews[slot0._tabView:getCurTabId()] then
			slot4:stopAnimator()
		end

		slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 4, slot2.prefab)
	else
		gohelper.setActive(slot0._gomonthcard, false)
		gohelper.setActive(slot0._simagerecommend.gameObject, true)
		slot0._simagerecommend:LoadImage(ResUrl.getStoreRecommend(slot2.res))

		slot0._animator.enabled = true

		slot0._animator:Play(UIAnimationName.Open, 0, 0)
		slot0._animator:Update(0)
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, slot0._refreshTabsItem, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._refreshTabsItem, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.SetVisibleInternal, slot0._onSetVisibleInternal, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.SetAutoToNextPage, slot0._onSetAutoToNextPage, slot0)

	if slot0._tabView._tabViews[slot0._tabView:getCurTabId()] then
		slot2:stopAnimator()
	end

	slot0._tabView:onClose()
	slot0._click:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._drag:RemoveDragListener()
	TaskDispatcher.cancelTask(slot0._toNextTab, slot0)

	slot0._ignoreClick = false

	slot0.animatorPlayer:Stop()

	slot0._jumpTab = nil

	TaskDispatcher.cancelTask(slot0._onSwitchCloseAnimDone, slot0)
	TaskDispatcher.cancelTask(slot0._resetIgnoreClick, slot0)
end

function slot0._onSetVisibleInternal(slot0, slot1)
	if slot1 then
		TaskDispatcher.cancelTask(slot0._toNextTab, slot0)
		TaskDispatcher.runDelay(slot0._toNextTab, slot0, uv0.AutoToNextTime)
	else
		TaskDispatcher.cancelTask(slot0._toNextTab, slot0)
	end
end

function slot0._onSetAutoToNextPage(slot0, slot1)
	if slot1 then
		TaskDispatcher.cancelTask(slot0._toNextTab, slot0)
		TaskDispatcher.runDelay(slot0._toNextTab, slot0, uv0.AutoToNextTime)
	else
		TaskDispatcher.cancelTask(slot0._toNextTab, slot0)
	end
end

function slot0.onUpdateParam(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:refreshUI(slot0.viewContainer:getJumpTabId())
end

function slot0.onDestroyView(slot0)
	if slot0._categoryItemContainer and #slot0._categoryItemContainer > 0 then
		for slot4 = 1, #slot0._categoryItemContainer do
			slot0._categoryItemContainer[slot4].btn:RemoveClickListener()
		end
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagerecommend:UnLoadImage()
	slot0._tabView:removeEvents()
	slot0._tabView:onDestroyView()
	TaskDispatcher.cancelTask(slot0._toNextTab, slot0)
	TaskDispatcher.cancelTask(slot0._onSwitchCloseAnimDone, slot0)
	TaskDispatcher.cancelTask(slot0._resetIgnoreClick, slot0)
end

return slot0
