module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoPlayerComp", package.seeall)

local var_0_0 = class("FeiLinShiDuoPlayerComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.playerGO = arg_1_1
	arg_1_0.playerTrans = arg_1_0.playerGO.transform
	arg_1_0.isGround = true
	arg_1_0.fallAddSpeed = FeiLinShiDuoEnum.FallSpeed
	arg_1_0.fallYSpeed = 0
	arg_1_0.isTouchElementList = {}
	arg_1_0.fixFallDeltaMoveX = 0
	arg_1_0.hasFixFallPos = false
	arg_1_0.isJumping = false
	arg_1_0.isClimbing = false
	arg_1_0.startClimbing = false
	arg_1_0.curStairsItem = nil
	arg_1_0.isFalling = false
	arg_1_0.isDying = false
	arg_1_0.curStandWallItem = nil
	arg_1_0.deltaMoveX = 0
	arg_1_0.tempClickDeltaMoveX = 0
	arg_1_0.curCheckPosIndex = 1
	arg_1_0.canShowOption = false
end

function var_0_0.setScene(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.sceneGO = arg_2_1
	arg_2_0.sceneTrans = arg_2_0.sceneGO.transform
	arg_2_0.sceneViewCls = arg_2_2
	arg_2_0.playerAnimComp = arg_2_2:getPlayerAnimComp()
	arg_2_0.gameUIView = arg_2_2:getGameUIView()
	arg_2_0.curGuideCheckData = arg_2_0.sceneViewCls:getCurGuideCheckData()
end

function var_0_0.addEventListeners(arg_3_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, arg_3_0.resetData, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, arg_4_0.resetData, arg_4_0)
end

function var_0_0.resetData(arg_5_0)
	arg_5_0:killTween()

	arg_5_0.isGround = true
	arg_5_0.fallYSpeed = 0
	arg_5_0.isTouchElementList = {}
	arg_5_0.fixFallDeltaMoveX = 0
	arg_5_0.hasFixFallPos = false
	arg_5_0.isJumping = false
	arg_5_0.isClimbing = false
	arg_5_0.startClimbing = false
	arg_5_0.curStairsItem = nil
	arg_5_0.isFalling = false
	arg_5_0.isDying = false
	arg_5_0.curStandWallItem = nil
	arg_5_0.isInTarget = false
	arg_5_0.tempClickDeltaMoveX = 0
	arg_5_0.canShowOption = false
end

function var_0_0.setUIClickRightDown(arg_6_0)
	arg_6_0.clickRightDown = true
end

function var_0_0.setUIClickRightUp(arg_7_0)
	arg_7_0.clickRightDown = false
end

function var_0_0.setUIClickLeftDown(arg_8_0)
	arg_8_0.clickLeftDown = true
end

function var_0_0.setUIClickLeftUp(arg_9_0)
	arg_9_0.clickLeftDown = false
end

function var_0_0.onTick(arg_10_0)
	arg_10_0:checkBoxHitPlayer()

	local var_10_0 = arg_10_0:playerMove()

	arg_10_0:checkPlayerFall()

	if var_10_0 then
		arg_10_0:handleEvent()
	end

	arg_10_0:checkPlayerInGuidePos()
end

function var_0_0.playerMove(arg_11_0)
	if not arg_11_0.playerTrans or not arg_11_0.playerAnimComp or arg_11_0:checkPlayerIsInElement() or arg_11_0.isInTarget then
		return false
	end

	local var_11_0 = ViewMgr.instance:isOpen(ViewName.GuideView)

	arg_11_0.deltaMoveX = 0

	if arg_11_0.isGround and (UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) or arg_11_0.clickLeftDown) then
		arg_11_0.deltaMoveX = -1
	elseif arg_11_0.isGround and (UnityEngine.Input.GetKey(UnityEngine.KeyCode.RightArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) or arg_11_0.clickRightDown) then
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.OnClickGuideRightMoveBtn)

		arg_11_0.deltaMoveX = 1
	elseif arg_11_0.isGround and UnityEngine.Input.GetKey(UnityEngine.KeyCode.Space) and arg_11_0.canShowOption and not var_11_0 then
		arg_11_0:startClimbStairs()
	end

	if arg_11_0.tempClickDeltaMoveX ~= arg_11_0.deltaMoveX then
		arg_11_0.tempClickDeltaMoveX = arg_11_0.deltaMoveX

		if arg_11_0.tempClickDeltaMoveX > 0 then
			arg_11_0.gameUIView:rightClickUp()
			arg_11_0.gameUIView:rightClickDown()
		elseif arg_11_0.tempClickDeltaMoveX < 0 then
			arg_11_0.gameUIView:leftClickUp()
			arg_11_0.gameUIView:leftClickDown()
		else
			arg_11_0.gameUIView:leftClickUp()
			arg_11_0.gameUIView:rightClickUp()
		end
	end

	local var_11_1 = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper)

	if var_11_0 then
		if var_11_1 and arg_11_0.deltaMoveX == -1 then
			arg_11_0.deltaMoveX = 0
		elseif not var_11_1 then
			arg_11_0.deltaMoveX = 0
		end
	end

	if UIBlockMgr.instance:isBlock() or ZProj.TouchEventMgr.Fobidden then
		arg_11_0.deltaMoveX = 0
	end

	if arg_11_0.deltaMoveX ~= 0 and arg_11_0:checkPlayerInNoneColorElement(arg_11_0.playerTrans.localPosition.x, arg_11_0.playerTrans.localPosition.y) and not arg_11_0.isDying then
		GameFacade.showToast(ToastEnum.Act185TrapTip)

		return false
	end

	arg_11_0.isTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(arg_11_0.playerTrans.localPosition.x + arg_11_0.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth / 2 + 1), arg_11_0.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2)

	if not arg_11_0:checkPlayerInState() then
		arg_11_0.deltaMoveX = arg_11_0.playerAnimComp:setMoveAnim(arg_11_0.deltaMoveX, arg_11_0.isTouchElementList)
	end

	if arg_11_0.sceneTrans then
		local var_11_2, var_11_3 = arg_11_0.sceneViewCls:fixSceneBorder(-arg_11_0.playerTrans.localPosition.x, -arg_11_0.playerTrans.localPosition.y)

		arg_11_0.sceneTrans.localPosition = Vector3.Lerp(arg_11_0.sceneTrans.localPosition, Vector3(var_11_2, var_11_3, arg_11_0.sceneTrans.localPosition.z), FeiLinShiDuoEnum.SceneMoveSpeed)
	end

	arg_11_0.fixFallDeltaMoveX = arg_11_0.deltaMoveX ~= 0 and arg_11_0.deltaMoveX or arg_11_0.fixFallDeltaMoveX

	if arg_11_0.deltaMoveX ~= 0 and not arg_11_0:checkPlayerInState() and not arg_11_0:checkForwardCanMove(arg_11_0.playerTrans.localPosition.x + arg_11_0.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth / 2 + 1), arg_11_0.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2, arg_11_0.deltaMoveX) then
		arg_11_0.playerAnimComp:setForward(arg_11_0.deltaMoveX)

		return false
	end

	if arg_11_0.jumpForwardElementList and #arg_11_0.jumpForwardElementList == 0 and not arg_11_0:checkPlayerInState() then
		arg_11_0.playerAnimComp:setPlayerMove(arg_11_0.playerTrans)
	end

	return true
