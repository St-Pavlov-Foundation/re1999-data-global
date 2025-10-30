module("modules.logic.commandstation.view.CommandStationDialogueEventView", package.seeall)

local var_0_0 = class("CommandStationDialogueEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goOutsideEvent = gohelper.findChild(arg_1_0.viewGO, "root/#go_OutsideEvent")
	arg_1_0._btndialogue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_OutsideEvent/#btn_dialogue")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "root/#go_OutsideEvent/#txt_Title")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "root/#go_OutsideEvent/Scroll View/Viewport/#txt_Descr")
	arg_1_0._btnPrevDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_OutsideEvent/#btn_PrevDisable")
	arg_1_0._btnPrev = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_OutsideEvent/#btn_Prev")
	arg_1_0._btnNextDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_OutsideEvent/#btn_NextDisable")
	arg_1_0._btnNext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_OutsideEvent/#btn_Next")
	arg_1_0._goOutsideEventPanel = gohelper.findChild(arg_1_0.viewGO, "root/#go_OutsideEventPanel")
	arg_1_0._txtTitle2 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_OutsideEventPanel/#txt_Title2")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "root/#go_OutsideEventPanel/Scroll View/Viewport/#go_content")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_OutsideEventPanel/Scroll View/Viewport/#go_content/#go_Item")
	arg_1_0._btnLeftDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_OutsideEventPanel/#btn_LeftDisable")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_OutsideEventPanel/#btn_Left")
	arg_1_0._btnRightDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_OutsideEventPanel/#btn_RightDisable")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_OutsideEventPanel/#btn_Right")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btndialogue:AddClickListener(arg_2_0._btndialogueOnClick, arg_2_0)
	arg_2_0._btnPrevDisable:AddClickListener(arg_2_0._btnPrevDisableOnClick, arg_2_0)
	arg_2_0._btnPrev:AddClickListener(arg_2_0._btnPrevOnClick, arg_2_0)
	arg_2_0._btnNextDisable:AddClickListener(arg_2_0._btnNextDisableOnClick, arg_2_0)
	arg_2_0._btnNext:AddClickListener(arg_2_0._btnNextOnClick, arg_2_0)
	arg_2_0._btnLeftDisable:AddClickListener(arg_2_0._btnLeftDisableOnClick, arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
	arg_2_0._btnRightDisable:AddClickListener(arg_2_0._btnRightDisableOnClick, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btndialogue:RemoveClickListener()
	arg_3_0._btnPrevDisable:RemoveClickListener()
	arg_3_0._btnPrev:RemoveClickListener()
	arg_3_0._btnNextDisable:RemoveClickListener()
	arg_3_0._btnNext:RemoveClickListener()
	arg_3_0._btnLeftDisable:RemoveClickListener()
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRightDisable:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
end

function var_0_0._btnPrevDisableOnClick(arg_4_0)
	return
end

function var_0_0._btnNextDisableOnClick(arg_5_0)
	return
end

function var_0_0._btnLeftDisableOnClick(arg_6_0)
	return
end

function var_0_0._btnRightDisableOnClick(arg_7_0)
	return
end

function var_0_0._btndialogueOnClick(arg_8_0)
	if arg_8_0._clickTime and Time.time - arg_8_0._clickTime < 0.5 then
		return
	end

	arg_8_0._clickTime = Time.time
	arg_8_0._dialogueCurIndex = arg_8_0._dialogueCurIndex + 1

	arg_8_0:_switch(arg_8_0._outSideEventAnimator, arg_8_0._updateDialogue)
end

function var_0_0._switch(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._switchCallback = arg_9_2

	arg_9_1:Play("switch", 0, 0)
	arg_9_0:_startDelayUpdateDialogue()
end

function var_0_0._startDelayUpdateDialogue(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayUpdateDialogue, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0._delayUpdateDialogue, arg_10_0, 0.167)
end

function var_0_0._FocusEvent(arg_11_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, arg_11_0._eventList[arg_11_0._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, arg_11_0._eventList[arg_11_0._curIndex])
end

function var_0_0._delayUpdateDialogue(arg_12_0)
	arg_12_0._switchCallback(arg_12_0)
end

function var_0_0._btncloseOnClick(arg_13_0)
	if arg_13_0._isShowDialogue then
		arg_13_0:_btndialogueOnClick()

		return
	end

	arg_13_0:closeThis()
end

function var_0_0._btnPrevOnClick(arg_14_0)
	arg_14_0._curIndex = arg_14_0._curIndex - 1

	if arg_14_0._curIndex < 1 then
		arg_14_0._curIndex = #arg_14_0._eventList
	end

	arg_14_0:_changeEvent()
	arg_14_0:_updateBtnState()
end

function var_0_0._btnNextOnClick(arg_15_0)
	arg_15_0._curIndex = arg_15_0._curIndex + 1

	arg_15_0:_changeEvent()
	arg_15_0:_updateBtnState()
end

function var_0_0._btnLeftOnClick(arg_16_0)
	arg_16_0._curIndex = arg_16_0._curIndex - 1

	if arg_16_0._curIndex > #arg_16_0._eventList then
		arg_16_0._curIndex = 1
	end

	arg_16_0:_changeEvent()
	arg_16_0:_updateBtnState()
end

function var_0_0._btnRightOnClick(arg_17_0)
	arg_17_0._curIndex = arg_17_0._curIndex + 1

	arg_17_0:_changeEvent()
	arg_17_0:_updateBtnState()
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._goViewport = gohelper.findChild(arg_18_0.viewGO, "root/#go_OutsideEvent/Scroll View/Viewport")
	arg_18_0._outSideEventAnimator = arg_18_0._goOutsideEvent:GetComponent("Animator")
	arg_18_0._outSidePanelAnimator = arg_18_0._goOutsideEventPanel:GetComponent("Animator")
	arg_18_0._goArrow = gohelper.findChild(arg_18_0.viewGO, "root/#go_OutsideEvent/image_Arrow")

	gohelper.setActive(arg_18_0._goArrow, false)
end

function var_0_0._showDialogueView(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._isShowDialogue = arg_19_1

	gohelper.setActive(arg_19_0._goOutsideEvent, arg_19_1)
	gohelper.setActive(arg_19_0._goOutsideEventPanel, not arg_19_1)

	if not arg_19_1 then
		if arg_19_2 then
			arg_19_0:_switch(arg_19_0._outSidePanelAnimator, arg_19_0._showDialogueList)
			AudioMgr.instance:trigger(AudioEnum3_0.CommandStationMap.play_ui_lushang_zhihuibu_paper)
		else
			arg_19_0:_showDialogueList()
		end
	elseif arg_19_2 then
		arg_19_0:_switch(arg_19_0._outSideEventAnimator, arg_19_0._updateDialogue)
	else
		arg_19_0:_updateDialogue()
	end
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0._timeId = arg_20_0.viewParam.timeId
	arg_20_0._eventId = arg_20_0.viewParam.eventId

	local var_20_0 = {}

	tabletool.addValues(var_20_0, CommandStationConfig.instance:getEventList(arg_20_0._timeId, arg_20_0._eventId))

	arg_20_0._eventList = var_20_0
	arg_20_0._minIndex = 1
	arg_20_0._maxIndex = #arg_20_0._eventList
	arg_20_0._curIndex = tabletool.indexOf(arg_20_0._eventList, arg_20_0._eventId)

	arg_20_0:_showDialogue(true)
	arg_20_0:_updateBtnState()
end

function var_0_0._showDialogue(arg_21_0, arg_21_1)
	arg_21_0._dialogueCurIndex = 1
	arg_21_0._dialogueMaxIndex = 1

	local var_21_0 = arg_21_0._eventList[arg_21_0._curIndex]
	local var_21_1 = lua_copost_event.configDict[var_21_0]

	if var_21_1 == nil then
		logError("eventConfig is nil")

		return
	end

	arg_21_0._eventId = var_21_0
	arg_21_0._dialogueList = string.splitToNumber(var_21_1.eventTextId, "#")
	arg_21_0._dialogueMaxIndex = #arg_21_0._dialogueList
	arg_21_0._eventConfig = var_21_1
	arg_21_0._oldState = arg_21_0._isShowDialogue
	arg_21_0._isShowDialogue = CommandStationModel.instance:getEventState(arg_21_0._eventId) ~= CommandStationEnum.EventState.GetReward

	arg_21_0:_showDialogueView(arg_21_0._isShowDialogue, not arg_21_1 and arg_21_0._oldState == arg_21_0._isShowDialogue)
end

function var_0_0._updateDialogue(arg_22_0)
	if arg_22_0._dialogueCurIndex > arg_22_0._dialogueMaxIndex then
		arg_22_0:_showDialogueView(false)

		return
	end

	local var_22_0 = arg_22_0._dialogueList[arg_22_0._dialogueCurIndex]
	local var_22_1 = var_22_0 and lua_copost_event_text.configDict[var_22_0]
	local var_22_2 = var_22_1 and var_22_1.text or ""
	local var_22_3 = GameUtil.getPreferredHeight(arg_22_0._txtDescr, var_22_2)

	arg_22_0._txtDescr.text = var_22_2

	if arg_22_0._goViewport then
		arg_22_0._goViewport:GetComponent(typeof(UnityEngine.UI.MaskableGraphic)).raycastTarget = var_22_3 > recthelper.getHeight(arg_22_0._goViewport.transform)
	end

	local var_22_4 = var_22_1 and lua_copost_character.configDict[var_22_1.chaId]

	arg_22_0._txtTitle.text = var_22_4 and var_22_4.chaName

	gohelper.setActive(arg_22_0._goArrow, arg_22_0._dialogueCurIndex < arg_22_0._dialogueMaxIndex)
end

function var_0_0._updateBtnState(arg_23_0)
	local var_23_0 = arg_23_0._maxIndex ~= 1

	gohelper.setActive(arg_23_0._btnLeft.gameObject, var_23_0)
	gohelper.setActive(arg_23_0._btnRight.gameObject, var_23_0)
	gohelper.setActive(arg_23_0._btnPrev.gameObject, var_23_0)
	gohelper.setActive(arg_23_0._btnNext.gameObject, var_23_0)
	gohelper.setActive(arg_23_0._btnLeftDisable.gameObject, false)
	gohelper.setActive(arg_23_0._btnRightDisable.gameObject, false)
	gohelper.setActive(arg_23_0._btnPrevDisable.gameObject, false)
	gohelper.setActive(arg_23_0._btnNextDisable.gameObject, false)
end

function var_0_0._changeEvent(arg_24_0)
	arg_24_0:_showDialogue()
	arg_24_0:_FocusEvent()
end

function var_0_0._showDialogueList(arg_25_0)
	local var_25_0 = arg_25_0._dialogueList or {}

	gohelper.CreateObjList(arg_25_0, arg_25_0._onCreateItem, var_25_0, arg_25_0._gocontent, arg_25_0._goItem)

	if CommandStationModel.instance:getEventState(arg_25_0._eventId) ~= CommandStationEnum.EventState.GetReward then
		CommandStationRpc.instance:sendFinishCommandPostEventRequest(arg_25_0._eventId)
	end

	arg_25_0._txtTitle2.text = arg_25_0._eventConfig.eventTitleId
end

function var_0_0._onCreateItem(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = gohelper.findChildText(arg_26_1, "")
	local var_26_1 = gohelper.findChildText(arg_26_1, "txt_Title")
	local var_26_2 = arg_26_2 and lua_copost_event_text.configDict[arg_26_2]

	var_26_0.text = var_26_2 and var_26_2.text

	local var_26_3 = var_26_2 and lua_copost_character.configDict[var_26_2.chaId]

	var_26_1.text = var_26_3 and var_26_3.chaName
end

function var_0_0.onClose(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._delayUpdateDialogue, arg_27_0)

	if arg_27_0._isShowDialogue then
		arg_27_0._outSideEventAnimator:Play("close", 0, 0)
	else
		arg_27_0._outSidePanelAnimator:Play("close", 0, 0)
	end
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

return var_0_0
