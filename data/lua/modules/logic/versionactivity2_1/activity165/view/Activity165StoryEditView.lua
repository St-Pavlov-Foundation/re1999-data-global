module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEditView", package.seeall)

slot0 = class("Activity165StoryEditView", BaseView)

function slot0.onInitView(slot0)
	slot0._gostory = gohelper.findChild(slot0.viewGO, "#go_story")
	slot0._goending = gohelper.findChild(slot0.viewGO, "#go_ending")
	slot0._simagepic = gohelper.findChildImage(slot0.viewGO, "#go_assessment/#simage_pic")
	slot0._txtstory = gohelper.findChildText(slot0.viewGO, "#go_ending/scroll_story/Viewport/#txt_story")
	slot0._goassessment = gohelper.findChild(slot0.viewGO, "#go_assessment")
	slot0._imageassessment = gohelper.findChildImage(slot0.viewGO, "#go_assessment/#image_assessment")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#go_assessment/scroll_dec/Viewport/#txt_dec")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_restart")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_story/#go_tips")
	slot0._gokeywordpanel = gohelper.findChild(slot0.viewGO, "#go_keywordpanel")
	slot0._btnkeywordpanelclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_keywordpanel/#btn_close")
	slot0._gokeywords = gohelper.findChild(slot0.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords/#image_icon")
	slot0._txtkeywords = gohelper.findChildText(slot0.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords/#txt_keywords")
	slot0._btnkeywords = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords/#btn_keywords")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_keywordpanel/#btn_ok")
	slot0._godragContainer = gohelper.findChild(slot0.viewGO, "#go_dragContainer")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
	slot0._btnkeywords:AddClickListener(slot0._btnkeywordsOnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	slot0._btnkeywordpanelclose:AddClickListener(slot0._btnkeywordpanelcloseOnClick, slot0)
	slot0:_addEvents()
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnkeywords:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
	slot0._btnkeywordpanelclose:RemoveClickListener()
	slot0:_removeEvents()
end

function slot0._btnconfirmOnClick(slot0)
	slot0:beginGenerateEnding()
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act165ResetEditor, MsgBoxEnum.BoxType.Yes_No, slot0._restartStory, nil, , slot0, nil)
end

function slot0._btnrestartOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act165ResetEditor, MsgBoxEnum.BoxType.Yes_No, slot0._restartStory, nil, , slot0, nil)
end

function slot0._btndialogcontainerOnClick(slot0)
	if slot0.isEndingAnim then
		gohelper.setActive(slot0._godialogcontainer.gameObject, false)
		slot0:_showAssessment()
	end
end

function slot0._btnkeywordpanelcloseOnClick(slot0)
	slot0:_closeKwPanel(slot0._storyMo:getSelectStepIndex())
end

function slot0._btnokOnClick(slot0)
	slot1 = slot0._storyMo:getSelectStepIndex()

	if slot0._storyMo:isFillingStep() then
		if slot1 and slot0._curStep and (slot0._storyMo:checkIsFinishStep() or slot0._curStep:isNullKeyword()) then
			slot0:_closeKwPanel(slot1)
		end
	else
		slot0:_closeKwPanel(slot1)
	end
end

function slot0._editableInitView(slot0)
	slot0._goassessmentVX_s = gohelper.findChild(slot0.viewGO, "#go_assessment/#vx_s")
	slot0._godialogcontainer = gohelper.findChild(slot0.viewGO, "#go_dialogcontainer")
	slot0._btndialog = gohelper.getClick(slot0._godialogcontainer)

	slot0._btndialog:AddClickListener(slot0._btndialogcontainerOnClick, slot0)
	gohelper.setActive(slot0._godialogcontainer.gameObject, false)

	slot0._simagedialogicon = gohelper.findChildSingleImage(slot0._godialogcontainer, "#go_dialog/container/headframe/headicon")
	slot0._txtdialog = gohelper.findChildText(slot0._godialogcontainer, "#go_dialog/container/go_normalcontent/txt_contentcn")
	slot0._simagedialogbg = gohelper.findChildSingleImage(slot0._godialogcontainer, "#go_dialog/container/simagebg")
	slot0._keywordPanelAnim = SLFramework.AnimatorPlayer.Get(slot0._gokeywordpanel.gameObject)
	slot0._viewAnim = SLFramework.AnimatorPlayer.Get(slot0.viewGO.gameObject)
	slot0._btnconfirmAnim = slot0._btnconfirm.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "excessive")
	slot0._endAnim = SLFramework.AnimatorPlayer.Get(slot0._goending.gameObject)
	slot0._assessmentAnim = SLFramework.AnimatorPlayer.Get(slot0._goassessment.gameObject)
	slot0._assessmentAnimEvent = slot0._goassessment:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._assessmentAnimEvent:AddEventListener("PlayAudio", slot0._playAssessmentAudio, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0._btnclickOnClick(slot0)
	if slot0._isFinishPlayEnding then
		return
	end

	if slot0._storyMo:getState() == Activity165Enum.StoryStage.Ending then
		if not slot0._tweenEndingId then
			return
		end

		slot0:_killEndingTxtAnim()
		slot0:_showEndingCallBack()
	else
		if not slot0._playerStepAnimIndex then
			return
		end

		if not slot0._stepItemList[slot0._playerStepAnimIndex] or not slot2._isUnlock then
			slot0._playerStepAnimIndex = nil

			return
		end

		slot0._playerStepAnimIndex = nil

		slot2:finishStoryAnim()
	end
end

function slot0._addEvents(slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, slot0._Act165GetInfoReply, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.Act165RestartReply, slot0._Act165RestartReply, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, slot0._Act165GenerateEndingReply, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.Act165ModifyKeywordReply, slot0._Act165ModifyKeywordReply, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.onClickStepBtn, slot0._onClickStepBtn, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.OnFinishStep, slot0._OnFinishStep, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.onClickUsedKeyword, slot0._onClickUsedKeyword, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.canfinishStory, slot0._canfinishStory, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.refrshEditView, slot0.onRefresh, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.finishStepAnim, slot0._finishStepAnim, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
end

function slot0._removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()

	if slot0._btndialog then
		slot0._btndialog:RemoveClickListener()
	end

	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, slot0._Act165GetInfoReply, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165RestartReply, slot0._Act165RestartReply, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, slot0._Act165GenerateEndingReply, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165ModifyKeywordReply, slot0._Act165ModifyKeywordReply, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.onClickStepBtn, slot0._onClickStepBtn, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.OnFinishStep, slot0._OnFinishStep, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.onClickUsedKeyword, slot0._onClickUsedKeyword, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.canfinishStory, slot0._canfinishStory, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.refrshEditView, slot0.onRefresh, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.finishStepAnim, slot0._finishStepAnim, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
	slot0._assessmentAnimEvent:RemoveEventListener("PlayAudio")
end

function slot0._onClickStepBtn(slot0, slot1)
	if slot0._storyMo:getSelectStepIndex() then
		return
	end

	for slot5, slot6 in ipairs(slot0._stepItemList) do
		if slot6:isPlayingTxt() then
			return
		end
	end

	slot0._storyMo:setSelectStepIndex(slot1)
	slot0._stepItemList[slot1]:refreshFillStepState()

	if slot0._curStep then
		slot0._curStep:refreshFillStepState()
	end

	slot0._curStep = slot2

	slot0:_refreshKeywordItem()
	slot0:_activeKeywordPanel(true)
	slot0._viewAnim:Play(Activity165Enum.EditStepMoveAnim[slot1].Move, nil, slot0)

	if slot0._storyMo:getState() == Activity165Enum.StoryStage.isEndFill then
		gohelper.setActive(slot0._btnconfirm.gameObject, false)
	end
end

function slot0._OnFinishStep(slot0, slot1)
	slot0._curfinishStep = slot1

	if LuaUtil.tableNotEmpty(slot1) then
		slot0:_onFinishStepItem(1)
	end
end

function slot0._onFinishStepItem(slot0, slot1)
	slot0._finishStepIndex = slot1

	if slot1 > #slot0._curfinishStep then
		return
	end

	slot3 = slot0._storyMo:unlockStepCount() - #slot0._curfinishStep + slot1 - 1
	slot0._playerStepAnimIndex = slot3

	if slot3 == 3 then
		gohelper.setActive(slot0._golocked, true)
		slot0._lockRightAnim:Play(Activity165Enum.EditViewAnim.Unlock, slot0._hideLockRight, slot0)
	end

	if slot0._storyMo:getStepMo(slot0._curfinishStep[slot1]) and slot5.isEndingStep then
		return
	end

	slot0._stepItemList[slot3]:onFinishStep(slot4)
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill_win)
end

function slot0._hideLockRight(slot0)
	gohelper.setActive(slot0._golocked, false)
end

function slot0._canfinishStory(slot0)
	slot0:_activeKeywordPanel(false)
	slot0:_onRefreshStoryState()
	slot0:_refreshTip()
end

function slot0._finishStepAnim(slot0)
	if slot0._finishStepIndex > #slot0._curfinishStep then
		slot0._playerStepAnimIndex = nil

		return
	end

	if slot0._storyMo:getState() ~= Activity165Enum.StoryStage.Filling then
		return
	end

	if slot0._storyMo:getStepMo(slot0._curfinishStep[slot0._finishStepIndex]) and slot2.isEndingStep then
		slot0._storyMo:finishStroy()

		slot0._playerStepAnimIndex = nil

		return
	end

	slot5 = slot0._stepItemList[slot0._storyMo:unlockStepCount() - #slot0._curfinishStep + slot0._finishStepIndex]

	if slot0._storyMo:getStepMo(slot0._curfinishStep[slot0._finishStepIndex + 1]) and slot7.isEndingStep then
		slot0._storyMo:finishStroy()

		slot0._playerStepAnimIndex = nil

		return
	end

	slot5:onUpdateMO(slot6)

	if slot0._finishStepIndex + 1 >= #slot0._curfinishStep then
		slot5:showEgLock()
	end

	slot0:_onFinishStepItem(slot0._finishStepIndex + 1)
end

function slot0._onClickUsedKeyword(slot0, slot1)
	if slot0._isDraging or not slot0._storyMo.curStepIndex then
		return
	end

	slot0._clickKwId = slot1

	slot0:checkKeyword()

	if slot0._storyMo:isFillingStep() then
		if slot0._storyMo:getKeywordMo(slot1).isUsed then
			if slot0._curStep and slot0._curStep:isKeyword(slot1) then
				slot0._storyMo:removeUseKeywords(slot1)
				slot0._curStep:removeKeywordItem(slot1)
			end
		else
			slot0:_tryFillKeyword(slot1, true)
		end
	elseif slot2.isUsed or slot0._curStep:tryFillKeyword() then
		GameFacade.showMessageBox(MessageBoxIdDefine.Act165ResetStep, MsgBoxEnum.BoxType.Yes_No, slot0._onclickPreStepYesCallback, nil, , slot0)
	end
end

function slot0._Act165GetInfoReply(slot0)
	slot0:_refreshStep()
end

function slot0._Act165RestartReply(slot0, slot1)
	if slot0._clickKwId then
		slot0:_onClickUsedKeyword(slot0._clickKwId)
	end

	slot0:onRefresh()

	slot0._clickKwId = nil
end

function slot0._Act165GenerateEndingReply(slot0, slot1)
end

function slot0._Act165ModifyKeywordReply(slot0, slot1)
	slot0:_refreshKeywordItem()
end

function slot0.onOpen(slot0)
	slot0._actId = Activity165Model.instance:getActivityId()
	slot0._storyId = slot0.viewParam.storyId
	slot0.reviewEnding = slot0.viewParam.reviewEnding
	slot0._storyMo = Activity165Model.instance:getStoryMo(slot0._actId, slot0._storyId)

	slot0._storyMo:setReviewEnding(slot0.reviewEnding)

	slot0._clickKwId = nil

	slot0:_createStoryGo()

	slot0.isEndingAnim = false
	slot0._isCloseKePanel = false

	slot0:_onRefreshStoryState()
	slot0:_activeKeywordPanel(false)
	gohelper.setActive(slot0._goexcessive.gameObject, false)
	slot0:_refreshTip()

	slot0._isFinishPlayEnding = false

	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_enter)
end

function slot0.onRefresh(slot0)
	slot0:_onRefreshStoryState()
	slot0:_refreshStep()
	slot0:_refreshKeywordItem()
end

function slot0._onRefreshStoryState(slot0)
	slot3 = slot1 == Activity165Enum.StoryStage.Ending

	if slot0._storyMo:getState() == Activity165Enum.StoryStage.isEndFill or slot3 then
		slot5 = math.min(#slot0._stepItemList, slot0._storyMo:getUnlockStepIdRemoveEndingCount())
		slot6 = slot0._stepItemList[slot5 + 1]
		slot7 = slot5 > 1 and 324 or -484
		slot8 = slot6 and slot6.goParent.transform.localPosition.y or -200

		recthelper.setAnchor(slot0._btnconfirm.transform, slot7, slot8)
		recthelper.setAnchor(slot0._goending.transform, slot7, slot8 - 100)
		recthelper.setAnchor(slot0._goassessment.transform, slot7, slot8 - 240)

		if slot0._storyMo:getUnlockStepIdRemoveEndingCount() > 1 then
			gohelper.setActive(slot0._golocked, false)
		end
	end

	gohelper.setActive(slot0._btnconfirm.gameObject, slot2)
	gohelper.setActive(slot0._goending.gameObject, slot3)
	gohelper.setActive(slot0._goassessment.gameObject, slot3)
	gohelper.setActive(slot0._btnreset.gameObject, not slot3)
	gohelper.setActive(slot0._btnrestart.gameObject, slot3 and not slot0.reviewEnding)

	if slot3 then
		slot0:_showEnding()
	end
end

function slot0._createStoryGo(slot0)
	slot0._storyItem = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._gostory, "story"), "story_" .. slot0._storyId)
	slot0._golocked = gohelper.findChild(slot0._storyItem, "#go_point/#go_locked")
	slot0._lockRightAnim = SLFramework.AnimatorPlayer.Get(slot0._golocked.gameObject)
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0._storyItem, "#btn_click")

	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)

	slot0._storyAnim = SLFramework.AnimatorPlayer.Get(slot0._storyItem.gameObject)
	slot6 = gohelper.findChildScrollRect(slot0._storyItem, "begin/scroll_story")

	if slot0._storyMo then
		gohelper.findChildText(slot0._storyItem, "#txt_title").text = slot0._storyMo:getStoryName(76)
		gohelper.findChildText(slot0._storyItem, "begin/scroll_story/Viewport/#txt_dec").text = slot0._storyMo:getStoryFirstStepMo() and slot7.stepCo.text

		if not string.nilorempty(slot7 and slot7.stepCo.pic) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(gohelper.findChildImage(slot0._storyItem, "begin/icon/#image_icon"), slot8, true)
		end

		slot0:_createStepList()
	end

	slot6.verticalNormalizedPosition = 1
