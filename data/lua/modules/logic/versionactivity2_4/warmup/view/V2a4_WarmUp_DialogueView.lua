module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView", package.seeall)

slot0 = class("V2a4_WarmUp_DialogueView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "Mask/#go_fail")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "Mask/#go_success")
	slot0._goaskphoto = gohelper.findChild(slot0.viewGO, "Left/#go_ask_photo")
	slot0._simageimage = gohelper.findChildSingleImage(slot0.viewGO, "Left/#go_ask_photo/#simage_image")
	slot0._goasktext = gohelper.findChild(slot0.viewGO, "Left/#go_ask_text")
	slot0._simageroleicon = gohelper.findChildSingleImage(slot0.viewGO, "Left/#go_ask_text/cardbg/#simage_roleicon")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "Left/#go_ask_text/info/#go_item")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "Left/#go_ask_text/info/#go_item/bg/#txt_title")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "Left/#go_ask_text/info/#go_item/#txt_dec")
	slot0._txtsmalltitle = gohelper.findChildText(slot0.viewGO, "Right/#txt_smalltitle")
	slot0._godialoguecontainer = gohelper.findChild(slot0.viewGO, "Right/#go_dialoguecontainer")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	slot0._goleftdialogueitem = gohelper.findChild(slot0.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem/content_bg/#txt_content")
	slot0._gorightdialogueitem = gohelper.findChild(slot0.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_rightdialogueitem")
	slot0._gomiddialogueItem = gohelper.findChild(slot0.viewGO, "Right/#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_middialogueItem")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "Right/#go_dialoguecontainer/#go_arrow")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "Right/#go_time")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "Right/#go_time/#txt_time")
	slot0._gooptionitem = gohelper.findChild(slot0.viewGO, "Right/#go_optionitem")
	slot0._goyes = gohelper.findChild(slot0.viewGO, "Right/#go_optionitem/#go_yes")
	slot0._btnyes = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_optionitem/#go_yes/#btn_yes")
	slot0._gono = gohelper.findChild(slot0.viewGO, "Right/#go_optionitem/#go_no")
	slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_optionitem/#go_no/#btn_no")
	slot0._gonext = gohelper.findChild(slot0.viewGO, "Right/#go_optionitem/#go_next")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_optionitem/#go_next/#btn_next")
	slot0._txtcorrect = gohelper.findChildText(slot0.viewGO, "Top/#txt_correct")
	slot0._txtwrong = gohelper.findChildText(slot0.viewGO, "Top/#txt_wrong")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
end

slot1 = string.format
slot2 = SLFramework.AnimatorPlayer
slot3 = "switch"

function slot0._btnyesOnClick(slot0)
	V2a4_WarmUpController.instance:commitAnswer(true)
end

function slot0._btnnoOnClick(slot0)
	V2a4_WarmUpController.instance:commitAnswer(false)
end

slot4 = "V2a4_WarmUp_DialogueView:_btnnextOnClick()"

function slot0._btnnextOnClick(slot0)
	UIBlockHelper.instance:startBlock(uv0, 3, slot0.viewName)
	V2a4_WarmUpController.instance:waveStart(slot0:_level())
end

function slot0._editableInitView_dialogItem(slot0)
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "Right/#go_dialoguecontainer/Scroll View")
	slot0._txtcontentBg = gohelper.findChild(slot0._scrollcontent.gameObject, "Viewport/#go_content/#go_leftdialogueitem/content_bg")
	slot1 = slot0._goleftdialogueitem.transform
	slot4 = slot0._txtcontentBg.transform

	gohelper.setActive(slot0._goleftdialogueitem, false)
	gohelper.setActive(slot0._gorightdialogueitem, false)
	gohelper.setActive(slot0._gomiddialogueItem, false)

	slot5 = recthelper.getAnchorY(slot1)
	slot0._contentMinHeight = recthelper.getHeight(slot0._godialoguecontainer.transform)
	slot0._rectTrContent = slot0._gocontent.transform
	slot0._uiInfo = {
		stY = slot5,
		intervalY = math.max(1, math.abs(recthelper.getAnchorY(slot0._gorightdialogueitem.transform) - slot5) - recthelper.getHeight(slot1)),
		messageTxtMaxWidth = recthelper.getWidth(slot0._txtcontent.transform)
	}

	slot0:_setTimerText(V2a4_WarmUpConfig.instance:getDurationSec())
end

