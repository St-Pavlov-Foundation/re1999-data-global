module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoPlayerAnimComp", package.seeall)

local var_0_0 = class("FeiLinShiDuoPlayerAnimComp", BaseUnitSpawn)
local var_0_1 = {
	LoopClimb = "loop_climb",
	EndClimb = "end_climb",
	StartClimb = "start_climb",
	EndRun = "end_run",
	StartPush = "start_push",
	Fall = "fall",
	Die = "die",
	EndPush = "end_push",
	StartRun = "start_run",
	EndFall = "fall_end",
	Idle = "idle",
	Jump = "jump",
	LoopPush = "loop_push",
	LoopRun = "loop_run"
}
local var_0_2 = {
	[var_0_1.Idle] = true,
	[var_0_1.LoopClimb] = true,
	[var_0_1.LoopPush] = true,
	[var_0_1.LoopRun] = true,
	[var_0_1.Fall] = true
}

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0.trans = arg_1_1.transform
	arg_1_0.curAnimName = var_0_1.Idle
	arg_1_0.mapConfigData = FeiLinShiDuoGameModel.instance:getMapConfigData()
	arg_1_0.curDeltaMoveX = arg_1_0.mapConfigData.gameConfig.playerForward
	arg_1_0.guiSpine = GuiSpine.Create(arg_1_1, true)

	arg_1_0.guiSpine:setResPath(FeiLinShiDuoEnum.RoleResPath, arg_1_0._onSpineLoaded, arg_1_0, true)

	arg_1_0.maxMoveSpeed = FeiLinShiDuoEnum.PlayerMoveSpeed
	arg_1_0.maxPushSpeed = FeiLinShiDuoEnum.PlayerPushBoxSpeed
	arg_1_0.curMoveSpeed = 0
	arg_1_0.isStartMove = false
	arg_1_0.isEndMove = false
	arg_1_0.isStartPush = false
	arg_1_0.isEndPush = false
	arg_1_0.isFalling = false
	arg_1_0.isClimbing = false
	arg_1_0.isJumping = false
	arg_1_0.isDying = false
	arg_1_0.playerComp = MonoHelper.getLuaComFromGo(arg_1_1, FeiLinShiDuoPlayerComp)

	FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(arg_1_0.curMoveSpeed)
end

function var_0_0._onSpineLoaded(arg_2_0)
	arg_2_0.spineGO = arg_2_0.guiSpine:getSpineGo()

	arg_2_0.guiSpine:setActionEventCb(arg_2_0.onAnimEvent, arg_2_0)

	local var_2_0 = arg_2_0.guiSpine:getSkeletonGraphic().material
	local var_2_1 = UnityEngine.Object.Instantiate(var_2_0)

	arg_2_0.guiSpine:getSkeletonGraphic().material = var_2_1
	arg_2_0.spineMaterial = var_2_1

	arg_2_0:changePlayerColor(FeiLinShiDuoEnum.ColorType.None)
end

function var_0_0.addEventListeners(arg_3_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.changePlayerColor, arg_3_0.changePlayerColor, arg_3_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, arg_3_0.resetData, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.changePlayerColor, arg_4_0.changePlayerColor, arg_4_0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, arg_4_0.resetData, arg_4_0)
end

function var_0_0.changePlayerColor(arg_5_0, arg_5_1)
	if arg_5_0.spineMaterial then
		local var_5_0 = FeiLinShiDuoEnum.ColorStr[arg_5_1]
		local var_5_1 = GameUtil.parseColor(var_5_0)

		arg_5_0.spineMaterial:SetColor(FeiLinShiDuoEnum.playerColor, var_5_1)
	end
end

function var_0_0.playAnim(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.curAnimName = arg_6_1

	if arg_6_0.spineGO then
		local var_6_0 = arg_6_2 or 0.1

		arg_6_0.guiSpine:setBodyAnimation(arg_6_1, var_0_2[arg_6_1], var_6_0)
	end

	FeiLinShiDuoGameModel.instance:setPlayerIsIdleState(arg_6_0.curAnimName == var_0_1.Idle)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.playerChangeAnim)
