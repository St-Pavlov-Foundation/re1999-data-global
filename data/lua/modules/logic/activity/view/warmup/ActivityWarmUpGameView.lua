module("modules.logic.activity.view.warmup.ActivityWarmUpGameView", package.seeall)

slot0 = class("ActivityWarmUpGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagebase = gohelper.findChildSingleImage(slot0.viewGO, "#go_progress/#simage_base")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._simagemap = gohelper.findChildSingleImage(slot0.viewGO, "#simage_map")
	slot0._gocanvas = gohelper.findChild(slot0.viewGO, "#go_canvas")
	slot0._gobottle = gohelper.findChild(slot0.viewGO, "#go_bottle")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_progress")
	slot0._gointerval = gohelper.findChild(slot0.viewGO, "#go_progress/#go_interval")
	slot0._btntrigger = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_trigger")
	slot0._txttrigger = gohelper.findChildText(slot0.viewGO, "#btn_trigger/#txt_trigger")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._gotargeticon = gohelper.findChild(slot0.viewGO, "go_targets/targets/#go_targeticon")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "remaintimebg/#txt_remaintime")
	slot0._imagebottle = gohelper.findChildImage(slot0.viewGO, "#go_bottle/#image_bottle")
	slot0._goresult = gohelper.findChild(slot0.viewGO, "#go_result")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_result/#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_result/#go_fail")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#go_result/#simage_mask")
	slot0._gobottletarget = gohelper.findChild(slot0.viewGO, "bottle/hu/#go_bottletarget")
	slot0._gobottlecurveleft = gohelper.findChild(slot0.viewGO, "bottle/hu/#go_bottlecurveleft")
	slot0._gobottlecurveright = gohelper.findChild(slot0.viewGO, "bottle/hu/#go_bottlecurveright")
	slot0._btnhome = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#go_fail/#btn_home")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/#go_fail/#btn_restart")
	slot0._imageremaintip = gohelper.findChildImage(slot0.viewGO, "remaintimebg/#image_remaintip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntrigger:AddClickListener(slot0._btntriggerOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnhome:AddClickListener(slot0._btnhomeOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrestart:RemoveClickListener()
	slot0._btntrigger:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnhome:RemoveClickListener()
end

slot0.ProgressUIWidth = 940.79

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getActivityWarmUpBg("full/bj002"))
	slot0._simagemap:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi2"))
	slot0._simagebase:LoadImage(ResUrl.getActivityWarmUpBg("bg_xiadi"))
	slot0._simagemask:LoadImage(ResUrl.getActivityWarmUpBg("bg_bodian"))

	slot0._bgMaterial = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._simagemask.gameObject, SingleBgToMaterial)

	slot0._bgMaterial:loadMaterial(slot0._simagemask, "ui_black2transparent")

	slot0._tfProgress = slot0._goprogress.transform
	slot0._goblackbg = gohelper.findChild(slot0.viewGO, "#go_result/blackbg")
	slot0._btnblackbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_result/blackbg")
	slot0._animBtnTrigger = slot0._btntrigger:GetComponent(typeof(UnityEngine.Animator))
	slot0._goAnimCountDown = gohelper.findChild(slot0.viewGO, "remaintimebg")
	slot0._animCountDown = slot0._goAnimCountDown:GetComponent(typeof(UnityEngine.Animator))
	slot0._animTargetIcons = gohelper.findChild(slot0.viewGO, "go_targets"):GetComponent(typeof(UnityEngine.Animator))
	slot0._animBottle = gohelper.findChild(slot0.viewGO, "bottle"):GetComponent(typeof(UnityEngine.Animator))
	slot0._flyTargetPos = slot0._gobottletarget.transform.position
	slot0._flyCurveLeftPos = slot0._gobottlecurveleft.transform.position
	slot0._flyCurveRightPos = slot0._gobottlecurveright.transform.position

	slot0:addEventCb(ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameTriggerNoHit, slot0.onGameTriggerNoHit, slot0)
	slot0:addEventCb(ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameTriggerHit, slot0.onGameTriggerHit, slot0)
	slot0:addEventCb(ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameNextRound, slot0.onGameNextRound, slot0)
	slot0:addEventCb(ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameOverTimeOut, slot0.onGameTimeOut, slot0)
	slot0:addEventCb(ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameOverFinished, slot0.onGameOverFinished, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseViewCall, slot0)
	slot0._btnblackbg:AddClickListener(slot0._btnblackbgOnClick, slot0)

	slot0._targetItems = {}
	slot0._blockItems = {}
	slot0._lockAllClick = false
	slot0._flyIconFlag = {}
	slot0._rectBottle = slot0._gobottle.transform
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._blockItems) do
		slot5.imageIcon:UnLoadImage()
		slot5.imageIconCur:UnLoadImage()
	end

	for slot4, slot5 in pairs(slot0._targetItems) do
		slot5.imageIcon:UnLoadImage()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagemap:UnLoadImage()
	slot0._simagebase:UnLoadImage()
	slot0._bgMaterial:dispose()
	slot0._btnblackbg:RemoveClickListener()
