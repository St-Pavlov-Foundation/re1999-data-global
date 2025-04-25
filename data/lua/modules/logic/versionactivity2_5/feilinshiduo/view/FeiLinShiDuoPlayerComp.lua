module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoPlayerComp", package.seeall)

slot0 = class("FeiLinShiDuoPlayerComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.playerGO = slot1
	slot0.playerTrans = slot0.playerGO.transform
	slot0.isGround = true
	slot0.fallAddSpeed = FeiLinShiDuoEnum.FallSpeed
	slot0.fallYSpeed = 0
	slot0.isTouchElementList = {}
	slot0.fixFallDeltaMoveX = 0
	slot0.hasFixFallPos = false
	slot0.isJumping = false
	slot0.isClimbing = false
	slot0.startClimbing = false
	slot0.curStairsItem = nil
	slot0.isFalling = false
	slot0.isDying = false
	slot0.curStandWallItem = nil
	slot0.deltaMoveX = 0
	slot0.tempClickDeltaMoveX = 0
	slot0.curCheckPosIndex = 1
	slot0.canShowOption = false
end

function slot0.setScene(slot0, slot1, slot2)
	slot0.sceneGO = slot1
	slot0.sceneTrans = slot0.sceneGO.transform
	slot0.sceneViewCls = slot2
	slot0.playerAnimComp = slot2:getPlayerAnimComp()
	slot0.gameUIView = slot2:getGameUIView()
	slot0.curGuideCheckData = slot0.sceneViewCls:getCurGuideCheckData()
end

function slot0.addEventListeners(slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, slot0.resetData, slot0)
end

function slot0.removeEventListeners(slot0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, slot0.resetData, slot0)
end

function slot0.resetData(slot0)
	slot0:killTween()

	slot0.isGround = true
	slot0.fallYSpeed = 0
	slot0.isTouchElementList = {}
	slot0.fixFallDeltaMoveX = 0
	slot0.hasFixFallPos = false
	slot0.isJumping = false
	slot0.isClimbing = false
	slot0.startClimbing = false
	slot0.curStairsItem = nil
	slot0.isFalling = false
	slot0.isDying = false
	slot0.curStandWallItem = nil
	slot0.isInTarget = false
	slot0.tempClickDeltaMoveX = 0
	slot0.canShowOption = false
end

function slot0.setUIClickRightDown(slot0)
	slot0.clickRightDown = true
end

function slot0.setUIClickRightUp(slot0)
	slot0.clickRightDown = false
end

function slot0.setUIClickLeftDown(slot0)
	slot0.clickLeftDown = true
end

function slot0.setUIClickLeftUp(slot0)
	slot0.clickLeftDown = false
end

function slot0.onTick(slot0)
	slot0:checkBoxHitPlayer()
	slot0:checkPlayerFall()

	if slot0:playerMove() then
		slot0:handleEvent()
	end

	slot0:checkPlayerInGuidePos()
end

function slot0.playerMove(slot0)
	if not slot0.playerTrans or not slot0.playerAnimComp or slot0:checkPlayerIsInElement() or slot0.isInTarget then
		return false
	end

	slot1 = ViewMgr.instance:isOpen(ViewName.GuideView)
	slot0.deltaMoveX = 0

	if slot0.isGround and (UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) or slot0.clickLeftDown) then
		slot0.deltaMoveX = -1
	elseif slot0.isGround and (UnityEngine.Input.GetKey(UnityEngine.KeyCode.RightArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) or slot0.clickRightDown) then
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.OnClickGuideRightMoveBtn)

		slot0.deltaMoveX = 1
	elseif slot0.isGround and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Space) and slot0.canShowOption and not slot1 then
		slot0:startClimbStairs()
	end

	if slot0.tempClickDeltaMoveX ~= slot0.deltaMoveX then
		slot0.tempClickDeltaMoveX = slot0.deltaMoveX

		if slot0.tempClickDeltaMoveX > 0 then
			slot0.gameUIView:rightClickUp()
			slot0.gameUIView:rightClickDown()
		elseif slot0.tempClickDeltaMoveX < 0 then
			slot0.gameUIView:leftClickUp()
			slot0.gameUIView:leftClickDown()
		else
			slot0.gameUIView:leftClickUp()
			slot0.gameUIView:rightClickUp()
		end
	end

	if slot1 then
		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper) and slot0.deltaMoveX == -1 then
			slot0.deltaMoveX = 0
		elseif not slot2 then
			slot0.deltaMoveX = 0
		end
	end

	if UIBlockMgr.instance:isBlock() or ZProj.TouchEventMgr.Fobidden then
		slot0.deltaMoveX = 0
	end

	if slot0.deltaMoveX ~= 0 and slot0:checkPlayerInNoneColorElement(slot0.playerTrans.localPosition.x, slot0.playerTrans.localPosition.y) and not slot0.isDying then
		GameFacade.showToast(ToastEnum.Act185TrapTip)

		return false
	end

	slot0.isTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(slot0.playerTrans.localPosition.x + slot0.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth / 2 + 1), slot0.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2)

	if not slot0:checkPlayerInState() then
		slot0.deltaMoveX = slot0.playerAnimComp:setMoveAnim(slot0.deltaMoveX, slot0.isTouchElementList)
	end

	if slot0.sceneTrans then
		slot3, slot4 = slot0.sceneViewCls:fixSceneBorder(-slot0.playerTrans.localPosition.x, -slot0.playerTrans.localPosition.y)
		slot0.sceneTrans.localPosition = Vector3.Lerp(slot0.sceneTrans.localPosition, Vector3(slot3, slot4, slot0.sceneTrans.localPosition.z), FeiLinShiDuoEnum.SceneMoveSpeed)
	end

	slot0.fixFallDeltaMoveX = slot0.deltaMoveX ~= 0 and slot0.deltaMoveX or slot0.fixFallDeltaMoveX

	if slot0.deltaMoveX ~= 0 and not slot0:checkPlayerInState() and not slot0:checkForwardCanMove(slot0.playerTrans.localPosition.x + slot0.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth / 2 + 1), slot0.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2, slot0.deltaMoveX) then
		slot0.playerAnimComp:setForward(slot0.deltaMoveX)

		return false
	end

	if slot0.jumpForwardElementList and #slot0.jumpForwardElementList == 0 and not slot0:checkPlayerInState() then
		slot0.playerAnimComp:setPlayerMove(slot0.playerTrans)
	end

	return true
