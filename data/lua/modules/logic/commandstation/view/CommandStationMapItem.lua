module("modules.logic.commandstation.view.CommandStationMapItem", package.seeall)

local var_0_0 = class("CommandStationMapItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goTime = gohelper.findChild(arg_1_0.viewGO, "#go_Time")
	arg_1_0._goHighLight4 = gohelper.findChild(arg_1_0.viewGO, "#go_Time/#go_HighLight4")
	arg_1_0._goImportant = gohelper.findChild(arg_1_0.viewGO, "#go_Time/#go_Important")
	arg_1_0._txtEvent = gohelper.findChildText(arg_1_0.viewGO, "#go_Time/#txt_Event")
	arg_1_0._goExpand4 = gohelper.findChild(arg_1_0.viewGO, "#go_Time/#go_Expand4")
	arg_1_0._btnclicktime = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Time/#btn_click_time")
	arg_1_0._goDispatch = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch")
	arg_1_0._goHighLight3 = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_HighLight3")
	arg_1_0._going = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_ing")
	arg_1_0._goExpand3 = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_Expand3")
	arg_1_0._goFinish = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_Finish")
	arg_1_0._goRedPoint = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_Finish/#go_RedPoint")
	arg_1_0._goGet = gohelper.findChild(arg_1_0.viewGO, "#go_Dispatch/#go_Get")
	arg_1_0._btnclickdispatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Dispatch/#btn_click_dispatch")
	arg_1_0._goOutside = gohelper.findChild(arg_1_0.viewGO, "#go_Outside")
	arg_1_0._goHighLight1 = gohelper.findChild(arg_1_0.viewGO, "#go_Outside/#go_HighLight1")
	arg_1_0._goIcon1 = gohelper.findChild(arg_1_0.viewGO, "#go_Outside/#go_Icon1")
	arg_1_0._goIcon2 = gohelper.findChild(arg_1_0.viewGO, "#go_Outside/#go_Icon2")
	arg_1_0._goExpand1 = gohelper.findChild(arg_1_0.viewGO, "#go_Outside/#go_Expand1")
	arg_1_0._btnclickoutside = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Outside/#btn_click_outside")
	arg_1_0._goCharacter = gohelper.findChild(arg_1_0.viewGO, "#go_Character")
	arg_1_0._goHighLight2 = gohelper.findChild(arg_1_0.viewGO, "#go_Character/#go_HighLight2")
	arg_1_0._goExpand2 = gohelper.findChild(arg_1_0.viewGO, "#go_Character/#go_Expand2")
	arg_1_0._btnclickcharacter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Character/#btn_click_character")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclicktime:AddClickListener(arg_2_0._btnclicktimeOnClick, arg_2_0)
	arg_2_0._btnclickdispatch:AddClickListener(arg_2_0._btnclickdispatchOnClick, arg_2_0)
	arg_2_0._btnclickoutside:AddClickListener(arg_2_0._btnclickoutsideOnClick, arg_2_0)
	arg_2_0._btnclickcharacter:AddClickListener(arg_2_0._btnclickcharacterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclicktime:RemoveClickListener()
	arg_3_0._btnclickdispatch:RemoveClickListener()
	arg_3_0._btnclickoutside:RemoveClickListener()
	arg_3_0._btnclickcharacter:RemoveClickListener()
end

function var_0_0._btnclicktimeOnClick(arg_4_0)
	arg_4_0:_btnclickOnClick()
end

function var_0_0._btnclickdispatchOnClick(arg_5_0)
	arg_5_0:_btnclickOnClick()
end

function var_0_0._btnclickoutsideOnClick(arg_6_0)
	arg_6_0:_btnclickOnClick()
end

function var_0_0._btnclickcharacterOnClick(arg_7_0)
	arg_7_0:_btnclickOnClick()
end

function var_0_0._btnclickOnClick(arg_8_0)
	if not arg_8_0._eventConfig or arg_8_0._isClose then
		return
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, arg_8_0._eventId)

	local var_8_0 = CommandStationMapModel.instance:getTimeId()
	local var_8_1 = {
		eventId = arg_8_0._eventId,
		timeId = var_8_0
	}

	if arg_8_0._category == CommandStationEnum.EventCategory.Normal then
		if arg_8_0._eventTypeIsTime or arg_8_0._eventTypeIsNormal then
			CommandStationController.instance:openCommandStationTimelineEventView(var_8_1)
		elseif arg_8_0._eventTypeIsDialogue then
			CommandStationController.instance:openCommandStationDialogueEventView(var_8_1)
		elseif arg_8_0._eventTypeIsDispatch then
			CommandStationController.instance:openCommandStationDispatchEventMainView(var_8_1)
		end
	elseif arg_8_0._characterCategory then
		CommandStationController.instance:openCommandStationCharacterEventView(var_8_1)
	end

	arg_8_0:FocusEvent()
	CommandStationController.StatCommandStationButtonClick("CommandStationMapItem", string.format("btnclickOnClick_%s_%s", var_8_0, arg_8_0._eventId))
end

function var_0_0.FirstFocusEvent(arg_9_0)
	local var_9_0 = true

	if ViewMgr.instance:isOpen(ViewName.CommandStationCharacterEventView) then
		var_9_0 = false
	end

	if not gohelper.isNil(arg_9_0._sceneNodeGo) then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.SceneFocusPos, arg_9_0:_getLocalPos(), var_9_0)
	end
