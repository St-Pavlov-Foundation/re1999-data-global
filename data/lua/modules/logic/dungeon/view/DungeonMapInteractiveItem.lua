module("modules.logic.dungeon.view.DungeonMapInteractiveItem", package.seeall)

slot0 = class("DungeonMapInteractiveItem", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnfightuiuse = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_fight_ui_use")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "rotate/bg/scroll/#txt_info")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "rotate/bg/#go_mask")
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "rotate/bg/#go_mask/#go_scroll")
	slot0._gochatarea = gohelper.findChild(slot0.viewGO, "rotate/bg/#go_chatarea")
	slot0._gochatitem = gohelper.findChild(slot0.viewGO, "rotate/bg/#go_chatarea/#go_chatitem")
	slot0._goimportanttips = gohelper.findChild(slot0.viewGO, "rotate/bg/#go_importanttips")
	slot0._txttipsinfo = gohelper.findChildText(slot0.viewGO, "rotate/bg/#go_importanttips/bg/#txt_tipsinfo")
	slot0._goop1 = gohelper.findChild(slot0.viewGO, "rotate/#go_op1")
	slot0._txtdoit = gohelper.findChildText(slot0.viewGO, "rotate/#go_op1/bg/#txt_doit")
	slot0._btndoit = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op1/bg/#btn_doit")
	slot0._goop2 = gohelper.findChild(slot0.viewGO, "rotate/#go_op2")
	slot0._gofinishFight = gohelper.findChild(slot0.viewGO, "rotate/#go_op2/#go_finishFight")
	slot0._txtwin = gohelper.findChildText(slot0.viewGO, "rotate/#go_op2/#go_finishFight/bg/#txt_win")
	slot0._btnwin = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op2/#go_finishFight/bg/#btn_win")
	slot0._gounfinishedFight = gohelper.findChild(slot0.viewGO, "rotate/#go_op2/#go_unfinishedFight")
	slot0._txtfight = gohelper.findChildText(slot0.viewGO, "rotate/#go_op2/#go_unfinishedFight/bg/#txt_fight")
	slot0._btnfight = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op2/#go_unfinishedFight/bg/#btn_fight")
	slot0._goop3 = gohelper.findChild(slot0.viewGO, "rotate/#go_op3")
	slot0._gounfinishtask = gohelper.findChild(slot0.viewGO, "rotate/#go_op3/#go_unfinishtask")
	slot0._txtunfinishtask = gohelper.findChildText(slot0.viewGO, "rotate/#go_op3/#go_unfinishtask/#txt_unfinishtask")
	slot0._btnunfinishtask = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op3/#go_unfinishtask/#btn_unfinishtask")
	slot0._gofinishtask = gohelper.findChild(slot0.viewGO, "rotate/#go_op3/#go_finishtask")
	slot0._txtfinishtask = gohelper.findChildText(slot0.viewGO, "rotate/#go_op3/#go_finishtask/#txt_finishtask")
	slot0._btnfinishtask = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op3/#go_finishtask/#btn_finishtask")
	slot0._goop4 = gohelper.findChild(slot0.viewGO, "rotate/#go_op4")
	slot0._gonext = gohelper.findChild(slot0.viewGO, "rotate/#go_op4/#go_next")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op4/#go_next/#btn_next")
	slot0._gooptions = gohelper.findChild(slot0.viewGO, "rotate/#go_op4/#go_options")
	slot0._gotalkitem = gohelper.findChild(slot0.viewGO, "rotate/#go_op4/#go_options/#go_talkitem")
	slot0._gofinishtalk = gohelper.findChild(slot0.viewGO, "rotate/#go_op4/#go_finishtalk")
	slot0._btnfinishtalk = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op4/#go_finishtalk/#btn_finishtalk")
	slot0._goop5 = gohelper.findChild(slot0.viewGO, "rotate/#go_op5")
	slot0._gosubmit = gohelper.findChild(slot0.viewGO, "rotate/#go_op5/#go_submit")
	slot0._btnsubmit = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op5/#go_submit/#btn_submit")
	slot0._inputanswer = gohelper.findChildTextMeshInputField(slot0.viewGO, "rotate/#go_op5/#input_answer")
	slot0._goop8 = gohelper.findChild(slot0.viewGO, "rotate/#go_op8")
	slot0._gopuzzlequestion = gohelper.findChild(slot0.viewGO, "rotate/#go_op8/#go_puzzle_question")
	slot0._txtpuzzlequestion = gohelper.findChildText(slot0.viewGO, "rotate/#go_op8/#go_puzzle_question/#txt_puzzle_question")
	slot0._btnpuzzlequestion = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op8/#go_puzzle_question/#btn_puzzle_question")
	slot0._gopuzzlequestionfinish = gohelper.findChild(slot0.viewGO, "rotate/#go_op8/#go_puzzle_question_finish")
	slot0._btnpuzzlequestionfinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op8/#go_puzzle_question_finish/#btn_puzzle_question_finish")
	slot0._goop9 = gohelper.findChild(slot0.viewGO, "rotate/#go_op9")
	slot0._gopipe = gohelper.findChild(slot0.viewGO, "rotate/#go_op9/#go_pipe")
	slot0._txtpuzzlepipe = gohelper.findChildText(slot0.viewGO, "rotate/#go_op9/#go_pipe/#txt_puzzle_pipe")
	slot0._btnpuzzlepipe = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op9/#go_pipe/#btn_puzzle_pipe")
	slot0._gopipefinish = gohelper.findChild(slot0.viewGO, "rotate/#go_op9/#go_pipe_finish")
	slot0._btnpipefinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op9/#go_pipe_finish/#btn_pipe_finish")
	slot0._goop10 = gohelper.findChild(slot0.viewGO, "rotate/#go_op10")
	slot0._gochangecolor = gohelper.findChild(slot0.viewGO, "rotate/#go_op10/#go_changecolor")
	slot0._txtpuzzlechangecolor = gohelper.findChildText(slot0.viewGO, "rotate/#go_op10/#go_changecolor/#txt_changecolor_pipe")
	slot0._btnpuzzlechangecolor = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op10/#go_changecolor/#btn_puzzle_changecolor")
	slot0._gochangecolorfinish = gohelper.findChild(slot0.viewGO, "rotate/#go_op10/#go_changecolor_finish")
	slot0._btnchangecolorfinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op10/#go_changecolor_finish/#btn_changecolor_finish")
	slot0._goop12 = gohelper.findChild(slot0.viewGO, "rotate/#go_op12")
	slot0._gomazedraw = gohelper.findChild(slot0.viewGO, "rotate/#go_op12/#go_maze_draw")
	slot0._txtmazedraw = gohelper.findChildText(slot0.viewGO, "rotate/#go_op12/#go_maze_draw/#txt_maze_draw")
	slot0._btnmazedraw = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op12/#go_maze_draw/#btn_maze_draw")
	slot0._gomazedrawfinish = gohelper.findChild(slot0.viewGO, "rotate/#go_op12/#go_maze_draw_finish")
	slot0._btnmazedrawfinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op12/#go_maze_draw_finish/#btn_maze_draw_finish")
	slot0._goop13 = gohelper.findChild(slot0.viewGO, "rotate/#go_op13")
	slot0._gocubegame = gohelper.findChild(slot0.viewGO, "rotate/#go_op13/#go_cube_game")
	slot0._btncubegame = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op13/#go_cube_game/#btn_cube_game")
	slot0._gocubegamefinish = gohelper.findChild(slot0.viewGO, "rotate/#go_op13/#go_cube_game_finish")
	slot0._btncubegamefinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op13/#go_cube_game_finish/#btn_cube_game_finish")
	slot0._goop15 = gohelper.findChild(slot0.viewGO, "rotate/#go_op15")
	slot0._goouijagame = gohelper.findChild(slot0.viewGO, "rotate/#go_op15/#go_ouija_game")
	slot0._txtouija = gohelper.findChildText(slot0.viewGO, "rotate/#go_op15/#go_ouija_game/#txt_ouija_game")
	slot0._btnouijagame = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op15/#go_ouija_game/#btn_ouija_game")
	slot0._goouijagamefinish = gohelper.findChild(slot0.viewGO, "rotate/#go_op15/#go_ouija_game_finish")
	slot0._btnouijagamefinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op15/#go_ouija_game_finish/#btn_ouija_game_finish")
	slot0._goop101 = gohelper.findChild(slot0.viewGO, "rotate/#go_op101")
	slot0._goop101puzzle = gohelper.findChild(slot0.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle")
	slot0._txt101puzzle = gohelper.findChildText(slot0.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle/#txt_puzzle")
	slot0._btn101puzzle = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle/#btn_puzzle")
	slot0._goop101puzzlefinish = gohelper.findChild(slot0.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle_finish")
	slot0._btn101puzzlefinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#go_op101/#go_versionactivity_puzzle_finish/#btn_puzzle_finish")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "rotate/layout/top/title/#txt_title")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnfightuiuse:AddClickListener(slot0._btnfightuiuseOnClick, slot0)
	slot0._btndoit:AddClickListener(slot0._btndoitOnClick, slot0)
	slot0._btnwin:AddClickListener(slot0._btnwinOnClick, slot0)
	slot0._btnfight:AddClickListener(slot0._btnfightOnClick, slot0)
	slot0._btnunfinishtask:AddClickListener(slot0._btnunfinishtaskOnClick, slot0)
	slot0._btnfinishtask:AddClickListener(slot0._btnfinishtaskOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnfinishtalk:AddClickListener(slot0._btnfinishtalkOnClick, slot0)
	slot0._btnsubmit:AddClickListener(slot0._btnsubmitOnClick, slot0)
	slot0._btnpuzzlequestion:AddClickListener(slot0._btnpuzzlequestionOnClick, slot0)
	slot0._btnpuzzlequestionfinish:AddClickListener(slot0._btnpuzzlequestionfinishOnClick, slot0)
	slot0._btnpuzzlepipe:AddClickListener(slot0._btnpuzzlepipeOnClick, slot0)
	slot0._btnpipefinish:AddClickListener(slot0._btnpipefinishOnClick, slot0)
	slot0._btnpuzzlechangecolor:AddClickListener(slot0._btnpuzzlechangecolorOnClick, slot0)
	slot0._btnchangecolorfinish:AddClickListener(slot0._btnchangecolorfinishOnClick, slot0)
	slot0._btnmazedraw:AddClickListener(slot0._btnmazedrawOnClick, slot0)
	slot0._btnmazedrawfinish:AddClickListener(slot0._btnmazedrawfinishOnClick, slot0)
	slot0._btncubegame:AddClickListener(slot0._btnputcubegameOnClick, slot0)
	slot0._btncubegamefinish:AddClickListener(slot0._btnPutCubeGameFinishOnClick, slot0)
	slot0._btnouijagame:AddClickListener(slot0._btnOuijagameOnClick, slot0)
	slot0._btnouijagamefinish:AddClickListener(slot0._btnOuijaGameFinishOnClick, slot0)
	slot0._inputanswer:AddOnEndEdit(slot0._onInputAnswerEndEdit, slot0)
	slot0._btn101puzzle:AddClickListener(slot0._btn101PuzzleGameOnClick, slot0)
	slot0._btn101puzzlefinish:AddClickListener(slot0._btn101PuzzleGameFinishOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnfightuiuse:RemoveClickListener()
	slot0._btndoit:RemoveClickListener()
	slot0._btnwin:RemoveClickListener()
	slot0._btnfight:RemoveClickListener()
	slot0._btnunfinishtask:RemoveClickListener()
	slot0._btnfinishtask:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btnfinishtalk:RemoveClickListener()
	slot0._btnsubmit:RemoveClickListener()
	slot0._btnpuzzlequestion:RemoveClickListener()
	slot0._btnpuzzlequestionfinish:RemoveClickListener()
	slot0._btnpuzzlepipe:RemoveClickListener()
	slot0._btnpipefinish:RemoveClickListener()
	slot0._btnpuzzlechangecolor:RemoveClickListener()
	slot0._btnchangecolorfinish:RemoveClickListener()
	slot0._btnmazedraw:RemoveClickListener()
	slot0._btnmazedrawfinish:RemoveClickListener()
	slot0._btncubegame:RemoveClickListener()
	slot0._btncubegamefinish:RemoveClickListener()
	slot0._btnouijagame:RemoveClickListener()
	slot0._btnouijagamefinish:RemoveClickListener()
	slot0._inputanswer:RemoveOnEndEdit()
	slot0._btn101puzzle:RemoveClickListener()
	slot0._btn101puzzlefinish:RemoveClickListener()
end

function slot0._btnfightuiuseOnClick(slot0)
	slot0:_btnfightOnClick()
end

function slot0._btnsubmitOnClick(slot0)
	slot1 = slot0._inputanswer:GetText()
	slot2 = slot0._config.param

	if not string.nilorempty(slot0._config.paramLang) then
		slot2 = slot0._config.paramLang
	end

	if slot0:_checkAnswer(slot2, slot1) then
		slot0:_onHide()
		DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	else
		slot0._inputanswer:SetText("")
		GameFacade.showToast(ToastEnum.DungeonMapInteractive)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._checkAnswer(slot0, slot1, slot2)
	slot3 = {}

	if not string.nilorempty(slot1) then
		if string.find(slot1, "|") then
			slot3 = string.split(slot1, "|")
		else
			table.insert(slot3, slot1)
		end
	end

	for slot7, slot8 in pairs(slot3) do
		if slot2 == slot8 then
			return true
		end
	end

	return false
end

function slot0._btncloseOnClick(slot0)
	if slot0._playScrollAnim then
		return
	end

	slot0:_onHide()
end

function slot0._closeMapInteractiveItem(slot0)
	slot0:_onHide()
end

function slot0._btnfinishtalkOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id, DungeonMapModel.instance:getDialogId())
	DungeonMapModel.instance:clearDialogId()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btndoitOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnfightOnClick(slot0)
	slot0:_onHide()

	slot1 = tonumber(slot0._config.param)
	DungeonModel.instance.curLookEpisodeId = slot1

	if TeachNoteModel.instance:isTeachNoteEpisode(slot1) then
		TeachNoteController.instance:enterTeachNoteDetailView(slot1)
	else
		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot1).chapterId, slot1)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnwinOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnunfinishtaskOnClick(slot0)
	slot0:_onHide()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnfinishtaskOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnnextOnClick(slot0)
	if slot0._playScrollAnim then
		return
	end

	slot0:_playNextSectionOrDialog()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnpuzzlequestionOnClick(slot0)
	slot0:_asynHide(ViewName.DungeonPuzzleQuestionView)
	DungeonPuzzleQuestionModel.instance:initByElementCo(slot0._config)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleQuestionView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnpuzzlequestionfinishOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnpuzzlepipeOnClick(slot0)
	if slot0._config.type == DungeonEnum.ElementType.CircuitGame then
		slot0:_asynHide(ViewName.DungeonPuzzleCircuitView)
		DungeonPuzzleCircuitController.instance:openGame(slot0._config)

		return
	end

	slot0:_asynHide(ViewName.DungeonPuzzlePipeView)
	DungeonPuzzlePipeController.instance:openGame(slot0._config)
end

function slot0._btnpipefinishOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnpuzzlechangecolorOnClick(slot0)
	slot0:_asynHide(ViewName.DungeonPuzzleChangeColorView)
	DungeonPuzzleChangeColorController.instance:enterDecryptChangeColor(tonumber(slot0._config.param))
end

function slot0._btnmazedrawOnClick(slot0)
	slot0:_asynHide(ViewName.DungeonPuzzleMazeDrawView)
	DungeonPuzzleMazeDrawController.instance:openGame(slot0._config)
end

function slot0._btnmazedrawfinishOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btnputcubegameOnClick(slot0)
	slot0:_asynHide(ViewName.PutCubeGameView)
	DungeonController.instance:openPutCubeGameView(slot0._config)
end

function slot0._btnPutCubeGameFinishOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
end

function slot0._btnOuijagameOnClick(slot0)
	slot0:_asynHide(ViewName.DungeonPuzzleOuijaView)
	AudioMgr.instance:trigger(AudioEnum.PuzzleOuija.play_ui_checkpoint_boat_open)
	DungeonController.instance:openOuijaGameView(slot0._config)
end

function slot0._btnOuijaGameFinishOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
end

function slot0._btnchangecolorfinishOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btn101PuzzleGameOnClick(slot0)
	slot0:_onHide()
	ViewMgr.instance:openView(ViewName.VersionActivityPuzzleView, {
		elementCo = slot0._config
	})
end

function slot0._btn101PuzzleGameFinishOnClick(slot0)
	slot0:_onHide()
	DungeonRpc.instance:sendMapElementRequest(slot0._config.id)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._btntalkitemOnClick(slot0)
end

function slot0._editableInitView(slot0)
	DungeonMapModel.instance:setMapInteractiveItemVisible(true)

	slot0._nextAnimator = slot0._gonext:GetComponent(typeof(UnityEngine.Animator))
	slot0._imgMask = slot0._gomask:GetComponent(gohelper.Type_Image)
	slot0._simagebgimage = gohelper.findChildSingleImage(slot0.viewGO, "rotate/bg/bgimag")
	slot0._simageanswerbg = gohelper.findChildSingleImage(slot0.viewGO, "rotate/#go_op5/#input_answer")

	slot0:_loadBgImage()
	slot0._simageanswerbg:LoadImage(ResUrl.getDungeonInteractiveItemBg("zhangjiedatidi_071"))

	slot0._goplaceholdertext = gohelper.findChild(slot0.viewGO, "rotate/#go_op5/#input_answer/Text Area/Placeholder")

	SLFramework.UGUI.UIClickListener.Get(slot0._inputanswer.gameObject):AddClickListener(slot0._hidePlaceholderText, slot0)

	slot0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(slot0._txtinfo.gameObject):GetComponent(gohelper.Type_TextMesh)
	slot0._conMark = gohelper.onceAddComponent(slot0._txtinfo.gameObject, typeof(ZProj.TMPMark))

	slot0._conMark:SetTopOffset(0, -4)
	slot0._conMark:SetMarkTopGo(slot0._txtmarktop.gameObject)
end

function slot0._loadBgImage(slot0)
	slot0._simagebgimage:LoadImage(ResUrl.getDungeonInteractiveItemBg("kuang1"))
end

function slot0._onScreenResize(slot0)
	DungeonMapModel.instance.directFocusElement = true

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, slot0._config.id)

	DungeonMapModel.instance.directFocusElement = false
end

function slot0._hidePlaceholderText(slot0)
	gohelper.setActive(slot0._goplaceholdertext, false)
end

function slot0._onInputAnswerEndEdit(slot0)
	gohelper.setActive(slot0._goplaceholdertext, true)
end

function slot0._playAnim(slot0, slot1, slot2)
	slot1:GetComponent(typeof(UnityEngine.Animator)):Play(slot2)
end

function slot0._playBtnsQuitAnim(slot0)
	for slot4, slot5 in pairs(DungeonEnum.ElementType) do
		if slot0["_goop" .. slot5] and slot6.activeInHierarchy then
			slot8 = slot6:GetComponentsInChildren(typeof(UnityEngine.Animator)):GetEnumerator()

			while slot8:MoveNext() do
				slot8.Current:Play("dungeonmap_interactive_btn_out")
			end
		end
	end
end

function slot0._onShow(slot0)
	if slot0._show then
		return
	end

	slot0._show = true

	DungeonMapModel.instance:clearDialog()
	DungeonMapModel.instance:clearDialogId()
	gohelper.setActive(slot0.viewGO, true)
	slot0._animator:Play("dungeonmap_interactive_in")
	slot0:_playAnim(slot0._gonext, "dungeonmap_interactive_in")
	TaskDispatcher.cancelTask(slot0._showCloseBtn, slot0)
	TaskDispatcher.runDelay(slot0._showCloseBtn, slot0, 0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
end

function slot0._showCloseBtn(slot0)
	gohelper.setActive(slot0._btnclose.gameObject, true)
end

function slot0._onOutAnimationFinished(slot0)
	gohelper.setActive(slot0.viewGO, false)
	UIBlockMgr.instance:endBlock("dungeonmap_interactive_out")
	gohelper.destroy(slot0.viewGO)
end

function slot0._asynHide(slot0, slot1)
	if not slot1 then
		logError("_asynHide viewName is nil")

		return
	end

	slot0._waitCloseViewName = slot1

	if not slot0._show then
		return
	end

	slot0:_clearScroll()

	slot0._show = false

	gohelper.setActive(slot0.viewGO, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
end

function slot0._onHide(slot0)
	if not slot0._show then
		return
	end

	slot0:_clearScroll()

	slot0._show = false

	gohelper.setActive(slot0._btnclose.gameObject, false)
	UIBlockMgr.instance:startBlock("dungeonmap_interactive_out")
	slot0._animator:Play("dungeonmap_interactive_out")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
	slot0:_playBtnsQuitAnim()
	TaskDispatcher.runDelay(slot0._onOutAnimationFinished, slot0, 0.23)

	if SLFramework.FrameworkSettings.IsEditor then
		slot1, slot2 = transformhelper.getPos(slot0.viewGO.transform)

		if slot1 - slot0._elementAddX ~= 0 or slot2 - slot0._elementAddY ~= 0 then
			slot4 = slot2 - slot0._elementY

			print(string.format("偏移坐标xy：%s#%s", string.format(slot1 - slot0._elementX == 0 and "%s" or "%.2f", slot3), string.format(slot4 == 0 and "%s" or "%.2f", slot4)))
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnclose)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

function slot0._onViewClose(slot0, slot1)
	if slot1 == slot0._waitCloseViewName then
		slot0:_cancelAsynHide()
	end
end

function slot0._onClickElement(slot0)
	slot0:_cancelAsynHide()
end

function slot0._cancelAsynHide(slot0)
	slot0._waitCloseViewName = nil

	gohelper.destroy(slot0.viewGO)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._optionBtnList = slot0:getUserDataTb_()
	slot0._dialogItemList = slot0:getUserDataTb_()
	slot0._dialogItemCacheList = slot0:getUserDataTb_()

	slot0:onInitView()
	slot0:addEvents()
	slot0:_editableAddEvents()
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.closeMapInteractiveItem, slot0._closeMapInteractiveItem, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnClickElement, slot0._onClickElement, slot0, LuaEventSystem.High)

	slot0._handleTypeMap = {
		[DungeonEnum.ElementType.None] = slot0._directlyComplete,
		[DungeonEnum.ElementType.Fight] = slot0._showFight,
		[DungeonEnum.ElementType.Task] = slot0._showTask,
		[DungeonEnum.ElementType.Story] = slot0._playStory,
		[DungeonEnum.ElementType.Question] = slot0._playQuestion,
		[DungeonEnum.ElementType.FullScreenQuestion] = slot0._showPuzzleQuestion,
		[DungeonEnum.ElementType.PipeGame] = slot0._showPuzzlePipeGame,
		[DungeonEnum.ElementType.ChangeColor] = slot0._showPuzzleChangeColor,
		[DungeonEnum.ElementType.MazeDraw] = slot0._showPuzzleMazeDraw,
		[DungeonEnum.ElementType.PutCubeGame] = slot0._showPutCubeGame,
		[DungeonEnum.ElementType.CircuitGame] = slot0._showPuzzlePipeGame,
		[DungeonEnum.ElementType.OuijaGame] = slot0._showOuijaGame,
		[DungeonEnum.ElementType.PuzzleGame] = slot0._showPuzzleGame
	}
end

function slot0._showElementTitle(slot0)
	slot0._txttitle.text = slot0._config.title
end

function slot0._OnClickElement(slot0, slot1)
	slot0._mapElement = slot1

	if slot0._show then
		slot0:_onHide()

		return
	end

	slot0:_onShow()

	slot0._config = slot0._mapElement._config
	slot0._elementGo = slot0._mapElement._go

	slot0:_showElementTitle()

	slot0._elementX, slot0._elementY, slot0._elementZ = transformhelper.getPos(slot0._elementGo.transform)

	if not string.nilorempty(slot0._config.offsetPos) then
		slot0._elementAddX = slot0._elementX + (string.splitToNumber(slot0._config.offsetPos, "#")[1] or 0)
		slot0._elementAddY = slot0._elementY + (slot2[2] or 0)
	end

	slot0.viewGO.transform.position = Vector3(slot0._elementAddX, slot0._elementAddY, 0)

	slot0:_showRewards()

	slot2 = not string.nilorempty(slot0._config.flagText)

	gohelper.setActive(slot0._goimportanttips, slot2)

	if slot2 then
		slot0._txttipsinfo.text = slot0._config.flagText
	end

	slot4 = slot0._config.type == DungeonEnum.ElementType.Story

	gohelper.setActive(slot0._txtinfo.gameObject, not slot4)
	gohelper.setActive(slot0._gochatarea, slot4)

	for slot8, slot9 in pairs(DungeonEnum.ElementType) do
		if slot0["_goop" .. slot9] then
			gohelper.setActive(slot10, slot9 == slot3)
		end
	end

	if slot3 == DungeonEnum.ElementType.CircuitGame then
		gohelper.setActive(slot0._goop9, true)
	end

	if slot0._handleTypeMap[slot3] then
		slot5(slot0)
	else
		logError("element type undefined!")
	end
end

function slot0._showRewards(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "rotate/layout/top/reward")

	if not GameUtil.splitString2(DungeonModel.instance:getMapElementReward(slot0._config.id), true, "|", "#") then
		gohelper.setActive(slot1, false)

		return
	end

	gohelper.setActive(slot1, true)

	for slot7, slot8 in ipairs(slot3) do
		gohelper.setActive(gohelper.cloneInPlace(slot0._gorewarditem), true)
	end

	slot0._rewardClick = gohelper.getClick(gohelper.findChild(slot1, "click"))

	slot0._rewardClick:AddClickListener(slot0._openRewardView, slot0, slot3)
end

function slot0._openRewardView(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	DungeonController.instance:openDungeonElementRewardView(slot1)
end

function slot0._playQuestion(slot0)
	slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.desc)
end

function slot0._showFight(slot0)
	slot2 = DungeonModel.instance:hasPassLevel(tonumber(slot0._config.param))

	gohelper.setActive(slot0._gofinishFight, slot2)
	gohelper.setActive(slot0._gounfinishedFight, not slot2)

	if slot2 then
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.finishText)
	else
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.desc)
		slot0._txtfight.text = slot0._config.acceptText
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MoveFightBtn2MapView) then
		TaskDispatcher.runDelay(slot0._addToMapView, slot0, 0.5)
	end
