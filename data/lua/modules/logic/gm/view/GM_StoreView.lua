module("modules.logic.gm.view.GM_StoreView", package.seeall)

local var_0_0 = class("GM_StoreView", BaseView)
local var_0_1 = "#FFFF00"
local var_0_2 = "#00FF00"

function var_0_0.register()
	var_0_0.StoreView_register(StoreView)
	var_0_0.RecommendStoreView_register(RecommendStoreView)
	var_0_0.PackageStoreView_register(PackageStoreView)
	var_0_0.PackageStoreGoodsItem_register(PackageStoreGoodsItem)
	var_0_0.ClothesStoreView_register(ClothesStoreView)
	var_0_0.StoreSkinGoodsItem_register(StoreSkinGoodsItem)
	var_0_0.NormalStoreView_register(NormalStoreView)
	var_0_0.NormalStoreGoodsItem_register(NormalStoreGoodsItem)
end

function var_0_0.StoreView_register(arg_2_0)
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_refreshTabs")

	function arg_2_0._editableInitView(arg_3_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_3_0, "_editableInitView", ...)

		local var_3_0 = GMMinusModel.instance:addBtnGM(arg_3_0)

		recthelper.setAnchorX(var_3_0.transform, 50)
		recthelper.setAnchorY(var_3_0.transform, -999)
	end

	function arg_2_0.addEvents(arg_4_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_4_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_4_0)
		GM_StoreViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_StoreViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0._refreshTabs(arg_6_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_6_0, "_refreshTabs", ...)

		if var_0_0.s_ShowAllTabId then
			for iter_6_0, iter_6_1 in ipairs(arg_6_0._tabsContainer) do
				if iter_6_1 then
					local var_6_0 = iter_6_1.tabId

					if iter_6_1 then
						iter_6_1.txtnamecn1.text = tostring(var_6_0)
						iter_6_1.txtnamecn2.text = tostring(var_6_0)
					end
				end
			end
		else
			local var_6_1 = StoreModel.instance:getFirstTabs(true, true)

			for iter_6_2, iter_6_3 in ipairs(arg_6_0._tabsContainer) do
				if iter_6_3 then
					local var_6_2 = var_6_1[iter_6_2]

					if iter_6_3 then
						iter_6_3.txtnamecn1.text = var_6_2.name
						iter_6_3.txtnamecn2.text = var_6_2.name
					end
				end
			end
		end
	end

	function arg_2_0._gm_showAllTabIdUpdate(arg_7_0)
		local var_7_0 = StoreController.instance._lastViewStoreId

		if not var_7_0 or var_7_0 == 0 then
			var_7_0 = StoreEnum.DefaultTabId
		end

		arg_7_0:_refreshTabs(var_7_0)
	end
end

