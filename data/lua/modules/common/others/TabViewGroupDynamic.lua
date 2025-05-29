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

function var_0_0.destoryTab(arg_12_0, arg_12_1)
	if arg_12_0._tabViews then
		local var_12_0 = arg_12_0._tabAbLoaders[arg_12_1]

		if var_12_0 then
			if not var_12_0.isLoading then
				local var_12_1 = arg_12_0._tabViews[arg_12_1]

				if var_12_1 then
					local var_12_2 = var_12_1.viewGO

					var_12_1:removeEventsInternal()
					var_12_1:onDestroyViewInternal()
					var_12_1:__onDispose()
					gohelper.destroy(var_12_2)
				end
			end

			var_12_0:dispose()

			arg_12_0._tabAbLoaders[arg_12_1] = nil
		end
	end
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0._tabViews then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._tabViews) do
			local var_13_0 = arg_13_0._tabAbLoaders[iter_13_0]

			if var_13_0 and not var_13_0.isLoading then
				iter_13_1:onDestroyViewInternal()
				iter_13_1:__onDispose()
			end
		end
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0._tabAbLoaders) do
		iter_13_3:dispose()
	end

	arg_13_0._tabAbLoaders = nil
	arg_13_0._tabCanvasGroup = nil
	arg_13_0._tabGOContainer = nil
	arg_13_0._tabViews = nil
end

function var_0_0.getTabContainerId(arg_14_0)
	return arg_14_0._tabContainerId
end

function var_0_0.getCurTabId(arg_15_0)
	return arg_15_0._curTabId
end

function var_0_0._toSwitchTab(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == arg_16_0._tabContainerId then
		arg_16_0:_openTabView(arg_16_2)
	end
end

function var_0_0._openTabView(arg_17_0, arg_17_1)
	if arg_17_0._curTabId == arg_17_1 then
		return
	end

	arg_17_0:_closeTabView()

	arg_17_0._curTabId = arg_17_1

	if not arg_17_0._curTabId then
		return
	end

	if arg_17_0._tabAbLoaders[arg_17_0._curTabId] then
		arg_17_0:_setVisible(arg_17_0._curTabId, true)
		arg_17_0._tabViews[arg_17_0._curTabId]:onOpenInternal()
	else
		local var_17_0 = MultiAbLoader.New()

		arg_17_0._tabAbLoaders[arg_17_0._curTabId] = var_17_0

		local var_17_1 = arg_17_0.viewContainer:getSetting().tabRes
		local var_17_2 = var_17_1 and var_17_1[arg_17_0._tabContainerId] and var_17_1[arg_17_0._tabContainerId][arg_17_0._curTabId]

		arg_17_0._tabMainRes[arg_17_0._curTabId] = var_17_2[1]

		if arg_17_0._dynamicNodeResHandlers and arg_17_0._dynamicNodeResHandlers[arg_17_0._curTabId] then
			local var_17_3 = arg_17_0._dynamicNodeResHandlers[arg_17_0._curTabId]()
			local var_17_4 = {}

			tabletool.addValues(var_17_4, var_17_2)
			tabletool.addValues(var_17_4, var_17_3)

			var_17_2 = var_17_4
		end

		if var_17_2 then
			UIBlockMgr.instance:startBlock(arg_17_0._UIBlockKey)
			var_17_0:setPathList(var_17_2)
			var_17_0:startLoad(arg_17_0._finishCallback, arg_17_0)
		else
			logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", arg_17_0._tabContainerId, arg_17_0._curTabId))
		end
	end
end

function var_0_0._closeTabView(arg_18_0)
	local var_18_0 = arg_18_0._curTabId and arg_18_0._tabAbLoaders[arg_18_0._curTabId]

	if var_18_0 then
		if var_18_0.isLoading then
			var_18_0:dispose()

			arg_18_0._tabAbLoaders[arg_18_0._curTabId] = nil

			UIBlockMgr.instance:endBlock(arg_18_0._UIBlockKey)
		else
			arg_18_0._tabViews[arg_18_0._curTabId]:onCloseInternal()
			arg_18_0:_setVisible(arg_18_0._curTabId, false)
		end
	end
end

function var_0_0._setVisible(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._tabCanvasGroup[arg_19_1]

	if not var_19_0 then
		local var_19_1 = arg_19_0._tabViews[arg_19_1].viewGO

		var_19_0 = gohelper.onceAddComponent(var_19_1, typeof(UnityEngine.CanvasGroup))
		arg_19_0._tabCanvasGroup[arg_19_1] = var_19_0
	end

	if arg_19_2 then
		var_19_0.alpha = 1
		var_19_0.interactable = true
		var_19_0.blocksRaycasts = true
	else
		var_19_0.alpha = 0
		var_19_0.interactable = false
		var_19_0.blocksRaycasts = false
	end
end

function var_0_0._getTabGoContainer(arg_20_0)
	if arg_20_0._dynamicNodeContainers then
		local var_20_0 = arg_20_0._dynamicNodeContainers[arg_20_0._curTabId]

		if var_20_0 then
			return gohelper.findChild(arg_20_0.viewGO, var_20_0)
		end
	end

	return arg_20_0._tabGOContainer
end

function var_0_0._finishCallback(arg_21_0, arg_21_1)
	UIBlockMgr.instance:endBlock(arg_21_0._UIBlockKey)

	local var_21_0 = arg_21_1:getAssetItem(arg_21_0._tabMainRes[arg_21_0._curTabId]):GetResource()
	local var_21_1 = gohelper.clone(var_21_0, arg_21_0:_getTabGoContainer())
	local var_21_2 = arg_21_0._tabViews[arg_21_0._curTabId]

	if var_21_2 then
		var_21_2:__onInit()

		var_21_2.rootGO = arg_21_0.viewGO
		var_21_2.viewGO = var_21_1
		var_21_2.tabContainer = arg_21_0
		var_21_2.viewContainer = arg_21_0.viewContainer
		var_21_2.viewName = arg_21_0.viewName
		var_21_2.viewParam = arg_21_0.viewParam

		arg_21_0:_setVisible(arg_21_0._curTabId, true)
		var_21_2:onInitViewInternal()
		var_21_2:addEventsInternal()
		var_21_2:onOpenInternal()

		if arg_21_0._hasOpenFinish then
			var_21_2:onOpenFinishInternal()
		end
	else
		logError(string.format("TabView not exist: tabContainerId_%d, tabId_%d", arg_21_0._tabContainerId, arg_21_0._curTabId))
	end
end

function var_0_0._hasLoaded(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._tabAbLoaders and arg_22_0._tabAbLoaders[arg_22_1]

	return var_22_0 and not var_22_0.isLoading
end

return var_0_0