end

function slot0._addToMapView(slot0)
	gohelper.setActive(slot0._btnfightuiuse.gameObject, true)

	slot2 = ViewMgr.instance:getContainer(ViewName.DungeonMapView).viewGO
	slot5 = recthelper.worldPosToAnchorPos(slot0._btnfightuiuse.transform.position, slot2.transform, nil, CameraMgr.instance:getMainCamera())
	slot0._btnfightuiuse.transform.parent = slot2.transform

	transformhelper.setLocalPosXY(slot0._btnfightuiuse.transform, slot5.x, slot5.y)
end

function slot0._setMarkTopAndGetText(slot0, slot1)
	slot2 = StoryTool.getMarkTopTextList(slot1)

	TaskDispatcher.runDelay(function ()
		uv0._conMark:SetMarksTop(uv1)
	end, nil, 0.01)

	return StoryTool.filterMarkTop(slot1)
end

function slot0._showTask(slot0)
	slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.desc)
	slot2 = string.splitToNumber(slot0._config.param, "#")
	slot0._finishTask = slot2[3] <= ItemModel.instance:getItemQuantity(slot2[1], slot2[2])

	gohelper.setActive(slot0._gofinishtask, slot0._finishTask)
	gohelper.setActive(slot0._gounfinishtask, not slot0._finishTask)

	if LangSettings.instance:getCurLangShortcut() == "jp" or slot6 == "ko" then
		if slot0._finishTask then
			slot0._txtfinishtask.text = string.format("%s%s<color=#00ff00>%s</color>/%s", ItemModel.instance:getItemConfig(slot2[1], slot2[2]).name, luaLang("dungeon_map_submit"), slot5, slot3)
		else
			slot0._txtunfinishtask.text = string.format("%s%s<color=#ff0000>%s</color>/%s", slot4.name, luaLang("dungeon_map_submit"), slot5, slot3)
		end
	elseif slot6 == "en" then
		if slot0._finishTask then
			slot0._txtfinishtask.text = string.format("%s %s <color=#00ff00>%s</color>/%s", luaLang("dungeon_map_submit"), slot4.name, slot5, slot3)
		else
			slot0._txtunfinishtask.text = string.format("%s %s <color=#ff0000>%s</color>/%s", luaLang("dungeon_map_submit"), slot4.name, slot5, slot3)
		end
	elseif slot0._finishTask then
		slot0._txtfinishtask.text = string.format("%s%s<color=#00ff00>%s</color>/%s", luaLang("dungeon_map_submit"), slot4.name, slot5, slot3)
	else
		slot0._txtunfinishtask.text = string.format("%s%s<color=#ff0000>%s</color>/%s", luaLang("dungeon_map_submit"), slot4.name, slot5, slot3)
	end
