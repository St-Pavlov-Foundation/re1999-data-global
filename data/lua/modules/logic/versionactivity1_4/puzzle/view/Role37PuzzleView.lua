module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleView", package.seeall)

slot0 = class("Role37PuzzleView", BaseView)
slot0.AudioInterval = 0.85
slot0.StartDealy = 1.04
slot0.ResumeWaitDealy = 0.2

function slot0.onInitView(slot0)
	slot0._txtStageName = gohelper.findChildText(slot0.viewGO, "left/image_StageBG/#txt_StageName")
	slot0._txtStageEn = gohelper.findChildText(slot0.viewGO, "left/image_StageBG/#txt_StageEn")
	slot0._txtround = gohelper.findChildText(slot0.viewGO, "left/#txt_round")
	slot0._txtTargetDesc = gohelper.findChildText(slot0.viewGO, "left/TargetList/Target1/#txt_TargetDesc")
	slot0._imageTargetFinish = gohelper.findChildImage(slot0.viewGO, "left/TargetList/Target1/#txt_TargetDesc/#image_TargetFinish")
	slot0._imageTargetNotFinish = gohelper.findChildImage(slot0.viewGO, "left/TargetList/Target1/#txt_TargetDesc/#image_TargetNotFinish")
	slot0._goQuestion = gohelper.findChild(slot0.viewGO, "QuestionPanelCommon/#go_Question")
	slot0._txtQuestion = gohelper.findChildText(slot0.viewGO, "QuestionPanelCommon/#go_Question/#txt_Question")
	slot0._btnTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "QuestionPanelCommon/#btn_Tips")
	slot0._goBaseQuestionPanel = gohelper.findChild(slot0.viewGO, "#go_BaseQuestionPanel")
	slot0._scrollAreaList1 = gohelper.findChildScrollRect(slot0.viewGO, "#go_BaseQuestionPanel/PutArea/put/#scroll_AreaList1")
	slot0._gostepframes1 = gohelper.findChild(slot0.viewGO, "#go_BaseQuestionPanel/PutArea/put/#scroll_AreaList1/Viewport/#go_stepframes1")
	slot0._gosteps1 = gohelper.findChild(slot0.viewGO, "#go_BaseQuestionPanel/PutArea/put/#scroll_AreaList1/Viewport/#go_steps1")
	slot0._btnLeftArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_BaseQuestionPanel/PutArea/put/#btn_LeftArrow")
	slot0._btnRightArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_BaseQuestionPanel/PutArea/put/#btn_RightArrow")
	slot0._gobaseoper = gohelper.findChild(slot0.viewGO, "#go_BaseQuestionPanel/OperArea/#go_baseoper")
	slot0._goFinalQuestionPanel = gohelper.findChild(slot0.viewGO, "#go_FinalQuestionPanel")
	slot0._scrollAreaList2 = gohelper.findChildScrollRect(slot0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#scroll_AreaList2")
	slot0._gostepframes2 = gohelper.findChild(slot0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#scroll_AreaList2/Viewport/#go_stepframes2")
	slot0._gosteps2 = gohelper.findChild(slot0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#scroll_AreaList2/Viewport/#go_steps2")
	slot0._btnLeftArrowFinal = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_LeftArrowFinal")
	slot0._btnRightArrowFinal = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_RightArrowFinal")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#go_progress")
	slot0._btnStop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_Stop")
	slot0._btnPlay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_Play")
	slot0._btnpause = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_FinalQuestionPanel/PutArea/put/#btn_pause")
	slot0._gofinaloper = gohelper.findChild(slot0.viewGO, "#go_FinalQuestionPanel/OperArea/#go_finaloper")
	slot0._btnSearch = gohelper.findChildButtonWithAudio(slot0.viewGO, "Record/Title/#btn_Search")
	slot0._goRecordEmpty = gohelper.findChild(slot0.viewGO, "Record/#go_RecordEmpty")
	slot0._scrollrecord = gohelper.findChildScrollRect(slot0.viewGO, "Record/#scroll_record")
	slot0._btnrollback = gohelper.findChildButtonWithAudio(slot0.viewGO, "top_right/#btn_rollback")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "top_right/#btn_reset")
	slot0._goprotectArea = gohelper.findChild(slot0.viewGO, "#go_protectArea")
	slot0._goRecordItem = gohelper.findChild(slot0.viewGO, "Record/#scroll_record/Viewport/Content/RecordItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnTips:AddClickListener(slot0._btnTipsOnClick, slot0)
	slot0._btnLeftArrow:AddClickListener(slot0._btnLeftArrowOnClick, slot0)
	slot0._btnRightArrow:AddClickListener(slot0._btnRightArrowOnClick, slot0)
	slot0._btnLeftArrowFinal:AddClickListener(slot0._btnLeftArrowFinalOnClick, slot0)
	slot0._btnRightArrowFinal:AddClickListener(slot0._btnRightArrowFinalOnClick, slot0)
	slot0._btnStop:AddClickListener(slot0._btnStopOnClick, slot0)
	slot0._btnPlay:AddClickListener(slot0._btnPlayOnClick, slot0)
	slot0._btnpause:AddClickListener(slot0._btnpauseOnClick, slot0)
	slot0._btnSearch:AddClickListener(slot0._btnSearchOnClick, slot0)
	slot0._btnrollback:AddClickListener(slot0._btnrollbackOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnTips:RemoveClickListener()
	slot0._btnLeftArrow:RemoveClickListener()
	slot0._btnRightArrow:RemoveClickListener()
	slot0._btnLeftArrowFinal:RemoveClickListener()
	slot0._btnRightArrowFinal:RemoveClickListener()
	slot0._btnStop:RemoveClickListener()
	slot0._btnPlay:RemoveClickListener()
	slot0._btnpause:RemoveClickListener()
	slot0._btnSearch:RemoveClickListener()
	slot0._btnrollback:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
end

function slot0._btnTipsOnClick(slot0)
	Activity130Controller.instance:dispatchEvent(Activity130Event.ShowTipDialog, Activity130Config.instance:getActivity130DecryptCo(VersionActivity1_4Enum.ActivityId.Role37, slot0.puzzleCfg.puzzleId).puzzleTip)
end

function slot0._btnStopOnClick(slot0)
	if slot0._scrollTweenId then
		ZProj.TweenHelper.KillById(slot0._scrollTweenId)

		slot0._scrollTweenId = nil
	end

	gohelper.setActive(slot0._btnpause, false)
	gohelper.setActive(slot0._btnPlay, true)
	gohelper.setActive(slot0._goprotectArea, false)
	slot0:_stopAudio()
	slot0._progressAnimation:Play("go_progress_close")
	TaskDispatcher.runDelay(function (slot0)
		gohelper.setActive(slot0._goprogress, false)
	end, slot0, 0.3)
end

function slot0._btnPlayOnClick(slot0)
	slot0.recordScrollValue = nil
	slot0.lastStepsX = nil

	if slot0._goprogress.activeInHierarchy then
		if not slot0.curKey then
			return
		else
			slot0:_resumeProgressAnim()
			slot0:_resumeScrollPos()
			slot0:_resumeAudio()
		end
	else
		slot0.maxKey = 0

		for slot4, slot5 in pairs(slot0.operList) do
			if slot0.maxKey < slot4 then
				slot0.maxKey = slot4
			end
		end

		if slot0.maxKey == 0 then
			return
		else
			gohelper.setActive(slot0._goprogress, true)

			slot0._progressAnim.speed = 1

			slot0:_playAudio()

			slot0._scrollAreaList2.horizontalNormalizedPosition = 0
		end
	end

	gohelper.setActive(slot0._btnPlay, false)
	gohelper.setActive(slot0._btnpause, true)
	gohelper.setActive(slot0._goprotectArea, true)
end

function slot0._btnpauseOnClick(slot0)
	if slot0._scrollTweenId then
		ZProj.TweenHelper.KillById(slot0._scrollTweenId)

		slot0._scrollTweenId = nil
	end

	gohelper.setActive(slot0._btnpause, false)
	gohelper.setActive(slot0._btnPlay, true)
	gohelper.setActive(slot0._goprotectArea, false)
	slot0:_pauseAudio()

	slot0._progressAnim.speed = 0
	slot0.lastStepsX = recthelper.getAnchorX(slot0._gosteps.transform)
end

function slot0._btnLeftArrowOnClick(slot0)
	if slot0._scrollAreaList1.horizontalNormalizedPosition ~= 0 then
		if slot1 - 0.2 < 0 then
			slot1 = 0
		end

		slot0._scrollAreaList1.horizontalNormalizedPosition = slot1
	end
end

function slot0._btnRightArrowOnClick(slot0)
	if slot0._scrollAreaList1.horizontalNormalizedPosition ~= 1 then
		if slot1 + 0.2 > 1 then
			slot1 = 1
		end

		slot0._scrollAreaList1.horizontalNormalizedPosition = slot1
	end
end

function slot0._btnLeftArrowFinalOnClick(slot0)
	if slot0._scrollAreaList2.horizontalNormalizedPosition ~= 0 then
		if slot1 - 0.2 < 0 then
			slot1 = 0
		end

		slot0._scrollAreaList2.horizontalNormalizedPosition = slot1
	end
end

function slot0._btnRightArrowFinalOnClick(slot0)
	if slot0._scrollAreaList2.horizontalNormalizedPosition ~= 1 then
		if slot1 + 0.2 > 1 then
			slot1 = 1
		end

		slot0._scrollAreaList2.horizontalNormalizedPosition = slot1
	end
end

function slot0._btnSearchOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Role37PuzzleRecordView)
end

function slot0._btnrollbackOnClick(slot0)
	Role37PuzzleModel.instance:rollBack()
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130GameRestart, MsgBoxEnum.BoxType.Yes_No, function ()
		Activity130Rpc.instance:addGameChallengeNum(Activity130Model.instance:getCurEpisodeId())
		Role37PuzzleModel.instance:reset()
	end)
end

function slot0._editableInitView(slot0)
	slot0:_editableAddEvents()

	slot0.transform = slot0.viewGO.transform

	slot0:initViewCfg()
	gohelper.setActive(slot0._btnTips, not slot0.isFinal)
	slot0:_playFinalSound()
	slot0._scrollAreaList:AddOnValueChanged(slot0._onScrollValueChanged, slot0)

	slot0.answerPrefab = gohelper.findChild(slot0._gosteps, "answeritem")

	gohelper.setActive(slot0.answerPrefab, false)

	slot0.dragGo = gohelper.clone(slot0.answerPrefab, slot0.viewGO, "dragItem")
	slot0.dragImgDesc = gohelper.findChildImage(slot0.dragGo, "img_ItemIcon")
	slot0.dragImgyyDesc = gohelper.findChildImage(slot0.dragGo, "img_ItemIcon_yy")
	slot0.dragAnim = slot0.dragGo:GetComponent(typeof(UnityEngine.Animator))
	slot0._goComplete = gohelper.findChild(slot0.viewGO, "QuestionPanelCommon/anim_Completed")
	slot0._goVxprogress = gohelper.findChild(slot0._goprogress, "vx_progress")
	slot0._progressAnimation = slot0._goprogress:GetComponent(typeof(UnityEngine.Animation))
	slot0._progressAnim = slot0._goVxprogress:GetComponent(typeof(UnityEngine.Animator))
	slot0.answerList = {}
	slot0.frameItemList = {}
	slot0.optionItemList = {}
	slot0.recordItemList = {}

	slot0:refreshUI()
end

function slot0.initViewCfg(slot0)
	slot0.puzzleCfg = Role37PuzzleModel.instance:getPuzzleCfg()
	slot0.puzzleId = slot0.puzzleCfg.puzzleId
	slot0.maxOper = slot0.puzzleCfg.maxOper
	slot0.operGroupCfg = Role37PuzzleModel.instance:getOperGroupCfg()
	slot0.operList = Role37PuzzleModel.instance:getOperList()

	if slot0.puzzleId ~= Role37PuzzleEnum.PuzzleId.Final then
		slot0.isFinal = false
		slot0.realOper = slot0._gobaseoper
		slot0._gostepframes = slot0._gostepframes1
		slot0._gosteps = slot0._gosteps1
		slot0._scrollAreaList = slot0._scrollAreaList1
		slot0.goLeftArrow = slot0._btnLeftArrow
		slot0.goRightArrow = slot0._btnRightArrow
	else
		slot0.isFinal = true
		slot0.realOper = slot0._gofinaloper
		slot0._gostepframes = slot0._gostepframes2
		slot0._gosteps = slot0._gosteps2
		slot0._scrollAreaList = slot0._scrollAreaList2
		slot0.goLeftArrow = slot0._btnLeftArrowFinal
		slot0.goRightArrow = slot0._btnRightArrowFinal
	end
end

function slot0.refreshUI(slot0)
	if Activity130Config.instance:getActivity130EpisodeCo(Activity130Enum.ActivityId.Act130, Activity130Model.instance:getCurEpisodeId()) then
		slot0._txtStageEn.text = slot2.episodetag
		slot0._txtStageName.text = slot2.name
		slot0._txtTargetDesc.text = slot2.conditionStr
	end

	slot0._txtQuestion.text = slot0.puzzleCfg.puzzleTxt

	gohelper.setActive(slot0._goBaseQuestionPanel, not slot0.isFinal)
	gohelper.setActive(slot0._goFinalQuestionPanel, slot0.isFinal)
	slot0:onRecordChange(PuzzleRecordListModel.instance:getCount())
	slot0:_initPutArea()
	slot0:_initOptionItem()
end

function slot0._initOptionItem(slot0)
	for slot4 = 1, 6 do
		slot0:_creatOptionItem(slot4)
	end

	for slot5 = 1, #Role37PuzzleModel.instance:getOperGroupList() do
		slot6 = slot1[slot5].operType

		if not slot0.optionItemList[slot5] then
			gohelper.setActive(slot0:_creatOptionItem(slot5).go, true)
		end

		slot7.button = gohelper.findChildButton(slot7.go, "")

		slot7.button:AddClickListener(slot0._optionClick, slot0, slot6)

		slot7.uidrag = SLFramework.UGUI.UIDragListener.Get(slot7.go)

		slot7.uidrag:AddDragBeginListener(slot0._optionDragBegin, slot0, slot6)
		slot7.uidrag:AddDragListener(slot0._optionDrag, slot0)
		slot7.uidrag:AddDragEndListener(slot0._optionDragEnd, slot0, slot6)

		if not slot0.isFinal then
			gohelper.setActive(gohelper.findChildImage(slot7.go, "image_Empty"), false)

			slot9 = gohelper.findChildImage(slot7.go, "image_Icon")
			slot10 = gohelper.findChildText(slot7.go, "txt_tip")

			UISpriteSetMgr.instance:setV1a4Role37Sprite(slot9, slot1[slot5].shapeImg)

			slot10.text = slot1[slot5].operDesc
			gohelper.findChildText(slot7.go, "txt_Type").text = slot1[slot5].name

			gohelper.setActive(slot9, true)
			gohelper.setActive(slot10, true)
		end
	end
end

function slot0._creatOptionItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.findChild(slot0.realOper, "option" .. slot1)
	slot0.optionItemList[slot1] = slot2

	return slot2
end

function slot0._initPutArea(slot0)
	slot1 = gohelper.findChild(slot0._gostepframes, "stepframe")

	for slot5 = 1, slot0.maxOper do
		slot6 = slot0:getUserDataTb_()
		slot6.go = gohelper.cloneInPlace(slot1, "stepframe" .. slot5)
		slot6.notPutImage = gohelper.findChildImage(slot6.go, "noPut")
		slot6.putImage = gohelper.findChildImage(slot6.go, "put")
		slot0.frameItemList[slot5] = slot6
	end

	gohelper.setActive(slot1, false)
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.AddOption, slot0.onAddOption, slot0)
	slot0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RemoveOption, slot0.onRemoveOption, slot0)
	slot0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.ExchangeOption, slot0.onExchangeOption, slot0)
	slot0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RepleaceOption, slot0.onRepleaceOption, slot0)
	slot0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.MoveOption, slot0.onMoveOption, slot0)
	slot0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.Reset, slot0.onReset, slot0)
	slot0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, slot0.onPuzzleFinish, slot0)
	slot0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RecordCntChange, slot0.onRecordChange, slot0)
	slot0:addEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.ErrorOperChange, slot0.onErrorOper, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.AddOption, slot0.onAddOption, slot0)
	slot0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RemoveOption, slot0.onRemoveOption, slot0)
	slot0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.ExchangeOption, slot0.onExchangeOption, slot0)
	slot0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RepleaceOption, slot0.onRepleaceOption, slot0)
	slot0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.MoveOption, slot0.onMoveOption, slot0)
	slot0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.Reset, slot0.onReset, slot0)
	slot0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.PuzzleResult, slot0.onPuzzleFinish, slot0)
	slot0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.RecordCntChange, slot0.onRecordChange, slot0)
	slot0:removeEventCb(Role37PuzzleController.instance, Role37PuzzleEvent.ErrorOperChange, slot0.onErrorOper, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._scrollAreaList:RemoveOnValueChanged()

	for slot4 = 1, tabletool.len(slot0.operGroupCfg) do
		slot5 = slot0.optionItemList[slot4]

		slot5.button:RemoveClickListener()
		slot5.uidrag:RemoveDragBeginListener()
		slot5.uidrag:RemoveDragListener()
		slot5.uidrag:RemoveDragEndListener()
	end

	slot0:_editableRemoveEvents()
	TaskDispatcher.cancelTask(slot0._playAudioLoop, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.resume_plotmusic_sound)
	slot0:_closeFinalSound()
end

function slot0._optionClick(slot0, slot1)
	if slot0.optionDrag then
		return
	end

	Role37PuzzleModel.instance:addOption(slot1, Role37PuzzleModel.instance:getFirstGapIndex())
	AudioMgr.instance:trigger(Role37PuzzleModel.instance:getOperAudioId(slot1))
end

function slot0._optionDragBegin(slot0, slot1, slot2)
	slot0.optionDrag = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_drag)

	slot3 = recthelper.screenPosToAnchorPos(slot2.position, slot0.transform)

	UISpriteSetMgr.instance:setV1a4Role37Sprite(slot0.dragImgDesc, slot0.operGroupCfg[slot1].shapeImg)
	UISpriteSetMgr.instance:setV1a4Role37Sprite(slot0.dragImgyyDesc, slot0.operGroupCfg[slot1].shapeImg .. "_yy")
	gohelper.setActive(slot0.dragGo, true)
	slot0.dragAnim:Play("in", 0, 0)
	recthelper.setAnchor(slot0.dragGo.transform, slot3.x, slot3.y)
