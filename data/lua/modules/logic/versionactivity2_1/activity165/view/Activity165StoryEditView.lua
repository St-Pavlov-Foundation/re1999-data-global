module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEditView", package.seeall)

local var_0_0 = class("Activity165StoryEditView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gostory = gohelper.findChild(arg_1_0.viewGO, "#go_story")
	arg_1_0._goending = gohelper.findChild(arg_1_0.viewGO, "#go_ending")
	arg_1_0._simagepic = gohelper.findChildImage(arg_1_0.viewGO, "#go_assessment/#simage_pic")
	arg_1_0._txtstory = gohelper.findChildText(arg_1_0.viewGO, "#go_ending/scroll_story/Viewport/#txt_story")
	arg_1_0._goassessment = gohelper.findChild(arg_1_0.viewGO, "#go_assessment")
	arg_1_0._imageassessment = gohelper.findChildImage(arg_1_0.viewGO, "#go_assessment/#image_assessment")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#go_assessment/scroll_dec/Viewport/#txt_dec")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_restart")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_story/#go_tips")
	arg_1_0._gokeywordpanel = gohelper.findChild(arg_1_0.viewGO, "#go_keywordpanel")
	arg_1_0._btnkeywordpanelclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_keywordpanel/#btn_close")
	arg_1_0._gokeywords = gohelper.findChild(arg_1_0.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords/#image_icon")
	arg_1_0._txtkeywords = gohelper.findChildText(arg_1_0.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords/#txt_keywords")
	arg_1_0._btnkeywords = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_keywordpanel/scroll_keywords/Viewport/Content/#go_keywords/#btn_keywords")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_keywordpanel/#btn_ok")
	arg_1_0._godragContainer = gohelper.findChild(arg_1_0.viewGO, "#go_dragContainer")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
	arg_2_0._btnkeywords:AddClickListener(arg_2_0._btnkeywordsOnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
	arg_2_0._btnkeywordpanelclose:AddClickListener(arg_2_0._btnkeywordpanelcloseOnClick, arg_2_0)
	arg_2_0:_addEvents()
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnkeywords:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
	arg_3_0._btnkeywordpanelclose:RemoveClickListener()
	arg_3_0:_removeEvents()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	arg_4_0:beginGenerateEnding()
end

function var_0_0._btnresetOnClick(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act165ResetEditor, MsgBoxEnum.BoxType.Yes_No, arg_5_0._restartStory, nil, nil, arg_5_0, nil)
end

function var_0_0._btnrestartOnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act165ResetEditor, MsgBoxEnum.BoxType.Yes_No, arg_6_0._restartStory, nil, nil, arg_6_0, nil)
end

function var_0_0._btndialogcontainerOnClick(arg_7_0)
	if arg_7_0.isEndingAnim then
		gohelper.setActive(arg_7_0._godialogcontainer.gameObject, false)
		arg_7_0:_showAssessment()
	end
end

function var_0_0._btnkeywordpanelcloseOnClick(arg_8_0)
	local var_8_0 = arg_8_0._storyMo:getSelectStepIndex()

	arg_8_0:_closeKwPanel(var_8_0)
end

function var_0_0._btnokOnClick(arg_9_0)
	local var_9_0 = arg_9_0._storyMo:getSelectStepIndex()

	if arg_9_0._storyMo:isFillingStep() then
		if var_9_0 and arg_9_0._curStep and (arg_9_0._storyMo:checkIsFinishStep() or arg_9_0._curStep:isNullKeyword()) then
			arg_9_0:_closeKwPanel(var_9_0)
		end
	else
		arg_9_0:_closeKwPanel(var_9_0)
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._goassessmentVX_s = gohelper.findChild(arg_10_0.viewGO, "#go_assessment/#vx_s")
	arg_10_0._godialogcontainer = gohelper.findChild(arg_10_0.viewGO, "#go_dialogcontainer")
	arg_10_0._btndialog = gohelper.getClick(arg_10_0._godialogcontainer)

	arg_10_0._btndialog:AddClickListener(arg_10_0._btndialogcontainerOnClick, arg_10_0)
	gohelper.setActive(arg_10_0._godialogcontainer.gameObject, false)

	arg_10_0._simagedialogicon = gohelper.findChildSingleImage(arg_10_0._godialogcontainer, "#go_dialog/container/headframe/headicon")
	arg_10_0._txtdialog = gohelper.findChildText(arg_10_0._godialogcontainer, "#go_dialog/container/go_normalcontent/txt_contentcn")
	arg_10_0._simagedialogbg = gohelper.findChildSingleImage(arg_10_0._godialogcontainer, "#go_dialog/container/simagebg")
	arg_10_0._keywordPanelAnim = SLFramework.AnimatorPlayer.Get(arg_10_0._gokeywordpanel.gameObject)
	arg_10_0._viewAnim = SLFramework.AnimatorPlayer.Get(arg_10_0.viewGO.gameObject)
	arg_10_0._btnconfirmAnim = arg_10_0._btnconfirm.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0._goexcessive = gohelper.findChild(arg_10_0.viewGO, "excessive")
	arg_10_0._endAnim = SLFramework.AnimatorPlayer.Get(arg_10_0._goending.gameObject)
	arg_10_0._assessmentAnim = SLFramework.AnimatorPlayer.Get(arg_10_0._goassessment.gameObject)
	arg_10_0._assessmentAnimEvent = arg_10_0._goassessment:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_10_0._assessmentAnimEvent:AddEventListener("PlayAudio", arg_10_0._playAssessmentAudio, arg_10_0)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0._btnclickOnClick(arg_12_0)
	if arg_12_0._isFinishPlayEnding then
		return
	end

	if arg_12_0._storyMo:getState() == Activity165Enum.StoryStage.Ending then
		if not arg_12_0._tweenEndingId then
			return
		end

		arg_12_0:_killEndingTxtAnim()
		arg_12_0:_showEndingCallBack()
	else
		if not arg_12_0._playerStepAnimIndex then
			return
		end

		local var_12_0 = arg_12_0._stepItemList[arg_12_0._playerStepAnimIndex]

		if not var_12_0 or not var_12_0._isUnlock then
			arg_12_0._playerStepAnimIndex = nil

			return
		end

		arg_12_0._playerStepAnimIndex = nil

		var_12_0:finishStoryAnim()
	end
end

function var_0_0._addEvents(arg_13_0)
	arg_13_0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, arg_13_0._Act165GetInfoReply, arg_13_0)
	arg_13_0:addEventCb(Activity165Controller.instance, Activity165Event.Act165RestartReply, arg_13_0._Act165RestartReply, arg_13_0)
	arg_13_0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, arg_13_0._Act165GenerateEndingReply, arg_13_0)
	arg_13_0:addEventCb(Activity165Controller.instance, Activity165Event.Act165ModifyKeywordReply, arg_13_0._Act165ModifyKeywordReply, arg_13_0)
	arg_13_0:addEventCb(Activity165Controller.instance, Activity165Event.onClickStepBtn, arg_13_0._onClickStepBtn, arg_13_0)
	arg_13_0:addEventCb(Activity165Controller.instance, Activity165Event.OnFinishStep, arg_13_0._OnFinishStep, arg_13_0)
	arg_13_0:addEventCb(Activity165Controller.instance, Activity165Event.onClickUsedKeyword, arg_13_0._onClickUsedKeyword, arg_13_0)
	arg_13_0:addEventCb(Activity165Controller.instance, Activity165Event.canfinishStory, arg_13_0._canfinishStory, arg_13_0)
	arg_13_0:addEventCb(Activity165Controller.instance, Activity165Event.refrshEditView, arg_13_0.onRefresh, arg_13_0)
	arg_13_0:addEventCb(Activity165Controller.instance, Activity165Event.finishStepAnim, arg_13_0._finishStepAnim, arg_13_0)
	arg_13_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_13_0.onRefreshActivity, arg_13_0)