end

function var_0_0.getSpineGO(arg_7_0)
	return arg_7_0.spineGO
end

function var_0_0.onAnimEvent(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == SpineAnimEvent.ActionComplete then
		if (arg_8_1 == var_0_1.EndRun or arg_8_1 == var_0_1.EndClimb or arg_8_1 == var_0_1.EndPush or arg_8_1 == var_0_1.Jump or arg_8_1 == var_0_1.EndFall or arg_8_1 == var_0_1.Die) and not arg_8_0.isClimbing and not arg_8_0.isFalling then
			arg_8_0:playAnim(var_0_1.Idle)

			arg_8_0.curMoveSpeed = 0
			arg_8_0.curDeltaMoveX = 0
			arg_8_0.isJumping = false
			arg_8_0.isDying = false

			if arg_8_0.playerComp then
				if arg_8_1 == var_0_1.Die then
					arg_8_0.playerComp:playerReborn()
				end

				arg_8_0.playerComp:setIdleState()
			end

			arg_8_0:stopLoopAudio()
		elseif arg_8_1 == var_0_1.StartRun and not arg_8_0.isFalling and not arg_8_0.isClimbing and not arg_8_0.isJumping and not arg_8_0.isDying then
			arg_8_0:playAnim(var_0_1.LoopRun)

			arg_8_0.curMoveSpeed = arg_8_0.maxMoveSpeed

			arg_8_0:stopLoopAudio()
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_move_loop)
		elseif arg_8_1 == var_0_1.StartPush and not arg_8_0.isFalling and not arg_8_0.isClimbing and not arg_8_0.isJumping and not arg_8_0.isDying then
			arg_8_0:playAnim(var_0_1.LoopPush)

			arg_8_0.curMoveSpeed = arg_8_0.maxPushSpeed

			arg_8_0:stopLoopAudio()
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_box_push_loop)
		elseif arg_8_1 == var_0_1.StartClimb and not arg_8_0.isFalling and not arg_8_0.isJumping and not arg_8_0.isDying then
			arg_8_0:playAnim(var_0_1.LoopClimb)

			arg_8_0.curMoveSpeed = FeiLinShiDuoEnum.climbSpeed

			arg_8_0:stopLoopAudio()
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_ladder_crawl_loop)
		end

		arg_8_0.isStartMove = false
		arg_8_0.isEndMove = false
		arg_8_0.isStartPush = false
		arg_8_0.isEndPush = false

		FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(arg_8_0.curMoveSpeed)
	end
end

