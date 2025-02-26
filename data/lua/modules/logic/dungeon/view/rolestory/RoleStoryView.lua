module("modules.logic.dungeon.view.rolestory.RoleStoryView", package.seeall)

slot0 = class("RoleStoryView", BaseRoleStoryView)

function slot0.onInit(slot0)
	slot0.resPathList = {
		itemRes = "ui/viewres/dungeon/rolestory/rolestoryitem.prefab",
		mainRes = "ui/viewres/dungeon/rolestory/rolestoryview.prefab",
		tankRes = RoleStoryTank.prefabPath
	}
end

function slot0.onInitView(slot0)
	slot0.simageFullBg = gohelper.findChildSingleImage(slot0.viewGO, "BG/#simage_FullBG")

	slot0.simageFullBg:LoadImage(ResUrl.getRoleStoryIcon("rolestory_fullbg_7"))

	slot0.goRewardPanel = gohelper.findChild(slot0.viewGO, "goRewardPanel")
	slot0.btnclose = gohelper.findChildButtonWithAudio(slot0.goRewardPanel, "btnclose")
	slot0.goNode = gohelper.findChild(slot0.goRewardPanel, "#go_node")
	slot0.rewardContent = gohelper.findChild(slot0.goRewardPanel, "#go_node/Content")
	slot0.rewardItems = {}
	slot0.currencyViewGO = gohelper.findChild(slot0.viewGO, "#go_topright/currencyview")
	slot0.currencyTxt = gohelper.findChildText(slot0.currencyViewGO, "#go_container/#go_currency/#btn_currency/#txt")
	slot0.btnCurrency = gohelper.findChildButtonWithAudio(slot0.currencyViewGO, "#go_container/#go_currency/#btn_currency")
	slot0.currencyImage = gohelper.findChildImage(slot0.currencyViewGO, "#go_container/#go_currency/#btn_currency/#image")
	slot0.currencyAnim = slot0.currencyViewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.currencyId = CurrencyEnum.CurrencyType.RoleStory

	RoleStoryListModel.instance:markUnlockOrder()

	slot0._gotank = gohelper.findChild(slot0.viewGO, "#go_tank")
	slot0.roleStoryTank = RoleStoryTank.New(slot0:getResInst(slot0.resPathList.tankRes, slot0._gotank))
end

function slot0.addEvents(slot0)
	slot0.btnclose:AddClickListener(slot0.onClickClose, slot0)
	slot0.btnCurrency:AddClickListener(slot0._btncurrencyOnClick, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, slot0.showReward, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onFullViewOpenOrClose, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onFullViewOpenOrClose, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnclose:RemoveClickListener()
	slot0.btnCurrency:RemoveClickListener()
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, slot0.showReward, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onFullViewOpenOrClose, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onFullViewOpenOrClose, slot0)
end

function slot0._onFullViewOpenOrClose(slot0)
	if ViewMgr.instance:getContainer(ViewName.DungeonView) and slot0._scrollView then
		if slot1._isVisible and slot0.isShow then
			slot0._scrollView:onOpen()
		else
			slot0._scrollView:onCloseFinish()
		end
	end
end

function slot0.onShow(slot0)
	if slot0._scrollView then
		slot0._scrollView:removeEventsInternal()
		slot0._scrollView:onDestroyViewInternal()
		slot0._scrollView:__onDispose()
	end

	slot0._scrollView = nil

	slot0:buildScroll()
	RoleStoryListModel.instance:refreshList()

	if ViewMgr.instance:getContainer(ViewName.DungeonView) and slot0._scrollView and slot1._isVisible then
		slot0._scrollView:onOpen()
	end

	slot0.currencyAnim:Play("currencyview_in")
	slot0:refreshCurrency()
	slot0.roleStoryTank:onOpen()
end

function slot0.onHide(slot0)
	if slot0._scrollView then
		slot0._scrollView:onCloseFinish()
	end

	slot0:onClickClose()
	slot0.currencyAnim:Play("currencyview_out")
end

function slot0.buildScroll(slot0)
	if slot0._scrollView then
		return
	end

	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "RoleChapterList/#Scroll_RoleChapter"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0.resPathList.itemRes
	slot1.cellClass = RoleStoryItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 474
	slot1.cellHeight = 640
	slot1.cellSpaceH = 156
	slot1.cellSpaceV = 0
	slot1.startSpace = 145
	slot1.endSpace = 100
	slot1.sortMode = ScrollEnum.ScrollSortUp
	slot0._scrollView = LuaListScrollView.New(RoleStoryListModel.instance, slot1)
	slot0._scrollView.isFirst = true

	function slot0._scrollView.onUpdateFinish(slot0)
		slot0.isFirst = false
	end

	slot0._scrollView:__onInit()

	slot0._scrollView.viewGO = slot0.viewGO
	slot0._scrollView.viewName = slot0.viewName
	slot0._scrollView.viewContainer = slot0

	slot0._scrollView:onInitViewInternal()
	slot0._scrollView:addEventsInternal()
end

function slot0.onClickClose(slot0)
	gohelper.setActive(slot0.goRewardPanel, false)
end

function slot0.showReward(slot0, slot1, slot2, slot3, slot4)
	if not slot1 then
		slot0:onClickClose()

		return
	end

	transformhelper.setPos(slot0.goNode.transform, slot2, slot3, slot4)
	gohelper.setActive(slot0.goRewardPanel, true)

	slot9 = #slot0.rewardItems

	for slot9 = 1, math.max(#slot1.rewards, slot9) do
		slot11 = slot5[slot9]

		if not slot0.rewardItems[slot9] then
			slot10 = IconMgr.instance:getCommonItemIcon(slot0.rewardContent)
			slot0.rewardItems[slot9] = slot10

			transformhelper.setLocalScale(slot10.tr, 0.5, 0.5, 1)
		end

		if slot11 then
			gohelper.setActive(slot10.go, true)
			slot10:setMOValue(slot11[1], slot11[2], slot11[3])
			slot10:setCountFontSize(42)
		else
			gohelper.setActive(slot10.go, false)
		end
	end
end

function slot0._onCurrencyChange(slot0, slot1)
	if not slot0.currencyId or not slot1[slot2] then
		return
	end

	slot0:refreshCurrency()
end

function slot0.refreshCurrency(slot0)
	slot1 = slot0.currencyId
	slot3 = CurrencyConfig.instance:getCurrencyCo(slot1)
	slot0.currencyTxt.text = string.format("%s/%s", GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(slot1) and slot2.quantity or 0), GameUtil.numberDisplay(slot3.maxLimit))

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.currencyImage, slot3.icon .. "_1")
end

function slot0._btncurrencyOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, slot0.currencyId, false)
end

function slot0.onDestroyView(slot0)
	if slot0.simageFullBg then
		slot0.simageFullBg:UnLoadImage()

		slot0.simageFullBg = nil
	end

	if slot0._scrollView then
		slot0._scrollView:removeEventsInternal()
		slot0._scrollView:onDestroyViewInternal()
		slot0._scrollView:__onDispose()
	end

	slot0._scrollView = nil

	if slot0.rewardItems then
		for slot4, slot5 in pairs(slot0.rewardItems) do
			slot5:onDestroy()
		end

		slot0.rewardItems = nil
	end

	if slot0.roleStoryTank then
		slot0.roleStoryTank:onDestroy()

		slot0.roleStoryTank = nil
	end
end

return slot0
