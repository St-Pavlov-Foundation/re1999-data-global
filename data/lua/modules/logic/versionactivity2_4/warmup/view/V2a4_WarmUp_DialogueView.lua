module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView", package.seeall)

local var_0_0 = class("V2a4_WarmUp_DialogueView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "Mask/#go_fail")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "Mask/#go_success")
	arg_1_0._goaskphoto = gohelper.findChild(arg_1_0.viewGO, "Left/#go_ask_photo")
	arg_1_0._simageimage = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#go_ask_photo/#simage_image")
	arg_1_0._goasktext = gohelper.findChild(arg_1_0.viewGO, "Left/#go_ask_text")
	arg_1_0._simageroleicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#go_ask_text/cardbg/#simage_roleicon")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "Left/#go_ask_text/info/#go_item")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_ask_text/info/#go_item/bg/#txt_title")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_ask_text/info/#go_item/#txt_dec")
	arg_1_0._txtsmalltitle = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_smalltitle")
	arg_1_0._godialoguecontainer = gohelper.findChild(arg_1_0.viewGO, "Right/#go_dialoguecontainer")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	arg_1_0._goleftdialogueitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem/content_bg/#txt_content")
	arg_1_0._gorightdialogueitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_rightdialogueitem")
	arg_1_0._gomiddialogueItem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_middialogueItem")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "Right/#go_dialoguecontainer/#go_arrow")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "Right/#go_time")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_time/#txt_time")
	arg_1_0._gooptionitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_optionitem")
	arg_1_0._goyes = gohelper.findChild(arg_1_0.viewGO, "Right/#go_optionitem/#go_yes")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_optionitem/#go_yes/#btn_yes")
	arg_1_0._gono = gohelper.findChild(arg_1_0.viewGO, "Right/#go_optionitem/#go_no")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_optionitem/#go_no/#btn_no")
	arg_1_0._gonext = gohelper.findChild(arg_1_0.viewGO, "Right/#go_optionitem/#go_next")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_optionitem/#go_next/#btn_next")
	arg_1_0._txtcorrect = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_correct")
	arg_1_0._txtwrong = gohelper.findChildText(arg_1_0.viewGO, "Top/#txt_wrong")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
end

local var_0_1 = string.format
local var_0_2 = SLFramework.AnimatorPlayer
local var_0_3 = "switch"

function var_0_0._btnyesOnClick(arg_4_0)
	V2a4_WarmUpController.instance:commitAnswer(true)
end

function var_0_0._btnnoOnClick(arg_5_0)
	V2a4_WarmUpController.instance:commitAnswer(false)
end

local var_0_4 = "V2a4_WarmUp_DialogueView:_btnnextOnClick()"

function var_0_0._btnnextOnClick(arg_6_0)
	UIBlockHelper.instance:startBlock(var_0_4, 3, arg_6_0.viewName)
	V2a4_WarmUpController.instance:waveStart(arg_6_0:_level())
end

function var_0_0._editableInitView_dialogItem(arg_7_0)
	arg_7_0._scrollcontent = gohelper.findChildScrollRect(arg_7_0.viewGO, "Right/#go_dialoguecontainer/Scroll View")
	arg_7_0._txtcontentBg = gohelper.findChild(arg_7_0._scrollcontent.gameObject, "Viewport/#go_content/#go_leftdialogueitem/content_bg")

	local var_7_0 = arg_7_0._goleftdialogueitem.transform
	local var_7_1 = arg_7_0._gorightdialogueitem.transform
	local var_7_2 = arg_7_0._txtcontent.transform
	local var_7_3 = arg_7_0._txtcontentBg.transform

	gohelper.setActive(arg_7_0._goleftdialogueitem, false)
	gohelper.setActive(arg_7_0._gorightdialogueitem, false)
	gohelper.setActive(arg_7_0._gomiddialogueItem, false)

	local var_7_4 = recthelper.getAnchorY(var_7_0)
	local var_7_5 = recthelper.getAnchorY(var_7_1)
	local var_7_6 = recthelper.getHeight(var_7_0)

	arg_7_0._contentMinHeight = recthelper.getHeight(arg_7_0._godialoguecontainer.transform)
	arg_7_0._rectTrContent = arg_7_0._gocontent.transform
	arg_7_0._uiInfo = {
		stY = var_7_4,
		intervalY = math.max(1, math.abs(var_7_5 - var_7_4) - var_7_6),
		messageTxtMaxWidth = recthelper.getWidth(var_7_2)
	}

	arg_7_0:_setTimerText(V2a4_WarmUpConfig.instance:getDurationSec())
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._topGo = gohelper.findChild(arg_8_0.viewGO, "Top")
	arg_8_0._leftGo = gohelper.findChild(arg_8_0.viewGO, "Left")
	arg_8_0._animPlayer_Top = var_0_2.Get(arg_8_0._topGo)
	arg_8_0._animPlayer_Left = var_0_2.Get(arg_8_0._leftGo)
	arg_8_0._basicInfoItemList = {}
	arg_8_0._dialogueItemList = {}
	arg_8_0._modifiledOnceDict = {}
	arg_8_0._totRoundCount = 0
	arg_8_0._totCorrectCount = 0
	arg_8_0._totWrongCount = 0
	arg_8_0._contentHeight = 0
	arg_8_0._lastDialogueIndex = 0
	arg_8_0._lastWaveMO = nil
	arg_8_0._lastRoundMO = nil
	arg_8_0._lastDialogCO = nil

	arg_8_0:_setActive_GlobalClick(false)
	arg_8_0:_editableInitView_dialogItem()
	gohelper.setActive(arg_8_0._goitem, false)
	gohelper.setActive(arg_8_0._goaskphoto, false)
	gohelper.setActive(arg_8_0._goasktext, false)
	gohelper.setActive(arg_8_0._goyes, false)
	gohelper.setActive(arg_8_0._gono, false)
	gohelper.setActive(arg_8_0._gonext, false)

	arg_8_0._leftAnimEvent = gohelper.onceAddComponent(arg_8_0._leftGo, gohelper.Type_AnimationEventWrap)

	arg_8_0._leftAnimEvent:AddEventListener(var_0_3, arg_8_0._onAnimSwitch, arg_8_0)
	arg_8_0:_refreshScoreboard()
end

function var_0_0.onUpdateParam(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._refreshTimeTick, arg_9_0)
	TaskDispatcher.runRepeat(arg_9_0._refreshTimeTick, arg_9_0, 1)
end

function var_0_0._level(arg_10_0)
	return arg_10_0.viewParam.level or 1
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._isFirstWave = true

	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, arg_11_0._onTouchScreen, arg_11_0)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onWaveStart, arg_11_0._onWaveStart, arg_11_0)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onRoundStart, arg_11_0._onRoundStart, arg_11_0)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onMoveStep, arg_11_0._onMoveStep, arg_11_0)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onWaveEnd, arg_11_0._onWaveEnd, arg_11_0)
	arg_11_0:onUpdateParam()