function var_0_0.setMoveAnim(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.playerCanMove = arg_9_0.playerComp:checkPlayerCanMove()
	arg_9_0.isFalling = false
	arg_9_0.isClimbing = false
	arg_9_0.isTouchBox = arg_9_0:checkIsTouchBox(arg_9_2)

	if arg_9_0.isTouchBox then
		arg_9_0:pushBoxMove(arg_9_1)
	else
		arg_9_0:normalMove(arg_9_1)
	end

	FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(arg_9_0.curMoveSpeed)

	return arg_9_0.curDeltaMoveX
end

function var_0_0.checkIsTouchBox(arg_10_0, arg_10_1)
	if #arg_10_1 > 0 then
		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			if iter_10_1.type == FeiLinShiDuoEnum.ObjectType.Box then
				return true
			end
		end
	end

	return false
end

function var_0_0.normalMove(arg_11_0, arg_11_1)
	if arg_11_1 ~= 0 and arg_11_0.curMoveSpeed == 0 and not arg_11_0.isStartMove and not arg_11_0.isEndMove and arg_11_0.playerCanMove then
		arg_11_0.curDeltaMoveX = arg_11_1

		arg_11_0:playAnim(var_0_1.StartRun)

		arg_11_0.isStartMove = true
		arg_11_0.isEndMove = false
		arg_11_0.curMoveSpeed = arg_11_0.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed
	elseif arg_11_0.isStartMove and arg_11_0.playerCanMove then
		arg_11_0.curMoveSpeed = math.max(arg_11_0.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed, arg_11_0.maxMoveSpeed)
	elseif ((arg_11_1 == 0 or arg_11_0.curDeltaMoveX == -arg_11_1) and arg_11_0.curDeltaMoveX ~= 0 and arg_11_0.curMoveSpeed > 0 or arg_11_0.curAnimName == var_0_1.LoopPush or not arg_11_0.playerCanMove) and not arg_11_0.isEndMove and arg_11_0.curAnimName ~= var_0_1.Idle then
		arg_11_0.curMoveSpeed = math.min(arg_11_0.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)

		arg_11_0:playAnim(var_0_1.EndRun)

		arg_11_0.isEndMove = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	elseif arg_11_0.isEndMove then
		arg_11_0.curMoveSpeed = math.min(arg_11_0.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)
	end
end

function var_0_0.pushBoxMove(arg_12_0, arg_12_1)
	if arg_12_1 ~= 0 and not arg_12_0.isStartPush and not arg_12_0.isEndMove and arg_12_0.curAnimName == var_0_1.Idle and arg_12_0.playerCanMove then
		arg_12_0.curDeltaMoveX = arg_12_1

		arg_12_0:playAnim(var_0_1.StartPush)

		arg_12_0.isStartPush = true
		arg_12_0.isEndPush = false
		arg_12_0.curMoveSpeed = arg_12_0.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed
	elseif not arg_12_0:checkCurIsMoveAnim() and arg_12_0.isStartPush and arg_12_0.playerCanMove then
		arg_12_0.curMoveSpeed = math.max(arg_12_0.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed, arg_12_0.maxPushSpeed)
	elseif arg_12_0:checkCurIsMoveAnim() and not arg_12_0.isEndPush then
		arg_12_0.curMoveSpeed = math.min(arg_12_0.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)

		arg_12_0:playAnim(var_0_1.EndRun)

		arg_12_0.isEndPush = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	elseif not arg_12_0:checkCurIsMoveAnim() and arg_12_1 == 0 and arg_12_0.curDeltaMoveX ~= 0 then
		arg_12_0.curMoveSpeed = 0
	elseif not arg_12_0:checkCurIsMoveAnim() and arg_12_1 ~= 0 and arg_12_0.curAnimName == var_0_1.LoopPush and arg_12_1 == arg_12_0.curDeltaMoveX and arg_12_0.playerCanMove then
		arg_12_0.curMoveSpeed = math.max(arg_12_0.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed, arg_12_0.maxPushSpeed)
	elseif not arg_12_0:checkCurIsMoveAnim() and (arg_12_1 == -arg_12_0.curDeltaMoveX and arg_12_1 ~= 0 or not arg_12_0.playerCanMove) and not arg_12_0.isEndPush and arg_12_0.curAnimName ~= var_0_1.EndPush and arg_12_0.curAnimName ~= var_0_1.Idle then
		arg_12_0.curMoveSpeed = math.min(arg_12_0.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)

		arg_12_0:playAnim(var_0_1.EndPush)

		arg_12_0.isEndPush = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_box_push_loop)
	elseif arg_12_0.isEndPush then
		arg_12_0.curMoveSpeed = math.min(arg_12_0.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)
	end
end

function var_0_0.setPlayerMove(arg_13_0, arg_13_1)
	if arg_13_0.curDeltaMoveX ~= 0 then
		arg_13_0:setForward(arg_13_0.curDeltaMoveX)
	end

	transformhelper.setLocalPosXY(arg_13_1, arg_13_1.localPosition.x + arg_13_0.curDeltaMoveX * arg_13_0.curMoveSpeed * Time.deltaTime, arg_13_1.localPosition.y)