end

function slot0._showPuzzleQuestion(slot0)
	if DungeonMapModel.instance:hasMapPuzzleStatus(slot0._config.id) then
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.finishText)
	else
		slot0._txtpuzzlequestion.text = slot0._config.acceptText
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.desc)
	end

	slot0._gopuzzlequestion:SetActive(not slot1)
	slot0._gopuzzlequestionfinish.gameObject:SetActive(slot1)
end

function slot0._showPuzzlePipeGame(slot0)
	if DungeonMapModel.instance:hasMapPuzzleStatus(slot0._config.id) then
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.finishText)
	else
		slot0._txtpuzzlepipe.text = slot0._config.acceptText
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.desc)
	end

	slot0._gopipe:SetActive(not slot1)
	slot0._gopipefinish:SetActive(slot1)
end

function slot0._showPuzzleChangeColor(slot0)
	slot1 = nil
end

function slot0._showPuzzleMazeDraw(slot0)
	if DungeonMapModel.instance:hasMapPuzzleStatus(slot0._config.id) then
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.finishText)
	else
		slot0._txtmazedraw.text = slot0._config.acceptText
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.desc)
	end

	slot0._gomazedraw:SetActive(not slot1)
	slot0._gomazedrawfinish:SetActive(slot1)
end

function slot0._showPutCubeGame(slot0)
end