end

function var_0_0._removeEvents(arg_14_0)
	arg_14_0._btnclick:RemoveClickListener()

	if arg_14_0._btndialog then
		arg_14_0._btndialog:RemoveClickListener()
	end

	arg_14_0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, arg_14_0._Act165GetInfoReply, arg_14_0)
	arg_14_0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165RestartReply, arg_14_0._Act165RestartReply, arg_14_0)
	arg_14_0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, arg_14_0._Act165GenerateEndingReply, arg_14_0)
	arg_14_0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165ModifyKeywordReply, arg_14_0._Act165ModifyKeywordReply, arg_14_0)
	arg_14_0:removeEventCb(Activity165Controller.instance, Activity165Event.onClickStepBtn, arg_14_0._onClickStepBtn, arg_14_0)
	arg_14_0:removeEventCb(Activity165Controller.instance, Activity165Event.OnFinishStep, arg_14_0._OnFinishStep, arg_14_0)
	arg_14_0:removeEventCb(Activity165Controller.instance, Activity165Event.onClickUsedKeyword, arg_14_0._onClickUsedKeyword, arg_14_0)
	arg_14_0:removeEventCb(Activity165Controller.instance, Activity165Event.canfinishStory, arg_14_0._canfinishStory, arg_14_0)
	arg_14_0:removeEventCb(Activity165Controller.instance, Activity165Event.refrshEditView, arg_14_0.onRefresh, arg_14_0)
	arg_14_0:removeEventCb(Activity165Controller.instance, Activity165Event.finishStepAnim, arg_14_0._finishStepAnim, arg_14_0)
	arg_14_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_14_0.onRefreshActivity, arg_14_0)
	arg_14_0._assessmentAnimEvent:RemoveEventListener("PlayAudio")
end

