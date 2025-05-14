module("modules.logic.store.view.RecommendStoreView", package.seeall)

local var_0_0 = class("RecommendStoreView", BaseView)

var_0_0.AutoToNextTime = 4

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagerecommend = gohelper.findChildSingleImage(arg_1_0.viewGO, "subViewContainer/#simage_recommend")
	arg_1_0._gomonthcard = gohelper.findChild(arg_1_0.viewGO, "subViewContainer/#go_monthcard")
	arg_1_0._gostorecategoryitem = gohelper.findChild(arg_1_0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	arg_1_0._categorycontentTrans = gohelper.findChild(arg_1_0.viewGO, "top/scroll_category/viewport/categorycontent").transform
	arg_1_0._categoryscroll = gohelper.findChild(arg_1_0.viewGO, "top/scroll_category")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
end

function var_0_0._onClickRecommend(arg_4_0)
	local var_4_0 = arg_4_0._selectThirdTabId ~= 0 and arg_4_0._selectThirdTabId or arg_4_0._selectSecondTabId

	if var_4_0 ~= 0 then
		local var_4_1 = StoreConfig.instance:getStoreRecommendConfig(var_4_0)

		if string.nilorempty(var_4_1.systemJumpCode) == false then
			StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
				[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
				[StatEnum.EventProperties.RecommendPageId] = var_4_1.id,
				[StatEnum.EventProperties.RecommendPageName] = var_4_1.name
			})
			GameFacade.jumpByAdditionParam(var_4_1.systemJumpCode)
		end
	end
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gostorecategoryitem, false)
	arg_5_0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_shangpindiban"))

	arg_5_0._click = gohelper.getClick(arg_5_0._simagerecommend.gameObject)

	gohelper.addUIClickAudio(arg_5_0._simagerecommend.gameObject, AudioEnum.UI.play_ui_common_pause)

	arg_5_0._categoryItemContainer = {}
	arg_5_0._tabView = StoreTabViewGroup.New(4, "subViewContainer/#go_monthcard")
	arg_5_0._tabView.viewGO = arg_5_0.viewGO
	arg_5_0._tabView.viewContainer = arg_5_0.viewContainer
	arg_5_0._tabView.viewName = arg_5_0.viewName

	arg_5_0._tabView:onInitView()

	arg_5_0._animator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0._ignoreClick = false
	arg_5_0._gosubViewContainer = gohelper.findChild(arg_5_0.viewGO, "subViewContainer")
	arg_5_0._btnleft = gohelper.findChildButton(arg_5_0.viewGO, "subViewContainer/#btn_left")
	arg_5_0._btnright = gohelper.findChildButton(arg_5_0.viewGO, "subViewContainer/#btn_right")
	arg_5_0._sliderGo = gohelper.findChild(arg_5_0.viewGO, "#go_slider/selectitem")

	gohelper.setActive(arg_5_0._sliderGo, false)

	arg_5_0.animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO)
end