end

function slot0._optionDrag(slot0, slot1, slot2)
	slot3 = recthelper.screenPosToAnchorPos(slot2.position, slot0.transform)

	if slot0.optionDrag then
		recthelper.setAnchor(slot0.dragGo.transform, slot3.x, slot3.y)
	end
end

function slot0._optionDragEnd(slot0, slot1, slot2)
	if not slot0.optionDrag then
		return
	end

	slot0.optionDrag = false

	slot0.dragAnim:Play("put", 0, 0)

	slot3 = recthelper.screenPosToAnchorPos(slot2.position, slot0.transform)
	slot4 = nil

	for slot8 = 1, slot0.maxOper do
		if math.abs(recthelper.screenPosToAnchorPos(recthelper.uiPosToScreenPos(slot0.frameItemList[slot8].go.transform), slot0.transform).x - slot3.x) < 75 and math.abs(slot10.y - slot3.y) < 75 then
			slot4 = slot8

			break
		end
	end

	if slot4 then
		Role37PuzzleModel.instance:addOption(slot1, slot4)
		slot0:_playDragEndAudio(slot1)
	end

	gohelper.setActive(slot0.dragGo, false)
end

function slot0._onScrollValueChanged(slot0, slot1)
	recthelper.setAnchorX(slot0._gosteps.transform, recthelper.getAnchorX(slot0._gostepframes.transform))

	if slot0.lastStepsX then
		if not slot0.recordScrollValue then
			slot0.recordScrollValue = slot0._progressAnim:GetCurrentAnimatorStateInfo(0).normalizedTime
		end

		slot0.recordScrollValue = slot0.recordScrollValue + 0.000748 * (slot2 - slot0.lastStepsX)

		if slot0.recordScrollValue > 1 then
			slot5 = 1
		elseif slot5 < 0 then
			slot5 = 0
		end

		slot0._progressAnim:Play("play", 0, slot5)

		slot0.lastStepsX = slot2
	end

	if slot1 <= 0.01 then
		gohelper.setActive(slot0.goLeftArrow, false)
		gohelper.setActive(slot0.goRightArrow, true)
	elseif slot1 >= 0.99 then
		gohelper.setActive(slot0.goLeftArrow, true)
		gohelper.setActive(slot0.goRightArrow, false)
	else
		gohelper.setActive(slot0.goLeftArrow, true)
		gohelper.setActive(slot0.goRightArrow, true)
	end