end

function slot0._createStepList(slot0)
	slot1 = gohelper.findChild(slot0._storyItem, "#go_point/eg")

	gohelper.setActive(gohelper.findChild(slot1, "#go_eg").gameObject, false)
	gohelper.setActive(slot1, false)

	slot0._stepItemList = slot0:getUserDataTb_()

	for slot8 = 1, gohelper.findChild(slot0._storyItem, "#go_point/point").transform.childCount do
		slot9 = gohelper.findChild(slot3, slot8)
		slot10 = gohelper.clone(slot2, slot9)
		slot11 = MonoHelper.addNoUpdateLuaComOnceToGo(slot10, Activity165StepItem)
		slot11.goParent = slot9

		slot11:onInitItem(slot0._storyMo, slot8)
		gohelper.setActive(slot10.gameObject, true)

		slot0._stepItemList[slot8] = slot11
	end

	slot0:_refreshStep()
end

function slot0._refreshStep(slot0)
	for slot5, slot6 in pairs(slot0._stepItemList) do
		slot6:onUpdateMO(slot0._storyMo:getUnlockStepIdRemoveEnding()[slot5])
	end

	gohelper.setActive(slot0._golocked, slot0._storyMo:getUnlockStepIdRemoveEndingCount() < 3)

	if slot2 < 3 then
		slot0._lockRightAnim:Play(Activity165Enum.EditViewAnim.Idle, nil, slot0)
	end
