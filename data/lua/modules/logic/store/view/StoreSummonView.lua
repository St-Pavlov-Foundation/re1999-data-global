module("modules.logic.store.view.StoreSummonView", package.seeall)

local var_0_0 = class("StoreSummonView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gostorecategoryitem = gohelper.findChild(arg_1_0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_prop")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#scroll_prop/#go_lock")
	arg_1_0._lineGo = gohelper.findChild(arg_1_0.viewGO, "line")
	arg_1_0._txtLockText = gohelper.findChildText(arg_1_0.viewGO, "#scroll_prop/#go_lock/locktext")
	arg_1_0._simagelockbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_prop/#go_lock/#simage_lockbg")

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
	arg_4_0._txtrefreshTime = gohelper.findChildText(arg_4_0.viewGO, "#txt_refreshTime")

	gohelper.setActive(arg_4_0._txtrefreshTime.gameObject, false)
	gohelper.setActive(arg_4_0._gostorecategoryitem, false)

	arg_4_0._lockClick = gohelper.getClickWithAudio(arg_4_0._golock)
	arg_4_0._isLock = false
	arg_4_0._categoryItemContainer = {}

	arg_4_0._simagelockbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_weijiesuodiban"))
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._categoryItemContainer and #arg_5_0._categoryItemContainer > 0 then
		for iter_5_0 = 1, #arg_5_0._categoryItemContainer do
			arg_5_0._categoryItemContainer[iter_5_0].btn:RemoveClickListener()
		end
	end

	arg_5_0._simagelockbg:UnLoadImage()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.storeId = StoreEnum.StoreId.LimitStore

	arg_6_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_6_0._updateInfo, arg_6_0)
	arg_6_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_6_0._updateInfo, arg_6_0)
	arg_6_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_6_0._onRefreshRedDot, arg_6_0)
	arg_6_0._lockClick:AddClickListener(arg_6_0._onLockClick, arg_6_0)
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_7_0._updateInfo, arg_7_0)
	arg_7_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_7_0._updateInfo, arg_7_0)
	arg_7_0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_7_0._onRefreshRedDot, arg_7_0)
	arg_7_0._lockClick:RemoveClickListener()
end

function var_0_0.refreshRemainTime(arg_8_0)
	local var_8_0 = StoreConfig.instance:getTabConfig(arg_8_0.storeId)
	local var_8_1 = StoreHelper.getRemainExpireTime(var_8_0)

	if var_8_1 and var_8_1 > 0 then
		arg_8_0._txtrefreshTime.text = string.format(luaLang("summon_limit_shop_remaintime"), SummonModel.formatRemainTime(var_8_1))
	else
		arg_8_0._txtrefreshTime.text = ""
	end
end

function var_0_0.refreshLockStatus(arg_9_0)
	if arg_9_0._selectThirdTabId > 0 then
		arg_9_0._isLock = StoreModel.instance:isStoreTabLock(arg_9_0.storeId)

		if arg_9_0._isLock then
			local var_9_0 = StoreConfig.instance:getStoreConfig(arg_9_0.storeId)

			arg_9_0._txtLockText.text = string.format(luaLang("lock_store_text"), StoreConfig.instance:getTabConfig(var_9_0.needClearStore).name)
		end

		gohelper.setActive(arg_9_0._golock, arg_9_0._isLock)
	else
		gohelper.setActive(arg_9_0._golock, false)
	end
end

function var_0_0._refreshSecondTabs(arg_10_0, arg_10_1, arg_10_2)
	return
end

function var_0_0._refreshGoods(arg_11_0)
	return
end

function var_0_0._onLockClick(arg_12_0)
	if arg_12_0._isLock then
		local var_12_0 = StoreConfig.instance:getTabConfig(arg_12_0.storeId).name

		GameFacade.showToast(ToastEnum.NormalStoreIsLock, var_12_0)
	end
end

function var_0_0._updateInfo(arg_13_0)
	return
end

function var_0_0._onRefreshRedDot(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._categoryItemContainer) do
		gohelper.setActive(iter_14_1.go_reddot, StoreModel.instance:isTabFirstRedDotShow(iter_14_1.tabId))
	end
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

return var_0_0
