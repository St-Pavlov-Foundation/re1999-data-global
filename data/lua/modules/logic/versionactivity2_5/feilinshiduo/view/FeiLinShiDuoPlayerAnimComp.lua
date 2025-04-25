module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoPlayerAnimComp", package.seeall)

slot0 = class("FeiLinShiDuoPlayerAnimComp", BaseUnitSpawn)
slot1 = {
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
slot2 = {
	[slot1.Idle] = true,
	[slot1.LoopClimb] = true,
	[slot1.LoopPush] = true,
	[slot1.LoopRun] = true,
	[slot1.Fall] = true
}

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.trans = slot1.transform
	slot0.curAnimName = uv1.Idle
	slot0.mapConfigData = FeiLinShiDuoGameModel.instance:getMapConfigData()
	slot0.curDeltaMoveX = slot0.mapConfigData.gameConfig.playerForward
	slot0.guiSpine = GuiSpine.Create(slot1, true)

	slot0.guiSpine:setResPath(FeiLinShiDuoEnum.RoleResPath, slot0._onSpineLoaded, slot0, true)

	slot0.maxMoveSpeed = FeiLinShiDuoEnum.PlayerMoveSpeed
	slot0.maxPushSpeed = FeiLinShiDuoEnum.PlayerPushBoxSpeed
	slot0.curMoveSpeed = 0
	slot0.isStartMove = false
	slot0.isEndMove = false
	slot0.isStartPush = false
	slot0.isEndPush = false
	slot0.isFalling = false
	slot0.isClimbing = false
	slot0.isJumping = false
	slot0.isDying = false
	slot0.playerComp = MonoHelper.getLuaComFromGo(slot1, FeiLinShiDuoPlayerComp)

	FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(slot0.curMoveSpeed)
end

function slot0._onSpineLoaded(slot0)
	slot0.spineGO = slot0.guiSpine:getSpineGo()

	slot0.guiSpine:setActionEventCb(slot0.onAnimEvent, slot0)

	slot2 = UnityEngine.Object.Instantiate(slot0.guiSpine:getSkeletonGraphic().material)
	slot0.guiSpine:getSkeletonGraphic().material = slot2
	slot0.spineMaterial = slot2

	slot0:changePlayerColor(FeiLinShiDuoEnum.ColorType.None)
end

function slot0.addEventListeners(slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.changePlayerColor, slot0.changePlayerColor, slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, slot0.resetData, slot0)
end

function slot0.removeEventListeners(slot0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.changePlayerColor, slot0.changePlayerColor, slot0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, slot0.resetData, slot0)
end

function slot0.changePlayerColor(slot0, slot1)
	if slot0.spineMaterial then
		slot0.spineMaterial:SetColor(FeiLinShiDuoEnum.playerColor, GameUtil.parseColor(FeiLinShiDuoEnum.ColorStr[slot1]))
	end
end

function slot0.playAnim(slot0, slot1, slot2)
	slot0.curAnimName = slot1

	if slot0.spineGO then
		slot0.guiSpine:setBodyAnimation(slot1, uv0[slot1], slot2 or 0.1)
	end

	FeiLinShiDuoGameModel.instance:setPlayerIsIdleState(slot0.curAnimName == uv1.Idle)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.playerChangeAnim)
end

function slot0.getSpineGO(slot0)
	return slot0.spineGO
end

