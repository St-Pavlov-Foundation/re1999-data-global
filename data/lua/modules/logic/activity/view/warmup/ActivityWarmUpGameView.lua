module("modules.logic.activity.view.warmup.ActivityWarmUpGameView", package.seeall)

local var_0_0 = class("ActivityWarmUpGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagebase = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_progress/#simage_base")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._simagemap = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_map")
	arg_1_0._gocanvas = gohelper.findChild(arg_1_0.viewGO, "#go_canvas")
	arg_1_0._gobottle = gohelper.findChild(arg_1_0.viewGO, "#go_bottle")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")
	arg_1_0._gointerval = gohelper.findChild(arg_1_0.viewGO, "#go_progress/#go_interval")
	arg_1_0._btntrigger = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_trigger")
	arg_1_0._txttrigger = gohelper.findChildText(arg_1_0.viewGO, "#btn_trigger/#txt_trigger")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._gotargeticon = gohelper.findChild(arg_1_0.viewGO, "go_targets/targets/#go_targeticon")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "remaintimebg/#txt_remaintime")
	arg_1_0._imagebottle = gohelper.findChildImage(arg_1_0.viewGO, "#go_bottle/#image_bottle")
	arg_1_0._goresult = gohelper.findChild(arg_1_0.viewGO, "#go_result")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_result/#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_result/#go_fail")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_result/#simage_mask")
	arg_1_0._gobottletarget = gohelper.findChild(arg_1_0.viewGO, "bottle/hu/#go_bottletarget")
	arg_1_0._gobottlecurveleft = gohelper.findChild(arg_1_0.viewGO, "bottle/hu/#go_bottlecurveleft")
	arg_1_0._gobottlecurveright = gohelper.findChild(arg_1_0.viewGO, "bottle/hu/#go_bottlecurveright")
	arg_1_0._btnhome = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#go_fail/#btn_home")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_result/#go_fail/#btn_restart")
	arg_1_0._imageremaintip = gohelper.findChildImage(arg_1_0.viewGO, "remaintimebg/#image_remaintip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntrigger:AddClickListener(arg_2_0._btntriggerOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnhome:AddClickListener(arg_2_0._btnhomeOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btntrigger:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnhome:RemoveClickListener()
end

var_0_0.ProgressUIWidth = 940.79

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getActivityWarmUpBg("full/bj002"))
	arg_4_0._simagemap:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi2"))
	arg_4_0._simagebase:LoadImage(ResUrl.getActivityWarmUpBg("bg_xiadi"))
	arg_4_0._simagemask:LoadImage(ResUrl.getActivityWarmUpBg("bg_bodian"))

	arg_4_0._bgMaterial = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._simagemask.gameObject, SingleBgToMaterial)

	arg_4_0._bgMaterial:loadMaterial(arg_4_0._simagemask, "ui_black2transparent")

	arg_4_0._tfProgress = arg_4_0._goprogress.transform
	arg_4_0._goblackbg = gohelper.findChild(arg_4_0.viewGO, "#go_result/blackbg")
	arg_4_0._btnblackbg = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "#go_result/blackbg")
	arg_4_0._animBtnTrigger = arg_4_0._btntrigger:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._goAnimCountDown = gohelper.findChild(arg_4_0.viewGO, "remaintimebg")
	arg_4_0._animCountDown = arg_4_0._goAnimCountDown:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animTargetIcons = gohelper.findChild(arg_4_0.viewGO, "go_targets"):GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animBottle = gohelper.findChild(arg_4_0.viewGO, "bottle"):GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._flyTargetPos = arg_4_0._gobottletarget.transform.position
	arg_4_0._flyCurveLeftPos = arg_4_0._gobottlecurveleft.transform.position
	arg_4_0._flyCurveRightPos = arg_4_0._gobottlecurveright.transform.position

	arg_4_0:addEventCb(ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameTriggerNoHit, arg_4_0.onGameTriggerNoHit, arg_4_0)
	arg_4_0:addEventCb(ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameTriggerHit, arg_4_0.onGameTriggerHit, arg_4_0)
	arg_4_0:addEventCb(ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameNextRound, arg_4_0.onGameNextRound, arg_4_0)
	arg_4_0:addEventCb(ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameOverTimeOut, arg_4_0.onGameTimeOut, arg_4_0)
	arg_4_0:addEventCb(ActivityWarmUpGameController.instance, ActivityWarmUpEvent.GameOverFinished, arg_4_0.onGameOverFinished, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0.onCloseViewCall, arg_4_0)
	arg_4_0._btnblackbg:AddClickListener(arg_4_0._btnblackbgOnClick, arg_4_0)

	arg_4_0._targetItems = {}
	arg_4_0._blockItems = {}
	arg_4_0._lockAllClick = false
	arg_4_0._flyIconFlag = {}
	arg_4_0._rectBottle = arg_4_0._gobottle.transform
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._blockItems) do
		iter_5_1.imageIcon:UnLoadImage()
		iter_5_1.imageIconCur:UnLoadImage()
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0._targetItems) do
		iter_5_3.imageIcon:UnLoadImage()
	end

	arg_5_0._simagebg:UnLoadImage()
	arg_5_0._simagemap:UnLoadImage()
	arg_5_0._simagebase:UnLoadImage()
	arg_5_0._bgMaterial:dispose()
	arg_5_0._btnblackbg:RemoveClickListener()