function var_0_0._onClickStepBtn(arg_15_0, arg_15_1)
	if arg_15_0._storyMo:getSelectStepIndex() then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._stepItemList) do
		if iter_15_1:isPlayingTxt() then
			return
		end
	end

	local var_15_0 = arg_15_0._stepItemList[arg_15_1]

	arg_15_0._storyMo:setSelectStepIndex(arg_15_1)
	var_15_0:refreshFillStepState()

	if arg_15_0._curStep then
		arg_15_0._curStep:refreshFillStepState()
	end

	arg_15_0._curStep = var_15_0

	arg_15_0:_refreshKeywordItem()
	arg_15_0:_activeKeywordPanel(true)

	local var_15_1 = Activity165Enum.EditStepMoveAnim[arg_15_1].Move

	arg_15_0._viewAnim:Play(var_15_1, nil, arg_15_0)

	if arg_15_0._storyMo:getState() == Activity165Enum.StoryStage.isEndFill then
		gohelper.setActive(arg_15_0._btnconfirm.gameObject, false)
	end
end

function var_0_0._OnFinishStep(arg_16_0, arg_16_1)
	arg_16_0._curfinishStep = arg_16_1

	if LuaUtil.tableNotEmpty(arg_16_1) then
		arg_16_0:_onFinishStepItem(1)
	end
end

function var_0_0._onFinishStepItem(arg_17_0, arg_17_1)
	arg_17_0._finishStepIndex = arg_17_1

	if arg_17_1 > #arg_17_0._curfinishStep then
		return
	end

	local var_17_0 = arg_17_0._storyMo:unlockStepCount() - #arg_17_0._curfinishStep + arg_17_1 - 1

	arg_17_0._playerStepAnimIndex = var_17_0

	if var_17_0 == 3 then
		gohelper.setActive(arg_17_0._golocked, true)
		arg_17_0._lockRightAnim:Play(Activity165Enum.EditViewAnim.Unlock, arg_17_0._hideLockRight, arg_17_0)
	end

	local var_17_1 = arg_17_0._curfinishStep[arg_17_1]
	local var_17_2 = arg_17_0._storyMo:getStepMo(var_17_1)

	if var_17_2 and var_17_2.isEndingStep then
		return
	end

	arg_17_0._stepItemList[var_17_0]:onFinishStep(var_17_1)
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill_win)
end

function var_0_0._hideLockRight(arg_18_0)
	gohelper.setActive(arg_18_0._golocked, false)
end

function var_0_0._canfinishStory(arg_19_0)
	arg_19_0:_activeKeywordPanel(false)
	arg_19_0:_onRefreshStoryState()
	arg_19_0:_refreshTip()
end

function var_0_0._finishStepAnim(arg_20_0)
	if arg_20_0._finishStepIndex > #arg_20_0._curfinishStep then
		arg_20_0._playerStepAnimIndex = nil

		return
	end

	if arg_20_0._storyMo:getState() ~= Activity165Enum.StoryStage.Filling then
		return
	end

	local var_20_0 = arg_20_0._curfinishStep[arg_20_0._finishStepIndex]
	local var_20_1 = arg_20_0._storyMo:getStepMo(var_20_0)

	if var_20_1 and var_20_1.isEndingStep then
		arg_20_0._storyMo:finishStroy()

		arg_20_0._playerStepAnimIndex = nil

		return
	end

	local var_20_2 = arg_20_0._storyMo:unlockStepCount() - #arg_20_0._curfinishStep + arg_20_0._finishStepIndex
	local var_20_3 = arg_20_0._stepItemList[var_20_2]
	local var_20_4 = arg_20_0._curfinishStep[arg_20_0._finishStepIndex + 1]
	local var_20_5 = arg_20_0._storyMo:getStepMo(var_20_4)

	if var_20_5 and var_20_5.isEndingStep then
		arg_20_0._storyMo:finishStroy()

		arg_20_0._playerStepAnimIndex = nil

		return
	end

	var_20_3:onUpdateMO(var_20_4)

	if arg_20_0._finishStepIndex + 1 >= #arg_20_0._curfinishStep then
		var_20_3:showEgLock()
	end

	arg_20_0:_onFinishStepItem(arg_20_0._finishStepIndex + 1)
end

function var_0_0._onClickUsedKeyword(arg_21_0, arg_21_1)
	if arg_21_0._isDraging or not arg_21_0._storyMo.curStepIndex then
		return
	end

	arg_21_0._clickKwId = arg_21_1

	local var_21_0 = arg_21_0._storyMo:getKeywordMo(arg_21_1)

	arg_21_0:checkKeyword()

	if arg_21_0._storyMo:isFillingStep() then
		if var_21_0.isUsed then
			if arg_21_0._curStep and arg_21_0._curStep:isKeyword(arg_21_1) then
				arg_21_0._storyMo:removeUseKeywords(arg_21_1)
				arg_21_0._curStep:removeKeywordItem(arg_21_1)
			end
		else
			arg_21_0:_tryFillKeyword(arg_21_1, true)
		end
	elseif var_21_0.isUsed or arg_21_0._curStep:tryFillKeyword() then
		GameFacade.showMessageBox(MessageBoxIdDefine.Act165ResetStep, MsgBoxEnum.BoxType.Yes_No, arg_21_0._onclickPreStepYesCallback, nil, nil, arg_21_0)
	end
end

function var_0_0._Act165GetInfoReply(arg_22_0)
	arg_22_0:_refreshStep()
end

