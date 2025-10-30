module("modules.logic.commandstation.view.CommandStationDispatchEventMainView", package.seeall)

local var_0_0 = class("CommandStationDispatchEventMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gochild = gohelper.findChild(arg_1_0.viewGO, "#go_child")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Left")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Right")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:checkClose()
end

function var_0_0.checkClose(arg_5_0)
	if arg_5_0._curTabViewId == CommandStationEnum.DispatchTabView.Process and not CommandStationModel.instance:getDispatchEventInfo(arg_5_0._curEventConfig.id) then
		arg_5_0:_openTabView(CommandStationEnum.DispatchTabView.Normal)

		return
	end

	arg_5_0:closeThis()
end

function var_0_0._btnLeftOnClick(arg_6_0)
	arg_6_0._toLeft = true
	arg_6_0._curIndex = arg_6_0._curIndex - 1

	if arg_6_0._curIndex < 1 then
		arg_6_0._curIndex = #arg_6_0._eventList
	end

	arg_6_0:_updateEventInfo()

	arg_6_0._toLeft = nil

	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, arg_6_0._eventList[arg_6_0._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, arg_6_0._eventList[arg_6_0._curIndex])
end

function var_0_0._btnRightOnClick(arg_7_0)
	arg_7_0._toLeft = false
	arg_7_0._curIndex = arg_7_0._curIndex + 1

	if arg_7_0._curIndex > #arg_7_0._eventList then
		arg_7_0._curIndex = 1
	end

	arg_7_0:_updateEventInfo()

	arg_7_0._toLeft = nil

	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, arg_7_0._eventList[arg_7_0._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, arg_7_0._eventList[arg_7_0._curIndex])
end

function var_0_0._updateBtnState(arg_8_0)
	if arg_8_0._curTabViewId == CommandStationEnum.DispatchTabView.Process and CommandStationModel.instance:getDispatchEventState(arg_8_0._curEventConfig.id) == CommandStationEnum.DispatchState.NotStart then
		gohelper.setActive(arg_8_0._btnLeft, false)
		gohelper.setActive(arg_8_0._btnRight, false)

		return
	end

	gohelper.setActive(arg_8_0._btnLeft.gameObject, arg_8_0._maxIndex ~= 1)
	gohelper.setActive(arg_8_0._btnRight.gameObject, arg_8_0._maxIndex ~= 1)
end

function var_0_0._updateEventInfo(arg_9_0)
	local var_9_0 = arg_9_0._eventList[arg_9_0._curIndex]
	local var_9_1 = lua_copost_event.configDict[var_9_0]

	if not var_9_1 then
		logError("CommandStationDispatchEventMainView _updateEventInfo eventConfig is nil")

		return
	end

	arg_9_0._curEventConfig = var_9_1

	local var_9_2 = arg_9_0:_getTabId(var_9_0)

	arg_9_0:_openTabView(var_9_2)

	arg_9_0.viewParam.defaultTabIds[2] = var_9_2
end

function var_0_0._getTabId(arg_10_0, arg_10_1)
	local var_10_0 = CommandStationModel.instance:getDispatchEventInfo(arg_10_1)

	if not var_10_0 then
		return CommandStationEnum.DispatchTabView.Normal
	end

	if not var_10_0:hasGetReward() then
		return CommandStationEnum.DispatchTabView.Process
	end

	return CommandStationEnum.DispatchTabView.Normal
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0:addEventCb(CommandStationController.instance, CommandStationEvent.ClickDispatch, arg_11_0._onClickDispatch, arg_11_0)
	arg_11_0:addEventCb(CommandStationController.instance, CommandStationEvent.DispatchFinish, arg_11_0._onDispatchFinish, arg_11_0)
	arg_11_0:addEventCb(CommandStationController.instance, CommandStationEvent.DispatchStart, arg_11_0._onDispatchStart, arg_11_0)
end

function var_0_0._onClickDispatch(arg_12_0)
	arg_12_0:_openTabView(CommandStationEnum.DispatchTabView.Process)
end

function var_0_0._onDispatchFinish(arg_13_0)
	arg_13_0:_openTabView(CommandStationEnum.DispatchTabView.Normal)
end

function var_0_0._onDispatchStart(arg_14_0)
	arg_14_0:_updateBtnState()
end

function var_0_0._openTabView(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._curTabViewId and arg_15_0._curTabViewId ~= arg_15_1

	arg_15_0.viewContainer:switchTab(arg_15_1, arg_15_0._curEventConfig)

	arg_15_0._curTabViewId = arg_15_1

	CommandStationController.instance:dispatchEvent(CommandStationEvent.DispatchChangeTab, var_15_0, arg_15_0._toLeft)
	arg_15_0:_updateBtnState()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0._timeId = arg_16_0.viewParam.timeId

	local var_16_0 = arg_16_0.viewParam.eventId

	arg_16_0.viewParam.defaultTabIds = {}
	arg_16_0._eventList = CommandStationConfig.instance:getEventList(arg_16_0._timeId, var_16_0)
	arg_16_0._minIndex = 1
	arg_16_0._maxIndex = #arg_16_0._eventList
	arg_16_0._curIndex = tabletool.indexOf(arg_16_0._eventList, var_16_0)

	arg_16_0:_updateEventInfo()
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