end

function slot0._refreshTip(slot0)
end

function slot0._restartStory(slot0)
	TaskDispatcher.cancelTask(slot0._restartStoryCallback, slot0)
	TaskDispatcher.cancelTask(slot0._hideExcessive, slot0)
	gohelper.setActive(slot0._goexcessive.gameObject, true)
	TaskDispatcher.runDelay(slot0._restartStoryCallback, slot0, 0.5)
	TaskDispatcher.runDelay(slot0._hideExcessive, slot0, 1)

	slot0._isFinishPlayEnding = false
end

function slot0._restartStoryCallback(slot0)
	gohelper.setActive(slot0._godialogcontainer.gameObject, false)
	slot0._storyMo:onRestart()
	Activity165Rpc.instance:sendAct165RestartRequest(slot0._actId, slot0._storyId, slot0._storyMo:getFirstStepId())
end

function slot0._hideExcessive(slot0)
	gohelper.setActive(slot0._goexcessive.gameObject, false)
end

function slot0._onclickPreStepYesCallback(slot0)
	slot0._storyMo:resetStep()

	if slot0._storyMo.curStepInde then
		for slot4 = slot0._storyMo.curStepIndex + 1, #slot0._stepItemList do
			slot0._stepItemList[slot4]:clearStep()
		end
	end

	slot0._curStep:onRefreshMo()
	gohelper.setActive(slot0._golocked, slot0._storyMo:getUnlockStepIdRemoveEndingCount() < 3)
