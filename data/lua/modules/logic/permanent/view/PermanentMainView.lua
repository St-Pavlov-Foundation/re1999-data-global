module("modules.logic.permanent.view.PermanentMainView", package.seeall)

local var_0_0 = class("PermanentMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "BG/#simage_FullBG")
	arg_1_0._gotank = gohelper.findChild(arg_1_0.viewGO, "#go_tank")
	arg_1_0._gocurrency = gohelper.findChild(arg_1_0.viewGO, "#go_topright/currencyview")
	arg_1_0._txtcurrency = gohelper.findChildText(arg_1_0._gocurrency, "#go_container/#go_currency/#btn_currency/#txt_num")
	arg_1_0._btncurrency = gohelper.findChildButtonWithAudio(arg_1_0._gocurrency, "#go_container/#go_currency/#btn_currency")
	arg_1_0._imagecurrency = gohelper.findChildImage(arg_1_0._gocurrency, "#go_container/#go_currency/#btn_currency/#image")
	arg_1_0._animCurrency = arg_1_0._gocurrency:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncurrency:AddClickListener(arg_2_0._btncurrencyOnClick, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncurrency:RemoveClickListener()
end

function var_0_0._btncurrencyOnClick(arg_4_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, arg_4_0.currencyId, false)
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = arg_5_0:getResInst(RoleStoryTank.prefabPath, arg_5_0._gotank)

	arg_5_0.roleStoryTank = RoleStoryTank.New(var_5_0)
	arg_5_0.currencyId = CurrencyEnum.CurrencyType.RoleStory

	arg_5_0:buildScroll()
	PermanentModel.instance:undateActivityInfo()
end

function var_0_0.onOpen(arg_6_0)
	PermanentActivityListModel.instance:refreshList()

	if arg_6_0._scrollView and arg_6_0.viewGO.activeInHierarchy then
		arg_6_0._scrollView.playOpen = true

		arg_6_0._scrollView:onOpen()
		TaskDispatcher.runDelay(arg_6_0._delaySet, arg_6_0, 0.1)
	end

	arg_6_0._animCurrency:Play("currencyview_in")
	arg_6_0:refreshCurrency()
	arg_6_0.roleStoryTank:onOpen()
end

function var_0_0._delaySet(arg_7_0)
	arg_7_0._scrollView.playOpen = false
end

function var_0_0.onClose(arg_8_0)
	arg_8_0._animCurrency:Play("currencyview_out")

	if arg_8_0._scrollView then
		arg_8_0._scrollView:onCloseFinish()
	end

	TaskDispatcher.cancelTask(arg_8_0._delaySet, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	if arg_9_0._scrollView then
		arg_9_0._scrollView:removeEventsInternal()
		arg_9_0._scrollView:onDestroyViewInternal()
		arg_9_0._scrollView:__onDispose()
	end

	arg_9_0._scrollView = nil

	if arg_9_0.roleStoryTank then
		arg_9_0.roleStoryTank:onDestroy()

		arg_9_0.roleStoryTank = nil
	end
end

function var_0_0.buildScroll(arg_10_0)
	if arg_10_0._scrollView then
		return
	end

	local var_10_0 = ListScrollParam.New()

	var_10_0.scrollGOPath = "#scroll_view"
	var_10_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_10_0.prefabUrl = "ui/viewres/dungeon/reappear/reappearitem.prefab"
	var_10_0.cellClass = PermanentMainItem
	var_10_0.scrollDir = ScrollEnum.ScrollDirH
	var_10_0.lineCount = 1
	var_10_0.cellWidth = 692
	var_10_0.cellHeight = 420
	var_10_0.cellSpaceH = 23
	var_10_0.cellSpaceV = 0
	var_10_0.startSpace = 50
	var_10_0.endSpace = 0
	var_10_0.sortMode = ScrollEnum.ScrollSortUp
	arg_10_0._scrollView = LuaListScrollView.New(PermanentActivityListModel.instance, var_10_0)

	arg_10_0._scrollView:__onInit()

	arg_10_0._scrollView.viewGO = arg_10_0.viewGO
	arg_10_0._scrollView.viewName = arg_10_0.viewName
	arg_10_0._scrollView.viewContainer = arg_10_0

	arg_10_0._scrollView:onInitViewInternal()
	arg_10_0._scrollView:addEventsInternal()
end

function var_0_0._onCurrencyChange(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.currencyId

	if not var_11_0 or not arg_11_1[var_11_0] then
		return
	end

	arg_11_0:refreshCurrency()
end

function var_0_0.refreshCurrency(arg_12_0)
	local var_12_0 = arg_12_0.currencyId
	local var_12_1 = CurrencyModel.instance:getCurrency(var_12_0)
	local var_12_2 = CurrencyConfig.instance:getCurrencyCo(var_12_0)
	local var_12_3 = var_12_1 and var_12_1.quantity or 0

	arg_12_0._txtcurrency.text = string.format("%s/%s", GameUtil.numberDisplay(var_12_3), GameUtil.numberDisplay(var_12_2.maxLimit))

	local var_12_4 = var_12_2.icon

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_12_0._imagecurrency, var_12_4 .. "_1")
end

function var_0_0._onFullViewClose(arg_13_0)
	if arg_13_0.viewGO.activeInHierarchy then
		PermanentModel.instance:undateActivityInfo()
	end
end

return var_0_0