end

function var_0_0.handleEvent(arg_12_0)
	if not arg_12_0.sceneViewCls then
		return
	end

	arg_12_0:playerTouchElement()
	arg_12_0:checkClimbStairs()
	arg_12_0:checkPlayerDropFromStairs()
end

function var_0_0.checkPlayerFall(arg_13_0, arg_13_1)
	if (arg_13_0.isGround or arg_13_0.deltaMoveX == 0 and not arg_13_0.isGround) and not arg_13_0.isJumping and not arg_13_0.isClimbing or arg_13_1 then
		local var_13_0 = {
			FeiLinShiDuoEnum.ObjectType.Jump,
			FeiLinShiDuoEnum.ObjectType.Option,
			FeiLinShiDuoEnum.ObjectType.Start
		}
		local var_13_1 = FeiLinShiDuoGameModel.instance:checkTouchElement(arg_13_0.playerTrans.localPosition.x - arg_13_0.deltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 4, arg_13_0.playerTrans.localPosition.y - 2, var_13_0, nil, true)
		local var_13_2 = FeiLinShiDuoGameModel.instance:checkTouchElement(arg_13_0.playerTrans.localPosition.x + arg_13_0.deltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 4, arg_13_0.playerTrans.localPosition.y - 2, var_13_0, nil, true)

		if #var_13_1 == 0 and #var_13_2 == 0 and not arg_13_0:checkPlayerIsInElement() then
			if not arg_13_0.hasFixFallPos then
				if arg_13_0.jumpForwardElementList and #arg_13_0.jumpForwardElementList > 0 then
					transformhelper.setLocalPosXY(arg_13_0.playerTrans, arg_13_0.playerTrans.localPosition.x, arg_13_0.playerTrans.localPosition.y - arg_13_0.fallYSpeed * Time.deltaTime)
				else
					local var_13_3 = arg_13_1 and arg_13_0.playerTrans.localPosition.x or arg_13_0.playerTrans.localPosition.x + arg_13_0.fixFallDeltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 4

					transformhelper.setLocalPosXY(arg_13_0.playerTrans, var_13_3, arg_13_0.playerTrans.localPosition.y - arg_13_0.fallYSpeed * Time.deltaTime)
				end

				arg_13_0.hasFixFallPos = true
			else
				transformhelper.setLocalPosXY(arg_13_0.playerTrans, arg_13_0.playerTrans.localPosition.x, arg_13_0.playerTrans.localPosition.y - arg_13_0.fallYSpeed * Time.deltaTime)
			end

			arg_13_0.isGround = false
			arg_13_0.fallYSpeed = arg_13_0.fallYSpeed + arg_13_0.fallAddSpeed

			arg_13_0.playerAnimComp:playFallAnim()

			arg_13_0.isFalling = true
		else
			if not arg_13_0.isGround then
				arg_13_0.playerTrans.localPosition = arg_13_0:fixStandPos(var_13_1)

				arg_13_0.playerAnimComp:playFallEndAnim()
			end

			arg_13_0:setCurStandWall(var_13_1, arg_13_0.deltaMoveX)

			arg_13_0.isGround = true
			arg_13_0.fallYSpeed = 0
			arg_13_0.hasFixFallPos = false
			arg_13_0.jumpForwardElementList = {}
			arg_13_0.isFalling = false
		end
	end
