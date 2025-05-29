module("modules.logic.dungeon.view.rolestory.RoleStoryView", package.seeall)

local var_0_0 = class("RoleStoryView", BaseRoleStoryView)

function var_0_0.onInit(arg_1_0)
	arg_1_0.resPathList = {
		itemRes = "ui/viewres/dungeon/rolestory/rolestoryitem.prefab",
		mainRes = "ui/viewres/dungeon/rolestory/rolestoryview.prefab",
		tankRes = RoleStoryTank.prefabPath
	}
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.simageFullBg = gohelper.findChildSingleImage(arg_2_0.viewGO, "BG/#simage_FullBG")

	arg_2_0.simageFullBg:LoadImage(ResUrl.getRoleStoryIcon("rolestory_fullbg_7"))

	arg_2_0.goRewardPanel = gohelper.findChild(arg_2_0.viewGO, "goRewardPanel")
	arg_2_0.btnclose = gohelper.findChildButtonWithAudio(arg_2_0.goRewardPanel, "btnclose")
	arg_2_0.goNode = gohelper.findChild(arg_2_0.goRewardPanel, "#go_node")
	arg_2_0.rewardContent = gohelper.findChild(arg_2_0.goRewardPanel, "#go_node/Content")
	arg_2_0.rewardItems = {}
	arg_2_0.currencyViewGO = gohelper.findChild(arg_2_0.viewGO, "#go_topright/currencyview")
	arg_2_0.currencyTxt = gohelper.findChildText(arg_2_0.currencyViewGO, "#go_container/#go_currency/#btn_currency/#txt")
	arg_2_0.btnCurrency = gohelper.findChildButtonWithAudio(arg_2_0.currencyViewGO, "#go_container/#go_currency/#btn_currency")
	arg_2_0.currencyImage = gohelper.findChildImage(arg_2_0.currencyViewGO, "#go_container/#go_currency/#btn_currency/#image")
	arg_2_0.currencyAnim = arg_2_0.currencyViewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0.currencyId = CurrencyEnum.CurrencyType.RoleStory

	RoleStoryListModel.instance:markUnlockOrder()

	arg_2_0._gotank = gohelper.findChild(arg_2_0.viewGO, "#go_tank")

	local var_2_0 = arg_2_0:getResInst(arg_2_0.resPathList.tankRes, arg_2_0._gotank)

	arg_2_0.roleStoryTank = RoleStoryTank.New(var_2_0)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0.btnclose:AddClickListener(arg_3_0.onClickClose, arg_3_0)
	arg_3_0.btnCurrency:AddClickListener(arg_3_0._btncurrencyOnClick, arg_3_0)
	arg_3_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, arg_3_0.showReward, arg_3_0)
	arg_3_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_3_0._onFullViewOpenOrClose, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_3_0._onFullViewOpenOrClose, arg_3_0)
	arg_3_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, arg_3_0._onUpdateInfo, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0.btnclose:RemoveClickListener()
	arg_4_0.btnCurrency:RemoveClickListener()
	arg_4_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, arg_4_0.showReward, arg_4_0)
	arg_4_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0._onCurrencyChange, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_4_0._onFullViewOpenOrClose, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_4_0._onFullViewOpenOrClose, arg_4_0)
	arg_4_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, arg_4_0._onUpdateInfo, arg_4_0)
end

function var_0_0._onUpdateInfo(arg_5_0)
	arg_5_0:onShow()
end

function var_0_0._onFullViewOpenOrClose(arg_6_0)
	local var_6_0 = ViewMgr.instance:getContainer(ViewName.DungeonView)

	if var_6_0 and arg_6_0._scrollView then
		if var_6_0._isVisible and arg_6_0.isShow then
			arg_6_0._scrollView:onOpen()
		else
			arg_6_0._scrollView:onCloseFinish()
		end
	end
end

function var_0_0.onShow(arg_7_0)
	if arg_7_0._scrollView then
		arg_7_0._scrollView:removeEventsInternal()
		arg_7_0._scrollView:onDestroyViewInternal()
		arg_7_0._scrollView:__onDispose()
	end

	arg_7_0._scrollView = nil

	arg_7_0:buildScroll()
	RoleStoryListModel.instance:refreshList()

	local var_7_0 = ViewMgr.instance:getContainer(ViewName.DungeonView)

	if var_7_0 and arg_7_0._scrollView and var_7_0._isVisible then
		arg_7_0._scrollView:onOpen()
	end

	arg_7_0.currencyAnim:Play("currencyview_in")
	arg_7_0:refreshCurrency()
	arg_7_0.roleStoryTank:onOpen()
end

