module("modules.logic.room.view.manufacture.RoomCritterBuildingViewContainer", package.seeall)

local var_0_0 = class("RoomCritterBuildingViewContainer", BaseViewContainer)
local var_0_1 = {
	Navigate = 1,
	SubView = 2,
	Currency = 3
}

var_0_0.SubViewTabId = {
	Summon = 3,
	Rest = 1,
	Training = 2,
	Incubate = 4
}
var_0_0.TabSettingList = {
	{
		isPlayAnim = true,
		name = "room_critter_building_rest",
		icon = "critter_summon_icon_1",
		currency = {}
	},
	{
		isPlayAnim = true,
		name = "room_critter_building_training",
		icon = "critter_summon_icon_3",
		currency = {}
	},
	{
		icon = "critter_summon_icon_2",
		name = "room_critter_building_incubate",
		isPlayAnim = true,
		currency = CritterSummonModel.instance:getCostCurrency(),
		needHideCurrencyBtn = CritterSummonModel.instance:getCostCurrency(),
		helpBtnCallBack = function()
			CritterSummonController.instance:openSummonRuleTipView(RoomSummonEnum.SummonType.Summon)
		end
	},
	{
		icon = "critter_summon_icon_4",
		name = "room_critter_building_breed",
		isPlayAnim = true,
		currency = CritterIncubateModel.instance:getCostCurrency(),
		needHideCurrencyBtn = CritterIncubateModel.instance:getCostCurrency(),
		helpBtnCallBack = function()
			CritterSummonController.instance:openSummonRuleTipView(RoomSummonEnum.SummonType.Incubate)
		end,
		openBtnCallBack = function()
			return ManufactureModel.instance:getTradeLevel() >= RoomTradeTaskModel.instance:getOpenCritterIncubateLevel()
		end
	}
}

function var_0_0.buildViews(arg_4_0)
	local var_4_0 = {}

	table.insert(var_4_0, RoomCritterBuildingView.New())
	table.insert(var_4_0, TabViewGroup.New(var_0_1.Navigate, "#go_BackBtns"))
	table.insert(var_4_0, TabViewGroup.New(var_0_1.SubView, "#go_subView"))
	table.insert(var_4_0, TabViewGroup.New(var_0_1.Currency, "righttop"))

	return var_4_0
end

function var_0_0.buildTabViews(arg_5_0, arg_5_1)
	if arg_5_1 == var_0_1.Navigate then
		arg_5_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_5_0.navigateView:setOverrideClose(arg_5_0._overrideCloseFunc, arg_5_0)

		return {
			arg_5_0.navigateView
		}
	elseif arg_5_1 == var_0_1.SubView then
		arg_5_0.subViewList = {
			arg_5_0:getRestMultiView(),
			arg_5_0:getTrainMultiView(),
			arg_5_0:getSummonMultiView(),
			arg_5_0:getIncubateMultiView()
		}

		return arg_5_0.subViewList
	elseif arg_5_1 == 3 then
		local var_5_0 = arg_5_0:getDefaultSelectedTab()
		local var_5_1 = var_0_0.TabSettingList[var_5_0].currency

		arg_5_0._currencyView = CurrencyView.New(var_5_1)

		return {
			arg_5_0._currencyView
		}
	end
end

function var_0_0.getRestMultiView(arg_6_0)
	local var_6_0 = ListScrollParam.New()

	var_6_0.scrollGOPath = "content/feed/#scroll_feed"
	var_6_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_6_0.prefabUrl = "content/feed/#scroll_feed/viewport/content/go_feeditem"
	var_6_0.cellClass = RoomCritterRestViewFoodItem
	var_6_0.scrollDir = ScrollEnum.ScrollDirV
	var_6_0.cellWidth = 150
	var_6_0.cellHeight = 122
	var_6_0.cellSpaceV = 0

	local var_6_1 = LuaListScrollView.New(RoomCritterFoodListModel.instance, var_6_0)

	return MultiView.New({
		RoomCritterRestView.New(),
		var_6_1,
		RoomCritterRestViewMapUI.New()
	})
end