function var_0_0._Act165RestartReply(arg_23_0, arg_23_1)
	if arg_23_0._clickKwId then
		arg_23_0:_onClickUsedKeyword(arg_23_0._clickKwId)
	end

	arg_23_0:onRefresh()

	arg_23_0._clickKwId = nil
end

function var_0_0._Act165GenerateEndingReply(arg_24_0, arg_24_1)
	return
end

function var_0_0._Act165ModifyKeywordReply(arg_25_0, arg_25_1)
	arg_25_0:_refreshKeywordItem()
end

function var_0_0.onOpen(arg_26_0)
	arg_26_0._actId = Activity165Model.instance:getActivityId()
	arg_26_0._storyId = arg_26_0.viewParam.storyId
	arg_26_0.reviewEnding = arg_26_0.viewParam.reviewEnding
	arg_26_0._storyMo = Activity165Model.instance:getStoryMo(arg_26_0._actId, arg_26_0._storyId)

	arg_26_0._storyMo:setReviewEnding(arg_26_0.reviewEnding)

	arg_26_0._clickKwId = nil

	arg_26_0:_createStoryGo()

	arg_26_0.isEndingAnim = false
	arg_26_0._isCloseKePanel = false

	arg_26_0:_onRefreshStoryState()
	arg_26_0:_activeKeywordPanel(false)
	gohelper.setActive(arg_26_0._goexcessive.gameObject, false)
	arg_26_0:_refreshTip()

	arg_26_0._isFinishPlayEnding = false

	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_enter)
end

function var_0_0.onRefresh(arg_27_0)
	arg_27_0:_onRefreshStoryState()
	arg_27_0:_refreshStep()
	arg_27_0:_refreshKeywordItem()
end

function var_0_0._onRefreshStoryState(arg_28_0)
	local var_28_0 = arg_28_0._storyMo:getState()
	local var_28_1 = var_28_0 == Activity165Enum.StoryStage.isEndFill
	local var_28_2 = var_28_0 == Activity165Enum.StoryStage.Ending

	if var_28_1 or var_28_2 then
		local var_28_3 = arg_28_0._storyMo:getUnlockStepIdRemoveEndingCount()
		local var_28_4 = math.min(#arg_28_0._stepItemList, var_28_3)
		local var_28_5 = arg_28_0._stepItemList[var_28_4 + 1]
		local var_28_6 = var_28_4 > 1 and 324 or -484
		local var_28_7 = var_28_5 and var_28_5.goParent.transform.localPosition.y or -200

		recthelper.setAnchor(arg_28_0._btnconfirm.transform, var_28_6, var_28_7)
		recthelper.setAnchor(arg_28_0._goending.transform, var_28_6, var_28_7 - 100)
		recthelper.setAnchor(arg_28_0._goassessment.transform, var_28_6, var_28_7 - 240)

		if arg_28_0._storyMo:getUnlockStepIdRemoveEndingCount() > 1 then
			gohelper.setActive(arg_28_0._golocked, false)
		end
	end

	gohelper.setActive(arg_28_0._btnconfirm.gameObject, var_28_1)
	gohelper.setActive(arg_28_0._goending.gameObject, var_28_2)
	gohelper.setActive(arg_28_0._goassessment.gameObject, var_28_2)
	gohelper.setActive(arg_28_0._btnreset.gameObject, not var_28_2)
	gohelper.setActive(arg_28_0._btnrestart.gameObject, var_28_2 and not arg_28_0.reviewEnding)

	if var_28_2 then
		arg_28_0:_showEnding()
	end
end

function var_0_0._createStoryGo(arg_29_0)
	local var_29_0 = arg_29_0.viewContainer:getSetting().otherRes[1]
	local var_29_1 = gohelper.findChild(arg_29_0._gostory, "story")

	arg_29_0._storyItem = arg_29_0:getResInst(var_29_0, var_29_1, "story_" .. arg_29_0._storyId)
	arg_29_0._golocked = gohelper.findChild(arg_29_0._storyItem, "#go_point/#go_locked")
	arg_29_0._lockRightAnim = SLFramework.AnimatorPlayer.Get(arg_29_0._golocked.gameObject)
	arg_29_0._btnclick = gohelper.findChildButtonWithAudio(arg_29_0._storyItem, "#btn_click")

	arg_29_0._btnclick:AddClickListener(arg_29_0._btnclickOnClick, arg_29_0)

	arg_29_0._storyAnim = SLFramework.AnimatorPlayer.Get(arg_29_0._storyItem.gameObject)

	local var_29_2 = gohelper.findChildText(arg_29_0._storyItem, "#txt_title")
	local var_29_3 = gohelper.findChildText(arg_29_0._storyItem, "begin/scroll_story/Viewport/#txt_dec")
	local var_29_4 = gohelper.findChildImage(arg_29_0._storyItem, "begin/icon/#image_icon")
	local var_29_5 = gohelper.findChildScrollRect(arg_29_0._storyItem, "begin/scroll_story")

	if arg_29_0._storyMo then
		var_29_2.text = arg_29_0._storyMo:getStoryName(76)

		local var_29_6 = arg_29_0._storyMo:getStoryFirstStepMo()

		var_29_3.text = var_29_6 and var_29_6.stepCo.text

		local var_29_7 = var_29_6 and var_29_6.stepCo.pic

		if not string.nilorempty(var_29_7) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(var_29_4, var_29_7, true)
		end

		arg_29_0:_createStepList()
	end

	var_29_5.verticalNormalizedPosition = 1
end

function var_0_0._createStepList(arg_30_0)
	local var_30_0 = gohelper.findChild(arg_30_0._storyItem, "#go_point/eg")
	local var_30_1 = gohelper.findChild(var_30_0, "#go_eg")

	gohelper.setActive(var_30_1.gameObject, false)

	local var_30_2 = gohelper.findChild(arg_30_0._storyItem, "#go_point/point")
	local var_30_3 = var_30_2.transform.childCount

	gohelper.setActive(var_30_0, false)

	arg_30_0._stepItemList = arg_30_0:getUserDataTb_()

	for iter_30_0 = 1, var_30_3 do
		local var_30_4 = gohelper.findChild(var_30_2, iter_30_0)
		local var_30_5 = gohelper.clone(var_30_1, var_30_4)
		local var_30_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_30_5, Activity165StepItem)

		var_30_6.goParent = var_30_4

		var_30_6:onInitItem(arg_30_0._storyMo, iter_30_0)
		gohelper.setActive(var_30_5.gameObject, true)

		arg_30_0._stepItemList[iter_30_0] = var_30_6
	end

	arg_30_0:_refreshStep()