end

function slot0.playCloseAnim(slot0, slot1, slot2)
	if slot0._storyAnim then
		slot0._storyAnim:Play(Activity165Enum.EditViewAnim.Close, slot1, slot2)

		if slot0._goending.activeSelf then
			slot0._endAnim:Play(Activity165Enum.EditViewAnim.Close, nil, slot0)
		end

		if slot0._goassessment.activeSelf then
			slot0._assessmentAnim:Play(Activity165Enum.EditViewAnim.Close, nil, slot0)
		end

		slot0._viewAnim:Play(Activity165Enum.EditViewAnim.Close, nil, slot0)
	elseif slot1 then
		slot1(slot2)
	end
end

function slot0._refreshKeywordItem(slot0)
	if slot0._storyMo then
		slot0._keywordItems = slot0:getUserDataTb_()

		gohelper.CreateObjList(slot0, slot0._createKeywordCallback, slot0._storyMo:getKeywordList(), slot0._gokeywords.transform.parent.gameObject, slot0._gokeywords, Activity165KeywordItem)
	end

	slot0:_refreshKeywordPanel()
end

function slot0._createKeywordCallback(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setDragEvent(slot0._onDragBegin, slot0._onDrag, slot0._onDragEnd, slot0)

	slot0._keywordItems[slot2.keywordId] = slot1
end

function slot0._activeKeywordPanel(slot0, slot1)
	if not slot1 then
		slot0._storyMo:setSelectStepIndex()

		for slot5, slot6 in pairs(slot0._stepItemList) do
			slot6:refreshFillStepState()
		end
	end

	slot2 = slot1 and Activity165Enum.EditViewAnim.Open or Activity165Enum.EditViewAnim.Close

	function slot3()
		if not uv0 then
			gohelper.setActive(uv1._gokeywordpanel, false)
			gohelper.setActive(uv1._gotopleft, true)
		end
	end

	if slot1 then
		gohelper.setActive(slot0._gokeywordpanel, true)
		gohelper.setActive(slot0._gotopleft, false)
	end

	if slot0._gokeywordpanel.activeSelf then
		slot0._keywordPanelAnim:Play(slot2, slot3, slot0)
	end
end

function slot0._refreshKeywordPanel(slot0)
	for slot4, slot5 in pairs(slot0._keywordItems) do
		slot5:onRefresh()
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if slot0._isDraging then
		return
	end

	if not slot0._storyMo:getKeywordMo(slot1) or slot4.isUsed then
		return
	end

	if slot0._curStep and slot0._curStep:isFullKeyword() then
		return
	end

	slot0:checkKeyword()
	gohelper.setActive(slot0._godragContainer.gameObject, true)

	slot0._isDraging = true

	if slot0:_getDragKeywordItem() then
		slot5.id = slot3

		if not string.nilorempty(Activity165Config.instance:getKeywordCo(slot0._actId, slot3).pic) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(slot0._dragKeywordItem.icon, slot6.pic)
		end

		gohelper.setActive(slot0._dragKeywordItem.go, true)
		slot0._keywordItems[slot3]:Using()
	end

	slot0:_setDragItemPos()
end

function slot0.checkKeyword(slot0)
	if not slot0._curStep then
		return
	end

	for slot5, slot6 in ipairs(slot0._storyMo:getKeywordList()) do
		if slot6.isUsed and not LuaUtil.tableContains(slot0._curStep._keywordIdList, slot6.keywordId) then
			slot0._curStep:addKeywordItem(slot7)
		end
	end
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._isDraging then
		return
	end

	slot0:_setDragItemPos()

	if slot0:_isInCurStep() then
		slot0._curStep:setBogusKeyword(slot0._dragKeywordItem.id)
	else
		slot0._curStep:refreshBogusKeyword()
	end
end

function slot0._onDragEndEvent(slot0)
	slot0._isDraging = false

	slot0._curStep:cancelBogusKeyword()
	slot0:_tryFillKeyword(slot0._dragKeywordItem.id, slot0:_isInCurStep() and slot0._dragKeywordItem)
	gohelper.setActive(slot0._dragKeywordItem.go, false)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if not slot0._isDraging then
		return
	end

	slot0:_onDragEndEvent()
end

function slot0._setDragItemPos(slot0)
	if slot0._dragKeywordItem then
		slot1 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0._godragContainer.transform)

		recthelper.setAnchor(slot0._dragKeywordItem.go.transform, slot1.x, slot1.y)
	end
