module("framework.mvc.view.BaseViewContainer", package.seeall)

local var_0_0 = class("BaseViewContainer", UserDataDispose)

var_0_0.Status_None = 0
var_0_0.Status_ResLoading = 1
var_0_0.Status_Opening = 2
var_0_0.Status_Open = 3
var_0_0.Status_Closing = 4
var_0_0.Status_Close = 5
var_0_0.Stage_onOpen = 1
var_0_0.Stage_onOpenFinish = 2
var_0_0.Stage_onClose = 3
var_0_0.Stage_onCloseFinish = 4
var_0_0.ViewLoadingCount = 0
var_0_0.CloseTypeManual = 1

function var_0_0.ctor(arg_1_0)
	LuaEventSystem.addEventMechanism(arg_1_0)

	arg_1_0._views = nil
	arg_1_0._tabViews = nil
	arg_1_0._viewSetting = nil
	arg_1_0._isOpenImmediate = false
	arg_1_0._isCloseImmediate = false
	arg_1_0._viewStatus = var_0_0.Status_None
	arg_1_0._isVisible = true
	arg_1_0._abLoader = nil
	arg_1_0._canvasGroup = nil
	arg_1_0.viewName = nil
	arg_1_0.viewParam = nil
	arg_1_0.viewGO = nil
	arg_1_0._closeType = nil
end

function var_0_0.setCloseType(arg_2_0, arg_2_1)
	arg_2_0._closeType = arg_2_1
end

function var_0_0.isManualClose(arg_3_0)
	return arg_3_0._closeType == var_0_0.CloseTypeManual
end

function var_0_0.setSetting(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.viewName = arg_4_1
	arg_4_0._viewSetting = arg_4_2
end

function var_0_0.getSetting(arg_5_0)
	return arg_5_0._viewSetting
end

function var_0_0.openInternal(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.viewParam = arg_6_1
	arg_6_0._isOpenImmediate = arg_6_2

	if arg_6_0._viewStatus == var_0_0.Status_ResLoading or arg_6_0._viewStatus == var_0_0.Status_Opening or arg_6_0._viewStatus == var_0_0.Status_Open then
		return
	end

	ViewMgr.instance:dispatchEvent(ViewEvent.BeforeOpenView, arg_6_0.viewName, arg_6_0.viewParam)

	if not arg_6_0._abLoader then
		arg_6_0:_setVisible(true)

		arg_6_0._viewStatus = var_0_0.Status_ResLoading

		arg_6_0:_loadViewRes()

		return
	end

	if arg_6_0._viewStatus == var_0_0.Status_Closing then
		arg_6_0:onPlayCloseTransitionFinish()
	end

	arg_6_0:_setVisible(true)
	arg_6_0:_reallyOpen()
end

function var_0_0.closeInternal(arg_7_0, arg_7_1)
	arg_7_0._isCloseImmediate = arg_7_1

	if arg_7_0._viewStatus == var_0_0.Status_ResLoading then
		if arg_7_0._abLoader then
			arg_7_0._abLoader:dispose()

			arg_7_0._abLoader = nil
			var_0_0.ViewLoadingCount = var_0_0.ViewLoadingCount - 1

			if var_0_0.ViewLoadingCount <= 0 then
				UIBlockMgr.instance:endBlock(UIBlockKey.ViewOpening)
			end
		end

		arg_7_0._viewStatus = var_0_0.Status_None
	elseif arg_7_0._viewStatus == var_0_0.Status_Closing then
		if arg_7_1 then
			arg_7_0:onPlayCloseTransitionFinish()
		end
	elseif arg_7_0._viewStatus == var_0_0.Status_Opening then
		arg_7_0:onPlayOpenTransitionFinish()
		arg_7_0:_reallyClose()
	elseif arg_7_0._viewStatus == var_0_0.Status_Open then
		arg_7_0:_reallyClose()
	end
end

function var_0_0.setVisibleInternal(arg_8_0, arg_8_1)
	arg_8_0:_setVisible(arg_8_1)
end

function var_0_0.onUpdateParamInternal(arg_9_0, arg_9_1)
	arg_9_0:_setVisible(true)

	arg_9_0.viewParam = arg_9_1

	if arg_9_0._views then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._views) do
			iter_9_1.viewParam = arg_9_1

			iter_9_1:onUpdateParamInternal()
		end
	end

	arg_9_0:onContainerUpdateParam()
end

function var_0_0.onClickModalMaskInternal(arg_10_0)
	if arg_10_0._views then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._views) do
			iter_10_1:onClickModalMaskInternal()
		end
	end

	arg_10_0:onContainerClickModalMask()