end

function slot0.onOpen(slot0)
	ActivityWarmUpGameController.instance:clearLastResult()
	ActivityWarmUpGameController.instance:prepareGame()

	slot0._txttrigger.text = luaLang("p_activitywarmupview_challenge")

	slot0._animBtnTrigger:Play(UIAnimationName.Start)
	slot0:refreshGameDisplay()
	slot0:updateForRemainTime()
	slot0:updateForPointerMove()
	slot0:allBlocksPlayAnim(UIAnimationName.Idle)
end

function slot0.onOpenFinish(slot0)
	slot0:refreshAllBlocks()
	slot0:allBlocksPlayAnim(UIAnimationName.Idle)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
	ActivityWarmUpGameModel.instance:release()
	TaskDispatcher.cancelTask(slot0.onLockCountDownCompleted, slot0)
	TaskDispatcher.cancelTask(slot0.onSwitchNextRoundCompleted, slot0)
	TaskDispatcher.cancelTask(slot0.onRepeatCountdown, slot0)
	TaskDispatcher.cancelTask(slot0.onGameClearAnimCompleted, slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_BLOCK_GAME_CLEAR)

	slot0._waitingFlyIconNextRound = false
	slot0._waitingFlyIconGameOver = false

	slot0:stopAllFlyIcons()
	slot0:stopEnterFrame()
end

function slot0.onCloseFinish(slot0)
	if not ActivityWarmUpGameController.instance:getSaveResult() then
		ActivityWarmUpGameController.instance:dispatchEvent(ActivityWarmUpEvent.NotifyGameCancel)
	end
end

function slot0._btntriggerOnClick(slot0)
	if slot0._lockAllClick then
		return
	end

	if not ActivityWarmUpGameController.instance:getIsPlaying() then
		gohelper.setActive(slot0._goresult, false)

		slot0._txtremaintime.text = ""

		slot0._animCountDown:Play("countdown")

		slot0._lockAllClick = true
		slot0._waitingFlyIconNextRound = false
		slot0._waitingFlyIconGameOver = false

		gohelper.setActive(slot0._imageremaintip.gameObject, false)
		AudioMgr.instance:trigger(AudioEnum.WarmUpGame.game_count_down)
		TaskDispatcher.runRepeat(slot0.onRepeatCountdown, slot0, 1)
		TaskDispatcher.runDelay(slot0.onLockCountDownCompleted, slot0, 3)
	elseif not ActivityWarmUpGameController.instance:getIsCD() then
		slot0._animBtnTrigger:Play(UIAnimationName.Click, 0, 0)
		ActivityWarmUpGameController.instance:pointerTrigger()
	end
end

function slot0.onRepeatCountdown(slot0)
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.game_count_down)
end

function slot0.onLockCountDownCompleted(slot0)
	TaskDispatcher.cancelTask(slot0.onLockCountDownCompleted, slot0)
	TaskDispatcher.cancelTask(slot0.onRepeatCountdown, slot0)
	gohelper.setActive(slot0._imageremaintip.gameObject, true)

	slot0._lockAllClick = false

	slot0._animCountDown:Play(UIAnimationName.Idle)
	ActivityWarmUpGameController.instance:startGame()
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.start_pot_boiling)

	slot0._txttrigger.text = luaLang("p_activitywarmupgameview_add")

	slot0._animBtnTrigger:Play(UIAnimationName.Idle)
	slot0._animBottle:Play("bottle")
	slot0._animTargetIcons:Play(UIAnimationName.Idle)
	TaskDispatcher.runRepeat(slot0.onEnterFrame, slot0, 0.01)

	slot0._isBtnCD = false
	slot0._flyIconFlag = {}

	slot0:updateForRemainTime()
	slot0:updateForTriggerCD()
	slot0:allBlocksPlayAnim(UIAnimationName.Loop)