end

function slot0._getDragKeywordItem(slot0)
	if not slot0._dragKeywordItem then
		slot2 = gohelper.clone(gohelper.findChild(slot0._gokeywords, "#image_icon"), slot0._godragContainer, "dragItem")
		slot0._dragKeywordItem = {
			go = slot2,
			icon = slot2:GetComponent(typeof(UnityEngine.UI.Image))
		}
	end

	return slot0._dragKeywordItem
end

function slot0._tryFillKeyword(slot0, slot1, slot2)
	if slot2 and slot0._curStep:tryFillKeyword(slot1) then
		slot0:_fillKeyword(slot1)
	else
		slot0:_failFillKeyword(slot1)
	end

	slot0._clickKwId = nil
end

function slot0._fillKeyword(slot0, slot1)
	slot0._curStep:fillKeyword(slot1)
	slot0._storyMo:fillKeyword(slot1, slot0._curStep._index)
	slot0._keywordItems[slot1]:onRefresh()
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill)
end

function slot0._failFillKeyword(slot0, slot1)
	slot0._keywordItems[slot1]:clearUsing()
	slot0._curStep:failFillKeyword(slot1)
end

function slot0._isInCurStep(slot0)
	if slot0._curStep then
		if slot0:_getRectMatrix(slot0._dragKeywordItem.go, 0).right < slot0:_getRectMatrix(slot0._curStep._btnclick, 500).left or slot1.right < slot2.left or slot2.top < slot1.bottom or slot1.top < slot2.bottom then
			return false
		else
			return true
		end
	end
