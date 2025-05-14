module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameView", package.seeall)

local var_0_0 = class("LanShouPaGameView", BaseView)

var_0_0.TextShowInterval = 0.06
var_0_0.ScrollTalkMargin = {
	Top = 20,
	Bottom = 20
}
var_0_0.TextMaxHeight = 200
var_0_0.TipHeight = 30
var_0_0.offsetY = 1
var_0_0.offsetX = 2.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtRemainingTimesNum = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/RemainingTimes/txt_RemainingTimes/#txt_RemainingTimesNum")
	arg_1_0._txtTargetDecr = gohelper.findChildText(arg_1_0.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	arg_1_0._txtMapName = gohelper.findChildText(arg_1_0.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "Top/Tips2/image_TipsBG/#txt_Tips")
	arg_1_0._btnReadBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightTop/#btn_ReadBtn")
	arg_1_0._btnResetBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "RightTop/#btn_ResetBtn")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")
	arg_1_0._gotouch = gohelper.findChild(arg_1_0.viewGO, "#go_touch")
	arg_1_0._isPlayingDialog = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnResetBtn:AddClickListener(arg_2_0._btnResetBtnOnClick, arg_2_0)
	arg_2_0._btnReadBtn:AddClickListener(arg_2_0._btnReadBtnOnClick, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.PlayDialogue, arg_2_0.showDialog, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnResetBtn:RemoveClickListener()
	arg_3_0._btnReadBtn:RemoveClickListener()
	arg_3_0:removeEventCb(ChessGameController.instance, ChessGameEvent.PlayDialogue, arg_3_0.showDialog, arg_3_0)
end

function var_0_0._btnResetBtnOnClick(arg_4_0)
	if ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, arg_4_0._yesResetFunc)
end

function var_0_0._btnReadBtnOnClick(arg_5_0)
	if ChessGameController.instance.eventMgr:isPlayingFlow() then
		return
	end

	if ChessGameModel.instance:getRound() > 0 then
		if not arg_5_0._litterPointTime or arg_5_0._litterPointTime < Time.time then
			arg_5_0._litterPointTime = Time.time + 0.3

			gohelper.setActive(arg_5_0.gotalk, false)
			arg_5_0:_returnPointGame(ChessGameEnum.RollBack.LastPoint)
		end
	else
		GameFacade.showToast(ToastEnum.ActivityChessNotBack)
	end
end

var_0_0.UI_RESTART_BLOCK_KEY = "LanShouPaGameViewsGameMainDelayRestart"

