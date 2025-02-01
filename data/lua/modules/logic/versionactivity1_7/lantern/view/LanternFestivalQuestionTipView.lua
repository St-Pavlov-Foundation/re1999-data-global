module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalQuestionTipView", package.seeall)

slot0 = class("LanternFestivalQuestionTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._goanswer = gohelper.findChild(slot0.viewGO, "Root/#go_answer")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Root/#go_answer/Title/#txt_Title")
	slot0._txtanswerdescr = gohelper.findChildText(slot0.viewGO, "Root/#go_answer/Scroll View/Viewport/#txt_answerdescr")
	slot0._txtAnswer = gohelper.findChildText(slot0.viewGO, "Root/#go_answer/Anwser/#txt_Answer")
	slot0._imagePuzzlePic = gohelper.findChildImage(slot0.viewGO, "Root/#go_answer/#image_PuzzlePic")
	slot0._goquestion = gohelper.findChild(slot0.viewGO, "Root/#go_question")
	slot0._txtquestiontitle = gohelper.findChildText(slot0.viewGO, "Root/#go_question/Title/#txt_questiontitle")
	slot0._txtquestiondescr = gohelper.findChildText(slot0.viewGO, "Root/#go_question/Scroll View/Viewport/#txt_questiondescr")
	slot0._btnchoice1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#go_question/Layout/#btn_choice1")
	slot0._gonormalbg1 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice1/#go_normalbg1")
	slot0._gofalsebg1 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice1/#go_falsebg1")
	slot0._gotruebg1 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice1/#go_truebg1")
	slot0._gofalseicon1 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice1/Layout/#go_falseicon1")
	slot0._gotrueicon1 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice1/Layout/#go_trueicon1")
	slot0._txtchoice1 = gohelper.findChildText(slot0.viewGO, "Root/#go_question/Layout/#btn_choice1/Layout/#txt_choice1")
	slot0._btnchoice2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#go_question/Layout/#btn_choice2")
	slot0._gonormalbg2 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice2/#go_normalbg2")
	slot0._gofalsebg2 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice2/#go_falsebg2")
	slot0._gotruebg2 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice2/#go_truebg2")
	slot0._gofalseicon2 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice2/Layout/#go_falseicon2")
	slot0._gotrueicon2 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice2/Layout/#go_trueicon2")
	slot0._txtchoice2 = gohelper.findChildText(slot0.viewGO, "Root/#go_question/Layout/#btn_choice2/Layout/#txt_choice2")
	slot0._btnchoice3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#go_question/Layout/#btn_choice3")
	slot0._gonormalbg3 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice3/#go_normalbg3")
	slot0._gofalsebg3 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice3/#go_falsebg3")
	slot0._gotruebg3 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice3/#go_truebg3")
	slot0._gofalseicon3 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice3/Layout/#go_falseicon3")
	slot0._gotrueicon3 = gohelper.findChild(slot0.viewGO, "Root/#go_question/Layout/#btn_choice3/Layout/#go_trueicon3")
	slot0._txtchoice3 = gohelper.findChildText(slot0.viewGO, "Root/#go_question/Layout/#btn_choice3/Layout/#txt_choice3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnchoice1:AddClickListener(slot0._btnchoice1OnClick, slot0)
	slot0._btnchoice2:AddClickListener(slot0._btnchoice2OnClick, slot0)
	slot0._btnchoice3:AddClickListener(slot0._btnchoice3OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnchoice1:RemoveClickListener()
	slot0._btnchoice2:RemoveClickListener()
	slot0._btnchoice3:RemoveClickListener()
end

function slot0._btnchoice1OnClick(slot0)
	if LanternFestivalModel.instance:getPuzzleOptionState(slot0._puzzleId, 1) == LanternFestivalEnum.OptionState.Wrong then
		GameFacade.showToast(ToastEnum.Act1_7LanternFestivalSelectWrongTip)

		return
	elseif slot1 == LanternFestivalEnum.OptionState.Right then
		return
	end

	slot0:_clickChoice(1)
end

function slot0._btnchoice2OnClick(slot0)
	if LanternFestivalModel.instance:getPuzzleOptionState(slot0._puzzleId, 2) == LanternFestivalEnum.OptionState.Wrong then
		GameFacade.showToast(ToastEnum.Act1_7LanternFestivalSelectWrongTip)

		return
	elseif slot1 == LanternFestivalEnum.OptionState.Right then
		return
	end

	slot0:_clickChoice(2)
end

function slot0._btnchoice3OnClick(slot0)
	if LanternFestivalModel.instance:getPuzzleOptionState(slot0._puzzleId, 3) == LanternFestivalEnum.OptionState.Wrong then
		GameFacade.showToast(ToastEnum.Act1_7LanternFestivalSelectWrongTip)

		return
	elseif slot1 == LanternFestivalEnum.OptionState.Right then
		return
	end

	slot0:_clickChoice(3)
end

function slot0._clickChoice(slot0, slot1)
	if ActivityModel.instance:getActivityInfo()[ActivityEnum.Activity.LanternFestival] and slot3:isExpired() then
		ToastController.instance:showToast(ToastEnum.ActivityEnd)
		slot0:closeThis()

		return
	end

	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("waitShowResult")
	gohelper.setActive(slot0["_gonormalbg" .. slot1], false)

	slot4 = LanternFestivalConfig.instance:getAct154Co(slot2, slot0._day).answerId == slot1

	gohelper.setActive(slot0["_gofalseicon" .. slot1], not slot4)
	gohelper.setActive(slot0["_gotrueicon" .. slot1], slot4)
	gohelper.setActive(slot0["_gofalsebg" .. slot1], not slot4)
	gohelper.setActive(slot0["_gotruebg" .. slot1], slot4)
	slot0["_aniChoice" .. tostring(slot1)]:Play("open", 0, 0)

	slot0._curIndex = slot1

	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_checkpoint_continueappear)
	TaskDispatcher.runDelay(slot0._realSendAnswer, slot0, 0.5)
end

function slot0._realSendAnswer(slot0)
	UIBlockMgr.instance:endBlock("waitShowResult")

	slot0._newUnlockPuzzle = slot0._puzzleId

	Activity154Rpc.instance:sendAnswer154PuzzleRequest(ActivityEnum.Activity.LanternFestival, slot0._puzzleId, slot0._curIndex)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._puzzleId = slot0.viewParam.puzzleId
	slot0._day = slot0.viewParam.day
	slot0._curIndex = 0

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)

	slot0._aniChoice1 = gohelper.findChild(slot0._btnchoice1.gameObject, "Layout"):GetComponent(typeof(UnityEngine.Animator))
	slot0._aniChoice2 = gohelper.findChild(slot0._btnchoice2.gameObject, "Layout"):GetComponent(typeof(UnityEngine.Animator))
	slot0._aniChoice3 = gohelper.findChild(slot0._btnchoice3.gameObject, "Layout"):GetComponent(typeof(UnityEngine.Animator))
	slot0._viewAni = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_taskinterface)
	slot0:_refreshTip(false)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot0:_refreshTip()
		AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_jinye_answer_correct)
		slot0._viewAni:Play("open", 0, 0)
		UIBlockMgr.instance:startBlock("waitShowOpen")
		TaskDispatcher.runDelay(slot0._openFinished, slot0, 3)
	end
