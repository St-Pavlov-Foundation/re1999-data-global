module("modules.logic.store.view.StoreViewContainer", package.seeall)

local var_0_0 = class("StoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_topright"))
	table.insert(var_1_0, TabViewGroup.New(3, "#go_store"))

	arg_1_0.storeView = StoreView.New()

	table.insert(var_1_0, arg_1_0.storeView)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = StoreController.instance:needHideHome()

		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			not var_2_0,
			false
		})

		return {
			arg_2_0.navigationView
		}
	elseif arg_2_1 == 2 then
		arg_2_0._currencyView = CurrencyView.New({})

		return {
			arg_2_0._currencyView
		}
	elseif arg_2_1 == 3 then
		local var_2_1 = ListScrollParam.New()

		var_2_1.scrollGOPath = "#scroll_prop"
		var_2_1.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_1.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_1.cellClass = NormalStoreGoodsItem
		var_2_1.scrollDir = ScrollEnum.ScrollDirV
		var_2_1.lineCount = 4
		var_2_1.cellWidth = 332
		var_2_1.cellHeight = 355
		var_2_1.cellSpaceH = 29
		var_2_1.cellSpaceV = 37
		var_2_1.startSpace = 31

		local var_2_2 = ListScrollParam.New()

		var_2_2.scrollGOPath = "#scroll_prop"
		var_2_2.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_2.prefabUrl = arg_2_0._viewSetting.otherRes[2]
		var_2_2.cellClass = ChargeStoreGoodsItem
		var_2_2.scrollDir = ScrollEnum.ScrollDirV
		var_2_2.lineCount = 3
		var_2_2.cellWidth = 446
		var_2_2.cellHeight = 406
		var_2_2.cellSpaceH = 38
		var_2_2.cellSpaceV = 35
		var_2_2.startSpace = 0

		local var_2_3 = ListScrollParam.New()

		var_2_3.scrollGOPath = "#go_has/#scroll_skin"
		var_2_3.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_3.prefabUrl = arg_2_0._viewSetting.otherRes[3]
		var_2_3.cellClass = StoreSkinGoodsItem
		var_2_3.scrollDir = ScrollEnum.ScrollDirV
		var_2_3.lineCount = 2
		var_2_3.cellWidth = 260
		var_2_3.cellHeight = 408
		var_2_3.cellSpaceH = 0
		var_2_3.cellSpaceV = 0
		var_2_3.startSpace = 0
		var_2_3.notPlayAnimation = true

		local var_2_4 = ListScrollParam.New()

		var_2_4.scrollGOPath = "#scroll_prop"
		var_2_4.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_4.prefabUrl = arg_2_0._viewSetting.otherRes[4]
		var_2_4.cellClass = PackageStoreGoodsItem
		var_2_4.scrollDir = ScrollEnum.ScrollDirH
		var_2_4.lineCount = 1
		var_2_4.cellWidth = 340
		var_2_4.cellHeight = 770
		var_2_4.cellSpaceH = 29.5
		var_2_4.cellSpaceV = 0
		var_2_4.startSpace = 8

		local var_2_5 = TreeScrollParam.New()

		var_2_5.scrollGOPath = "#scroll_prop"
		var_2_5.prefabType = ScrollEnum.ScrollPrefabFromView
		var_2_5.prefabUrls = {
			"roomstoreitem/root",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node"
		}
		var_2_5.cellClass = StoreRoomTreeItem
		var_2_5.scrollDir = ScrollEnum.ScrollDirV

		local var_2_6 = {}

		for iter_2_0 = 1, 12 do
			var_2_6[iter_2_0] = math.floor((iter_2_0 - 1) / 4) * 0.07
		end

		local var_2_7 = {}

		for iter_2_1 = 1, 9 do
			var_2_7[iter_2_1] = math.floor((iter_2_1 - 1) / 3) * 0.07
		end

		local var_2_8 = {}
		local var_2_9 = {
			__index = function(arg_3_0, arg_3_1)
				return (arg_3_1 - 1) * 0.07
			end
		}

		setmetatable(var_2_8, var_2_9)

		arg_2_0._ScrollViewNormalStore = LuaListScrollViewWithAnimator.New(StoreNormalGoodsItemListModel.instance, var_2_1, var_2_6)
		arg_2_0._ScrollViewChargeStore = LuaListScrollViewWithAnimator.New(StoreChargeGoodsItemListModel.instance, var_2_2, var_2_7)
		arg_2_0._ScrollViewPackageStore = LuaListScrollViewWithAnimator.New(StorePackageGoodsItemListModel.instance, var_2_4, var_2_8)
		arg_2_0._ScrollViewSkinStore = LuaListScrollViewWithAnimator.New(StoreClothesGoodsItemListModel.instance, var_2_3)
		arg_2_0._ScrollViewRoomStore = LuaTreeScrollView.New(StoreRoomGoodsItemListModel.instance, var_2_5)
		arg_2_0._RecommendStoreView = RecommendStoreView.New()

		return {
			MultiView.New({
				NormalStoreView.New(),
				arg_2_0._ScrollViewNormalStore,
				TabViewGroup.New(6, "#go_limit")
			}),
			MultiView.New({
				ChargeStoreView.New(),
				arg_2_0._ScrollViewChargeStore
			}),
			MultiView.New({
				arg_2_0._ScrollViewSkinStore,
				ClothesStoreView.New(),
				ClothesStoreVideoView.New(),
				ClothesStoreDragView.New()
			}),
			MultiView.New({
				PackageStoreView.New(),
				arg_2_0._ScrollViewPackageStore
			}),
			MultiView.New({
				arg_2_0._RecommendStoreView
			}),
			MultiView.New({
				RoomStoreView.New(),
				arg_2_0._ScrollViewRoomStore,
				TabViewGroup.New(5, "#go_critter")
			}),
			MultiView.New({
				DecorateStoreView.New()
			})
		}
	elseif arg_2_1 == 4 then
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
	elseif arg_2_1 == 5 then
		local var_2_10 = ListScrollParam.New()

		var_2_10.scrollGOPath = "#scroll_goods"
		var_2_10.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_10.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_10.cellClass = RoomStoreGoodsItem
		var_2_10.scrollDir = ScrollEnum.ScrollDirV
		var_2_10.lineCount = 4
		var_2_10.cellWidth = 332
		var_2_10.cellHeight = 355
		var_2_10.cellSpaceH = 29
		var_2_10.cellSpaceV = 37
		var_2_10.startSpace = 31

		local var_2_11 = {}

		for iter_2_2 = 1, 12 do
			var_2_11[iter_2_2] = math.floor((iter_2_2 - 1) / 4) * 0.07
		end

		arg_2_0._ScrollViewRoomCritterStore = LuaListScrollViewWithAnimator.New(StoreCritterGoodsItemListModel.instance, var_2_10, var_2_11)

		return {
			MultiView.New({
				RoomCritterStoreView.New(),
				arg_2_0._ScrollViewRoomCritterStore
			})
		}
	elseif arg_2_1 == 6 then
		local var_2_12 = ListScrollParam.New()

		var_2_12.scrollGOPath = "#scroll_prop"
		var_2_12.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_12.prefabUrl = arg_2_0._viewSetting.otherRes[5]
		var_2_12.cellClass = SummonStoreGoodsItem
		var_2_12.scrollDir = ScrollEnum.ScrollDirV
		var_2_12.lineCount = 4
		var_2_12.cellWidth = 332
		var_2_12.cellHeight = 355
		var_2_12.cellSpaceH = 29
		var_2_12.cellSpaceV = 37
		var_2_12.startSpace = 31

		local var_2_13 = {}

		for iter_2_3 = 1, 12 do
			var_2_13[iter_2_3] = math.floor((iter_2_3 - 1) / 4) * 0.07
		end

		arg_2_0._ScrollViewSummonStore = LuaListScrollViewWithAnimator.New(StoreNormalGoodsItemListModel.instance, var_2_12, var_2_13)

		return {
			MultiView.New({
				StoreSummonView.New(),
				arg_2_0._ScrollViewSummonStore
			})
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Rolesopen)
end

