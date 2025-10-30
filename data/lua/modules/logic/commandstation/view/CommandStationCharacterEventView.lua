module("modules.logic.commandstation.view.CommandStationCharacterEventView", package.seeall)

local var_0_0 = class("CommandStationCharacterEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goCharacterEvent = gohelper.findChild(arg_1_0.viewGO, "#go_CharacterEvent")
	arg_1_0._goCharacterEventPanel = gohelper.findChild(arg_1_0.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#txt_Name")
	arg_1_0._txtTime = gohelper.findChildText(arg_1_0.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#txt_Time")
	arg_1_0._btnopentimeline = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_opentimeline")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/Scroll View/Viewport/#txt_Descr")
	arg_1_0._btnLeftDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_LeftDisable")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_Left")
	arg_1_0._btnRightDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_RightDisable")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_Right")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnopentimeline:AddClickListener(arg_2_0._btnopentimelineOnClick, arg_2_0)
	arg_2_0._btnLeftDisable:AddClickListener(arg_2_0._btnLeftDisableOnClick, arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
	arg_2_0._btnRightDisable:AddClickListener(arg_2_0._btnRightDisableOnClick, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnopentimeline:RemoveClickListener()
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

function var_0_0._btnopentimelineOnClick(arg_6_0)
	if arg_6_0._isOpenTimeline then
		return
	end

	arg_6_0._isOpenTimeline = not arg_6_0._isOpenTimeline

	arg_6_0:_moveTimeline(arg_6_0._isOpenTimeline and {
		node = arg_6_0.viewGO,
		leftopNode = arg_6_0._golefttop
	} or nil)
	CommandStationController.StatCommandStationButtonClick(arg_6_0.viewName, string.format("btnopentimelineOnClick_%s", arg_6_0._curCharacterId))
end

function var_0_0._moveTimeline(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 ~= nil

	if var_7_0 then
		CommandStationMapModel.instance:setCharacterId(arg_7_0._curCharacterId)
	else
		CommandStationMapModel.instance:setCharacterId(nil)
	end

	CommandStationMapModel.instance:setTimelineCharacterMode(var_7_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveTimeline, arg_7_1)
	gohelper.setActive(arg_7_0._btnclose, var_7_0)
	arg_7_0:_updateBtnState()
end

function var_0_0.checkClose(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_9_0)
	arg_9_0:checkClose()
end

function var_0_0._btnLeftOnClick(arg_10_0)
	arg_10_0._curIndex = arg_10_0._curIndex - 1

	if arg_10_0._curIndex < 1 then
		arg_10_0._curIndex = #arg_10_0._eventList
	end

	arg_10_0:_updateBtnState()
	arg_10_0:_FocusEvent()
	arg_10_0:_showSwitchAnim(true)
end

function var_0_0._btnRightOnClick(arg_11_0)
	arg_11_0._curIndex = arg_11_0._curIndex + 1

	if arg_11_0._curIndex > #arg_11_0._eventList then
		arg_11_0._curIndex = 1
	end

	arg_11_0:_updateBtnState()
	arg_11_0:_FocusEvent()
	arg_11_0:_showSwitchAnim(false)
end

function var_0_0._editableInitView(arg_12_0)
	gohelper.setActive(arg_12_0._btnclose, false)

	arg_12_0._isOpenTimeline = false
	arg_12_0._animator = arg_12_0.viewGO:GetComponent("Animator")
end

function var_0_0._showSwitchAnim(arg_13_0, arg_13_1)
	arg_13_0._animator.enabled = true

	arg_13_0._animator:Play(arg_13_1 and "switchleft" or "switchright", 0, 0)
	TaskDispatcher.cancelTask(arg_13_0._afterSwitchUpdateEventInfo, arg_13_0)
	TaskDispatcher.runDelay(arg_13_0._afterSwitchUpdateEventInfo, arg_13_0, 0.167)
end

function var_0_0._afterSwitchUpdateEventInfo(arg_14_0)
	arg_14_0:_updateEventInfo()
end

function var_0_0.onUpdateParam(arg_15_0)
	if arg_15_0._eventList[arg_15_0._curIndex] == arg_15_0.viewParam.eventId then
		return
	end

	arg_15_0._animator.enabled = true

	arg_15_0._animator:Play("switchtime", 0, 0)
	TaskDispatcher.cancelTask(arg_15_0._showEvent, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._showEvent, arg_15_0, 0.167)
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:_showEvent()
	arg_16_0:addEventCb(CommandStationController.instance, CommandStationEvent.SelectTimePoint, arg_16_0._onSelectTimePoint, arg_16_0)
	arg_16_0:addEventCb(CommandStationController.instance, CommandStationEvent.EventCreateFinish, arg_16_0._onEventCreateFinish, arg_16_0)
end

function var_0_0._onEventCreateFinish(arg_17_0)
	return
end

function var_0_0._onSelectTimePoint(arg_18_0, arg_18_1)
	arg_18_0._timeId = arg_18_1
	arg_18_0._eventList = CommandStationConfig.instance:getCharacterEventList(arg_18_0._timeId)

	local var_18_0 = false

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._eventList) do
		if CommandStationConfig.instance:getCharacterIdByEventId(iter_18_1) == arg_18_0._curCharacterId then
			arg_18_0._eventId = iter_18_1
			var_18_0 = true

			break
		end
	end

	if not var_18_0 then
		logError(string.format("CommandStationCharacterEventView _onSelectTimePoint not match timeId:%d, characterId:%d, eventId:%d", arg_18_0._timeId, arg_18_0._curCharacterId, arg_18_0._eventId))
	end

	arg_18_0:_initEventData()
	arg_18_0:_FocusEvent()
end

function var_0_0._showEvent(arg_19_0)
	arg_19_0._timeId = arg_19_0.viewParam.timeId
	arg_19_0._eventId = arg_19_0.viewParam.eventId
	arg_19_0._eventList = CommandStationConfig.instance:getCharacterEventList(arg_19_0._timeId)

	arg_19_0:_initEventData()
end

function var_0_0._initEventData(arg_20_0)
	arg_20_0._minIndex = 1
	arg_20_0._maxIndex = #arg_20_0._eventList
	arg_20_0._curIndex = tabletool.indexOf(arg_20_0._eventList, arg_20_0._eventId)

	arg_20_0:_updateEventInfo()
	arg_20_0:_updateBtnState()
end

function var_0_0._updateBtnState(arg_21_0)
	local var_21_0 = CommandStationMapModel.instance:isTimelineCharacterMode()
	local var_21_1 = arg_21_0._maxIndex ~= 1 and not var_21_0

	gohelper.setActive(arg_21_0._btnLeft.gameObject, var_21_1)
	gohelper.setActive(arg_21_0._btnRight.gameObject, var_21_1)
	gohelper.setActive(arg_21_0._btnLeftDisable.gameObject, false)
	gohelper.setActive(arg_21_0._btnRightDisable.gameObject, false)
end

function var_0_0._FocusEvent(arg_22_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, arg_22_0._eventList[arg_22_0._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, arg_22_0._eventList[arg_22_0._curIndex])
end

function var_0_0._updateEventInfo(arg_23_0)
	local var_23_0 = arg_23_0._eventList[arg_23_0._curIndex]
	local var_23_1 = lua_copost_character_event.configDict[var_23_0]

	if not var_23_1 then
		return
	end

	local var_23_2 = tonumber(var_23_1.eventTextId)
	local var_23_3 = var_23_2 and lua_copost_event_text.configDict[var_23_2]

	arg_23_0._txtDescr.text = var_23_3 and var_23_3.text

	local var_23_4 = var_23_1.chaId

	arg_23_0._curCharacterId = var_23_4

	local var_23_5 = lua_copost_character.configDict[var_23_4]

	arg_23_0._txtName.text = var_23_5.chaName

	local var_23_6 = CommandStationConfig.instance:getTimeGroupByCharacterEventId(var_23_0)

	if var_23_6 then
		local var_23_7 = lua_copost_time_point.configDict[var_23_6.id]

		arg_23_0._txtTime.text = var_23_7 and var_23_7.time
	end

	local var_23_8 = var_23_1.chaId

	arg_23_0._singleImage = arg_23_0._singleImage or gohelper.findChildSingleImage(arg_23_0.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/Head/image_Icon")

	local var_23_9 = lua_copost_character.configDict[var_23_8]

	if var_23_9 then
		arg_23_0._singleImage:LoadImage(ResUrl.getHeadIconSmall(var_23_9.chaPicture), arg_23_0._singleImageLoadCallback, arg_23_0)
	end
end

function var_0_0._singleImageLoadCallback(arg_24_0)
	arg_24_0._singleImage:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function var_0_0.onClose(arg_25_0)
	CommandStationMapModel.instance:setCharacterId(nil)
	CommandStationMapModel.instance:setTimelineCharacterMode(nil)
	arg_25_0:_moveTimeline()
	TaskDispatcher.cancelTask(arg_25_0._afterSwitchUpdateEventInfo, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._showEvent, arg_25_0)
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

return var_0_0
