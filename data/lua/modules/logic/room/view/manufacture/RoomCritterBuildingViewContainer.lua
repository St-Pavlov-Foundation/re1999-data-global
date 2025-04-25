module("modules.logic.room.view.manufacture.RoomCritterBuildingViewContainer", package.seeall)

slot0 = class("RoomCritterBuildingViewContainer", BaseViewContainer)
slot1 = {
	Navigate = 1,
	SubView = 2,
	Currency = 3
}
slot0.SubViewTabId = {
	Summon = 3,
	Rest = 1,
	Training = 2,
	Incubate = 4
}
slot0.TabSettingList = {
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
		helpBtnCallBack = function ()
			CritterSummonController.instance:openSummonRuleTipView(RoomSummonEnum.SummonType.Summon)
		end
	},
	{
		icon = "critter_summon_icon_4",
		name = "room_critter_building_breed",
		isPlayAnim = true,
		currency = CritterIncubateModel.instance:getCostCurrency(),
		needHideCurrencyBtn = CritterIncubateModel.instance:getCostCurrency(),
		helpBtnCallBack = function ()
			CritterSummonController.instance:openSummonRuleTipView(RoomSummonEnum.SummonType.Incubate)
		end,
		openBtnCallBack = function ()
			return RoomTradeTaskModel.instance:getOpenCritterIncubateLevel() <= ManufactureModel.instance:getTradeLevel()
		end
	}
}

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCritterBuildingView.New())
	table.insert(slot1, TabViewGroup.New(uv0.Navigate, "#go_BackBtns"))
	table.insert(slot1, TabViewGroup.New(uv0.SubView, "#go_subView"))
	table.insert(slot1, TabViewGroup.New(uv0.Currency, "righttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0.Navigate then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot0.navigateView
		}
	elseif slot1 == uv0.SubView then
		slot0.subViewList = {
			slot0:getRestMultiView(),
			slot0:getTrainMultiView(),
			slot0:getSummonMultiView(),
			slot0:getIncubateMultiView()
		}

		return slot0.subViewList
	elseif slot1 == 3 then
		slot0._currencyView = CurrencyView.New(uv1.TabSettingList[slot0:getDefaultSelectedTab()].currency)

		return {
			slot0._currencyView
		}
	end
end

function slot0.getRestMultiView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "content/feed/#scroll_feed"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "content/feed/#scroll_feed/viewport/content/go_feeditem"
	slot1.cellClass = RoomCritterRestViewFoodItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.cellWidth = 150
	slot1.cellHeight = 122
	slot1.cellSpaceV = 0

	return MultiView.New({
		RoomCritterRestView.New(),
		LuaListScrollView.New(RoomCritterFoodListModel.instance, slot1),
		RoomCritterRestViewMapUI.New()
	})
end

function slot0.getSummonMultiView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "root/right/#go_critterSub/#scroll_critter"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "root/right/#go_critterSub/#go_critteritem"
	slot1.cellClass = RoomCritterSummonPoolItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 2
	slot1.cellWidth = 166
	slot1.cellHeight = 166
	slot1.cellSpaceV = 0

	return MultiView.New({
		RoomCritterSummonView.New(),
		LuaListScrollView.New(RoomSummonPoolCritterListModel.instance, slot1)
	})
end

function slot0.getTrainMultiView(slot0)
	return MultiView.New(RoomCritterTrainViewContainer.createViewList())
end

function slot0.getIncubateMultiView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "root/right/#go_critter/#scroll_critter"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "root/right/#go_critter/#scroll_critter/viewport/content/#go_critterItem"
	slot1.cellClass = RoomCritterIncubateItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 540
	slot1.cellHeight = 184
	slot1.cellSpaceV = 8.6
	slot1.startSpace = 14

	return MultiView.New({
		RoomCritterIncubateView.New(),
		LuaListScrollView.New(CritterIncubateListModel.instance, slot1)
	})
end

function slot0._overrideCloseFunc(slot0)
	if ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
		ViewMgr.instance:closeView(ViewName.RoomCritterPlaceView)
		CritterController.instance:clearSelectedCritterSeatSlot()

		return
	end

	if slot0:getContainerCurSelectTab() == uv0.SubViewTabId.Training and slot0:getSubViewTabState(uv0.SubViewTabId.Training) and slot1 ~= CritterEnum.TrainOPState.Normal then
		slot0:dispatchEvent(CritterEvent.UITrainViewGoBack)

		return
	end

	ManufactureController.instance:closeCritterBuildingView(false)
	ManufactureController.instance:resetCameraOnCloseView()
end

function slot0.getDefaultSelectedTab(slot0)
	slot1 = uv0.SubViewTabId.Rest

	if slot0:checkTabId(slot0.viewParam and slot0.viewParam.defaultTab) then
		slot1 = slot2
	end

	return slot1
end

function slot0.checkTabId(slot0, slot1)
	slot2 = false

	if slot1 then
		for slot6, slot7 in pairs(uv0.SubViewTabId) do
			if slot7 == slot1 then
				slot2 = true

				break
			end
		end
	end

	return slot2
end

function slot0.onContainerInit(slot0)
	slot1 = nil

	if slot0.viewParam then
		slot2 = slot0:getDefaultSelectedTab()
		slot0.viewParam.defaultTabIds = {
			[uv0.SubView] = slot2
		}
		slot0._curSelectTab = slot2
		slot1 = slot0.viewParam.buildingUid
	end

	if not slot1 then
		if ManufactureModel.instance:getCritterBuildingListInOrder() then
			slot1 = slot2[1].buildingUid
		else
			logError("RoomCritterBuildingViewContainer:onContainerInit,error,can't find critterBuilding")
		end
	end

	slot0:setContainerViewBuildingUid(slot1)
end

function slot0.switchTab(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = uv0.TabSettingList[slot1]

	slot0._currencyView:setCurrencyType(slot2.currency)

	slot0._currencyView.foreHideBtn = slot2.needHideCurrencyBtn ~= nil

	if slot2.needHideCurrencyBtn then
		for slot7, slot8 in pairs(slot2.needHideCurrencyBtn) do
			slot0._currencyView:_hideAddBtn(slot8)
		end
	end

	slot0:playViewOpenCloseAnim(slot1, function ()
		uv0:dispatchEvent(ViewEvent.ToSwitchTab, uv1.SubView, uv2)
	end, slot0)

	slot0._curSelectTab = slot1
end

function slot0.playViewOpenCloseAnim(slot0, slot1, slot2, slot3)
	if not slot0._curSelectTab then
		slot0._curSelectTab = slot0:getDefaultSelectedTab()
	end

	slot5 = uv0.TabSettingList[slot1].isPlayAnim

	if uv0.TabSettingList[slot0._curSelectTab].isPlayAnim then
		if slot0.subViewList[slot0._curSelectTab] then
			if slot0.subViewList[slot0._curSelectTab]._views[1] and slot6.viewGO then
				if SLFramework.AnimatorPlayer.Get(slot6.viewGO) then
					slot7:Play(UIAnimationName.Close, slot2, slot3)
				else
					slot4 = false
				end
			else
				slot4 = false
			end
		else
			slot4 = false
		end
	end

	if slot5 then
		if slot0.subViewList[slot1] then
			if slot0.subViewList[slot1]._views[1] and slot6.viewGO then
				if SLFramework.AnimatorPlayer.Get(slot6.viewGO) then
					if slot4 then
						slot7:Play(UIAnimationName.Open, nil, slot0)
					else
						slot7:Play(UIAnimationName.Open, slot2, slot3)
					end
				else
					slot5 = false
				end
			else
				slot5 = false
			end
		else
			slot5 = false
		end
	end

	if not slot4 and not slot5 then
		slot2(slot3)
	end
end

function slot0.playCloseTransition(slot0)
	slot0:startViewCloseBlock()
	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Close, slot0.onPlayCloseTransitionFinish, slot0)
end

function slot0.setContainerViewBuildingUid(slot0, slot1)
	slot0._viewBuildingUid = slot1
end

function slot0.getContainerViewBuildingUid(slot0)
	return slot0._viewBuildingUid
end

function slot0.getContainerCurSelectTab(slot0)
	return slot0._curSelectTab
end

function slot0.setContainerTabState(slot0, slot1, slot2)
	slot0._subViewTagOpDict = slot0._subViewTagOpDict or {}
	slot0._subViewTagOpDict[slot1] = slot2
end

function slot0.getSubViewTabState(slot0, slot1)
	return slot0._subViewTagOpDict and slot0._subViewTagOpDict[slot1]
end

function slot0.getContainerViewBuilding(slot0, slot1)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot0._viewBuildingUid) and slot1 then
		logError(string.format("RoomCritterBuildingViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", slot0._viewBuildingUid))
	end

	return slot0._viewBuildingUid, slot2
end

return slot0