end

function slot0.onAddOption(slot0, slot1)
	slot2 = gohelper.cloneInPlace(slot0.answerPrefab)

	gohelper.setActive(slot2, true)

	slot2.name = "answerItem" .. slot1
	slot0.answerList[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(slot2, OptionItem)

	slot0.answerList[slot1]:initParam(slot1, slot0.frameItemList, slot0.viewGO, slot0.isFinal)
	slot0:_skipToPos(slot1, slot0.maxOper)
	slot0:refreshNum()
	slot0:setFramePut(slot1, true)
end

function slot0.onRemoveOption(slot0, slot1)
	gohelper.destroy(slot0.answerList[slot1].go)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_delete)

	slot0.answerList[slot1] = nil

	slot0:refreshNum()
	slot0:setFramePut(slot1, false)
end

function slot0.onExchangeOption(slot0, slot1, slot2)
	slot0.answerList[slot1] = slot0.answerList[slot2]
	slot0.answerList[slot2] = slot0.answerList[slot1]

	slot0.answerList[slot1]:updateIndex(slot1)
	slot0.answerList[slot2]:updateIndex(slot2)
	slot0.answerList[slot1]:calculateDefalutPos()
	slot0.answerList[slot2]:calculateDefalutPos()
	slot0.answerList[slot1]:_setDefalutPos(true)
	slot0.answerList[slot2]:_setDefalutPos(true)
	slot0:refreshNum()
	slot0:refreshErrorOper()
