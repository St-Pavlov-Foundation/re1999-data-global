module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameView", package.seeall)

slot0 = class("LanShouPaGameView", BaseView)
slot0.TextShowInterval = 0.06
slot0.ScrollTalkMargin = {
	Top = 20,
	Bottom = 20
}
slot0.TextMaxHeight = 200
slot0.TipHeight = 30
slot0.offsetY = 1
slot0.offsetX = 2.5

function slot0.onInitView(slot0)
	slot0._txtRemainingTimesNum = gohelper.findChildText(slot0.viewGO, "LeftTop/RemainingTimes/txt_RemainingTimes/#txt_RemainingTimesNum")
	slot0._txtTargetDecr = gohelper.findChildText(slot0.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	slot0._txtMapName = gohelper.findChildText(slot0.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "Top/Tips2/image_TipsBG/#txt_Tips")
	slot0._btnReadBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightTop/#btn_ReadBtn")
	slot0._btnResetBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "RightTop/#btn_ResetBtn")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")
	slot0._goexcessive = gohelper.findChild(slot0.viewGO, "#go_excessive")
	slot0._gotouch = gohelper.findChild(slot0.viewGO, "#go_touch")
	slot0._isPlayingDialog = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnResetBtn:AddClickListener(slot0._btnResetBtnOnClick, slot0)
	slot0._btnReadBtn:AddClickListener(slot0._btnReadBtnOnClick, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.PlayDialogue, slot0.showDialog, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnResetBtn:RemoveClickListener()
	slot0._btnReadBtn:RemoveClickListener()
	slot0:removeEventCb(ChessGameController.instance, ChessGameEvent.PlayDialogue, slot0.showDialog, slot0)
end

function slot0._btnResetBtnOnClick(slot0)
	if ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, slot0._yesResetFunc)
end

function slot0._btnReadBtnOnClick(slot0)
	if ChessGameController.instance.eventMgr:isPlayingFlow() then
		return
	end

	if ChessGameModel.instance:getRound() > 0 then
		if not slot0._litterPointTime or slot0._litterPointTime < Time.time then
			slot0._litterPointTime = Time.time + 0.3

			gohelper.setActive(slot0.gotalk, false)
			slot0:_returnPointGame(ChessGameEnum.RollBack.LastPoint)
		end
	else
		GameFacade.showToast(ToastEnum.ActivityChessNotBack)
	end
end

slot0.UI_RESTART_BLOCK_KEY = "LanShouPaGameViewsGameMainDelayRestart"

function slot0._editableInitView(slot0)
	function slot0._yesResetFunc()
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
		TaskDispatcher.runDelay(uv0.delayRestartGame, uv0, LanShouPaEnum.AnimatorTime.SwithSceneOpen)
		gohelper.setActive(uv0.gotalk, false)
		ChessGameController.instance.eventMgr:stopFlow()
		uv0:onFinishTalk()
		ChessStatController.instance:statReset()
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
	end

	slot0._govxfinish = gohelper.findChild(slot0.viewGO, "LeftTop/TargetList/Target1/vx_finish")
	slot0._goMapName = gohelper.findChild(slot0.viewGO, "Top/Tips")
	slot0._aniMapName = slot0._goMapName:GetComponent(LanShouPaEnum.ComponentType.Animator)
	slot0._goTips = gohelper.findChild(slot0.viewGO, "Top/Tips2")
	slot0._aniTips = slot0._goTips:GetComponent(LanShouPaEnum.ComponentType.Animator)
	slot0._goresetgame = gohelper.findChild(slot0.viewGO, "excessive")
	slot0._swicthSceneAnimator = gohelper.findChild(slot0.viewGO, "#go_excessive/anim"):GetComponent(LanShouPaEnum.ComponentType.Animator)
	slot0._resetGameAnimator = gohelper.findChild(slot0.viewGO, "excessive/anim"):GetComponent(LanShouPaEnum.ComponentType.Animator)
	slot0._viewAnimator = slot0.viewGO:GetComponent(LanShouPaEnum.ComponentType.Animator)

	gohelper.setActive(slot0._goexcessive, false)
	gohelper.setActive(slot0._goresetgame, false)

	slot0._isLastSwitchStart = false

	slot0:_initDialogView()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.GameResultQuit, slot0.onResultQuit, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.CurrentConditionUpdate, slot0.refreshConditions, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.GameMapDataUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.RollBack, slot0.onRollBack, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.GameLoadingMapStateUpdate, slot0._onReadyGoNextMap, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.ClickOnTalking, slot0._clickOnTalking, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.GameToastUpdate, slot0._onToastUpdate, slot0)
	slot0:refreshUI()
	TaskDispatcher.runDelay(slot0._onTitleOpen, slot0, ChessGameEnum.TitleOpenAnimTime)