end

function var_0_0.isOpen(arg_11_0)
	return arg_11_0:isOpening() or arg_11_0:isOpenFinish()
end

function var_0_0.isOpening(arg_12_0)
	return arg_12_0._viewStatus == var_0_0.Status_ResLoading or arg_12_0._viewStatus == var_0_0.Status_Opening
end

function var_0_0.isOpenFinish(arg_13_0)
	return arg_13_0._viewStatus == var_0_0.Status_Open
end

function var_0_0.isClosing(arg_14_0)
	return arg_14_0._viewStatus == var_0_0.Status_Closing
end

function var_0_0.destroyView(arg_15_0)
	if arg_15_0._views then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._views) do
			iter_15_1:removeEventsInternal()
			iter_15_1:onDestroyViewInternal()
			iter_15_1:tryCallMethodName("__onDispose")
		end
	end

	if arg_15_0.viewGO then
		gohelper.destroy(arg_15_0.viewGO)

		arg_15_0.viewGO = nil
	end

	if arg_15_0._abLoader then
		arg_15_0._abLoader:dispose()

		arg_15_0._abLoader = nil
	end

	arg_15_0:onContainerDestroy()
end

function var_0_0.closeThis(arg_16_0)
	ViewMgr.instance:closeView(arg_16_0.viewName)
end