end

function slot0._openFinished(slot0)
	UIBlockMgr.instance:endBlock("waitShowOpen")
end

function slot0._refreshTip(slot0, slot1)
	if not LanternFestivalModel.instance:isPuzzleUnlock(slot0._puzzleId) then
		slot0:closeThis()

		return
	end

	if not slot1 then
		slot4 = LanternFestivalModel.instance:getPuzzleState(slot0._puzzleId) == LanternFestivalEnum.PuzzleState.RewardGet or slot3 == LanternFestivalEnum.PuzzleState.Solved
	end

	gohelper.setActive(slot0._goanswer, slot4)
	gohelper.setActive(slot0._goquestion, not slot4)

	if slot4 then
		slot0:_refreshAnswer()
	else
		slot0:_refreshQuestion()
	end
end

function slot0._refreshQuestion(slot0)
	slot1 = LanternFestivalConfig.instance:getAct154Co(nil, slot0._day)
	slot0._txtquestiontitle.text = slot1.puzzleTitle
	slot0._txtquestiondescr.text = slot1.puzzleDesc

	for slot6 = 1, 3 do
		gohelper.setActive(slot0["_gofalseicon" .. slot6], LanternFestivalModel.instance:getPuzzleOptionState(slot0._puzzleId, slot6) == LanternFestivalEnum.OptionState.Wrong)
		gohelper.setActive(slot0["_gotrueicon" .. slot6], slot7 == LanternFestivalEnum.OptionState.Right)
		gohelper.setActive(slot0["_gonormalbg" .. slot6], slot7 == LanternFestivalEnum.OptionState.UnAnswer)
		gohelper.setActive(slot0["_gofalsebg" .. slot6], slot7 == LanternFestivalEnum.OptionState.Wrong)
		gohelper.setActive(slot0["_gotruebg" .. slot6], slot7 == LanternFestivalEnum.OptionState.Right)

		slot0["_txtchoice" .. slot6].text = LanternFestivalConfig.instance:getAct154Options(slot0._puzzleId)[slot6].optionText
	end
end

function slot0._refreshAnswer(slot0)
	slot1 = LanternFestivalConfig.instance:getAct154Co(nil, slot0._day)
	slot0._txtTitle.text = slot1.puzzleTitle
	slot0._txtanswerdescr.text = slot1.puzzleDesc
	slot0._txtAnswer.text = LanternFestivalConfig.instance:getAct154Options(slot0._puzzleId)[LanternFestivalConfig.instance:getPuzzleCo(slot0._puzzleId).answerId].optionText

	UISpriteSetMgr.instance:setV1a7LanternSprite(slot0._imagePuzzlePic, LanternFestivalConfig.instance:getPuzzleCo(slot0._puzzleId).puzzleIcon)
end

function slot0.onClose(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)

	if slot0._newUnlockPuzzle and slot0._newUnlockPuzzle > 0 and LanternFestivalModel.instance:isPuzzleGiftGet(slot0._newUnlockPuzzle) then
		LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.ShowUnlockNewPuzzle, slot0._newUnlockPuzzle)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