end

function slot0.onMoveOption(slot0, slot1, slot2)
	slot0.answerList[slot2] = slot0.answerList[slot1]
	slot0.answerList[slot1] = nil

	slot0.answerList[slot2]:updateIndex(slot2)
	slot0.answerList[slot2]:calculateDefalutPos()
	slot0.answerList[slot2]:_setDefalutPos(true)
	slot0:refreshNum()
	slot0:setFramePut(slot1, false)
	slot0:setFramePut(slot2, true)
end

function slot0.onRepleaceOption(slot0, slot1, slot2)
	slot0.answerList[slot2]:updateIndex(slot2)
	slot0.answerList[slot2]:refreshSprite()
	slot0:refreshNum()
end

function slot0.onReset(slot0)
	for slot4, slot5 in pairs(slot0.answerList) do
		gohelper.destroy(slot5.go)
		slot0:setFramePut(slot4, false)
	end

	slot0.answerList = {}
	slot0.operList = Role37PuzzleModel.instance:getOperList()
	slot0._scrollAreaList.horizontalNormalizedPosition = 0
end

function slot0.onPuzzleFinish(slot0, slot1)
	if slot1 then
		StatActivity130Controller.instance:statSuccess()
	else
		StatActivity130Controller.instance:statFail()
	end

	gohelper.setActive(slot0._imageTargetFinish, slot1)
	gohelper.setActive(slot0._imageTargetNotFinish, not slot1)

	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		gohelper.setActive(slot0._goQuestion, false)
		gohelper.setActive(slot0._goComplete, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_completed_writing)
		UIBlockMgr.instance:startBlock("puzzleFinish")
		TaskDispatcher.runDelay(slot0.onAnimFinish, slot0, 2)
	else
		Role37PuzzleController.instance:openPuzzleResultView()
	end