end

function slot0._btnresetOnClick(slot0)
	if slot0._lockAllClick then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.WarmUpGameReFight, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:onRestartComfirm()
	end)
end

function slot0.onRestartComfirm(slot0)
	if ActivityWarmUpGameController.instance:getIsPlaying() then
		AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
		slot0._animBottle:Play(UIAnimationName.Idle)
		ActivityWarmUpGameController.instance:stopGame()
	end

	gohelper.setActive(slot0._goresult, false)
	gohelper.setActive(slot0._btntrigger.gameObject, true)
	ActivityWarmUpGameController.instance:clearLastResult()
	ActivityWarmUpGameController.instance:prepareGame()

	slot0._txttrigger.text = luaLang("p_activitywarmupview_challenge")

	slot0._animBtnTrigger:Play(UIAnimationName.Start)

	slot0._isBtnCD = false
	slot0._waitingFlyIconNextRound = false
	slot0._waitingFlyIconGameOver = false

	slot0:stopEnterFrame()
	slot0:refreshGameDisplay()
	slot0:updateForRemainTime()
	slot0:updateForTriggerCD()
	slot0:updateForPointerMove()
	slot0:allBlocksPlayAnim("idle")
end

function slot0._btnblackbgOnClick(slot0)
	gohelper.setActive(slot0._goresult, false)

	if ActivityWarmUpGameController.instance:getSaveResult() then
		slot0:closeThis()
	end
end

function slot0._btnhomeOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnrestartOnClick(slot0)
	gohelper.setActive(slot0._goresult, false)
	slot0:onRestartComfirm()
end

function slot0.onCloseViewCall(slot0, slot1)
	if slot1 == ViewName.CommonPropView and ActivityWarmUpGameController.instance:getSaveResult() then
		slot0:closeThis()
	end
end

function slot0.onGameTriggerNoHit(slot0)
	logNormal("onGameTriggerNoHit")
	ActivityWarmUpGameController.instance:markCDTime()
end

function slot0.onGameTriggerHit(slot0, slot1)
	logNormal("onGameTriggerHit")
	slot0:refreshAllTargetIcons()
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.trigger_click_nice)
	slot0._animBtnTrigger:Play(UIAnimationName.Selected, 0, 0)

	if slot0:getBlockItemByData(slot1) then
		slot0._flyIconFlag[slot2] = true

		TaskDispatcher.runRepeat(uv0.playIconFly, slot2, 0.01)
	end
end

function slot0.onGameNextRound(slot0)
	logNormal("onGameNextRound")
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.trigger_click_nice)
	ActivityWarmUpGameController.instance:goNextRound()

	slot0._lockAllClick = true

	if tabletool.len(slot0._flyIconFlag) > 0 then
		slot0._waitingFlyIconNextRound = true

		return
	end

	slot0:nextRoundPlayAnim()
end

function slot0.checkNextRoundWaitFly(slot0)
	if slot0._waitingFlyIconNextRound and tabletool.len(slot0._flyIconFlag) <= 0 then
		slot0:nextRoundPlayAnim()

		return true
	end
end

function slot0.nextRoundPlayAnim(slot0)
	slot0._waitingFlyIconNextRound = false

	slot0._animTargetIcons:Play(UIAnimationName.Switch)
	TaskDispatcher.runDelay(slot0.onSwitchNextRoundCompleted, slot0, 0.16)
end

function slot0.onSwitchNextRoundCompleted(slot0)
	TaskDispatcher.cancelTask(slot0.onSwitchNextRoundCompleted, slot0)

	slot0._lockAllClick = false

	slot0:refreshGameDisplay()
	slot0:allBlocksPlayAnim(UIAnimationName.Open)
end

function slot0.onGameTimeOut(slot0)
	logNormal("onGameTimeOut")
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
	slot0._animBottle:Play(UIAnimationName.Idle)
	ActivityWarmUpGameController.instance:stopGame()
	slot0:updateForTriggerCD()
	slot0:stopEnterFrame()
	gohelper.setActive(slot0._goresult, true)
	gohelper.setActive(slot0._gosuccess, false)
	gohelper.setActive(slot0._simagemask.gameObject, true)
	gohelper.setActive(slot0._gofail, true)
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.play_game_fail)
end

