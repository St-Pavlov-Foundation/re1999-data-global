module("modules.logic.dungeon.view.maze.DungeonMazeView", package.seeall)

local var_0_0 = class("DungeonMazeView", BaseViewExtended)
local var_0_1 = DungeonMazeController.instance
local var_0_2 = DungeonMazeEnum.dir.left
local var_0_3 = DungeonMazeEnum.dir.right
local var_0_4 = DungeonMazeEnum.dir.down
local var_0_5 = DungeonMazeEnum.dir.up
local var_0_6 = {
	[var_0_2] = Vector2.New(-500, 0),
	[var_0_3] = Vector2.New(500, 0),
	[var_0_5] = Vector2.New(0, 300),
	[var_0_4] = Vector2.New(0, -300)
}
local var_0_7 = "dialogue_role30_left"
local var_0_8 = "dialogue_role30_right"
local var_0_9 = 70

function var_0_0.onInitView(arg_1_0)
	arg_1_0._leftRoadBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Road/road1/#btn_click")
	arg_1_0._rightRoadBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Road/road2/#btn_click")
	arg_1_0._upRoadBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Road/road4/#btn_click")
	arg_1_0._downRoadBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Road/road3/#btn_click")
	arg_1_0._leftEventBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Road/road1/#btn_event/light")
	arg_1_0._rightEventBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Road/road2/#btn_event/light")
	arg_1_0._upEventBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Road/road4/#btn_event/light")
	arg_1_0._downEventBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Road/road3/#btn_event/light")
	arg_1_0._goRoadStopLeft = gohelper.findChild(arg_1_0.viewGO, "Road/road1/stop")
	arg_1_0._goRoadStopRight = gohelper.findChild(arg_1_0.viewGO, "Road/road2/stop")
	arg_1_0._goRoadStopBottom = gohelper.findChild(arg_1_0.viewGO, "Road/road3/stop")
	arg_1_0._goRoadStopUp = gohelper.findChild(arg_1_0.viewGO, "Road/road4/stop")
	arg_1_0._goRoadDirLeft = gohelper.findChild(arg_1_0.viewGO, "Road/road1/normal")
	arg_1_0._goRoadDirRight = gohelper.findChild(arg_1_0.viewGO, "Road/road2/normal")
	arg_1_0._goRoadDirBottom = gohelper.findChild(arg_1_0.viewGO, "Road/road3/normal")
	arg_1_0._goRoadDirUp = gohelper.findChild(arg_1_0.viewGO, "Road/road4/normal")
	arg_1_0._goRoadLightLeft = gohelper.findChild(arg_1_0.viewGO, "Road/road1/light")
	arg_1_0._goRoadLightRight = gohelper.findChild(arg_1_0.viewGO, "Road/road2/light")
	arg_1_0._goRoadLightBottom = gohelper.findChild(arg_1_0.viewGO, "Road/road3/light")
	arg_1_0._goRoadLightUp = gohelper.findChild(arg_1_0.viewGO, "Road/road4/light")
	arg_1_0._goRoadEventLeft = gohelper.findChild(arg_1_0.viewGO, "Road/road1/#btn_event")
	arg_1_0._goRoadEventRight = gohelper.findChild(arg_1_0.viewGO, "Road/road2/#btn_event")
	arg_1_0._goRoadEventBottom = gohelper.findChild(arg_1_0.viewGO, "Road/road3/#btn_event")
	arg_1_0._goRoadEventUp = gohelper.findChild(arg_1_0.viewGO, "Road/road4/#btn_event")
	arg_1_0._goEyeNormal = gohelper.findChild(arg_1_0.viewGO, "#go_top/normal")
	arg_1_0._goEyeActive = gohelper.findChild(arg_1_0.viewGO, "#go_top/active")
	arg_1_0._goEyeCooling = gohelper.findChild(arg_1_0.viewGO, "#go_top/cooling")
	arg_1_0._goSkillCoolingStar1Light = gohelper.findChild(arg_1_0.viewGO, "#go_top/cooling/star1/light")
	arg_1_0._goSkillCoolingStar2Light = gohelper.findChild(arg_1_0.viewGO, "#go_top/cooling/star2/light")
	arg_1_0._goSkillCoolingStar1Drak = gohelper.findChild(arg_1_0.viewGO, "#go_top/cooling/star1/dark")
	arg_1_0._goSkillCoolingStar2Drak = gohelper.findChild(arg_1_0.viewGO, "#go_top/cooling/star2/dark")
	arg_1_0._goDestination = gohelper.findChild(arg_1_0.viewGO, "#go_ending")
	arg_1_0._textChaosValue = gohelper.findChildText(arg_1_0.viewGO, "#go_bottom/normal/#txt_value")
	arg_1_0._textDangerousValue = gohelper.findChildText(arg_1_0.viewGO, "#go_bottom/dangerous/#txt_value")
	arg_1_0._goNormalChaoValue = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/normal")
	arg_1_0._goDangerousChaoValue = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/dangerous")
	arg_1_0._goChaoAdd = gohelper.findChild(arg_1_0.viewGO, "#go_bottom/#txt_add")
	arg_1_0._textChaosAdd = gohelper.findChildText(arg_1_0.viewGO, "#go_bottom/#txt_add")
	arg_1_0._goChess = gohelper.findChild(arg_1_0.viewGO, "#go_chess")
	arg_1_0._goChessAni = gohelper.findChild(arg_1_0._goChess, "#chess")
	arg_1_0._imageChessIcon = gohelper.findChildSingleImage(arg_1_0._goChess, "#chess/#image_chess")
	arg_1_0._goTalk = gohelper.findChild(arg_1_0.viewGO, "#go_chess/#go_talk")
	arg_1_0._goArrowTip = gohelper.findChild(arg_1_0._goTalk, "#go_ArrowTips")
	arg_1_0._scrollTalk = gohelper.findChildScrollRect(arg_1_0._goTalk, "Scroll View")
	arg_1_0._txttalk = gohelper.findChildText(arg_1_0._goTalk, "Scroll View/Viewport/Content/#txt_talk")
	arg_1_0.rectTrTalk = arg_1_0._goTalk:GetComponent(gohelper.Type_RectTransform)
	arg_1_0.rectTrContent = gohelper.findChildComponent(arg_1_0._goTalk, "Scroll View/Viewport/Content", gohelper.Type_RectTransform)
	arg_1_0._transChess = arg_1_0._goChess.transform
	arg_1_0._btnEye = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top/#btn_click")
	arg_1_0._btnRestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._goBottom = gohelper.findChild(arg_1_0.viewGO, "#go_bottom")
	arg_1_0._bottomAnimator = arg_1_0._goBottom:GetComponent(gohelper.Type_Animator)
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._chessAnimator = arg_1_0._goChessAni:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._leftRoadBtn:AddClickListener(arg_2_0._onClickLeftRoadBtn, arg_2_0)
	arg_2_0._rightRoadBtn:AddClickListener(arg_2_0._onClickRightRoadBtn, arg_2_0)
	arg_2_0._upRoadBtn:AddClickListener(arg_2_0._onClickUpRoadBtn, arg_2_0)
	arg_2_0._downRoadBtn:AddClickListener(arg_2_0._onClickDownRoadBtn, arg_2_0)
	arg_2_0._btnEye:AddClickListener(arg_2_0._onClickEyeBtn, arg_2_0)
	arg_2_0._btnRestart:AddClickListener(arg_2_0._onClickRestartBtn, arg_2_0)

	arg_2_0.talkTextClick = gohelper.getClickWithDefaultAudio(arg_2_0._goTalk)

	arg_2_0.talkTextClick:AddClickListener(arg_2_0.onClickText, arg_2_0)
	arg_2_0._leftEventBtn:AddClickListener(arg_2_0._onClickLeftObstacleBtn, arg_2_0)
	arg_2_0._rightEventBtn:AddClickListener(arg_2_0._onClickRightObstacleBtn, arg_2_0)
	arg_2_0._upEventBtn:AddClickListener(arg_2_0._onClickUpObstacleBtn, arg_2_0)
	arg_2_0._downEventBtn:AddClickListener(arg_2_0._onClickDownObstacleBtn, arg_2_0)
	arg_2_0:addEventCb(DungeonMazeController.instance, DungeonMazeEvent.DungeonMazeCompleted, arg_2_0.onMazeCompleted, arg_2_0)
	arg_2_0:addEventCb(DungeonMazeController.instance, DungeonMazeEvent.DungeonMazeExit, arg_2_0.onMazeExit, arg_2_0)
	arg_2_0:addEventCb(DungeonMazeController.instance, DungeonMazeEvent.DungeonMazeReStart, arg_2_0.onMazeRestart, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._leftRoadBtn:RemoveClickListener()
	arg_3_0._rightRoadBtn:RemoveClickListener()
	arg_3_0._upRoadBtn:RemoveClickListener()
	arg_3_0._downRoadBtn:RemoveClickListener()
	arg_3_0._btnEye:RemoveClickListener()
	arg_3_0._btnRestart:RemoveClickListener()
	arg_3_0.talkTextClick:RemoveClickListener()
	arg_3_0._leftEventBtn:RemoveClickListener()
	arg_3_0._rightEventBtn:RemoveClickListener()
	arg_3_0._upEventBtn:RemoveClickListener()
	arg_3_0._downEventBtn:RemoveClickListener()
end

function var_0_0._onClickLeftRoadBtn(arg_4_0)
	if not arg_4_0._leftCell or not arg_4_0._leftCell.pass then
		return
	end

	arg_4_0:_clickToMove(var_0_2)
end

function var_0_0._onClickRightRoadBtn(arg_5_0)
	if not arg_5_0._rightCell or not arg_5_0._rightCell.pass then
		return
	end

	arg_5_0:_clickToMove(var_0_3)
end

function var_0_0._onClickDownRoadBtn(arg_6_0)
	if not arg_6_0._downCell or not arg_6_0._downCell.pass then
		return
	end

	arg_6_0:_clickToMove(var_0_4)
end

function var_0_0._onClickUpRoadBtn(arg_7_0)
	if not arg_7_0._upCell or not arg_7_0._upCell.pass then
		return
	end

	arg_7_0:_clickToMove(var_0_5)
end

function var_0_0._clickToMove(arg_8_0, arg_8_1)
	if arg_8_0._moving then
		return
	end

	arg_8_0._moving = true

	DungeonMazeController.instance:MoveTo(arg_8_1)
	arg_8_0:_doMoveTween(arg_8_1)
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_push)
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.stop_ui_fuleyuan_eyes)
end

