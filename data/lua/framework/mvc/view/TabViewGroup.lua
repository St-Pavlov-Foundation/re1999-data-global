module("framework.mvc.view.TabViewGroup", package.seeall)

local var_0_0 = class("TabViewGroup", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._tabContainerId = arg_1_1 or 1
	arg_1_0._tabGOContainerPath = arg_1_2
	arg_1_0._tabGOContainer = nil
	arg_1_0._tabAbLoaders = {}
	arg_1_0._tabCanvasGroup = {}
	arg_1_0._tabViews = nil
	arg_1_0._curTabId = nil
	arg_1_0._hasOpenFinish = false
	arg_1_0._UIBlockKey = nil
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._UIBlockKey = arg_2_0.viewName .. UIBlockKey.TabViewOpening .. arg_2_0._tabContainerId
	arg_2_0._tabGOContainer = arg_2_0.viewGO

	if not string.nilorempty(arg_2_0._tabGOContainerPath) then
		arg_2_0._tabGOContainer = gohelper.findChild(arg_2_0.viewGO, arg_2_0._tabGOContainerPath)
	end

	if not arg_2_0._tabGOContainer then
		logError(arg_2_0.viewName .. " tabGOContainer not exist: " .. arg_2_0._tabGOContainerPath)
	end

	arg_2_0._tabViews = arg_2_0.viewContainer:buildTabViews(arg_2_0._tabContainerId)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_3_0._toSwitchTab, arg_3_0)

	local var_3_0 = arg_3_0.viewParam and type(arg_3_0.viewParam) == "table" and arg_3_0.viewParam.defaultTabIds and arg_3_0.viewParam.defaultTabIds[arg_3_0._tabContainerId] or 1

	arg_3_0:_openTabView(var_3_0)
end

function var_0_0.onOpenFinish(arg_4_0)
	if arg_4_0:_hasLoaded(arg_4_0._curTabId) then
		arg_4_0._tabViews[arg_4_0._curTabId]:onOpenFinishInternal()
	else
		arg_4_0._hasOpenFinish = true
	end
end

function var_0_0.onUpdateParam(arg_5_0)
	if arg_5_0:_hasLoaded(arg_5_0._curTabId) then
		arg_5_0._tabViews[arg_5_0._curTabId]:onUpdateParamInternal()
	end
end

function var_0_0.onClose(arg_6_0)
	arg_6_0._hasOpenFinish = false

	arg_6_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_6_0._toSwitchTab, arg_6_0)
	arg_6_0:_closeTabView()
end

function var_0_0.onCloseFinish(arg_7_0)
	if arg_7_0:_hasLoaded(arg_7_0._curTabId) then
		arg_7_0._tabViews[arg_7_0._curTabId]:onCloseFinishInternal()
	end

	arg_7_0._curTabId = nil
end

function var_0_0.removeEvents(arg_8_0)
	if arg_8_0._tabViews then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._tabViews) do
			local var_8_0 = arg_8_0._tabAbLoaders[iter_8_0]

			if var_8_0 and not var_8_0.isLoading then
				iter_8_1:removeEventsInternal()
			end
		end
	end
end

function var_0_0.onDestroyView(arg_9_0)
	if arg_9_0._tabViews then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._tabViews) do
			local var_9_0 = arg_9_0._tabAbLoaders[iter_9_0]

			if var_9_0 and not var_9_0.isLoading then
				iter_9_1:onDestroyViewInternal()
				iter_9_1:tryCallMethodName("__onDispose")
			end
		end
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0._tabAbLoaders) do
		iter_9_3:dispose()
	end

	arg_9_0._tabAbLoaders = nil
	arg_9_0._tabCanvasGroup = nil
	arg_9_0._tabGOContainer = nil
	arg_9_0._tabViews = nil
end

function var_0_0.getTabContainerId(arg_10_0)
	return arg_10_0._tabContainerId
end

function var_0_0.getCurTabId(arg_11_0)
	return arg_11_0._curTabId
end

function var_0_0.isHasTryCallFail(arg_12_0)
	if arg_12_0._tabViews then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._tabViews) do
			if iter_12_1 and iter_12_1:isHasTryCallFail() then
				return true
			end
		end
	end

	return false
end