function slot0.onGameOverFinished(slot0)
	logNormal("onGameOverFinished")
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
	slot0._animBottle:Play(UIAnimationName.Idle)
	ActivityWarmUpGameController.instance:stopGame()
	ActivityWarmUpGameController.instance:saveGameClearResult()
	slot0:stopEnterFrame()

	slot0._lockAllClick = true

	if tabletool.len(slot0._flyIconFlag) > 0 then
		slot0._waitingFlyIconGameOver = true

		return
	end

	slot0:gameClear()
end

function slot0.checkGameOverWaitFly(slot0)
	if slot0._waitingFlyIconGameOver and tabletool.len(slot0._flyIconFlag) <= 0 then
		slot0._waitingFlyIconGameOver = false

		slot0:gameClear()

		return true
	end
end

function slot0.onEnterFrame(slot0)
	ActivityWarmUpGameController.instance:onGameUpdate()
	slot0:updateForPointerMove()
	slot0:updateForRemainTime()
	slot0:updateForTriggerCD()
end

slot0.UI_BLOCK_GAME_CLEAR = "ActivityWarmUpGameView_gameClear"

function slot0.gameClear(slot0)
	slot0._lockAllClick = false

	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.play_game_victory)
	gohelper.setActive(slot0._goresult, true)
	gohelper.setActive(slot0._simagemask.gameObject, false)
	gohelper.setActive(slot0._gosuccess, true)
	gohelper.setActive(slot0._gofail, false)
	gohelper.setActive(slot0._btntrigger.gameObject, false)
	UIBlockMgr.instance:startBlock(uv0.UI_BLOCK_GAME_CLEAR)
	TaskDispatcher.runDelay(slot0.onGameClearAnimCompleted, slot0, 1.1)
end

function slot0.onGameClearAnimCompleted(slot0)
	TaskDispatcher.cancelTask(slot0.onGameClearAnimCompleted, slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_BLOCK_GAME_CLEAR)

	if ActivityWarmUpGameController.instance:getSaveResult() then
		ActivityWarmUpGameController.instance:gameClear()
	end
end

function slot0.onPlayFailCompleted(slot0)
	gohelper.setActive(slot0._goresult, false)
	ActivityWarmUpGameController.instance:prepareGame()

	slot0._txttrigger.text = luaLang("p_activitywarmupview_challenge")

	slot0._animBtnTrigger:Play(UIAnimationName.Start)

	slot0._isBtnCD = false

	slot0:refreshGameDisplay()
end

function slot0.refreshGameDisplay(slot0)
	slot0:refreshAllTargetIcons()
	slot0:refreshAllBlocks()
end

slot0.FlyProgressSpeed = 0.05
slot0.IconSelectTime = 0.334

function slot0.playIconFly(slot0)
	slot1 = slot0.panel

	if not slot0.progress or not slot0.targetCurvePos then
		slot0.progress = 0
		slot0.posX, slot0.posY, slot0.posZ = transformhelper.getPos(slot0.tfIcon)
		slot0.posXCur, slot0.posYCur, slot0.posZCur = transformhelper.getPos(slot0.tfIconCur)
		slot0.targetCurvePos = slot1._flyTargetPos.x < slot0.posX and slot1._flyCurveRightPos or slot1._flyCurveLeftPos
		slot0.targetCurvePosCur = slot1._flyTargetPos.x < slot0.posXCur and slot1._flyCurveRightPos or slot1._flyCurveLeftPos
		slot0.startTime = Time.time

		slot0.anim:Play(UIAnimationName.Selected)
		slot0.animCur:Play(UIAnimationName.Selected)

		slot0.isPlayGo = false
	end

	if Time.time - slot0.startTime < uv0.IconSelectTime then
		return
	elseif not slot0.isPlayGo then
		slot0.isPlayGo = true

		slot0.anim:Play("go")
		slot0.animCur:Play("go")
	end

	slot2 = math.min(1, slot0.progress)
	slot3 = math.cos(slot2 * math.pi * 0.5)
	slot4 = Mathf.Lerp(slot1._flyTargetPos.x, slot0.targetCurvePos.x, slot3)
	slot5 = Mathf.Lerp(slot1._flyTargetPos.y, slot0.targetCurvePos.y, slot3)
	slot6 = Mathf.Lerp(slot1._flyTargetPos.z, slot0.targetCurvePos.z, slot3)

	transformhelper.setPos(slot0.tfIcon, Mathf.Lerp(slot0.posX, slot4, slot2), Mathf.Lerp(slot0.posY, slot5, slot2), Mathf.Lerp(slot0.posZ, slot6, slot2))
	transformhelper.setPos(slot0.tfIconCur, Mathf.Lerp(slot0.posXCur, slot4, slot2), Mathf.Lerp(slot0.posYCur, slot5, slot2), Mathf.Lerp(slot0.posZCur, slot6, slot2))

	if slot2 >= 1 then
		uv0.onPlayIconFlyCompleted(slot0)

		return
	end

	slot0.progress = slot2 + uv0.FlyProgressSpeed