end

function var_0_0._refreshStep(arg_31_0)
	local var_31_0 = arg_31_0._storyMo:getUnlockStepIdRemoveEnding()

	for iter_31_0, iter_31_1 in pairs(arg_31_0._stepItemList) do
		iter_31_1:onUpdateMO(var_31_0[iter_31_0])
	end

	local var_31_1 = arg_31_0._storyMo:getUnlockStepIdRemoveEndingCount()

	gohelper.setActive(arg_31_0._golocked, var_31_1 < 3)

	if var_31_1 < 3 then
		arg_31_0._lockRightAnim:Play(Activity165Enum.EditViewAnim.Idle, nil, arg_31_0)
	end
end

function var_0_0._refreshTip(arg_32_0)
	return
end

function var_0_0._restartStory(arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._restartStoryCallback, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._hideExcessive, arg_33_0)
	gohelper.setActive(arg_33_0._goexcessive.gameObject, true)
	TaskDispatcher.runDelay(arg_33_0._restartStoryCallback, arg_33_0, 0.5)
	TaskDispatcher.runDelay(arg_33_0._hideExcessive, arg_33_0, 1)

	arg_33_0._isFinishPlayEnding = false
end

function var_0_0._restartStoryCallback(arg_34_0)
	gohelper.setActive(arg_34_0._godialogcontainer.gameObject, false)
	arg_34_0._storyMo:onRestart()
	Activity165Rpc.instance:sendAct165RestartRequest(arg_34_0._actId, arg_34_0._storyId, arg_34_0._storyMo:getFirstStepId())
end

function var_0_0._hideExcessive(arg_35_0)
	gohelper.setActive(arg_35_0._goexcessive.gameObject, false)
end

function var_0_0._onclickPreStepYesCallback(arg_36_0)
	arg_36_0._storyMo:resetStep()

	if arg_36_0._storyMo.curStepInde then
		for iter_36_0 = arg_36_0._storyMo.curStepIndex + 1, #arg_36_0._stepItemList do
			arg_36_0._stepItemList[iter_36_0]:clearStep()
		end
	end

	arg_36_0._curStep:onRefreshMo()

	local var_36_0 = arg_36_0._storyMo:getUnlockStepIdRemoveEndingCount()

	gohelper.setActive(arg_36_0._golocked, var_36_0 < 3)
end