function slot0._editableInitView(slot0)
	slot0._topGo = gohelper.findChild(slot0.viewGO, "Top")
	slot0._leftGo = gohelper.findChild(slot0.viewGO, "Left")
	slot0._animPlayer_Top = uv0.Get(slot0._topGo)
	slot0._animPlayer_Left = uv0.Get(slot0._leftGo)
	slot0._basicInfoItemList = {}
	slot0._dialogueItemList = {}
	slot0._modifiledOnceDict = {}
	slot0._totRoundCount = 0
	slot0._totCorrectCount = 0
	slot0._totWrongCount = 0
	slot0._contentHeight = 0
	slot0._lastDialogueIndex = 0
	slot0._lastWaveMO = nil
	slot0._lastRoundMO = nil
	slot0._lastDialogCO = nil

	slot0:_setActive_GlobalClick(false)
	slot0:_editableInitView_dialogItem()
	gohelper.setActive(slot0._goitem, false)
	gohelper.setActive(slot0._goaskphoto, false)
	gohelper.setActive(slot0._goasktext, false)
	gohelper.setActive(slot0._goyes, false)
	gohelper.setActive(slot0._gono, false)
	gohelper.setActive(slot0._gonext, false)

	slot0._leftAnimEvent = gohelper.onceAddComponent(slot0._leftGo, gohelper.Type_AnimationEventWrap)

	slot0._leftAnimEvent:AddEventListener(uv1, slot0._onAnimSwitch, slot0)
	slot0:_refreshScoreboard()
end

function slot0.onUpdateParam(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
end

function slot0._level(slot0)
	return slot0.viewParam.level or 1
end

function slot0.onOpen(slot0)
	slot0._isFirstWave = true

	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onWaveStart, slot0._onWaveStart, slot0)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onRoundStart, slot0._onRoundStart, slot0)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onMoveStep, slot0._onMoveStep, slot0)
	V2a4_WarmUpController.instance:registerCallback(V2a4_WarmUpEvent.onWaveEnd, slot0._onWaveEnd, slot0)
	slot0:onUpdateParam()
end

function slot0.onOpenFinish(slot0)
	V2a4_WarmUpController.instance:restart(slot0:_level())
end