end

function slot0.onPlayIconFlyCompleted(slot0)
	slot1 = slot0.panel
	slot1._flyIconFlag[slot0] = nil
	slot0.targetCurvePos = nil
	slot0.progress = nil
	slot0.isPlayGo = false

	TaskDispatcher.cancelTask(uv0.playIconFly, slot0)

	if not slot1:checkNextRoundWaitFly() and not slot1:checkGameOverWaitFly() and tabletool.len(slot1._flyIconFlag) == 0 then
		slot1:refreshAllBlockAfterFly()
	end
end

function slot0.stopAllFlyIcons(slot0)
	for slot4, slot5 in pairs(slot0._blockItems) do
		TaskDispatcher.cancelTask(uv0.playIconFly, slot5)

		slot5.targetCurvePos = nil
		slot5.progress = nil
		slot5.isPlayGo = false
		slot0._flyIconFlag[slot5] = nil
	end
end

function slot0.refreshAllTargetIcons(slot0)
	slot0:hideAllTargetIcon()

	for slot5, slot6 in ipairs(ActivityWarmUpGameModel.instance:getTargetMatIDs()) do
		if ActivityWarmUpGameModel.instance:matIsUsed(slot6) then
			gohelper.setActive(slot0:getOrCreateIcon(slot5).go, false)
		else
			slot0:refreshTargetIcon(slot7, slot6, slot5)
		end
	end
end

function slot0.refreshTargetIcon(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.go, true)

	slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, slot2)

	if not string.nilorempty(slot5) then
		slot1.imageIcon:LoadImage(slot5)
	end
end

function slot0.refreshAllBlocks(slot0)
	slot0:stopAllFlyIcons()
	slot0:hideAllBlock()

	for slot5, slot6 in ipairs(ActivityWarmUpGameModel.instance:getBlockDatas()) do
		slot0:refreshBlock(slot0:getOrCreateBlock(slot5), slot6)
	end
end

function slot0.allBlocksPlayAnim(slot0, slot1)
	for slot5, slot6 in pairs(slot0._blockItems) do
		slot6.anim:Play(slot1, 0, 0)
		slot6.animCur:Play(slot1, 0, 0)
	end
end

function slot0.refreshAllBlockAfterFly(slot0)
	slot2 = {
		[slot8] = true
	}

	for slot6, slot7 in ipairs(ActivityWarmUpGameModel.instance:getBlockDatas()) do
		slot0:refreshBlock(slot0:getOrCreateBlock(slot6), slot7)
	end

	for slot6, slot7 in pairs(slot0._blockItems) do
		if not slot2[slot7] then
			slot7.blockData = nil

			gohelper.setActive(slot7.go, false)
		end
	end
end

function slot0.refreshBlock(slot0, slot1, slot2)
	if ActivityWarmUpGameModel.instance:getBindMatByBlock(slot2) then
		slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, slot3)

		if not string.nilorempty(slot5) then
			slot1.imageIcon:LoadImage(slot5)
			slot1.imageIconCur:LoadImage(slot5)
		end
	end

	gohelper.setActive(slot1.go, not ActivityWarmUpGameModel.instance:matIsUsed(slot3))

	if slot0._flyIconFlag[slot1] then
		return
	end

	recthelper.setAnchor(slot1.tfIcon, slot1.iconAnchorX, slot1.iconAnchorY)
	recthelper.setAnchor(slot1.tfIconCur, slot1.iconCurAnchorX, slot1.iconCurAnchorY)

	slot1.blockData = slot2

	recthelper.setAnchorX(slot1.rectProgress, uv0.ProgressUIWidth * slot2.startPos)
	recthelper.setWidth(slot1.rectProgress, uv0.ProgressUIWidth * (slot2.endPos - slot2.startPos))
	slot1.anim:Play(UIAnimationName.Loop)
	slot1.animCur:Play(UIAnimationName.Loop)

	slot5 = ActivityWarmUpGameModel.instance:isCurrentTarget(slot2)

	gohelper.setActive(slot1.goNormal, not slot5)
	gohelper.setActive(slot1.goCur, slot5)