function var_0_0.RecommendStoreView_register(arg_8_0)
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "onOpen")
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "_refreshSecondTabs")
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "_refreshTabsItem")
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "_refreshTabs")
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "_onSetVisibleInternal")
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "_onSetAutoToNextPage")
	GMMinusModel.instance:saveOriginalFunc(arg_8_0, "onDestroyView")
	GMMinusModel.instance:saveOriginalFunc(StoreHelper, "getRecommendStoreSecondTabConfig")

	function arg_8_0._editableInitView(arg_9_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_9_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_9_0)
	end

	function arg_8_0.addEvents(arg_10_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_10_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_10_0)
		GM_RecommendStoreViewContainer.addEvents(arg_10_0)
	end

	function arg_8_0.removeEvents(arg_11_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_11_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_11_0)
		GM_RecommendStoreViewContainer.removeEvents(arg_11_0)
	end

	function arg_8_0.onOpen(arg_12_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_12_0, "onOpen", ...)
		arg_12_0:_gm_stopBannerLoopAnimUpdate()
	end

	function arg_8_0._refreshSecondTabs(arg_13_0, arg_13_1, arg_13_2, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_13_0, "_refreshSecondTabs", arg_13_1, arg_13_2, ...)

		local var_13_0 = arg_13_0._categoryItemContainer[arg_13_1]
		local var_13_1 = arg_13_2.id
		local var_13_2 = arg_13_2.name

		if GM_RecommendStoreView.s_ShowAllTabId then
			local var_13_3 = GMMinusModel.instance:getFirstLogin("GM_RecommendStoreViewContainer_lastOpenedTabIdSet", {})

			if GM_RecommendStoreView.s_ShowAllBanner and not var_13_3[var_13_1] then
				var_13_2 = string.format("%s\n<color=#00FF00>%s (New)</color>", var_13_2, var_13_1)
			else
				var_13_2 = string.format("%s\n%s", var_13_2, var_13_1)
			end
		end

		var_13_0.txt_itemcn1.text = var_13_2
		var_13_0.txt_itemcn2.text = var_13_2
	end

	function arg_8_0._onSetVisibleInternal(arg_14_0, ...)
		if GM_RecommendStoreView.s_StopBannerLoopAnim then
			-- block empty
		else
			GMMinusModel.instance:callOriginalSelfFunc(arg_14_0, "_onSetVisibleInternal", ...)
		end
	end

	function arg_8_0._onSetAutoToNextPage(arg_15_0, ...)
		if GM_RecommendStoreView.s_StopBannerLoopAnim then
			-- block empty
		else
			GMMinusModel.instance:callOriginalSelfFunc(arg_15_0, "_onSetAutoToNextPage", ...)
		end
	end

	function arg_8_0._refreshTabsItem(arg_16_0, ...)
		if GM_RecommendStoreView.s_ShowAllBanner then
			local var_16_0, var_16_1 = arg_16_0:_gm_getRecommendStoreSecondTabConfig()

			function StoreHelper.getRecommendStoreSecondTabConfig()
				local var_17_0 = arg_16_0:_gm_showAllBanner_GetTabIdList()
				local var_17_1 = StoreModel.instance:getRecommendSecondTabs(StoreEnum.RecommendStore, true)
				local var_17_2 = {}

				for iter_17_0, iter_17_1 in ipairs(var_17_0) do
					var_17_2[iter_17_1] = true
				end

				local var_17_3 = {}

				for iter_17_2, iter_17_3 in ipairs(var_17_1) do
					if var_17_2[iter_17_3.id] then
						table.insert(var_17_3, iter_17_3)
					end
				end

				return var_17_3, var_16_1
			end
		end

		local var_16_2 = GMMinusModel.instance:callOriginalSelfFunc(arg_16_0, "_refreshTabsItem", ...)

		StoreHelper.getRecommendStoreSecondTabConfig = GMMinusModel.instance:loadOriginalFunc(StoreHelper, "getRecommendStoreSecondTabConfig")

		return var_16_2
	end

	function arg_8_0._refreshTabs(arg_18_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_18_0, "_refreshTabs", ...)
		arg_18_0:_gm_stopBannerLoopAnimUpdate()
	end

	function arg_8_0.onDestroyView(arg_19_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_19_0, "onDestroyView", ...)

		StoreHelper.getRecommendStoreSecondTabConfig = GMMinusModel.instance:loadOriginalFunc(StoreHelper, "getRecommendStoreSecondTabConfig")
	end

	function arg_8_0._gm_stopBannerLoopAnimUpdate(arg_20_0)
		if GM_RecommendStoreView.s_StopBannerLoopAnim then
			TaskDispatcher.cancelTask(arg_20_0._toNextTab, arg_20_0)
			TaskDispatcher.cancelTask(arg_20_0._onSwitchCloseAnimDone, arg_20_0)
		end
	end

	function arg_8_0._gm_showAllTabIdUpdate(arg_21_0)
		arg_21_0:_refreshTabsItem()
	end

	function arg_8_0._gm_showAllBannerUpdate(arg_22_0)
		if not GM_RecommendStoreView.s_ShowAllBanner then
			return
		end

		arg_22_0:_refreshTabsItem()
	end

	function arg_8_0._gm_getRecommendStoreSecondTabConfig(arg_23_0)
		return GMMinusModel.instance:callOriginalStaticFunc(StoreHelper, "getRecommendStoreSecondTabConfig")
	end

	function arg_8_0._gm_showAllBanner_GetTabIdList(arg_24_0)
		local var_24_0 = {}
		local var_24_1, var_24_2 = arg_24_0:_gm_getRecommendStoreSecondTabConfig()

		table.sort(var_24_1, function(arg_25_0, arg_25_1)
			return arg_24_0:_tabSortFunction(arg_25_0, arg_25_1)
		end)

		local var_24_3 = {}

		for iter_24_0 = 1, #var_24_1 do
			local var_24_4 = var_24_1[iter_24_0].id

			var_24_0[#var_24_0 + 1] = var_24_4
			var_24_3[var_24_4] = true
		end

		GMMinusModel.instance:setFirstLogin("GM_RecommendStoreViewContainer_lastOpenedTabIdSet", var_24_3)

		local var_24_5 = ServerTime.now()

		for iter_24_1, iter_24_2 in ipairs(lua_store_recommend.configList) do
			local var_24_6 = iter_24_2.onlineTime
			local var_24_7 = iter_24_2.offlineTime
			local var_24_8
			local var_24_9

			if string.nilorempty(var_24_6) then
				var_24_8 = var_24_5
			else
				var_24_8 = TimeUtil.stringToTimestamp(var_24_6)
			end

			if string.nilorempty(var_24_7) then
				var_24_9 = var_24_5
			else
				var_24_9 = TimeUtil.stringToTimestamp(var_24_7)
			end

			if var_24_5 <= var_24_8 and var_24_5 <= var_24_9 then
				var_24_0[#var_24_0 + 1] = iter_24_2.id
			end
		end

		return var_24_0
	end
end

function var_0_0.PackageStoreView_register(arg_26_0)
	GMMinusModel.instance:saveOriginalFunc(arg_26_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_26_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_26_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_26_0, "_refreshSecondTabs")

	function arg_26_0._editableInitView(arg_27_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_27_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_27_0)
	end

	function arg_26_0.addEvents(arg_28_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_28_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_28_0)
		GM_PackageStoreViewContainer.addEvents(arg_28_0)
	end

	function arg_26_0.removeEvents(arg_29_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_29_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_29_0)
		GM_PackageStoreViewContainer.removeEvents(arg_29_0)
	end

	function arg_26_0._refreshSecondTabs(arg_30_0, arg_30_1, arg_30_2, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_30_0, "_refreshSecondTabs", arg_30_1, arg_30_2, ...)

		if not GM_PackageStoreView.s_ShowAllTabId then
			return
		end

		local var_30_0 = arg_30_0._categoryItemContainer[arg_30_1]

		if not var_30_0 then
			return
		end

		local var_30_1 = arg_30_2.id .. arg_30_2.name

		var_30_0.txt_itemcn1.text = var_30_1
		var_30_0.txt_itemcn2.text = var_30_1
	end

	function arg_26_0._gm_showAllTabIdUpdate()
		StoreController.instance:dispatchEvent(StoreEvent.UpdatePackageStore)
	end

	function arg_26_0._gm_showAllItemIdUpdate()
		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged)
	end
end

function var_0_0.PackageStoreGoodsItem_register(arg_33_0)
	GMMinusModel.instance:saveOriginalFunc(arg_33_0, "onUpdateMO")

	function arg_33_0.onUpdateMO(arg_34_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_34_0, "onUpdateMO", ...)

		if not GM_PackageStoreView.s_ShowAllItemId then
			return
		end

		local var_34_0 = arg_34_0._mo.config

		arg_34_0._txtmaterialNum.text = tostring(var_34_0.id)
	end
end

function var_0_0.ClothesStoreView_register(arg_35_0)
	GMMinusModel.instance:saveOriginalFunc(arg_35_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_35_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_35_0, "removeEvents")

	function arg_35_0._editableInitView(arg_36_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_36_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_36_0)
	end

	function arg_35_0.addEvents(arg_37_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_37_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_37_0)
		GM_ClothesStoreViewContainer.addEvents(arg_37_0)
	end

	function arg_35_0.removeEvents(arg_38_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_38_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_38_0)
		GM_ClothesStoreViewContainer.removeEvents(arg_38_0)
	end

	function arg_35_0._gm_showAllTabIdUpdate()
		StoreClothesGoodsItemListModel.instance:onModelUpdate()
	end
end

function var_0_0.StoreSkinGoodsItem_register(arg_40_0)
	GMMinusModel.instance:saveOriginalFunc(arg_40_0, "onUpdateMO")

	local var_40_0 = "#FF0000"

	function arg_40_0.onUpdateMO(arg_41_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_41_0, "onUpdateMO", ...)

		if not GM_ClothesStoreView.s_ShowAllTabId then
			return
		end

		local var_41_0 = arg_41_0._mo.config
		local var_41_1 = arg_41_0.skinCo
		local var_41_2 = var_41_1.characterId
		local var_41_3 = HeroConfig.instance:getHeroCO(var_41_2)
		local var_41_4 = gohelper.getRichColorText(tostring(var_41_0.id), var_40_0)
		local var_41_5 = gohelper.getRichColorText(tostring(var_41_1.id), var_40_0)

		arg_41_0._txtskinname.text = "id: " .. var_41_4 .. "\n" .. "SkinId: " .. var_41_5
		arg_41_0._txtname.text = var_41_3.name .. " (id: " .. tostring(var_41_2) .. ")"
	end
end

function var_0_0.NormalStoreView_register(arg_42_0)
	GMMinusModel.instance:saveOriginalFunc(arg_42_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_42_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_42_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_42_0, "_refreshSecondTabs")

	function arg_42_0._editableInitView(arg_43_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_43_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_43_0)
	end

	function arg_42_0.addEvents(arg_44_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_44_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_44_0)
		GM_NormalStoreViewContainer.addEvents(arg_44_0)
	end

	function arg_42_0.removeEvents(arg_45_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_45_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_45_0)
		GM_NormalStoreViewContainer.removeEvents(arg_45_0)
	end

	function arg_42_0._refreshSecondTabs(arg_46_0, arg_46_1, arg_46_2, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_46_0, "_refreshSecondTabs", arg_46_1, arg_46_2, ...)

		if not GM_NormalStoreView.s_ShowAllTabId then
			return
		end

		local var_46_0 = arg_46_0._categoryItemContainer[arg_46_1]
		local var_46_1 = arg_46_2.id

		var_46_0.tabId = var_46_1
		var_46_0.txt_itemcn1.text = tostring(var_46_1) .. arg_46_2.name
		var_46_0.txt_itemcn2.text = tostring(var_46_1) .. arg_46_2.name
	end

	function arg_42_0._gm_showAllTabIdUpdate(arg_47_0)
		local var_47_0 = StoreController.instance._lastViewStoreId

		if not var_47_0 or var_47_0 == 0 then
			var_47_0 = arg_47_0.viewContainer:getJumpTabId()
		end

		arg_47_0:_refreshTabs(var_47_0, true)
	end

	function arg_42_0._gm_showAllGoodsIdUpdate(arg_48_0)
		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged)
	end