end

function var_0_0.onOpen(arg_6_0)
	ActivityWarmUpGameController.instance:clearLastResult()
	ActivityWarmUpGameController.instance:prepareGame()

	arg_6_0._txttrigger.text = luaLang("p_activitywarmupview_challenge")

	arg_6_0._animBtnTrigger:Play(UIAnimationName.Start)
	arg_6_0:refreshGameDisplay()
	arg_6_0:updateForRemainTime()
	arg_6_0:updateForPointerMove()
	arg_6_0:allBlocksPlayAnim(UIAnimationName.Idle)
end

function var_0_0.onOpenFinish(arg_7_0)
	arg_7_0:refreshAllBlocks()
	arg_7_0:allBlocksPlayAnim(UIAnimationName.Idle)
end

function var_0_0.onClose(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
	ActivityWarmUpGameModel.instance:release()
	TaskDispatcher.cancelTask(arg_8_0.onLockCountDownCompleted, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onSwitchNextRoundCompleted, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onRepeatCountdown, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onGameClearAnimCompleted, arg_8_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_BLOCK_GAME_CLEAR)

	arg_8_0._waitingFlyIconNextRound = false
	arg_8_0._waitingFlyIconGameOver = false

	arg_8_0:stopAllFlyIcons()
	arg_8_0:stopEnterFrame()
end

function var_0_0.onCloseFinish(arg_9_0)
	if not ActivityWarmUpGameController.instance:getSaveResult() then
		ActivityWarmUpGameController.instance:dispatchEvent(ActivityWarmUpEvent.NotifyGameCancel)
	end
end

function var_0_0._btntriggerOnClick(arg_10_0)
	if arg_10_0._lockAllClick then
		return
	end

	if not ActivityWarmUpGameController.instance:getIsPlaying() then
		gohelper.setActive(arg_10_0._goresult, false)

		arg_10_0._txtremaintime.text = ""

		arg_10_0._animCountDown:Play("countdown")

		arg_10_0._lockAllClick = true
		arg_10_0._waitingFlyIconNextRound = false
		arg_10_0._waitingFlyIconGameOver = false

		gohelper.setActive(arg_10_0._imageremaintip.gameObject, false)
		AudioMgr.instance:trigger(AudioEnum.WarmUpGame.game_count_down)
		TaskDispatcher.runRepeat(arg_10_0.onRepeatCountdown, arg_10_0, 1)
		TaskDispatcher.runDelay(arg_10_0.onLockCountDownCompleted, arg_10_0, 3)
	elseif not ActivityWarmUpGameController.instance:getIsCD() then
		arg_10_0._animBtnTrigger:Play(UIAnimationName.Click, 0, 0)
		ActivityWarmUpGameController.instance:pointerTrigger()
	end
end

function var_0_0.onRepeatCountdown(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.game_count_down)
end

function var_0_0.onLockCountDownCompleted(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.onLockCountDownCompleted, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.onRepeatCountdown, arg_12_0)
	gohelper.setActive(arg_12_0._imageremaintip.gameObject, true)

	arg_12_0._lockAllClick = false

	arg_12_0._animCountDown:Play(UIAnimationName.Idle)
	ActivityWarmUpGameController.instance:startGame()
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.start_pot_boiling)

	arg_12_0._txttrigger.text = luaLang("p_activitywarmupgameview_add")

	arg_12_0._animBtnTrigger:Play(UIAnimationName.Idle)
	arg_12_0._animBottle:Play("bottle")
	arg_12_0._animTargetIcons:Play(UIAnimationName.Idle)
	TaskDispatcher.runRepeat(arg_12_0.onEnterFrame, arg_12_0, 0.01)

	arg_12_0._isBtnCD = false
	arg_12_0._flyIconFlag = {}

	arg_12_0:updateForRemainTime()
	arg_12_0:updateForTriggerCD()
	arg_12_0:allBlocksPlayAnim(UIAnimationName.Loop)