end

function slot0.stopEnterFrame(slot0)
	TaskDispatcher.cancelTask(slot0.onEnterFrame, slot0)
end

function slot0.updateForPointerMove(slot0)
	recthelper.setAnchorX(slot0._rectBottle, uv0.ProgressUIWidth * (ActivityWarmUpGameModel.instance.pointerVal - 0.5))

	slot3 = ActivityWarmUpGameModel.instance:getBlockDataByPointer(ActivityWarmUpGameModel.instance.pointerVal)

	if slot3 and not ActivityWarmUpGameModel.instance:matIsUsed(ActivityWarmUpGameModel.instance:getBindMatByBlock(slot3)) then
		slot0._imagebottle.color = Color.New(0.9568627, 0.5294118, 0.3176471, 1)
	else
		slot0._imagebottle.color = Color.New(1, 1, 1, 1)
	end
end

function slot0.updateForRemainTime(slot0)
	if (ActivityWarmUpGameController.instance:getRemainTime() or ActivityWarmUpGameController.instance:getSettingRemainTime()) ~= nil then
		slot0._txtremaintime.text = tostring(slot1)

		if slot1 ~= slot0._lastRemainTime then
			if ActivityWarmUpGameController.instance:getIsPlaying() then
				AudioMgr.instance:trigger(AudioEnum.WarmUpGame.game_count_down)
			end

			slot0._lastRemainTime = slot1
		end
	else
		slot0._txtremaintime.text = ""
	end
end

function slot0.updateForTriggerCD(slot0)
	slot0._isBtnCD = ActivityWarmUpGameController.instance:getIsCD()

	ZProj.UGUIHelper.SetGrayscale(slot0._btntrigger.gameObject, slot0._isBtnCD)
end

function slot0.getOrCreateBlock(slot0, slot1)
	if not slot0._blockItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._gointerval, "item_interval_" .. tostring(slot1))
		slot2.go = slot3
		slot2.imageProgress = gohelper.findChildImage(slot3, "#image_interval")
		slot2.imageIcon = gohelper.findChildSingleImage(slot3, "#image_interval/go_normal/#simage_icon")
		slot2.imageIconCur = gohelper.findChildSingleImage(slot3, "#image_interval/go_next/#simage_icon")
		slot2.tfIcon = slot2.imageIcon.transform
		slot2.tfIconCur = slot2.imageIconCur.transform
		slot2.rect = slot3.transform
		slot2.rectProgress = slot2.imageProgress.transform
		slot2.panel = slot0
		slot4 = gohelper.findChild(slot3, "#image_interval/go_normal")
		slot2.anim = slot4:GetComponent(typeof(UnityEngine.Animator))
		slot2.goNormal = slot4
		slot4 = gohelper.findChild(slot3, "#image_interval/go_next")
		slot2.animCur = slot4:GetComponent(typeof(UnityEngine.Animator))
		slot2.goCur = slot4
		slot2.iconAnchorX, slot2.iconAnchorY = recthelper.getAnchor(slot2.tfIcon)
		slot2.iconCurAnchorX, slot2.iconCurAnchorY = recthelper.getAnchor(slot2.tfIconCur)
		slot2.iconPos = slot2.rect.position
		slot0._blockItems[slot1] = slot2
	end

	return slot2
end

function slot0.getBlockItemByData(slot0, slot1)
	for slot5, slot6 in pairs(slot0._blockItems) do
		if slot6.blockData == slot1 then
			return slot6
		end
	end
end

function slot0.getOrCreateIcon(slot0, slot1)
	if not slot0._targetItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._gotargeticon, "item_icon_" .. tostring(slot1))
		slot2.go = slot3
		slot2.imageIcon = gohelper.findChildSingleImage(slot3, "#simage_icon")
		slot2.rect = slot3.transform
		slot0._targetItems[slot1] = slot2
	end

	return slot2
end

function slot0.hideAllTargetIcon(slot0)
	for slot4, slot5 in pairs(slot0._targetItems) do
		gohelper.setActive(slot5.go, false)
	end
end

function slot0.hideAllBlock(slot0)
	for slot4, slot5 in pairs(slot0._blockItems) do
		slot5.blockData = nil

		gohelper.setActive(slot5.go, false)
	end
end

return slot0