end

function slot0.onAnimFinish(slot0)
	if slot0.isFinal then
		slot0:_btnPlayOnClick()
		TaskDispatcher.runDelay(function ()
			UIBlockMgr.instance:endBlock("puzzleFinish")
			Role37PuzzleController.instance:openPuzzleResultView()
		end, nil, 10)
	else
		UIBlockMgr.instance:endBlock("puzzleFinish")
		Role37PuzzleController.instance:openPuzzleResultView()
	end
end

function slot0.onRecordChange(slot0, slot1)
	slot0._txtround.text = string.format(luaLang("v1a4_role37_puzzle_round"), slot1)

	gohelper.setActive(slot0._goRecordEmpty, slot1 <= 0)
	slot0:refreshRecord(slot1)
	ZProj.UGUIHelper.RebuildLayout(slot0._scrollrecord.content)

	slot0._scrollrecord.verticalNormalizedPosition = 0
end

function slot0.refreshRecord(slot0, slot1)
	if slot1 >= #slot0.recordItemList then
		for slot6 = 1, slot1 do
			slot7 = slot0:getRecordItem(slot6)

			slot7.comp:onUpdateMO(Role37PuzzleModel.instance:getRecordMo(slot6))
			gohelper.setActive(slot7.go, true)
		end
	else
		for slot6 = 1, slot2 do
			slot7 = slot0:getRecordItem(slot6)

			if slot6 <= slot1 then
				slot7.comp:onUpdateMO(Role37PuzzleModel.instance:getRecordMo(slot6))
				gohelper.setActive(slot7.go, true)
			else
				gohelper.setActive(slot7.go, false)
			end
		end
	end