end

function var_0_0._btnresetOnClick(arg_13_0)
	if arg_13_0._lockAllClick then
		return
	end

	local function var_13_0()
		arg_13_0:onRestartComfirm()
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.WarmUpGameReFight, MsgBoxEnum.BoxType.Yes_No, var_13_0)
end

function var_0_0.onRestartComfirm(arg_15_0)
	if ActivityWarmUpGameController.instance:getIsPlaying() then
		AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
		arg_15_0._animBottle:Play(UIAnimationName.Idle)
		ActivityWarmUpGameController.instance:stopGame()
	end

	gohelper.setActive(arg_15_0._goresult, false)
	gohelper.setActive(arg_15_0._btntrigger.gameObject, true)
	ActivityWarmUpGameController.instance:clearLastResult()
	ActivityWarmUpGameController.instance:prepareGame()

	arg_15_0._txttrigger.text = luaLang("p_activitywarmupview_challenge")

	arg_15_0._animBtnTrigger:Play(UIAnimationName.Start)

	arg_15_0._isBtnCD = false
	arg_15_0._waitingFlyIconNextRound = false
	arg_15_0._waitingFlyIconGameOver = false

	arg_15_0:stopEnterFrame()
	arg_15_0:refreshGameDisplay()
	arg_15_0:updateForRemainTime()
	arg_15_0:updateForTriggerCD()
	arg_15_0:updateForPointerMove()
	arg_15_0:allBlocksPlayAnim("idle")
end

function var_0_0._btnblackbgOnClick(arg_16_0)
	gohelper.setActive(arg_16_0._goresult, false)

	if ActivityWarmUpGameController.instance:getSaveResult() then
		arg_16_0:closeThis()
	end
end

function var_0_0._btnhomeOnClick(arg_17_0)
	arg_17_0:closeThis()
end

function var_0_0._btnrestartOnClick(arg_18_0)
	gohelper.setActive(arg_18_0._goresult, false)
	arg_18_0:onRestartComfirm()
end

function var_0_0.onCloseViewCall(arg_19_0, arg_19_1)
	if arg_19_1 == ViewName.CommonPropView and ActivityWarmUpGameController.instance:getSaveResult() then
		arg_19_0:closeThis()
	end
end

function var_0_0.onGameTriggerNoHit(arg_20_0)
	logNormal("onGameTriggerNoHit")
	ActivityWarmUpGameController.instance:markCDTime()
end

function var_0_0.onGameTriggerHit(arg_21_0, arg_21_1)
	logNormal("onGameTriggerHit")
	arg_21_0:refreshAllTargetIcons()
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.trigger_click_nice)
	arg_21_0._animBtnTrigger:Play(UIAnimationName.Selected, 0, 0)

	local var_21_0 = arg_21_0:getBlockItemByData(arg_21_1)

	if var_21_0 then
		arg_21_0._flyIconFlag[var_21_0] = true

		TaskDispatcher.runRepeat(var_0_0.playIconFly, var_21_0, 0.01)
	end
end

function var_0_0.onGameNextRound(arg_22_0)
	logNormal("onGameNextRound")
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.trigger_click_nice)
	ActivityWarmUpGameController.instance:goNextRound()

	arg_22_0._lockAllClick = true

	if tabletool.len(arg_22_0._flyIconFlag) > 0 then
		arg_22_0._waitingFlyIconNextRound = true

		return
	end

	arg_22_0:nextRoundPlayAnim()
end

function var_0_0.checkNextRoundWaitFly(arg_23_0)
	if arg_23_0._waitingFlyIconNextRound and tabletool.len(arg_23_0._flyIconFlag) <= 0 then
		arg_23_0:nextRoundPlayAnim()

		return true
	end
end