function slot0._showOuijaGame(slot0)
	if DungeonMapModel.instance:hasMapPuzzleStatus(slot0._config.id) then
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.finishText)
	else
		slot0._txtouija.text = slot0._config.acceptText
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.desc)
	end

	slot0._goouijagame:SetActive(not slot1)
	slot0._goouijagamefinish:SetActive(slot1)
end

function slot0._showPuzzleGame(slot0)
	if DungeonMapModel.instance:hasMapPuzzleStatus(slot0._config.id) then
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.finishText)
	else
		slot0._txt101puzzle.text = slot0._config.acceptText
		slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.desc)
	end

	slot0._goop101puzzle:SetActive(not slot1)
	slot0._goop101puzzlefinish:SetActive(slot1)
end

function slot0._directlyComplete(slot0)
	slot0._txtdoit.text = slot0._config.acceptText
	slot0._txtinfo.text = slot0:_setMarkTopAndGetText(slot0._config.desc)
end

function slot0._playNextSectionOrDialog(slot0)
	slot0:_clearDialog()

	if slot0._dialogIndex <= #slot0._sectionList then
		slot0:_playNextDialog()

		return
	end

	slot1 = table.remove(slot0._sectionStack)

	slot0:_playSection(slot1[1], slot1[2])
end

function slot0._playStory(slot0)
	slot0:_clearDialog()

	slot0._sectionStack = {}
	slot0._dialogId = tonumber(slot0._config.param)

	slot0:_playSection(0)