end

function slot0._getRectMatrix(slot0, slot1, slot2)
	slot3, slot4 = recthelper.rectToRelativeAnchorPos2(slot1.transform.position, slot0.viewGO.transform)

	return {
		left = slot3 - slot1.transform.rect.width * 0.5 - slot2,
		right = slot3 + slot1.transform.rect.width * 0.5 + slot2,
		top = slot4 + slot1.transform.rect.height * 0.5 + slot2,
		bottom = slot4 - slot1.transform.rect.height * 0.5 - slot2
	}
end

function slot0._closeKwPanel(slot0, slot1)
	if slot0._isCloseKePanel then
		return
	end

	slot0._isCloseKePanel = true

	slot0:_activeKeywordPanel(false)
	slot0._curStep:refreshFillStepState(false)
	slot0._viewAnim:Play(Activity165Enum.EditStepMoveAnim[slot1].Back, slot0.backKwPanelCB, slot0)
end

function slot0.backKwPanelCB(slot0)
	if slot0._storyMo:getState() == Activity165Enum.StoryStage.isEndFill then
		gohelper.setActive(slot0._btnconfirm.gameObject, true)
		slot0._btnconfirmAnim:Play(Activity165Enum.EditViewAnim.story_btn_open, 0, 1)
	end

	slot0._isCloseKePanel = false
