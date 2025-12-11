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
	arg_1_0._categoryscrollTrs = arg_1_0._categoryscroll.transform
	arg_1_0._categoryscrollRect = gohelper.findChildScrollRect(arg_1_0.viewGO, "top/scroll_category")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnbubbleLeft:AddClickListener(arg_2_0._btnbubbleLeftOnClick, arg_2_0)
	arg_2_0._btnbubbleRight:AddClickListener(arg_2_0._btnbubbleRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnbubbleLeft:RemoveClickListener()
	arg_3_0._btnbubbleRight:RemoveClickListener()
end

function var_0_0._onClickRecommend(arg_4_0)
	local var_4_0 = arg_4_0._selectThirdTabId ~= 0 and arg_4_0._selectThirdTabId or arg_4_0._selectSecondTabId

	if var_4_0 ~= 0 then
		local var_4_1 = StoreConfig.instance:getStoreRecommendConfig(var_4_0)

		if string.nilorempty(var_4_1.systemJumpCode) == false then
			StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
				[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
				[StatEnum.EventProperties.RecommendPageId] = var_4_1.id,
				[StatEnum.EventProperties.RecommendPageName] = var_4_1.name,
				[StatEnum.EventProperties.RecommendPageRank] = arg_4_0:getIndexByTabId(var_4_0)
			})
			GameFacade.jumpByAdditionParam(var_4_1.systemJumpCode)
		end
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._tabIdRedDotFlagDict = {}

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
	arg_5_0._gobubbleLeft = gohelper.findChild(arg_5_0.viewGO, "top/go_bubbleLeft")
	arg_5_0._gobubbleRight = gohelper.findChild(arg_5_0.viewGO, "top/go_bubbleRight")
	arg_5_0._btnbubbleLeft = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "top/go_bubbleLeft/btn_click")
	arg_5_0._btnbubbleRight = gohelper.findChildButtonWithAudio(arg_5_0.viewGO, "top/go_bubbleRight/btn_click")
	arg_5_0._sliderGo = gohelper.findChild(arg_5_0.viewGO, "#go_slider/selectitem")

	gohelper.setActive(arg_5_0._sliderGo, false)
	gohelper.setActive(arg_5_0._gobubbleLeft, false)
	gohelper.setActive(arg_5_0._gobubbleRight, false)

	arg_5_0._bubbleTbLeft = arg_5_0:_createBubbleTb(arg_5_0._gobubbleLeft, arg_5_0._btnbubbleLeft)
	arg_5_0._bubbleTbRight = arg_5_0:_createBubbleTb(arg_5_0._gobubbleRight, arg_5_0._btnbubbleRight)
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

function var_0_0._btnbubbleLeftOnClick(arg_9_0)
	if arg_9_0._leftRedDotTabId then
		StoreController.instance:enterRecommendStore(arg_9_0._leftRedDotTabId)
		arg_9_0:_switchTab(arg_9_0._leftRedDotTabId)
		arg_9_0:_moveToTabId(arg_9_0._leftRedDotTabId)
	end
end

function var_0_0._btnbubbleRightOnClick(arg_10_0)
	if arg_10_0._rightRedDotTabId then
		StoreController.instance:enterRecommendStore(arg_10_0._rightRedDotTabId)
		arg_10_0:_switchTab(arg_10_0._rightRedDotTabId)
		arg_10_0:_moveToTabId(arg_10_0._rightRedDotTabId)
	end
end

function var_0_0._onCategoryscrollValueChanged(arg_11_0, arg_11_1)
	arg_11_0:_onRefreshBubbleRedDot()
end

function var_0_0._btnrightOnClick(arg_12_0)
	arg_12_0:_toNextTab(1)
end

function var_0_0._btnleftOnClick(arg_13_0)
	arg_13_0:_toNextTab(-1)
end

function var_0_0._toNextTab(arg_14_0, arg_14_1)
	arg_14_1 = arg_14_1 or 1

	local var_14_0 = arg_14_0._nowIndex + arg_14_1

	if var_14_0 <= 0 then
		var_14_0 = #arg_14_0._categoryItemContainer
	elseif var_14_0 > #arg_14_0._categoryItemContainer then
		var_14_0 = 1
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_14_1 = arg_14_0._categoryItemContainer[var_14_0].tabId

	arg_14_0:_switchTab(var_14_1)