function slot0.onClose(slot0)
	slot0._modifiledOnceDict = {}

	slot0._leftAnimEvent:RemoveEventListener(uv0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_upTween")
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	TaskDispatcher.cancelTask(slot0._onWaitAnsOvertime, slot0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onWaveStart, slot0._onWaveStart, slot0)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onRoundStart, slot0._onRoundStart, slot0)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onMoveStep, slot0._onMoveStep, slot0)
	V2a4_WarmUpController.instance:unregisterCallback(V2a4_WarmUpEvent.onWaveEnd, slot0._onWaveEnd, slot0)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_upTween")
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	TaskDispatcher.cancelTask(slot0._onWaitAnsOvertime, slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_dialogueItemList")
	GameUtil.onDestroyViewMemberList(slot0, "_basicInfoItemList")
end

function slot0._onWaveStart(slot0, slot1)
	if slot0._isFirstWave then
		slot0._isFirstWave = false

		slot0:_onWaveStartInner(slot1)
	else
		slot0._lastWaveMO = slot1

		slot0._animPlayer_Left:Play(UIAnimationName.Switch, slot0._onAnimSwitchDone, slot0)
		slot0:_moveUpToBlank()
	end
end

function slot0._isReachBound(slot0)
	slot2 = slot0._contentHeight - -slot0._uiInfo.stY

	return Mathf.Approximately(slot2, 0), slot2
end

function slot0._moveUpToBlank(slot0)
	slot3 = slot0._contentMinHeight

	for slot7 = math.max(1, slot0._lastDialogueIndex), #slot0._dialogueItemList do
		slot0._dialogueItemList[slot7]:setGray(true)
	end

	slot4, slot5 = slot0:_isReachBound()
	slot0._contentHeight = slot0._contentHeight + slot3

	if not slot4 then
		slot0._contentHeight = slot0._contentHeight - slot5
	end

	recthelper.setHeight(slot0._rectTrContent, Mathf.Max(slot0._contentHeight, slot0._contentMinHeight))
	slot0:_playUpAnimation()
end

function slot0._onAnimSwitchDone(slot0)
	if not slot0._lastWaveMO then
		return
	end

	slot0:_onWaveStartInner()
end

function slot0._onAnimSwitch(slot0)
	slot0._lastWaveMO = nil

	slot0:_onWaveStartInner(slot0._lastWaveMO)
end

function slot0._onWaveStartInner(slot0, slot1)
	UIBlockHelper.instance:endBlock(uv0)
	gohelper.setActive(slot0._gonext, false)
	gohelper.setActive(slot0._goyes, false)
	gohelper.setActive(slot0._gono, false)
	gohelper.setActive(slot0._goasktext, slot1:isRound_Text())
	gohelper.setActive(slot0._goaskphoto, slot1:isRound_Photo())
	V2a4_WarmUpController.instance:postWaveStart(slot1)
end

function slot0._refreshTimeTick(slot0)
	slot1 = math.max(0, V2a4_WarmUpBattleModel.instance:getRemainTime())

	slot0:_setTimerText(slot1)

	if slot1 <= 0 then
		TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
		V2a4_WarmUpController.instance:timeout()
	end
end

function slot0._setTimerText(slot0, slot1)
	slot0._txttime.text = uv0(V2a4_WarmUpConfig.instance:getConstStr(2), slot1)
end

function slot0._onWaitAnsOvertime(slot0)
	slot1, slot2 = V2a4_WarmUpBattleModel.instance:curRound()

	if not slot1:isWaitAns() or not slot0:_isLastWaveAndRound(slot2, slot1) then
		TaskDispatcher.cancelTask(slot0._onWaitAnsOvertime, slot0)

		return
	end

	if not slot0._lastDialogCO then
		return
	end

	slot3 = slot0._lastDialogCO
	slot0._lastDialogCO = nil

	if slot1:isLastStep() then
		slot0._lastWaveMO = nil
		slot0._lastRoundMO = nil
	end

	slot0:_appendDialogueItem(slot2, slot1, slot3)
end

function slot0._onRoundStart(slot0, slot1, slot2)
	slot0:_cleanLast()

	slot0._totRoundCount = slot0._totRoundCount + 1

	slot0:_refreshRoundTitle(slot1, slot2)
	slot0:_refreshNpcIcon(slot1, slot2)
	slot0:_refreshNpcInfoList(slot1, slot2)
	slot0:_refreshPhotoIcon(slot1, slot2)
	V2a4_WarmUpController.instance:postRoundStart(slot1, slot2)
end

function slot0._onMoveStep(slot0, slot1, slot2, slot3)
	TaskDispatcher.cancelTask(slot0._onWaitAnsOvertime, slot0)

	slot4 = slot2:isWaitAns()
	slot5 = slot2:isReplyResult()

	gohelper.setActive(slot0._goyes, slot4)
	gohelper.setActive(slot0._gono, slot4)
	gohelper.setActive(slot0._gonext, false)

	if slot4 then
		slot0._lastDialogCO = slot3

		if slot0:_isLastWaveAndRound(slot1, slot2) then
			slot0:_onWaitAnsOvertime()
		else
			slot0._lastWaveMO = slot1
			slot0._lastRoundMO = slot2

			TaskDispatcher.runRepeat(slot0._onWaitAnsOvertime, slot0, V2a4_WarmUpConfig.instance:getHangonWaitSec())
		end
	elseif slot5 then
		slot0._animPlayer_Top:Play("refresh", nil, )

		if not slot0:_isLastWaveAndRound(slot1, slot2) then
			slot0._lastWaveMO = slot1
			slot0._lastRoundMO = slot2

			if slot2:isWin() then
				slot0._totCorrectCount = slot0._totCorrectCount + 1
			else
				slot0._totWrongCount = slot0._totWrongCount + 1
			end

			slot0:_refreshScoreboard()
		end

		slot0:_showDialogItemOrStepEnd(slot1, slot2, slot3)
	else
		slot0:_cleanLast()
		slot0:_showDialogItemOrStepEnd(slot1, slot2, slot3)
	end
end

function slot0._showDialogItemOrStepEnd(slot0, slot1, slot2, slot3)
	if not slot3 then
		slot0:onStepEnd(slot1, slot2)
	else
		slot0:_appendDialogueItem(slot1, slot2, slot3)
	end
end

function slot0._onWaveEnd(slot0, slot1)
	gohelper.setActive(slot0._goyes, false)
	gohelper.setActive(slot0._gono, false)
	gohelper.setActive(slot0._gonext, true)
end

function slot0._appendDialogueItem(slot0, slot1, slot2, slot3)
	slot5 = slot0:_create_V2a4_WarmUp_DialogueView_XXXDialogueItem(slot3.group)

	table.insert(slot0._dialogueItemList, slot5)
	slot5:onUpdateMO({
		waveMO = slot1,
		roundMO = slot2,
		dialogCO = slot3
	})
	slot0:_setActive_GlobalClick(true)
end

function slot0.onAddContentItem(slot0, slot1, slot2)
	if not slot0._modifiledOnceDict[slot1] then
		slot0._modifiledOnceDict[slot1] = {
			contentHeight = slot0._contentHeight,
			stY = slot0._uiInfo.stY
		}
	else
		slot0._uiInfo.stY = slot0._modifiledOnceDict[slot1].stY
		slot0._contentHeight = slot0._modifiledOnceDict[slot1].contentHeight
	end

	slot5, slot6 = slot0:_isReachBound()

	if slot5 then
		slot0._contentHeight = slot0._contentHeight + slot2 + slot0._uiInfo.intervalY
	else
		slot0._contentHeight = slot0._contentHeight + math.max(0, slot4 - slot6)
	end

	slot0._uiInfo.stY = slot0._uiInfo.stY - slot4

	recthelper.setHeight(slot0._rectTrContent, Mathf.Max(slot0._contentHeight, slot0._contentMinHeight))
	slot0:_playUpAnimation()
end

function slot0.onStepEnd(slot0, slot1, slot2)
	V2a4_WarmUpController.instance:stepEnd(slot1, slot2)
end

function slot0._playUpAnimation(slot0)
	if slot0._contentHeight <= slot0._contentMinHeight then
		return
	end

	GameUtil.onDestroyViewMember_TweenId(slot0, "_upTween")

	slot0._upTween = ZProj.TweenHelper.DOTweenFloat(slot0._scrollcontent.verticalNormalizedPosition, 0, 0.5, slot0._frameUpdate, slot0._frameFinished, slot0)
end

function slot0._frameUpdate(slot0, slot1)
	slot0._scrollcontent.verticalNormalizedPosition = slot1
end

function slot0._frameFinished(slot0)
	gohelper.setActive(slot0._goArrow, false)
end

function slot0._refreshRoundTitle(slot0, slot1, slot2)
	slot0._txtsmalltitle.text = uv0(V2a4_WarmUpConfig.instance:getConstStr(1), slot0._totRoundCount)
end

function slot0._refreshScoreboard(slot0, slot1, slot2)
	slot0._txtcorrect.text = tostring(slot0._totCorrectCount)
	slot0._txtwrong.text = tostring(slot0._totWrongCount)
end

function slot0._refreshNpcIcon(slot0, slot1, slot2)
	if not slot1:isRound_Text() then
		return
	end

	GameUtil.loadSImage(slot0._simageroleicon, slot2:resUrl())
end

function slot0._refreshPhotoIcon(slot0, slot1, slot2)
	if not slot1:isRound_Photo() then
		return
	end

	GameUtil.loadSImage(slot0._simageimage, slot2:resUrl())
end

function slot0._getNpcBasicInfoIdList(slot0, slot1)
	slot2 = V2a4_WarmUpConfig.instance:textItemListCO(slot1)

	return {
		slot2.info1,
		slot2.info2,
		slot2.info3,
		slot2.info4,
		slot2.info5,
		slot2.info6
	}
end

function slot0._refreshNpcInfoList(slot0, slot1, slot2)
	if not slot1:isRound_Text() then
		return
	end

	for slot8, slot9 in ipairs(slot0:_getNpcBasicInfoIdList(slot2:cfgId())) do
		slot10 = nil

		if slot8 > #slot0._basicInfoItemList then
			table.insert(slot0._basicInfoItemList, slot0:_create_V2a4_WarmUp_DialogueView_BasicInfoItem(slot8))
		else
			slot10 = slot0._basicInfoItemList[slot8]
		end

		slot11 = slot9 ~= 0

		slot10:setActive(slot11)

		if slot11 then
			slot10:onUpdateMO(slot9)
		end
	end

	for slot8 = #slot4 + 1, #slot0._basicInfoItemList do
		slot0._basicInfoItemList[slot8]:setActive(false)
	end
end

function slot0._create_V2a4_WarmUp_DialogueView_BasicInfoItem(slot0, slot1)
	slot3 = V2a4_WarmUp_DialogueView_BasicInfoItem.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})

	slot3:setIndex(slot1)
	slot3:init(gohelper.cloneInPlace(slot0._goitem))

	return slot3