end

function slot0._playSection(slot0, slot1, slot2)
	slot0:_setSectionData(slot1, slot2)
	slot0:_playNextDialog()
end

function slot0._setSectionData(slot0, slot1, slot2)
	slot0._sectionList = DungeonConfig.instance:getDialog(slot0._dialogId, slot1)
	slot0._dialogIndex = slot2 or 1
	slot0._sectionId = slot1
end

function slot0._playNextDialog(slot0)
	slot0._dialogIndex = slot0._dialogIndex + 1

	if slot0._sectionList[slot0._dialogIndex].type == "dialog" then
		slot0:_showDialog("dialog", slot1.content, slot1.speaker, slot1.audio)
	end

	if #slot0._sectionStack > 0 and #slot0._sectionList < slot0._dialogIndex then
		slot2 = table.remove(slot0._sectionStack)

		slot0:_setSectionData(slot2[1], slot2[2])
	end

	slot2 = false

	if slot0._sectionList[slot0._dialogIndex] and slot3.type == "options" then
		slot0._dialogIndex = slot0._dialogIndex + 1
		slot4 = string.split(slot3.content, "#")
		slot5 = string.split(slot3.param, "#")

		for slot9, slot10 in pairs(slot0._optionBtnList) do
			gohelper.setActive(slot10[1], false)
		end

		for slot9, slot10 in ipairs(slot4) do
			slot0:_addDialogOption(slot9, slot5[slot9], slot10)
		end

		slot2 = true
	end

	slot0:_refreshDialogBtnState(slot2, not slot3 or slot3.type ~= "dialogend")

	if slot0._dissolveInfo then
		gohelper.setActive(slot0._curBtnGo, false)
	end
