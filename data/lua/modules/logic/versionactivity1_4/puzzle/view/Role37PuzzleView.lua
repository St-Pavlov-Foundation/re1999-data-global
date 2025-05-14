module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleView", package.seeall)

local var_0_0 = class("Role37PuzzleView", BaseView)

var_0_0.AudioInterval = 0.85
var_0_0.StartDealy = 1.04
var_0_0.ResumeWaitDealy = 0.2

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtStageName = gohelper.findChildText(arg_1_0.viewGO, "left/image_StageBG/#txt_StageName")
	arg_1_0._txtStageEn = gohelper.findChildText(arg_1_0.viewGO, "left/image_StageBG/#txt_StageEn")
	arg_1_0._txtround = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_round")
	arg_1_0._txtTargetDesc = gohelper.findChildText(arg_1_0.viewGO, "left/TargetList/Target1/#txt_TargetDesc")
	arg_1_0._imageTargetFinish = gohelper.findChildImage(arg_1_0.viewGO, "left/TargetList/Target1/#txt_TargetDesc/#image_TargetFinish")
	arg_1_0._imageTargetNotFinish = gohelper.findChildImage(arg_1_0.viewGO, "left/TargetList/Target1/#txt_TargetDesc/#image_TargetNotFinish")
	arg_1_0._goQuestion = gohelper.findChild(arg_1_0.viewGO, "QuestionPanelCommon/#go_Question")
	arg_1_0._txtQuestion = gohelper.findChildText(arg_1_0.viewGO, "QuestionPanelCommon/#go_Question/#txt_Question")
	arg_1_0._btnTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "QuestionPanelCommon/#btn_Tips")
	arg_1_0._goBaseQuestionPanel = gohelper.findChild(arg_1_0.viewGO, "#go_BaseQuestionPanel")
	arg_1_0._scrollAreaList1 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_BaseQuestionPanel/PutArea/put/#scroll_AreaList1")
	arg_1_0._gostepframes1 = gohelper.findChild(arg_1_0.viewGO, "#go_BaseQuestionPanel/PutArea/put/#scroll_AreaList1/Viewport/#go_stepframes1")
	arg_1_0._gosteps1 = gohelper.findChild(arg_1_0.viewGO, "#go_BaseQuestionPanel/PutArea/put/#scroll_AreaList1/Viewport/#go_steps1")
	arg_1_0._btnLeftArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_BaseQuestionPanel/PutArea/put/#btn_LeftArrow")
	arg_1_0._btnRightArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_BaseQuestionPanel/PutArea/put/#btn_RightArrow")
	arg_1_0._gobaseoper = gohelper.findChild(arg_1_0.viewGO, "#go_BaseQuestionPanel/OperArea/#go_baseoper")
	arg_1_0._goFinalQuestionPanel = gohelper.findChild(arg_1_0.viewGO, "#go_FinalQuestionPanel")
	arg_1_0._scrollAreaList2 = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#scroll_AreaList2")
	arg_1_0._gostepframes2 = gohelper.findChild(arg_1_0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#scroll_AreaList2/Viewport/#go_stepframes2")
	arg_1_0._gosteps2 = gohelper.findChild(arg_1_0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#scroll_AreaList2/Viewport/#go_steps2")
	arg_1_0._btnLeftArrowFinal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_LeftArrowFinal")
	arg_1_0._btnRightArrowFinal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_RightArrowFinal")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#go_progress")
	arg_1_0._btnStop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_Stop")
	arg_1_0._btnPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_Play")
	arg_1_0._btnpause = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_pause")
	arg_1_0._gofinaloper = gohelper.findChild(arg_1_0.viewGO, "#go_FinalQuestionPanel/OperArea/#go_finaloper")
	arg_1_0._btnSearch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Record/Title/#btn_Search")
	arg_1_0._goRecordEmpty = gohelper.findChild(arg_1_0.viewGO, "Record/#go_RecordEmpty")
	arg_1_0._scrollrecord = gohelper.findChildScrollRect(arg_1_0.viewGO, "Record/#scroll_record")
	arg_1_0._btnrollback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top_right/#btn_rollback")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top_right/#btn_reset")
	arg_1_0._goprotectArea = gohelper.findChild(arg_1_0.viewGO, "#go_protectArea")
	arg_1_0._goRecordItem = gohelper.findChild(arg_1_0.viewGO, "Record/#scroll_record/Viewport/Content/RecordItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTips:AddClickListener(arg_2_0._btnTipsOnClick, arg_2_0)
	arg_2_0._btnLeftArrow:AddClickListener(arg_2_0._btnLeftArrowOnClick, arg_2_0)
	arg_2_0._btnRightArrow:AddClickListener(arg_2_0._btnRightArrowOnClick, arg_2_0)
	arg_2_0._btnLeftArrowFinal:AddClickListener(arg_2_0._btnLeftArrowFinalOnClick, arg_2_0)
	arg_2_0._btnRightArrowFinal:AddClickListener(arg_2_0._btnRightArrowFinalOnClick, arg_2_0)
	arg_2_0._btnStop:AddClickListener(arg_2_0._btnStopOnClick, arg_2_0)
	arg_2_0._btnPlay:AddClickListener(arg_2_0._btnPlayOnClick, arg_2_0)
	arg_2_0._btnpause:AddClickListener(arg_2_0._btnpauseOnClick, arg_2_0)
	arg_2_0._btnSearch:AddClickListener(arg_2_0._btnSearchOnClick, arg_2_0)
	arg_2_0._btnrollback:AddClickListener(arg_2_0._btnrollbackOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTips:RemoveClickListener()
	arg_3_0._btnLeftArrow:RemoveClickListener()
	arg_3_0._btnRightArrow:RemoveClickListener()
	arg_3_0._btnLeftArrowFinal:RemoveClickListener()
	arg_3_0._btnRightArrowFinal:RemoveClickListener()
	arg_3_0._btnStop:RemoveClickListener()
	arg_3_0._btnPlay:RemoveClickListener()
	arg_3_0._btnpause:RemoveClickListener()
	arg_3_0._btnSearch:RemoveClickListener()
	arg_3_0._btnrollback:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._btnTipsOnClick(arg_4_0)
	local var_4_0 = VersionActivity1_4Enum.ActivityId.Role37
	local var_4_1 = arg_4_0.puzzleCfg.puzzleId
	local var_4_2 = Activity130Config.instance:getActivity130DecryptCo(var_4_0, var_4_1).puzzleTip

	Activity130Controller.instance:dispatchEvent(Activity130Event.ShowTipDialog, var_4_2)
end

function var_0_0._btnStopOnClick(arg_5_0)
	if arg_5_0._scrollTweenId then
		ZProj.TweenHelper.KillById(arg_5_0._scrollTweenId)

		arg_5_0._scrollTweenId = nil
	end

	gohelper.setActive(arg_5_0._btnpause, false)
	gohelper.setActive(arg_5_0._btnPlay, true)
	gohelper.setActive(arg_5_0._goprotectArea, false)
	arg_5_0:_stopAudio()
	arg_5_0._progressAnimation:Play("go_progress_close")
	TaskDispatcher.runDelay(function(arg_6_0)
		gohelper.setActive(arg_6_0._goprogress, false)
	end, arg_5_0, 0.3)
end

function var_0_0._btnPlayOnClick(arg_7_0)
	arg_7_0.recordScrollValue = nil
	arg_7_0.lastStepsX = nil

	if arg_7_0._goprogress.activeInHierarchy then
		if not arg_7_0.curKey then
			return
		else
			arg_7_0:_resumeProgressAnim()
			arg_7_0:_resumeScrollPos()
			arg_7_0:_resumeAudio()
		end
	else
		arg_7_0.maxKey = 0

		for iter_7_0, iter_7_1 in pairs(arg_7_0.operList) do
			if iter_7_0 > arg_7_0.maxKey then
				arg_7_0.maxKey = iter_7_0
			end
		end

		if arg_7_0.maxKey == 0 then
			return
		else
			gohelper.setActive(arg_7_0._goprogress, true)

			arg_7_0._progressAnim.speed = 1

			arg_7_0:_playAudio()

			arg_7_0._scrollAreaList2.horizontalNormalizedPosition = 0
		end
	end

	gohelper.setActive(arg_7_0._btnPlay, false)
	gohelper.setActive(arg_7_0._btnpause, true)
	gohelper.setActive(arg_7_0._goprotectArea, true)
end

function var_0_0._btnpauseOnClick(arg_8_0)
	if arg_8_0._scrollTweenId then
		ZProj.TweenHelper.KillById(arg_8_0._scrollTweenId)

		arg_8_0._scrollTweenId = nil
	end

	gohelper.setActive(arg_8_0._btnpause, false)
	gohelper.setActive(arg_8_0._btnPlay, true)
	gohelper.setActive(arg_8_0._goprotectArea, false)
	arg_8_0:_pauseAudio()

	arg_8_0._progressAnim.speed = 0
	arg_8_0.lastStepsX = recthelper.getAnchorX(arg_8_0._gosteps.transform)
end

function var_0_0._btnLeftArrowOnClick(arg_9_0)
	local var_9_0 = arg_9_0._scrollAreaList1.horizontalNormalizedPosition

	if var_9_0 ~= 0 then
		local var_9_1 = var_9_0 - 0.2

		if var_9_1 < 0 then
			var_9_1 = 0
		end

		arg_9_0._scrollAreaList1.horizontalNormalizedPosition = var_9_1
	end
end

function var_0_0._btnRightArrowOnClick(arg_10_0)
	local var_10_0 = arg_10_0._scrollAreaList1.horizontalNormalizedPosition

	if var_10_0 ~= 1 then
		local var_10_1 = var_10_0 + 0.2

		if var_10_1 > 1 then
			var_10_1 = 1
		end

		arg_10_0._scrollAreaList1.horizontalNormalizedPosition = var_10_1
	end
end

function var_0_0._btnLeftArrowFinalOnClick(arg_11_0)
	local var_11_0 = arg_11_0._scrollAreaList2.horizontalNormalizedPosition

	if var_11_0 ~= 0 then
		local var_11_1 = var_11_0 - 0.2

		if var_11_1 < 0 then
			var_11_1 = 0
		end

		arg_11_0._scrollAreaList2.horizontalNormalizedPosition = var_11_1
	end
end

function var_0_0._btnRightArrowFinalOnClick(arg_12_0)
	local var_12_0 = arg_12_0._scrollAreaList2.horizontalNormalizedPosition

	if var_12_0 ~= 1 then
		local var_12_1 = var_12_0 + 0.2

		if var_12_1 > 1 then
			var_12_1 = 1
		end

		arg_12_0._scrollAreaList2.horizontalNormalizedPosition = var_12_1
	end
end

function var_0_0._btnSearchOnClick(arg_13_0)
	ViewMgr.instance:openView(ViewName.Role37PuzzleRecordView)
end

function var_0_0._btnrollbackOnClick(arg_14_0)
	Role37PuzzleModel.instance:rollBack()
end

function var_0_0._btnresetOnClick(arg_15_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130GameRestart, MsgBoxEnum.BoxType.Yes_No, function()
		Activity130Rpc.instance:addGameChallengeNum(Activity130Model.instance:getCurEpisodeId())
		Role37PuzzleModel.instance:reset()
	end)
end

function var_0_0._editableInitView(arg_17_0)
	arg_17_0:_editableAddEvents()

	arg_17_0.transform = arg_17_0.viewGO.transform

	arg_17_0:initViewCfg()
	gohelper.setActive(arg_17_0._btnTips, not arg_17_0.isFinal)
	arg_17_0:_playFinalSound()
	arg_17_0._scrollAreaList:AddOnValueChanged(arg_17_0._onScrollValueChanged, arg_17_0)

	arg_17_0.answerPrefab = gohelper.findChild(arg_17_0._gosteps, "answeritem")

	gohelper.setActive(arg_17_0.answerPrefab, false)

	arg_17_0.dragGo = gohelper.clone(arg_17_0.answerPrefab, arg_17_0.viewGO, "dragItem")
	arg_17_0.dragImgDesc = gohelper.findChildImage(arg_17_0.dragGo, "img_ItemIcon")
	arg_17_0.dragImgyyDesc = gohelper.findChildImage(arg_17_0.dragGo, "img_ItemIcon_yy")
	arg_17_0.dragAnim = arg_17_0.dragGo:GetComponent(typeof(UnityEngine.Animator))
	arg_17_0._goComplete = gohelper.findChild(arg_17_0.viewGO, "QuestionPanelCommon/anim_Completed")
	arg_17_0._goVxprogress = gohelper.findChild(arg_17_0._goprogress, "vx_progress")
	arg_17_0._progressAnimation = arg_17_0._goprogress:GetComponent(typeof(UnityEngine.Animation))
	arg_17_0._progressAnim = arg_17_0._goVxprogress:GetComponent(typeof(UnityEngine.Animator))
	arg_17_0.answerList = {}
	arg_17_0.frameItemList = {}
	arg_17_0.optionItemList = {}
	arg_17_0.recordItemList = {}

	arg_17_0:refreshUI()
end

function var_0_0.initViewCfg(arg_18_0)
	arg_18_0.puzzleCfg = Role37PuzzleModel.instance:getPuzzleCfg()
	arg_18_0.puzzleId = arg_18_0.puzzleCfg.puzzleId
	arg_18_0.maxOper = arg_18_0.puzzleCfg.maxOper
	arg_18_0.operGroupCfg = Role37PuzzleModel.instance:getOperGroupCfg()
	arg_18_0.operList = Role37PuzzleModel.instance:getOperList()

	if arg_18_0.puzzleId ~= Role37PuzzleEnum.PuzzleId.Final then
		arg_18_0.isFinal = false
		arg_18_0.realOper = arg_18_0._gobaseoper
		arg_18_0._gostepframes = arg_18_0._gostepframes1
		arg_18_0._gosteps = arg_18_0._gosteps1
		arg_18_0._scrollAreaList = arg_18_0._scrollAreaList1
		arg_18_0.goLeftArrow = arg_18_0._btnLeftArrow
		arg_18_0.goRightArrow = arg_18_0._btnRightArrow
	else
		arg_18_0.isFinal = true
		arg_18_0.realOper = arg_18_0._gofinaloper
		arg_18_0._gostepframes = arg_18_0._gostepframes2
		arg_18_0._gosteps = arg_18_0._gosteps2
		arg_18_0._scrollAreaList = arg_18_0._scrollAreaList2
		arg_18_0.goLeftArrow = arg_18_0._btnLeftArrowFinal
		arg_18_0.goRightArrow = arg_18_0._btnRightArrowFinal
	end
end

function var_0_0.refreshUI(arg_19_0)
	local var_19_0 = Activity130Model.instance:getCurEpisodeId()
	local var_19_1 = Activity130Config.instance:getActivity130EpisodeCo(Activity130Enum.ActivityId.Act130, var_19_0)

	if var_19_1 then
		arg_19_0._txtStageEn.text = var_19_1.episodetag
		arg_19_0._txtStageName.text = var_19_1.name
		arg_19_0._txtTargetDesc.text = var_19_1.conditionStr
	end

	arg_19_0._txtQuestion.text = arg_19_0.puzzleCfg.puzzleTxt

	gohelper.setActive(arg_19_0._goBaseQuestionPanel, not arg_19_0.isFinal)
	gohelper.setActive(arg_19_0._goFinalQuestionPanel, arg_19_0.isFinal)

	local var_19_2 = PuzzleRecordListModel.instance:getCount()

	arg_19_0:onRecordChange(var_19_2)
	arg_19_0:_initPutArea()
	arg_19_0:_initOptionItem()
end

function var_0_0._initOptionItem(arg_20_0)
	for iter_20_0 = 1, 6 do
		arg_20_0:_creatOptionItem(iter_20_0)
	end

	local var_20_0 = Role37PuzzleModel.instance:getOperGroupList()

	for iter_20_1 = 1, #var_20_0 do
		local var_20_1 = var_20_0[iter_20_1].operType
		local var_20_2 = arg_20_0.optionItemList[iter_20_1]

		if not var_20_2 then
			var_20_2 = arg_20_0:_creatOptionItem(iter_20_1)

			gohelper.setActive(var_20_2.go, true)
		end

		var_20_2.button = gohelper.findChildButton(var_20_2.go, "")

		var_20_2.button:AddClickListener(arg_20_0._optionClick, arg_20_0, var_20_1)

		var_20_2.uidrag = SLFramework.UGUI.UIDragListener.Get(var_20_2.go)

		var_20_2.uidrag:AddDragBeginListener(arg_20_0._optionDragBegin, arg_20_0, var_20_1)
		var_20_2.uidrag:AddDragListener(arg_20_0._optionDrag, arg_20_0)
		var_20_2.uidrag:AddDragEndListener(arg_20_0._optionDragEnd, arg_20_0, var_20_1)

		if not arg_20_0.isFinal then
			local var_20_3 = gohelper.findChildImage(var_20_2.go, "image_Empty")

			gohelper.setActive(var_20_3, false)

			local var_20_4 = gohelper.findChildImage(var_20_2.go, "image_Icon")
			local var_20_5 = gohelper.findChildText(var_20_2.go, "txt_tip")

			UISpriteSetMgr.instance:setV1a4Role37Sprite(var_20_4, var_20_0[iter_20_1].shapeImg)

			var_20_5.text = var_20_0[iter_20_1].operDesc
			gohelper.findChildText(var_20_2.go, "txt_Type").text = var_20_0[iter_20_1].name

			gohelper.setActive(var_20_4, true)
			gohelper.setActive(var_20_5, true)
		end
	end
end

function var_0_0._creatOptionItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getUserDataTb_()

	var_21_0.go = gohelper.findChild(arg_21_0.realOper, "option" .. arg_21_1)
	arg_21_0.optionItemList[arg_21_1] = var_21_0

	return var_21_0
end

function var_0_0._initPutArea(arg_22_0)
	local var_22_0 = gohelper.findChild(arg_22_0._gostepframes, "stepframe")

	for iter_22_0 = 1, arg_22_0.maxOper do
		local var_22_1 = arg_22_0:getUserDataTb_()

		var_22_1.go = gohelper.cloneInPlace(var_22_0, "stepframe" .. iter_22_0)
		var_22_1.notPutImage = gohelper.findChildImage(var_22_1.go, "noPut")
		var_22_1.putImage = gohelper.findChildImage(var_22_1.go, "put")
		arg_22_0.frameItemList[iter_22_0] = var_22_1
	end

	gohelper.setActive(var_22_0, false)
end

function var_0_0._editableAddEvents(arg_23_0)
	arg_23_0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.AddOption, arg_23_0.onAddOption, arg_23_0)
	arg_23_0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RemoveOption, arg_23_0.onRemoveOption, arg_23_0)
	arg_23_0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.ExchangeOption, arg_23_0.onExchangeOption, arg_23_0)
	arg_23_0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RepleaceOption, arg_23_0.onRepleaceOption, arg_23_0)
	arg_23_0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.MoveOption, arg_23_0.onMoveOption, arg_23_0)
	arg_23_0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.Reset, arg_23_0.onReset, arg_23_0)
	arg_23_0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, arg_23_0.onPuzzleFinish, arg_23_0)
	arg_23_0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RecordCntChange, arg_23_0.onRecordChange, arg_23_0)
	arg_23_0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.ErrorOperChange, arg_23_0.onErrorOper, arg_23_0)