end

function var_0_0.NormalStoreGoodsItem_register(arg_49_0)
	GMMinusModel.instance:saveOriginalFunc(arg_49_0, "refreshActGoods")
	GMMinusModel.instance:saveOriginalFunc(arg_49_0, "refreshNormalGoods")

	function arg_49_0.refreshActGoods(arg_50_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_50_0, "refreshActGoods", ...)

		if not GM_NormalStoreView.s_ShowAllGoodsId then
			return
		end

		local var_50_0 = arg_50_0._mo:getActGoodsId()

		arg_50_0._txtgoodsName.text = gohelper.getRichColorText(var_50_0, var_0_1) .. gohelper.getRichColorText("(Act)", var_0_2)
	end

	function arg_49_0.refreshNormalGoods(arg_51_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_51_0, "refreshNormalGoods", ...)

		if not GM_NormalStoreView.s_ShowAllGoodsId then
			return
		end

		local var_51_0 = arg_51_0._mo.goodsId

		arg_51_0._txtgoodsName.text = gohelper.getRichColorText(var_51_0, var_0_1)
	end
end

function var_0_0.onInitView(arg_52_0)
	arg_52_0._btnClose = gohelper.findChildButtonWithAudio(arg_52_0.viewGO, "btnClose")
	arg_52_0._item1Toggle = gohelper.findChildToggle(arg_52_0.viewGO, "viewport/content/item1/Toggle")
end

function var_0_0.addEvents(arg_53_0)
	arg_53_0._btnClose:AddClickListener(arg_53_0.closeThis, arg_53_0)
	arg_53_0._item1Toggle:AddOnValueChanged(arg_53_0._onItem1ToggleValueChanged, arg_53_0)
end

function var_0_0.removeEvents(arg_54_0)
	arg_54_0._btnClose:RemoveClickListener()
	arg_54_0._item1Toggle:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_55_0)
	arg_55_0:_refreshItem1()
end

function var_0_0.onDestroyView(arg_56_0)
	return
end

var_0_0.s_ShowAllTabId = false

function var_0_0._refreshItem1(arg_57_0)
	local var_57_0 = var_0_0.s_ShowAllTabId

	arg_57_0._item1Toggle.isOn = var_57_0
end

function var_0_0._onItem1ToggleValueChanged(arg_58_0)
	local var_58_0 = arg_58_0._item1Toggle.isOn

	var_0_0.s_ShowAllTabId = var_58_0

	GMController.instance:dispatchEvent(GMEvent.StoreView_ShowAllTabIdUpdate, var_58_0)
end

return var_0_0