function var_0_0.onHide(arg_8_0)
	if arg_8_0._scrollView then
		arg_8_0._scrollView:onCloseFinish()
	end

	arg_8_0:onClickClose()
	arg_8_0.currencyAnim:Play("currencyview_out")
end

function var_0_0.buildScroll(arg_9_0)
	if arg_9_0._scrollView then
		return
	end

	local var_9_0 = ListScrollParam.New()

	var_9_0.scrollGOPath = "RoleChapterList/#Scroll_RoleChapter"
	var_9_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_9_0.prefabUrl = arg_9_0.resPathList.itemRes
	var_9_0.cellClass = RoleStoryItem
	var_9_0.scrollDir = ScrollEnum.ScrollDirH
	var_9_0.lineCount = 1
	var_9_0.cellWidth = 474
	var_9_0.cellHeight = 640
	var_9_0.cellSpaceH = 156
	var_9_0.cellSpaceV = 0
	var_9_0.startSpace = 145
	var_9_0.endSpace = 100
	var_9_0.sortMode = ScrollEnum.ScrollSortUp
	arg_9_0._scrollView = LuaListScrollView.New(RoleStoryListModel.instance, var_9_0)
	arg_9_0._scrollView.isFirst = true

	function arg_9_0._scrollView.onUpdateFinish(arg_10_0)
		arg_10_0.isFirst = false
	end

	arg_9_0._scrollView:__onInit()

	arg_9_0._scrollView.viewGO = arg_9_0.viewGO
	arg_9_0._scrollView.viewName = arg_9_0.viewName
	arg_9_0._scrollView.viewContainer = arg_9_0

	arg_9_0._scrollView:onInitViewInternal()
	arg_9_0._scrollView:addEventsInternal()
end

function var_0_0.onClickClose(arg_11_0)
	gohelper.setActive(arg_11_0.goRewardPanel, false)
end

function var_0_0.showReward(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if not arg_12_1 then
		arg_12_0:onClickClose()

		return
	end

	transformhelper.setPos(arg_12_0.goNode.transform, arg_12_2, arg_12_3, arg_12_4)
	gohelper.setActive(arg_12_0.goRewardPanel, true)

	local var_12_0 = arg_12_1.rewards

	for iter_12_0 = 1, math.max(#var_12_0, #arg_12_0.rewardItems) do
		local var_12_1 = arg_12_0.rewardItems[iter_12_0]
		local var_12_2 = var_12_0[iter_12_0]

		if not var_12_1 then
			var_12_1 = IconMgr.instance:getCommonItemIcon(arg_12_0.rewardContent)
			arg_12_0.rewardItems[iter_12_0] = var_12_1

			transformhelper.setLocalScale(var_12_1.tr, 0.5, 0.5, 1)
		end

		if var_12_2 then
			gohelper.setActive(var_12_1.go, true)
			var_12_1:setMOValue(var_12_2[1], var_12_2[2], var_12_2[3])
			var_12_1:setCountFontSize(42)
		else
			gohelper.setActive(var_12_1.go, false)
		end
	end
end

function var_0_0._onCurrencyChange(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.currencyId

	if not var_13_0 or not arg_13_1[var_13_0] then
		return
	end

	arg_13_0:refreshCurrency()
end

function var_0_0.refreshCurrency(arg_14_0)
	local var_14_0 = arg_14_0.currencyId
	local var_14_1 = CurrencyModel.instance:getCurrency(var_14_0)
	local var_14_2 = CurrencyConfig.instance:getCurrencyCo(var_14_0)
	local var_14_3 = var_14_1 and var_14_1.quantity or 0

	arg_14_0.currencyTxt.text = string.format("%s/%s", GameUtil.numberDisplay(var_14_3), GameUtil.numberDisplay(var_14_2.maxLimit))

	local var_14_4 = var_14_2.icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_14_0.currencyImage, var_14_4 .. "_1")
end

function var_0_0._btncurrencyOnClick(arg_15_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, arg_15_0.currencyId, false)
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0.simageFullBg then
		arg_16_0.simageFullBg:UnLoadImage()

		arg_16_0.simageFullBg = nil
	end

	if arg_16_0._scrollView then
		arg_16_0._scrollView:removeEventsInternal()
		arg_16_0._scrollView:onDestroyViewInternal()
		arg_16_0._scrollView:__onDispose()
	end

	arg_16_0._scrollView = nil

	if arg_16_0.rewardItems then
		for iter_16_0, iter_16_1 in pairs(arg_16_0.rewardItems) do
			iter_16_1:onDestroy()
		end

		arg_16_0.rewardItems = nil
	end

	if arg_16_0.roleStoryTank then
		arg_16_0.roleStoryTank:onDestroy()

		arg_16_0.roleStoryTank = nil
	end
end

return var_0_0