function var_0_0._editableInitView(arg_6_0)
	function arg_6_0._yesResetFunc()
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
		TaskDispatcher.runDelay(arg_6_0.delayRestartGame, arg_6_0, LanShouPaEnum.AnimatorTime.SwithSceneOpen)
		gohelper.setActive(arg_6_0.gotalk, false)
		ChessGameController.instance.eventMgr:stopFlow()
		arg_6_0:onFinishTalk()
		ChessStatController.instance:statReset()
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
	end

	arg_6_0._govxfinish = gohelper.findChild(arg_6_0.viewGO, "LeftTop/TargetList/Target1/vx_finish")
	arg_6_0._goMapName = gohelper.findChild(arg_6_0.viewGO, "Top/Tips")
	arg_6_0._aniMapName = arg_6_0._goMapName:GetComponent(LanShouPaEnum.ComponentType.Animator)
	arg_6_0._goTips = gohelper.findChild(arg_6_0.viewGO, "Top/Tips2")
	arg_6_0._aniTips = arg_6_0._goTips:GetComponent(LanShouPaEnum.ComponentType.Animator)
	arg_6_0._goresetgame = gohelper.findChild(arg_6_0.viewGO, "excessive")

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "#go_excessive/anim")
	local var_6_1 = gohelper.findChild(arg_6_0.viewGO, "excessive/anim")

	arg_6_0._swicthSceneAnimator = var_6_0:GetComponent(LanShouPaEnum.ComponentType.Animator)
	arg_6_0._resetGameAnimator = var_6_1:GetComponent(LanShouPaEnum.ComponentType.Animator)
	arg_6_0._viewAnimator = arg_6_0.viewGO:GetComponent(LanShouPaEnum.ComponentType.Animator)

	gohelper.setActive(arg_6_0._goexcessive, false)
	gohelper.setActive(arg_6_0._goresetgame, false)

	arg_6_0._isLastSwitchStart = false

	arg_6_0:_initDialogView()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(ChessGameController.instance, ChessGameEvent.GameResultQuit, arg_8_0.onResultQuit, arg_8_0)
	arg_8_0:addEventCb(ChessGameController.instance, ChessGameEvent.CurrentConditionUpdate, arg_8_0.refreshConditions, arg_8_0)
	arg_8_0:addEventCb(ChessGameController.instance, ChessGameEvent.GameMapDataUpdate, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:addEventCb(ChessGameController.instance, ChessGameEvent.RollBack, arg_8_0.onRollBack, arg_8_0)
	arg_8_0:addEventCb(ChessGameController.instance, ChessGameEvent.GameLoadingMapStateUpdate, arg_8_0._onReadyGoNextMap, arg_8_0)
	arg_8_0:addEventCb(ChessGameController.instance, ChessGameEvent.ClickOnTalking, arg_8_0._clickOnTalking, arg_8_0)
	arg_8_0:addEventCb(ChessGameController.instance, ChessGameEvent.GameToastUpdate, arg_8_0._onToastUpdate, arg_8_0)
	arg_8_0:refreshUI()
	TaskDispatcher.runDelay(arg_8_0._onTitleOpen, arg_8_0, ChessGameEnum.TitleOpenAnimTime)
end

function var_0_0._onTitleOpen(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onTitleOpen, arg_9_0)
	gohelper.setActive(arg_9_0._goMapName, false)
end

function var_0_0.onClose(arg_10_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_10_0.delayRestartGame, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onHideToast, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onResetOpenAnim, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onTitleOpen, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.playNextStep, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.onFinishTalk, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._playfunc, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.refreshConditions, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._openCallback, arg_10_0)
	arg_10_0:removeUpdateBeat()
end

function var_0_0._initDialogView(arg_11_0)
	arg_11_0.dialogMap = {}
	arg_11_0.isStartTalk = false
	arg_11_0.gotalk = gohelper.findChild(arg_11_0.viewGO, "go_talk")
	arg_11_0.gotalkRect = arg_11_0.gotalk:GetComponent(gohelper.Type_RectTransform)
	arg_11_0.scrolltalk = gohelper.findChildScrollRect(arg_11_0.gotalk, "Scroll View")
	arg_11_0.txttalk = gohelper.findChildText(arg_11_0.gotalk, "Scroll View/Viewport/Content/txt_talk")

	gohelper.setActive(arg_11_0.gotalk, false)
end

function var_0_0._getEpisodeCfg(arg_12_0)
	local var_12_0 = ChessModel.instance:getActId()
	local var_12_1 = ChessModel.instance:getEpisodeId()

	if arg_12_0._curEpisodeCfg and arg_12_0._curEpisodeCfg.activity == var_12_0 and arg_12_0._curEpisodeCfg.id == var_12_1 then
		return arg_12_0._curEpisodeCfg
	end

	if var_12_0 ~= nil and var_12_1 ~= nil then
		local var_12_2 = ChessConfig.instance:getEpisodeCo(var_12_0, var_12_1)

		arg_12_0._curEpisodeCfg = var_12_2
		arg_12_0._curMainConditions = var_12_2 and GameUtil.splitString2(var_12_2.mainConfition, true, "|", "#")
		arg_12_0._curConditionDesc = var_12_2 and string.split(var_12_2.mainConditionStr, "|")
		arg_12_0._mapNames = var_12_2 and string.split(var_12_2.mapName, "#")

		return arg_12_0._curEpisodeCfg
	end
end

function var_0_0.refreshUI(arg_13_0)
	local var_13_0 = arg_13_0:_getEpisodeCfg()
	local var_13_1 = ChessGameModel.instance:getNowMapIndex()

	arg_13_0._txtMapName.text = arg_13_0._mapNames[var_13_1]

	arg_13_0:refreshConditions()
end

function var_0_0.onRollBack(arg_14_0)
	arg_14_0:onFinishTalk()
end

function var_0_0.refreshConditions(arg_15_0)
	local var_15_0 = arg_15_0:_getEpisodeCfg()
	local var_15_1 = ChessGameModel.instance:getCompletedCount() or 1
	local var_15_2 = string.split(var_15_0.mainConditionStr, "|")
	local var_15_3 = arg_15_0._curTargetIndex and var_15_1 > arg_15_0._curTargetIndex and var_15_1 <= #var_15_2

	arg_15_0._curTargetIndex = var_15_1

	if var_15_3 then
		gohelper.setActive(arg_15_0._govxfinish, false)
		gohelper.setActive(arg_15_0._govxfinish, true)
		TaskDispatcher.runDelay(arg_15_0.refreshConditions, arg_15_0, 0.5)

		return
	end

	local var_15_4

	if var_15_1 + 1 > #var_15_2 then
		var_15_4 = #var_15_2
	else
		var_15_4 = var_15_1 + 1
	end

	arg_15_0._txtTargetDecr.text = var_15_2[var_15_4]
end

function var_0_0.onResultQuit(arg_16_0)
	arg_16_0:closeThis()
end

function var_0_0.delayRestartGame(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.delayRestartGame, arg_17_0)
	LanShouPaController.instance:resetStartGame()
end

function var_0_0._returnPointGame(arg_18_0)
	LanShouPaController.instance:returnPointGame(ChessGameEnum.RollBack.LastPoint)
end

function var_0_0._onReadyGoNextMap(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1 == ChessGameEvent.LoadingMapState.Start

	arg_19_0:switchScene(var_19_0, var_19_0 and arg_19_2)

	if arg_19_1 == ChessGameEvent.LoadingMapState.Finish and arg_19_2 then
		arg_19_0._isOpenAnim = true

		arg_19_0._viewAnimator:Play(UIAnimationName.Open, 0, 0)
		arg_19_0._viewAnimator:Update(0)
		TaskDispatcher.runDelay(arg_19_0._openCallback, arg_19_0, 1)
	end
end

function var_0_0._openCallback(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._openCallback, arg_20_0)

	arg_20_0._isOpenAnim = false
end

function var_0_0.switchScene(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1 == true

	if arg_21_0._isLastSwitchStart == var_21_0 then
		return
	end

	if arg_21_0._curSwitchSceneGO == nil then
		arg_21_0._curSwitchSceneGO = arg_21_2 and arg_21_0._goresetgame or arg_21_0._goexcessive
		arg_21_0._curSwitchSceneAnim = arg_21_2 and arg_21_0._resetGameAnimator or arg_21_0._swicthSceneAnimator
	end

	arg_21_0._isLastSwitchStart = var_21_0

	if var_21_0 then
		UIBlockMgr.instance:startBlock(var_0_0.UI_RESTART_BLOCK_KEY)
		gohelper.setActive(arg_21_0._curSwitchSceneGO, true)
		gohelper.setActive(arg_21_0._gotouch, false)
	end

	arg_21_0._curSwitchSceneAnim:Play(var_21_0 and "open" or "close")
	TaskDispatcher.cancelTask(arg_21_0._onHideSwitchScene, arg_21_0)
	TaskDispatcher.runDelay(arg_21_0._onHideSwitchScene, arg_21_0, 0.3)
end

function var_0_0._onHideSwitchScene(arg_22_0)
	if arg_22_0._isLastSwitchStart then
		arg_22_0._curSwitchSceneAnim:Play("loop")
	else
		UIBlockMgr.instance:endBlock(var_0_0.UI_RESTART_BLOCK_KEY)

		if arg_22_0._curSwitchSceneGO then
			gohelper.setActive(arg_22_0._curSwitchSceneGO, false)
			gohelper.setActive(arg_22_0._gotouch, true)

			arg_22_0._curSwitchSceneGO = nil
			arg_22_0._curSwitchSceneAnim = nil
		end

		local var_22_0 = ChessGameModel.instance:getNowMapIndex()

		arg_22_0._txtMapName.text = arg_22_0._mapNames[var_22_0]

		gohelper.setActive(arg_22_0._goMapName, true)
		TaskDispatcher.runDelay(arg_22_0._onTitleOpen, arg_22_0, ChessGameEnum.TitleOpenAnimTime)
	end
end

function var_0_0._onToastUpdate(arg_23_0, arg_23_1)
	TaskDispatcher.cancelTask(arg_23_0._onHideToast, arg_23_0)
	TaskDispatcher.runDelay(arg_23_0._onHideToast, arg_23_0, 5)

	arg_23_0._txtTips.text = arg_23_1.content

	gohelper.setActive(arg_23_0._goTips, true)
	arg_23_0._aniTips:Play("open", 0, 0)
end

function var_0_0._onHideToast(arg_24_0)
	gohelper.setActive(arg_24_0._goTips, false)
end

function var_0_0.showDialog(arg_25_0, arg_25_1)
	local var_25_0 = CameraMgr.instance:getUICamera()
	local var_25_1 = CameraMgr.instance:getMainCamera()
	local var_25_2 = arg_25_1.id
	local var_25_3, var_25_4 = ChessGameInteractModel.instance:getInteractById(var_25_2):getXY()
	local var_25_5 = {
		z = 0,
		x = var_25_3,
		y = var_25_4
	}
	local var_25_6 = ChessGameHelper.nodePosToWorldPos(var_25_5)
	local var_25_7 = CameraMgr.instance:getMainCameraTrs().parent
	local var_25_8, var_25_9, var_25_10 = transformhelper.getLocalPos(var_25_7)
	local var_25_11 = recthelper.worldPosToAnchorPos(Vector3.New(var_25_6.x + var_0_0.offsetX, var_25_6.y + var_25_9 + var_0_0.offsetY, 0), arg_25_0.viewGO.transform, var_25_0, var_25_1)

	transformhelper.setLocalPos(arg_25_0.gotalk.transform, var_25_11.x, var_25_11.y, 0)
	arg_25_0:startTalk(arg_25_1.txtco)
end

function var_0_0.startTalk(arg_26_0, arg_26_1)
	if arg_26_0.isStartTalk then
		return
	end

	arg_26_0._isPlayingDialog = true
	arg_26_0._dialogConfigGroup = arg_26_1
	arg_26_0.isStartTalk = true

	ChessGameModel.instance:setTalk(true)

	arg_26_0.curStepIndex = 1
	arg_26_0.curCharIndex = 0
	arg_26_0.lastShowTime = Time.time - var_0_0.TextShowInterval
	arg_26_0.dialogConfig = arg_26_0._dialogConfigGroup[arg_26_0.curStepIndex]
	arg_26_0.dialogLength = utf8.len(arg_26_0.dialogConfig.content)

	arg_26_0:initUpdateBeat()
end

function var_0_0.initUpdateBeat(arg_27_0)
	arg_27_0.updateHandle = UpdateBeat:CreateListener(arg_27_0._onTalkFrame, arg_27_0)

	UpdateBeat:AddListener(arg_27_0.updateHandle)

	arg_27_0.lateUpdateHandle = LateUpdateBeat:CreateListener(arg_27_0._onTalkFrameLateUpdate, arg_27_0)

	LateUpdateBeat:AddListener(arg_27_0.lateUpdateHandle)
end

function var_0_0._onTalkFrame(arg_28_0)
	if arg_28_0.closedView then
		return
	end

	if not arg_28_0.isStartTalk then
		return
	end

	if arg_28_0.waitPlayNextStep or arg_28_0.waitFinishTalk then
		return
	end

	if Time.time - arg_28_0.lastShowTime < var_0_0.TextShowInterval then
		return
	end

	arg_28_0:showTalkContent()
end

function var_0_0.showTalkContent(arg_29_0)
	if arg_29_0.closedView then
		return
	end

	arg_29_0.lastShowTime = Time.time
	arg_29_0.curCharIndex = arg_29_0.curCharIndex + 1

	gohelper.setActive(arg_29_0._goTalkNode, true)
	gohelper.setActive(arg_29_0.gotalk, true)
	gohelper.setActive(arg_29_0.gotalkDot, true)

	arg_29_0.txttalk.text = utf8.sub(arg_29_0.dialogConfig.content, 1, arg_29_0.curCharIndex)
	arg_29_0.scrolltalk.verticalNormalizedPosition = 0
	arg_29_0.isDirty = true

	if arg_29_0.curCharIndex == arg_29_0.dialogLength + 1 then
		if arg_29_0._dialogConfigGroup[arg_29_0.curStepIndex + 1] then
			arg_29_0.waitPlayNextStep = true
		else
			arg_29_0.waitFinishTalk = true
		end
	end
end

function var_0_0.playNextStep(arg_30_0)
	arg_30_0._isPlayingDialog = true
	arg_30_0.waitPlayNextStep = false
	arg_30_0.curCharIndex = 0
	arg_30_0.curStepIndex = arg_30_0.curStepIndex
	arg_30_0.dialogConfig = arg_30_0._dialogConfigGroup[arg_30_0.curStepIndex]
	arg_30_0.dialogLength = utf8.len(arg_30_0.dialogConfig.content)
end

function var_0_0.onFinishTalk(arg_31_0)
	arg_31_0.waitFinishTalk = false
	arg_31_0.waitPlayNextStep = false
	arg_31_0.isStartTalk = false
	arg_31_0.lastShowTime = 0
	arg_31_0.curCharIndex = 0
	arg_31_0.curStepIndex = 1

	gohelper.setActive(arg_31_0.gotalk, false)
	gohelper.setActive(arg_31_0._goTalkNode, false)
	arg_31_0:removeUpdateBeat()
	ChessGameModel.instance:setTalk(false)
	ChessGameController.instance:autoSelectPlayer()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.DialogEnd)
end

function var_0_0._onTalkFrameLateUpdate(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._onTalkFrameLateUpdate, arg_32_0)

	if arg_32_0.closedView then
		return
	end

	if not arg_32_0.isStartTalk then
		return
	end

	if arg_32_0.waitPlayNextStep or arg_32_0.waitFinishTalk then
		return
	end

	if not arg_32_0.isDirty then
		return
	end

	arg_32_0.isDirty = false

	local var_32_0 = 0
	local var_32_1 = arg_32_0.txttalk.preferredHeight
	local var_32_2 = var_0_0.ScrollTalkMargin.Top + var_0_0.ScrollTalkMargin.Bottom

	if var_32_1 > var_0_0.TextMaxHeight then
		var_32_0 = var_0_0.TextMaxHeight + var_32_2
	else
		var_32_0 = var_32_1 + var_32_2
	end

	if arg_32_0.waitPlayNextStep then
		var_32_0 = var_32_0 + var_0_0.TipHeight
	end

	recthelper.setHeight(arg_32_0.gotalkRect, var_32_0)
	gohelper.fitScreenOffset(arg_32_0.gotalk.transform)
end

function var_0_0.removeUpdateBeat(arg_33_0)
	if arg_33_0.updateHandle then
		UpdateBeat:RemoveListener(arg_33_0.updateHandle)
	end

	if arg_33_0.lateUpdateHandle then
		UpdateBeat:RemoveListener(arg_33_0.lateUpdateHandle)
	end
end

function var_0_0._clickOnTalking(arg_34_0)
	if arg_34_0.isStartTalk then
		arg_34_0:removeUpdateBeat()

		if arg_34_0._isPlayingDialog then
			arg_34_0.txttalk.text = arg_34_0.dialogConfig.content
			arg_34_0.curStepIndex = arg_34_0.curStepIndex + 1
			arg_34_0.isDirty = true

			arg_34_0:_onTalkFrameLateUpdate()

			arg_34_0._isPlayingDialog = false
		else
			arg_34_0:initUpdateBeat()

			if arg_34_0.waitPlayNextStep then
				arg_34_0:playNextStep()
			elseif arg_34_0.waitFinishTalk then
				arg_34_0:onFinishTalk()
			elseif arg_34_0._dialogConfigGroup[arg_34_0.curStepIndex] then
				arg_34_0:playNextStep()
			else
				arg_34_0:onFinishTalk()
			end
		end
	else
		arg_34_0:onFinishTalk()
	end
end

return var_0_0