end

function slot0.beginGenerateEnding(slot0)
	gohelper.setActive(slot0._btnconfirm.gameObject, false)
	gohelper.setActive(slot0._goending.gameObject, true)
	gohelper.setActive(slot0._btnreset.gameObject, false)

	slot0.isEndingAnim = true

	slot0:_showEnding()
	slot0._storyMo:generateStroy()
end

function slot0.generateEndingCallback(slot0)
end

function slot0._showDialog(slot0)
	if slot0:_getEndingCo() then
		slot2 = ResUrl.getHeadIconSmall("309901")
		slot0._txtdialog.text = slot1.text

		if not slot0._tmpFadeIn then
			slot0._tmpFadeIn = MonoHelper.addLuaComOnceToGo(gohelper.findChild(slot0._godialogcontainer, "#go_dialog/container"), TMPFadeIn)
		end

		slot0._tmpFadeIn:playNormalText(slot3)
		slot0._simagedialogicon:LoadImage(slot2)
		gohelper.setActive(slot0._godialogcontainer.gameObject, true)
	else
		slot0:_showAssessment()
	end
end

function slot0._showEnding(slot0)
	slot0:_killEndingTxtAnim()

	slot0._txtstory.text = ""

	if slot0.isEndingAnim then
		slot0._endAnim:Play(Activity165Enum.EditViewAnim.Play, nil, slot0)
		slot0:_doEndingText()
	else
		slot0:_showEndingCallBack()
	end

	if not slot0:_getEndingCo() then
		return
	end

	if not string.nilorempty(slot1.pic) then
		UISpriteSetMgr.instance:setV2a1Act165_2Sprite(slot0._simagepic, slot1.pic)
	end

	if not string.nilorempty(slot1.level) then
		UISpriteSetMgr.instance:setV2a1Act165_2Sprite(slot0._imageassessment, "v2a1_strangetale_assessment_" .. slot1.level)
		gohelper.setActive(slot0._goassessmentVX_s, slot1.level == Activity165Enum.EndingAssessment.S)
	end

	slot0._txtdec.text = slot1.text
