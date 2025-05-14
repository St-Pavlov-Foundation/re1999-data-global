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

	function arg_8_0._editableInitView(arg_9_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_9_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_9_0)
		GM_RecommendStoreViewContainer._editableInitView(arg_9_0)
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
		GM_RecommendStoreViewContainer.onOpen(arg_12_0, ...)
	end

	function arg_8_0._refreshSecondTabs(arg_13_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_13_0, "_refreshSecondTabs", ...)
		GM_RecommendStoreViewContainer._refreshSecondTabs(arg_13_0, ...)
	end
end

function var_0_0.PackageStoreView_register(arg_14_0)
	GMMinusModel.instance:saveOriginalFunc(arg_14_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_14_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_14_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_14_0, "_refreshSecondTabs")

	function arg_14_0._editableInitView(arg_15_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_15_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_15_0)
	end

	function arg_14_0.addEvents(arg_16_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_16_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_16_0)
		GM_PackageStoreViewContainer.addEvents(arg_16_0)
	end

	function arg_14_0.removeEvents(arg_17_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_17_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_17_0)
		GM_PackageStoreViewContainer.removeEvents(arg_17_0)
	end

	function arg_14_0._refreshSecondTabs(arg_18_0, arg_18_1, arg_18_2, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_18_0, "_refreshSecondTabs", arg_18_1, arg_18_2, ...)

		if not GM_PackageStoreView.s_ShowAllTabId then
			return
		end

		local var_18_0 = arg_18_0._categoryItemContainer[arg_18_1]

		if not var_18_0 then
			return
		end

		local var_18_1 = arg_18_2.id .. arg_18_2.name

		var_18_0.txt_itemcn1.text = var_18_1
		var_18_0.txt_itemcn2.text = var_18_1
	end

	function arg_14_0._gm_showAllTabIdUpdate()
		StoreController.instance:dispatchEvent(StoreEvent.UpdatePackageStore)
	end

	function arg_14_0._gm_showAllItemIdUpdate()
		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged)
	end
end

function var_0_0.PackageStoreGoodsItem_register(arg_21_0)
	GMMinusModel.instance:saveOriginalFunc(arg_21_0, "onUpdateMO")

	function arg_21_0.onUpdateMO(arg_22_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_22_0, "onUpdateMO", ...)

		if not GM_PackageStoreView.s_ShowAllItemId then
			return
		end

		local var_22_0 = arg_22_0._mo.config

		arg_22_0._txtmaterialNum.text = tostring(var_22_0.id)
	end
end

function var_0_0.ClothesStoreView_register(arg_23_0)
	GMMinusModel.instance:saveOriginalFunc(arg_23_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_23_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_23_0, "removeEvents")

	function arg_23_0._editableInitView(arg_24_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_24_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_24_0)
	end

	function arg_23_0.addEvents(arg_25_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_25_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_25_0)
		GM_ClothesStoreViewContainer.addEvents(arg_25_0)
	end

	function arg_23_0.removeEvents(arg_26_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_26_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_26_0)
		GM_ClothesStoreViewContainer.removeEvents(arg_26_0)
	end

	function arg_23_0._gm_showAllTabIdUpdate()
		StoreClothesGoodsItemListModel.instance:onModelUpdate()
	end
end

function var_0_0.StoreSkinGoodsItem_register(arg_28_0)
	GMMinusModel.instance:saveOriginalFunc(arg_28_0, "onUpdateMO")

	local var_28_0 = "#FF0000"

	function arg_28_0.onUpdateMO(arg_29_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_29_0, "onUpdateMO", ...)

		if not GM_ClothesStoreView.s_ShowAllTabId then
			return
		end

		local var_29_0 = arg_29_0._mo.config
		local var_29_1 = arg_29_0.skinCo
		local var_29_2 = var_29_1.characterId
		local var_29_3 = HeroConfig.instance:getHeroCO(var_29_2)
		local var_29_4 = gohelper.getRichColorText(tostring(var_29_0.id), var_28_0)
		local var_29_5 = gohelper.getRichColorText(tostring(var_29_1.id), var_28_0)

		arg_29_0._txtskinname.text = "id: " .. var_29_4 .. "\n" .. "SkinId: " .. var_29_5
		arg_29_0._txtname.text = var_29_3.name .. " (id: " .. tostring(var_29_2) .. ")"
	end