end

function slot0.getRecordItem(slot0, slot1)
	if not slot0.recordItemList[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._goRecordItem, "record_" .. slot1)

		table.insert(slot0.recordItemList, {
			go = slot3,
			comp = MonoHelper.addNoUpdateLuaComOnceToGo(slot3, PuzzleRecordItem)
		})
	end

	return slot2
end

function slot0._skipToPos(slot0, slot1, slot2)
	slot3, slot4 = nil

	if slot0.isFinal then
		if slot1 - 9 < 0 then
			slot0._scrollAreaList2.horizontalNormalizedPosition = 0

			return
		end

		if 0.015 + slot5 * 0.01971 > 1 then
			slot8 = 1
		end

		slot0._scrollAreaList2.horizontalNormalizedPosition = slot8
	else
		if slot1 - 6 < 0 then
			slot0._scrollAreaList1.horizontalNormalizedPosition = 0

			return
		end

		slot4 = 200 * slot2 + 10 * (slot2 - 1) + 5
		slot6 = (slot4 - 1380) / slot4 * slot2
		slot7, slot8 = math.modf(slot6)

		if 1 / slot6 * (slot8 + slot5) > 1 then
			slot10 = 1
		end

		slot0._scrollAreaList1.horizontalNormalizedPosition = slot10
	end
