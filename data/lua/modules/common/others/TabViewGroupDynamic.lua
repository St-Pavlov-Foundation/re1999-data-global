module("modules.common.others.TabViewGroupDynamic", package.seeall)

local var_0_0 = class("TabViewGroupDynamic", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._tabContainerId = arg_1_1 or 1
	arg_1_0._tabGOContainerPath = arg_1_2
	arg_1_0._tabGOContainer = nil
	arg_1_0._tabAbLoaders = {}
	arg_1_0._tabMainRes = {}
	arg_1_0._tabCanvasGroup = {}
	arg_1_0._tabViews = nil
	arg_1_0._curTabId = nil
	arg_1_0._hasOpenFinish = false
	arg_1_0._UIBlockKey = nil
end

function var_0_0.setDynamicNodeContainers(arg_2_0, arg_2_1)
	arg_2_0._dynamicNodeContainers = arg_2_1
end

function var_0_0.setDynamicNodeResHandlers(arg_3_0, arg_3_1)
	arg_3_0._dynamicNodeResHandlers = arg_3_1
end

function var_0_0.stopOpenDefaultTab(arg_4_0, arg_4_1)
	arg_4_0._isStopOpenDefaultTab = arg_4_1
end

function var_0_0.onInitView(arg_5_0)
	arg_5_0._UIBlockKey = arg_5_0.viewName .. UIBlockKey.TabViewOpening .. arg_5_0._tabContainerId
	arg_5_0._tabGOContainer = arg_5_0.viewGO

	if not string.nilorempty(arg_5_0._tabGOContainerPath) then
		arg_5_0._tabGOContainer = gohelper.findChild(arg_5_0.viewGO, arg_5_0._tabGOContainerPath)
	end

	if not arg_5_0._tabGOContainer then
		logError(arg_5_0.viewName .. " tabGOContainer not exist: " .. arg_5_0._tabGOContainerPath)
	end

	arg_5_0._tabViews = arg_5_0.viewContainer:buildTabViews(arg_5_0._tabContainerId)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_6_0._toSwitchTab, arg_6_0)

	if arg_6_0._isStopOpenDefaultTab then
		return
	end

	local var_6_0 = arg_6_0.viewParam and type(arg_6_0.viewParam) == "table" and arg_6_0.viewParam.defaultTabIds and arg_6_0.viewParam.defaultTabIds[arg_6_0._tabContainerId] or 1

	arg_6_0:_openTabView(var_6_0)
end

function var_0_0.onOpenFinish(arg_7_0)
	if arg_7_0:_hasLoaded(arg_7_0._curTabId) then
		arg_7_0._tabViews[arg_7_0._curTabId]:onOpenFinishInternal()
	else
		arg_7_0._hasOpenFinish = true
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	if arg_8_0:_hasLoaded(arg_8_0._curTabId) then
		arg_8_0._tabViews[arg_8_0._curTabId]:onUpdateParamInternal()
	end
end

function var_0_0.onClose(arg_9_0)
	arg_9_0._hasOpenFinish = false

	arg_9_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_9_0._toSwitchTab, arg_9_0)
	arg_9_0:_closeTabView()
end

function var_0_0.onCloseFinish(arg_10_0)
	if arg_10_0:_hasLoaded(arg_10_0._curTabId) then
		arg_10_0._tabViews[arg_10_0._curTabId]:onCloseFinishInternal()
	end

	arg_10_0._curTabId = nil
end

function var_0_0.removeEvents(arg_11_0)
	if arg_11_0._tabViews then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._tabViews) do
			local var_11_0 = arg_11_0._tabAbLoaders[iter_11_0]

			if var_11_0 and not var_11_0.isLoading then
				iter_11_1:removeEventsInternal()
			end
		end
	end
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0._tabViews then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._tabViews) do
			local var_12_0 = arg_12_0._tabAbLoaders[iter_12_0]

			if var_12_0 and not var_12_0.isLoading then
				iter_12_1:onDestroyViewInternal()
				iter_12_1:__onDispose()
			end
		end
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0._tabAbLoaders) do
		iter_12_3:dispose()
	end

	arg_12_0._tabAbLoaders = nil
	arg_12_0._tabCanvasGroup = nil
	arg_12_0._tabGOContainer = nil
	arg_12_0._tabViews = nil
end

function var_0_0.getTabContainerId(arg_13_0)
	return arg_13_0._tabContainerId
end

function var_0_0.getCurTabId(arg_14_0)
	return arg_14_0._curTabId
end