end

function slot0._refreshDialogBtnState(slot0, slot1, slot2)
	gohelper.setActive(slot0._gooptions, slot1)

	if slot1 then
		slot0._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)
		gohelper.setActive(slot0._gofinishtalk.gameObject, false)

		slot0._curBtnGo = slot0._gooptions

		return
	end

	if slot2 and (#slot0._sectionStack > 0 or slot0._dialogIndex <= #slot0._sectionList) then
		slot0._curBtnGo = slot0._gonext

		gohelper.setActive(slot0._gonext.gameObject, slot2)
		slot0._nextAnimator:Play("dungeonmap_interactive_btn_in1")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	else
		slot0._nextAnimator:Play("dungeonmap_interactive_btn_out")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuedisappear)

		slot0._curBtnGo = slot0._gofinishtalk
	end

	gohelper.setActive(slot0._gofinishtalk.gameObject, not slot2)
end

function slot0._addDialogOption(slot0, slot1, slot2, slot3)
	slot4 = slot0._optionBtnList[slot1] and slot0._optionBtnList[slot1][1] or gohelper.cloneInPlace(slot0._gotalkitem)
	slot0._maxOptionIndex = slot1

	gohelper.setActive(slot4, false)

	gohelper.findChildText(slot4, "txt_talkitem").text = slot3

	gohelper.findChildButtonWithAudio(slot4, "btn_talkitem"):AddClickListener(slot0._onOptionClick, slot0, {
		slot2,
		slot3
	})

	if not slot0._optionBtnList[slot1] then
		slot0._optionBtnList[slot1] = {
			slot4,
			slot6
		}
	end
