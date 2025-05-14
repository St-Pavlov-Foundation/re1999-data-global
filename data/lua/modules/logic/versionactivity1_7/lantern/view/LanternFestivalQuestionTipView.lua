module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalQuestionTipView", package.seeall)

local var_0_0 = class("LanternFestivalQuestionTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._goanswer = gohelper.findChild(arg_1_0.viewGO, "Root/#go_answer")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_answer/Title/#txt_Title")
	arg_1_0._txtanswerdescr = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_answer/Scroll View/Viewport/#txt_answerdescr")
	arg_1_0._txtAnswer = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_answer/Anwser/#txt_Answer")
	arg_1_0._imagePuzzlePic = gohelper.findChildImage(arg_1_0.viewGO, "Root/#go_answer/#image_PuzzlePic")
	arg_1_0._goquestion = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question")
	arg_1_0._txtquestiontitle = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_question/Title/#txt_questiontitle")
	arg_1_0._txtquestiondescr = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_question/Scroll View/Viewport/#txt_questiondescr")
	arg_1_0._btnchoice1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice1")
	arg_1_0._gonormalbg1 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice1/#go_normalbg1")
	arg_1_0._gofalsebg1 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice1/#go_falsebg1")
	arg_1_0._gotruebg1 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice1/#go_truebg1")
	arg_1_0._gofalseicon1 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice1/Layout/#go_falseicon1")
	arg_1_0._gotrueicon1 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice1/Layout/#go_trueicon1")
	arg_1_0._txtchoice1 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice1/Layout/#txt_choice1")
	arg_1_0._btnchoice2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice2")
	arg_1_0._gonormalbg2 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice2/#go_normalbg2")
	arg_1_0._gofalsebg2 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice2/#go_falsebg2")
	arg_1_0._gotruebg2 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice2/#go_truebg2")
	arg_1_0._gofalseicon2 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice2/Layout/#go_falseicon2")
	arg_1_0._gotrueicon2 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice2/Layout/#go_trueicon2")
	arg_1_0._txtchoice2 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice2/Layout/#txt_choice2")
	arg_1_0._btnchoice3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice3")
	arg_1_0._gonormalbg3 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice3/#go_normalbg3")
	arg_1_0._gofalsebg3 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice3/#go_falsebg3")
	arg_1_0._gotruebg3 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice3/#go_truebg3")
	arg_1_0._gofalseicon3 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice3/Layout/#go_falseicon3")
	arg_1_0._gotrueicon3 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice3/Layout/#go_trueicon3")
	arg_1_0._txtchoice3 = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_question/Layout/#btn_choice3/Layout/#txt_choice3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchoice1:AddClickListener(arg_2_0._btnchoice1OnClick, arg_2_0)
	arg_2_0._btnchoice2:AddClickListener(arg_2_0._btnchoice2OnClick, arg_2_0)
	arg_2_0._btnchoice3:AddClickListener(arg_2_0._btnchoice3OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchoice1:RemoveClickListener()
	arg_3_0._btnchoice2:RemoveClickListener()
	arg_3_0._btnchoice3:RemoveClickListener()
end

function var_0_0._btnchoice1OnClick(arg_4_0)
	local var_4_0 = LanternFestivalModel.instance:getPuzzleOptionState(arg_4_0._puzzleId, 1)

	if var_4_0 == LanternFestivalEnum.OptionState.Wrong then
		GameFacade.showToast(ToastEnum.Act1_7LanternFestivalSelectWrongTip)

		return
	elseif var_4_0 == LanternFestivalEnum.OptionState.Right then
		return
	end

	arg_4_0:_clickChoice(1)
end

function var_0_0._btnchoice2OnClick(arg_5_0)
	local var_5_0 = LanternFestivalModel.instance:getPuzzleOptionState(arg_5_0._puzzleId, 2)

	if var_5_0 == LanternFestivalEnum.OptionState.Wrong then
		GameFacade.showToast(ToastEnum.Act1_7LanternFestivalSelectWrongTip)

		return
	elseif var_5_0 == LanternFestivalEnum.OptionState.Right then
		return
	end

	arg_5_0:_clickChoice(2)
end

function var_0_0._btnchoice3OnClick(arg_6_0)
	local var_6_0 = LanternFestivalModel.instance:getPuzzleOptionState(arg_6_0._puzzleId, 3)

	if var_6_0 == LanternFestivalEnum.OptionState.Wrong then
		GameFacade.showToast(ToastEnum.Act1_7LanternFestivalSelectWrongTip)

		return
	elseif var_6_0 == LanternFestivalEnum.OptionState.Right then
		return
	end

	arg_6_0:_clickChoice(3)
end

function var_0_0._clickChoice(arg_7_0, arg_7_1)
	local var_7_0 = ActivityEnum.Activity.LanternFestival
	local var_7_1 = ActivityModel.instance:getActivityInfo()[var_7_0]

	if var_7_1 and var_7_1:isExpired() then
		ToastController.instance:showToast(ToastEnum.ActivityEnd)
		arg_7_0:closeThis()

		return
	end

	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("waitShowResult")
	gohelper.setActive(arg_7_0["_gonormalbg" .. arg_7_1], false)

	local var_7_2 = LanternFestivalConfig.instance:getAct154Co(var_7_0, arg_7_0._day).answerId == arg_7_1

	gohelper.setActive(arg_7_0["_gofalseicon" .. arg_7_1], not var_7_2)
	gohelper.setActive(arg_7_0["_gotrueicon" .. arg_7_1], var_7_2)
	gohelper.setActive(arg_7_0["_gofalsebg" .. arg_7_1], not var_7_2)
	gohelper.setActive(arg_7_0["_gotruebg" .. arg_7_1], var_7_2)
	arg_7_0["_aniChoice" .. tostring(arg_7_1)]:Play("open", 0, 0)

	arg_7_0._curIndex = arg_7_1

	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_checkpoint_continueappear)
	TaskDispatcher.runDelay(arg_7_0._realSendAnswer, arg_7_0, 0.5)
end

function var_0_0._realSendAnswer(arg_8_0)
	UIBlockMgr.instance:endBlock("waitShowResult")

	arg_8_0._newUnlockPuzzle = arg_8_0._puzzleId

	local var_8_0 = ActivityEnum.Activity.LanternFestival

	Activity154Rpc.instance:sendAnswer154PuzzleRequest(var_8_0, arg_8_0._puzzleId, arg_8_0._curIndex)
end

function var_0_0.onClickModalMask(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._editableInitView(arg_10_0)
	return
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._puzzleId = arg_12_0.viewParam.puzzleId
	arg_12_0._day = arg_12_0.viewParam.day
	arg_12_0._curIndex = 0

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_12_0._onCloseViewFinish, arg_12_0)

	arg_12_0._aniChoice1 = gohelper.findChild(arg_12_0._btnchoice1.gameObject, "Layout"):GetComponent(typeof(UnityEngine.Animator))
	arg_12_0._aniChoice2 = gohelper.findChild(arg_12_0._btnchoice2.gameObject, "Layout"):GetComponent(typeof(UnityEngine.Animator))
	arg_12_0._aniChoice3 = gohelper.findChild(arg_12_0._btnchoice3.gameObject, "Layout"):GetComponent(typeof(UnityEngine.Animator))
	arg_12_0._viewAni = arg_12_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_taskinterface)
	arg_12_0:_refreshTip(false)