function var_0_0.nextRoundPlayAnim(arg_24_0)
	arg_24_0._waitingFlyIconNextRound = false

	arg_24_0._animTargetIcons:Play(UIAnimationName.Switch)
	TaskDispatcher.runDelay(arg_24_0.onSwitchNextRoundCompleted, arg_24_0, 0.16)
end

function var_0_0.onSwitchNextRoundCompleted(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.onSwitchNextRoundCompleted, arg_25_0)

	arg_25_0._lockAllClick = false

	arg_25_0:refreshGameDisplay()
	arg_25_0:allBlocksPlayAnim(UIAnimationName.Open)
end

function var_0_0.onGameTimeOut(arg_26_0)
	logNormal("onGameTimeOut")
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
	arg_26_0._animBottle:Play(UIAnimationName.Idle)
	ActivityWarmUpGameController.instance:stopGame()
	arg_26_0:updateForTriggerCD()
	arg_26_0:stopEnterFrame()
	gohelper.setActive(arg_26_0._goresult, true)
	gohelper.setActive(arg_26_0._gosuccess, false)
	gohelper.setActive(arg_26_0._simagemask.gameObject, true)
	gohelper.setActive(arg_26_0._gofail, true)
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.play_game_fail)
end

function var_0_0.onGameOverFinished(arg_27_0)
	logNormal("onGameOverFinished")
	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.stop_pot_boiling)
	arg_27_0._animBottle:Play(UIAnimationName.Idle)
	ActivityWarmUpGameController.instance:stopGame()
	ActivityWarmUpGameController.instance:saveGameClearResult()
	arg_27_0:stopEnterFrame()

	arg_27_0._lockAllClick = true

	if tabletool.len(arg_27_0._flyIconFlag) > 0 then
		arg_27_0._waitingFlyIconGameOver = true

		return
	end

	arg_27_0:gameClear()
end

function var_0_0.checkGameOverWaitFly(arg_28_0)
	if arg_28_0._waitingFlyIconGameOver and tabletool.len(arg_28_0._flyIconFlag) <= 0 then
		arg_28_0._waitingFlyIconGameOver = false

		arg_28_0:gameClear()

		return true
	end
end

function var_0_0.onEnterFrame(arg_29_0)
	ActivityWarmUpGameController.instance:onGameUpdate()
	arg_29_0:updateForPointerMove()
	arg_29_0:updateForRemainTime()
	arg_29_0:updateForTriggerCD()
end

var_0_0.UI_BLOCK_GAME_CLEAR = "ActivityWarmUpGameView_gameClear"

function var_0_0.gameClear(arg_30_0)
	arg_30_0._lockAllClick = false

	AudioMgr.instance:trigger(AudioEnum.WarmUpGame.play_game_victory)
	gohelper.setActive(arg_30_0._goresult, true)
	gohelper.setActive(arg_30_0._simagemask.gameObject, false)
	gohelper.setActive(arg_30_0._gosuccess, true)
	gohelper.setActive(arg_30_0._gofail, false)
	gohelper.setActive(arg_30_0._btntrigger.gameObject, false)
	UIBlockMgr.instance:startBlock(var_0_0.UI_BLOCK_GAME_CLEAR)
	TaskDispatcher.runDelay(arg_30_0.onGameClearAnimCompleted, arg_30_0, 1.1)
end

function var_0_0.onGameClearAnimCompleted(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.onGameClearAnimCompleted, arg_31_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_BLOCK_GAME_CLEAR)

	if ActivityWarmUpGameController.instance:getSaveResult() then
		ActivityWarmUpGameController.instance:gameClear()
	end
end

function var_0_0.onPlayFailCompleted(arg_32_0)
	gohelper.setActive(arg_32_0._goresult, false)
	ActivityWarmUpGameController.instance:prepareGame()

	arg_32_0._txttrigger.text = luaLang("p_activitywarmupview_challenge")

	arg_32_0._animBtnTrigger:Play(UIAnimationName.Start)

	arg_32_0._isBtnCD = false

	arg_32_0:refreshGameDisplay()
end

function var_0_0.refreshGameDisplay(arg_33_0)
	arg_33_0:refreshAllTargetIcons()
	arg_33_0:refreshAllBlocks()
end

var_0_0.FlyProgressSpeed = 0.05
var_0_0.IconSelectTime = 0.334