function var_0_0.getRes(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._abLoader:getAssetItem(arg_17_1)

	if var_17_0 then
		return var_17_0:GetResource(arg_17_1)
	end

	return nil
end

function var_0_0.getResInst(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0._abLoader:getAssetItem(arg_18_1)

	if var_18_0 then
		local var_18_1 = var_18_0:GetResource(arg_18_1)

		if var_18_1 then
			return gohelper.clone(var_18_1, arg_18_2, arg_18_3)
		else
			logError(arg_18_0.__cname .. " prefab not exist: " .. arg_18_1)
		end
	else
		logError(arg_18_0.__cname .. " resource not load: " .. arg_18_1)
	end

	return nil
end

function var_0_0._loadViewRes(arg_19_0)
	local var_19_0 = arg_19_0._viewSetting.mainRes
	local var_19_1 = arg_19_0._viewSetting.otherRes
	local var_19_2 = {
		var_19_0
	}

	if var_19_1 then
		for iter_19_0, iter_19_1 in pairs(var_19_1) do
			table.insert(var_19_2, iter_19_1)
		end
	end

	local var_19_3 = arg_19_0._viewSetting.preloader and arg_19_0._viewSetting.preloader[arg_19_0.viewName] or nil

	if var_19_3 then
		var_19_3(var_19_2)
	end

	if arg_19_0.viewParam and type(arg_19_0.viewParam) == "table" and arg_19_0.viewParam.defaultTabIds and arg_19_0._viewSetting.tabRes then
		for iter_19_2, iter_19_3 in ipairs(arg_19_0.viewParam.defaultTabIds) do
			local var_19_4 = arg_19_0._viewSetting.tabRes[iter_19_2]
			local var_19_5 = var_19_4 and var_19_4[iter_19_3]

			if var_19_5 then
				for iter_19_4, iter_19_5 in pairs(var_19_5) do
					table.insert(var_19_2, iter_19_5)
				end
			end
		end
	end

	if not string.nilorempty(arg_19_0._viewSetting.anim) and string.find(arg_19_0._viewSetting.anim, ".controller") then
		table.insert(var_19_2, arg_19_0._viewSetting.anim)
	end

	var_0_0.ViewLoadingCount = var_0_0.ViewLoadingCount + 1

	UIBlockMgr.instance:startBlock(UIBlockKey.ViewOpening)

	arg_19_0._abLoader = MultiAbLoader.New()

	arg_19_0._abLoader:setPathList(var_19_2)
	arg_19_0._abLoader:startLoad(arg_19_0._onResLoadFinish, arg_19_0)
end

function var_0_0._onResLoadFinish(arg_20_0, arg_20_1)
	local var_20_0 = ViewMgr.instance:getUILayer(arg_20_0._viewSetting.layer)
	local var_20_1 = arg_20_0._abLoader:getAssetItem(arg_20_0._viewSetting.mainRes):GetResource(arg_20_0._viewSetting.mainRes)

	arg_20_0.viewGO = gohelper.clone(var_20_1, var_20_0, arg_20_0.viewName)
	arg_20_0._views = arg_20_0:buildViews()

	if arg_20_0._views then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._views) do
			if isTypeOf(iter_20_1, TabViewGroup) then
				arg_20_0._tabViews = arg_20_0._tabViews or {}
				arg_20_0._tabViews[iter_20_1:getTabContainerId()] = iter_20_1
			end

			iter_20_1:tryCallMethodName("__onInit")

			iter_20_1.viewGO = arg_20_0.viewGO
			iter_20_1.viewContainer = arg_20_0
			iter_20_1.viewName = arg_20_0.viewName

			iter_20_1:onInitViewInternal()
			iter_20_1:addEventsInternal()
		end
	end

	arg_20_0:onContainerInit()

	var_0_0.ViewLoadingCount = var_0_0.ViewLoadingCount - 1

	if var_0_0.ViewLoadingCount <= 0 then
		UIBlockMgr.instance:endBlock(UIBlockKey.ViewOpening)
	end

	arg_20_0:_reallyOpen()
end

function var_0_0._setVisible(arg_21_0, arg_21_1)
	arg_21_0._isVisible = arg_21_1

	if not arg_21_0.viewGO then
		return
	end

	if not arg_21_0._canvasGroup then
		arg_21_0._canvasGroup = gohelper.onceAddComponent(arg_21_0.viewGO, typeof(UnityEngine.CanvasGroup))
	end

	if arg_21_1 then
		arg_21_0._canvasGroup.alpha = 1
		arg_21_0._canvasGroup.interactable = true
		arg_21_0._canvasGroup.blocksRaycasts = true

		recthelper.setAnchorX(arg_21_0.viewGO.transform, 0)
	else
		arg_21_0._canvasGroup.alpha = 0
		arg_21_0._canvasGroup.interactable = false
		arg_21_0._canvasGroup.blocksRaycasts = false

		recthelper.setAnchorX(arg_21_0.viewGO.transform, 10000)
	end
end

function var_0_0._reallyOpen(arg_22_0)
	arg_22_0.viewGO.transform:SetAsLastSibling()
	arg_22_0:_setVisible(arg_22_0._isVisible)

	arg_22_0._viewStatus = var_0_0.Status_Opening

	arg_22_0:_onViewStage(var_0_0.Stage_onOpen)

	if arg_22_0._viewStatus ~= var_0_0.Status_Opening then
		if isDebugBuild then
			logError(arg_22_0.viewName .. " status change while opening " .. arg_22_0._viewStatus)
		end

		return
	end

	if arg_22_0._isOpenImmediate then
		arg_22_0:onPlayOpenTransitionFinish()
	else
		arg_22_0:playOpenTransition()
	end
end

function var_0_0._reallyClose(arg_23_0)
	arg_23_0._viewStatus = var_0_0.Status_Closing

	arg_23_0:_onViewStage(var_0_0.Stage_onClose)

	if arg_23_0._viewStatus ~= var_0_0.Status_Closing then
		if isDebugBuild then
			logError(arg_23_0.viewName .. " status change while closing " .. arg_23_0._viewStatus)
		end

		return
	end

	if arg_23_0._isCloseImmediate then
		arg_23_0:onPlayCloseTransitionFinish()
	else
		arg_23_0:playCloseTransition()
	end
end

function var_0_0._onViewStage(arg_24_0, arg_24_1)
	if arg_24_0._views then
		for iter_24_0, iter_24_1 in ipairs(arg_24_0._views) do
			if arg_24_1 == var_0_0.Stage_onOpen then
				iter_24_1.viewParam = arg_24_0.viewParam

				iter_24_1:onOpenInternal()
			elseif arg_24_1 == var_0_0.Stage_onOpenFinish then
				iter_24_1:onOpenFinishInternal()
			elseif arg_24_1 == var_0_0.Stage_onClose then
				iter_24_1:onCloseInternal()
			elseif arg_24_1 == var_0_0.Stage_onCloseFinish then
				iter_24_1:onCloseFinishInternal()
			end
		end
	end

	if arg_24_1 == var_0_0.Stage_onOpen then
		ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenView, arg_24_0.viewName, arg_24_0.viewParam)

		if arg_24_0._viewSetting.viewType == ViewType.Full then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenFullView, arg_24_0.viewName, arg_24_0.viewParam)
		elseif arg_24_0._viewSetting.viewType == ViewType.Modal then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenModalView, arg_24_0.viewName, arg_24_0.viewParam)
		end

		arg_24_0:onContainerOpen()
	elseif arg_24_1 == var_0_0.Stage_onOpenFinish then
		ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenViewFinish, arg_24_0.viewName, arg_24_0.viewParam)

		if arg_24_0._viewSetting.viewType == ViewType.Full then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenFullViewFinish, arg_24_0.viewName, arg_24_0.viewParam)
		elseif arg_24_0._viewSetting.viewType == ViewType.Modal then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnOpenModalViewFinish, arg_24_0.viewName, arg_24_0.viewParam)
		end

		arg_24_0:onContainerOpenFinish()
	elseif arg_24_1 == var_0_0.Stage_onClose then
		ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseView, arg_24_0.viewName, arg_24_0.viewParam)

		if arg_24_0._viewSetting.viewType == ViewType.Full then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseFullView, arg_24_0.viewName, arg_24_0.viewParam)
		elseif arg_24_0._viewSetting.viewType == ViewType.Modal then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseModalView, arg_24_0.viewName, arg_24_0.viewParam)
		end

		arg_24_0:onContainerClose()
	elseif arg_24_1 == var_0_0.Stage_onCloseFinish then
		ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseViewFinish, arg_24_0.viewName, arg_24_0.viewParam)

		if arg_24_0._viewSetting.viewType == ViewType.Full then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseFullViewFinish, arg_24_0.viewName, arg_24_0.viewParam)
		elseif arg_24_0._viewSetting.viewType == ViewType.Modal then
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseModalViewFinish, arg_24_0.viewName, arg_24_0.viewParam)
		end

		arg_24_0:onContainerCloseFinish()
	end
