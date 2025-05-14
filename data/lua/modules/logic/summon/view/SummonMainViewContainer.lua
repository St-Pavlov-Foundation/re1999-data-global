module("modules.logic.summon.view.SummonMainViewContainer", package.seeall)

local var_0_0 = class("SummonMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.centerTabContent = SummonMainPreloadView.New(3, "#go_ui/contentView")

	arg_1_0.centerTabContent:preloadTab(arg_1_0:getPreloadTabs())
	table.insert(var_1_0, arg_1_0.centerTabContent)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_ui/#go_lefttop"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_ui/#go_righttop"))

	arg_1_0._mainView = SummonMainView.New()

	table.insert(var_1_0, arg_1_0._mainView)
	table.insert(var_1_0, SummonMainTabView.New())
	SummonMainCategoryListModel.instance:saveEnterTime()

	var_0_0.BlockCloseKey = "SummonCloseAnim"

	return var_1_0
end

function var_0_0.getPreloadTabs(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = SummonMainModel.getValidPools()
	local var_2_3 = SummonMainModel.instance:getCurId()
	local var_2_4 = 1

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		local var_2_5 = SummonMainModel.instance:getADPageTabIndexForUI(iter_2_1)

		if iter_2_1.id ~= var_2_3 then
			var_2_0[var_2_5] = true
		else
			table.insert(var_2_1, var_2_5)

			var_2_4 = var_2_5
		end
	end

	for iter_2_2, iter_2_3 in pairs(var_2_0) do
		if iter_2_2 ~= var_2_4 then
			table.insert(var_2_1, iter_2_2)
		end
	end

	return var_2_1
end

function var_0_0.preloadUIRes(arg_3_0)
	if not arg_3_0._uiLoader then
		local var_3_0 = SummonMainController.instance:pickAllUIPreloadRes()

		arg_3_0._uiLoader = MultiAbLoader.New()

		arg_3_0._uiLoader:setPathList(var_3_0)
		arg_3_0._uiLoader:startLoad(arg_3_0.disposeUILoader, arg_3_0)
	end
end

function var_0_0.disposeUILoader(arg_4_0)
	if arg_4_0._uiLoader ~= nil then
		logNormal("disposeUILoader")
		arg_4_0._uiLoader:dispose()

		arg_4_0._uiLoader = nil
	end
end

function var_0_0.buildTabViews(arg_5_0, arg_5_1)
	if arg_5_1 == 1 then
		arg_5_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_5_0._navigateButtonView:setCloseCheck(arg_5_0._closeCheckFunc, arg_5_0)
		arg_5_0._navigateButtonView:setHomeCheck(arg_5_0._closeCheckFunc, arg_5_0)

		return {
			arg_5_0._navigateButtonView
		}
	elseif arg_5_1 == 2 then
		return arg_5_0:_buildCurrency()
	elseif arg_5_1 == 3 then
		arg_5_0._tabInsts = SummonMainModel.instance:createUIClassTab()

		return arg_5_0._tabInsts
	end
end

function var_0_0.onContainerOpenFinish(arg_6_0)
	arg_6_0._navigateButtonView:resetOnCloseViewAudio(0)

	if arg_6_0.centerTabContent then
		arg_6_0.centerTabContent:checkPreload()
	end

	arg_6_0:preloadUIRes()
end

function var_0_0.refreshHelp(arg_7_0)
	if arg_7_0._navigateButtonView then
		arg_7_0._navigateButtonView:setParam({
			true,
			true,
			false
		})
	end
end

function var_0_0._buildCurrency(arg_8_0)
	arg_8_0._currencyView = CurrencyView.New({
		CurrencyEnum.CurrencyType.Diamond,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon,
		{
			id = 140001,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			jumpFunc = SummonMainModel.jumpToSummonCostShop
		}
	}, nil, nil, nil, true)

	return {
		arg_8_0._currencyView
	}
end

function var_0_0.refreshCurrencyType(arg_9_0)
	if arg_9_0._currencyView then
		local var_9_0 = SummonMainModel.instance:getCurPool()

		if var_9_0 then
			arg_9_0._currencyView:setCurrencyType(SummonMainModel.getCostCurrencyParam(var_9_0))
		end
	end
end

function var_0_0._closeCheckFunc(arg_10_0)
	logNormal("_closeCheckFunc")

	local var_10_0 = arg_10_0._mainView:startExitSummonFadeOut()

	TaskDispatcher.runDelay(arg_10_0._onAnimExit, arg_10_0, var_10_0)
	arg_10_0:_onBlackLoadingShow()

	return false
end

function var_0_0.getCurTabInst(arg_11_0)
	local var_11_0 = SummonMainModel.instance:getCurADPageIndex()

	if var_11_0 then
		return arg_11_0._tabInsts[var_11_0]
	end

	return nil
end

function var_0_0._onBlackLoadingShow(arg_12_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_12_0._onMainUILoaded, arg_12_0)
		MainController.instance:enterMainScene(true)
	else
		arg_12_0._isSceneExitFinish = true
	end

	VirtualSummonScene.instance:close(true)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(var_0_0.BlockCloseKey)
end

function var_0_0._onMainUILoaded(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.MainView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_13_0._onMainUILoaded, arg_13_0)

		arg_13_0._isSceneExitFinish = true

		logNormal("_onMainSceneLoaded ViewName : " .. tostring(arg_13_1))
		arg_13_0:_checkAllStepFinish()
	end
end

function var_0_0._onAnimExit(arg_14_0)
	arg_14_0._isAnimExitFinish = true

	arg_14_0:_checkAllStepFinish()
end

function var_0_0._checkAllStepFinish(arg_15_0)
	if arg_15_0._isSceneExitFinish and arg_15_0._isAnimExitFinish then
		arg_15_0:reallyClose()
	end
end

function var_0_0.reallyClose(arg_16_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockCloseKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
	arg_16_0:closeThis()
end

function var_0_0.onContainerClose(arg_17_0)
	arg_17_0:disposeUILoader()
end

return var_0_0