end

function slot0._onOptionClick(slot0, slot1)
	if slot0._playScrollAnim then
		return
	end

	slot0:_clearDialog()

	if slot0._dialogId ~= 24 or slot1[1] ~= "5" then
		slot0:_showDialog("option", string.format(LangSettings.instance:getCurLangShortcut() == "jp" and "<color=#c95318>%s</color>" or "<color=#c95318>\"%s\"</color>", slot1[2]))
	end

	slot0._showOption = true

	if slot0._dialogIndex <= #slot0._sectionList then
		table.insert(slot0._sectionStack, {
			slot0._sectionId,
			slot0._dialogIndex
		})
	end

	DungeonMapModel.instance:addDialogId(slot2)
	slot0:_playSection(slot2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
end

function slot0._showDialog(slot0, slot1, slot2, slot3, slot4)
	DungeonMapModel.instance:addDialog(slot1, slot2, slot3, slot4)

	slot5 = table.remove(slot0._dialogItemCacheList) or gohelper.cloneInPlace(slot0._gochatitem)

	transformhelper.setLocalPos(slot5.transform, 0, 0, 200)
	gohelper.setActive(slot5, true)
	gohelper.setAsLastSibling(slot5)

	gohelper.findChildText(slot5, "name").text = slot3 and slot3 .. ":" or ""

	gohelper.setActive(gohelper.findChild(slot5, "usericon"), not slot3)

	if slot3 and slot4 and slot4 > 0 then
		slot0._audioIcon = gohelper.findChild(slot5, "name/laba")
		slot0._audioId = slot4
	end

	slot8 = gohelper.findChildText(slot5, "info")

	if slot0._showOption and slot0._addDialog then
		slot0._dissolveInfo = {
			slot5,
			slot8,
			slot2
		}
		slot8.text = StoryTool.filterMarkTop(slot2)
	else
		gohelper.onceAddComponent(slot8.gameObject, typeof(ZProj.TMPMark)):SetMarkTopGo(IconMgr.instance:getCommonTextMarkTop(slot8.gameObject):GetComponent(gohelper.Type_TextMesh).gameObject)

		slot8.text = StoryTool.filterMarkTop(slot2)

		TaskDispatcher.runDelay(function ()
			uv1:SetMarksTop(StoryTool.getMarkTopTextList(uv0))
		end, nil, 0.01)
	end

	slot0._showOption = false

	table.insert(slot0._dialogItemList, slot5)

	slot0._addDialog = true
end

function slot0._clearDialog(slot0)
	slot0._dialogItemList = slot0:getUserDataTb_()
	slot0._playScrollAnim = true

	gohelper.setActive(slot0._gomask, false)
	TaskDispatcher.runDelay(slot0._delayScroll, slot0, 0)

	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end
end

function slot0._delayScroll(slot0)
	gohelper.setActive(slot0._gomask, true)

	slot0._imgMask.enabled = true

	if slot0._curScrollGo then
		slot0._oldScrollGo = slot2

		gohelper.setActive(gohelper.findChild(slot2, "GameObject"), false)
		ZProj.TweenHelper.DOLocalMoveY(slot2.transform, 299, 0.26, slot0._scrollEnd, slot0, slot2)
	else
		slot1 = 0.1
	end

	for slot8, slot9 in ipairs(slot0._dialogItemList) do
		gohelper.addChild(gohelper.findChild(gohelper.cloneInPlace(slot0._goscroll), "view/content"), slot9)

		slot9.transform.position = slot9.transform.position
		slot11, slot12, slot13 = transformhelper.getLocalPos(slot9.transform)

		transformhelper.setLocalPos(slot9.transform, slot11, slot12, 0)
	end

	gohelper.setActive(slot3, true)

	slot0._curScrollGo = slot3

	if slot3 then
		if slot0._dissolveInfo then
			slot6 = slot0._dissolveInfo[3]
			slot0._dissolveInfo[2].text = ""
		end

		transformhelper.setLocalPosXY(slot3.transform, 0, -229)
		ZProj.TweenHelper.DOLocalMoveY(slot3.transform, 0, slot1, slot0._scrollEnd, slot0, slot3)
	end
end

function slot0._scrollEnd(slot0, slot1)
	if slot1 ~= slot0._curScrollGo then
		gohelper.destroy(slot1)
	else
		if slot0._dissolveInfo then
			TaskDispatcher.runDelay(slot0._onDissolveStart, slot0, 0.3)

			return
		end

		slot0:_onDissolveFinish()
	end
end

function slot0._onDissolveStart(slot0)
	slot2 = slot0._dissolveInfo[2]

	gohelper.onceAddComponent(slot2.gameObject, typeof(ZProj.TMPMark)):SetMarkTopGo(IconMgr.instance:getCommonTextMarkTop(slot2.gameObject):GetComponent(gohelper.Type_TextMesh).gameObject)

	slot2.text = StoryTool.filterMarkTop(slot0._dissolveInfo[3])

	TaskDispatcher.runDelay(function ()
		uv1:SetMarksTop(StoryTool.getMarkTopTextList(uv0))
	end, nil, 0.01)

	slot0._imgMask.enabled = true

	slot0._dissolveInfo[1]:GetComponent(typeof(UnityEngine.Animation)):Play("dungeonmap_chatarea")
	TaskDispatcher.runDelay(slot0._onDissolveFinish, slot0, 1.3)
end

function slot0._onDissolveFinish(slot0)
	slot0:_playAudio()
	gohelper.setActive(slot0._curBtnGo, true)

	slot0._dissolveInfo = nil
	slot0._playScrollAnim = false

	if slot0._curBtnGo == slot0._gooptions then
		for slot4 = 1, slot0._maxOptionIndex do
			if (slot4 - 1) * 0.03 > 0 then
				gohelper.setActive(slot0._optionBtnList[slot4][1], false)
				TaskDispatcher.runDelay(function ()
					if not gohelper.isNil(uv0) then
						gohelper.setActive(uv0, true)
					end
				end, nil, slot5)
			else
				gohelper.setActive(slot6, true)
			end
		end
	end
end

function slot0._playAudio(slot0)
	if not slot0._audioId then
		return
	end

	gohelper.setActive(slot0._audioIcon, true)

	if not slot0._audioParam then
		slot0._audioParam = AudioParam.New()
	end

	slot0._audioParam.callback = slot0._onAudioStop
	slot0._audioParam.callbackTarget = slot0

	AudioEffectMgr.instance:playAudio(slot0._audioId, slot0._audioParam)
end

function slot0._onAudioStop(slot0, slot1)
	gohelper.setActive(slot0._audioIcon, false)
end

function slot0.setBtnClosePosZ(slot0, slot1)
	slot2 = slot0._btnclose.transform
	slot3 = slot2.localPosition
	slot2.localPosition = Vector3(slot3.x, slot3.y, slot1)
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.viewGO.transform, slot1, slot1, slot1)
end