function var_0_0.playIconFly(arg_34_0)
	local var_34_0 = arg_34_0.panel

	if not arg_34_0.progress or not arg_34_0.targetCurvePos then
		arg_34_0.progress = 0
		arg_34_0.posX, arg_34_0.posY, arg_34_0.posZ = transformhelper.getPos(arg_34_0.tfIcon)
		arg_34_0.posXCur, arg_34_0.posYCur, arg_34_0.posZCur = transformhelper.getPos(arg_34_0.tfIconCur)
		arg_34_0.targetCurvePos = arg_34_0.posX > var_34_0._flyTargetPos.x and var_34_0._flyCurveRightPos or var_34_0._flyCurveLeftPos
		arg_34_0.targetCurvePosCur = arg_34_0.posXCur > var_34_0._flyTargetPos.x and var_34_0._flyCurveRightPos or var_34_0._flyCurveLeftPos
		arg_34_0.startTime = Time.time

		arg_34_0.anim:Play(UIAnimationName.Selected)
		arg_34_0.animCur:Play(UIAnimationName.Selected)

		arg_34_0.isPlayGo = false
	end

	if Time.time - arg_34_0.startTime < var_0_0.IconSelectTime then
		return
	elseif not arg_34_0.isPlayGo then
		arg_34_0.isPlayGo = true

		arg_34_0.anim:Play("go")
		arg_34_0.animCur:Play("go")
	end

	local var_34_1 = math.min(1, arg_34_0.progress)
	local var_34_2 = math.cos(var_34_1 * math.pi * 0.5)
	local var_34_3 = Mathf.Lerp(var_34_0._flyTargetPos.x, arg_34_0.targetCurvePos.x, var_34_2)
	local var_34_4 = Mathf.Lerp(var_34_0._flyTargetPos.y, arg_34_0.targetCurvePos.y, var_34_2)
	local var_34_5 = Mathf.Lerp(var_34_0._flyTargetPos.z, arg_34_0.targetCurvePos.z, var_34_2)

	transformhelper.setPos(arg_34_0.tfIcon, Mathf.Lerp(arg_34_0.posX, var_34_3, var_34_1), Mathf.Lerp(arg_34_0.posY, var_34_4, var_34_1), Mathf.Lerp(arg_34_0.posZ, var_34_5, var_34_1))
	transformhelper.setPos(arg_34_0.tfIconCur, Mathf.Lerp(arg_34_0.posXCur, var_34_3, var_34_1), Mathf.Lerp(arg_34_0.posYCur, var_34_4, var_34_1), Mathf.Lerp(arg_34_0.posZCur, var_34_5, var_34_1))

	if var_34_1 >= 1 then
		var_0_0.onPlayIconFlyCompleted(arg_34_0)

		return
	end

	arg_34_0.progress = var_34_1 + var_0_0.FlyProgressSpeed
end

function var_0_0.onPlayIconFlyCompleted(arg_35_0)
	local var_35_0 = arg_35_0.panel

	var_35_0._flyIconFlag[arg_35_0] = nil
	arg_35_0.targetCurvePos = nil
	arg_35_0.progress = nil
	arg_35_0.isPlayGo = false

	TaskDispatcher.cancelTask(var_0_0.playIconFly, arg_35_0)

	local var_35_1 = var_35_0:checkNextRoundWaitFly()
	local var_35_2 = var_35_0:checkGameOverWaitFly()

	if not var_35_1 and not var_35_2 and tabletool.len(var_35_0._flyIconFlag) == 0 then
		var_35_0:refreshAllBlockAfterFly()
	end
end