end

function var_0_0._switchTab(arg_15_0, arg_15_1)
	if arg_15_0._selectSecondTabId ~= arg_15_1 and arg_15_0._jumpTab == nil then
		arg_15_0._jumpTab = arg_15_1

		local var_15_0 = arg_15_0._selectThirdTabId ~= 0 and arg_15_0._selectThirdTabId or arg_15_0._selectSecondTabId
		local var_15_1 = StoreConfig.instance:getStoreRecommendConfig(var_15_0)

		if var_15_1.prefab > 0 then
			local var_15_2 = arg_15_0._tabView._tabViews[var_15_1.prefab]

			if var_15_2.switchClose then
				var_15_2:switchClose(arg_15_0._onSwitchCloseAnimDone, arg_15_0)
			else
				arg_15_0:_onSwitchCloseAnimDone()
			end
		else
			arg_15_0.animatorPlayer:Play(UIAnimationName.Close, arg_15_0._onSwitchCloseAnimDone, arg_15_0)
		end

		TaskDispatcher.runDelay(arg_15_0._onSwitchCloseAnimDone, arg_15_0, 2)

		arg_15_0._selectSecondTabId = arg_15_1

		arg_15_0:_refreshTabsItem()
	end
end

function var_0_0._onSwitchCloseAnimDone(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._onSwitchCloseAnimDone, arg_16_0)
	arg_16_0:_refreshTabs(arg_16_0._jumpTab)
	arg_16_0:refreshRightPage()
	StoreController.instance:statSwitchStore(arg_16_0._jumpTab)

	arg_16_0._jumpTab = nil
end

function var_0_0._resetIgnoreClick(arg_17_0)
	arg_17_0._ignoreClick = false
end

function var_0_0.onOpen(arg_18_0)
	local var_18_0 = StoreModel.instance:getMonthCardInfo()

	arg_18_0._hasMonthCard = false

	if var_18_0 ~= nil then
		arg_18_0._hasMonthCard = var_18_0:getRemainDay() ~= StoreEnum.MonthCardStatus.NotPurchase
	end

	arg_18_0._tabView:onOpen()
	arg_18_0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_18_0._refreshTabsItem, arg_18_0)
	arg_18_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_18_0._refreshTabsItem, arg_18_0)
	arg_18_0:addEventCb(ActivityController.instance, ActivityEvent.ChangeActivityStage, arg_18_0._onRefreshRedDot, arg_18_0)
	arg_18_0:addEventCb(StoreController.instance, StoreEvent.SetVisibleInternal, arg_18_0._onSetVisibleInternal, arg_18_0)
	arg_18_0:addEventCb(StoreController.instance, StoreEvent.SetAutoToNextPage, arg_18_0._onSetAutoToNextPage, arg_18_0)
	arg_18_0._click:AddClickListener(arg_18_0._onClickRecommend, arg_18_0)

	arg_18_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_18_0._gosubViewContainer)

	arg_18_0._drag:AddDragBeginListener(arg_18_0._onDragBegin, arg_18_0)
	arg_18_0._drag:AddDragEndListener(arg_18_0._onDragEnd, arg_18_0)
	arg_18_0._drag:AddDragListener(arg_18_0._onDrag, arg_18_0)
	arg_18_0._categoryscrollRect:AddOnValueChanged(arg_18_0._onCategoryscrollValueChanged, arg_18_0)

	arg_18_0._selectFirstTabId = arg_18_0.viewContainer:getSelectFirstTabId()

	local var_18_1 = arg_18_0.viewContainer:getJumpTabId()

	arg_18_0:refreshUI(var_18_1, true)
end