end

function var_0_0._onCloseViewFinish(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.CommonPropView then
		arg_13_0:_refreshTip()
		AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_jinye_answer_correct)
		arg_13_0._viewAni:Play("open", 0, 0)
		UIBlockMgr.instance:startBlock("waitShowOpen")
		TaskDispatcher.runDelay(arg_13_0._openFinished, arg_13_0, 3)
	end
end

function var_0_0._openFinished(arg_14_0)
	UIBlockMgr.instance:endBlock("waitShowOpen")
end

function var_0_0._refreshTip(arg_15_0, arg_15_1)
	if not LanternFestivalModel.instance:isPuzzleUnlock(arg_15_0._puzzleId) then
		arg_15_0:closeThis()

		return
	end

	local var_15_0 = LanternFestivalModel.instance:getPuzzleState(arg_15_0._puzzleId)
	local var_15_1 = var_15_0 == LanternFestivalEnum.PuzzleState.RewardGet

	if not arg_15_1 then
		var_15_1 = var_15_1 or var_15_0 == LanternFestivalEnum.PuzzleState.Solved
	end

	gohelper.setActive(arg_15_0._goanswer, var_15_1)
	gohelper.setActive(arg_15_0._goquestion, not var_15_1)

	if var_15_1 then
		arg_15_0:_refreshAnswer()
	else
		arg_15_0:_refreshQuestion()
	end