function var_0_0.playCloseAnim(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0._storyAnim then
		arg_37_0._storyAnim:Play(Activity165Enum.EditViewAnim.Close, arg_37_1, arg_37_2)

		if arg_37_0._goending.activeSelf then
			arg_37_0._endAnim:Play(Activity165Enum.EditViewAnim.Close, nil, arg_37_0)
		end

		if arg_37_0._goassessment.activeSelf then
			arg_37_0._assessmentAnim:Play(Activity165Enum.EditViewAnim.Close, nil, arg_37_0)
		end

		arg_37_0._viewAnim:Play(Activity165Enum.EditViewAnim.Close, nil, arg_37_0)
	elseif arg_37_1 then
		arg_37_1(arg_37_2)
	end
end

function var_0_0._refreshKeywordItem(arg_38_0)
	if arg_38_0._storyMo then
		arg_38_0._keywordItems = arg_38_0:getUserDataTb_()

		local var_38_0 = arg_38_0._storyMo:getKeywordList()

		gohelper.CreateObjList(arg_38_0, arg_38_0._createKeywordCallback, var_38_0, arg_38_0._gokeywords.transform.parent.gameObject, arg_38_0._gokeywords, Activity165KeywordItem)
	end

	arg_38_0:_refreshKeywordPanel()
end

function var_0_0._createKeywordCallback(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	arg_39_1:onUpdateMO(arg_39_2)
	arg_39_1:setDragEvent(arg_39_0._onDragBegin, arg_39_0._onDrag, arg_39_0._onDragEnd, arg_39_0)

	arg_39_0._keywordItems[arg_39_2.keywordId] = arg_39_1
end

function var_0_0._activeKeywordPanel(arg_40_0, arg_40_1)
	if not arg_40_1 then
		arg_40_0._storyMo:setSelectStepIndex()

		for iter_40_0, iter_40_1 in pairs(arg_40_0._stepItemList) do
			iter_40_1:refreshFillStepState()
		end
	end

	local var_40_0 = arg_40_1 and Activity165Enum.EditViewAnim.Open or Activity165Enum.EditViewAnim.Close

	local function var_40_1()
		if not arg_40_1 then
			gohelper.setActive(arg_40_0._gokeywordpanel, false)
			gohelper.setActive(arg_40_0._gotopleft, true)
		end
	end

	if arg_40_1 then
		gohelper.setActive(arg_40_0._gokeywordpanel, true)
		gohelper.setActive(arg_40_0._gotopleft, false)
	end

	if arg_40_0._gokeywordpanel.activeSelf then
		arg_40_0._keywordPanelAnim:Play(var_40_0, var_40_1, arg_40_0)
	end
end

function var_0_0._refreshKeywordPanel(arg_42_0)
	for iter_42_0, iter_42_1 in pairs(arg_42_0._keywordItems) do
		iter_42_1:onRefresh()
	end
end

function var_0_0._onDragBegin(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_0._isDraging then
		return
	end

	local var_43_0 = arg_43_1
	local var_43_1 = arg_43_0._storyMo:getKeywordMo(var_43_0)

	if not var_43_1 or var_43_1.isUsed then
		return
	end

	if arg_43_0._curStep and arg_43_0._curStep:isFullKeyword() then
		return
	end

	arg_43_0:checkKeyword()
	gohelper.setActive(arg_43_0._godragContainer.gameObject, true)

	arg_43_0._isDraging = true

	local var_43_2 = arg_43_0:_getDragKeywordItem()

	if var_43_2 then
		var_43_2.id = var_43_0

		local var_43_3 = Activity165Config.instance:getKeywordCo(arg_43_0._actId, var_43_0)

		if not string.nilorempty(var_43_3.pic) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(arg_43_0._dragKeywordItem.icon, var_43_3.pic)
		end

		gohelper.setActive(arg_43_0._dragKeywordItem.go, true)
		arg_43_0._keywordItems[var_43_0]:Using()
	end

	arg_43_0:_setDragItemPos()
end

function var_0_0.checkKeyword(arg_44_0)
	if not arg_44_0._curStep then
		return
	end

	local var_44_0 = arg_44_0._curStep._keywordIdList

	for iter_44_0, iter_44_1 in ipairs(arg_44_0._storyMo:getKeywordList()) do
		if iter_44_1.isUsed then
			local var_44_1 = iter_44_1.keywordId

			if not LuaUtil.tableContains(var_44_0, var_44_1) then
				arg_44_0._curStep:addKeywordItem(var_44_1)
			end
		end
	end
end

function var_0_0._onDrag(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_0._isDraging then
		return
	end

	arg_45_0:_setDragItemPos()

	if arg_45_0:_isInCurStep() then
		arg_45_0._curStep:setBogusKeyword(arg_45_0._dragKeywordItem.id)
	else
		arg_45_0._curStep:refreshBogusKeyword()
	end
end

function var_0_0._onDragEndEvent(arg_46_0)
	arg_46_0._isDraging = false

	arg_46_0._curStep:cancelBogusKeyword()

	local var_46_0 = arg_46_0:_isInCurStep() and arg_46_0._dragKeywordItem

	arg_46_0:_tryFillKeyword(arg_46_0._dragKeywordItem.id, var_46_0)
	gohelper.setActive(arg_46_0._dragKeywordItem.go, false)
end

function var_0_0._onDragEnd(arg_47_0, arg_47_1, arg_47_2)
	if not arg_47_0._isDraging then
		return
	end

	arg_47_0:_onDragEndEvent()
end

function var_0_0._setDragItemPos(arg_48_0)
	if arg_48_0._dragKeywordItem then
		local var_48_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_48_0._godragContainer.transform)

		recthelper.setAnchor(arg_48_0._dragKeywordItem.go.transform, var_48_0.x, var_48_0.y)
	end
end

function var_0_0._getDragKeywordItem(arg_49_0)
	if not arg_49_0._dragKeywordItem then
		local var_49_0 = gohelper.findChild(arg_49_0._gokeywords, "#image_icon")
		local var_49_1 = gohelper.clone(var_49_0, arg_49_0._godragContainer, "dragItem")

		arg_49_0._dragKeywordItem = {}
		arg_49_0._dragKeywordItem.go = var_49_1
		arg_49_0._dragKeywordItem.icon = var_49_1:GetComponent(typeof(UnityEngine.UI.Image))
	end

	return arg_49_0._dragKeywordItem
end

function var_0_0._tryFillKeyword(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_2 and arg_50_0._curStep:tryFillKeyword(arg_50_1) then
		arg_50_0:_fillKeyword(arg_50_1)
	else
		arg_50_0:_failFillKeyword(arg_50_1)
	end

	arg_50_0._clickKwId = nil
end

function var_0_0._fillKeyword(arg_51_0, arg_51_1)
	arg_51_0._curStep:fillKeyword(arg_51_1)
	arg_51_0._storyMo:fillKeyword(arg_51_1, arg_51_0._curStep._index)
	arg_51_0._keywordItems[arg_51_1]:onRefresh()
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill)
end

function var_0_0._failFillKeyword(arg_52_0, arg_52_1)
	arg_52_0._keywordItems[arg_52_1]:clearUsing()
	arg_52_0._curStep:failFillKeyword(arg_52_1)
end

function var_0_0._isInCurStep(arg_53_0)
	if arg_53_0._curStep then
		local var_53_0 = arg_53_0:_getRectMatrix(arg_53_0._curStep._btnclick, 500)
		local var_53_1 = arg_53_0:_getRectMatrix(arg_53_0._dragKeywordItem.go, 0)

		if var_53_0.left > var_53_1.right or var_53_1.left > var_53_0.right or var_53_0.bottom > var_53_1.top or var_53_1.bottom > var_53_0.top then
			return false
		else
			return true
		end
	end
end

function var_0_0._getRectMatrix(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0, var_54_1 = recthelper.rectToRelativeAnchorPos2(arg_54_1.transform.position, arg_54_0.viewGO.transform)

	return {
		left = var_54_0 - arg_54_1.transform.rect.width * 0.5 - arg_54_2,
		right = var_54_0 + arg_54_1.transform.rect.width * 0.5 + arg_54_2,
		top = var_54_1 + arg_54_1.transform.rect.height * 0.5 + arg_54_2,
		bottom = var_54_1 - arg_54_1.transform.rect.height * 0.5 - arg_54_2
	}
end

function var_0_0._closeKwPanel(arg_55_0, arg_55_1)
	if arg_55_0._isCloseKePanel then
		return
	end

	arg_55_0._isCloseKePanel = true

	arg_55_0:_activeKeywordPanel(false)
	arg_55_0._curStep:refreshFillStepState(false)

	local var_55_0 = Activity165Enum.EditStepMoveAnim[arg_55_1].Back

	arg_55_0._viewAnim:Play(var_55_0, arg_55_0.backKwPanelCB, arg_55_0)
end

function var_0_0.backKwPanelCB(arg_56_0)
	if arg_56_0._storyMo:getState() == Activity165Enum.StoryStage.isEndFill then
		gohelper.setActive(arg_56_0._btnconfirm.gameObject, true)
		arg_56_0._btnconfirmAnim:Play(Activity165Enum.EditViewAnim.story_btn_open, 0, 1)
	end

	arg_56_0._isCloseKePanel = false
end

function var_0_0.beginGenerateEnding(arg_57_0)
	gohelper.setActive(arg_57_0._btnconfirm.gameObject, false)
	gohelper.setActive(arg_57_0._goending.gameObject, true)
	gohelper.setActive(arg_57_0._btnreset.gameObject, false)

	arg_57_0.isEndingAnim = true

	arg_57_0:_showEnding()
	arg_57_0._storyMo:generateStroy()
end

function var_0_0.generateEndingCallback(arg_58_0)
	return
end

function var_0_0._showDialog(arg_59_0)
	local var_59_0 = arg_59_0:_getEndingCo()

	if var_59_0 then
		local var_59_1 = ResUrl.getHeadIconSmall("309901")
		local var_59_2 = var_59_0.text

		arg_59_0._txtdialog.text = var_59_2

		if not arg_59_0._tmpFadeIn then
			local var_59_3 = gohelper.findChild(arg_59_0._godialogcontainer, "#go_dialog/container")

			arg_59_0._tmpFadeIn = MonoHelper.addLuaComOnceToGo(var_59_3, TMPFadeIn)
		end

		arg_59_0._tmpFadeIn:playNormalText(var_59_2)
		arg_59_0._simagedialogicon:LoadImage(var_59_1)
		gohelper.setActive(arg_59_0._godialogcontainer.gameObject, true)
	else
		arg_59_0:_showAssessment()
	end
end

function var_0_0._showEnding(arg_60_0)
	arg_60_0:_killEndingTxtAnim()

	arg_60_0._txtstory.text = ""

	if arg_60_0.isEndingAnim then
		arg_60_0._endAnim:Play(Activity165Enum.EditViewAnim.Play, nil, arg_60_0)
		arg_60_0:_doEndingText()
	else
		arg_60_0:_showEndingCallBack()
	end

	local var_60_0 = arg_60_0:_getEndingCo()

	if not var_60_0 then
		return
	end

	if not string.nilorempty(var_60_0.pic) then
		UISpriteSetMgr.instance:setV2a1Act165_2Sprite(arg_60_0._simagepic, var_60_0.pic)
	end

	if not string.nilorempty(var_60_0.level) then
		local var_60_1 = "v2a1_strangetale_assessment_" .. var_60_0.level

		UISpriteSetMgr.instance:setV2a1Act165_2Sprite(arg_60_0._imageassessment, var_60_1)

		local var_60_2 = var_60_0.level == Activity165Enum.EndingAssessment.S

		gohelper.setActive(arg_60_0._goassessmentVX_s, var_60_2)
	end

	arg_60_0._txtdec.text = var_60_0.text
end

function var_0_0._setEndingText(arg_61_0)
	arg_61_0._txtstory.text = arg_61_0._storyMo:getEndingText()
end

function var_0_0._doEndingText(arg_62_0)
	local var_62_0 = arg_62_0._storyMo:getEndingText()

	arg_62_0._separateChars = Activity165Model.instance:setSeparateChars(var_62_0)
	arg_62_0._tweenTime = 0

	if not arg_62_0._scrollEndingStory then
		arg_62_0._scrollEndingStory = gohelper.findChildScrollRect(arg_62_0.viewGO, "#go_ending/scroll_story")
	end

	local var_62_1 = #arg_62_0._separateChars
	local var_62_2 = var_62_1 * 0.033

	arg_62_0._tweenEndingId = ZProj.TweenHelper.DOTweenFloat(1, var_62_1, var_62_2, arg_62_0._onTweenFrameCallback, arg_62_0._showEndingCallBack, arg_62_0, nil, EaseType.Linear)
end

function var_0_0._onTweenFrameCallback(arg_63_0, arg_63_1)
	if not arg_63_0.isEndingAnim or arg_63_1 - arg_63_0._tweenTime < 1 then
		return
	end

	if arg_63_0._separateChars and arg_63_1 <= #arg_63_0._separateChars then
		local var_63_0 = math.floor(arg_63_1)

		arg_63_0._txtstory.text = arg_63_0._separateChars[var_63_0]

		if arg_63_0._scrollEndingStory.verticalNormalizedPosition ~= 0 then
			arg_63_0._scrollEndingStory.verticalNormalizedPosition = 0
		end
	else
		arg_63_0:_setEndingText()
	end

	arg_63_0._tweenTime = arg_63_1
end

function var_0_0._showEndingCallBack(arg_64_0)
	arg_64_0:_setEndingText()

	if arg_64_0.isEndingAnim and arg_64_0._storyMo:isShowDialog() then
		TaskDispatcher.runDelay(arg_64_0._showDialog, arg_64_0, 0.3)
	else
		arg_64_0:_showAssessment()
	end

	arg_64_0._isFinishPlayEnding = true
end

function var_0_0._getEndingCo(arg_65_0)
	return (arg_65_0._storyMo:getEndingCo())
end

function var_0_0._showAssessment(arg_66_0)
	gohelper.setActive(arg_66_0._btnconfirm.gameObject, false)
	gohelper.setActive(arg_66_0._goending.gameObject, true)
	gohelper.setActive(arg_66_0._goassessment.gameObject, true)
	gohelper.setActive(arg_66_0._btnreset.gameObject, false)
	gohelper.setActive(arg_66_0._btnrestart.gameObject, not arg_66_0.reviewEnding)
	gohelper.setActive(arg_66_0._godragContainer.gameObject, false)
	arg_66_0._assessmentAnim:Play(Activity165Enum.EditViewAnim.Play, nil, arg_66_0)

	arg_66_0.isEndingAnim = false

	if arg_66_0._storyMo:getUnlockStepIdRemoveEndingCount() > 1 then
		gohelper.setActive(arg_66_0._golocked, false)
	end
end

function var_0_0._playAssessmentAudio(arg_67_0)
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_generate)
end

function var_0_0.onRefreshActivity(arg_68_0, arg_68_1)
	if arg_68_1 == Activity165Model.instance:getActivityId() and not (ActivityHelper.getActivityStatusAndToast(arg_68_1) == ActivityEnum.ActivityStatus.Normal) then
		arg_68_0:closeThis()
		GameFacade.showToast(ToastEnum.ActivityEnd)
	end
end

function var_0_0.onClose(arg_69_0)
	arg_69_0._storyMo:setSelectStepIndex()
	arg_69_0._storyMo:saveStepUseKeywords()
end

function var_0_0.onDestroyView(arg_70_0)
	TaskDispatcher.cancelTask(arg_70_0._restartStoryCallback, arg_70_0)
	TaskDispatcher.cancelTask(arg_70_0._showEndingCallBack, arg_70_0)
	TaskDispatcher.cancelTask(arg_70_0._hideExcessive, arg_70_0)
	TaskDispatcher.cancelTask(arg_70_0._showDialog, arg_70_0)
	arg_70_0._simagedialogicon:UnLoadImage()
	arg_70_0._simagedialogbg:UnLoadImage()
	arg_70_0:_killEndingTxtAnim()
end

function var_0_0._killEndingTxtAnim(arg_71_0)
	if arg_71_0._tweenEndingId then
		ZProj.TweenHelper.KillById(arg_71_0._tweenEndingId)

		arg_71_0._tweenEndingId = nil
	end
end

return var_0_0
