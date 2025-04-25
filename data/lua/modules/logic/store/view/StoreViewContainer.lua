module("modules.logic.store.view.StoreViewContainer", package.seeall)

slot0 = class("StoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, TabViewGroup.New(2, "#go_topright"))
	table.insert(slot1, TabViewGroup.New(3, "#go_store"))

	slot0.storeView = StoreView.New()

	table.insert(slot1, slot0.storeView)

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigationView
		}
	elseif slot1 == 2 then
		slot0._currencyView = CurrencyView.New({})

		return {
			slot0._currencyView
		}
	elseif slot1 == 3 then
		slot2 = ListScrollParam.New()
		slot2.scrollGOPath = "#scroll_prop"
		slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot2.prefabUrl = slot0._viewSetting.otherRes[1]
		slot2.cellClass = NormalStoreGoodsItem
		slot2.scrollDir = ScrollEnum.ScrollDirV
		slot2.lineCount = 4
		slot2.cellWidth = 332
		slot2.cellHeight = 355
		slot2.cellSpaceH = 29
		slot2.cellSpaceV = 37
		slot2.startSpace = 31
		slot3 = ListScrollParam.New()
		slot3.scrollGOPath = "#scroll_prop"
		slot3.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot3.prefabUrl = slot0._viewSetting.otherRes[2]
		slot3.cellClass = ChargeStoreGoodsItem
		slot3.scrollDir = ScrollEnum.ScrollDirV
		slot3.lineCount = 3
		slot3.cellWidth = 446
		slot3.cellHeight = 406
		slot3.cellSpaceH = 38
		slot3.cellSpaceV = 35
		slot3.startSpace = 0
		slot4 = ListScrollParam.New()
		slot4.scrollGOPath = "#scroll_prop"
		slot4.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot4.prefabUrl = slot0._viewSetting.otherRes[3]
		slot4.cellClass = StoreSkinGoodsItem
		slot4.scrollDir = ScrollEnum.ScrollDirH
		slot4.lineCount = 1
		slot4.cellWidth = 374
		slot4.cellHeight = 955
		slot4.cellSpaceH = 31
		slot4.cellSpaceV = 0
		slot4.startSpace = 7
		slot5 = ListScrollParam.New()
		slot5.scrollGOPath = "#scroll_prop"
		slot5.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot5.prefabUrl = slot0._viewSetting.otherRes[4]
		slot5.cellClass = PackageStoreGoodsItem
		slot5.scrollDir = ScrollEnum.ScrollDirH
		slot5.lineCount = 1
		slot5.cellWidth = 340
		slot5.cellHeight = 770
		slot5.cellSpaceH = 29.5
		slot5.cellSpaceV = 0
		slot5.startSpace = 8
		slot6 = TreeScrollParam.New()
		slot6.scrollGOPath = "#scroll_prop"
		slot6.prefabType = ScrollEnum.ScrollPrefabFromView
		slot6.prefabUrls = {
			"roomstoreitem/root",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node"
		}
		slot6.cellClass = StoreRoomTreeItem
		slot6.scrollDir = ScrollEnum.ScrollDirV
		slot7 = {
			[slot11] = math.floor((slot11 - 1) / 4) * 0.07
		}

		for slot11 = 1, 12 do
		end

		for slot12 = 1, 9 do
		end

		slot9 = {}

		setmetatable(slot9, {
			__index = function (slot0, slot1)
				return (slot1 - 1) * 0.07
			end
		})

		slot0._ScrollViewNormalStore = LuaListScrollViewWithAnimator.New(StoreNormalGoodsItemListModel.instance, slot2, slot7)
		slot0._ScrollViewChargeStore = LuaListScrollViewWithAnimator.New(StoreChargeGoodsItemListModel.instance, slot3, {
			[slot12] = math.floor((slot12 - 1) / 3) * 0.07
		})
		slot0._ScrollViewPackageStore = LuaListScrollViewWithAnimator.New(StorePackageGoodsItemListModel.instance, slot5, slot9)
		slot0._ScrollViewSkinStore = LuaListScrollViewWithAnimator.New(StoreClothesGoodsItemListModel.instance, slot4, slot9)
		slot0._ScrollViewRoomStore = LuaTreeScrollView.New(StoreRoomGoodsItemListModel.instance, slot6)

		return {
			MultiView.New({
				NormalStoreView.New(),
				slot0._ScrollViewNormalStore,
				TabViewGroup.New(6, "#go_limit")
			}),
			MultiView.New({
				ChargeStoreView.New(),
				slot0._ScrollViewChargeStore
			}),
			MultiView.New({
				ClothesStoreView.New(),
				slot0._ScrollViewSkinStore
			}),
			MultiView.New({
				PackageStoreView.New(),
				slot0._ScrollViewPackageStore
			}),
			MultiView.New({
				RecommendStoreView.New()
			}),
			MultiView.New({
				RoomStoreView.New(),
				slot0._ScrollViewRoomStore,
				TabViewGroup.New(5, "#go_critter")
			}),
			MultiView.New({
				DecorateStoreView.New()
			})
		}
	elseif slot1 == 4 then
		return {
			StoreMonthCardView.New(),
			GiftPacksView.New(),
			BpEnterView.New(),
			StoreNewbieChooseView.New(),
			StoreRoleSkinView.New(),
			StoreBlockPackageView.New(),
			GiftrecommendView1.New(),
			GiftrecommendView2.New(),
			StoreSeasonCardView.New(),
			StoreSkinBagView.New()
		}
	elseif slot1 == 5 then
		slot2 = ListScrollParam.New()
		slot2.scrollGOPath = "#scroll_goods"
		slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot2.prefabUrl = slot0._viewSetting.otherRes[1]
		slot2.cellClass = RoomStoreGoodsItem
		slot2.scrollDir = ScrollEnum.ScrollDirV
		slot2.lineCount = 4
		slot2.cellWidth = 332
		slot2.cellHeight = 355
		slot2.cellSpaceH = 29
		slot2.cellSpaceV = 37
		slot2.startSpace = 31

		for slot7 = 1, 12 do
		end

		slot0._ScrollViewRoomCritterStore = LuaListScrollViewWithAnimator.New(StoreCritterGoodsItemListModel.instance, slot2, {
			[slot7] = math.floor((slot7 - 1) / 4) * 0.07
		})

		return {
			MultiView.New({
				RoomCritterStoreView.New(),
				slot0._ScrollViewRoomCritterStore
			})
		}
	elseif slot1 == 6 then
		slot2 = ListScrollParam.New()
		slot2.scrollGOPath = "#scroll_prop"
		slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot2.prefabUrl = slot0._viewSetting.otherRes[5]
		slot2.cellClass = SummonStoreGoodsItem
		slot2.scrollDir = ScrollEnum.ScrollDirV
		slot2.lineCount = 4
		slot2.cellWidth = 332
		slot2.cellHeight = 355
		slot2.cellSpaceH = 29
		slot2.cellSpaceV = 37
		slot2.startSpace = 31

		for slot7 = 1, 12 do
		end

		slot0._ScrollViewSummonStore = LuaListScrollViewWithAnimator.New(StoreNormalGoodsItemListModel.instance, slot2, {
			[slot7] = math.floor((slot7 - 1) / 4) * 0.07
		})

		return {
			MultiView.New({
				StoreSummonView.New(),
				slot0._ScrollViewSummonStore
			})
		}
	end
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Rolesopen)
end

