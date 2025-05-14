module("modules.logic.store.view.ChargeStoreView", package.seeall)

local var_0_0 = class("ChargeStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_righticon")
	arg_1_0._gostorecategoryitem = gohelper.findChild(arg_1_0.viewGO, "scroll_category/viewport/categorycontent/#go_storecategoryitem")
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_prop")

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
	gohelper.setActive(arg_4_0._gostorecategoryitem, false)

	arg_4_0._categoryItemContainer = {}

	arg_4_0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("full/shangcheng_bj"))
	arg_4_0._simagelefticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_leftdown2"))
	arg_4_0._simagerighticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_right3"))
end

function var_0_0._refreshAllSecondTabs(arg_5_0)
	local var_5_0 = StoreModel.instance:getSecondTabs(arg_5_0._selectFirstTabId, true, true)

	if var_5_0 and #var_5_0 > 0 then
		for iter_5_0 = 1, #var_5_0 do
			arg_5_0:_refreshSecondTabs(iter_5_0, var_5_0[iter_5_0])
			gohelper.setActive(arg_5_0._categoryItemContainer[iter_5_0].go, true)
		end

		for iter_5_1 = #var_5_0 + 1, #arg_5_0._categoryItemContainer do
			gohelper.setActive(arg_5_0._categoryItemContainer[iter_5_1].go, false)
		end
	else
		for iter_5_2 = 1, #arg_5_0._categoryItemContainer do
			gohelper.setActive(arg_5_0._categoryItemContainer[iter_5_2].go, false)
		end
	end
end