function var_0_0._toSwitchTab(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == arg_15_0._tabContainerId then
		arg_15_0:_openTabView(arg_15_2)
	end
end

function var_0_0._openTabView(arg_16_0, arg_16_1)
	if arg_16_0._curTabId == arg_16_1 then
		return
	end

	arg_16_0:_closeTabView()

	arg_16_0._curTabId = arg_16_1

	if not arg_16_0._curTabId then
		return
	end

	if arg_16_0._tabAbLoaders[arg_16_0._curTabId] then
		arg_16_0:_setVisible(arg_16_0._curTabId, true)
		arg_16_0._tabViews[arg_16_0._curTabId]:onOpenInternal()
	else
		local var_16_0 = MultiAbLoader.New()

		arg_16_0._tabAbLoaders[arg_16_0._curTabId] = var_16_0

		local var_16_1 = arg_16_0.viewContainer:getSetting().tabRes
		local var_16_2 = var_16_1 and var_16_1[arg_16_0._tabContainerId] and var_16_1[arg_16_0._tabContainerId][arg_16_0._curTabId]

		arg_16_0._tabMainRes[arg_16_0._curTabId] = var_16_2[1]

		if arg_16_0._dynamicNodeResHandlers and arg_16_0._dynamicNodeResHandlers[arg_16_0._curTabId] then
			local var_16_3 = arg_16_0._dynamicNodeResHandlers[arg_16_0._curTabId]()
			local var_16_4 = {}

			tabletool.addValues(var_16_4, var_16_2)
			tabletool.addValues(var_16_4, var_16_3)

			var_16_2 = var_16_4
		end

		if var_16_2 then
			UIBlockMgr.instance:startBlock(arg_16_0._UIBlockKey)
			var_16_0:setPathList(var_16_2)
			var_16_0:startLoad(arg_16_0._finishCallback, arg_16_0)
		else
			logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", arg_16_0._tabContainerId, arg_16_0._curTabId))
		end
	end
end

function var_0_0._closeTabView(arg_17_0)
	local var_17_0 = arg_17_0._curTabId and arg_17_0._tabAbLoaders[arg_17_0._curTabId]

	if var_17_0 then
		if var_17_0.isLoading then
			var_17_0:dispose()

			arg_17_0._tabAbLoaders[arg_17_0._curTabId] = nil

			UIBlockMgr.instance:endBlock(arg_17_0._UIBlockKey)
		else
			arg_17_0._tabViews[arg_17_0._curTabId]:onCloseInternal()
			arg_17_0:_setVisible(arg_17_0._curTabId, false)
		end
	end
end

function var_0_0._setVisible(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._tabCanvasGroup[arg_18_1]

	if not var_18_0 then
		local var_18_1 = arg_18_0._tabViews[arg_18_1].viewGO

		var_18_0 = gohelper.onceAddComponent(var_18_1, typeof(UnityEngine.CanvasGroup))
		arg_18_0._tabCanvasGroup[arg_18_1] = var_18_0
	end

	if arg_18_2 then
		var_18_0.alpha = 1
		var_18_0.interactable = true
		var_18_0.blocksRaycasts = true
	else
		var_18_0.alpha = 0
		var_18_0.interactable = false
		var_18_0.blocksRaycasts = false
	end
end

function var_0_0._getTabGoContainer(arg_19_0)
	if arg_19_0._dynamicNodeContainers then
		local var_19_0 = arg_19_0._dynamicNodeContainers[arg_19_0._curTabId]

		if var_19_0 then
			return gohelper.findChild(arg_19_0.viewGO, var_19_0)
		end
	end

	return arg_19_0._tabGOContainer
end

function var_0_0._finishCallback(arg_20_0, arg_20_1)
	UIBlockMgr.instance:endBlock(arg_20_0._UIBlockKey)

	local var_20_0 = arg_20_1:getAssetItem(arg_20_0._tabMainRes[arg_20_0._curTabId]):GetResource()
	local var_20_1 = gohelper.clone(var_20_0, arg_20_0:_getTabGoContainer())
	local var_20_2 = arg_20_0._tabViews[arg_20_0._curTabId]

	if var_20_2 then
		var_20_2:__onInit()

		var_20_2.rootGO = arg_20_0.viewGO
		var_20_2.viewGO = var_20_1
		var_20_2.tabContainer = arg_20_0
		var_20_2.viewContainer = arg_20_0.viewContainer
		var_20_2.viewName = arg_20_0.viewName
		var_20_2.viewParam = arg_20_0.viewParam

		arg_20_0:_setVisible(arg_20_0._curTabId, true)
		var_20_2:onInitViewInternal()
		var_20_2:addEventsInternal()
		var_20_2:onOpenInternal()

		if arg_20_0._hasOpenFinish then
			var_20_2:onOpenFinishInternal()
		end
	else
		logError(string.format("TabView not exist: tabContainerId_%d, tabId_%d", arg_20_0._tabContainerId, arg_20_0._curTabId))
	end
end

function var_0_0._hasLoaded(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._tabAbLoaders and arg_21_0._tabAbLoaders[arg_21_1]

	return var_21_0 and not var_21_0.isLoading
end

return var_0_0
