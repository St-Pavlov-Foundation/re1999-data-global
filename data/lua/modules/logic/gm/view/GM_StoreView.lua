module("modules.logic.gm.view.GM_StoreView", package.seeall)

slot0 = class("GM_StoreView", BaseView)
slot1 = "#FFFF00"
slot2 = "#00FF00"

function slot0.register()
	uv0.StoreView_register(StoreView)
	uv0.RecommendStoreView_register(RecommendStoreView)
	uv0.PackageStoreView_register(PackageStoreView)
	uv0.PackageStoreGoodsItem_register(PackageStoreGoodsItem)
	uv0.ClothesStoreView_register(ClothesStoreView)
	uv0.StoreSkinGoodsItem_register(StoreSkinGoodsItem)
	uv0.NormalStoreView_register(NormalStoreView)
	uv0.NormalStoreGoodsItem_register(NormalStoreGoodsItem)
end

function slot0.StoreView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_refreshTabs")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)

		slot1 = GMMinusModel.instance:addBtnGM(slot0)

		recthelper.setAnchorX(slot1.transform, 50)
		recthelper.setAnchorY(slot1.transform, -999)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_StoreViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_StoreViewContainer.removeEvents(slot0)
	end

	function slot0._refreshTabs(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_refreshTabs", ...)

		if uv0.s_ShowAllTabId then
			for slot4, slot5 in ipairs(slot0._tabsContainer) do
				if slot5 then
					slot6 = slot5.tabId

					if slot5 then
						slot5.txtnamecn1.text = tostring(slot6)
						slot5.txtnamecn2.text = tostring(slot6)
					end
				end
			end
		else
			for slot5, slot6 in ipairs(slot0._tabsContainer) do
				if slot6 then
					slot7 = StoreModel.instance:getFirstTabs(true, true)[slot5]

					if slot6 then
						slot6.txtnamecn1.text = slot7.name
						slot6.txtnamecn2.text = slot7.name
					end
				end
			end
		end
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		if not StoreController.instance._lastViewStoreId or slot1 == 0 then
			slot1 = StoreEnum.DefaultTabId
		end

		slot0:_refreshTabs(slot1)
	end
end

function slot0.RecommendStoreView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "onOpen")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_refreshSecondTabs")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
		GM_RecommendStoreViewContainer._editableInitView(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_RecommendStoreViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_RecommendStoreViewContainer.removeEvents(slot0)
	end

	function slot0.onOpen(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "onOpen", ...)
		GM_RecommendStoreViewContainer.onOpen(slot0, ...)
	end

	function slot0._refreshSecondTabs(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_refreshSecondTabs", ...)
		GM_RecommendStoreViewContainer._refreshSecondTabs(slot0, ...)
	end
end

function slot0.PackageStoreView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_refreshSecondTabs")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_PackageStoreViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_PackageStoreViewContainer.removeEvents(slot0)
	end

	function slot0._refreshSecondTabs(slot0, slot1, slot2, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_refreshSecondTabs", slot1, slot2, ...)

		if not GM_PackageStoreView.s_ShowAllTabId then
			return
		end

		if not slot0._categoryItemContainer[slot1] then
			return
		end

		slot4 = slot2.id .. slot2.name
		slot3.txt_itemcn1.text = slot4
		slot3.txt_itemcn2.text = slot4
	end

	function slot0._gm_showAllTabIdUpdate()
		StoreController.instance:dispatchEvent(StoreEvent.UpdatePackageStore)
	end

	function slot0._gm_showAllItemIdUpdate()
		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged)
	end
end

function slot0.PackageStoreGoodsItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "onUpdateMO")

	function slot0.onUpdateMO(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "onUpdateMO", ...)

		if not GM_PackageStoreView.s_ShowAllItemId then
			return
		end

		slot0._txtmaterialNum.text = tostring(slot0._mo.config.id)
	end
end

function slot0.ClothesStoreView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_ClothesStoreViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_ClothesStoreViewContainer.removeEvents(slot0)
	end

	function slot0._gm_showAllTabIdUpdate()
		StoreClothesGoodsItemListModel.instance:onModelUpdate()
	end
end

function slot0.StoreSkinGoodsItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "onUpdateMO")

	slot1 = "#FF0000"

	function slot0.onUpdateMO(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "onUpdateMO", ...)

		if not GM_ClothesStoreView.s_ShowAllTabId then
			return
		end

		slot2 = slot0.skinCo
		slot3 = slot2.characterId
		slot0._txtskinname.text = "id: " .. gohelper.getRichColorText(tostring(slot0._mo.config.id), uv0) .. "\n" .. "SkinId: " .. gohelper.getRichColorText(tostring(slot2.id), uv0)
		slot0._txtname.text = HeroConfig.instance:getHeroCO(slot3).name .. " (id: " .. tostring(slot3) .. ")"
	end
end

function slot0.NormalStoreView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_refreshSecondTabs")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_NormalStoreViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_NormalStoreViewContainer.removeEvents(slot0)
	end

	function slot0._refreshSecondTabs(slot0, slot1, slot2, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_refreshSecondTabs", slot1, slot2, ...)

		if not GM_NormalStoreView.s_ShowAllTabId then
			return
		end

		slot3 = slot0._categoryItemContainer[slot1]
		slot4 = slot2.id
		slot3.tabId = slot4
		slot3.txt_itemcn1.text = tostring(slot4) .. slot2.name
		slot3.txt_itemcn2.text = tostring(slot4) .. slot2.name
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		if not StoreController.instance._lastViewStoreId or slot1 == 0 then
			slot1 = slot0.viewContainer:getJumpTabId()
		end

		slot0:_refreshTabs(slot1, true)
	end

	function slot0._gm_showAllGoodsIdUpdate(slot0)
		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged)
	end
end

function slot0.NormalStoreGoodsItem_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "refreshActGoods")
	GMMinusModel.instance:saveOriginalFunc(slot0, "refreshNormalGoods")

	function slot0.refreshActGoods(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "refreshActGoods", ...)

		if not GM_NormalStoreView.s_ShowAllGoodsId then
			return
		end

		slot0._txtgoodsName.text = gohelper.getRichColorText(slot0._mo:getActGoodsId(), uv0) .. gohelper.getRichColorText("(Act)", uv1)
	end

	function slot0.refreshNormalGoods(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "refreshNormalGoods", ...)

		if not GM_NormalStoreView.s_ShowAllGoodsId then
			return
		end

		slot0._txtgoodsName.text = gohelper.getRichColorText(slot0._mo.goodsId, uv0)
	end
end

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._item1Toggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item1/Toggle")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._item1Toggle:AddOnValueChanged(slot0._onItem1ToggleValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._item1Toggle:RemoveOnValueChanged()
end

function slot0.onOpen(slot0)
	slot0:_refreshItem1()
end

function slot0.onDestroyView(slot0)
end

slot0.s_ShowAllTabId = false

function slot0._refreshItem1(slot0)
	slot0._item1Toggle.isOn = uv0.s_ShowAllTabId
end

function slot0._onItem1ToggleValueChanged(slot0)
	slot1 = slot0._item1Toggle.isOn
	uv0.s_ShowAllTabId = slot1

	GMController.instance:dispatchEvent(GMEvent.StoreView_ShowAllTabIdUpdate, slot1)
end

return slot0