function slot0.setCurrencyType(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) then
		for slot7 = #string.split(slot1, "#"), 1, -1 do
			table.insert(slot2, tonumber(slot3[slot7]))
		end
	end

	if slot0._currencyView then
		slot0._currencyView:setCurrencyType(slot2)
	end
end

function slot0.setCurrencyByParams(slot0, slot1)
	if slot0._currencyView then
		slot0._currencyView:setCurrencyType(slot1)
	end
end

function slot0.selectTabView(slot0, slot1, slot2, slot3, slot4)
	slot0.jumpTabId = slot1
	slot0.jumpGoodsId = slot3
	slot0._selectFirstTabId = slot2
	slot5 = StoreConfig.instance:getTabConfig(slot2)
	slot0.notPlayAnimation = false

	if slot3 ~= nil then
		slot0.notPlayAnimation = true

		if slot5 then
			if slot5.prefab == StoreEnum.Prefab.NormalStore then
				slot0._ScrollViewNormalStore._firstUpdate = false
			elseif slot5.prefab == StoreEnum.Prefab.PackageStore then
				slot0._ScrollViewPackageStore._firstUpdate = false
			elseif slot5.prefab == StoreEnum.Prefab.ChargeStore then
				slot0._ScrollViewChargeStore._firstUpdate = false
			elseif slot5.prefab == StoreEnum.Prefab.RoomStore then
				slot0._ScrollViewRoomStore._firstUpdate = false
			end
		end
	end

	if slot5 and slot5.prefab and slot5.prefab ~= 0 and not slot4 then
		slot0:dispatchEvent(ViewEvent.ToSwitchTab, 3, slot5.prefab)
		StoreController.instance:dispatchEvent(StoreEvent.OnSwitchTab, slot5)
	end
end

function slot0.getSelectFirstTabId(slot0)
	return slot0._selectFirstTabId
end

function slot0.playNormalStoreAnimation(slot0)
	slot0._ScrollViewNormalStore:playOpenAnimation()
end

function slot0.playSummonStoreAnimation(slot0)
	if slot0._ScrollViewSummonStore ~= nil then
		slot0._ScrollViewSummonStore:playOpenAnimation()
	end
end

function slot0.playChargeStoreAnimation(slot0)
	slot0._ScrollViewChargeStore:playOpenAnimation()
end

function slot0.playRoomtoreAnimation(slot0)
	slot0._ScrollViewRoomStore:playOpenAnimation()
end

function slot0.playCritterStoreAnimation(slot0)
	slot0._ScrollViewRoomCritterStore:playOpenAnimation()
end

function slot0.setRoomStoreAnimation(slot0, slot1)
	for slot6 = slot1 + 1, 8 do
	end

	slot0._ScrollViewRoomStore._animationDelayTimes = {
		[slot6 - slot1] = math.floor((slot6 - 1) / 4) * 0.07
	}
end

function slot0.getJumpTabId(slot0)
	return slot0.jumpTabId
end

function slot0.getJumpGoodsId(slot0)
	slot0.jumpGoodsId = nil

	return slot0.jumpGoodsId
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)
	StoreController.instance:dispatchEvent(StoreEvent.SetVisibleInternal, slot1)
end

return slot0
