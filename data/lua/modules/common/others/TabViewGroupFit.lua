module("modules.common.others.TabViewGroupFit", package.seeall)

local var_0_0 = class("TabViewGroupFit", BaseView)

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
	arg_2_0._rawGetRes = arg_2_0.viewContainer.getRes
	arg_2_0._rawGetResInst = arg_2_0.viewContainer.getResInst

	arg_2_0:_setHook()
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_3_0._toSwitchTab, arg_3_0)

	local var_3_0 = arg_3_0.viewParam and type(arg_3_0.viewParam) == "table" and arg_3_0.viewParam.defaultTabIds and arg_3_0.viewParam.defaultTabIds[arg_3_0._tabContainerId] or 1

	arg_3_0:_openTabView(var_3_0)
end

function var_0_0.onOpenFinish(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._tabViews) do
		local var_4_0 = arg_4_0._tabAbLoaders[iter_4_0]

		if var_4_0 and var_4_0.isTabLoadFinished then
			iter_4_1:onOpenFinishInternal()
		end
	end

	arg_4_0._hasOpenFinish = true
end

function var_0_0.onUpdateParam(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._tabViews) do
		local var_5_0 = arg_5_0._tabAbLoaders[iter_5_0]

		if var_5_0 and var_5_0.isTabLoadFinished then
			iter_5_1:onUpdateParamInternal()
		end
	end
end

function var_0_0.onClose(arg_6_0)
	arg_6_0._hasOpenFinish = false

	arg_6_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_6_0._toSwitchTab, arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0._tabViews) do
		arg_6_0:_closeTabView(iter_6_0)
	end
end

function var_0_0.onCloseFinish(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._tabViews) do
		local var_7_0 = arg_7_0._tabAbLoaders[iter_7_0]

		if var_7_0 and var_7_0.isTabLoadFinished then
			iter_7_1:onCloseFinishInternal()
		end
	end

	arg_7_0._curTabId = nil
end

function var_0_0.removeEvents(arg_8_0)
	if arg_8_0._tabViews then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._tabViews) do
			local var_8_0 = arg_8_0._tabAbLoaders[iter_8_0]

			if var_8_0 and var_8_0.isTabLoadFinished then
				iter_8_1:removeEventsInternal()
			end
		end
	end
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0:_resetHook()

	if arg_9_0._tabViews then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._tabViews) do
			local var_9_0 = arg_9_0._tabAbLoaders[iter_9_0]

			if var_9_0 and var_9_0.isTabLoadFinished then
				iter_9_1:onDestroyViewInternal()
				iter_9_1:__onDispose()
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