function var_0_0.getSummonMultiView(arg_7_0)
	local var_7_0 = ListScrollParam.New()

	var_7_0.scrollGOPath = "root/right/#go_critterSub/#scroll_critter"
	var_7_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_7_0.prefabUrl = "root/right/#go_critterSub/#go_critteritem"
	var_7_0.cellClass = RoomCritterSummonPoolItem
	var_7_0.scrollDir = ScrollEnum.ScrollDirV
	var_7_0.lineCount = 2
	var_7_0.cellWidth = 166
	var_7_0.cellHeight = 166
	var_7_0.cellSpaceV = 0

	local var_7_1 = LuaListScrollView.New(RoomSummonPoolCritterListModel.instance, var_7_0)

	return MultiView.New({
		RoomCritterSummonView.New(),
		var_7_1
	})
end

function var_0_0.getTrainMultiView(arg_8_0)
	return MultiView.New(RoomCritterTrainViewContainer.createViewList())
end

function var_0_0.getIncubateMultiView(arg_9_0)
	local var_9_0 = ListScrollParam.New()

	var_9_0.scrollGOPath = "root/right/#go_critter/#scroll_critter"
	var_9_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_9_0.prefabUrl = "root/right/#go_critter/#scroll_critter/viewport/content/#go_critterItem"
	var_9_0.cellClass = RoomCritterIncubateItem
	var_9_0.scrollDir = ScrollEnum.ScrollDirV
	var_9_0.lineCount = 1
	var_9_0.cellWidth = 540
	var_9_0.cellHeight = 184
	var_9_0.cellSpaceV = 8.6
	var_9_0.startSpace = 14

	local var_9_1 = LuaListScrollView.New(CritterIncubateListModel.instance, var_9_0)

	return MultiView.New({
		RoomCritterIncubateView.New(),
		var_9_1
	})
end