end

function var_0_0._refreshQuestion(arg_16_0)
	local var_16_0 = LanternFestivalConfig.instance:getAct154Co(nil, arg_16_0._day)

	arg_16_0._txtquestiontitle.text = var_16_0.puzzleTitle
	arg_16_0._txtquestiondescr.text = var_16_0.puzzleDesc

	local var_16_1 = LanternFestivalConfig.instance:getAct154Options(arg_16_0._puzzleId)

	for iter_16_0 = 1, 3 do
		local var_16_2 = LanternFestivalModel.instance:getPuzzleOptionState(arg_16_0._puzzleId, iter_16_0)

		gohelper.setActive(arg_16_0["_gofalseicon" .. iter_16_0], var_16_2 == LanternFestivalEnum.OptionState.Wrong)
		gohelper.setActive(arg_16_0["_gotrueicon" .. iter_16_0], var_16_2 == LanternFestivalEnum.OptionState.Right)
		gohelper.setActive(arg_16_0["_gonormalbg" .. iter_16_0], var_16_2 == LanternFestivalEnum.OptionState.UnAnswer)
		gohelper.setActive(arg_16_0["_gofalsebg" .. iter_16_0], var_16_2 == LanternFestivalEnum.OptionState.Wrong)
		gohelper.setActive(arg_16_0["_gotruebg" .. iter_16_0], var_16_2 == LanternFestivalEnum.OptionState.Right)

		arg_16_0["_txtchoice" .. iter_16_0].text = var_16_1[iter_16_0].optionText
	end
end

function var_0_0._refreshAnswer(arg_17_0)
	local var_17_0 = LanternFestivalConfig.instance:getAct154Co(nil, arg_17_0._day)

	arg_17_0._txtTitle.text = var_17_0.puzzleTitle
	arg_17_0._txtanswerdescr.text = var_17_0.puzzleDesc

	local var_17_1 = LanternFestivalConfig.instance:getPuzzleCo(arg_17_0._puzzleId).answerId

	arg_17_0._txtAnswer.text = LanternFestivalConfig.instance:getAct154Options(arg_17_0._puzzleId)[var_17_1].optionText

	local var_17_2 = LanternFestivalConfig.instance:getPuzzleCo(arg_17_0._puzzleId)

	UISpriteSetMgr.instance:setV1a7LanternSprite(arg_17_0._imagePuzzlePic, var_17_2.puzzleIcon)
end

function var_0_0.onClose(arg_18_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_18_0._onCloseViewFinish, arg_18_0)

	if arg_18_0._newUnlockPuzzle and arg_18_0._newUnlockPuzzle > 0 and LanternFestivalModel.instance:isPuzzleGiftGet(arg_18_0._newUnlockPuzzle) then
		LanternFestivalController.instance:dispatchEvent(LanternFestivalEvent.ShowUnlockNewPuzzle, arg_18_0._newUnlockPuzzle)
	end
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
