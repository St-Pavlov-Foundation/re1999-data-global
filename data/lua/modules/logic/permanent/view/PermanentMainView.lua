module("modules.logic.permanent.view.PermanentMainView", package.seeall)

slot0 = class("PermanentMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "BG/#simage_FullBG")
	slot0._gotank = gohelper.findChild(slot0.viewGO, "#go_tank")
	slot0._gocurrency = gohelper.findChild(slot0.viewGO, "#go_topright/currencyview")
	slot0._txtcurrency = gohelper.findChildText(slot0._gocurrency, "#go_container/#go_currency/#btn_currency/#txt_num")
	slot0._btncurrency = gohelper.findChildButtonWithAudio(slot0._gocurrency, "#go_container/#go_currency/#btn_currency")
	slot0._imagecurrency = gohelper.findChildImage(slot0._gocurrency, "#go_container/#go_currency/#btn_currency/#image")
	slot0._animCurrency = slot0._gocurrency:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncurrency:AddClickListener(slot0._btncurrencyOnClick, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncurrency:RemoveClickListener()
end

function slot0._btncurrencyOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, slot0.currencyId, false)
end

function slot0._editableInitView(slot0)
	slot0.roleStoryTank = RoleStoryTank.New(slot0:getResInst(RoleStoryTank.prefabPath, slot0._gotank))
	slot0.currencyId = CurrencyEnum.CurrencyType.RoleStory

	slot0:buildScroll()
	PermanentModel.instance:undateActivityInfo()
end

function slot0.onOpen(slot0)
	PermanentActivityListModel.instance:refreshList()

	if slot0._scrollView and slot0.viewGO.activeInHierarchy then
		slot0._scrollView.playOpen = true

		slot0._scrollView:onOpen()
		TaskDispatcher.runDelay(slot0._delaySet, slot0, 0.1)
	end

	slot0._animCurrency:Play("currencyview_in")
	slot0:refreshCurrency()
	slot0.roleStoryTank:onOpen()
end

function slot0._delaySet(slot0)
	slot0._scrollView.playOpen = false
end

function slot0.onClose(slot0)
	slot0._animCurrency:Play("currencyview_out")

	if slot0._scrollView then
		slot0._scrollView:onCloseFinish()
	end

	TaskDispatcher.cancelTask(slot0._delaySet, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._scrollView then
		slot0._scrollView:removeEventsInternal()
		slot0._scrollView:onDestroyViewInternal()
		slot0._scrollView:__onDispose()
	end

	slot0._scrollView = nil

	if slot0.roleStoryTank then
		slot0.roleStoryTank:onDestroy()

		slot0.roleStoryTank = nil
	end
end

function slot0.buildScroll(slot0)
	if slot0._scrollView then
		return
	end

	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_view"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = "ui/viewres/dungeon/reappear/reappearitem.prefab"
	slot1.cellClass = PermanentMainItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 692
	slot1.cellHeight = 420
	slot1.cellSpaceH = 23
	slot1.cellSpaceV = 0
	slot1.startSpace = 50
	slot1.endSpace = 0
	slot1.sortMode = ScrollEnum.ScrollSortUp
	slot0._scrollView = LuaListScrollView.New(PermanentActivityListModel.instance, slot1)

	slot0._scrollView:__onInit()

	slot0._scrollView.viewGO = slot0.viewGO
	slot0._scrollView.viewName = slot0.viewName
	slot0._scrollView.viewContainer = slot0

	slot0._scrollView:onInitViewInternal()
	slot0._scrollView:addEventsInternal()
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
	slot0._txtcurrency.text = string.format("%s/%s", GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(slot1) and slot2.quantity or 0), GameUtil.numberDisplay(slot3.maxLimit))

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecurrency, slot3.icon .. "_1")
end

function slot0._onFullViewClose(slot0)
	if slot0.viewGO.activeInHierarchy then
		PermanentModel.instance:undateActivityInfo()
	end
end

return slot0