end

function var_0_0._editableRemoveEvents(arg_24_0)
	arg_24_0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.AddOption, arg_24_0.onAddOption, arg_24_0)
	arg_24_0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RemoveOption, arg_24_0.onRemoveOption, arg_24_0)
	arg_24_0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.ExchangeOption, arg_24_0.onExchangeOption, arg_24_0)
	arg_24_0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RepleaceOption, arg_24_0.onRepleaceOption, arg_24_0)
	arg_24_0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.MoveOption, arg_24_0.onMoveOption, arg_24_0)
	arg_24_0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.Reset, arg_24_0.onReset, arg_24_0)
	arg_24_0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, arg_24_0.onPuzzleFinish, arg_24_0)
	arg_24_0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RecordCntChange, arg_24_0.onRecordChange, arg_24_0)
	arg_24_0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.ErrorOperChange, arg_24_0.onErrorOper, arg_24_0)
end

function var_0_0.onDestroyView(arg_25_0)
	arg_25_0._scrollAreaList:RemoveOnValueChanged()

	for iter_25_0 = 1, tabletool.len(arg_25_0.operGroupCfg) do
		local var_25_0 = arg_25_0.optionItemList[iter_25_0]

		var_25_0.button:RemoveClickListener()
		var_25_0.uidrag:RemoveDragBeginListener()
		var_25_0.uidrag:RemoveDragListener()
		var_25_0.uidrag:RemoveDragEndListener()
	end

	arg_25_0:_editableRemoveEvents()
	TaskDispatcher.cancelTask(arg_25_0._playAudioLoop, arg_25_0)
	AudioMgr.instance:trigger(AudioEnum.UI.resume_plotmusic_sound)
	arg_25_0:_closeFinalSound()