end

function slot0._onTitleOpen(slot0)
	TaskDispatcher.cancelTask(slot0._onTitleOpen, slot0)
	gohelper.setActive(slot0._goMapName, false)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(slot0.delayRestartGame, slot0)
	TaskDispatcher.cancelTask(slot0._onHideToast, slot0)
	TaskDispatcher.cancelTask(slot0._onResetOpenAnim, slot0)
	TaskDispatcher.cancelTask(slot0._onTitleOpen, slot0)
	TaskDispatcher.cancelTask(slot0.playNextStep, slot0)
	TaskDispatcher.cancelTask(slot0.onFinishTalk, slot0)
	TaskDispatcher.cancelTask(slot0._playfunc, slot0)
	TaskDispatcher.cancelTask(slot0.refreshConditions, slot0)
	TaskDispatcher.cancelTask(slot0._openCallback, slot0)
	slot0:removeUpdateBeat()
end

function slot0._initDialogView(slot0)
	slot0.dialogMap = {}
	slot0.isStartTalk = false
	slot0.gotalk = gohelper.findChild(slot0.viewGO, "go_talk")
	slot0.gotalkRect = slot0.gotalk:GetComponent(gohelper.Type_RectTransform)
	slot0.scrolltalk = gohelper.findChildScrollRect(slot0.gotalk, "Scroll View")
	slot0.txttalk = gohelper.findChildText(slot0.gotalk, "Scroll View/Viewport/Content/txt_talk")

	gohelper.setActive(slot0.gotalk, false)
end

function slot0._getEpisodeCfg(slot0)
	slot1 = ChessModel.instance:getActId()
	slot2 = ChessModel.instance:getEpisodeId()

	if slot0._curEpisodeCfg and slot0._curEpisodeCfg.activity == slot1 and slot0._curEpisodeCfg.id == slot2 then
		return slot0._curEpisodeCfg
	end

	if slot1 ~= nil and slot2 ~= nil then
		slot3 = ChessConfig.instance:getEpisodeCo(slot1, slot2)
		slot0._curEpisodeCfg = slot3
		slot0._curMainConditions = slot3 and GameUtil.splitString2(slot3.mainConfition, true, "|", "#")
		slot0._curConditionDesc = slot3 and string.split(slot3.mainConditionStr, "|")
		slot0._mapNames = slot3 and string.split(slot3.mapName, "#")

		return slot0._curEpisodeCfg
	end
end

function slot0.refreshUI(slot0)
	slot1 = slot0:_getEpisodeCfg()
	slot0._txtMapName.text = slot0._mapNames[ChessGameModel.instance:getNowMapIndex()]

	slot0:refreshConditions()
end

function slot0.onRollBack(slot0)
	slot0:onFinishTalk()
end

