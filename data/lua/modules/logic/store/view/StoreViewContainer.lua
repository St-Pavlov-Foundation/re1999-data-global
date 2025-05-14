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
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			true,
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
		local var_2_0 = ListScrollParam.New()

		var_2_0.scrollGOPath = "#scroll_prop"
		var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_0.cellClass = NormalStoreGoodsItem
		var_2_0.scrollDir = ScrollEnum.ScrollDirV
		var_2_0.lineCount = 4
		var_2_0.cellWidth = 332
		var_2_0.cellHeight = 355
		var_2_0.cellSpaceH = 29
		var_2_0.cellSpaceV = 37
		var_2_0.startSpace = 31

		local var_2_1 = ListScrollParam.New()

		var_2_1.scrollGOPath = "#scroll_prop"
		var_2_1.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_1.prefabUrl = arg_2_0._viewSetting.otherRes[2]
		var_2_1.cellClass = ChargeStoreGoodsItem
		var_2_1.scrollDir = ScrollEnum.ScrollDirV
		var_2_1.lineCount = 3
		var_2_1.cellWidth = 446
		var_2_1.cellHeight = 406
		var_2_1.cellSpaceH = 38
		var_2_1.cellSpaceV = 35
		var_2_1.startSpace = 0

		local var_2_2 = ListScrollParam.New()

		var_2_2.scrollGOPath = "#scroll_prop"
		var_2_2.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_2.prefabUrl = arg_2_0._viewSetting.otherRes[3]
		var_2_2.cellClass = StoreSkinGoodsItem
		var_2_2.scrollDir = ScrollEnum.ScrollDirH
		var_2_2.lineCount = 1
		var_2_2.cellWidth = 374
		var_2_2.cellHeight = 955
		var_2_2.cellSpaceH = 31
		var_2_2.cellSpaceV = 0
		var_2_2.startSpace = 7

		local var_2_3 = ListScrollParam.New()

		var_2_3.scrollGOPath = "#scroll_prop"
		var_2_3.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_3.prefabUrl = arg_2_0._viewSetting.otherRes[4]
		var_2_3.cellClass = PackageStoreGoodsItem
		var_2_3.scrollDir = ScrollEnum.ScrollDirH
		var_2_3.lineCount = 1
		var_2_3.cellWidth = 340
		var_2_3.cellHeight = 770
		var_2_3.cellSpaceH = 29.5
		var_2_3.cellSpaceV = 0
		var_2_3.startSpace = 8

		local var_2_4 = TreeScrollParam.New()

		var_2_4.scrollGOPath = "#scroll_prop"
		var_2_4.prefabType = ScrollEnum.ScrollPrefabFromView
		var_2_4.prefabUrls = {
			"roomstoreitem/root",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node"
		}
		var_2_4.cellClass = StoreRoomTreeItem
		var_2_4.scrollDir = ScrollEnum.ScrollDirV

		local var_2_5 = {}

		for iter_2_0 = 1, 12 do
			var_2_5[iter_2_0] = math.floor((iter_2_0 - 1) / 4) * 0.07
		end

		local var_2_6 = {}

		for iter_2_1 = 1, 9 do
			var_2_6[iter_2_1] = math.floor((iter_2_1 - 1) / 3) * 0.07
		end

		local var_2_7 = {}
		local var_2_8 = {
			__index = function(arg_3_0, arg_3_1)
				return (arg_3_1 - 1) * 0.07
			end
		}

		setmetatable(var_2_7, var_2_8)

		arg_2_0._ScrollViewNormalStore = LuaListScrollViewWithAnimator.New(StoreNormalGoodsItemListModel.instance, var_2_0, var_2_5)
		arg_2_0._ScrollViewChargeStore = LuaListScrollViewWithAnimator.New(StoreChargeGoodsItemListModel.instance, var_2_1, var_2_6)
		arg_2_0._ScrollViewPackageStore = LuaListScrollViewWithAnimator.New(StorePackageGoodsItemListModel.instance, var_2_3, var_2_7)
		arg_2_0._ScrollViewSkinStore = LuaListScrollViewWithAnimator.New(StoreClothesGoodsItemListModel.instance, var_2_2, var_2_7)
		arg_2_0._ScrollViewRoomStore = LuaTreeScrollView.New(StoreRoomGoodsItemListModel.instance, var_2_4)

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
				ClothesStoreView.New(),
				arg_2_0._ScrollViewSkinStore
			}),
			MultiView.New({
				PackageStoreView.New(),
				arg_2_0._ScrollViewPackageStore
			}),
			MultiView.New({
				RecommendStoreView.New()
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
		local var_2_9 = ListScrollParam.New()

		var_2_9.scrollGOPath = "#scroll_goods"
		var_2_9.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_9.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_9.cellClass = RoomStoreGoodsItem
		var_2_9.scrollDir = ScrollEnum.ScrollDirV
		var_2_9.lineCount = 4
		var_2_9.cellWidth = 332
		var_2_9.cellHeight = 355
		var_2_9.cellSpaceH = 29
		var_2_9.cellSpaceV = 37
		var_2_9.startSpace = 31

		local var_2_10 = {}

		for iter_2_2 = 1, 12 do
			var_2_10[iter_2_2] = math.floor((iter_2_2 - 1) / 4) * 0.07
		end

		arg_2_0._ScrollViewRoomCritterStore = LuaListScrollViewWithAnimator.New(StoreCritterGoodsItemListModel.instance, var_2_9, var_2_10)

		return {
			MultiView.New({
				RoomCritterStoreView.New(),
				arg_2_0._ScrollViewRoomCritterStore
			})
		}
	elseif arg_2_1 == 6 then
		local var_2_11 = ListScrollParam.New()

		var_2_11.scrollGOPath = "#scroll_prop"
		var_2_11.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_11.prefabUrl = arg_2_0._viewSetting.otherRes[5]
		var_2_11.cellClass = SummonStoreGoodsItem
		var_2_11.scrollDir = ScrollEnum.ScrollDirV
		var_2_11.lineCount = 4
		var_2_11.cellWidth = 332
		var_2_11.cellHeight = 355
		var_2_11.cellSpaceH = 29
		var_2_11.cellSpaceV = 37
		var_2_11.startSpace = 31

		local var_2_12 = {}

		for iter_2_3 = 1, 12 do
			var_2_12[iter_2_3] = math.floor((iter_2_3 - 1) / 4) * 0.07
		end

		arg_2_0._ScrollViewSummonStore = LuaListScrollViewWithAnimator.New(StoreNormalGoodsItemListModel.instance, var_2_11, var_2_12)

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
	arg_7_0.jumpTabId = arg_7_1
	arg_7_0.jumpGoodsId = arg_7_3
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
	return arg_15_0.jumpTabId
end

function var_0_0.getJumpGoodsId(arg_16_0)
	local var_16_0 = arg_16_0.jumpGoodsId

	arg_16_0.jumpGoodsId = nil

	return var_16_0
end

function var_0_0.setVisibleInternal(arg_17_0, arg_17_1)
	var_0_0.super.setVisibleInternal(arg_17_0, arg_17_1)
	StoreController.instance:dispatchEvent(StoreEvent.SetVisibleInternal, arg_17_1)
end

return var_0_0