end

function var_0_0.onOpenFinish(arg_12_0)
	local var_12_0 = arg_12_0:_level()

	V2a4_WarmUpController.instance:restart(var_12_0)
end

function var_0_0.onClose(arg_13_0)
	arg_13_0._modifiledOnceDict = {}

	arg_13_0._leftAnimEvent:RemoveEventListener(var_0_3)
	GameUtil.onDestroyViewMember_TweenId(arg_13_0, "_upTween")
	TaskDispatcher.cancelTask(arg_13_0._refreshTimeTick, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._onWaitAnsOvertime, arg_13_0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, arg_13_0._onTouchScreen, arg_13_0)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onWaveStart, arg_13_0._onWaveStart, arg_13_0)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onRoundStart, arg_13_0._onRoundStart, arg_13_0)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onMoveStep, arg_13_0._onMoveStep, arg_13_0)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onWaveEnd, arg_13_0._onWaveEnd, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	GameUtil.onDestroyViewMember_TweenId(arg_14_0, "_upTween")
	TaskDispatcher.cancelTask(arg_14_0._refreshTimeTick, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._onWaitAnsOvertime, arg_14_0)
	GameUtil.onDestroyViewMemberList(arg_14_0, "_dialogueItemList")
	GameUtil.onDestroyViewMemberList(arg_14_0, "_basicInfoItemList")