end

function slot0.onErrorOper(slot0, slot1)
	if Role37PuzzleModel.instance:getErrorCnt() == 1 and slot1 ~= 0 then
		Activity130Controller.instance:dispatchEvent(Activity130Event.ShowTipDialog, Activity130Config.instance:getActivity130DecryptCo(VersionActivity1_4Enum.ActivityId.Role37, slot0.puzzleCfg.puzzleId).errorTip)
	end

	slot0:refreshErrorOper()
end

function slot0.refreshErrorOper(slot0)
	if Role37PuzzleModel.instance:getCurErrorIndex() == 0 then
		slot1 = 9999
	end

	for slot5, slot6 in pairs(slot0.answerList) do
		slot6:setError(slot1 <= slot5)
	end
end

function slot0._playAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.pause_plotmusic_sound)

	slot0.curKey = 1

	TaskDispatcher.runDelay(slot0._playAudioLoop, slot0, uv0.StartDealy)
end

function slot0._pauseAudio(slot0)
	TaskDispatcher.cancelTask(slot0._playAudioLoop, slot0)
end

function slot0._resumeAudio(slot0)
	for slot4, slot5 in pairs(slot0.operList) do
		if slot0.maxKey < slot4 then
			slot0.maxKey = slot4
		end
	end

	slot0:_playAudioLoop()
	TaskDispatcher.runRepeat(slot0._playAudioLoop, slot0, uv0.AudioInterval)
