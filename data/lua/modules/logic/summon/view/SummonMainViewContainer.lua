module("modules.logic.summon.view.SummonMainViewContainer", package.seeall)

slot0 = class("SummonMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.centerTabContent = SummonMainPreloadView.New(3, "#go_ui/contentView")

	slot0.centerTabContent:preloadTab(slot0:getPreloadTabs())
	table.insert(slot1, slot0.centerTabContent)
	table.insert(slot1, TabViewGroup.New(1, "#go_ui/#go_lefttop"))
	table.insert(slot1, TabViewGroup.New(2, "#go_ui/#go_righttop"))

	slot0._mainView = SummonMainView.New()

	table.insert(slot1, slot0._mainView)
	table.insert(slot1, SummonMainTabView.New())
	SummonMainCategoryListModel.instance:saveEnterTime()

	uv0.BlockCloseKey = "SummonCloseAnim"

	return slot1
end

function slot0.getPreloadTabs(slot0)
	slot2 = {}
	slot5 = 1

	for slot9, slot10 in ipairs(SummonMainModel.getValidPools()) do
		if slot10.id ~= SummonMainModel.instance:getCurId() then
			-- Nothing
		else
			table.insert(slot2, slot11)

			slot5 = slot11
		end
	end

	for slot9, slot10 in pairs({
		[SummonMainModel.instance:getADPageTabIndexForUI(slot10)] = true
	}) do
		if slot9 ~= slot5 then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0.preloadUIRes(slot0)
	if not slot0._uiLoader then
		slot0._uiLoader = MultiAbLoader.New()

		slot0._uiLoader:setPathList(SummonMainController.instance:pickAllUIPreloadRes())
		slot0._uiLoader:startLoad(slot0.disposeUILoader, slot0)
	end
end

function slot0.disposeUILoader(slot0)
	if slot0._uiLoader ~= nil then
		logNormal("disposeUILoader")
		slot0._uiLoader:dispose()

		slot0._uiLoader = nil
	end
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0._navigateButtonView:setCloseCheck(slot0._closeCheckFunc, slot0)
		slot0._navigateButtonView:setHomeCheck(slot0._closeCheckFunc, slot0)

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		return slot0:_buildCurrency()
	elseif slot1 == 3 then
		slot0._tabInsts = SummonMainModel.instance:createUIClassTab()

		return slot0._tabInsts
	end
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(0)

	if slot0.centerTabContent then
		slot0.centerTabContent:checkPreload()
	end

	slot0:preloadUIRes()
end

function slot0.refreshHelp(slot0)
	if slot0._navigateButtonView then
		slot0._navigateButtonView:setParam({
			true,
			true,
			false
		})
	end
end

function slot0._buildCurrency(slot0)
	slot0._currencyView = CurrencyView.New({
		CurrencyEnum.CurrencyType.Diamond,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon,
		{
			id = 140001,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			jumpFunc = SummonMainModel.jumpToSummonCostShop
		}
	}, nil, , , true)

	return {
		slot0._currencyView
	}
end

function slot0.refreshCurrencyType(slot0)
	if slot0._currencyView and SummonMainModel.instance:getCurPool() then
		slot0._currencyView:setCurrencyType(SummonMainModel.getCostCurrencyParam(slot1))
	end
end

function slot0._closeCheckFunc(slot0)
	logNormal("_closeCheckFunc")
	TaskDispatcher.runDelay(slot0._onAnimExit, slot0, slot0._mainView:startExitSummonFadeOut())
	slot0:_onBlackLoadingShow()

	return false
end

function slot0.getCurTabInst(slot0)
	if SummonMainModel.instance:getCurADPageIndex() then
		return slot0._tabInsts[slot1]
	end

	return nil
end

function slot0._onBlackLoadingShow(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onMainUILoaded, slot0)
		MainController.instance:enterMainScene(true)
	else
		slot0._isSceneExitFinish = true
	end

	VirtualSummonScene.instance:close(true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(uv0.BlockCloseKey)
end

function slot0._onMainUILoaded(slot0, slot1)
	if slot1 == ViewName.MainView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._onMainUILoaded, slot0)

		slot0._isSceneExitFinish = true

		logNormal("_onMainSceneLoaded ViewName : " .. tostring(slot1))
		slot0:_checkAllStepFinish()
	end
end

function slot0._onAnimExit(slot0)
	slot0._isAnimExitFinish = true

	slot0:_checkAllStepFinish()
end

function slot0._checkAllStepFinish(slot0)
	if slot0._isSceneExitFinish and slot0._isAnimExitFinish then
		slot0:reallyClose()
	end
end

function slot0.reallyClose(slot0)
	UIBlockMgr.instance:endBlock(uv0.BlockCloseKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
	slot0:closeThis()
end

function slot0.onContainerClose(slot0)
	slot0:disposeUILoader()
end

return slot0