function var_0_0._doMoveTween(arg_9_0, arg_9_1)
	TaskDispatcher.cancelTask(arg_9_0._delayHideDialog, arg_9_0)
	arg_9_0:_delayHideDialog()

	local var_9_0 = var_0_6[arg_9_1]

	arg_9_0:_refreshChessIcon(arg_9_1)

	local var_9_1 = ZProj.TweenHelper.DOAnchorPos(arg_9_0._transChess, var_9_0.x, var_9_0.y, 1, arg_9_0._doMoveTweenDone, arg_9_0)

	ZProj.TweenHelper.DOFadeCanvasGroup(arg_9_0._goChess, 1, 0, 0.4)
	arg_9_0._viewAnimator:Play(UIAnimationName.Switch, 0, 0)
end

function var_0_0._doMoveTweenDone(arg_10_0)
	arg_10_0:_refreshCurCellView()
	arg_10_0:_refreshChaosValueView()
	arg_10_0:_refreshChessView()
	arg_10_0:_refreshSkillView()
	arg_10_0:_refreshCurCellDialogView()
	arg_10_0._chessAnimator:Play("jump", 0, 0)

	arg_10_0._moving = false
end

function var_0_0._refreshChessIcon(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 == var_0_2 and var_0_8 or var_0_7

	arg_11_0._imageChessIcon:UnLoadImage()
	arg_11_0._imageChessIcon:LoadImage(ResUrl.getChessDialogueSingleBg(var_11_0))
end

function var_0_0._onClickLeftObstacleBtn(arg_12_0)
	arg_12_0:_clickObstacle(var_0_2, arg_12_0._leftCell)
end

function var_0_0._onClickRightObstacleBtn(arg_13_0)
	arg_13_0:_clickObstacle(var_0_3, arg_13_0._rightCell)
end

function var_0_0._onClickUpObstacleBtn(arg_14_0)
	arg_14_0:_clickObstacle(var_0_5, arg_14_0._upCell)
end

function var_0_0._onClickDownObstacleBtn(arg_15_0)
	arg_15_0:_clickObstacle(var_0_4, arg_15_0._downCell)
end

function var_0_0._clickObstacle(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_2 or string.nilorempty(arg_16_2.obstacleDialog) or arg_16_2.obstacleToggled then
		return
	end

	arg_16_2.obstacleToggled = true

	arg_16_0:_doToggleObstacleDone()
end

function var_0_0._doToggleObstacleDone(arg_17_0)
	arg_17_0:_refreshCurCellView()
end

function var_0_0._onClickEyeBtn(arg_18_0)
	local var_18_0 = DungeonMazeModel.instance:GetSkillState()

	if var_18_0 == DungeonMazeEnum.skillState.using then
		if SLFramework.FrameworkSettings.IsEditor then
			arg_18_0._quickPassCount = arg_18_0._quickPassCount or 0
			arg_18_0._quickPassCount = arg_18_0._quickPassCount + 1

			if arg_18_0._quickPassCount >= 10 then
				local var_18_1 = tonumber(arg_18_0._episodeCfg.story)

				if var_18_1 ~= 0 then
					DungeonMazeController.instance:playMazeAfterStory(var_18_1)

					return
				end
			end
		end

		GameFacade.showToast(ToastEnum.MazeGameEyeSkillUsingToast)
	elseif var_18_0 == DungeonMazeEnum.skillState.cooling then
		GameFacade.showToast(ToastEnum.MazeGameEyeSkillCoolingToast)
	else
		DungeonMazeController.instance:UseEyeSkill()
		arg_18_0:_refreshSkillView()
		DungeonMazeModel.instance:SaveCurProgress()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
	end
end

function var_0_0._onClickRestartBtn(arg_19_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.WarmUpGameReFight, MsgBoxEnum.BoxType.Yes_No, arg_19_0._doClickRestartAction, nil, nil)
end

function var_0_0._doClickRestartAction(arg_20_0)
	local var_20_0 = DungeonMazeModel.instance:getCurCellData()
	local var_20_1 = DungeonMazeModel.instance:getChaosValue()

	DungeonMazeController.instance:sandStatData(DungeonMazeEnum.resultStat[4], var_20_0.cellId, var_20_1)
	var_0_1:dispatchEvent(DungeonMazeEvent.DungeonMazeReStart)
end

function var_0_0.onClickText(arg_21_0)
	return
end

function var_0_0.onMazeCompleted(arg_22_0)
	arg_22_0:closeThis()
end

function var_0_0.onMazeExit(arg_23_0)
	arg_23_0:closeThis()
end

function var_0_0.onMazeRestart(arg_24_0)
	DungeonMazeController.instance:initStatData()
	DungeonMazeModel.instance:initData()
	arg_24_0:initMap()
end

function var_0_0._editableInitView(arg_25_0)
	arg_25_0._roadStopMap = arg_25_0:getUserDataTb_()
	arg_25_0._roadStopMap[DungeonMazeEnum.dir.left] = arg_25_0._goRoadStopLeft
	arg_25_0._roadStopMap[DungeonMazeEnum.dir.right] = arg_25_0._goRoadStopRight
	arg_25_0._roadStopMap[DungeonMazeEnum.dir.down] = arg_25_0._goRoadStopBottom
	arg_25_0._roadStopMap[DungeonMazeEnum.dir.up] = arg_25_0._goRoadStopUp
	arg_25_0._roadDirMap = arg_25_0:getUserDataTb_()
	arg_25_0._roadDirMap[DungeonMazeEnum.dir.left] = arg_25_0._goRoadDirLeft
	arg_25_0._roadDirMap[DungeonMazeEnum.dir.right] = arg_25_0._goRoadDirRight
	arg_25_0._roadDirMap[DungeonMazeEnum.dir.down] = arg_25_0._goRoadDirBottom
	arg_25_0._roadDirMap[DungeonMazeEnum.dir.up] = arg_25_0._goRoadDirUp
	arg_25_0._roadLightMap = arg_25_0:getUserDataTb_()
	arg_25_0._roadLightMap[DungeonMazeEnum.dir.left] = arg_25_0._goRoadLightLeft
	arg_25_0._roadLightMap[DungeonMazeEnum.dir.right] = arg_25_0._goRoadLightRight
	arg_25_0._roadLightMap[DungeonMazeEnum.dir.down] = arg_25_0._goRoadLightBottom
	arg_25_0._roadLightMap[DungeonMazeEnum.dir.up] = arg_25_0._goRoadLightUp
	arg_25_0._roadEventMap = arg_25_0:getUserDataTb_()
	arg_25_0._roadEventMap[DungeonMazeEnum.dir.left] = arg_25_0._goRoadEventLeft
	arg_25_0._roadEventMap[DungeonMazeEnum.dir.right] = arg_25_0._goRoadEventRight
	arg_25_0._roadEventMap[DungeonMazeEnum.dir.down] = arg_25_0._goRoadEventBottom
	arg_25_0._roadEventMap[DungeonMazeEnum.dir.up] = arg_25_0._goRoadEventUp
	arg_25_0._roadDirBtnMap = arg_25_0:getUserDataTb_()
	arg_25_0._roadDirBtnMap[DungeonMazeEnum.dir.left] = arg_25_0._leftRoadBtn
	arg_25_0._roadDirBtnMap[DungeonMazeEnum.dir.right] = arg_25_0._rightRoadBtn
	arg_25_0._roadDirBtnMap[DungeonMazeEnum.dir.down] = arg_25_0._downRoadBtn
	arg_25_0._roadDirBtnMap[DungeonMazeEnum.dir.up] = arg_25_0._upRoadBtn
	arg_25_0._roadEventBtnMap = arg_25_0:getUserDataTb_()
	arg_25_0._roadEventBtnMap[DungeonMazeEnum.dir.left] = arg_25_0._leftEventBtn
	arg_25_0._roadEventBtnMap[DungeonMazeEnum.dir.right] = arg_25_0._rightEventBtn
	arg_25_0._roadEventBtnMap[DungeonMazeEnum.dir.down] = arg_25_0._downEventBtn
	arg_25_0._roadEventBtnMap[DungeonMazeEnum.dir.up] = arg_25_0._upEventBtn

	gohelper.setActive(arg_25_0._goChaoAdd, false)
	gohelper.setActive(arg_25_0._goTalk, false)
end

function var_0_0.onUpdateParam(arg_26_0)
	return
end

function var_0_0.onOpen(arg_27_0)
	arg_27_0._episodeCfg = arg_27_0.viewParam.episodeCfg

	if not arg_27_0.viewParam.existProgress then
		DungeonMazeModel.instance:SaveCurProgress()
	end

	local var_27_0 = DungeonGameConfig.instance:getMazeGameConst(DungeonMazeEnum.hideDialogTimeConstId)

	arg_27_0._dialogHideTime = var_27_0 and tonumber(var_27_0.size) or 4

	arg_27_0:initMap()
end

function var_0_0.onOpenFinish(arg_28_0)
	DungeonMazeController.instance:dispatchEvent(DungeonMazeEvent.EnterDungeonMaze)
end

function var_0_0.onClose(arg_29_0)
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.stop_ui_fuleyuan_eyes)
end

function var_0_0.initMap(arg_30_0)
	arg_30_0:_refreshCurCellView()
	arg_30_0:_refreshChaosValueView()
	gohelper.setActive(arg_30_0._goChaoAdd, false)
	arg_30_0:_refreshChessView()
	arg_30_0:_refreshSkillView()
end

function var_0_0._refreshCurCellView(arg_31_0)
	arg_31_0._curCell = DungeonMazeModel.instance:getCurCellData()

	local var_31_0 = arg_31_0._curCell.connectSet

	arg_31_0._leftCell = var_31_0[DungeonMazeEnum.dir.left]
	arg_31_0._rightCell = var_31_0[DungeonMazeEnum.dir.right]
	arg_31_0._upCell = var_31_0[DungeonMazeEnum.dir.up]
	arg_31_0._downCell = var_31_0[DungeonMazeEnum.dir.down]

	for iter_31_0, iter_31_1 in pairs(arg_31_0._roadStopMap) do
		local var_31_1 = var_31_0[iter_31_0]

		gohelper.setActive(iter_31_1, not var_31_1 and true or not var_31_1.pass)
		gohelper.setActive(arg_31_0._roadDirMap[iter_31_0], var_31_1 and var_31_1.pass)

		local var_31_2 = false
		local var_31_3 = arg_31_0._roadEventMap[iter_31_0]
		local var_31_4 = var_31_1 and not string.nilorempty(var_31_1.obstacleDialog)
		local var_31_5 = false

		if var_31_4 then
			gohelper.setActive(var_31_3, true)

			var_31_5 = var_31_1 and var_31_1.obstacleToggled
			var_31_2 = var_31_5

			local var_31_6 = gohelper.findChild(var_31_3, "grey")
			local var_31_7 = gohelper.findChild(var_31_3, "light")

			gohelper.setActive(var_31_6, var_31_5)
			gohelper.setActive(var_31_7, not var_31_5)
		else
			gohelper.setActive(var_31_3, false)
		end

		DungeonMazeController.instance:dispatchEvent(DungeonMazeEvent.ShowMazeObstacleDialog, iter_31_0, var_31_2 and var_31_1.obstacleDialog or nil, var_31_5)
	end

	gohelper.setActive(arg_31_0._goDestination, false)

	for iter_31_2, iter_31_3 in pairs(var_31_0) do
		if iter_31_3 and iter_31_3.value == 2 then
			gohelper.setActive(arg_31_0._goDestination, true)
		end
	end

	local var_31_8 = DungeonMazeModel.instance:getChaosValue()

	if var_31_8 and var_31_8 < DungeonMazeEnum.MaxChaosValue then
		var_0_1:dispatchEvent(DungeonMazeEvent.ArriveMazeGameCell, arg_31_0._curCell.cellId)
	end
end

function var_0_0._refreshCurCellDialogView(arg_32_0)
	if arg_32_0._curCell.toggled then
		return
	end

	local var_32_0 = arg_32_0._curCell.eventId

	if var_32_0 and var_32_0 > 0 then
		local var_32_1 = DungeonGameConfig.instance:getMazeEventCfg(var_32_0)

		if var_32_1 then
			gohelper.setActive(arg_32_0._goTalk, true)

			arg_32_0._txttalk.text = var_32_1.desc

			TaskDispatcher.runDelay(arg_32_0._delayHideDialog, arg_32_0, arg_32_0._dialogHideTime)

			arg_32_0._curCell.toggled = true
		end
	end
end

function var_0_0._delayHideDialog(arg_33_0)
	gohelper.setActive(arg_33_0._goTalk, false)
end

function var_0_0._refreshChaosValueView(arg_34_0)
	gohelper.setActive(arg_34_0._goChaoAdd, true)
	arg_34_0._bottomAnimator:Play(UIAnimationName.Open, 0, 0)

	local var_34_0 = DungeonMazeModel.instance:getChaosValue()

	if var_34_0 >= var_0_9 then
		gohelper.setActive(arg_34_0._goNormalChaoValue, false)
		gohelper.setActive(arg_34_0._goDangerousChaoValue, true)
	else
		gohelper.setActive(arg_34_0._goNormalChaoValue, true)
		gohelper.setActive(arg_34_0._goDangerousChaoValue, false)
	end

	arg_34_0._textChaosAdd.text = "+" .. DungeonMazeModel.instance:getAddChaosValue()
	arg_34_0._textChaosValue.text = var_34_0
	arg_34_0._textDangerousValue.text = var_34_0
end

function var_0_0._refreshChessView(arg_35_0)
	recthelper.setAnchor(arg_35_0._transChess, 0, 0)
	ZProj.TweenHelper.DOFadeCanvasGroup(arg_35_0._goChess, 0, 1, 0.25)
end

function var_0_0._refreshSkillView(arg_36_0)
	local var_36_0, var_36_1 = DungeonMazeModel.instance:GetSkillState()

	gohelper.setActive(arg_36_0._goEyeNormal, var_36_0 == DungeonMazeEnum.skillState.usable)
	gohelper.setActive(arg_36_0._goEyeActive, var_36_0 == DungeonMazeEnum.skillState.using)
	gohelper.setActive(arg_36_0._goEyeCooling, var_36_0 == DungeonMazeEnum.skillState.cooling)
	gohelper.setActive(arg_36_0._goSkillCoolingStar1Light, var_36_1 >= 1)
	gohelper.setActive(arg_36_0._goSkillCoolingStar2Light, var_36_1 >= 2)
	gohelper.setActive(arg_36_0._goSkillCoolingStar1Drak, var_36_1 < 1)
	gohelper.setActive(arg_36_0._goSkillCoolingStar2Drak, var_36_1 < 2)

	if var_36_0 == DungeonMazeEnum.skillState.using then
		local var_36_2 = DungeonMazeModel.instance:getNearestCellToDestination()
		local var_36_3 = DungeonMazeModel.instance:getCurCellData():getDirectionTo(var_36_2)

		for iter_36_0, iter_36_1 in pairs(arg_36_0._roadLightMap) do
			gohelper.setActive(iter_36_1, iter_36_0 == var_36_3)
		end

		gohelper.setActive(arg_36_0._roadDirMap[var_36_3], false)
	else
		for iter_36_2, iter_36_3 in pairs(arg_36_0._roadLightMap) do
			gohelper.setActive(iter_36_3, false)
		end
	end
end

function var_0_0.onDestroyView(arg_37_0)
	arg_37_0._imageChessIcon:UnLoadImage()
end

return var_0_0
