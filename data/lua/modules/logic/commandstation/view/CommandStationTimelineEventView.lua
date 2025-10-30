module("modules.logic.commandstation.view.CommandStationTimelineEventView", package.seeall)

local var_0_0 = class("CommandStationTimelineEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goTimeAxis = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis")
	arg_1_0._goTimeAxisEvent = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/#go_TimeAxisEvent")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/#txt_Title")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/Scroll View/Viewport/#txt_Descr")
	arg_1_0._btnLeftDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/#btn_LeftDisable")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/#btn_Left")
	arg_1_0._btnRightDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/#btn_RightDisable")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_TimeAxis/#go_TimeAxisEvent/#btn_Right")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnLeftDisable:AddClickListener(arg_2_0._btnLeftDisableOnClick, arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
	arg_2_0._btnRightDisable:AddClickListener(arg_2_0._btnRightDisableOnClick, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnLeftDisable:RemoveClickListener()
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRightDisable:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
end

function var_0_0._btnLeftDisableOnClick(arg_4_0)
	return
end

function var_0_0._btnRightDisableOnClick(arg_5_0)
	return
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnLeftOnClick(arg_7_0)
	arg_7_0._curIndex = arg_7_0._curIndex - 1

	if arg_7_0._curIndex < 1 then
		arg_7_0._curIndex = #arg_7_0._eventList
	end

	arg_7_0:_FocusEvent()
	arg_7_0:_updateEventInfo()
	arg_7_0:_updateBtnState()
end

function var_0_0._btnRightOnClick(arg_8_0)
	arg_8_0._curIndex = arg_8_0._curIndex + 1

	if arg_8_0._curIndex > #arg_8_0._eventList then
		arg_8_0._curIndex = 1
	end

	arg_8_0:_FocusEvent()
	arg_8_0:_updateEventInfo()
	arg_8_0:_updateBtnState()
end

function var_0_0._FocusEvent(arg_9_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, arg_9_0._eventList[arg_9_0._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, arg_9_0._eventList[arg_9_0._curIndex])
end

function var_0_0._editableInitView(arg_10_0)
	return
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._timeId = arg_12_0.viewParam.timeId
	arg_12_0._eventId = arg_12_0.viewParam.eventId
	arg_12_0._eventList = CommandStationConfig.instance:getEventList(arg_12_0._timeId, arg_12_0._eventId)
	arg_12_0._minIndex = 1
	arg_12_0._maxIndex = #arg_12_0._eventList
	arg_12_0._curIndex = tabletool.indexOf(arg_12_0._eventList, arg_12_0._eventId)

	arg_12_0:_updateEventInfo()
	arg_12_0:_updateBtnState()
end

function var_0_0._updateBtnState(arg_13_0)
	local var_13_0 = arg_13_0._maxIndex ~= 1

	gohelper.setActive(arg_13_0._btnLeft.gameObject, var_13_0)
	gohelper.setActive(arg_13_0._btnRight.gameObject, var_13_0)
	gohelper.setActive(arg_13_0._btnLeftDisable.gameObject, false)
	gohelper.setActive(arg_13_0._btnRightDisable.gameObject, false)
end

function var_0_0._updateEventInfo(arg_14_0)
	local var_14_0 = arg_14_0._eventList[arg_14_0._curIndex]
	local var_14_1 = lua_copost_event.configDict[var_14_0]

	if not var_14_1 then
		return
	end

	local var_14_2 = tonumber(var_14_1.eventTextId)
	local var_14_3 = var_14_2 and lua_copost_event_text.configDict[var_14_2]

	arg_14_0._txtDescr.text = var_14_3 and var_14_3.text
	arg_14_0._txtTitle.text = var_14_1.eventTitleId
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