function var_0_0._toSwitchTab(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == arg_12_0._tabContainerId then
		arg_12_0:_openTabView(arg_12_2)
	end
end

function var_0_0._openTabView(arg_13_0, arg_13_1)
	arg_13_0:_switchCloseTabView(arg_13_0._curTabId)

	arg_13_0._curTabId = arg_13_1

	ViewMgr.instance:dispatchEvent(ViewEvent.BeforeOpenTabView, {
		tabGroupView = arg_13_0,
		viewName = arg_13_0.viewName,
		tabView = arg_13_0._tabViews[arg_13_0._curTabId]
	})

	local var_13_0 = arg_13_0._tabAbLoaders[arg_13_0._curTabId]

	if var_13_0 then
		if not var_13_0.isTabLoadFinished then
			return
		end

		arg_13_0:_setVisible(arg_13_0._curTabId, true)

		local var_13_1 = arg_13_0._tabViews[arg_13_0._curTabId]

		if var_13_1.onTabSwitchOpen then
			var_13_1:onTabSwitchOpen()
		end

		if arg_13_0._tabOpenFinishCallback then
			arg_13_0._tabOpenFinishCallback(arg_13_0._tabOpenFinishCallbackObj, arg_13_0._curTabId, var_13_1, false)
		end
	else
		local var_13_2 = MultiAbLoader.New()

		arg_13_0._tabAbLoaders[arg_13_0._curTabId] = var_13_2

		local var_13_3 = arg_13_0.viewContainer:getSetting().tabRes
		local var_13_4 = var_13_3 and var_13_3[arg_13_0._tabContainerId] and var_13_3[arg_13_0._tabContainerId][arg_13_0._curTabId]

		if var_13_4 then
			UIBlockMgr.instance:startBlock(arg_13_0._UIBlockKey)
			var_13_2:setPathList(var_13_4)
			var_13_2:startLoad(arg_13_0._finishCallback, arg_13_0)
		else
			logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", arg_13_0._tabContainerId, arg_13_0._curTabId))
		end
	end
end

function var_0_0._switchCloseTabView(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 and arg_14_0._tabAbLoaders[arg_14_1]

	if var_14_0 then
		if var_14_0.isLoading then
			var_14_0:dispose()

			arg_14_0._tabAbLoaders[arg_14_1] = nil

			UIBlockMgr.instance:endBlock(arg_14_0._UIBlockKey)
		elseif var_14_0.isTabLoadFinished then
			local var_14_1 = arg_14_0._tabViews[arg_14_1]

			if var_14_1.onTabSwitchClose then
				var_14_1:onTabSwitchClose()
			end

			arg_14_0:_setVisible(arg_14_1, false)

			if arg_14_0._tabCloseFinishCallback then
				arg_14_0._tabCloseFinishCallback(arg_14_0._tabCloseFinishCallbackObj, arg_14_1, var_14_1)
			end
		end
	end
end

function var_0_0._closeTabView(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 and arg_15_0._tabAbLoaders[arg_15_1]

	if var_15_0 then
		if var_15_0.isLoading then
			var_15_0:dispose()

			arg_15_0._tabAbLoaders[arg_15_1] = nil

			UIBlockMgr.instance:endBlock(arg_15_0._UIBlockKey)
		elseif var_15_0.isTabLoadFinished then
			local var_15_1 = arg_15_0._tabViews[arg_15_1]

			if var_15_1.onTabSwitchClose then
				var_15_1:onTabSwitchClose(true)
			end

			var_15_1:onCloseInternal()

			if arg_15_0._keepCloseVisible then
				return
			end

			arg_15_0:_setVisible(arg_15_1, false)
		end
	end
end

function var_0_0._setVisible(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0._tabCanvasGroup then
		return
	end

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

function var_0_0.setTabCloseFinishCallback(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._tabCloseFinishCallback = arg_17_1
	arg_17_0._tabCloseFinishCallbackObj = arg_17_2
end

function var_0_0.setTabOpenFinishCallback(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._tabOpenFinishCallback = arg_18_1
	arg_18_0._tabOpenFinishCallbackObj = arg_18_2
end

function var_0_0.setTabAlpha(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_0._tabCanvasGroup then
		return
	end

	local var_19_0 = arg_19_0._tabCanvasGroup[arg_19_1]

	if not var_19_0 then
		local var_19_1 = arg_19_0._tabViews[arg_19_1].viewGO

		if not var_19_1 then
			return
		end

		var_19_0 = gohelper.onceAddComponent(var_19_1, typeof(UnityEngine.CanvasGroup))
		arg_19_0._tabCanvasGroup[arg_19_1] = var_19_0
	end

	if var_19_0 then
		var_19_0.alpha = arg_19_2
	end
end

function var_0_0.keepCloseVisible(arg_20_0, arg_20_1)
	arg_20_0._keepCloseVisible = arg_20_1
end

function var_0_0._setHook(arg_21_0)
	function arg_21_0.viewContainer.getRes(arg_22_0, arg_22_1)
		local var_22_0 = arg_21_0:_getRes(arg_22_1)

		if var_22_0 then
			return var_22_0
		end

		return arg_21_0._rawGetRes(arg_22_0, arg_22_1)
	end

	function arg_21_0.viewContainer.getResInst(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
		local var_23_0 = arg_21_0:_getResInst(arg_23_1, arg_23_2, arg_23_3)

		if var_23_0 then
			return var_23_0
		end

		return arg_21_0._rawGetResInst(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	end
end

function var_0_0._resetHook(arg_24_0)
	arg_24_0.viewContainer.getRes = arg_24_0._rawGetRes
	arg_24_0.viewContainer.getResInst = arg_24_0._rawGetResInst
	arg_24_0._rawGetRes = nil
	arg_24_0._rawGetResInst = nil
end

function var_0_0._getRes(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._tabAbLoaders) do
		if iter_25_1.isTabLoadFinished then
			local var_25_0 = iter_25_1:getAssetItem(arg_25_1)

			if var_25_0 then
				return var_25_0:GetResource(arg_25_1)
			end
		end
	end

	return nil
end

function var_0_0._getResInst(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	for iter_26_0, iter_26_1 in pairs(arg_26_0._tabAbLoaders) do
		if iter_26_1.isTabLoadFinished then
			local var_26_0 = iter_26_1:getAssetItem(arg_26_1)

			if var_26_0 then
				local var_26_1 = var_26_0:GetResource(arg_26_1)

				if var_26_1 then
					return gohelper.clone(var_26_1, arg_26_2, arg_26_3)
				end
			end
		end
	end
end

function var_0_0._finishCallback(arg_27_0, arg_27_1)
	UIBlockMgr.instance:endBlock(arg_27_0._UIBlockKey)

	local var_27_0 = arg_27_1:getFirstAssetItem():GetResource()
	local var_27_1 = gohelper.clone(var_27_0, arg_27_0._tabGOContainer)
	local var_27_2 = arg_27_0._tabViews[arg_27_0._curTabId]

	if var_27_2 then
		arg_27_1.isTabLoadFinished = true

		var_27_2:__onInit()

		var_27_2.rootGO = arg_27_0.viewGO
		var_27_2.viewGO = var_27_1
		var_27_2.tabContainer = arg_27_0
		var_27_2.viewContainer = arg_27_0.viewContainer
		var_27_2.viewName = arg_27_0.viewName
		var_27_2.viewParam = arg_27_0.viewParam

		arg_27_0:_setVisible(arg_27_0._curTabId, true)
		var_27_2:onInitViewInternal()
		var_27_2:addEventsInternal()
		var_27_2:onOpenInternal()

		if var_27_2.onTabSwitchOpen then
			var_27_2:onTabSwitchOpen()
		end

		if arg_27_0._hasOpenFinish then
			var_27_2:onOpenFinishInternal()
		end

		if arg_27_0._tabOpenFinishCallback then
			arg_27_0._tabOpenFinishCallback(arg_27_0._tabOpenFinishCallbackObj, arg_27_0._curTabId, var_27_2, true)
		end
	else
		logError(string.format("TabView not exist: tabContainerId_%d, tabId_%d", arg_27_0._tabContainerId, arg_27_0._curTabId))
	end
end

function var_0_0._hasLoaded(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._tabAbLoaders and arg_28_0._tabAbLoaders[arg_28_1]

	return var_28_0 and var_28_0.isTabLoadFinished
end

return var_0_0
