module("modules.logic.popup.controller.PopupController", package.seeall)

local var_0_0 = class("PopupController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._popupList = PriorityQueue.New(function(arg_2_0, arg_2_1)
		return arg_2_0[1] > arg_2_1[1]
	end)
	arg_1_0._locked = nil
	arg_1_0._curPopup = nil
	arg_1_0._addEvents = nil
	arg_1_0._subPriorityDict = {}
	arg_1_0._pauseDict = {}
end

function var_0_0.reInit(arg_3_0)
	arg_3_0._popupHistory = {}
	arg_3_0._popupList = PriorityQueue.New(function(arg_4_0, arg_4_1)
		return arg_4_0[1] > arg_4_1[1]
	end)
	arg_3_0._locked = nil
	arg_3_0._curPopup = nil
	arg_3_0._addEvents = nil
	arg_3_0._subPriorityDict = {}
	arg_3_0._pauseDict = {}
end

function var_0_0.clear(arg_5_0)
	arg_5_0:reInit()
end

function var_0_0.onInitFinish(arg_6_0)
	return
end

function var_0_0.addConstEvents(arg_7_0)
	return
end

function var_0_0._getSubPriority(arg_8_0, arg_8_1)
	local var_8_0 = 0
	local var_8_1 = 1e-05

	arg_8_0._subPriorityDict[arg_8_1] = (arg_8_0._subPriorityDict[arg_8_1] or 0) - var_8_1

	return arg_8_1 + arg_8_0._subPriorityDict[arg_8_1]
end

function var_0_0._resetSubPriority(arg_9_0)
	arg_9_0._subPriorityDict = {}
end

function var_0_0._onCloseViewFinish(arg_10_0, arg_10_1)
	if arg_10_0._curPopup and arg_10_1 == arg_10_0._curPopup[2] then
		arg_10_0:_checkViewCloseGC(arg_10_1)
		arg_10_0:_endPopupView()
	end
end

function var_0_0.addPopupView(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:_getSubPriority(arg_11_1)

	arg_11_0._popupList:add({
		var_11_0,
		arg_11_2,
		arg_11_3
	})
	arg_11_0:_tryShowView()
end

function var_0_0._tryShowView(arg_12_0)
	if not arg_12_0._locked then
		UIBlockMgr.instance:startBlock("PopupController")
		TaskDispatcher.cancelTask(arg_12_0._showPopupView, arg_12_0)
		TaskDispatcher.runDelay(arg_12_0._showPopupView, arg_12_0, 0.1)
	end

	if SLFramework.FrameworkSettings.IsEditor then
		ViewMgr.instance:closeView(ViewName.GMToolView)
	end
end

function var_0_0._showPopupView(arg_13_0)
	UIBlockMgr.instance:endBlock("PopupController")

	if arg_13_0:isPause() then
		return
	end

	if arg_13_0._locked or arg_13_0._popupList:getSize() == 0 then
		if arg_13_0._popupList:getSize() == 0 then
			arg_13_0:_resetSubPriority()
		end

		return
	end

	arg_13_0._locked = true
	arg_13_0._curPopup = arg_13_0._popupList:getFirstAndRemove()

	local var_13_0 = arg_13_0._curPopup[2]
	local var_13_1 = arg_13_0._curPopup[3]

	if var_13_0 == ViewName.MessageBoxView then
		if type(var_13_1.extra) == "table" then
			GameFacade.showMessageBox(var_13_1.messageBoxId, var_13_1.msgBoxType, var_13_1.yesCallback, var_13_1.noCallback, var_13_1.openCallback, var_13_1.yesCallbackObj, var_13_1.noCallbackObj, var_13_1.openCallbackObj, unpack(var_13_1.extra))
		else
			GameFacade.showMessageBox(var_13_1.messageBoxId, var_13_1.msgBoxType, var_13_1.yesCallback, var_13_1.noCallback, var_13_1.openCallback, var_13_1.yesCallbackObj, var_13_1.noCallbackObj, var_13_1.openCallbackObj)
		end
	else
		ViewMgr.instance:openView(var_13_0, var_13_1)
	end

	if not arg_13_0._addEvents then
		arg_13_0._addEvents = true

		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_13_0._onCloseViewFinish, arg_13_0)
	end
end

function var_0_0._endPopupView(arg_14_0)
	arg_14_0._locked = false

	if arg_14_0._addEvents then
		arg_14_0._addEvents = nil

		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_14_0._onCloseViewFinish, arg_14_0)
	end

	arg_14_0:_showPopupView()
end

function var_0_0._checkViewCloseGC(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._popupHistory and #arg_15_0._popupHistory or 0

	if var_15_0 >= 2 and arg_15_1 == arg_15_0._popupHistory[var_15_0] then
		arg_15_0._popupHistory = {}

		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.1, arg_15_0)
	else
		arg_15_0._popupHistory = arg_15_0._popupHistory or {}

		table.insert(arg_15_0._popupHistory, arg_15_1)
	end
end

function var_0_0.setPause(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 then
		arg_16_0._pauseDict[arg_16_1] = true
	else
		arg_16_0._pauseDict[arg_16_1] = nil
	end

	if not arg_16_0:isPause() then
		arg_16_0:_tryShowView()
	end
end

function var_0_0.isPause(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._pauseDict) do
		if iter_17_1 then
			return true
		end
	end

	return false
end

function var_0_0.getPopupCount(arg_18_0)
	return (arg_18_0._popupList:getSize())
end

function var_0_0.havePopupView(arg_19_0, arg_19_1)
	if not arg_19_0._popupList or arg_19_0._popupList:getSize() <= 0 then
		return false
	end

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._popupList._dataList) do
		if iter_19_1[2] == arg_19_1 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