end

function var_0_0.getTabContainer(arg_25_0, arg_25_1)
	return arg_25_0._tabViews and arg_25_0._tabViews[arg_25_1]
end

function var_0_0.isHasTryCallFail(arg_26_0)
	if arg_26_0._views then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0._views) do
			if iter_26_1:isHasTryCallFail() then
				return true
			end
		end
	end

	return false
end

function var_0_0.playOpenTransition(arg_27_0)
	arg_27_0:onPlayOpenTransitionFinish()
end

function var_0_0.onPlayOpenTransitionFinish(arg_28_0)
	arg_28_0._viewStatus = var_0_0.Status_Open

	arg_28_0:_onViewStage(var_0_0.Stage_onOpenFinish)
end

function var_0_0.playCloseTransition(arg_29_0)
	arg_29_0:onPlayCloseTransitionFinish()
end

function var_0_0.onPlayCloseTransitionFinish(arg_30_0)
	arg_30_0:_setVisible(false)

	arg_30_0._viewStatus = var_0_0.Status_Close

	arg_30_0:_onViewStage(var_0_0.Stage_onCloseFinish)
	arg_30_0:setCloseType(nil)
end

function var_0_0.onAndroidBack(arg_31_0)
	return
end

function var_0_0.buildViews(arg_32_0)
	return
end

function var_0_0.buildTabViews(arg_33_0, arg_33_1)
	return
end

function var_0_0.onContainerInit(arg_34_0)
	return
end

function var_0_0.onContainerDestroy(arg_35_0)
	return
end

function var_0_0.onContainerOpen(arg_36_0)
	return
end

function var_0_0.onContainerOpenFinish(arg_37_0)
	return
end

function var_0_0.onContainerClose(arg_38_0)
	return
end

function var_0_0.onContainerCloseFinish(arg_39_0)
	return
end

function var_0_0.onContainerUpdateParam(arg_40_0)
	return
end

function var_0_0.onContainerClickModalMask(arg_41_0)
	return
end

return var_0_0