function slot0.refreshConditions(slot0)
	slot2 = ChessGameModel.instance:getCompletedCount() or 1
	slot0._curTargetIndex = slot2

	if slot0._curTargetIndex and slot0._curTargetIndex < slot2 and slot2 <= #string.split(slot0:_getEpisodeCfg().mainConditionStr, "|") then
		gohelper.setActive(slot0._govxfinish, false)
		gohelper.setActive(slot0._govxfinish, true)
		TaskDispatcher.runDelay(slot0.refreshConditions, slot0, 0.5)

		return
	end

	slot5 = nil
	slot0._txtTargetDecr.text = slot3[(slot2 + 1 <= #slot3 or #slot3) and slot2 + 1]
end

function slot0.onResultQuit(slot0)
	slot0:closeThis()
end

function slot0.delayRestartGame(slot0)
	TaskDispatcher.cancelTask(slot0.delayRestartGame, slot0)
	LanShouPaController.instance:resetStartGame()
end

function slot0._returnPointGame(slot0)
	LanShouPaController.instance:returnPointGame(ChessGameEnum.RollBack.LastPoint)
end

function slot0._onReadyGoNextMap(slot0, slot1, slot2)
	slot3 = slot1 == ChessGameEvent.LoadingMapState.Start

	slot0:switchScene(slot3, slot3 and slot2)

	if slot1 == ChessGameEvent.LoadingMapState.Finish and slot2 then
		slot0._isOpenAnim = true

		slot0._viewAnimator:Play(UIAnimationName.Open, 0, 0)
		slot0._viewAnimator:Update(0)
		TaskDispatcher.runDelay(slot0._openCallback, slot0, 1)
	end
end

function slot0._openCallback(slot0)
	TaskDispatcher.cancelTask(slot0._openCallback, slot0)

	slot0._isOpenAnim = false
end

function slot0.switchScene(slot0, slot1, slot2)
	if slot0._isLastSwitchStart == (slot1 == true) then
		return
	end

	if slot0._curSwitchSceneGO == nil then
		slot0._curSwitchSceneGO = slot2 and slot0._goresetgame or slot0._goexcessive
		slot0._curSwitchSceneAnim = slot2 and slot0._resetGameAnimator or slot0._swicthSceneAnimator
	end

	slot0._isLastSwitchStart = slot3

	if slot3 then
		UIBlockMgr.instance:startBlock(uv0.UI_RESTART_BLOCK_KEY)
		gohelper.setActive(slot0._curSwitchSceneGO, true)
		gohelper.setActive(slot0._gotouch, false)
	end

	slot0._curSwitchSceneAnim:Play(slot3 and "open" or "close")
	TaskDispatcher.cancelTask(slot0._onHideSwitchScene, slot0)
	TaskDispatcher.runDelay(slot0._onHideSwitchScene, slot0, 0.3)
end

function slot0._onHideSwitchScene(slot0)
	if slot0._isLastSwitchStart then
		slot0._curSwitchSceneAnim:Play("loop")
	else
		UIBlockMgr.instance:endBlock(uv0.UI_RESTART_BLOCK_KEY)

		if slot0._curSwitchSceneGO then
			gohelper.setActive(slot0._curSwitchSceneGO, false)
			gohelper.setActive(slot0._gotouch, true)

			slot0._curSwitchSceneGO = nil
			slot0._curSwitchSceneAnim = nil
		end

		slot0._txtMapName.text = slot0._mapNames[ChessGameModel.instance:getNowMapIndex()]

		gohelper.setActive(slot0._goMapName, true)
		TaskDispatcher.runDelay(slot0._onTitleOpen, slot0, ChessGameEnum.TitleOpenAnimTime)
	end
end

function slot0._onToastUpdate(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._onHideToast, slot0)
	TaskDispatcher.runDelay(slot0._onHideToast, slot0, 5)

	slot0._txtTips.text = slot1.content

	gohelper.setActive(slot0._goTips, true)
	slot0._aniTips:Play("open", 0, 0)
end

function slot0._onHideToast(slot0)
	gohelper.setActive(slot0._goTips, false)
end

function slot0.showDialog(slot0, slot1)
	slot6, slot7 = ChessGameInteractModel.instance:getInteractById(slot1.id):getXY()
	slot9 = ChessGameHelper.nodePosToWorldPos({
		z = 0,
		x = slot6,
		y = slot7
	})
	slot11, slot12, slot13 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)
	slot14 = recthelper.worldPosToAnchorPos(Vector3.New(slot9.x + uv0.offsetX, slot9.y + slot12 + uv0.offsetY, 0), slot0.viewGO.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getMainCamera())

	transformhelper.setLocalPos(slot0.gotalk.transform, slot14.x, slot14.y, 0)
	slot0:startTalk(slot1.txtco)
end

function slot0.startTalk(slot0, slot1)
	if slot0.isStartTalk then
		return
	end

	slot0._isPlayingDialog = true
	slot0._dialogConfigGroup = slot1
	slot0.isStartTalk = true

	ChessGameModel.instance:setTalk(true)

	slot0.curStepIndex = 1
	slot0.curCharIndex = 0
	slot0.lastShowTime = Time.time - uv0.TextShowInterval
	slot0.dialogConfig = slot0._dialogConfigGroup[slot0.curStepIndex]
	slot0.dialogLength = utf8.len(slot0.dialogConfig.content)

	slot0:initUpdateBeat()
end

function slot0.initUpdateBeat(slot0)
	slot0.updateHandle = UpdateBeat:CreateListener(slot0._onTalkFrame, slot0)

	UpdateBeat:AddListener(slot0.updateHandle)

	slot0.lateUpdateHandle = LateUpdateBeat:CreateListener(slot0._onTalkFrameLateUpdate, slot0)

	LateUpdateBeat:AddListener(slot0.lateUpdateHandle)
end

function slot0._onTalkFrame(slot0)
	if slot0.closedView then
		return
	end

	if not slot0.isStartTalk then
		return
	end

	if slot0.waitPlayNextStep or slot0.waitFinishTalk then
		return
	end

	if Time.time - slot0.lastShowTime < uv0.TextShowInterval then
		return
	end

	slot0:showTalkContent()
end

function slot0.showTalkContent(slot0)
	if slot0.closedView then
		return
	end

	slot0.lastShowTime = Time.time
	slot0.curCharIndex = slot0.curCharIndex + 1

	gohelper.setActive(slot0._goTalkNode, true)
	gohelper.setActive(slot0.gotalk, true)
	gohelper.setActive(slot0.gotalkDot, true)

	slot0.txttalk.text = utf8.sub(slot0.dialogConfig.content, 1, slot0.curCharIndex)
	slot0.scrolltalk.verticalNormalizedPosition = 0
	slot0.isDirty = true

	if slot0.curCharIndex == slot0.dialogLength + 1 then
		if slot0._dialogConfigGroup[slot0.curStepIndex + 1] then
			slot0.waitPlayNextStep = true
		else
			slot0.waitFinishTalk = true
		end
	end
end

function slot0.playNextStep(slot0)
	slot0._isPlayingDialog = true
	slot0.waitPlayNextStep = false
	slot0.curCharIndex = 0
	slot0.curStepIndex = slot0.curStepIndex
	slot0.dialogConfig = slot0._dialogConfigGroup[slot0.curStepIndex]
	slot0.dialogLength = utf8.len(slot0.dialogConfig.content)
end

function slot0.onFinishTalk(slot0)
	slot0.waitFinishTalk = false
	slot0.waitPlayNextStep = false
	slot0.isStartTalk = false
	slot0.lastShowTime = 0
	slot0.curCharIndex = 0
	slot0.curStepIndex = 1

	gohelper.setActive(slot0.gotalk, false)
	gohelper.setActive(slot0._goTalkNode, false)
	slot0:removeUpdateBeat()
	ChessGameModel.instance:setTalk(false)
	ChessGameController.instance:autoSelectPlayer()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.DialogEnd)