function var_0_0._refreshTabs(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0._selectSecondTabId

	arg_6_0._selectSecondTabId = 0

	if not StoreModel.instance:isTabOpen(arg_6_1) then
		arg_6_1 = arg_6_0.viewContainer:getSelectFirstTabId()
	end

	local var_6_1
	local var_6_2, var_6_3

	var_6_2, arg_6_0._selectSecondTabId, var_6_3 = StoreModel.instance:jumpTabIdToSelectTabId(arg_6_1)

	local var_6_4 = StoreConfig.instance:getTabConfig(arg_6_0._selectSecondTabId)
	local var_6_5 = StoreConfig.instance:getTabConfig(arg_6_0.viewContainer:getSelectFirstTabId())

	if var_6_4 and not string.nilorempty(var_6_4.showCost) then
		arg_6_0.viewContainer:setCurrencyType(var_6_4.showCost)
	elseif var_6_5 and not string.nilorempty(var_6_5.showCost) then
		arg_6_0.viewContainer:setCurrencyType(var_6_5.showCost)
	else
		arg_6_0.viewContainer:setCurrencyType(nil)
	end

	if not arg_6_2 and var_6_0 == arg_6_0._selectSecondTabId then
		return
	end

	arg_6_0:_refreshAllSecondTabs()
	StoreController.instance:readTab(arg_6_1)
	arg_6_0:_onRefreshRedDot()

	arg_6_0._resetScrollPos = true

	arg_6_0:_refreshGood()
end

function var_0_0._onRefreshRedDot(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._categoryItemContainer) do
		gohelper.setActive(iter_7_1.go_reddot, StoreModel.instance:isTabFirstRedDotShow(iter_7_1.tabId))
	end
end

function var_0_0._refreshSecondTabs(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._categoryItemContainer[arg_8_1] or arg_8_0:initCategoryItemTable(arg_8_1)

	var_8_0.tabId = arg_8_2.id
	var_8_0.txt_itemcn1.text = arg_8_2.name
	var_8_0.txt_itemcn2.text = arg_8_2.name
	var_8_0.txt_itemen1.text = arg_8_2.nameEn
	var_8_0.txt_itemen2.text = arg_8_2.nameEn

	local var_8_1 = arg_8_0._selectSecondTabId == arg_8_2.id

	gohelper.setActive(var_8_0.go_unselected, not var_8_1)
	gohelper.setActive(var_8_0.go_selected, var_8_1)
end

function var_0_0.initCategoryItemTable(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = gohelper.cloneInPlace(arg_9_0._gostorecategoryitem, "item" .. arg_9_1)
	var_9_0.go_unselected = gohelper.findChild(var_9_0.go, "go_unselected")
	var_9_0.go_selected = gohelper.findChild(var_9_0.go, "go_selected")
	var_9_0.go_line = gohelper.findChild(var_9_0.go, "go_line")
	var_9_0.go_reddot = gohelper.findChild(var_9_0.go, "#go_tabreddot1")
	var_9_0.txt_itemcn1 = gohelper.findChildText(var_9_0.go, "go_unselected/txt_itemcn1")
	var_9_0.txt_itemen1 = gohelper.findChildText(var_9_0.go, "go_unselected/txt_itemen1")
	var_9_0.txt_itemcn2 = gohelper.findChildText(var_9_0.go, "go_selected/txt_itemcn2")
	var_9_0.txt_itemen2 = gohelper.findChildText(var_9_0.go, "go_selected/txt_itemen2")
	var_9_0.go_childcategory = gohelper.findChild(var_9_0.go, "go_childcategory")
	var_9_0.go_childItem = gohelper.findChild(var_9_0.go, "go_childcategory/go_childitem")
	var_9_0.childItemContainer = {}
	var_9_0.btnGO = gohelper.findChild(var_9_0.go, "clickArea")
	var_9_0.btn = gohelper.getClickWithAudio(var_9_0.go, AudioEnum.UI.play_ui_bank_open)
	var_9_0.tabId = 0

	var_9_0.btn:AddClickListener(function(arg_10_0)
		local var_10_0 = arg_10_0.tabId

		arg_9_0:_refreshTabs(var_10_0)
		StoreController.instance:statSwitchStore(var_10_0)
	end, var_9_0)
	table.insert(arg_9_0._categoryItemContainer, var_9_0)
	gohelper.setActive(var_9_0.go_childItem, false)

	return var_9_0
end

function var_0_0._refreshGood(arg_11_0)
	StoreModel.instance:setCurChargeStoreId(arg_11_0._selectSecondTabId)

	local var_11_0 = StoreModel.instance:getChargeGoods()

	StoreChargeGoodsItemListModel.instance:setMOList(var_11_0, arg_11_0._selectSecondTabId)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._selectFirstTabId = arg_12_0.viewContainer:getSelectFirstTabId()

	local var_12_0 = arg_12_0.viewContainer:getJumpTabId()

	arg_12_0:_refreshTabs(var_12_0, true)
	arg_12_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_12_0._updateInfo, arg_12_0)
	arg_12_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_12_0._updateInfo, arg_12_0)
	arg_12_0:addEventCb(PayController.instance, PayEvent.PayInfoChanged, arg_12_0._updateInfo, arg_12_0)
	ChargeRpc.instance:sendGetChargeInfoRequest()
end

function var_0_0._updateInfo(arg_13_0)
	arg_13_0:_refreshGood()
end

function var_0_0.onClose(arg_14_0)
	arg_14_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_14_0._updateInfo, arg_14_0)
	arg_14_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_14_0._updateInfo, arg_14_0)
	arg_14_0:removeEventCb(PayController.instance, PayEvent.PayInfoChanged, arg_14_0._updateInfo, arg_14_0)
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0._selectFirstTabId = arg_15_0.viewContainer:getSelectFirstTabId()

	local var_15_0 = arg_15_0.viewContainer:getJumpTabId()

	arg_15_0:_refreshTabs(var_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0._categoryItemContainer and #arg_16_0._categoryItemContainer > 0 then
		for iter_16_0 = 1, #arg_16_0._categoryItemContainer do
			local var_16_0 = arg_16_0._categoryItemContainer[iter_16_0]

			var_16_0.btn:RemoveClickListener()

			if var_16_0.childItemContainer and #var_16_0.childItemContainer > 0 then
				for iter_16_1 = 1, #var_16_0.childItemContainer do
					var_16_0.childItemContainer[iter_16_1].btn:RemoveClickListener()
				end
			end
		end
	end

	arg_16_0._simagebg:UnLoadImage()
	arg_16_0._simagelefticon:UnLoadImage()
	arg_16_0._simagerighticon:UnLoadImage()
end

return var_0_0