end

function var_0_0.checkCurIsMoveAnim(arg_14_0)
	return arg_14_0.curAnimName == var_0_1.StartRun or arg_14_0.curAnimName == var_0_1.LoopRun or arg_14_0.curAnimName == var_0_1.EndRun
end

function var_0_0.setForward(arg_15_0, arg_15_1)
	arg_15_0.guiSpine:changeLookDir(arg_15_1)
end

function var_0_0.getLookDir(arg_16_0)
	return arg_16_0.guiSpine:getLookDir()
end

function var_0_0.playJumpAnim(arg_17_0)
	arg_17_0.isJumping = true

	arg_17_0:playAnim(var_0_1.Jump)

	arg_17_0.curMoveSpeed = 0

	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_bounced)
	arg_17_0:stopLoopAudio()
end

function var_0_0.playFallAnim(arg_18_0)
	if not arg_18_0.isFalling then
		arg_18_0:playAnim(var_0_1.Fall)

		arg_18_0.isFalling = true
		arg_18_0.curDeltaMoveX = 0
		arg_18_0.curMoveSpeed = 0

		arg_18_0:stopLoopAudio()
	end
end

function var_0_0.playFallEndAnim(arg_19_0)
	if arg_19_0.isFalling then
		arg_19_0:playAnim(var_0_1.EndFall)

		arg_19_0.isFalling = false
		arg_19_0.curDeltaMoveX = 0
		arg_19_0.curMoveSpeed = 0

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_landing)
		arg_19_0:stopLoopAudio()
	end
end

function var_0_0.playStartClimbAnim(arg_20_0)
	if not arg_20_0.isClimbing then
		arg_20_0:playAnim(var_0_1.StartClimb)

		arg_20_0.isClimbing = true
		arg_20_0.curDeltaMoveX = 0
	end
end

function var_0_0.playEndClimbAnim(arg_21_0)
	if arg_21_0.isClimbing then
		arg_21_0:playAnim(var_0_1.EndClimb)

		arg_21_0.isClimbing = false
	end
end

function var_0_0.playDieAnim(arg_22_0)
	if not arg_22_0.isDying then
		arg_22_0:playAnim(var_0_1.Die)

		arg_22_0.isDying = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_spikes_death)
		arg_22_0:stopLoopAudio()
	end
end

function var_0_0.playIdleAnim(arg_23_0)
	arg_23_0:playAnim(var_0_1.Idle)

	arg_23_0.curMoveSpeed = 0
	arg_23_0.curDeltaMoveX = 0
	arg_23_0.isJumping = false
	arg_23_0.isDying = false

	if arg_23_0.playerComp then
		arg_23_0.playerComp:setIdleState()
	end
end

function var_0_0.resetData(arg_24_0)
	arg_24_0.curDeltaMoveX = arg_24_0.mapConfigData.gameConfig.playerForward
	arg_24_0.curMoveSpeed = 0
	arg_24_0.isStartMove = false
	arg_24_0.isEndMove = false
	arg_24_0.isStartPush = false
	arg_24_0.isEndPush = false
	arg_24_0.isFalling = false
	arg_24_0.isClimbing = false
	arg_24_0.isJumping = false
	arg_24_0.isDying = false
	arg_24_0.curAnimName = var_0_1.Idle

	arg_24_0:playAnim(var_0_1.Idle)
	arg_24_0:setForward(arg_24_0.curDeltaMoveX)
	FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(arg_24_0.curMoveSpeed)
	arg_24_0:stopLoopAudio()
end

function var_0_0.stopLoopAudio(arg_25_0)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_box_push_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_ladder_crawl_loop)
end

function var_0_0.onDestroy(arg_26_0)
	var_0_0.super.onDestroy(arg_26_0)
	arg_26_0:stopLoopAudio()
end

return var_0_0