end

function slot0._onTalkFrameLateUpdate(slot0)
	TaskDispatcher.cancelTask(slot0._onTalkFrameLateUpdate, slot0)

	if slot0.closedView then
		return
	end

	if not slot0.isStartTalk then
		return
	end

	if slot0.waitPlayNextStep or slot0.waitFinishTalk then
		return
	end

	if not slot0.isDirty then
		return
	end

	slot0.isDirty = false
	slot1 = 0
	slot3 = uv0.ScrollTalkMargin.Top + uv0.ScrollTalkMargin.Bottom

	if slot0.waitPlayNextStep then
		slot1 = (uv0.TextMaxHeight < slot0.txttalk.preferredHeight and uv0.TextMaxHeight + slot3 or slot2 + slot3) + uv0.TipHeight
	end

	recthelper.setHeight(slot0.gotalkRect, slot1)
	gohelper.fitScreenOffset(slot0.gotalk.transform)
end

function slot0.removeUpdateBeat(slot0)
	if slot0.updateHandle then
		UpdateBeat:RemoveListener(slot0.updateHandle)
	end

	if slot0.lateUpdateHandle then
		UpdateBeat:RemoveListener(slot0.lateUpdateHandle)
	end
end

function slot0._clickOnTalking(slot0)
	if slot0.isStartTalk then
		slot0:removeUpdateBeat()

		if slot0._isPlayingDialog then
			slot0.txttalk.text = slot0.dialogConfig.content
			slot0.curStepIndex = slot0.curStepIndex + 1
			slot0.isDirty = true

			slot0:_onTalkFrameLateUpdate()

			slot0._isPlayingDialog = false
		else
			slot0:initUpdateBeat()

			if slot0.waitPlayNextStep then
				slot0:playNextStep()
			elseif slot0.waitFinishTalk then
				slot0:onFinishTalk()
			elseif slot0._dialogConfigGroup[slot0.curStepIndex] then
				slot0:playNextStep()
			else
				slot0:onFinishTalk()
			end
		end
	else
		slot0:onFinishTalk()
	end
end

return slot0