function slot0.onAnimEvent(slot0, slot1, slot2)
	if slot2 == SpineAnimEvent.ActionComplete then
		if (slot1 == uv0.EndRun or slot1 == uv0.EndClimb or slot1 == uv0.EndPush or slot1 == uv0.Jump or slot1 == uv0.EndFall or slot1 == uv0.Die) and not slot0.isClimbing and not slot0.isFalling then
			slot0:playAnim(uv0.Idle)

			slot0.curMoveSpeed = 0
			slot0.curDeltaMoveX = 0
			slot0.isJumping = false
			slot0.isDying = false

			if slot0.playerComp then
				if slot1 == uv0.Die then
					slot0.playerComp:playerReborn()
				end

				slot0.playerComp:setIdleState()
			end

			slot0:stopLoopAudio()
		elseif slot1 == uv0.StartRun and not slot0.isFalling and not slot0.isClimbing and not slot0.isJumping and not slot0.isDying then
			slot0:playAnim(uv0.LoopRun)

			slot0.curMoveSpeed = slot0.maxMoveSpeed

			slot0:stopLoopAudio()
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_move_loop)
		elseif slot1 == uv0.StartPush and not slot0.isFalling and not slot0.isClimbing and not slot0.isJumping and not slot0.isDying then
			slot0:playAnim(uv0.LoopPush)

			slot0.curMoveSpeed = slot0.maxPushSpeed

			slot0:stopLoopAudio()
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_box_push_loop)
		elseif slot1 == uv0.StartClimb and not slot0.isFalling and not slot0.isJumping and not slot0.isDying then
			slot0:playAnim(uv0.LoopClimb)

			slot0.curMoveSpeed = FeiLinShiDuoEnum.climbSpeed

			slot0:stopLoopAudio()
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_ladder_crawl_loop)
		end

		slot0.isStartMove = false
		slot0.isEndMove = false
		slot0.isStartPush = false
		slot0.isEndPush = false

		FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(slot0.curMoveSpeed)
	end
end

function slot0.setMoveAnim(slot0, slot1, slot2)
	slot0.playerCanMove = slot0.playerComp:checkPlayerCanMove()
	slot0.isFalling = false
	slot0.isClimbing = false
	slot0.isTouchBox = slot0:checkIsTouchBox(slot2)

	if slot0.isTouchBox then
		slot0:pushBoxMove(slot1)
	else
		slot0:normalMove(slot1)
	end

	FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(slot0.curMoveSpeed)

	return slot0.curDeltaMoveX
end

function slot0.checkIsTouchBox(slot0, slot1)
	if #slot1 > 0 then
		for slot5, slot6 in pairs(slot1) do
			if slot6.type == FeiLinShiDuoEnum.ObjectType.Box then
				return true
			end
		end
	end

	return false
end

function slot0.normalMove(slot0, slot1)
	if slot1 ~= 0 and slot0.curMoveSpeed == 0 and not slot0.isStartMove and not slot0.isEndMove and slot0.playerCanMove then
		slot0.curDeltaMoveX = slot1

		slot0:playAnim(uv0.StartRun)

		slot0.isStartMove = true
		slot0.isEndMove = false
		slot0.curMoveSpeed = slot0.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed
	elseif slot0.isStartMove and slot0.playerCanMove then
		slot0.curMoveSpeed = math.max(slot0.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed, slot0.maxMoveSpeed)
	elseif ((slot1 == 0 or slot0.curDeltaMoveX == -slot1) and slot0.curDeltaMoveX ~= 0 and slot0.curMoveSpeed > 0 or slot0.curAnimName == uv0.LoopPush or not slot0.playerCanMove) and not slot0.isEndMove and slot0.curAnimName ~= uv0.Idle then
		slot0.curMoveSpeed = math.min(slot0.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)

		slot0:playAnim(uv0.EndRun)

		slot0.isEndMove = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	elseif slot0.isEndMove then
		slot0.curMoveSpeed = math.min(slot0.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)
	end
end

function slot0.pushBoxMove(slot0, slot1)
	if slot1 ~= 0 and not slot0.isStartPush and not slot0.isEndMove and slot0.curAnimName == uv0.Idle and slot0.playerCanMove then
		slot0.curDeltaMoveX = slot1

		slot0:playAnim(uv0.StartPush)

		slot0.isStartPush = true
		slot0.isEndPush = false
		slot0.curMoveSpeed = slot0.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed
	elseif not slot0:checkCurIsMoveAnim() and slot0.isStartPush and slot0.playerCanMove then
		slot0.curMoveSpeed = math.max(slot0.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed, slot0.maxPushSpeed)
	elseif slot0:checkCurIsMoveAnim() and not slot0.isEndPush then
		slot0.curMoveSpeed = math.min(slot0.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)

		slot0:playAnim(uv0.EndRun)

		slot0.isEndPush = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	elseif not slot0:checkCurIsMoveAnim() and slot1 == 0 and slot0.curDeltaMoveX ~= 0 then
		slot0.curMoveSpeed = 0
	elseif not slot0:checkCurIsMoveAnim() and slot1 ~= 0 and slot0.curAnimName == uv0.LoopPush and slot1 == slot0.curDeltaMoveX and slot0.playerCanMove then
		slot0.curMoveSpeed = math.max(slot0.curMoveSpeed + FeiLinShiDuoEnum.startMoveAddSpeed, slot0.maxPushSpeed)
	elseif not slot0:checkCurIsMoveAnim() and (slot1 == -slot0.curDeltaMoveX and slot1 ~= 0 or not slot0.playerCanMove) and not slot0.isEndPush and slot0.curAnimName ~= uv0.EndPush and slot0.curAnimName ~= uv0.Idle then
		slot0.curMoveSpeed = math.min(slot0.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)

		slot0:playAnim(uv0.EndPush)

		slot0.isEndPush = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_box_push_loop)
	elseif slot0.isEndPush then
		slot0.curMoveSpeed = math.min(slot0.curMoveSpeed - FeiLinShiDuoEnum.endMoveAddSpeed, 0)
	end