end

function var_0_0._onWaveStart(arg_15_0, arg_15_1)
	if arg_15_0._isFirstWave then
		arg_15_0._isFirstWave = false

		arg_15_0:_onWaveStartInner(arg_15_1)
	else
		arg_15_0._lastWaveMO = arg_15_1

		arg_15_0._animPlayer_Left:Play(UIAnimationName.Switch, arg_15_0._onAnimSwitchDone, arg_15_0)
		arg_15_0:_moveUpToBlank()
	end
end

function var_0_0._isReachBound(arg_16_0)
	local var_16_0 = -arg_16_0._uiInfo.stY
	local var_16_1 = arg_16_0._contentHeight - var_16_0

	return Mathf.Approximately(var_16_1, 0), var_16_1
end

function var_0_0._moveUpToBlank(arg_17_0)
	local var_17_0 = math.max(1, arg_17_0._lastDialogueIndex)
	local var_17_1 = #arg_17_0._dialogueItemList
	local var_17_2 = arg_17_0._contentMinHeight

	for iter_17_0 = var_17_0, var_17_1 do
		arg_17_0._dialogueItemList[iter_17_0]:setGray(true)
	end

	local var_17_3, var_17_4 = arg_17_0:_isReachBound()

	arg_17_0._contentHeight = arg_17_0._contentHeight + var_17_2

	if not var_17_3 then
		arg_17_0._contentHeight = arg_17_0._contentHeight - var_17_4
	end

	recthelper.setHeight(arg_17_0._rectTrContent, Mathf.Max(arg_17_0._contentHeight, arg_17_0._contentMinHeight))
	arg_17_0:_playUpAnimation()
end

function var_0_0._onAnimSwitchDone(arg_18_0)
	if not arg_18_0._lastWaveMO then
		return
	end

	arg_18_0:_onWaveStartInner()
end

function var_0_0._onAnimSwitch(arg_19_0)
	local var_19_0 = arg_19_0._lastWaveMO

	arg_19_0._lastWaveMO = nil

	arg_19_0:_onWaveStartInner(var_19_0)
end

function var_0_0._onWaveStartInner(arg_20_0, arg_20_1)
	UIBlockHelper.instance:endBlock(var_0_4)
	gohelper.setActive(arg_20_0._gonext, false)
	gohelper.setActive(arg_20_0._goyes, false)
	gohelper.setActive(arg_20_0._gono, false)
	gohelper.setActive(arg_20_0._goasktext, arg_20_1:isRound_Text())
	gohelper.setActive(arg_20_0._goaskphoto, arg_20_1:isRound_Photo())
	V2a4_WarmUpController.instance:postWaveStart(arg_20_1)
end

function var_0_0._refreshTimeTick(arg_21_0)
	local var_21_0 = V2a4_WarmUpBattleModel.instance:getRemainTime()
	local var_21_1 = math.max(0, var_21_0)

	arg_21_0:_setTimerText(var_21_1)

	if var_21_1 <= 0 then
		TaskDispatcher.cancelTask(arg_21_0._refreshTimeTick, arg_21_0)
		V2a4_WarmUpController.instance:timeout()
	end
end