function var_0_0._onDragBegin(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._startPos = arg_6_2.position.x
	arg_6_0._ignoreClick = false
end

function var_0_0._onDrag(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2.position.x

	arg_7_0._ignoreClick = Mathf.Abs(arg_7_0._startPos - var_7_0) > 300
end

function var_0_0._onDragEnd(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2.position.x - arg_8_0._startPos

	arg_8_0._ignoreClick = Mathf.Abs(var_8_0) > 300

	TaskDispatcher.runDelay(arg_8_0._resetIgnoreClick, arg_8_0, 0.1)

	if arg_8_0._ignoreClick then
		local var_8_1 = var_8_0 > 0 and -1 or 1

		arg_8_0:_toNextTab(var_8_1)
	end
end

function var_0_0._btnrightOnClick(arg_9_0)
	arg_9_0:_toNextTab(1)
end

function var_0_0._btnleftOnClick(arg_10_0)
	arg_10_0:_toNextTab(-1)
end

function var_0_0._toNextTab(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or 1

	local var_11_0 = arg_11_0._nowIndex + arg_11_1

	if var_11_0 <= 0 then
		var_11_0 = #arg_11_0._categoryItemContainer
	elseif var_11_0 > #arg_11_0._categoryItemContainer then
		var_11_0 = 1
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_11_1 = arg_11_0._categoryItemContainer[var_11_0].tabId

	arg_11_0:_switchTab(var_11_1)
end

function var_0_0._switchTab(arg_12_0, arg_12_1)
	if arg_12_0._selectSecondTabId ~= arg_12_1 and arg_12_0._jumpTab == nil then
		arg_12_0._jumpTab = arg_12_1

		local var_12_0 = arg_12_0._selectThirdTabId ~= 0 and arg_12_0._selectThirdTabId or arg_12_0._selectSecondTabId
		local var_12_1 = StoreConfig.instance:getStoreRecommendConfig(var_12_0)

		if var_12_1.prefab > 0 then
			local var_12_2 = arg_12_0._tabView._tabViews[var_12_1.prefab]

			if var_12_2.switchClose then
				var_12_2:switchClose(arg_12_0._onSwitchCloseAnimDone, arg_12_0)
			else
				arg_12_0:_onSwitchCloseAnimDone()
			end
		else
			arg_12_0.animatorPlayer:Play(UIAnimationName.Close, arg_12_0._onSwitchCloseAnimDone, arg_12_0)
		end

		TaskDispatcher.runDelay(arg_12_0._onSwitchCloseAnimDone, arg_12_0, 2)

		arg_12_0._selectSecondTabId = arg_12_1

		arg_12_0:_refreshTabsItem()
	end
end

function var_0_0._onSwitchCloseAnimDone(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._onSwitchCloseAnimDone, arg_13_0)
	arg_13_0:_refreshTabs(arg_13_0._jumpTab)
	arg_13_0:refreshRightPage()
	StoreController.instance:statSwitchStore(arg_13_0._jumpTab)

	arg_13_0._jumpTab = nil
end

function var_0_0._resetIgnoreClick(arg_14_0)
	arg_14_0._ignoreClick = false
end

function var_0_0.onOpen(arg_15_0)
	local var_15_0 = StoreModel.instance:getMonthCardInfo()

	arg_15_0._hasMonthCard = false

	if var_15_0 ~= nil then
		arg_15_0._hasMonthCard = var_15_0:getRemainDay() ~= StoreEnum.MonthCardStatus.NotPurchase
	end

	arg_15_0._tabView:onOpen()
	arg_15_0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_15_0._refreshTabsItem, arg_15_0)
	arg_15_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_15_0._refreshTabsItem, arg_15_0)
	arg_15_0:addEventCb(ActivityController.instance, ActivityEvent.ChangeActivityStage, arg_15_0._onRefreshRedDot, arg_15_0)
	arg_15_0:addEventCb(StoreController.instance, StoreEvent.SetVisibleInternal, arg_15_0._onSetVisibleInternal, arg_15_0)
	arg_15_0:addEventCb(StoreController.instance, StoreEvent.SetAutoToNextPage, arg_15_0._onSetAutoToNextPage, arg_15_0)
	arg_15_0._click:AddClickListener(arg_15_0._onClickRecommend, arg_15_0)

	arg_15_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_15_0._gosubViewContainer)

	arg_15_0._drag:AddDragBeginListener(arg_15_0._onDragBegin, arg_15_0)
	arg_15_0._drag:AddDragEndListener(arg_15_0._onDragEnd, arg_15_0)
	arg_15_0._drag:AddDragListener(arg_15_0._onDrag, arg_15_0)

	arg_15_0._selectFirstTabId = arg_15_0.viewContainer:getSelectFirstTabId()

	local var_15_1 = arg_15_0.viewContainer:getJumpTabId()

	arg_15_0:refreshUI(var_15_1, true)
end

function var_0_0.refreshUI(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:_refreshTabs(arg_16_1, arg_16_2)
end

function var_0_0._refreshTabs(arg_17_0, arg_17_1, arg_17_2)
	TaskDispatcher.cancelTask(arg_17_0._toNextTab, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0._toNextTab, arg_17_0, var_0_0.AutoToNextTime)

	local var_17_0 = arg_17_0._selectSecondTabId
	local var_17_1 = arg_17_0._selectThirdTabId

	arg_17_0._selectSecondTabId = arg_17_1
	arg_17_0._selectThirdTabId = 0

	local var_17_2 = StoreConfig.instance:getTabConfig(arg_17_0._selectThirdTabId)
	local var_17_3 = StoreConfig.instance:getTabConfig(arg_17_0._selectSecondTabId)
	local var_17_4 = StoreConfig.instance:getTabConfig(arg_17_0.viewContainer:getSelectFirstTabId())

	if var_17_2 and not string.nilorempty(var_17_2.showCost) then
		arg_17_0.viewContainer:setCurrencyType(var_17_2.showCost)
	elseif var_17_3 and not string.nilorempty(var_17_3.showCost) then
		arg_17_0.viewContainer:setCurrencyType(var_17_3.showCost)
	elseif var_17_4 and not string.nilorempty(var_17_4.showCost) then
		arg_17_0.viewContainer:setCurrencyType(var_17_4.showCost)
	else
		arg_17_0.viewContainer:setCurrencyType(nil)
	end

	if not arg_17_2 and var_17_0 == arg_17_0._selectSecondTabId and var_17_1 == arg_17_0._selectThirdTabId then
		return
	end

	local var_17_5 = arg_17_0:_refreshTabsItem()

	if #var_17_5 > 0 then
		StoreRpc.instance:sendGetStoreInfosRequest(var_17_5)
	end

	arg_17_0:refreshRightPage()
end

function var_0_0._refreshTabsItem(arg_18_0)
	local var_18_0, var_18_1 = StoreHelper.getRecommendStoreSecondTabConfig()

	arg_18_0:sortPage(var_18_0)

	local var_18_2 = false

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if iter_18_1.id == arg_18_0._selectSecondTabId then
			var_18_2 = true

			break
		end
	end

	if not var_18_2 then
		arg_18_0._selectSecondTabId = var_18_0[1].id
	end

	local var_18_3 = {}

	for iter_18_2 = 1, #var_18_0 do
		arg_18_0:_refreshSecondTabs(iter_18_2, var_18_0[iter_18_2])
		gohelper.setActive(arg_18_0._categoryItemContainer[iter_18_2].go, true)
		gohelper.setActive(arg_18_0._categoryItemContainer[iter_18_2].sliderGo, true)

		local var_18_4 = arg_18_0._categoryItemContainer[iter_18_2].go.transform.rect.width

		if var_18_4 > 0 then
			local var_18_5 = var_18_4
			local var_18_6 = 0

			if iter_18_2 > 1 and arg_18_0._categoryItemContainer[iter_18_2 - 1] and var_18_3[iter_18_2 - 1] and var_18_3[iter_18_2 - 1].totalWidth then
				var_18_5 = var_18_3[iter_18_2 - 1].totalWidth + var_18_4

				local var_18_7 = arg_18_0._categoryscroll.transform.rect.width

				var_18_6 = -var_18_5 + var_18_7
			end

			var_18_3[iter_18_2] = {
				width = var_18_4,
				totalWidth = var_18_5,
				pos = Mathf.Min(var_18_6, 0)
			}
		end
	end

	gohelper.setActive(arg_18_0._categoryItemContainer[#var_18_0].go_line, false)

	for iter_18_3 = #var_18_0 + 1, #arg_18_0._categoryItemContainer do
		arg_18_0._categoryItemContainer[iter_18_3].btn:RemoveClickListener()
		gohelper.destroy(arg_18_0._categoryItemContainer[iter_18_3].go)

		arg_18_0._categoryItemContainer[iter_18_3] = nil
	end

	if var_18_3 and var_18_3[arg_18_0._nowIndex] and var_18_3[arg_18_0._nowIndex].pos then
		local var_18_8 = var_18_3[arg_18_0._nowIndex].pos

		recthelper.setAnchorX(arg_18_0._categorycontentTrans, var_18_8)
	else
		local var_18_9 = -300 * (arg_18_0._nowIndex - 5) - 50
		local var_18_10 = -300 * (arg_18_0._nowIndex - 1)
		local var_18_11 = recthelper.getAnchorX(arg_18_0._categorycontentTrans)

		if var_18_11 < var_18_10 then
			recthelper.setAnchorX(arg_18_0._categorycontentTrans, var_18_10)
		elseif var_18_9 < var_18_11 then
			recthelper.setAnchorX(arg_18_0._categorycontentTrans, var_18_9)
		end
	end

	arg_18_0:_onRefreshRedDot()

	return var_18_1
end

function var_0_0._tabSortFunction(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = string.splitToNumber(arg_19_1.adjustOrder, "#")
	local var_19_1 = string.splitToNumber(arg_19_2.adjustOrder, "#")
	local var_19_2 = arg_19_1.order
	local var_19_3 = arg_19_2.order

	if arg_19_0:_checkSortType(var_19_0) then
		var_19_2 = var_19_0[1]
	end

	if arg_19_0:_checkSortType(var_19_1) then
		var_19_3 = var_19_1[1]
	end

	return var_19_2 < var_19_3
end

function var_0_0.sortPage(arg_20_0, arg_20_1)
	arg_20_0:_cacheConfigGroupData(arg_20_1)
	table.sort(arg_20_1, function(arg_21_0, arg_21_1)
		return arg_20_0:_tabSortGroupFunction(arg_21_0, arg_21_1)
	end)

	arg_20_0._cacheConfigGroupDic = {}
	arg_20_0._cacheConfigOrderDic = {}
end

function var_0_0._cacheConfigGroupData(arg_22_0, arg_22_1)
	arg_22_0._cacheConfigGroupDic = {}
	arg_22_0._cacheConfigOrderDic = {}

	if not arg_22_1 or #arg_22_1 <= 0 then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		local var_22_0, var_22_1 = StoreHelper.getRecommendStoreGroupAndOrder(iter_22_1, true)

		arg_22_0._cacheConfigGroupDic[iter_22_1.id] = var_22_0
		arg_22_0._cacheConfigOrderDic[iter_22_1.id] = var_22_1
	end
end

function var_0_0._tabSortGroupFunction(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0._cacheConfigGroupDic[arg_23_1.id]
	local var_23_1 = arg_23_0._cacheConfigGroupDic[arg_23_2.id]

	if var_23_0 == var_23_1 then
		return arg_23_0._cacheConfigOrderDic[arg_23_1.id] < arg_23_0._cacheConfigOrderDic[arg_23_2.id]
	end

	return var_23_0 < var_23_1
end

function var_0_0._checkSortType(arg_24_0, arg_24_1)
	if arg_24_1[2] == StoreEnum.AdjustOrderType.MonthCard and arg_24_0._hasMonthCard then
		return true
	end
end

function var_0_0._refreshSecondTabs(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0._categoryItemContainer[arg_25_1] or arg_25_0:initCategoryItemTable(arg_25_1)

	var_25_0.tabConfig = arg_25_2
	var_25_0.tabId = arg_25_2.id
	var_25_0.txt_itemcn1.text = arg_25_2.name
	var_25_0.txt_itemcn2.text = arg_25_2.name
	var_25_0.txt_itemen1.text = arg_25_2.nameEn
	var_25_0.txt_itemen2.text = arg_25_2.nameEn

	local var_25_1 = arg_25_0._selectSecondTabId == arg_25_2.id

	gohelper.setActive(arg_25_0._categoryItemContainer[arg_25_1].go_line, true)

	if var_25_1 then
		arg_25_0._nowIndex = arg_25_1

		if arg_25_0._categoryItemContainer[arg_25_1 - 1] then
			gohelper.setActive(arg_25_0._categoryItemContainer[arg_25_1 - 1].go_line, false)
		end
	end

	gohelper.setActive(var_25_0.go_timelimit, not string.nilorempty(arg_25_2.openTime) and not string.nilorempty(arg_25_2.endTime))
	gohelper.setActive(var_25_0.go_unselected, not var_25_1)
	gohelper.setActive(var_25_0.go_sliderUnselected, not var_25_1)
	gohelper.setActive(var_25_0.go_selected, var_25_1)
	gohelper.setActive(var_25_0.go_sliderSelected, var_25_1)
end

function var_0_0.initCategoryItemTable(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getUserDataTb_()

	var_26_0.go = gohelper.cloneInPlace(arg_26_0._gostorecategoryitem, "item" .. arg_26_1)
	var_26_0.go_unselected = gohelper.findChild(var_26_0.go, "go_unselected")
	var_26_0.go_selected = gohelper.findChild(var_26_0.go, "go_selected")
	var_26_0.go_timelimit = gohelper.findChild(var_26_0.go, "go_timellimit")
	var_26_0.go_reddot = gohelper.findChild(var_26_0.go, "#go_tabreddot1")
	var_26_0.go_reddotType1 = gohelper.findChild(var_26_0.go, "#go_tabreddot1/type1")
	var_26_0.go_reddotType5 = gohelper.findChild(var_26_0.go, "#go_tabreddot1/type5")
	var_26_0.txt_itemcn1 = gohelper.findChildText(var_26_0.go, "go_unselected/txt_itemcn1")
	var_26_0.txt_itemen1 = gohelper.findChildText(var_26_0.go, "go_unselected/txt_itemen1")
	var_26_0.txt_itemcn2 = gohelper.findChildText(var_26_0.go, "go_selected/txt_itemcn2")
	var_26_0.txt_itemen2 = gohelper.findChildText(var_26_0.go, "go_selected/txt_itemen2")
	var_26_0.go_childcategory = gohelper.findChild(var_26_0.go, "go_childcategory")
	var_26_0.go_childItem = gohelper.findChild(var_26_0.go, "go_childcategory/go_childitem")
	var_26_0.go_line = gohelper.findChild(var_26_0.go, "#go_line")
	var_26_0.btn = gohelper.getClickWithAudio(var_26_0.go, AudioEnum.UI.Play_UI_Universal_Click)
	var_26_0.tabId = 0
	var_26_0.sliderGo = gohelper.cloneInPlace(arg_26_0._sliderGo, "item" .. arg_26_1)
	var_26_0.go_sliderSelected = gohelper.findChild(var_26_0.sliderGo, "#go_lightstar")
	var_26_0.go_sliderUnselected = gohelper.findChild(var_26_0.sliderGo, "#go_nomalstar")

	var_26_0.btn:AddClickListener(function(arg_27_0)
		local var_27_0 = arg_27_0.tabId

		StoreController.instance:enterRecommendStore(var_27_0)
		arg_26_0:_switchTab(var_27_0)
	end, var_26_0)
	table.insert(arg_26_0._categoryItemContainer, var_26_0)
	gohelper.setActive(var_26_0.go_childItem, false)

	return var_26_0
end

function var_0_0._onRefreshRedDot(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0._categoryItemContainer) do
		if StoreModel.instance:isTabFirstRedDotShow(iter_28_1.tabId) then
			gohelper.setActive(iter_28_1.go_reddot, true)
			gohelper.setActive(iter_28_1.go_reddotType1, true)
			gohelper.setActive(iter_28_1.go_reddotType5, false)
		elseif StoreController.instance:isNeedShowRedDotNewTag(iter_28_1.tabConfig) and not StoreController.instance:isEnteredRecommendStore(iter_28_1.tabConfig.id) then
			gohelper.setActive(iter_28_1.go_reddot, true)
			gohelper.setActive(iter_28_1.go_reddotType1, false)
			gohelper.setActive(iter_28_1.go_reddotType5, true)
		else
			gohelper.setActive(iter_28_1.go_reddot, false)
		end
	end
end

function var_0_0.refreshRightPage(arg_29_0)
	local var_29_0 = arg_29_0._selectThirdTabId ~= 0 and arg_29_0._selectThirdTabId or arg_29_0._selectSecondTabId
	local var_29_1 = StoreConfig.instance:getStoreRecommendConfig(var_29_0)

	if var_29_1.prefab > 0 then
		gohelper.setActive(arg_29_0._gomonthcard, true)
		gohelper.setActive(arg_29_0._simagerecommend.gameObject, false)

		if arg_29_0._tabView then
			local var_29_2 = arg_29_0._tabView:getCurTabId()
			local var_29_3 = arg_29_0._tabView._tabViews[var_29_2]

			if var_29_3 then
				var_29_3:stopAnimator()
			end
		end

		arg_29_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 4, var_29_1.prefab)
	else
		gohelper.setActive(arg_29_0._gomonthcard, false)
		gohelper.setActive(arg_29_0._simagerecommend.gameObject, true)
		arg_29_0._simagerecommend:LoadImage(ResUrl.getStoreRecommend(var_29_1.res))

		arg_29_0._animator.enabled = true

		arg_29_0._animator:Play(UIAnimationName.Open, 0, 0)
		arg_29_0._animator:Update(0)
	end
end

function var_0_0.onClose(arg_30_0)
	arg_30_0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_30_0._refreshTabsItem, arg_30_0)
	arg_30_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_30_0._refreshTabsItem, arg_30_0)
	arg_30_0:removeEventCb(StoreController.instance, StoreEvent.SetVisibleInternal, arg_30_0._onSetVisibleInternal, arg_30_0)
	arg_30_0:removeEventCb(StoreController.instance, StoreEvent.SetAutoToNextPage, arg_30_0._onSetAutoToNextPage, arg_30_0)

	local var_30_0 = arg_30_0._tabView:getCurTabId()
	local var_30_1 = arg_30_0._tabView._tabViews[var_30_0]

	if var_30_1 then
		var_30_1:stopAnimator()
	end

	arg_30_0._tabView:onClose()
	arg_30_0._click:RemoveClickListener()
	arg_30_0._drag:RemoveDragBeginListener()
	arg_30_0._drag:RemoveDragEndListener()
	arg_30_0._drag:RemoveDragListener()
	TaskDispatcher.cancelTask(arg_30_0._toNextTab, arg_30_0)

	arg_30_0._ignoreClick = false

	arg_30_0.animatorPlayer:Stop()

	arg_30_0._jumpTab = nil

	TaskDispatcher.cancelTask(arg_30_0._onSwitchCloseAnimDone, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._resetIgnoreClick, arg_30_0)
end

function var_0_0._onSetVisibleInternal(arg_31_0, arg_31_1)
	if arg_31_1 then
		TaskDispatcher.cancelTask(arg_31_0._toNextTab, arg_31_0)
		TaskDispatcher.runDelay(arg_31_0._toNextTab, arg_31_0, var_0_0.AutoToNextTime)
	else
		TaskDispatcher.cancelTask(arg_31_0._toNextTab, arg_31_0)
	end
end

function var_0_0._onSetAutoToNextPage(arg_32_0, arg_32_1)
	if arg_32_1 then
		TaskDispatcher.cancelTask(arg_32_0._toNextTab, arg_32_0)
		TaskDispatcher.runDelay(arg_32_0._toNextTab, arg_32_0, var_0_0.AutoToNextTime)
	else
		TaskDispatcher.cancelTask(arg_32_0._toNextTab, arg_32_0)
	end
end

function var_0_0.onUpdateParam(arg_33_0)
	arg_33_0._selectFirstTabId = arg_33_0.viewContainer:getSelectFirstTabId()

	local var_33_0 = arg_33_0.viewContainer:getJumpTabId()

	arg_33_0:refreshUI(var_33_0)
end

function var_0_0.onDestroyView(arg_34_0)
	if arg_34_0._categoryItemContainer and #arg_34_0._categoryItemContainer > 0 then
		for iter_34_0 = 1, #arg_34_0._categoryItemContainer do
			arg_34_0._categoryItemContainer[iter_34_0].btn:RemoveClickListener()
		end
	end

	arg_34_0._simagebg:UnLoadImage()
	arg_34_0._simagerecommend:UnLoadImage()
	arg_34_0._tabView:removeEvents()
	arg_34_0._tabView:onDestroyView()
	TaskDispatcher.cancelTask(arg_34_0._toNextTab, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._onSwitchCloseAnimDone, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._resetIgnoreClick, arg_34_0)
end

return var_0_0