end

function var_0_0.NormalStoreView_register(arg_30_0)
	GMMinusModel.instance:saveOriginalFunc(arg_30_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_30_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_30_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_30_0, "_refreshSecondTabs")

	function arg_30_0._editableInitView(arg_31_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_31_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_31_0)
	end

	function arg_30_0.addEvents(arg_32_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_32_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_32_0)
		GM_NormalStoreViewContainer.addEvents(arg_32_0)
	end

	function arg_30_0.removeEvents(arg_33_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_33_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_33_0)
		GM_NormalStoreViewContainer.removeEvents(arg_33_0)
	end

	function arg_30_0._refreshSecondTabs(arg_34_0, arg_34_1, arg_34_2, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_34_0, "_refreshSecondTabs", arg_34_1, arg_34_2, ...)

		if not GM_NormalStoreView.s_ShowAllTabId then
			return
		end

		local var_34_0 = arg_34_0._categoryItemContainer[arg_34_1]
		local var_34_1 = arg_34_2.id

		var_34_0.tabId = var_34_1
		var_34_0.txt_itemcn1.text = tostring(var_34_1) .. arg_34_2.name
		var_34_0.txt_itemcn2.text = tostring(var_34_1) .. arg_34_2.name
	end

	function arg_30_0._gm_showAllTabIdUpdate(arg_35_0)
		local var_35_0 = StoreController.instance._lastViewStoreId

		if not var_35_0 or var_35_0 == 0 then
			var_35_0 = arg_35_0.viewContainer:getJumpTabId()
		end

		arg_35_0:_refreshTabs(var_35_0, true)
	end

	function arg_30_0._gm_showAllGoodsIdUpdate(arg_36_0)
		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged)
	end
end

function var_0_0.NormalStoreGoodsItem_register(arg_37_0)
	GMMinusModel.instance:saveOriginalFunc(arg_37_0, "refreshActGoods")
	GMMinusModel.instance:saveOriginalFunc(arg_37_0, "refreshNormalGoods")

	function arg_37_0.refreshActGoods(arg_38_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_38_0, "refreshActGoods", ...)

		if not GM_NormalStoreView.s_ShowAllGoodsId then
			return
		end

		local var_38_0 = arg_38_0._mo:getActGoodsId()

		arg_38_0._txtgoodsName.text = gohelper.getRichColorText(var_38_0, var_0_1) .. gohelper.getRichColorText("(Act)", var_0_2)
	end

	function arg_37_0.refreshNormalGoods(arg_39_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_39_0, "refreshNormalGoods", ...)

		if not GM_NormalStoreView.s_ShowAllGoodsId then
			return
		end

		local var_39_0 = arg_39_0._mo.goodsId

		arg_39_0._txtgoodsName.text = gohelper.getRichColorText(var_39_0, var_0_1)
	end
end

function var_0_0.onInitView(arg_40_0)
	arg_40_0._btnClose = gohelper.findChildButtonWithAudio(arg_40_0.viewGO, "btnClose")
	arg_40_0._item1Toggle = gohelper.findChildToggle(arg_40_0.viewGO, "viewport/content/item1/Toggle")
end

function var_0_0.addEvents(arg_41_0)
	arg_41_0._btnClose:AddClickListener(arg_41_0.closeThis, arg_41_0)
	arg_41_0._item1Toggle:AddOnValueChanged(arg_41_0._onItem1ToggleValueChanged, arg_41_0)
end

function var_0_0.removeEvents(arg_42_0)
	arg_42_0._btnClose:RemoveClickListener()
	arg_42_0._item1Toggle:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_43_0)
	arg_43_0:_refreshItem1()
end

function var_0_0.onDestroyView(arg_44_0)
	return
end

var_0_0.s_ShowAllTabId = false

function var_0_0._refreshItem1(arg_45_0)
	local var_45_0 = var_0_0.s_ShowAllTabId

	arg_45_0._item1Toggle.isOn = var_45_0
end

function var_0_0._onItem1ToggleValueChanged(arg_46_0)
	local var_46_0 = arg_46_0._item1Toggle.isOn

	var_0_0.s_ShowAllTabId = var_46_0

	GMController.instance:dispatchEvent(GMEvent.StoreView_ShowAllTabIdUpdate, var_46_0)
end

return var_0_0