end

function slot0.handleEvent(slot0)
	if not slot0.sceneViewCls then
		return
	end

	slot0:playerTouchElement()
	slot0:checkClimbStairs()
	slot0:checkPlayerDropFromStairs()
end

function slot0.checkPlayerFall(slot0, slot1)
	if (slot0.isGround or slot0.deltaMoveX == 0 and not slot0.isGround) and not slot0.isJumping and not slot0.isClimbing or slot1 then
		slot2 = {
			FeiLinShiDuoEnum.ObjectType.Jump,
			FeiLinShiDuoEnum.ObjectType.Option,
			FeiLinShiDuoEnum.ObjectType.Start
		}

		if #FeiLinShiDuoGameModel.instance:checkTouchElement(slot0.playerTrans.localPosition.x - slot0.deltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 4, slot0.playerTrans.localPosition.y - 2, slot2, nil, true) == 0 and #FeiLinShiDuoGameModel.instance:checkTouchElement(slot0.playerTrans.localPosition.x + slot0.deltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 4, slot0.playerTrans.localPosition.y - 2, slot2, nil, true) == 0 and not slot0:checkPlayerIsInElement() then
			if not slot0.hasFixFallPos then
				if slot0.jumpForwardElementList and #slot0.jumpForwardElementList > 0 then
					transformhelper.setLocalPosXY(slot0.playerTrans, slot0.playerTrans.localPosition.x, slot0.playerTrans.localPosition.y - slot0.fallYSpeed * Time.deltaTime)
				else
					transformhelper.setLocalPosXY(slot0.playerTrans, slot1 and slot0.playerTrans.localPosition.x or slot0.playerTrans.localPosition.x + slot0.fixFallDeltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 4, slot0.playerTrans.localPosition.y - slot0.fallYSpeed * Time.deltaTime)
				end

				slot0.hasFixFallPos = true
			else
				transformhelper.setLocalPosXY(slot0.playerTrans, slot0.playerTrans.localPosition.x, slot0.playerTrans.localPosition.y - slot0.fallYSpeed * Time.deltaTime)
			end

			slot0.isGround = false
			slot0.fallYSpeed = slot0.fallYSpeed + slot0.fallAddSpeed

			slot0.playerAnimComp:playFallAnim()

			slot0.isFalling = true
		else
			if not slot0.isGround then
				slot0.playerTrans.localPosition = slot0:fixStandPos(slot3)

				slot0.playerAnimComp:playFallEndAnim()
			end

			slot0:setCurStandWall(slot3, slot0.deltaMoveX)

			slot0.isGround = true
			slot0.fallYSpeed = 0
			slot0.hasFixFallPos = false
			slot0.jumpForwardElementList = {}
			slot0.isFalling = false
		end
	end