end

function slot0.setPlayerMove(slot0, slot1)
	if slot0.curDeltaMoveX ~= 0 then
		slot0:setForward(slot0.curDeltaMoveX)
	end

	transformhelper.setLocalPosXY(slot1, slot1.localPosition.x + slot0.curDeltaMoveX * slot0.curMoveSpeed * Time.deltaTime, slot1.localPosition.y)
end

function slot0.checkCurIsMoveAnim(slot0)
	return slot0.curAnimName == uv0.StartRun or slot0.curAnimName == uv0.LoopRun or slot0.curAnimName == uv0.EndRun
end

function slot0.setForward(slot0, slot1)
	slot0.guiSpine:changeLookDir(slot1)
end

function slot0.getLookDir(slot0)
	return slot0.guiSpine:getLookDir()
end

function slot0.playJumpAnim(slot0)
	slot0.isJumping = true

	slot0:playAnim(uv0.Jump)

	slot0.curMoveSpeed = 0

	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_bounced)
	slot0:stopLoopAudio()
end

function slot0.playFallAnim(slot0)
	if not slot0.isFalling then
		slot0:playAnim(uv0.Fall)

		slot0.isFalling = true
		slot0.curDeltaMoveX = 0
		slot0.curMoveSpeed = 0

		slot0:stopLoopAudio()
	end
end

function slot0.playFallEndAnim(slot0)
	if slot0.isFalling then
		slot0:playAnim(uv0.EndFall)

		slot0.isFalling = false
		slot0.curDeltaMoveX = 0
		slot0.curMoveSpeed = 0

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_landing)
		slot0:stopLoopAudio()
	end
end

function slot0.playStartClimbAnim(slot0)
	if not slot0.isClimbing then
		slot0:playAnim(uv0.StartClimb)

		slot0.isClimbing = true
		slot0.curDeltaMoveX = 0
	end
end

function slot0.playEndClimbAnim(slot0)
	if slot0.isClimbing then
		slot0:playAnim(uv0.EndClimb)

		slot0.isClimbing = false
	end
end

function slot0.playDieAnim(slot0)
	if not slot0.isDying then
		slot0:playAnim(uv0.Die)

		slot0.isDying = true

		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_spikes_death)
		slot0:stopLoopAudio()
	end
end

function slot0.playIdleAnim(slot0)
	slot0:playAnim(uv0.Idle)

	slot0.curMoveSpeed = 0
	slot0.curDeltaMoveX = 0
	slot0.isJumping = false
	slot0.isDying = false

	if slot0.playerComp then
		slot0.playerComp:setIdleState()
	end
end

function slot0.resetData(slot0)
	slot0.curDeltaMoveX = slot0.mapConfigData.gameConfig.playerForward
	slot0.curMoveSpeed = 0
	slot0.isStartMove = false
	slot0.isEndMove = false
	slot0.isStartPush = false
	slot0.isEndPush = false
	slot0.isFalling = false
	slot0.isClimbing = false
	slot0.isJumping = false
	slot0.isDying = false
	slot0.curAnimName = uv0.Idle

	slot0:playAnim(uv0.Idle)
	slot0:setForward(slot0.curDeltaMoveX)
	FeiLinShiDuoGameModel.instance:setCurPlayerMoveSpeed(slot0.curMoveSpeed)
	slot0:stopLoopAudio()
end

function slot0.stopLoopAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_box_push_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_ladder_crawl_loop)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
	slot0:stopLoopAudio()
end

return slot0