end

function slot0._create_V2a4_WarmUp_DialogueView_XXXDialogueItem(slot0, slot1)
	slot2 = V2a4_WarmUpConfig.instance:getDialogStyleCO(slot1)
	slot3 = _G[slot2.className]

	assert(slot3)

	slot4 = slot3.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})
	slot5 = gohelper.cloneInPlace(slot4:getTemplateGo())

	gohelper.setActive(slot5, true)
	slot4:init(slot5)
	slot4:setFontColor(slot2.fontColor)

	return slot4
end

function slot0.flush(slot0)
	if not slot0._dialogueItemList[#slot0._dialogueItemList] then
		slot0:_setActive_GlobalClick(false)

		return
	end

	if not slot1:isFlushed() then
		slot1:onFlush()
	else
		slot0:_setActive_GlobalClick(false)
	end
end

function slot0._isLastWaveAndRound(slot0, slot1, slot2)
	return slot1 ~= nil and slot0._lastWaveMO == slot1 and slot0._lastRoundMO == slot2
end

function slot0._setActive_GlobalClick(slot0, slot1)
	slot0._allowGlobalClick = slot1
end

function slot0._onTouchScreen(slot0)
	if not slot0._allowGlobalClick then
		return
	end

	slot0:flush()
end

function slot0._cleanLast(slot0)
	slot0._lastWaveMO = nil
	slot0._lastRoundMO = nil
	slot0._lastDialogCO = nil
end

function slot0.uiInfo(slot0)
	return slot0._uiInfo
end

return slot0