end

function slot0._stopAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.resume_plotmusic_sound)
	TaskDispatcher.cancelTask(slot0._playAudioLoop, slot0)

	slot0.curAudioId = nil
	slot0.curKey = nil
end

function slot0._playAudioLoop(slot0)
	if slot0.curKey then
		if slot0.curKey == 1 then
			TaskDispatcher.runRepeat(slot0._playAudioLoop, slot0, uv0.AudioInterval)
		end

		if slot0.curKey >= 8 then
			slot0._progressAnim.speed = 0
		end

		slot0:_tweenToScrollPos(slot0.curKey)

		if slot0.operList[slot0.curKey] then
			slot0.curAudioId = slot0.operGroupCfg[slot1].audioId

			AudioMgr.instance:trigger(slot0.curAudioId)
		else
			slot0:_playEmptyAudio()
		end

		slot0.curKey = slot0.curKey + 1

		if slot0.maxKey < slot0.curKey then
			TaskDispatcher.runDelay(slot0._btnStopOnClick, slot0, uv0.AudioInterval / 2 - 0.1)
		end
	end
end

function slot0._playEmptyAudio(slot0)
end

function slot0._resumeProgressAnim(slot0)
	if slot0.curKey > 8 then
		slot0._progressAnim:Play("play", 0, 0.82188)

		slot0._progressAnim.speed = 1
	else
		slot0._progressAnim:CrossFadeInFixedTime("play", 0, 0, 0.9 + (slot0.curKey - 1) * 0.867)

		slot0._progressAnim.speed = 1
	end
end

function slot0._resumeScrollPos(slot0)
	if slot0.curKey > 8 then
		slot0._scrollAreaList2.horizontalNormalizedPosition = (slot0.curKey - 8) * 0.01971
	else
		slot0._scrollAreaList2.horizontalNormalizedPosition = 0
	end
end

function slot0._tweenToScrollPos(slot0, slot1)
	if slot1 - 8 < 0 then
		return
	end

	if slot0._scrollAreaList2.horizontalNormalizedPosition + 0.01971 > 1 then
		slot5 = 1
	end

	slot0._scrollTweenId = ZProj.TweenHelper.DOTweenFloat(slot3, slot5, uv0.AudioInterval, slot0.setScrollValue, nil, slot0, nil, EaseType.Linear)
end

function slot0.setScrollValue(slot0, slot1)
	slot0._scrollAreaList2.horizontalNormalizedPosition = slot1
end

function slot0.refreshNum(slot0)
	for slot5 = 1, tabletool.len(slot0.answerList) do
		while slot0.answerList[slot5 + 0] == nil do
			slot6 = slot0.answerList[slot5 + slot1 + 1]
		end

		slot6:setNum(slot5)
	end
end

function slot0.setFramePut(slot0, slot1, slot2)
	gohelper.setActive(slot0.frameItemList[slot1].notPutImage, not slot2)
	gohelper.setActive(slot0.frameItemList[slot1].putImage, slot2)
end

function slot0._playFinalSound(slot0)
	if slot0.isFinal then
		slot0:_closeFinalSound()

		slot0._finalSoundId = AudioMgr.instance:trigger(AudioEnum.UI.set_activityvolume_on)
	end
end

function slot0._closeFinalSound(slot0)
	if slot0._finalSoundId then
		AudioMgr.instance:trigger(AudioEnum.UI.set_activityvolume_off)

		slot0._finalSoundId = nil
	end
end

function slot0._playDragEndAudio(slot0, slot1)
	if Activity130Model.instance:getCurEpisodeId() == 7 then
		AudioMgr.instance:trigger(Role37PuzzleModel.instance:getOperAudioId(slot1))
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_graph_put)
	end
end

return slot0