function var_0_0.refreshUI(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:_refreshTabs(arg_19_1, arg_19_2)
end

function var_0_0._refreshTabs(arg_20_0, arg_20_1, arg_20_2)
	TaskDispatcher.cancelTask(arg_20_0._toNextTab, arg_20_0)
	TaskDispatcher.runDelay(arg_20_0._toNextTab, arg_20_0, var_0_0.AutoToNextTime)

	local var_20_0 = arg_20_0._selectSecondTabId
	local var_20_1 = arg_20_0._selectThirdTabId

	arg_20_0._selectSecondTabId = arg_20_1
	arg_20_0._selectThirdTabId = 0

	local var_20_2 = StoreConfig.instance:getTabConfig(arg_20_0._selectThirdTabId)
	local var_20_3 = StoreConfig.instance:getTabConfig(arg_20_0._selectSecondTabId)
	local var_20_4 = StoreConfig.instance:getTabConfig(arg_20_0.viewContainer:getSelectFirstTabId())

	if var_20_2 and not string.nilorempty(var_20_2.showCost) then
		arg_20_0.viewContainer:setCurrencyType(var_20_2.showCost)
	elseif var_20_3 and not string.nilorempty(var_20_3.showCost) then
		arg_20_0.viewContainer:setCurrencyType(var_20_3.showCost)
	elseif var_20_4 and not string.nilorempty(var_20_4.showCost) then
		arg_20_0.viewContainer:setCurrencyType(var_20_4.showCost)
	else
		arg_20_0.viewContainer:setCurrencyType(nil)
	end

	if not arg_20_2 and var_20_0 == arg_20_0._selectSecondTabId and var_20_1 == arg_20_0._selectThirdTabId then
		return
	end

	local var_20_5 = arg_20_0:_refreshTabsItem()

	if #var_20_5 > 0 then
		StoreRpc.instance:sendGetStoreInfosRequest(var_20_5)
	end

	arg_20_0:refreshRightPage()
end

function var_0_0._refreshTabsItem(arg_21_0)
	local var_21_0, var_21_1 = StoreHelper.getRecommendStoreSecondTabConfig()

	arg_21_0._showSecondTabConfigs = var_21_0

	arg_21_0:sortPage(var_21_0)

	local var_21_2 = false

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1.id == arg_21_0._selectSecondTabId then
			var_21_2 = true

			break
		end
	end

	if not var_21_2 then
		arg_21_0._selectSecondTabId = var_21_0[1].id
	end

	arg_21_0._tabIdList = {}

	local var_21_3 = {}

	for iter_21_2 = 1, #var_21_0 do
		local var_21_4 = var_21_0[iter_21_2]

		table.insert(arg_21_0._tabIdList, var_21_4.id)
		arg_21_0:_refreshSecondTabs(iter_21_2, var_21_4)
		gohelper.setActive(arg_21_0._categoryItemContainer[iter_21_2].go, true)
		gohelper.setActive(arg_21_0._categoryItemContainer[iter_21_2].sliderGo, true)

		local var_21_5 = arg_21_0._categoryItemContainer[iter_21_2].go.transform.rect.width

		if var_21_5 > 0 then
			local var_21_6 = var_21_5
			local var_21_7 = 0

			if iter_21_2 > 1 and arg_21_0._categoryItemContainer[iter_21_2 - 1] and var_21_3[iter_21_2 - 1] and var_21_3[iter_21_2 - 1].totalWidth then
				var_21_6 = var_21_3[iter_21_2 - 1].totalWidth + var_21_5

				local var_21_8 = arg_21_0._categoryscroll.transform.rect.width

				var_21_7 = -var_21_6 + var_21_8
			end

			var_21_3[iter_21_2] = {
				width = var_21_5,
				totalWidth = var_21_6,
				pos = Mathf.Min(var_21_7, 0)
			}
		end
	end

	gohelper.setActive(arg_21_0._categoryItemContainer[#var_21_0].go_line, false)

	for iter_21_3 = #var_21_0 + 1, #arg_21_0._categoryItemContainer do
		arg_21_0._categoryItemContainer[iter_21_3].btn:RemoveClickListener()
		gohelper.destroy(arg_21_0._categoryItemContainer[iter_21_3].go)

		arg_21_0._categoryItemContainer[iter_21_3] = nil
	end

	if var_21_3 and var_21_3[arg_21_0._nowIndex] and var_21_3[arg_21_0._nowIndex].pos then
		local var_21_9 = var_21_3[arg_21_0._nowIndex].pos

		recthelper.setAnchorX(arg_21_0._categorycontentTrans, var_21_9)
	else
		local var_21_10 = -300 * (arg_21_0._nowIndex - 5) - 50
		local var_21_11 = -300 * (arg_21_0._nowIndex - 1)
		local var_21_12 = recthelper.getAnchorX(arg_21_0._categorycontentTrans)

		if var_21_12 < var_21_11 then
			recthelper.setAnchorX(arg_21_0._categorycontentTrans, var_21_11)
		elseif var_21_10 < var_21_12 then
			recthelper.setAnchorX(arg_21_0._categorycontentTrans, var_21_10)
		end
	end

	arg_21_0:_onRefreshRedDot()

	return var_21_1
end

function var_0_0._tabSortFunction(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = string.splitToNumber(arg_22_1.adjustOrder, "#")
	local var_22_1 = string.splitToNumber(arg_22_2.adjustOrder, "#")
	local var_22_2 = arg_22_1.order
	local var_22_3 = arg_22_2.order

	if arg_22_0:_checkSortType(var_22_0) then
		var_22_2 = var_22_0[1]
	end

	if arg_22_0:_checkSortType(var_22_1) then
		var_22_3 = var_22_1[1]
	end

	return var_22_2 < var_22_3
end

function var_0_0.sortPage(arg_23_0, arg_23_1)
	arg_23_0:_cacheConfigGroupData(arg_23_1)
	table.sort(arg_23_1, function(arg_24_0, arg_24_1)
		return arg_23_0:_tabSortGroupFunction(arg_24_0, arg_24_1)
	end)

	arg_23_0._cacheConfigGroupDic = {}
	arg_23_0._cacheConfigOrderDic = {}
end

function var_0_0._cacheConfigGroupData(arg_25_0, arg_25_1)
	arg_25_0._cacheConfigGroupDic = {}
	arg_25_0._cacheConfigOrderDic = {}

	if not arg_25_1 or #arg_25_1 <= 0 then
		return
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		local var_25_0, var_25_1 = StoreHelper.getRecommendStoreGroupAndOrder(iter_25_1, true)

		arg_25_0._cacheConfigGroupDic[iter_25_1.id] = var_25_0
		arg_25_0._cacheConfigOrderDic[iter_25_1.id] = var_25_1
	end
end

function var_0_0._tabSortGroupFunction(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0._cacheConfigGroupDic[arg_26_1.id]
	local var_26_1 = arg_26_0._cacheConfigGroupDic[arg_26_2.id]

	if var_26_0 == var_26_1 then
		return arg_26_0._cacheConfigOrderDic[arg_26_1.id] < arg_26_0._cacheConfigOrderDic[arg_26_2.id]
	end

	return var_26_0 < var_26_1
end

function var_0_0._checkSortType(arg_27_0, arg_27_1)
	if arg_27_1[2] == StoreEnum.AdjustOrderType.MonthCard and arg_27_0._hasMonthCard then
		return true
	end
end

function var_0_0._refreshSecondTabs(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0._categoryItemContainer[arg_28_1] or arg_28_0:initCategoryItemTable(arg_28_1)

	var_28_0.tabConfig = arg_28_2
	var_28_0.tabId = arg_28_2.id
	var_28_0.txt_itemcn1.text = arg_28_2.name
	var_28_0.txt_itemcn2.text = arg_28_2.name
	var_28_0.txt_itemen1.text = arg_28_2.nameEn
	var_28_0.txt_itemen2.text = arg_28_2.nameEn

	local var_28_1 = arg_28_0._selectSecondTabId == arg_28_2.id

	gohelper.setActive(arg_28_0._categoryItemContainer[arg_28_1].go_line, true)

	if var_28_1 then
		arg_28_0._nowIndex = arg_28_1

		if arg_28_0._categoryItemContainer[arg_28_1 - 1] then
			gohelper.setActive(arg_28_0._categoryItemContainer[arg_28_1 - 1].go_line, false)
		end
	end

	gohelper.setActive(var_28_0.go_timelimit, not string.nilorempty(arg_28_2.openTime) and not string.nilorempty(arg_28_2.endTime))
	gohelper.setActive(var_28_0.go_unselected, not var_28_1)
	gohelper.setActive(var_28_0.go_sliderUnselected, not var_28_1)
	gohelper.setActive(var_28_0.go_selected, var_28_1)
	gohelper.setActive(var_28_0.go_sliderSelected, var_28_1)
end

function var_0_0.initCategoryItemTable(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getUserDataTb_()

	var_29_0.go = gohelper.cloneInPlace(arg_29_0._gostorecategoryitem, "item" .. arg_29_1)
	var_29_0.go_unselected = gohelper.findChild(var_29_0.go, "go_unselected")
	var_29_0.go_selected = gohelper.findChild(var_29_0.go, "go_selected")
	var_29_0.go_timelimit = gohelper.findChild(var_29_0.go, "go_timellimit")
	var_29_0.go_reddot = gohelper.findChild(var_29_0.go, "#go_tabreddot1")
	var_29_0.go_reddotType1 = gohelper.findChild(var_29_0.go, "#go_tabreddot1/type1")
	var_29_0.go_reddotType5 = gohelper.findChild(var_29_0.go, "#go_tabreddot1/type5")
	var_29_0.txt_itemcn1 = gohelper.findChildText(var_29_0.go, "go_unselected/txt_itemcn1")
	var_29_0.txt_itemen1 = gohelper.findChildText(var_29_0.go, "go_unselected/txt_itemen1")
	var_29_0.txt_itemcn2 = gohelper.findChildText(var_29_0.go, "go_selected/txt_itemcn2")
	var_29_0.txt_itemen2 = gohelper.findChildText(var_29_0.go, "go_selected/txt_itemen2")
	var_29_0.go_childcategory = gohelper.findChild(var_29_0.go, "go_childcategory")
	var_29_0.go_childItem = gohelper.findChild(var_29_0.go, "go_childcategory/go_childitem")
	var_29_0.go_line = gohelper.findChild(var_29_0.go, "#go_line")
	var_29_0.btn = gohelper.getClickWithAudio(var_29_0.go, AudioEnum.UI.Play_UI_Universal_Click)
	var_29_0.tabId = 0
	var_29_0.sliderGo = gohelper.cloneInPlace(arg_29_0._sliderGo, "item" .. arg_29_1)
	var_29_0.go_sliderSelected = gohelper.findChild(var_29_0.sliderGo, "#go_lightstar")
	var_29_0.go_sliderUnselected = gohelper.findChild(var_29_0.sliderGo, "#go_nomalstar")

	var_29_0.btn:AddClickListener(function(arg_30_0)
		local var_30_0 = arg_30_0.tabId

		StoreController.instance:enterRecommendStore(var_30_0)
		arg_29_0:_switchTab(var_30_0)
	end, var_29_0)
	table.insert(arg_29_0._categoryItemContainer, var_29_0)

	var_29_0.go_reddotTrs = var_29_0.go_reddot.transform
	var_29_0.goTrs = var_29_0.go.transform

	gohelper.setActive(var_29_0.go_childItem, false)

	return var_29_0
end

function var_0_0._createBubbleTb(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:getUserDataTb_()

	var_31_0.go = arg_31_1
	var_31_0.animator = arg_31_1:GetComponent(gohelper.Type_Animator)
	var_31_0.btn = arg_31_2

	return var_31_0
end

function var_0_0._setBubbleTbActive(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_2 == true

	if arg_32_1.isShow ~= var_32_0 then
		arg_32_1.isShow = var_32_0

		gohelper.setActive(arg_32_1.btn, var_32_0)

		arg_32_1.keepTime = Time.time + 0.3

		if var_32_0 then
			gohelper.setActive(arg_32_1.go, var_32_0)
		end

		arg_32_1.animator:Play(var_32_0 and "open" or "close")
	elseif arg_32_1.keepTime and arg_32_1.keepTime < Time.time then
		arg_32_1.keepTime = nil

		gohelper.setActive(arg_32_1.go, arg_32_1.isShow)
	end
end

function var_0_0._onRefreshRedDot(arg_33_0)
	for iter_33_0, iter_33_1 in pairs(arg_33_0._categoryItemContainer) do
		local var_33_0 = false

		if StoreModel.instance:isTabFirstRedDotShow(iter_33_1.tabId) then
			var_33_0 = true

			gohelper.setActive(iter_33_1.go_reddot, true)
			gohelper.setActive(iter_33_1.go_reddotType1, true)
			gohelper.setActive(iter_33_1.go_reddotType5, false)
		elseif StoreController.instance:isNeedShowRedDotNewTag(iter_33_1.tabConfig) and not StoreController.instance:isEnteredRecommendStore(iter_33_1.tabConfig.id) then
			var_33_0 = true

			gohelper.setActive(iter_33_1.go_reddot, true)
			gohelper.setActive(iter_33_1.go_reddotType1, false)
			gohelper.setActive(iter_33_1.go_reddotType5, true)
		else
			gohelper.setActive(iter_33_1.go_reddot, false)
		end

		arg_33_0._tabIdRedDotFlagDict[iter_33_1.tabId] = var_33_0
	end

	arg_33_0:_onRefreshBubbleRedDot()
end

function var_0_0._onRefreshBubbleRedDot(arg_34_0)
	if not arg_34_0._isHasWaitRunLRRedDotTask then
		arg_34_0._isHasWaitRunLRRedDotTask = true

		TaskDispatcher.runDelay(arg_34_0._onRunLRRedDotTask, arg_34_0, 0.1)
	end
end

function var_0_0._onRunLRRedDotTask(arg_35_0)
	arg_35_0._isHasWaitRunLRRedDotTask = false
	arg_35_0._leftRedDotTabId = nil
	arg_35_0._rightRedDotTabId = nil

	if not arg_35_0._categoryscrollTrsLeftX or not arg_35_0._categoryscrollTrsRightX then
		local var_35_0 = recthelper.getWidth(arg_35_0._categoryscrollTrs)
		local var_35_1 = arg_35_0._categoryscrollTrs.pivot.x
		local var_35_2 = arg_35_0._categoryscrollTrs:TransformPoint(Vector3(-var_35_0 * var_35_1, 0, 0))
		local var_35_3 = arg_35_0._categoryscrollTrs:TransformPoint(Vector3(var_35_0 * (1 - var_35_1), 0, 0))

		arg_35_0._categoryscrollTrsLeftX = var_35_2.x
		arg_35_0._categoryscrollTrsRightX = var_35_3.x
	end

	for iter_35_0, iter_35_1 in ipairs(arg_35_0._categoryItemContainer) do
		if iter_35_1 and arg_35_0._tabIdRedDotFlagDict[iter_35_1.tabId] and not gohelper.isNil(iter_35_1.go_reddotTrs) then
			local var_35_4 = iter_35_1.go_reddotTrs.position.x

			if var_35_4 < arg_35_0._categoryscrollTrsLeftX then
				arg_35_0._leftRedDotTabId = iter_35_1.tabId
			elseif not arg_35_0._rightRedDotTabId and var_35_4 > arg_35_0._categoryscrollTrsRightX then
				arg_35_0._rightRedDotTabId = iter_35_1.tabId
			end
		end

		if arg_35_0._leftRedDotTabId and arg_35_0._rightRedDotTabId then
			break
		end
	end

	arg_35_0:_setBubbleTbActive(arg_35_0._bubbleTbLeft, arg_35_0._leftRedDotTabId ~= nil)
	arg_35_0:_setBubbleTbActive(arg_35_0._bubbleTbRight, arg_35_0._rightRedDotTabId ~= nil)
end

function var_0_0._moveToTabId(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getIndexByTabId(arg_36_1)
	local var_36_1 = arg_36_0._categoryItemContainer[var_36_0]

	if not var_36_1 or gohelper.isNil(var_36_1.goTrs) then
		return
	end

	local var_36_2 = recthelper.getWidth(arg_36_0._categorycontentTrans) - recthelper.getWidth(arg_36_0._categoryscrollTrs)

	if var_36_2 <= 0 then
		return
	end

	local var_36_3 = recthelper.getWidth(var_36_1.goTrs)
	local var_36_4 = recthelper.getAnchorX(var_36_1.goTrs)
	local var_36_5 = var_36_1.goTrs.pivot.x
	local var_36_6 = var_36_4 - var_36_3 * var_36_5
	local var_36_7 = var_36_4 + var_36_3 * (1 - var_36_5)

	arg_36_0._categoryscrollRect.horizontalNormalizedPosition = var_36_6 / var_36_2
end

function var_0_0.refreshRightPage(arg_37_0)
	local var_37_0 = arg_37_0._selectThirdTabId ~= 0 and arg_37_0._selectThirdTabId or arg_37_0._selectSecondTabId
	local var_37_1 = StoreConfig.instance:getStoreRecommendConfig(var_37_0)

	if var_37_1.prefab > 0 then
		gohelper.setActive(arg_37_0._gomonthcard, true)
		gohelper.setActive(arg_37_0._simagerecommend.gameObject, false)

		if arg_37_0._tabView then
			local var_37_2 = arg_37_0._tabView:getCurTabId()
			local var_37_3 = arg_37_0._tabView._tabViews[var_37_2]

			if var_37_3 then
				var_37_3:stopAnimator()
			end
		end

		arg_37_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 4, var_37_1.prefab)
	else
		gohelper.setActive(arg_37_0._gomonthcard, false)
		gohelper.setActive(arg_37_0._simagerecommend.gameObject, true)
		arg_37_0._simagerecommend:LoadImage(ResUrl.getStoreRecommend(var_37_1.res))

		arg_37_0._animator.enabled = true

		arg_37_0._animator:Play(UIAnimationName.Open, 0, 0)
		arg_37_0._animator:Update(0)
	end
end

function var_0_0.onClose(arg_38_0)
	arg_38_0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_38_0._refreshTabsItem, arg_38_0)
	arg_38_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_38_0._refreshTabsItem, arg_38_0)
	arg_38_0:removeEventCb(StoreController.instance, StoreEvent.SetVisibleInternal, arg_38_0._onSetVisibleInternal, arg_38_0)
	arg_38_0:removeEventCb(StoreController.instance, StoreEvent.SetAutoToNextPage, arg_38_0._onSetAutoToNextPage, arg_38_0)

	local var_38_0 = arg_38_0._tabView:getCurTabId()
	local var_38_1 = arg_38_0._tabView._tabViews[var_38_0]

	if var_38_1 then
		var_38_1:stopAnimator()
	end

	arg_38_0._tabView:onClose()
	arg_38_0._click:RemoveClickListener()
	arg_38_0._drag:RemoveDragBeginListener()
	arg_38_0._drag:RemoveDragEndListener()
	arg_38_0._drag:RemoveDragListener()
	arg_38_0._categoryscrollRect:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(arg_38_0._toNextTab, arg_38_0)

	arg_38_0._ignoreClick = false

	arg_38_0.animatorPlayer:Stop()

	arg_38_0._jumpTab = nil
	arg_38_0._isHasWaitRunLRRedDotTask = false

	TaskDispatcher.cancelTask(arg_38_0._onSwitchCloseAnimDone, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._resetIgnoreClick, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._onRunLRRedDotTask, arg_38_0, 0.1)
end

function var_0_0._onSetVisibleInternal(arg_39_0, arg_39_1)
	if arg_39_1 then
		TaskDispatcher.cancelTask(arg_39_0._toNextTab, arg_39_0)
		TaskDispatcher.runDelay(arg_39_0._toNextTab, arg_39_0, var_0_0.AutoToNextTime)
	else
		TaskDispatcher.cancelTask(arg_39_0._toNextTab, arg_39_0)
	end
end

function var_0_0._onSetAutoToNextPage(arg_40_0, arg_40_1)
	if arg_40_1 then
		TaskDispatcher.cancelTask(arg_40_0._toNextTab, arg_40_0)
		TaskDispatcher.runDelay(arg_40_0._toNextTab, arg_40_0, var_0_0.AutoToNextTime)
	else
		TaskDispatcher.cancelTask(arg_40_0._toNextTab, arg_40_0)
	end
end

function var_0_0.onUpdateParam(arg_41_0)
	arg_41_0._selectFirstTabId = arg_41_0.viewContainer:getSelectFirstTabId()

	local var_41_0 = arg_41_0.viewContainer:getJumpTabId()

	arg_41_0:refreshUI(var_41_0)
end

function var_0_0.onDestroyView(arg_42_0)
	if arg_42_0._categoryItemContainer and #arg_42_0._categoryItemContainer > 0 then
		for iter_42_0 = 1, #arg_42_0._categoryItemContainer do
			arg_42_0._categoryItemContainer[iter_42_0].btn:RemoveClickListener()
		end
	end

	arg_42_0._simagebg:UnLoadImage()
	arg_42_0._simagerecommend:UnLoadImage()
	arg_42_0._tabView:removeEvents()
	arg_42_0._tabView:onDestroyView()
	TaskDispatcher.cancelTask(arg_42_0._toNextTab, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._onSwitchCloseAnimDone, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._resetIgnoreClick, arg_42_0)
end

function var_0_0.getIndexByTabId(arg_43_0, arg_43_1)
	return tabletool.indexOf(arg_43_0._tabIdList, arg_43_1) or 1
end

return var_0_0