function var_0_0._overrideCloseFunc(arg_10_0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
		ViewMgr.instance:closeView(ViewName.RoomCritterPlaceView)
		CritterController.instance:clearSelectedCritterSeatSlot()

		return
	end

	if arg_10_0:getContainerCurSelectTab() == var_0_0.SubViewTabId.Training then
		local var_10_0 = arg_10_0:getSubViewTabState(var_0_0.SubViewTabId.Training)

		if var_10_0 and var_10_0 ~= CritterEnum.TrainOPState.Normal then
			arg_10_0:dispatchEvent(CritterEvent.UITrainViewGoBack)

			return
		end
	end

	ManufactureController.instance:closeCritterBuildingView(false)
	ManufactureController.instance:resetCameraOnCloseView()
end

function var_0_0.getDefaultSelectedTab(arg_11_0)
	local var_11_0 = var_0_0.SubViewTabId.Rest
	local var_11_1 = arg_11_0.viewParam and arg_11_0.viewParam.defaultTab

	if arg_11_0:checkTabId(var_11_1) then
		var_11_0 = var_11_1
	end

	return var_11_0
end

function var_0_0.checkTabId(arg_12_0, arg_12_1)
	local var_12_0 = false

	if arg_12_1 then
		for iter_12_0, iter_12_1 in pairs(var_0_0.SubViewTabId) do
			if iter_12_1 == arg_12_1 then
				var_12_0 = true

				break
			end
		end
	end

	return var_12_0
end

function var_0_0.onContainerInit(arg_13_0)
	local var_13_0

	if arg_13_0.viewParam then
		local var_13_1 = arg_13_0:getDefaultSelectedTab()

		arg_13_0.viewParam.defaultTabIds = {}
		arg_13_0.viewParam.defaultTabIds[var_0_1.SubView] = var_13_1
		arg_13_0._curSelectTab = var_13_1
		var_13_0 = arg_13_0.viewParam.buildingUid
	end

	if not var_13_0 then
		local var_13_2 = ManufactureModel.instance:getCritterBuildingListInOrder()

		if var_13_2 then
			var_13_0 = var_13_2[1].buildingUid
		else
			logError("RoomCritterBuildingViewContainer:onContainerInit,error,can't find critterBuilding")
		end
	end

	arg_13_0:setContainerViewBuildingUid(var_13_0)
end

function var_0_0.switchTab(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	local var_14_0 = var_0_0.TabSettingList[arg_14_1]
	local var_14_1 = var_14_0.currency

	arg_14_0._currencyView:setCurrencyType(var_14_1)

	arg_14_0._currencyView.foreHideBtn = var_14_0.needHideCurrencyBtn ~= nil

	if var_14_0.needHideCurrencyBtn then
		for iter_14_0, iter_14_1 in pairs(var_14_0.needHideCurrencyBtn) do
			arg_14_0._currencyView:_hideAddBtn(iter_14_1)
		end
	end

	arg_14_0:playViewOpenCloseAnim(arg_14_1, function()
		arg_14_0:dispatchEvent(ViewEvent.ToSwitchTab, var_0_1.SubView, arg_14_1)
	end, arg_14_0)

	arg_14_0._curSelectTab = arg_14_1
end

function var_0_0.playViewOpenCloseAnim(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_0._curSelectTab then
		arg_16_0._curSelectTab = arg_16_0:getDefaultSelectedTab()
	end

	local var_16_0 = var_0_0.TabSettingList[arg_16_0._curSelectTab].isPlayAnim
	local var_16_1 = var_0_0.TabSettingList[arg_16_1].isPlayAnim

	if var_16_0 then
		if arg_16_0.subViewList[arg_16_0._curSelectTab] then
			local var_16_2 = arg_16_0.subViewList[arg_16_0._curSelectTab]._views[1]

			if var_16_2 and var_16_2.viewGO then
				local var_16_3 = SLFramework.AnimatorPlayer.Get(var_16_2.viewGO)

				if var_16_3 then
					var_16_3:Play(UIAnimationName.Close, arg_16_2, arg_16_3)
				else
					var_16_0 = false
				end
			else
				var_16_0 = false
			end
		else
			var_16_0 = false
		end
	end

	if var_16_1 then
		if arg_16_0.subViewList[arg_16_1] then
			local var_16_4 = arg_16_0.subViewList[arg_16_1]._views[1]

			if var_16_4 and var_16_4.viewGO then
				local var_16_5 = SLFramework.AnimatorPlayer.Get(var_16_4.viewGO)

				if var_16_5 then
					if var_16_0 then
						var_16_5:Play(UIAnimationName.Open, nil, arg_16_0)
					else
						var_16_5:Play(UIAnimationName.Open, arg_16_2, arg_16_3)
					end
				else
					var_16_1 = false
				end
			else
				var_16_1 = false
			end
		else
			var_16_1 = false
		end
	end

	if not var_16_0 and not var_16_1 then
		arg_16_2(arg_16_3)
	end
end

function var_0_0.playCloseTransition(arg_17_0)
	arg_17_0:startViewCloseBlock()
	SLFramework.AnimatorPlayer.Get(arg_17_0.viewGO):Play(UIAnimationName.Close, arg_17_0.onPlayCloseTransitionFinish, arg_17_0)
end

function var_0_0.setContainerViewBuildingUid(arg_18_0, arg_18_1)
	arg_18_0._viewBuildingUid = arg_18_1
end

function var_0_0.getContainerViewBuildingUid(arg_19_0)
	return arg_19_0._viewBuildingUid
end

function var_0_0.getContainerCurSelectTab(arg_20_0)
	return arg_20_0._curSelectTab
end

function var_0_0.setContainerTabState(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._subViewTagOpDict = arg_21_0._subViewTagOpDict or {}
	arg_21_0._subViewTagOpDict[arg_21_1] = arg_21_2
end

function var_0_0.getSubViewTabState(arg_22_0, arg_22_1)
	return arg_22_0._subViewTagOpDict and arg_22_0._subViewTagOpDict[arg_22_1]
end

function var_0_0.getContainerViewBuilding(arg_23_0, arg_23_1)
	local var_23_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_23_0._viewBuildingUid)

	if not var_23_0 and arg_23_1 then
		logError(string.format("RoomCritterBuildingViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", arg_23_0._viewBuildingUid))
	end

	return arg_23_0._viewBuildingUid, var_23_0
end

return var_0_0