end

function var_0_0.FocusEvent(arg_10_0)
	if not gohelper.isNil(arg_10_0._sceneNodeGo) then
		CommandStationController.instance:dispatchEvent(CommandStationEvent.SceneFocusPos, arg_10_0:_getLocalPos())
	end
end

function var_0_0._getLocalPos(arg_11_0)
	local var_11_0 = arg_11_0._sceneNodeGo.transform.localPosition

	if arg_11_0._eventTypeIsDispatch or arg_11_0._characterCategory then
		var_11_0.x = var_11_0.x + 1
	end

	return var_11_0
end

function var_0_0.playCloseAnim(arg_12_0)
	if arg_12_0._isClose then
		return
	end

	arg_12_0._isClose = true

	TaskDispatcher.runDelay(arg_12_0._ensureClose, arg_12_0, 0.2)
	arg_12_0._animatorPlayer:Play("close", arg_12_0._closeAnimDone, arg_12_0)
end

function var_0_0._ensureClose(arg_13_0)
	arg_13_0:_closeAnimDone()
end

function var_0_0._closeAnimDone(arg_14_0)
	gohelper.destroy(arg_14_0.viewGO)
end

function var_0_0._commonAnimDone(arg_15_0)
	return
end

function var_0_0._editableInitView(arg_16_0)
	arg_16_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_16_0.viewGO)
	arg_16_0._animator = arg_16_0.viewGO:GetComponent("Animator")

	gohelper.setActive(arg_16_0._goTime, false)
	gohelper.setActive(arg_16_0._goOutside, false)
	gohelper.setActive(arg_16_0._goDispatch, false)
	gohelper.setActive(arg_16_0._goCharacter, false)

	for iter_16_0 = 1, 4 do
		gohelper.setActive(arg_16_0["_goHighLight" .. iter_16_0], false)
		gohelper.setActive(arg_16_0["_goExpand" .. iter_16_0], false)
	end

	arg_16_0._statusInfo = {
		[CommandStationEnum.EventType.Main] = 4,
		[CommandStationEnum.EventType.Dispatch] = 3,
		[CommandStationEnum.EventType.Normal] = 1,
		[CommandStationEnum.EventType.Dialogue] = 1
	}
	arg_16_0._characterStatus = 2

	arg_16_0:addEventCb(CommandStationController.instance, CommandStationEvent.SelectedEvent, arg_16_0._onSelectedEvent, arg_16_0)
	arg_16_0:addEventCb(CommandStationController.instance, CommandStationEvent.CancelSelectedEvent, arg_16_0._onCancelSelectedEvent, arg_16_0)
end

function var_0_0._onCancelSelectedEvent(arg_17_0)
	if arg_17_0._selectedSameType == false then
		arg_17_0:_updateSelectedTypeState(true)
	end

	if arg_17_0._isSelected then
		arg_17_0:FirstFocusEvent()
	end

	arg_17_0:_setSelected(false)
end

function var_0_0._onSelectedEvent(arg_18_0, arg_18_1)
	local var_18_0

	if arg_18_0._category == CommandStationEnum.EventCategory.Normal then
		var_18_0 = lua_copost_event.configDict[arg_18_1]
	elseif arg_18_0._category == CommandStationEnum.EventCategory.Character then
		var_18_0 = lua_copost_character_event.configDict[arg_18_1]
	end

	arg_18_0._selectedSameType = var_18_0 and var_18_0.eventType == arg_18_0._eventConfig.eventType

	if not arg_18_0._selectedSameType then
		arg_18_0:_updateSelectedTypeState(false)
	end

	arg_18_0:_setSelected(arg_18_1 == arg_18_0._eventId)