function var_0_0._toSwitchTab(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == arg_13_0._tabContainerId then
		arg_13_0:_openTabView(arg_13_2)
	end
end

function var_0_0._openTabView(arg_14_0, arg_14_1)
	arg_14_0:_closeTabView()

	arg_14_0._curTabId = arg_14_1

	ViewMgr.instance:dispatchEvent(ViewEvent.BeforeOpenTabView, {
		tabGroupView = arg_14_0,
		viewName = arg_14_0.viewName,
		tabView = arg_14_0._tabViews[arg_14_0._curTabId]
	})

	if arg_14_0._tabAbLoaders[arg_14_0._curTabId] then
		arg_14_0:_setVisible(arg_14_0._curTabId, true)
		arg_14_0._tabViews[arg_14_0._curTabId]:onOpenInternal()
	else
		local var_14_0 = MultiAbLoader.New()

		arg_14_0._tabAbLoaders[arg_14_0._curTabId] = var_14_0

		local var_14_1 = arg_14_0.viewContainer:getSetting().tabRes
		local var_14_2 = var_14_1 and var_14_1[arg_14_0._tabContainerId] and var_14_1[arg_14_0._tabContainerId][arg_14_0._curTabId]

		if var_14_2 then
			UIBlockMgr.instance:startBlock(arg_14_0._UIBlockKey)
			var_14_0:setPathList(var_14_2)
			var_14_0:startLoad(arg_14_0._finishCallback, arg_14_0)
		else
			logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", arg_14_0._tabContainerId, arg_14_0._curTabId))
		end
	end
end

function var_0_0._closeTabView(arg_15_0)
	local var_15_0 = arg_15_0._curTabId and arg_15_0._tabAbLoaders[arg_15_0._curTabId]

	if var_15_0 then
		if var_15_0.isLoading then
			var_15_0:dispose()

			arg_15_0._tabAbLoaders[arg_15_0._curTabId] = nil

			UIBlockMgr.instance:endBlock(arg_15_0._UIBlockKey)
		else
			arg_15_0._tabViews[arg_15_0._curTabId]:onCloseInternal()
			arg_15_0:_setVisible(arg_15_0._curTabId, false)
		end
	end
end

function var_0_0._setVisible(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._tabCanvasGroup[arg_16_1]

	if not var_16_0 then
		local var_16_1 = arg_16_0._tabViews[arg_16_1].viewGO

		var_16_0 = gohelper.onceAddComponent(var_16_1, typeof(UnityEngine.CanvasGroup))
		arg_16_0._tabCanvasGroup[arg_16_1] = var_16_0
	end

	if arg_16_2 then
		var_16_0.alpha = 1
		var_16_0.interactable = true
		var_16_0.blocksRaycasts = true
	else
		var_16_0.alpha = 0
		var_16_0.interactable = false
		var_16_0.blocksRaycasts = false
	end
end

function var_0_0._finishCallback(arg_17_0, arg_17_1)
	UIBlockMgr.instance:endBlock(arg_17_0._UIBlockKey)

	local var_17_0 = arg_17_1:getFirstAssetItem():GetResource()
	local var_17_1 = gohelper.clone(var_17_0, arg_17_0._tabGOContainer)
	local var_17_2 = arg_17_0._tabViews[arg_17_0._curTabId]

	if var_17_2 then
		var_17_2:__onInit()

		var_17_2.rootGO = arg_17_0.viewGO
		var_17_2.viewGO = var_17_1
		var_17_2.tabContainer = arg_17_0
		var_17_2.viewContainer = arg_17_0.viewContainer
		var_17_2.viewName = arg_17_0.viewName
		var_17_2.viewParam = arg_17_0.viewParam

		arg_17_0:_setVisible(arg_17_0._curTabId, true)
		var_17_2:onInitViewInternal()
		var_17_2:addEventsInternal()
		var_17_2:onOpenInternal()

		if arg_17_0._hasOpenFinish then
			var_17_2:onOpenFinishInternal()
		end
	else
		logError(string.format("TabView not exist: tabContainerId_%d, tabId_%d", arg_17_0._tabContainerId, arg_17_0._curTabId))
	end
end

function var_0_0._hasLoaded(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._tabAbLoaders and arg_18_0._tabAbLoaders[arg_18_1]

	return var_18_0 and not var_18_0.isLoading
end

return var_0_0