end

function slot0._setEndingText(slot0)
	slot0._txtstory.text = slot0._storyMo:getEndingText()
end

function slot0._doEndingText(slot0)
	slot0._separateChars = Activity165Model.instance:setSeparateChars(slot0._storyMo:getEndingText())
	slot0._tweenTime = 0

	if not slot0._scrollEndingStory then
		slot0._scrollEndingStory = gohelper.findChildScrollRect(slot0.viewGO, "#go_ending/scroll_story")
	end

	slot2 = #slot0._separateChars
	slot0._tweenEndingId = ZProj.TweenHelper.DOTweenFloat(1, slot2, slot2 * 0.033, slot0._onTweenFrameCallback, slot0._showEndingCallBack, slot0, nil, EaseType.Linear)
end

function slot0._onTweenFrameCallback(slot0, slot1)
	if not slot0.isEndingAnim or slot1 - slot0._tweenTime < 1 then
		return
	end

	if slot0._separateChars and slot1 <= #slot0._separateChars then
		slot0._txtstory.text = slot0._separateChars[math.floor(slot1)]

		if slot0._scrollEndingStory.verticalNormalizedPosition ~= 0 then
			slot0._scrollEndingStory.verticalNormalizedPosition = 0
		end
	else
		slot0:_setEndingText()
	end

	slot0._tweenTime = slot1
end

function slot0._showEndingCallBack(slot0)
	slot0:_setEndingText()

	if slot0.isEndingAnim and slot0._storyMo:isShowDialog() then
		TaskDispatcher.runDelay(slot0._showDialog, slot0, 0.3)
	else
		slot0:_showAssessment()
	end

	slot0._isFinishPlayEnding = true
end

function slot0._getEndingCo(slot0)
	return slot0._storyMo:getEndingCo()
end

function slot0._showAssessment(slot0)
	gohelper.setActive(slot0._btnconfirm.gameObject, false)
	gohelper.setActive(slot0._goending.gameObject, true)
	gohelper.setActive(slot0._goassessment.gameObject, true)
	gohelper.setActive(slot0._btnreset.gameObject, false)
	gohelper.setActive(slot0._btnrestart.gameObject, not slot0.reviewEnding)
	gohelper.setActive(slot0._godragContainer.gameObject, false)
	slot0._assessmentAnim:Play(Activity165Enum.EditViewAnim.Play, nil, slot0)

	slot0.isEndingAnim = false

	if slot0._storyMo:getUnlockStepIdRemoveEndingCount() > 1 then
		gohelper.setActive(slot0._golocked, false)
	end
end

function slot0._playAssessmentAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_generate)
end

function slot0.onRefreshActivity(slot0, slot1)
	if slot1 == Activity165Model.instance:getActivityId() and not (ActivityHelper.getActivityStatusAndToast(slot1) == ActivityEnum.ActivityStatus.Normal) then
		slot0:closeThis()
		GameFacade.showToast(ToastEnum.ActivityEnd)
	end
end

function slot0.onClose(slot0)
	slot0._storyMo:setSelectStepIndex()
	slot0._storyMo:saveStepUseKeywords()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._restartStoryCallback, slot0)
	TaskDispatcher.cancelTask(slot0._showEndingCallBack, slot0)
	TaskDispatcher.cancelTask(slot0._hideExcessive, slot0)
	TaskDispatcher.cancelTask(slot0._showDialog, slot0)
	slot0._simagedialogicon:UnLoadImage()
	slot0._simagedialogbg:UnLoadImage()
	slot0:_killEndingTxtAnim()
end

function slot0._killEndingTxtAnim(slot0)
	if slot0._tweenEndingId then
		ZProj.TweenHelper.KillById(slot0._tweenEndingId)

		slot0._tweenEndingId = nil
	end
end

return slot0