end

function var_0_0._updateSelectedTypeState(arg_19_0, arg_19_1)
	if arg_19_0._isClose then
		return
	end

	arg_19_0._animator.enabled = true

	if arg_19_1 then
		arg_19_0._animator:Play("open")
	else
		arg_19_0._animator:Play("close")
	end
end

function var_0_0._setSelected(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._characterCategory and arg_20_0._characterStatus or arg_20_0._statusInfo[arg_20_0._eventConfig.eventType]

	arg_20_0:_setSelectedByIndex(var_20_0, arg_20_1)
end

function var_0_0._setSelectedByIndex(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_2 and not arg_21_0._eventIsRead then
		CommandStationRpc.instance:sendCommandPostEventReadRequest(arg_21_0._eventId)

		arg_21_0._eventIsRead = true
	end

	if not arg_21_0._isClose then
		if arg_21_2 then
			arg_21_0._animatorPlayer:Play("tobig", arg_21_0._commonAnimDone, arg_21_0)
		elseif arg_21_0._isSelected then
			arg_21_0._animatorPlayer:Play("backbig", arg_21_0._commonAnimDone, arg_21_0)
		end
	end

	gohelper.setActive(arg_21_0["_goHighLight" .. arg_21_1], not arg_21_0._eventIsRead)
	gohelper.setActive(arg_21_0["_goExpand" .. arg_21_1], arg_21_2)

	arg_21_0._isSelected = arg_21_2
end

function var_0_0._editableAddEvents(arg_22_0)
	arg_22_0:addEventCb(CommandStationController.instance, CommandStationEvent.DispatchFinish, arg_22_0._onDispatchFinish, arg_22_0)
	arg_22_0:addEventCb(CommandStationController.instance, CommandStationEvent.DispatchStart, arg_22_0._onDispatchStart, arg_22_0)
end

function var_0_0._editableRemoveEvents(arg_23_0)
	return
end

function var_0_0.onUpdateMO(arg_24_0, arg_24_1, arg_24_2)
	TaskDispatcher.cancelTask(arg_24_0._refreshDispatchEventView, arg_24_0)

	arg_24_0._category = arg_24_2
	arg_24_0._eventId = arg_24_1
	arg_24_0._eventIsRead = CommandStationModel.instance:isEventRead(arg_24_0._eventId)

	if arg_24_0._category == CommandStationEnum.EventCategory.Normal then
		arg_24_0._eventConfig = lua_copost_event.configDict[arg_24_0._eventId]
	elseif arg_24_0._category == CommandStationEnum.EventCategory.Character then
		arg_24_0._characterCategory = true
		arg_24_0._eventConfig = lua_copost_character_event.configDict[arg_24_0._eventId]
	end

	if not arg_24_0._eventConfig then
		logError(string.format("CommandStationMapItem event config not found, eventId: %d, category: %d", arg_24_0._eventId, arg_24_0._category))

		return
	end

	arg_24_0:_setSelected(false)
	arg_24_0:_setPos()

	if arg_24_0._characterCategory then
		arg_24_0:_showCharacterEvent()

		return
	end

	arg_24_0:_showNormalEvent()
end

function var_0_0._setPos(arg_25_0)
	if arg_25_0._uiFollower then
		return
	end

	arg_25_0._uiFollower = gohelper.onceAddComponent(arg_25_0.viewGO, typeof(ZProj.UIFollower))

	local var_25_0 = string.format("%s_%s_%s", arg_25_0._category, arg_25_0._eventId, arg_25_0._eventConfig.eventType)
	local var_25_1 = CommandStationMapModel.instance:getSceneNode(var_25_0)

	arg_25_0.viewGO.name = var_25_0

	local var_25_2 = arg_25_0._eventConfig.eventCoordinate
	local var_25_3 = var_25_2[1] or 0
	local var_25_4 = var_25_2[2] or 0

	transformhelper.setLocalPos(var_25_1.transform, var_25_3, var_25_4, 0)

	local var_25_5 = CameraMgr.instance:getMainCamera()
	local var_25_6 = CameraMgr.instance:getUICamera()
	local var_25_7 = ViewMgr.instance:getUIRoot().transform

	arg_25_0._uiFollower:Set(var_25_5, var_25_6, var_25_7, var_25_1.transform, 0, 0, 0, 0, 0)
	arg_25_0._uiFollower:SetEnable(true)
	arg_25_0._uiFollower:ForceUpdate()

	arg_25_0._sceneNodeGo = var_25_1
end

function var_0_0._showCharacterEvent(arg_26_0)
	local var_26_0 = arg_26_0._eventConfig.chaId

	arg_26_0._singleImage = gohelper.findChildSingleImage(arg_26_0._goCharacter, "image_Icon")

	local var_26_1 = lua_copost_character.configDict[var_26_0]

	if var_26_1 then
		arg_26_0._singleImage:LoadImage(ResUrl.getHeadIconSmall(var_26_1.chaPicture))
	end

	gohelper.setActive(arg_26_0._goCharacter, true)
end

function var_0_0.isMainType(arg_27_0)
	return arg_27_0._eventConfig.eventType == CommandStationEnum.EventType.Main
end

function var_0_0._showNormalEvent(arg_28_0)
	arg_28_0._eventTypeIsTime = arg_28_0:isMainType()
	arg_28_0._eventTypeIsNormal = arg_28_0._eventConfig.eventType == CommandStationEnum.EventType.Normal
	arg_28_0._eventTypeIsDialogue = arg_28_0._eventConfig.eventType == CommandStationEnum.EventType.Dialogue
	arg_28_0._eventTypeIsDispatch = arg_28_0._eventConfig.eventType == CommandStationEnum.EventType.Dispatch

	gohelper.setActive(arg_28_0._goTime, arg_28_0._eventTypeIsTime)
	gohelper.setActive(arg_28_0._goOutside, arg_28_0._eventTypeIsDialogue or arg_28_0._eventTypeIsNormal)
	gohelper.setActive(arg_28_0._goDispatch, arg_28_0._eventTypeIsDispatch)

	if arg_28_0._eventTypeIsDialogue or arg_28_0._eventTypeIsNormal then
		arg_28_0:_updateDialogueEventView()

		return
	end

	if arg_28_0._eventTypeIsDispatch then
		arg_28_0:_updateDispatchEventView()

		return
	end
end

function var_0_0._updateDialogueEventView(arg_29_0)
	gohelper.setActive(arg_29_0._goIcon1, arg_29_0._eventTypeIsNormal)
	gohelper.setActive(arg_29_0._goIcon2, arg_29_0._eventTypeIsDialogue)
end

function var_0_0._updateDispatchEventView(arg_30_0)
	local var_30_0 = CommandStationModel.instance:getDispatchEventState(arg_30_0._eventId)
	local var_30_1 = var_30_0 == CommandStationEnum.DispatchState.InProgress
	local var_30_2 = var_30_0 == CommandStationEnum.DispatchState.Completed
	local var_30_3 = var_30_0 == CommandStationEnum.DispatchState.GetReward

	gohelper.setActive(arg_30_0._goFinish, var_30_2)
	gohelper.setActive(arg_30_0._going, var_30_1)
	gohelper.setActive(arg_30_0._goGet, var_30_3)
	TaskDispatcher.cancelTask(arg_30_0._refreshDispatchEventView, arg_30_0)

	if var_30_1 then
		TaskDispatcher.runRepeat(arg_30_0._refreshDispatchEventView, arg_30_0, 1)
	end
end

function var_0_0._refreshDispatchEventView(arg_31_0)
	local var_31_0 = CommandStationModel.instance:getDispatchEventState(arg_31_0._eventId)
	local var_31_1 = var_31_0 == CommandStationEnum.DispatchState.InProgress
	local var_31_2 = var_31_0 == CommandStationEnum.DispatchState.Completed

	gohelper.setActive(arg_31_0._goFinish, var_31_2)
	gohelper.setActive(arg_31_0._going, var_31_1)

	if var_31_2 then
		TaskDispatcher.cancelTask(arg_31_0._refreshDispatchEventView, arg_31_0)
	end
end

function var_0_0._onDispatchFinish(arg_32_0)
	if arg_32_0._eventTypeIsDispatch then
		arg_32_0:_updateDispatchEventView()
	end
end

function var_0_0._onDispatchStart(arg_33_0)
	if arg_33_0._eventTypeIsDispatch then
		arg_33_0:_updateDispatchEventView()
	end
end

function var_0_0.onSelect(arg_34_0, arg_34_1)
	return
end

function var_0_0.onDestroyView(arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._ensureClose, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._refreshDispatchEventView, arg_35_0)
	gohelper.destroy(arg_35_0._sceneNodeGo)
end

return var_0_0