end

function var_0_0.fixStandPos(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = FeiLinShiDuoGameModel.instance:getFixStandePos(arg_14_1, arg_14_0.playerTrans.localPosition.x, arg_14_0.playerTrans.localPosition.y)

	if var_14_0 and var_14_1 then
		return Vector3(arg_14_0.playerTrans.localPosition.x, var_14_1.y, 0)
	end

	return arg_14_0.playerTrans.localPosition
end

function var_0_0.setCurStandWall(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		if iter_15_1.type == FeiLinShiDuoEnum.ObjectType.Wall then
			arg_15_0.curStandWallItem = iter_15_1

			break
		end
	end
end

function var_0_0.playerTouchElement(arg_16_0)
	if arg_16_0.isGround then
		arg_16_0.isTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(arg_16_0.playerTrans.localPosition.x + arg_16_0.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth / 2 + 1), arg_16_0.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2)

		if #arg_16_0.isTouchElementList > 0 then
			for iter_16_0, iter_16_1 in pairs(arg_16_0.isTouchElementList) do
				if iter_16_1.type == FeiLinShiDuoEnum.ObjectType.Box and not arg_16_0:checkPlayerInState() and arg_16_0.deltaMoveX ~= 0 then
					arg_16_0.sceneViewCls:getBoxComp(iter_16_1.id):setMove(arg_16_0.playerTrans, arg_16_0.deltaMoveX)
				end

				if iter_16_1.type == FeiLinShiDuoEnum.ObjectType.Jump and arg_16_0.deltaMoveX ~= 0 and Mathf.Abs(iter_16_1.pos[1] + iter_16_1.width / 2 - arg_16_0.playerTrans.localPosition.x) <= FeiLinShiDuoEnum.touchElementRange then
					arg_16_0.isGround = false
					arg_16_0.isJumping = true
					arg_16_0.isFalling = true
					arg_16_0.jumpStartPos = Vector3(iter_16_1.pos[1] + iter_16_1.width / 2, iter_16_1.pos[2], 0)

					local var_16_0 = arg_16_0.playerAnimComp:getLookDir()
					local var_16_1 = var_16_0 * 2 * FeiLinShiDuoEnum.SlotWidth

					arg_16_0.jumpTargetPos = Vector3(iter_16_1.pos[1] + iter_16_1.width / 2 + var_16_1, iter_16_1.pos[2], 0)

					arg_16_0.playerAnimComp:playJumpAnim()

					local var_16_2 = {
						FeiLinShiDuoEnum.ObjectType.Stairs,
						FeiLinShiDuoEnum.ObjectType.Start
					}

					arg_16_0.jumpForwardElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(arg_16_0.jumpTargetPos.x, iter_16_1.pos[2] + FeiLinShiDuoEnum.HalfSlotWidth, var_16_2) or {}

					local var_16_3 = iter_16_1.pos[1] + iter_16_1.width / 2 + var_16_0 * FeiLinShiDuoEnum.SlotWidth
					local var_16_4 = iter_16_1.pos[2] + FeiLinShiDuoEnum.SlotWidth

					arg_16_0.jumpTargetPos = #arg_16_0.jumpForwardElementList > 0 and Vector3(var_16_3, var_16_4, 0) or arg_16_0.jumpTargetPos

					local var_16_5 = #arg_16_0.jumpForwardElementList > 0 and FeiLinShiDuoEnum.jumpAnimTime / 2 or FeiLinShiDuoEnum.jumpAnimTime

					arg_16_0.jumpTweenX = ZProj.TweenHelper.DOAnchorPosX(arg_16_0.playerTrans, arg_16_0.jumpTargetPos.x, var_16_5)
					arg_16_0.jumpTweenY = ZProj.TweenHelper.DOAnchorPosY(arg_16_0.playerTrans, var_16_4, FeiLinShiDuoEnum.jumpAnimTime / 2, arg_16_0.doJumpHalfXFinish, arg_16_0, nil, EaseType.OutCubic)

					local var_16_6 = arg_16_0.sceneViewCls:getJumpAnim(iter_16_1)

					if var_16_6 then
						var_16_6.enabled = true

						var_16_6:Play("active", 0, 0)
					end
				end

				if iter_16_1.type == FeiLinShiDuoEnum.ObjectType.Target and arg_16_0.deltaMoveX ~= 0 and not arg_16_0.isInTarget and Mathf.Abs(iter_16_1.pos[1] + iter_16_1.width / 2 - arg_16_0.playerTrans.localPosition.x) <= FeiLinShiDuoEnum.touchElementRange then
					local var_16_7 = FeiLinShiDuoGameModel.instance:getCurGameConfig()

					Activity185Rpc.instance:sendAct185FinishEpisodeRequest(var_16_7.activityId, var_16_7.episodeId, arg_16_0.openGameResultView, arg_16_0)

					arg_16_0.isInTarget = true

					arg_16_0.playerAnimComp:playIdleAnim()
					FeiLinShiDuoStatHelper.instance:sendMapFinish(arg_16_0.playerGO)
				end
			end
		end

		arg_16_0.isTouchElementList = FeiLinShiDuoGameModel.instance:checkTouchElement(arg_16_0.playerTrans.localPosition.x, arg_16_0.playerTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth / 2)

		if #arg_16_0.isTouchElementList > 0 then
			for iter_16_2, iter_16_3 in pairs(arg_16_0.isTouchElementList) do
				if iter_16_3.type == FeiLinShiDuoEnum.ObjectType.Trap then
					arg_16_0.playerAnimComp:playDieAnim()

					if not arg_16_0.isDying then
						arg_16_0.gameUIView:showDeadEffect()
					end

					arg_16_0.isDying = true

					break
				end
			end
		end
	end
end

function var_0_0.openGameResultView(arg_17_0)
	local var_17_0 = {}

	var_17_0.isSuccess = true

	FeiLinShiDuoGameController.instance:openGameResultView(var_17_0)
end

function var_0_0.doJumpHalfXFinish(arg_18_0)
	if arg_18_0.jumpForwardElementList and #arg_18_0.jumpForwardElementList > 0 then
		arg_18_0:doJumpFinish()
	else
		arg_18_0.jumpTweenY2 = ZProj.TweenHelper.DOAnchorPosY(arg_18_0.playerTrans, arg_18_0.jumpTargetPos.y, FeiLinShiDuoEnum.jumpAnimTime / 2, arg_18_0.doJumpFinish, arg_18_0, nil, EaseType.InCubic)
	end
end

function var_0_0.doJumpFinish(arg_19_0)
	if arg_19_0.jumpForwardElementList and #arg_19_0.jumpForwardElementList > 0 then
		arg_19_0.isJumping = false
	end

	arg_19_0.playerTrans.localPosition = arg_19_0.jumpTargetPos
	arg_19_0.jumpForwardElementList = {}

	arg_19_0:killTween()
end

function var_0_0.startClimbStairs(arg_20_0)
	if arg_20_0:checkPlayerInState() then
		return
	end

	arg_20_0.isClimbing = true
	arg_20_0.startClimbing = true

	if not arg_20_0:checkStairsCanClimb() then
		GameFacade.showToast(ToastEnum.Act185ClimbTip)

		arg_20_0.isClimbing = false
		arg_20_0.startClimbing = false

		arg_20_0.gameUIView:showOptionCanDoState(false)

		return
	end

	if arg_20_0.isTopStairs then
		transformhelper.setLocalPosXY(arg_20_0.playerTrans, arg_20_0.curStairsItem.pos[1] + arg_20_0.curStairsItem.width / 2, arg_20_0.curStairsItem.pos[2] + arg_20_0.curStairsItem.height - FeiLinShiDuoEnum.HalfSlotWidth)
	end
end

function var_0_0.checkStairsCanClimb(arg_21_0)
	local var_21_0 = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(arg_21_0.curStairsItem.pos[1], arg_21_0.curStairsItem.pos[2], arg_21_0.curStairsItem, FeiLinShiDuoEnum.checkDir.Top)
	local var_21_1 = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(arg_21_0.curStairsItem.pos[1], arg_21_0.curStairsItem.pos[2] + FeiLinShiDuoEnum.HalfSlotWidth, arg_21_0.curStairsItem, FeiLinShiDuoEnum.checkDir.Bottom, arg_21_0.sceneViewCls:getAllBoxCompList())

	return #var_21_0 == 0 and #var_21_1 == 0
end

function var_0_0.checkClimbStairs(arg_22_0)
	if arg_22_0.isGround and not arg_22_0.isClimbing then
		local var_22_0 = FeiLinShiDuoGameModel.instance:checkTouchElement(arg_22_0.playerTrans.localPosition.x, arg_22_0.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 4)
		local var_22_1 = FeiLinShiDuoGameModel.instance:checkTouchElement(arg_22_0.playerTrans.localPosition.x, arg_22_0.playerTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth / 4)

		arg_22_0.curStairsItem = nil

		for iter_22_0, iter_22_1 in pairs(var_22_0) do
			if iter_22_1.type == FeiLinShiDuoEnum.ObjectType.Stairs then
				arg_22_0.curStairsItem = iter_22_1
				arg_22_0.isTopStairs = false

				break
			end
		end

		for iter_22_2, iter_22_3 in pairs(var_22_1) do
			if iter_22_3.type == FeiLinShiDuoEnum.ObjectType.Stairs then
				arg_22_0.curStairsItem = iter_22_3
				arg_22_0.isTopStairs = true

				break
			end
		end

		if arg_22_0.curStairsItem and Mathf.Abs(arg_22_0.curStairsItem.pos[1] + arg_22_0.curStairsItem.width / 2 - arg_22_0.playerTrans.localPosition.x) > FeiLinShiDuoEnum.stairsTouchCheckRange then
			arg_22_0.curStairsItem = nil
		end

		arg_22_0.gameUIView:showOptionState(arg_22_0.curStairsItem ~= nil)

		arg_22_0.canShowOption = arg_22_0.curStairsItem ~= nil

		if arg_22_0.curStairsItem then
			arg_22_0.gameUIView:showOptionCanDoState(arg_22_0:checkStairsCanClimb())
		end
	elseif arg_22_0.isClimbing and arg_22_0.startClimbing then
		arg_22_0.gameUIView:showOptionState(false)

		arg_22_0.canShowOption = false

		arg_22_0.playerAnimComp:playStartClimbAnim()

		if arg_22_0.isTopStairs then
			transformhelper.setLocalPosXY(arg_22_0.playerTrans, arg_22_0.curStairsItem.pos[1] + arg_22_0.curStairsItem.width / 2, arg_22_0.playerTrans.localPosition.y - FeiLinShiDuoEnum.climbSpeed * Time.deltaTime)

			if Mathf.Abs(arg_22_0.curStairsItem.pos[2] - arg_22_0.playerTrans.localPosition.y) <= FeiLinShiDuoEnum.HalfSlotWidth / 3 then
				transformhelper.setLocalPosXY(arg_22_0.playerTrans, arg_22_0.curStairsItem.pos[1] + arg_22_0.curStairsItem.width / 2, arg_22_0.curStairsItem.pos[2])
				arg_22_0.playerAnimComp:playEndClimbAnim()

				arg_22_0.isTopStairs = false
				arg_22_0.startClimbing = false
			end
		else
			transformhelper.setLocalPosXY(arg_22_0.playerTrans, arg_22_0.curStairsItem.pos[1] + arg_22_0.curStairsItem.width / 2, arg_22_0.playerTrans.localPosition.y + FeiLinShiDuoEnum.climbSpeed * Time.deltaTime)

			if Mathf.Abs(arg_22_0.curStairsItem.pos[2] + arg_22_0.curStairsItem.height - arg_22_0.playerTrans.localPosition.y) <= FeiLinShiDuoEnum.HalfSlotWidth then
				transformhelper.setLocalPosXY(arg_22_0.playerTrans, arg_22_0.curStairsItem.pos[1] + arg_22_0.curStairsItem.width / 2, arg_22_0.curStairsItem.pos[2] + arg_22_0.curStairsItem.height)
				arg_22_0.playerAnimComp:playEndClimbAnim()

				arg_22_0.isTopStairs = true
				arg_22_0.startClimbing = false
			end
		end
	end
end

function var_0_0.checkPlayerDropFromStairs(arg_23_0)
	if not arg_23_0.isClimbing and not arg_23_0.startClimbing and arg_23_0.curStairsItem and arg_23_0.playerTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth / 4 < arg_23_0.curStairsItem.pos[2] then
		arg_23_0:checkPlayerFall(true)
	end
end

function var_0_0.checkBoxHitPlayer(arg_24_0)
	local var_24_0 = arg_24_0.sceneViewCls:getAllBoxComp()

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		if iter_24_1.isGround == false and not arg_24_0.isDying and arg_24_0.playerTrans.localPosition.x >= iter_24_1.itemInfo.pos[1] and arg_24_0.playerTrans.localPosition.x <= iter_24_1.itemInfo.pos[1] + iter_24_1.itemInfo.width and arg_24_0.playerTrans.localPosition.y < iter_24_1.itemInfo.pos[2] and Mathf.Abs(iter_24_1.itemInfo.pos[2] - arg_24_0.playerTrans.localPosition.y) <= FeiLinShiDuoEnum.HalfSlotWidth then
			arg_24_0.curHitBoxComp = iter_24_1

			arg_24_0.playerAnimComp:playDieAnim()

			if not arg_24_0.isDying then
				arg_24_0.gameUIView:showDeadEffect()
			end

			arg_24_0.isDying = true

			break
		end
	end

	if arg_24_0.curHitBoxComp and not arg_24_0.isDying then
		arg_24_0:playerReborn()

		arg_24_0.curHitBoxComp = nil
	end
end

function var_0_0.playerReborn(arg_25_0)
	if arg_25_0.curHitBoxComp then
		local var_25_0 = arg_25_0.playerAnimComp:getLookDir()
		local var_25_1 = arg_25_0.curHitBoxComp.itemInfo.pos[1] - FeiLinShiDuoEnum.HalfSlotWidth
		local var_25_2 = arg_25_0.curHitBoxComp.itemInfo.pos[1] + arg_25_0.curHitBoxComp.itemInfo.width + FeiLinShiDuoEnum.HalfSlotWidth
		local var_25_3 = var_25_0 > 0 and var_25_1 or var_25_2

		if arg_25_0:checkPlayerInNoneColorElement(var_25_3, arg_25_0.playerTrans.localPosition.y) and var_25_0 > 0 then
			var_25_3 = var_25_2
		elseif arg_25_0:checkPlayerInNoneColorElement(var_25_3, arg_25_0.playerTrans.localPosition.y) and var_25_0 < 0 then
			var_25_3 = var_25_1
		end

		transformhelper.setLocalPosXY(arg_25_0.playerTrans, var_25_3, arg_25_0.playerTrans.localPosition.y)
	elseif arg_25_0.curStandWallItem then
		local var_25_4 = Mathf.Abs(arg_25_0.playerTrans.localPosition.x - arg_25_0.curStandWallItem.pos[1]) < Mathf.Abs(arg_25_0.playerTrans.localPosition.x - (arg_25_0.curStandWallItem.pos[1] + arg_25_0.curStandWallItem.width)) and arg_25_0.curStandWallItem.pos[1] + FeiLinShiDuoEnum.HalfSlotWidth or arg_25_0.curStandWallItem.pos[1] + arg_25_0.curStandWallItem.width - FeiLinShiDuoEnum.HalfSlotWidth

		transformhelper.setLocalPosXY(arg_25_0.playerTrans, var_25_4, arg_25_0.curStandWallItem.pos[2] + arg_25_0.curStandWallItem.height)
	end

	UIBlockHelper.instance:startBlock("FeiLinShiDuoPlayerComp_playerReborn", 0.4, ViewName.FeiLinShiDuoGameView)
	arg_25_0.gameUIView:_onLeftClickUp()
	arg_25_0.gameUIView:_onRightClickUp()
end

function var_0_0.checkForwardCanMove(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	if not arg_26_0:checkPlayerCanMove() then
		return false
	end

	return FeiLinShiDuoGameModel.instance:checkForwardCanMove(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
end

function var_0_0.checkPlayerCanMove(arg_27_0)
	local var_27_0 = arg_27_0.sceneViewCls:getAllBoxComp()

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if iter_27_1:getShowState() and iter_27_1.isGround == false then
			return false
		end
	end

	if arg_27_0:checkPlayerIsInElement() or arg_27_0.isInTarget then
		return false
	end

	return true
end

function var_0_0.checkPlayerIsInElement(arg_28_0)
	local var_28_0 = FeiLinShiDuoGameModel.instance:getElementMap()

	if not var_28_0 then
		return false
	end

	local var_28_1 = {}
	local var_28_2 = var_28_0[FeiLinShiDuoEnum.ObjectType.Box] or {}
	local var_28_3 = var_28_0[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}

	if not var_28_0[FeiLinShiDuoEnum.ObjectType.Door] then
		local var_28_4 = {}
	end

	for iter_28_0, iter_28_1 in pairs(var_28_3) do
		table.insert(var_28_1, iter_28_1)
	end

	for iter_28_2, iter_28_3 in pairs(var_28_2) do
		table.insert(var_28_1, iter_28_3)
	end

	return #FeiLinShiDuoGameModel.instance:checkTouchElement(arg_28_0.playerTrans.localPosition.x, arg_28_0.playerTrans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 4, {}, var_28_1) > 0
end

function var_0_0.checkPlayerInNoneColorElement(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = FeiLinShiDuoGameModel.instance:getElementMap()

	if not var_29_0 then
		return false
	end

	local var_29_1 = {}
	local var_29_2 = var_29_0[FeiLinShiDuoEnum.ObjectType.Box] or {}
	local var_29_3 = var_29_0[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}
	local var_29_4 = var_29_0[FeiLinShiDuoEnum.ObjectType.Wall] or {}

	for iter_29_0, iter_29_1 in pairs(var_29_3) do
		if iter_29_1.color == FeiLinShiDuoEnum.ColorType.None then
			table.insert(var_29_1, iter_29_1)
		end
	end

	for iter_29_2, iter_29_3 in pairs(var_29_2) do
		if iter_29_3.color == FeiLinShiDuoEnum.ColorType.None then
			table.insert(var_29_1, iter_29_3)
		end
	end

	for iter_29_4, iter_29_5 in pairs(var_29_4) do
		table.insert(var_29_1, iter_29_5)
	end

	return #FeiLinShiDuoGameModel.instance:checkTouchElement(arg_29_1, arg_29_2 + FeiLinShiDuoEnum.HalfSlotWidth / 2, {}, var_29_1) > 0
end

function var_0_0.checkPlayerInGuidePos(arg_30_0)
	if arg_30_0.curGuideCheckData and #arg_30_0.curGuideCheckData.guideList > 0 and arg_30_0.curCheckPosIndex <= #arg_30_0.curGuideCheckData.guideList then
		local var_30_0 = arg_30_0.curGuideCheckData.guideList[arg_30_0.curCheckPosIndex]

		if not var_30_0 then
			return
		end

		if arg_30_0.playerTrans.localPosition.x >= var_30_0.posX and arg_30_0.playerTrans.localPosition.x <= var_30_0.posX + var_30_0.rangeX and arg_30_0.playerTrans.localPosition.y >= var_30_0.posY and arg_30_0.playerTrans.localPosition.y <= var_30_0.posY + var_30_0.rangeY then
			FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.PlayerInGuideCheckPos, var_30_0.id)

			arg_30_0.curCheckPosIndex = arg_30_0.curCheckPosIndex + 1
		end
	end
end

function var_0_0.checkPlayerInState(arg_31_0)
	return arg_31_0.isClimbing or arg_31_0.isFalling or arg_31_0.isDying or arg_31_0.isJumping
end

function var_0_0.setIdleState(arg_32_0)
	arg_32_0.isClimbing = false
	arg_32_0.isFalling = false
	arg_32_0.isDying = false
	arg_32_0.isJumping = false
end

function var_0_0.killTween(arg_33_0)
	if arg_33_0.jumpTweenX then
		ZProj.TweenHelper.KillById(arg_33_0.jumpTweenX)
	end

	if arg_33_0.jumpTweenY then
		ZProj.TweenHelper.KillById(arg_33_0.jumpTweenY)
	end

	if arg_33_0.jumpTweenY2 then
		ZProj.TweenHelper.KillById(arg_33_0.jumpTweenY2)
	end
end

function var_0_0.onDestroy(arg_34_0)
	arg_34_0:killTween()
end

return var_0_0