function slot0._clearScroll(slot0)
	slot0._showOption = false
	slot0._dissolveInfo = nil
	slot0._playScrollAnim = false

	TaskDispatcher.cancelTask(slot0._delayScroll, slot0)

	if slot0._oldScrollGo then
		gohelper.destroy(slot0._oldScrollGo)

		slot0._oldScrollGo = nil
	end

	if slot0._curScrollGo then
		gohelper.destroy(slot0._curScrollGo)

		slot0._curScrollGo = nil
	end

	slot0._dialogItemList = slot0:getUserDataTb_()
end

function slot0._editableRemoveEvents(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[2]:RemoveClickListener()
	end

	slot0:removeEventCb(DungeonController.instance, DungeonEvent.closeMapInteractiveItem, slot0._closeMapInteractiveItem, slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnClickElement, slot0._onClickElement, slot0)
end

function slot0.onDestroy(slot0)
	DungeonMapModel.instance:setMapInteractiveItemVisible(false)
	TaskDispatcher.cancelTask(slot0._showCloseBtn, slot0)
	TaskDispatcher.cancelTask(slot0._delayScroll, slot0)
	TaskDispatcher.cancelTask(slot0._onDissolveStart, slot0)
	TaskDispatcher.cancelTask(slot0._onDissolveFinish, slot0)
	slot0:removeEvents()
	slot0:_editableRemoveEvents()
	TaskDispatcher.cancelTask(slot0._addToMapView, slot0)
	gohelper.destroy(slot0._btnfightuiuse.gameObject)

	if slot0._audioParam then
		slot0._audioParam.callback = nil
		slot0._audioParam.callbackTarget = nil
		slot0._audioParam = nil
	end

	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end

	if slot0._rewardClick then
		slot0._rewardClick:RemoveClickListener()
	end

	SLFramework.UGUI.UIClickListener.Get(slot0._inputanswer.gameObject):RemoveClickListener()
	slot0._simagebgimage:UnLoadImage()
	slot0._simageanswerbg:UnLoadImage()
end

return slot0