function var_0_0._setTimerText(arg_22_0, arg_22_1)
	arg_22_0._txttime.text = var_0_1(V2a4_WarmUpConfig.instance:getConstStr(2), arg_22_1)
end

function var_0_0._onWaitAnsOvertime(arg_23_0)
	local var_23_0, var_23_1 = V2a4_WarmUpBattleModel.instance:curRound()

	if not var_23_0:isWaitAns() or not arg_23_0:_isLastWaveAndRound(var_23_1, var_23_0) then
		TaskDispatcher.cancelTask(arg_23_0._onWaitAnsOvertime, arg_23_0)

		return
	end

	if not arg_23_0._lastDialogCO then
		return
	end

	local var_23_2 = arg_23_0._lastDialogCO

	arg_23_0._lastDialogCO = nil

	if var_23_0:isLastStep() then
		arg_23_0._lastWaveMO = nil
		arg_23_0._lastRoundMO = nil
	end

	arg_23_0:_appendDialogueItem(var_23_1, var_23_0, var_23_2)
end

function var_0_0._onRoundStart(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:_cleanLast()

	arg_24_0._totRoundCount = arg_24_0._totRoundCount + 1

	arg_24_0:_refreshRoundTitle(arg_24_1, arg_24_2)
	arg_24_0:_refreshNpcIcon(arg_24_1, arg_24_2)
	arg_24_0:_refreshNpcInfoList(arg_24_1, arg_24_2)
	arg_24_0:_refreshPhotoIcon(arg_24_1, arg_24_2)
	V2a4_WarmUpController.instance:postRoundStart(arg_24_1, arg_24_2)
end

function var_0_0._onMoveStep(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	TaskDispatcher.cancelTask(arg_25_0._onWaitAnsOvertime, arg_25_0)

	local var_25_0 = arg_25_2:isWaitAns()
	local var_25_1 = arg_25_2:isReplyResult()

	gohelper.setActive(arg_25_0._goyes, var_25_0)
	gohelper.setActive(arg_25_0._gono, var_25_0)
	gohelper.setActive(arg_25_0._gonext, false)

	if var_25_0 then
		arg_25_0._lastDialogCO = arg_25_3

		if arg_25_0:_isLastWaveAndRound(arg_25_1, arg_25_2) then
			arg_25_0:_onWaitAnsOvertime()
		else
			arg_25_0._lastWaveMO = arg_25_1
			arg_25_0._lastRoundMO = arg_25_2

			TaskDispatcher.runRepeat(arg_25_0._onWaitAnsOvertime, arg_25_0, V2a4_WarmUpConfig.instance:getHangonWaitSec())
		end
	elseif var_25_1 then
		arg_25_0._animPlayer_Top:Play("refresh", nil, nil)

		if not arg_25_0:_isLastWaveAndRound(arg_25_1, arg_25_2) then
			arg_25_0._lastWaveMO = arg_25_1
			arg_25_0._lastRoundMO = arg_25_2

			if arg_25_2:isWin() then
				arg_25_0._totCorrectCount = arg_25_0._totCorrectCount + 1
			else
				arg_25_0._totWrongCount = arg_25_0._totWrongCount + 1
			end

			arg_25_0:_refreshScoreboard()
		end

		arg_25_0:_showDialogItemOrStepEnd(arg_25_1, arg_25_2, arg_25_3)
	else
		arg_25_0:_cleanLast()
		arg_25_0:_showDialogItemOrStepEnd(arg_25_1, arg_25_2, arg_25_3)
	end
end

function var_0_0._showDialogItemOrStepEnd(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if not arg_26_3 then
		arg_26_0:onStepEnd(arg_26_1, arg_26_2)
	else
		arg_26_0:_appendDialogueItem(arg_26_1, arg_26_2, arg_26_3)
	end
end

function var_0_0._onWaveEnd(arg_27_0, arg_27_1)
	gohelper.setActive(arg_27_0._goyes, false)
	gohelper.setActive(arg_27_0._gono, false)
	gohelper.setActive(arg_27_0._gonext, true)
end

function var_0_0._appendDialogueItem(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_3.group
	local var_28_1 = arg_28_0:_create_V2a4_WarmUp_DialogueView_XXXDialogueItem(var_28_0)

	table.insert(arg_28_0._dialogueItemList, var_28_1)

	local var_28_2 = {
		waveMO = arg_28_1,
		roundMO = arg_28_2,
		dialogCO = arg_28_3
	}

	var_28_1:onUpdateMO(var_28_2)
	arg_28_0:_setActive_GlobalClick(true)
end

function var_0_0.onAddContentItem(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0._modifiledOnceDict[arg_29_1] then
		arg_29_0._modifiledOnceDict[arg_29_1] = {
			contentHeight = arg_29_0._contentHeight,
			stY = arg_29_0._uiInfo.stY
		}
	else
		arg_29_0._uiInfo.stY = arg_29_0._modifiledOnceDict[arg_29_1].stY
		arg_29_0._contentHeight = arg_29_0._modifiledOnceDict[arg_29_1].contentHeight
	end

	local var_29_0 = arg_29_2 + arg_29_0._uiInfo.intervalY
	local var_29_1, var_29_2 = arg_29_0:_isReachBound()

	if var_29_1 then
		arg_29_0._contentHeight = arg_29_0._contentHeight + var_29_0
	else
		arg_29_0._contentHeight = arg_29_0._contentHeight + math.max(0, var_29_0 - var_29_2)
	end

	arg_29_0._uiInfo.stY = arg_29_0._uiInfo.stY - var_29_0

	recthelper.setHeight(arg_29_0._rectTrContent, Mathf.Max(arg_29_0._contentHeight, arg_29_0._contentMinHeight))
	arg_29_0:_playUpAnimation()
end

function var_0_0.onStepEnd(arg_30_0, arg_30_1, arg_30_2)
	V2a4_WarmUpController.instance:stepEnd(arg_30_1, arg_30_2)
end

function var_0_0._playUpAnimation(arg_31_0)
	if arg_31_0._contentHeight <= arg_31_0._contentMinHeight then
		return
	end

	GameUtil.onDestroyViewMember_TweenId(arg_31_0, "_upTween")

	arg_31_0._upTween = ZProj.TweenHelper.DOTweenFloat(arg_31_0._scrollcontent.verticalNormalizedPosition, 0, 0.5, arg_31_0._frameUpdate, arg_31_0._frameFinished, arg_31_0)
end

function var_0_0._frameUpdate(arg_32_0, arg_32_1)
	arg_32_0._scrollcontent.verticalNormalizedPosition = arg_32_1
end

function var_0_0._frameFinished(arg_33_0)
	gohelper.setActive(arg_33_0._goArrow, false)
end

function var_0_0._refreshRoundTitle(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0._txtsmalltitle.text = var_0_1(V2a4_WarmUpConfig.instance:getConstStr(1), arg_34_0._totRoundCount)
end

function var_0_0._refreshScoreboard(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0._txtcorrect.text = tostring(arg_35_0._totCorrectCount)
	arg_35_0._txtwrong.text = tostring(arg_35_0._totWrongCount)
end

function var_0_0._refreshNpcIcon(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_1:isRound_Text() then
		return
	end

	GameUtil.loadSImage(arg_36_0._simageroleicon, arg_36_2:resUrl())
end

function var_0_0._refreshPhotoIcon(arg_37_0, arg_37_1, arg_37_2)
	if not arg_37_1:isRound_Photo() then
		return
	end

	GameUtil.loadSImage(arg_37_0._simageimage, arg_37_2:resUrl())
end

function var_0_0._getNpcBasicInfoIdList(arg_38_0, arg_38_1)
	local var_38_0 = V2a4_WarmUpConfig.instance:textItemListCO(arg_38_1)

	return {
		var_38_0.info1,
		var_38_0.info2,
		var_38_0.info3,
		var_38_0.info4,
		var_38_0.info5,
		var_38_0.info6
	}
end

function var_0_0._refreshNpcInfoList(arg_39_0, arg_39_1, arg_39_2)
	if not arg_39_1:isRound_Text() then
		return
	end

	local var_39_0 = arg_39_2:cfgId()
	local var_39_1 = arg_39_0:_getNpcBasicInfoIdList(var_39_0)

	for iter_39_0, iter_39_1 in ipairs(var_39_1) do
		local var_39_2

		if iter_39_0 > #arg_39_0._basicInfoItemList then
			var_39_2 = arg_39_0:_create_V2a4_WarmUp_DialogueView_BasicInfoItem(iter_39_0)

			table.insert(arg_39_0._basicInfoItemList, var_39_2)
		else
			var_39_2 = arg_39_0._basicInfoItemList[iter_39_0]
		end

		local var_39_3 = iter_39_1 ~= 0

		var_39_2:setActive(var_39_3)

		if var_39_3 then
			var_39_2:onUpdateMO(iter_39_1)
		end
	end

	for iter_39_2 = #var_39_1 + 1, #arg_39_0._basicInfoItemList do
		arg_39_0._basicInfoItemList[iter_39_2]:setActive(false)
	end
end

function var_0_0._create_V2a4_WarmUp_DialogueView_BasicInfoItem(arg_40_0, arg_40_1)
	local var_40_0 = gohelper.cloneInPlace(arg_40_0._goitem)
	local var_40_1 = V2a4_WarmUp_DialogueView_BasicInfoItem.New({
		parent = arg_40_0,
		baseViewContainer = arg_40_0.viewContainer
	})

	var_40_1:setIndex(arg_40_1)
	var_40_1:init(var_40_0)

	return var_40_1
end

function var_0_0._create_V2a4_WarmUp_DialogueView_XXXDialogueItem(arg_41_0, arg_41_1)
	local var_41_0 = V2a4_WarmUpConfig.instance:getDialogStyleCO(arg_41_1)
	local var_41_1 = _G[var_41_0.className]

	assert(var_41_1)

	local var_41_2 = var_41_1.New({
		parent = arg_41_0,
		baseViewContainer = arg_41_0.viewContainer
	})
	local var_41_3 = gohelper.cloneInPlace(var_41_2:getTemplateGo())

	gohelper.setActive(var_41_3, true)
	var_41_2:init(var_41_3)
	var_41_2:setFontColor(var_41_0.fontColor)

	return var_41_2
end

function var_0_0.flush(arg_42_0)
	local var_42_0 = arg_42_0._dialogueItemList[#arg_42_0._dialogueItemList]

	if not var_42_0 then
		arg_42_0:_setActive_GlobalClick(false)

		return
	end

	if not var_42_0:isFlushed() then
		var_42_0:onFlush()
	else
		arg_42_0:_setActive_GlobalClick(false)
	end
end

function var_0_0._isLastWaveAndRound(arg_43_0, arg_43_1, arg_43_2)
	return arg_43_1 ~= nil and arg_43_0._lastWaveMO == arg_43_1 and arg_43_0._lastRoundMO == arg_43_2
end

function var_0_0._setActive_GlobalClick(arg_44_0, arg_44_1)
	arg_44_0._allowGlobalClick = arg_44_1
end

function var_0_0._onTouchScreen(arg_45_0)
	if not arg_45_0._allowGlobalClick then
		return
	end

	arg_45_0:flush()
end

function var_0_0._cleanLast(arg_46_0)
	arg_46_0._lastWaveMO = nil
	arg_46_0._lastRoundMO = nil
	arg_46_0._lastDialogCO = nil
end

function var_0_0.uiInfo(arg_47_0)
	return arg_47_0._uiInfo
end

return var_0_0