function var_0_0.setCurrencyType(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if not string.nilorempty(arg_5_1) then
		local var_5_1 = string.split(arg_5_1, "#")

		for iter_5_0 = #var_5_1, 1, -1 do
			table.insert(var_5_0, tonumber(var_5_1[iter_5_0]))
		end
	end

	if arg_5_0._currencyView then
		arg_5_0._currencyView:setCurrencyType(var_5_0)
	end
end

function var_0_0.setCurrencyByParams(arg_6_0, arg_6_1)
	if arg_6_0._currencyView then
		arg_6_0._currencyView:setCurrencyType(arg_6_1)
	end
end

function var_0_0.selectTabView(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.viewParam.jumpTab = arg_7_1
	arg_7_0.viewParam.jumpGoodsId = arg_7_3
	arg_7_0._selectFirstTabId = arg_7_2

	local var_7_0 = StoreConfig.instance:getTabConfig(arg_7_2)

	arg_7_0.notPlayAnimation = false

	if arg_7_3 ~= nil then
		arg_7_0.notPlayAnimation = true

		if var_7_0 then
			if var_7_0.prefab == StoreEnum.Prefab.NormalStore then
				arg_7_0._ScrollViewNormalStore._firstUpdate = false
			elseif var_7_0.prefab == StoreEnum.Prefab.PackageStore then
				arg_7_0._ScrollViewPackageStore._firstUpdate = false
			elseif var_7_0.prefab == StoreEnum.Prefab.ChargeStore then
				arg_7_0._ScrollViewChargeStore._firstUpdate = false
			elseif var_7_0.prefab == StoreEnum.Prefab.RoomStore then
				arg_7_0._ScrollViewRoomStore._firstUpdate = false
			end
		end
	end

	if var_7_0 and var_7_0.prefab and var_7_0.prefab ~= 0 and not arg_7_4 then
		arg_7_0:dispatchEvent(ViewEvent.ToSwitchTab, 3, var_7_0.prefab)
		StoreController.instance:dispatchEvent(StoreEvent.OnSwitchTab, var_7_0)
	end
end

function var_0_0.getSelectFirstTabId(arg_8_0)
	return arg_8_0._selectFirstTabId
end

function var_0_0.playNormalStoreAnimation(arg_9_0)
	arg_9_0._ScrollViewNormalStore:playOpenAnimation()
end

function var_0_0.playSummonStoreAnimation(arg_10_0)
	if arg_10_0._ScrollViewSummonStore ~= nil then
		arg_10_0._ScrollViewSummonStore:playOpenAnimation()
	end
end

function var_0_0.playChargeStoreAnimation(arg_11_0)
	arg_11_0._ScrollViewChargeStore:playOpenAnimation()
end

function var_0_0.playRoomtoreAnimation(arg_12_0)
	arg_12_0._ScrollViewRoomStore:playOpenAnimation()
end

function var_0_0.playCritterStoreAnimation(arg_13_0)
	arg_13_0._ScrollViewRoomCritterStore:playOpenAnimation()
end

function var_0_0.setRoomStoreAnimation(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0 = arg_14_1 + 1, 8 do
		local var_14_1 = math.floor((iter_14_0 - 1) / 4) * 0.07

		var_14_0[iter_14_0 - arg_14_1] = var_14_1
	end

	arg_14_0._ScrollViewRoomStore._animationDelayTimes = var_14_0
end

function var_0_0.getJumpTabId(arg_15_0)
	return arg_15_0.viewParam.jumpTab
end

function var_0_0.getJumpGoodsId(arg_16_0)
	local var_16_0 = arg_16_0.viewParam.jumpGoodsId

	arg_16_0.viewParam.jumpGoodsId = nil

	return var_16_0
end

function var_0_0.isJumpFocus(arg_17_0)
	return arg_17_0.viewParam.isFocus
end

function var_0_0.setVisibleInternal(arg_18_0, arg_18_1)
	var_0_0.super.setVisibleInternal(arg_18_0, arg_18_1)
	StoreController.instance:dispatchEvent(StoreEvent.SetVisibleInternal, arg_18_1)
end

function var_0_0.sortSkinStoreSiblingIndex(arg_19_0)
	local var_19_0 = arg_19_0._ScrollViewSkinStore and arg_19_0._ScrollViewSkinStore._cellCompDict
	local var_19_1

	if var_19_0 then
		local var_19_2 = 0

		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			if iter_19_0 and iter_19_0._mo and iter_19_0._isUniqueSkin and iter_19_0:_isUniqueSkin() then
				var_19_1 = var_19_1 or {}

				table.insert(var_19_1, iter_19_0)
			end

			var_19_2 = var_19_2 + 1
		end
	end

	if var_19_1 then
		table.sort(var_19_1, var_0_0._sortSkinGoodsItem)

		for iter_19_2 = #var_19_1, 1, -1 do
			local var_19_3 = var_19_1[iter_19_2]

			gohelper.setAsLastSibling(var_19_3.parentViewGO)
		end
	end
end

function var_0_0.getRecommendTabIndex(arg_20_0, arg_20_1)
	if arg_20_0._RecommendStoreView then
		return arg_20_0._RecommendStoreView:getIndexByTabId(arg_20_1)
	end

	return 1
end

function var_0_0._sortSkinGoodsItem(arg_21_0, arg_21_1)
	if arg_21_0._index ~= arg_21_1._index then
		return arg_21_0._index < arg_21_1._index
	end
end

return var_0_0