end

function slot0.fixStandPos(slot0, slot1)
	slot2, slot3 = FeiLinShiDuoGameModel.instance:getFixStandePos(slot1, slot0.playerTrans.localPosition.x, slot0.playerTrans.localPosition.y)

	if slot2 and slot3 then
		return Vector3(slot0.playerTrans.localPosition.x, slot3.y, 0)
	end

	return slot0.playerTrans.localPosition
end

function slot0.setCurStandWall(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot6.type == FeiLinShiDuoEnum.ObjectType.Wall then
			slot0.curStandWallItem = slot6

			break
		end
	end
end

function slot0.playerTouchElement(slot0)
	if slot0.isGround then
		slot0.isTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(slot0.playerTrans.localPosition.x + slot0.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth / 2 + 1), slot0.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2)

		if #slot0.isTouchElementList > 0 then
			for slot4, slot5 in pairs(slot0.isTouchElementList) do
				if slot5.type == FeiLinShiDuoEnum.ObjectType.Box and not slot0:checkPlayerInState() and slot0.deltaMoveX ~= 0 then
					slot0.sceneViewCls:getBoxComp(slot5.id):setMove(slot0.playerTrans, slot0.deltaMoveX)
				end

				if slot5.type == FeiLinShiDuoEnum.ObjectType.Jump and slot0.deltaMoveX ~= 0 and Mathf.Abs(slot5.pos[1] + slot5.width / 2 - slot0.playerTrans.localPosition.x) <= FeiLinShiDuoEnum.touchElementRange then
					slot0.isGround = false
					slot0.isJumping = true
					slot0.isFalling = true
					slot0.jumpStartPos = Vector3(slot5.pos[1] + slot5.width / 2, slot5.pos[2], 0)
					slot0.jumpTargetPos = Vector3(slot5.pos[1] + slot5.width / 2 + slot0.playerAnimComp:getLookDir() * 2 * FeiLinShiDuoEnum.SlotWidth, slot5.pos[2], 0)

					slot0.playerAnimComp:playJumpAnim()

					slot0.jumpForwardElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(slot0.jumpTargetPos.x, slot5.pos[2] + FeiLinShiDuoEnum.HalfSlotWidth, {
						FeiLinShiDuoEnum.ObjectType.Stairs,
						FeiLinShiDuoEnum.ObjectType.Start
					}) or {}
					slot10 = slot5.pos[2] + FeiLinShiDuoEnum.SlotWidth
					slot0.jumpTargetPos = #slot0.jumpForwardElementList > 0 and Vector3(slot5.pos[1] + slot5.width / 2 + slot6 * FeiLinShiDuoEnum.SlotWidth, slot10, 0) or slot0.jumpTargetPos
					slot0.jumpTweenX = ZProj.TweenHelper.DOAnchorPosX(slot0.playerTrans, slot0.jumpTargetPos.x, #slot0.jumpForwardElementList > 0 and FeiLinShiDuoEnum.jumpAnimTime / 2 or FeiLinShiDuoEnum.jumpAnimTime)
					slot0.jumpTweenY = ZProj.TweenHelper.DOAnchorPosY(slot0.playerTrans, slot10, FeiLinShiDuoEnum.jumpAnimTime / 2, slot0.doJumpHalfXFinish, slot0, nil, EaseType.OutCubic)

					if slot0.sceneViewCls:getJumpAnim(slot5) then
						slot12.enabled = true

						slot12:Play("active", 0, 0)
					end
				end

				if slot5.type == FeiLinShiDuoEnum.ObjectType.Target and slot0.deltaMoveX ~= 0 and not slot0.isInTarget and Mathf.Abs(slot5.pos[1] + slot5.width / 2 - slot0.playerTrans.localPosition.x) <= FeiLinShiDuoEnum.touchElementRange then
					slot6 = FeiLinShiDuoGameModel.instance:getCurGameConfig()

					Activity185Rpc.instance:sendAct185FinishEpisodeRequest(slot6.activityId, slot6.episodeId, slot0.openGameResultView, slot0)

					slot0.isInTarget = true

					slot0.playerAnimComp:playIdleAnim()
					FeiLinShiDuoStatHelper.instance:sendMapFinish(slot0.playerGO)
				end
			end
		end

		slot0.isTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(slot0.playerTrans.localPosition.x, slot0.playerTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth / 2)

		if #slot0.isTouchElementList > 0 then
			for slot4, slot5 in pairs(slot0.isTouchElementList) do
				if slot5.type == FeiLinShiDuoEnum.ObjectType.Trap then
					slot0.playerAnimComp:playDieAnim()

					if not slot0.isDying then
						slot0.gameUIView:showDeadEffect()
					end

					slot0.isDying = true

					break
				end
			end
		end
	end
end

function slot0.openGameResultView(slot0)
	FeiLinShiDuoGameController.instance:openGameResultView({
		isSuccess = true
	})
end

function slot0.doJumpHalfXFinish(slot0)
	if slot0.jumpForwardElementList and #slot0.jumpForwardElementList > 0 then
		slot0:doJumpFinish()
	else
		slot0.jumpTweenY2 = ZProj.TweenHelper.DOAnchorPosY(slot0.playerTrans, slot0.jumpTargetPos.y, FeiLinShiDuoEnum.jumpAnimTime / 2, slot0.doJumpFinish, slot0, nil, EaseType.InCubic)
	end
end

function slot0.doJumpFinish(slot0)
	if slot0.jumpForwardElementList and #slot0.jumpForwardElementList > 0 then
		slot0.isJumping = false
	end

	slot0.playerTrans.localPosition = slot0.jumpTargetPos
	slot0.jumpForwardElementList = {}

	slot0:killTween()
end

function slot0.startClimbStairs(slot0)
	if slot0:checkPlayerInState() then
		return
	end

	slot0.isClimbing = true
	slot0.startClimbing = true

	if not slot0:checkStairsCanClimb() then
		GameFacade.showToast(ToastEnum.Act185ClimbTip)

		slot0.isClimbing = false
		slot0.startClimbing = false

		slot0.gameUIView:showOptionCanDoState(false)

		return
	end

	if slot0.isTopStairs then
		transformhelper.setLocalPosXY(slot0.playerTrans, slot0.curStairsItem.pos[1] + slot0.curStairsItem.width / 2, slot0.curStairsItem.pos[2] + slot0.curStairsItem.height - FeiLinShiDuoEnum.HalfSlotWidth)
	end
end

function slot0.checkStairsCanClimb(slot0)
	return #FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(slot0.curStairsItem.pos[1], slot0.curStairsItem.pos[2], slot0.curStairsItem, FeiLinShiDuoEnum.checkDir.Top) == 0 and #FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(slot0.curStairsItem.pos[1], slot0.curStairsItem.pos[2] + FeiLinShiDuoEnum.HalfSlotWidth, slot0.curStairsItem, FeiLinShiDuoEnum.checkDir.Bottom, slot0.sceneViewCls:getAllBoxCompList()) == 0
end

function slot0.checkClimbStairs(slot0)
	if slot0.isGround and not slot0.isClimbing then
		slot6 = FeiLinShiDuoEnum.HalfSlotWidth / 4
		slot2 = FeiLinShiDuoGameModel.instance:checkTouchElement(slot0.playerTrans.localPosition.x, slot0.playerTrans.localPosition.y - slot6)
		slot0.curStairsItem = nil

		for slot6, slot7 in pairs(FeiLinShiDuoGameModel.instance:checkTouchElement(slot0.playerTrans.localPosition.x, slot0.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 4)) do
			if slot7.type == FeiLinShiDuoEnum.ObjectType.Stairs then
				slot0.curStairsItem = slot7
				slot0.isTopStairs = false

				break
			end
		end

		for slot6, slot7 in pairs(slot2) do
			if slot7.type == FeiLinShiDuoEnum.ObjectType.Stairs then
				slot0.curStairsItem = slot7
				slot0.isTopStairs = true

				break
			end
		end

		if slot0.curStairsItem and FeiLinShiDuoEnum.stairsTouchCheckRange < Mathf.Abs(slot0.curStairsItem.pos[1] + slot0.curStairsItem.width / 2 - slot0.playerTrans.localPosition.x) then
			slot0.curStairsItem = nil
		end

		slot0.gameUIView:showOptionState(slot0.curStairsItem ~= nil)

		slot0.canShowOption = slot0.curStairsItem ~= nil

		if slot0.curStairsItem then
			slot0.gameUIView:showOptionCanDoState(slot0:checkStairsCanClimb())
		end
	elseif slot0.isClimbing and slot0.startClimbing then
		slot0.gameUIView:showOptionState(false)

		slot0.canShowOption = false

		slot0.playerAnimComp:playStartClimbAnim()

		if slot0.isTopStairs then
			transformhelper.setLocalPosXY(slot0.playerTrans, slot0.curStairsItem.pos[1] + slot0.curStairsItem.width / 2, slot0.playerTrans.localPosition.y - FeiLinShiDuoEnum.climbSpeed * Time.deltaTime)

			if Mathf.Abs(slot0.curStairsItem.pos[2] - slot0.playerTrans.localPosition.y) <= FeiLinShiDuoEnum.HalfSlotWidth / 3 then
				transformhelper.setLocalPosXY(slot0.playerTrans, slot0.curStairsItem.pos[1] + slot0.curStairsItem.width / 2, slot0.curStairsItem.pos[2])
				slot0.playerAnimComp:playEndClimbAnim()

				slot0.isTopStairs = false
				slot0.startClimbing = false
			end
		else
			transformhelper.setLocalPosXY(slot0.playerTrans, slot0.curStairsItem.pos[1] + slot0.curStairsItem.width / 2, slot0.playerTrans.localPosition.y + FeiLinShiDuoEnum.climbSpeed * Time.deltaTime)

			if Mathf.Abs(slot0.curStairsItem.pos[2] + slot0.curStairsItem.height - slot0.playerTrans.localPosition.y) <= FeiLinShiDuoEnum.HalfSlotWidth then
				transformhelper.setLocalPosXY(slot0.playerTrans, slot0.curStairsItem.pos[1] + slot0.curStairsItem.width / 2, slot0.curStairsItem.pos[2] + slot0.curStairsItem.height)
				slot0.playerAnimComp:playEndClimbAnim()

				slot0.isTopStairs = true
				slot0.startClimbing = false
			end
		end
	end
end

function slot0.checkPlayerDropFromStairs(slot0)
	if not slot0.isClimbing and not slot0.startClimbing and slot0.curStairsItem and slot0.playerTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth / 4 < slot0.curStairsItem.pos[2] then
		slot0:checkPlayerFall(true)
	end
end

function slot0.checkBoxHitPlayer(slot0)
	for slot5, slot6 in pairs(slot0.sceneViewCls:getAllBoxComp()) do
		if slot6.isGround == false and not slot0.isDying and slot6.itemInfo.pos[1] <= slot0.playerTrans.localPosition.x and slot0.playerTrans.localPosition.x <= slot6.itemInfo.pos[1] + slot6.itemInfo.width and slot0.playerTrans.localPosition.y < slot6.itemInfo.pos[2] and Mathf.Abs(slot6.itemInfo.pos[2] - slot0.playerTrans.localPosition.y) <= FeiLinShiDuoEnum.HalfSlotWidth then
			slot0.curHitBoxComp = slot6

			slot0.playerAnimComp:playDieAnim()

			if not slot0.isDying then
				slot0.gameUIView:showDeadEffect()
			end

			slot0.isDying = true

			break
		end
	end

	if slot0.curHitBoxComp and not slot0.isDying then
		slot0:playerReborn()

		slot0.curHitBoxComp = nil
	end
end

function slot0.playerReborn(slot0)
	if slot0.curHitBoxComp then
		if slot0:checkPlayerInNoneColorElement(slot0.playerAnimComp:getLookDir() > 0 and slot0.curHitBoxComp.itemInfo.pos[1] - FeiLinShiDuoEnum.HalfSlotWidth or slot0.curHitBoxComp.itemInfo.pos[1] + slot0.curHitBoxComp.itemInfo.width + FeiLinShiDuoEnum.HalfSlotWidth, slot0.playerTrans.localPosition.y) and slot1 > 0 then
			slot4 = slot3
		elseif slot0:checkPlayerInNoneColorElement(slot4, slot0.playerTrans.localPosition.y) and slot1 < 0 then
			slot4 = slot2
		end

		transformhelper.setLocalPosXY(slot0.playerTrans, slot4, slot0.playerTrans.localPosition.y)
	elseif slot0.curStandWallItem then
		transformhelper.setLocalPosXY(slot0.playerTrans, Mathf.Abs(slot0.playerTrans.localPosition.x - slot0.curStandWallItem.pos[1]) < Mathf.Abs(slot0.playerTrans.localPosition.x - (slot0.curStandWallItem.pos[1] + slot0.curStandWallItem.width)) and slot0.curStandWallItem.pos[1] + FeiLinShiDuoEnum.HalfSlotWidth or slot0.curStandWallItem.pos[1] + slot0.curStandWallItem.width - FeiLinShiDuoEnum.HalfSlotWidth, slot0.curStandWallItem.pos[2] + slot0.curStandWallItem.height)
	end

	UIBlockHelper.instance:startBlock("FeiLinShiDuoPlayerComp_playerReborn", 0.4, ViewName.FeiLinShiDuoGameView)
	slot0.gameUIView:_onLeftClickUp()
	slot0.gameUIView:_onRightClickUp()
end

function slot0.checkForwardCanMove(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0:checkPlayerCanMove() then
		return false
	end

	return FeiLinShiDuoGameModel.instance:checkForwardCanMove(slot1, slot2, slot3, slot4, slot5)
end

function slot0.checkPlayerCanMove(slot0)
	for slot5, slot6 in pairs(slot0.sceneViewCls:getAllBoxComp()) do
		if slot6:getShowState() and slot6.isGround == false then
			return false
		end
	end

	if slot0:checkPlayerIsInElement() or slot0.isInTarget then
		return false
	end

	return true
end

function slot0.checkPlayerIsInElement(slot0)
	if not FeiLinShiDuoGameModel.instance:getElementMap() then
		return false
	end

	slot3 = slot1[FeiLinShiDuoEnum.ObjectType.Box] or {}
	slot5 = slot1[FeiLinShiDuoEnum.ObjectType.Door] or {}

	for slot9, slot10 in pairs(slot1[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}) do
		table.insert({}, slot10)
	end

	for slot9, slot10 in pairs(slot3) do
		table.insert(slot2, slot10)
	end

	return #FeiLinShiDuoGameModel.instance:checkTouchElement(slot0.playerTrans.localPosition.x, slot0.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 4, {}, slot2) > 0
end

function slot0.checkPlayerInNoneColorElement(slot0, slot1, slot2)
	if not FeiLinShiDuoGameModel.instance:getElementMap() then
		return false
	end

	slot5 = slot3[FeiLinShiDuoEnum.ObjectType.Box] or {}
	slot7 = slot3[FeiLinShiDuoEnum.ObjectType.Wall] or {}

	for slot11, slot12 in pairs(slot3[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}) do
		if slot12.color == FeiLinShiDuoEnum.ColorType.None then
			table.insert({}, slot12)
		end
	end

	for slot11, slot12 in pairs(slot5) do
		if slot12.color == FeiLinShiDuoEnum.ColorType.None then
			table.insert(slot4, slot12)
		end
	end

	for slot11, slot12 in pairs(slot7) do
		table.insert(slot4, slot12)
	end

	return #FeiLinShiDuoGameModel.instance:checkTouchElement(slot1, slot2 + FeiLinShiDuoEnum.HalfSlotWidth / 2, {}, slot4) > 0
end

function slot0.checkPlayerInGuidePos(slot0)
	if slot0.curGuideCheckData and #slot0.curGuideCheckData.guideList > 0 and slot0.curCheckPosIndex <= #slot0.curGuideCheckData.guideList then
		if not slot0.curGuideCheckData.guideList[slot0.curCheckPosIndex] then
			return
		end

		if slot1.posX <= slot0.playerTrans.localPosition.x and slot0.playerTrans.localPosition.x <= slot1.posX + slot1.rangeX and slot1.posY <= slot0.playerTrans.localPosition.y and slot0.playerTrans.localPosition.y <= slot1.posY + slot1.rangeY then
			FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.PlayerInGuideCheckPos, slot1.id)

			slot0.curCheckPosIndex = slot0.curCheckPosIndex + 1
		end
	end
end

function slot0.checkPlayerInState(slot0)
	return slot0.isClimbing or slot0.isFalling or slot0.isDying or slot0.isJumping
end

function slot0.setIdleState(slot0)
	slot0.isClimbing = false
	slot0.isFalling = false
	slot0.isDying = false
	slot0.isJumping = false
end

function slot0.killTween(slot0)
	if slot0.jumpTweenX then
		ZProj.TweenHelper.KillById(slot0.jumpTweenX)
	end

	if slot0.jumpTweenY then
		ZProj.TweenHelper.KillById(slot0.jumpTweenY)
	end

	if slot0.jumpTweenY2 then
		ZProj.TweenHelper.KillById(slot0.jumpTweenY2)
	end
end

function slot0.onDestroy(slot0)
	slot0:killTween()
end

return slot0