function var_0_0.stopAllFlyIcons(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(arg_36_0._blockItems) do
		TaskDispatcher.cancelTask(var_0_0.playIconFly, iter_36_1)

		iter_36_1.targetCurvePos = nil
		iter_36_1.progress = nil
		iter_36_1.isPlayGo = false
		arg_36_0._flyIconFlag[iter_36_1] = nil
	end
end

function var_0_0.refreshAllTargetIcons(arg_37_0)
	local var_37_0 = ActivityWarmUpGameModel.instance:getTargetMatIDs()

	arg_37_0:hideAllTargetIcon()

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		local var_37_1 = arg_37_0:getOrCreateIcon(iter_37_0)

		if ActivityWarmUpGameModel.instance:matIsUsed(iter_37_1) then
			gohelper.setActive(var_37_1.go, false)
		else
			arg_37_0:refreshTargetIcon(var_37_1, iter_37_1, iter_37_0)
		end
	end
end

function var_0_0.refreshTargetIcon(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	gohelper.setActive(arg_38_1.go, true)

	local var_38_0, var_38_1 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, arg_38_2)

	if not string.nilorempty(var_38_1) then
		arg_38_1.imageIcon:LoadImage(var_38_1)
	end
end

function var_0_0.refreshAllBlocks(arg_39_0)
	local var_39_0 = ActivityWarmUpGameModel.instance:getBlockDatas()

	arg_39_0:stopAllFlyIcons()
	arg_39_0:hideAllBlock()

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		local var_39_1 = arg_39_0:getOrCreateBlock(iter_39_0)

		arg_39_0:refreshBlock(var_39_1, iter_39_1)
	end
end

function var_0_0.allBlocksPlayAnim(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in pairs(arg_40_0._blockItems) do
		iter_40_1.anim:Play(arg_40_1, 0, 0)
		iter_40_1.animCur:Play(arg_40_1, 0, 0)
	end
end

function var_0_0.refreshAllBlockAfterFly(arg_41_0)
	local var_41_0 = ActivityWarmUpGameModel.instance:getBlockDatas()
	local var_41_1 = {}

	for iter_41_0, iter_41_1 in ipairs(var_41_0) do
		local var_41_2 = arg_41_0:getOrCreateBlock(iter_41_0)

		var_41_1[var_41_2] = true

		arg_41_0:refreshBlock(var_41_2, iter_41_1)
	end

	for iter_41_2, iter_41_3 in pairs(arg_41_0._blockItems) do
		if not var_41_1[iter_41_3] then
			iter_41_3.blockData = nil

			gohelper.setActive(iter_41_3.go, false)
		end
	end
end

function var_0_0.refreshBlock(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = ActivityWarmUpGameModel.instance:getBindMatByBlock(arg_42_2)

	if var_42_0 then
		local var_42_1, var_42_2 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_42_0)

		if not string.nilorempty(var_42_2) then
			arg_42_1.imageIcon:LoadImage(var_42_2)
			arg_42_1.imageIconCur:LoadImage(var_42_2)
		end
	end

	gohelper.setActive(arg_42_1.go, not ActivityWarmUpGameModel.instance:matIsUsed(var_42_0))

	if arg_42_0._flyIconFlag[arg_42_1] then
		return
	end

	recthelper.setAnchor(arg_42_1.tfIcon, arg_42_1.iconAnchorX, arg_42_1.iconAnchorY)
	recthelper.setAnchor(arg_42_1.tfIconCur, arg_42_1.iconCurAnchorX, arg_42_1.iconCurAnchorY)

	arg_42_1.blockData = arg_42_2

	local var_42_3 = arg_42_2.endPos - arg_42_2.startPos

	recthelper.setAnchorX(arg_42_1.rectProgress, var_0_0.ProgressUIWidth * arg_42_2.startPos)
	recthelper.setWidth(arg_42_1.rectProgress, var_0_0.ProgressUIWidth * var_42_3)
	arg_42_1.anim:Play(UIAnimationName.Loop)
	arg_42_1.animCur:Play(UIAnimationName.Loop)

	local var_42_4 = ActivityWarmUpGameModel.instance:isCurrentTarget(arg_42_2)

	gohelper.setActive(arg_42_1.goNormal, not var_42_4)
	gohelper.setActive(arg_42_1.goCur, var_42_4)
end

function var_0_0.stopEnterFrame(arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0.onEnterFrame, arg_43_0)
end

function var_0_0.updateForPointerMove(arg_44_0)
	local var_44_0 = var_0_0.ProgressUIWidth * (ActivityWarmUpGameModel.instance.pointerVal - 0.5)

	recthelper.setAnchorX(arg_44_0._rectBottle, var_44_0)

	local var_44_1 = ActivityWarmUpGameModel.instance.pointerVal
	local var_44_2 = ActivityWarmUpGameModel.instance:getBlockDataByPointer(var_44_1)
	local var_44_3 = ActivityWarmUpGameModel.instance:getBindMatByBlock(var_44_2)

	if var_44_2 and not ActivityWarmUpGameModel.instance:matIsUsed(var_44_3) then
		arg_44_0._imagebottle.color = Color.New(0.9568627, 0.5294118, 0.3176471, 1)
	else
		arg_44_0._imagebottle.color = Color.New(1, 1, 1, 1)
	end
end

function var_0_0.updateForRemainTime(arg_45_0)
	local var_45_0 = ActivityWarmUpGameController.instance:getRemainTime() or ActivityWarmUpGameController.instance:getSettingRemainTime()

	if var_45_0 ~= nil then
		arg_45_0._txtremaintime.text = tostring(var_45_0)

		if var_45_0 ~= arg_45_0._lastRemainTime then
			if ActivityWarmUpGameController.instance:getIsPlaying() then
				AudioMgr.instance:trigger(AudioEnum.WarmUpGame.game_count_down)
			end

			arg_45_0._lastRemainTime = var_45_0
		end
	else
		arg_45_0._txtremaintime.text = ""
	end
end

function var_0_0.updateForTriggerCD(arg_46_0)
	arg_46_0._isBtnCD = ActivityWarmUpGameController.instance:getIsCD()

	ZProj.UGUIHelper.SetGrayscale(arg_46_0._btntrigger.gameObject, arg_46_0._isBtnCD)
end

function var_0_0.getOrCreateBlock(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0._blockItems[arg_47_1]

	if not var_47_0 then
		var_47_0 = arg_47_0:getUserDataTb_()

		local var_47_1 = gohelper.cloneInPlace(arg_47_0._gointerval, "item_interval_" .. tostring(arg_47_1))

		var_47_0.go = var_47_1
		var_47_0.imageProgress = gohelper.findChildImage(var_47_1, "#image_interval")
		var_47_0.imageIcon = gohelper.findChildSingleImage(var_47_1, "#image_interval/go_normal/#simage_icon")
		var_47_0.imageIconCur = gohelper.findChildSingleImage(var_47_1, "#image_interval/go_next/#simage_icon")
		var_47_0.tfIcon = var_47_0.imageIcon.transform
		var_47_0.tfIconCur = var_47_0.imageIconCur.transform
		var_47_0.rect = var_47_1.transform
		var_47_0.rectProgress = var_47_0.imageProgress.transform
		var_47_0.panel = arg_47_0

		local var_47_2 = gohelper.findChild(var_47_1, "#image_interval/go_normal")

		var_47_0.anim = var_47_2:GetComponent(typeof(UnityEngine.Animator))
		var_47_0.goNormal = var_47_2

		local var_47_3 = gohelper.findChild(var_47_1, "#image_interval/go_next")

		var_47_0.animCur = var_47_3:GetComponent(typeof(UnityEngine.Animator))
		var_47_0.goCur = var_47_3
		var_47_0.iconAnchorX, var_47_0.iconAnchorY = recthelper.getAnchor(var_47_0.tfIcon)
		var_47_0.iconCurAnchorX, var_47_0.iconCurAnchorY = recthelper.getAnchor(var_47_0.tfIconCur)
		var_47_0.iconPos = var_47_0.rect.position
		arg_47_0._blockItems[arg_47_1] = var_47_0
	end

	return var_47_0
end

function var_0_0.getBlockItemByData(arg_48_0, arg_48_1)
	for iter_48_0, iter_48_1 in pairs(arg_48_0._blockItems) do
		if iter_48_1.blockData == arg_48_1 then
			return iter_48_1
		end
	end
end

function var_0_0.getOrCreateIcon(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0._targetItems[arg_49_1]

	if not var_49_0 then
		var_49_0 = arg_49_0:getUserDataTb_()

		local var_49_1 = gohelper.cloneInPlace(arg_49_0._gotargeticon, "item_icon_" .. tostring(arg_49_1))

		var_49_0.go = var_49_1
		var_49_0.imageIcon = gohelper.findChildSingleImage(var_49_1, "#simage_icon")
		var_49_0.rect = var_49_1.transform
		arg_49_0._targetItems[arg_49_1] = var_49_0
	end

	return var_49_0
end

function var_0_0.hideAllTargetIcon(arg_50_0)
	for iter_50_0, iter_50_1 in pairs(arg_50_0._targetItems) do
		gohelper.setActive(iter_50_1.go, false)
	end
end

function var_0_0.hideAllBlock(arg_51_0)
	for iter_51_0, iter_51_1 in pairs(arg_51_0._blockItems) do
		iter_51_1.blockData = nil

		gohelper.setActive(iter_51_1.go, false)
	end
end

return var_0_0