end

function var_0_0._optionClick(arg_26_0, arg_26_1)
	if arg_26_0.optionDrag then
		return
	end

	local var_26_0 = Role37PuzzleModel.instance:getFirstGapIndex()

	Role37PuzzleModel.instance:addOption(arg_26_1, var_26_0)

	local var_26_1 = Role37PuzzleModel.instance:getOperAudioId(arg_26_1)

	AudioMgr.instance:trigger(var_26_1)
end

function var_0_0._optionDragBegin(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.optionDrag = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_drag)

	local var_27_0 = recthelper.screenPosToAnchorPos(arg_27_2.position, arg_27_0.transform)

	UISpriteSetMgr.instance:setV1a4Role37Sprite(arg_27_0.dragImgDesc, arg_27_0.operGroupCfg[arg_27_1].shapeImg)
	UISpriteSetMgr.instance:setV1a4Role37Sprite(arg_27_0.dragImgyyDesc, arg_27_0.operGroupCfg[arg_27_1].shapeImg .. "_yy")
	gohelper.setActive(arg_27_0.dragGo, true)
	arg_27_0.dragAnim:Play("in", 0, 0)
	recthelper.setAnchor(arg_27_0.dragGo.transform, var_27_0.x, var_27_0.y)
end

function var_0_0._optionDrag(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = recthelper.screenPosToAnchorPos(arg_28_2.position, arg_28_0.transform)

	if arg_28_0.optionDrag then
		recthelper.setAnchor(arg_28_0.dragGo.transform, var_28_0.x, var_28_0.y)
	end
end

function var_0_0._optionDragEnd(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_0.optionDrag then
		return
	end

	arg_29_0.optionDrag = false

	arg_29_0.dragAnim:Play("put", 0, 0)

	local var_29_0 = recthelper.screenPosToAnchorPos(arg_29_2.position, arg_29_0.transform)
	local var_29_1

	for iter_29_0 = 1, arg_29_0.maxOper do
		local var_29_2 = recthelper.uiPosToScreenPos(arg_29_0.frameItemList[iter_29_0].go.transform)
		local var_29_3 = recthelper.screenPosToAnchorPos(var_29_2, arg_29_0.transform)

		if math.abs(var_29_3.x - var_29_0.x) < 75 and math.abs(var_29_3.y - var_29_0.y) < 75 then
			var_29_1 = iter_29_0

			break
		end
	end

	if var_29_1 then
		Role37PuzzleModel.instance:addOption(arg_29_1, var_29_1)
		arg_29_0:_playDragEndAudio(arg_29_1)
	end

	gohelper.setActive(arg_29_0.dragGo, false)
end

function var_0_0._onScrollValueChanged(arg_30_0, arg_30_1)
	local var_30_0 = recthelper.getAnchorX(arg_30_0._gostepframes.transform)

	recthelper.setAnchorX(arg_30_0._gosteps.transform, var_30_0)

	if arg_30_0.lastStepsX then
		if not arg_30_0.recordScrollValue then
			arg_30_0.recordScrollValue = arg_30_0._progressAnim:GetCurrentAnimatorStateInfo(0).normalizedTime
		end

		local var_30_1 = 0.000748 * (var_30_0 - arg_30_0.lastStepsX)

		arg_30_0.recordScrollValue = arg_30_0.recordScrollValue + var_30_1

		local var_30_2 = arg_30_0.recordScrollValue

		if var_30_2 > 1 then
			var_30_2 = 1
		elseif var_30_2 < 0 then
			var_30_2 = 0
		end

		arg_30_0._progressAnim:Play("play", 0, var_30_2)

		arg_30_0.lastStepsX = var_30_0
	end

	if arg_30_1 <= 0.01 then
		gohelper.setActive(arg_30_0.goLeftArrow, false)
		gohelper.setActive(arg_30_0.goRightArrow, true)
	elseif arg_30_1 >= 0.99 then
		gohelper.setActive(arg_30_0.goLeftArrow, true)
		gohelper.setActive(arg_30_0.goRightArrow, false)
	else
		gohelper.setActive(arg_30_0.goLeftArrow, true)
		gohelper.setActive(arg_30_0.goRightArrow, true)
	end
end

function var_0_0.onAddOption(arg_31_0, arg_31_1)
	local var_31_0 = gohelper.cloneInPlace(arg_31_0.answerPrefab)

	gohelper.setActive(var_31_0, true)

	var_31_0.name = "answerItem" .. arg_31_1
	arg_31_0.answerList[arg_31_1] = MonoHelper.addNoUpdateLuaComOnceToGo(var_31_0, OptionItem)

	arg_31_0.answerList[arg_31_1]:initParam(arg_31_1, arg_31_0.frameItemList, arg_31_0.viewGO, arg_31_0.isFinal)
	arg_31_0:_skipToPos(arg_31_1, arg_31_0.maxOper)
	arg_31_0:refreshNum()
	arg_31_0:setFramePut(arg_31_1, true)
end

function var_0_0.onRemoveOption(arg_32_0, arg_32_1)
	gohelper.destroy(arg_32_0.answerList[arg_32_1].go)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_delete)

	arg_32_0.answerList[arg_32_1] = nil

	arg_32_0:refreshNum()
	arg_32_0:setFramePut(arg_32_1, false)
end

function var_0_0.onExchangeOption(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.answerList[arg_33_1]

	arg_33_0.answerList[arg_33_1] = arg_33_0.answerList[arg_33_2]
	arg_33_0.answerList[arg_33_2] = var_33_0

	arg_33_0.answerList[arg_33_1]:updateIndex(arg_33_1)
	arg_33_0.answerList[arg_33_2]:updateIndex(arg_33_2)
	arg_33_0.answerList[arg_33_1]:calculateDefalutPos()
	arg_33_0.answerList[arg_33_2]:calculateDefalutPos()
	arg_33_0.answerList[arg_33_1]:_setDefalutPos(true)
	arg_33_0.answerList[arg_33_2]:_setDefalutPos(true)
	arg_33_0:refreshNum()
	arg_33_0:refreshErrorOper()
end

function var_0_0.onMoveOption(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.answerList[arg_34_2] = arg_34_0.answerList[arg_34_1]
	arg_34_0.answerList[arg_34_1] = nil

	arg_34_0.answerList[arg_34_2]:updateIndex(arg_34_2)
	arg_34_0.answerList[arg_34_2]:calculateDefalutPos()
	arg_34_0.answerList[arg_34_2]:_setDefalutPos(true)
	arg_34_0:refreshNum()
	arg_34_0:setFramePut(arg_34_1, false)
	arg_34_0:setFramePut(arg_34_2, true)
end

function var_0_0.onRepleaceOption(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.answerList[arg_35_2]:updateIndex(arg_35_2)
	arg_35_0.answerList[arg_35_2]:refreshSprite()
	arg_35_0:refreshNum()
end

function var_0_0.onReset(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.answerList) do
		gohelper.destroy(iter_36_1.go)
		arg_36_0:setFramePut(iter_36_0, false)
	end

	arg_36_0.answerList = {}
	arg_36_0.operList = Role37PuzzleModel.instance:getOperList()
	arg_36_0._scrollAreaList.horizontalNormalizedPosition = 0
end

function var_0_0.onPuzzleFinish(arg_37_0, arg_37_1)
	if arg_37_1 then
		StatActivity130Controller.instance:statSuccess()
	else
		StatActivity130Controller.instance:statFail()
	end

	gohelper.setActive(arg_37_0._imageTargetFinish, arg_37_1)
	gohelper.setActive(arg_37_0._imageTargetNotFinish, not arg_37_1)

	if arg_37_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		gohelper.setActive(arg_37_0._goQuestion, false)
		gohelper.setActive(arg_37_0._goComplete, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_completed_writing)
		UIBlockMgr.instance:startBlock("puzzleFinish")
		TaskDispatcher.runDelay(arg_37_0.onAnimFinish, arg_37_0, 2)
	else
		Role37PuzzleController.instance:openPuzzleResultView()
	end
end

function var_0_0.onAnimFinish(arg_38_0)
	if arg_38_0.isFinal then
		arg_38_0:_btnPlayOnClick()
		TaskDispatcher.runDelay(function()
			UIBlockMgr.instance:endBlock("puzzleFinish")
			Role37PuzzleController.instance:openPuzzleResultView()
		end, nil, 10)
	else
		UIBlockMgr.instance:endBlock("puzzleFinish")
		Role37PuzzleController.instance:openPuzzleResultView()
	end
end

function var_0_0.onRecordChange(arg_40_0, arg_40_1)
	arg_40_0._txtround.text = string.format(luaLang("v1a4_role37_puzzle_round"), arg_40_1)

	gohelper.setActive(arg_40_0._goRecordEmpty, arg_40_1 <= 0)
	arg_40_0:refreshRecord(arg_40_1)
	ZProj.UGUIHelper.RebuildLayout(arg_40_0._scrollrecord.content)

	arg_40_0._scrollrecord.verticalNormalizedPosition = 0
end

function var_0_0.refreshRecord(arg_41_0, arg_41_1)
	local var_41_0 = #arg_41_0.recordItemList

	if var_41_0 <= arg_41_1 then
		for iter_41_0 = 1, arg_41_1 do
			local var_41_1 = arg_41_0:getRecordItem(iter_41_0)
			local var_41_2 = Role37PuzzleModel.instance:getRecordMo(iter_41_0)

			var_41_1.comp:onUpdateMO(var_41_2)
			gohelper.setActive(var_41_1.go, true)
		end
	else
		for iter_41_1 = 1, var_41_0 do
			local var_41_3 = arg_41_0:getRecordItem(iter_41_1)

			if iter_41_1 <= arg_41_1 then
				local var_41_4 = Role37PuzzleModel.instance:getRecordMo(iter_41_1)

				var_41_3.comp:onUpdateMO(var_41_4)
				gohelper.setActive(var_41_3.go, true)
			else
				gohelper.setActive(var_41_3.go, false)
			end
		end
	end
end

function var_0_0.getRecordItem(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.recordItemList[arg_42_1]

	if not var_42_0 then
		var_42_0 = {}

		local var_42_1 = gohelper.cloneInPlace(arg_42_0._goRecordItem, "record_" .. arg_42_1)

		var_42_0.go = var_42_1
		var_42_0.comp = MonoHelper.addNoUpdateLuaComOnceToGo(var_42_1, PuzzleRecordItem)

		table.insert(arg_42_0.recordItemList, var_42_0)
	end

	return var_42_0
end

function var_0_0._skipToPos(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0
	local var_43_1

	if arg_43_0.isFinal then
		local var_43_2 = arg_43_1 - 9

		if var_43_2 < 0 then
			arg_43_0._scrollAreaList2.horizontalNormalizedPosition = 0

			return
		end

		local var_43_3 = 0.015 + var_43_2 * 0.01971

		if var_43_3 > 1 then
			var_43_3 = 1
		end

		arg_43_0._scrollAreaList2.horizontalNormalizedPosition = var_43_3
	else
		local var_43_4 = arg_43_1 - 6

		if var_43_4 < 0 then
			arg_43_0._scrollAreaList1.horizontalNormalizedPosition = 0

			return
		end

		local var_43_5 = 200 * arg_43_2 + 10 * (arg_43_2 - 1) + 5
		local var_43_6 = (var_43_5 - 1380) / var_43_5 * arg_43_2
		local var_43_7, var_43_8 = math.modf(var_43_6)
		local var_43_9 = 1 / var_43_6 * (var_43_8 + var_43_4)

		if var_43_9 > 1 then
			var_43_9 = 1
		end

		arg_43_0._scrollAreaList1.horizontalNormalizedPosition = var_43_9
	end
end

function var_0_0.onErrorOper(arg_44_0, arg_44_1)
	if Role37PuzzleModel.instance:getErrorCnt() == 1 and arg_44_1 ~= 0 then
		local var_44_0 = VersionActivity1_4Enum.ActivityId.Role37
		local var_44_1 = arg_44_0.puzzleCfg.puzzleId
		local var_44_2 = Activity130Config.instance:getActivity130DecryptCo(var_44_0, var_44_1).errorTip

		Activity130Controller.instance:dispatchEvent(Activity130Event.ShowTipDialog, var_44_2)
	end

	arg_44_0:refreshErrorOper()
end

function var_0_0.refreshErrorOper(arg_45_0)
	local var_45_0 = Role37PuzzleModel.instance:getCurErrorIndex()

	if var_45_0 == 0 then
		var_45_0 = 9999
	end

	for iter_45_0, iter_45_1 in pairs(arg_45_0.answerList) do
		iter_45_1:setError(var_45_0 <= iter_45_0)
	end
end

function var_0_0._playAudio(arg_46_0)
	AudioMgr.instance:trigger(AudioEnum.UI.pause_plotmusic_sound)

	arg_46_0.curKey = 1

	TaskDispatcher.runDelay(arg_46_0._playAudioLoop, arg_46_0, var_0_0.StartDealy)
end

function var_0_0._pauseAudio(arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._playAudioLoop, arg_47_0)
end

function var_0_0._resumeAudio(arg_48_0)
	for iter_48_0, iter_48_1 in pairs(arg_48_0.operList) do
		if iter_48_0 > arg_48_0.maxKey then
			arg_48_0.maxKey = iter_48_0
		end
	end

	arg_48_0:_playAudioLoop()
	TaskDispatcher.runRepeat(arg_48_0._playAudioLoop, arg_48_0, var_0_0.AudioInterval)
end

function var_0_0._stopAudio(arg_49_0)
	AudioMgr.instance:trigger(AudioEnum.UI.resume_plotmusic_sound)
	TaskDispatcher.cancelTask(arg_49_0._playAudioLoop, arg_49_0)

	arg_49_0.curAudioId = nil
	arg_49_0.curKey = nil
end

function var_0_0._playAudioLoop(arg_50_0)
	if arg_50_0.curKey then
		if arg_50_0.curKey == 1 then
			TaskDispatcher.runRepeat(arg_50_0._playAudioLoop, arg_50_0, var_0_0.AudioInterval)
		end

		if arg_50_0.curKey >= 8 then
			arg_50_0._progressAnim.speed = 0
		end

		arg_50_0:_tweenToScrollPos(arg_50_0.curKey)

		local var_50_0 = arg_50_0.operList[arg_50_0.curKey]

		if var_50_0 then
			arg_50_0.curAudioId = arg_50_0.operGroupCfg[var_50_0].audioId

			AudioMgr.instance:trigger(arg_50_0.curAudioId)
		else
			arg_50_0:_playEmptyAudio()
		end

		arg_50_0.curKey = arg_50_0.curKey + 1

		if arg_50_0.curKey > arg_50_0.maxKey then
			TaskDispatcher.runDelay(arg_50_0._btnStopOnClick, arg_50_0, var_0_0.AudioInterval / 2 - 0.1)
		end
	end
end

function var_0_0._playEmptyAudio(arg_51_0)
	return
end

function var_0_0._resumeProgressAnim(arg_52_0)
	if arg_52_0.curKey > 8 then
		arg_52_0._progressAnim:Play("play", 0, 0.82188)

		arg_52_0._progressAnim.speed = 1
	else
		local var_52_0 = 0.9
		local var_52_1 = 0.867
		local var_52_2 = var_52_0 + (arg_52_0.curKey - 1) * var_52_1

		arg_52_0._progressAnim:CrossFadeInFixedTime("play", 0, 0, var_52_2)

		arg_52_0._progressAnim.speed = 1
	end
end

function var_0_0._resumeScrollPos(arg_53_0)
	if arg_53_0.curKey > 8 then
		local var_53_0 = 0.01971

		arg_53_0._scrollAreaList2.horizontalNormalizedPosition = (arg_53_0.curKey - 8) * var_53_0
	else
		arg_53_0._scrollAreaList2.horizontalNormalizedPosition = 0
	end
end

function var_0_0._tweenToScrollPos(arg_54_0, arg_54_1)
	if arg_54_1 - 8 < 0 then
		return
	end

	local var_54_0 = arg_54_0._scrollAreaList2.horizontalNormalizedPosition
	local var_54_1 = var_54_0 + 0.01971

	if var_54_1 > 1 then
		var_54_1 = 1
	end

	arg_54_0._scrollTweenId = ZProj.TweenHelper.DOTweenFloat(var_54_0, var_54_1, var_0_0.AudioInterval, arg_54_0.setScrollValue, nil, arg_54_0, nil, EaseType.Linear)
end

function var_0_0.setScrollValue(arg_55_0, arg_55_1)
	arg_55_0._scrollAreaList2.horizontalNormalizedPosition = arg_55_1
end

function var_0_0.refreshNum(arg_56_0)
	local var_56_0 = 0

	for iter_56_0 = 1, tabletool.len(arg_56_0.answerList) do
		local var_56_1 = arg_56_0.answerList[iter_56_0 + var_56_0]

		while var_56_1 == nil do
			var_56_0 = var_56_0 + 1
			var_56_1 = arg_56_0.answerList[iter_56_0 + var_56_0]
		end

		var_56_1:setNum(iter_56_0)
	end
end

function var_0_0.setFramePut(arg_57_0, arg_57_1, arg_57_2)
	gohelper.setActive(arg_57_0.frameItemList[arg_57_1].notPutImage, not arg_57_2)
	gohelper.setActive(arg_57_0.frameItemList[arg_57_1].putImage, arg_57_2)
end

function var_0_0._playFinalSound(arg_58_0)
	if arg_58_0.isFinal then
		arg_58_0:_closeFinalSound()

		arg_58_0._finalSoundId = AudioMgr.instance:trigger(AudioEnum.UI.set_activityvolume_on)
	end
end

function var_0_0._closeFinalSound(arg_59_0)
	if arg_59_0._finalSoundId then
		AudioMgr.instance:trigger(AudioEnum.UI.set_activityvolume_off)

		arg_59_0._finalSoundId = nil
	end
end

function var_0_0._playDragEndAudio(arg_60_0, arg_60_1)
	if Activity130Model.instance:getCurEpisodeId() == 7 then
		local var_60_0 = Role37PuzzleModel.instance:getOperAudioId(arg_60_1)

		AudioMgr.instance:trigger(var_60_0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_put)
	end
end

return var_0_0
