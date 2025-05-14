module("modules.logic.versionactivity1_5.act142.game.interacts.Act142InteractPlayer", package.seeall)

local var_0_0 = class("Act142InteractPlayer", Va3ChessInteractBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._fireBallTweenMoveId = nil
	arg_1_0._isFiring = false
end

function var_0_0.onAvatarLoaded(arg_2_0)
	var_0_0.super.onAvatarLoaded(arg_2_0)

	local var_2_0 = arg_2_0._target.avatar.loader

	if not var_2_0 then
		return
	end

	local var_2_1 = var_2_0:getInstGO()

	if not gohelper.isNil(var_2_1) then
		local var_2_2 = gohelper.findChild(var_2_1, "fireball")

		gohelper.setActive(var_2_2, true)

		for iter_2_0 = 1, Activity142Enum.MAX_FIRE_BALL_NUM do
			local var_2_3 = "goFireBall" .. iter_2_0
			local var_2_4 = gohelper.findChild(var_2_1, "fireball/fireball" .. iter_2_0)

			if not gohelper.isNil(var_2_4) then
				arg_2_0._target.avatar[var_2_3] = var_2_4

				gohelper.setActive(var_2_4, false)
			end
		end

		arg_2_0._animSelf = var_2_1:GetComponent(Va3ChessEnum.ComponentType.Animator)

		if arg_2_0._animSelf then
			local var_2_5 = Va3ChessGameModel.instance:getObjectDataById(arg_2_0._target.id)

			if var_2_5 and var_2_5:getHaveBornEff() then
				arg_2_0._animSelf:Play(Activity142Enum.SWITCH_OPEN_ANIM, 0, 0)
				var_2_5:setHaveBornEff(false)
			end
		end
	end

	arg_2_0:updateFireBallCount()
	loadAbAsset(Va3ChessEnum.Bullet.FireBall.path, false, arg_2_0._onLoadFireBallBulletComplete, arg_2_0)
end

function var_0_0.onSelected(arg_3_0)
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.SelectObjWaitPos)

	local var_3_0 = arg_3_0._target.originData.posX
	local var_3_1 = arg_3_0._target.originData.posY
	local var_3_2 = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = var_3_0,
		selfPosY = var_3_1,
		selectType = Va3ChessEnum.ChessSelectType.Normal
	}

	arg_3_0:insertPosToList(var_3_0 + 1, var_3_1, var_3_2.posXList, var_3_2.posYList)
	arg_3_0:insertPosToList(var_3_0 - 1, var_3_1, var_3_2.posXList, var_3_2.posYList)
	arg_3_0:insertPosToList(var_3_0, var_3_1 + 1, var_3_2.posXList, var_3_2.posYList)
	arg_3_0:insertPosToList(var_3_0, var_3_1 - 1, var_3_2.posXList, var_3_2.posYList)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, var_3_2)
end

function var_0_0.insertPosToList(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = arg_4_0._target.originData.posX
	local var_4_1 = arg_4_0._target.originData.posY
	local var_4_2 = Va3ChessMapUtils.ToDirection(var_4_0, var_4_1, arg_4_1, arg_4_2)

	if Va3ChessGameController.instance:posCanWalk(arg_4_1, arg_4_2, var_4_2, arg_4_0._target.objType) then
		table.insert(arg_4_3, arg_4_1)
		table.insert(arg_4_4, arg_4_2)
	end
end

function var_0_0.onCancelSelect(arg_5_0)
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.None)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
end

function var_0_0.onSelectPos(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0, var_6_1 = arg_6_0:isCanFire(arg_6_1, arg_6_2)

	if var_6_0 and var_6_1 then
		arg_6_0:requestFire(arg_6_1, arg_6_2, var_6_1)
	else
		arg_6_0:requestBeginRound(arg_6_1, arg_6_2)
	end
end

function var_0_0.requestBeginRound(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._target.originData.posX
	local var_7_1 = arg_7_0._target.originData.posY

	if not Activity142Helper.isSurroundPlayer(arg_7_1, arg_7_2) then
		GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)

		return
	end

	local var_7_2 = Va3ChessMapUtils.ToDirection(var_7_0, var_7_1, arg_7_1, arg_7_2)

	if not Va3ChessGameController.instance:posCanWalk(arg_7_1, arg_7_2, var_7_2, arg_7_0._target.objType) then
		GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)

		return
	end

	local var_7_3 = {
		id = arg_7_0._target.originData.id,
		dir = Va3ChessMapUtils.ToDirection(var_7_0, var_7_1, arg_7_1, arg_7_2)
	}

	Va3ChessGameModel.instance:appendOpt(var_7_3)

	local var_7_4 = Va3ChessGameModel.instance:getActId()
	local var_7_5 = Va3ChessGameModel.instance:getOptList()

	Va3ChessRpcController.instance:sendActBeginRoundRequest(var_7_4, var_7_5, arg_7_0.onMoveSuccess, arg_7_0)
	Va3ChessGameController.instance:saveTempSelectObj()
	Va3ChessGameController.instance:setSelectObj(nil)

	local var_7_6 = Va3ChessGameController.instance.event

	if var_7_6 then
		var_7_6:setLockEvent()
	end
end

function var_0_0.updateFireBallCount(arg_8_0)
	local var_8_0 = Va3ChessGameModel.instance:getFireBallCount()

	for iter_8_0 = 1, Activity142Enum.MAX_FIRE_BALL_NUM do
		local var_8_1 = "goFireBall" .. iter_8_0
		local var_8_2 = arg_8_0._target.avatar[var_8_1]

		if not gohelper.isNil(var_8_2) then
			gohelper.setActive(var_8_2, iter_8_0 <= var_8_0)
		end
	end
end

function var_0_0._onLoadFireBallBulletComplete(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1.IsLoadSuccess then
		local var_9_0
		local var_9_1 = arg_9_0._target:tryGetSceneGO()

		if not gohelper.isNil(var_9_1) then
			local var_9_2 = var_9_1.transform

			var_9_0 = var_9_2.parent and var_9_2.parent.gameObject or nil
		end

		if arg_9_0._fireBallBulletAssetItem then
			arg_9_0._fireBallBulletAssetItem:Release()
		end

		arg_9_0._fireBallBulletAssetItem = arg_9_1

		arg_9_0._fireBallBulletAssetItem:Retain()

		local var_9_3 = gohelper.clone(arg_9_0._fireBallBulletAssetItem:GetResource(Va3ChessEnum.Bullet.FireBall.path), var_9_0)

		if not gohelper.isNil(var_9_3) then
			arg_9_0.fireBallBulletItem = {}
			arg_9_0.fireBallBulletItem.go = var_9_3
			arg_9_0.fireBallBulletItem.dir2GO = {}

			for iter_9_0, iter_9_1 in pairs(Va3ChessEnum.Direction) do
				local var_9_4 = gohelper.findChild(arg_9_0.fireBallBulletItem.go, string.format("dir_%s", iter_9_1))

				arg_9_0.fireBallBulletItem.dir2GO[iter_9_1] = var_9_4
			end

			arg_9_0:_setFireBallDirGOActive()

			arg_9_0.fireBallBulletItem.hitEffect = gohelper.findChild(arg_9_0.fireBallBulletItem.go, "vx_fire_hit")

			gohelper.setActive(arg_9_0.fireBallBulletItem.hitEffect, false)
		else
			logError("Act142InteractPlayer._onLoadFireBallBulletComplete error, get bulletGO fail")
		end
	end
end

function var_0_0.isCanFire(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = false
	local var_10_1

	if arg_10_0._isFiring then
		return var_10_0, var_10_1
	end

	local var_10_2, var_10_3 = Va3ChessGameController.instance:searchInteractByPos(arg_10_1, arg_10_2, Activity142Helper.filterCanFireKill)
	local var_10_4

	if var_10_2 == 1 then
		var_10_4 = var_10_3
	else
		var_10_4 = var_10_3 and var_10_3[1] or nil
	end

	local var_10_5 = Activity142Helper.isCanFireKill(var_10_4)
	local var_10_6 = var_10_5 and var_10_4.id or nil

	return var_10_5, var_10_6
end

function var_0_0.requestFire(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0._isFiring then
		logError("Act142InteractPlayer:requestFire error, cannot repeat fire")

		return
	end

	if Va3ChessGameModel.instance:getFireBallCount() < 0 then
		logError("Act142InteractPlayer:requestFire error, not have fireBall showing")

		return
	end

	local var_11_0 = Activity142Model.instance:getActivityId()
	local var_11_1 = arg_11_0._target.originData.posX
	local var_11_2 = arg_11_0._target.originData.posY

	Activity142Rpc.instance:sendAct142UseFireballRequest(var_11_0, var_11_1, var_11_2, arg_11_1, arg_11_2, arg_11_3, arg_11_0.playFireBallTween, arg_11_0)
end

function var_0_0.playFireBallTween(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 ~= 0 or string.nilorempty(arg_12_3.useFireball) then
		return
	end

	arg_12_0:updateFireBallCount()

	local var_12_0 = cjson.decode(arg_12_3.useFireball)

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0.targetId

	if not var_12_1 or var_12_1 <= 0 then
		return
	end

	if not arg_12_0.fireBallBulletItem or gohelper.isNil(arg_12_0.fireBallBulletItem.go) then
		return
	end

	local var_12_2 = var_12_0.x1 or 0
	local var_12_3 = var_12_0.y1 or 0
	local var_12_4 = var_12_0.x2 or 0
	local var_12_5 = var_12_0.y2 or 0
	local var_12_6, var_12_7 = Va3ChessGameModel.instance:getGameSize()
	local var_12_8 = Mathf.Clamp(var_12_4, 0, var_12_6 - 1)
	local var_12_9 = Mathf.Clamp(var_12_5, 0, var_12_7 - 1)
	local var_12_10 = Va3ChessMapUtils.ToDirection(var_12_2, var_12_3, var_12_8, var_12_9)

	arg_12_0:_setFireBallDirGOActive(var_12_10)

	local var_12_11 = arg_12_0.fireBallBulletItem.go.transform
	local var_12_12, var_12_13, var_12_14 = Va3ChessGameController.instance:calcTilePosInScene(var_12_2, var_12_3)

	transformhelper.setLocalPos(var_12_11, var_12_12, var_12_13, var_12_14)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.FIRING_BALL)

	arg_12_0._tmpTargetId = var_12_1

	local var_12_15 = var_12_0.pedalObjectId

	if var_12_15 and var_12_15 > 0 then
		arg_12_0._tmpPedalId = var_12_15
		arg_12_0._tmpPedalStatus = var_12_0.pedalStatus
	end

	arg_12_0._isFiring = true

	local var_12_16 = Va3ChessMapUtils.calBulletFlyTime(Va3ChessEnum.Bullet.FireBall.speed, var_12_2, var_12_3, var_12_8, var_12_9)
	local var_12_17, var_12_18, var_12_19 = Va3ChessGameController.instance:calcTilePosInScene(var_12_8, var_12_9)

	arg_12_0._fireBallTweenMoveId = ZProj.TweenHelper.DOLocalMove(var_12_11, var_12_17, var_12_18, var_12_19, var_12_16, arg_12_0.onFireBallTweenComplete, arg_12_0, nil, EaseType.Linear)

	AudioMgr.instance:trigger(AudioEnum.chess_activity142.FireBall)
end

function var_0_0._setFireBallDirGOActive(arg_13_0, arg_13_1)
	if not arg_13_0.fireBallBulletItem or not arg_13_0.fireBallBulletItem.dir2GO then
		return
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0.fireBallBulletItem.dir2GO) do
		gohelper.setActive(iter_13_1, iter_13_0 == arg_13_1)
	end
end

function var_0_0.onFireBallTweenComplete(arg_14_0)
	arg_14_0._fireBallTweenMoveId = nil

	local var_14_0 = Va3ChessGameController.instance.event

	if var_14_0 then
		if arg_14_0._tmpTargetId then
			local var_14_1 = {
				param = string.format("{\"stepType\":%s,\"id\":%s,\"reason\":%s,\"refreshAllKillEff\":%s}", Va3ChessEnum.GameStepType.DeleteObject, arg_14_0._tmpTargetId, Va3ChessEnum.DeleteReason.FireBall, 1)
			}

			var_14_0:insertStep(var_14_1)

			local var_14_2 = {
				param = string.format("{\"stepType\":%s,\"id\":%s}", Va3ChessEnum.GameStepType.InteractFinish, arg_14_0._tmpTargetId)
			}

			var_14_0:insertStep(var_14_2)
			gohelper.setActive(arg_14_0.fireBallBulletItem.hitEffect, false)
			gohelper.setActive(arg_14_0.fireBallBulletItem.hitEffect, true)
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.MonsterBeHit)
		end

		if arg_14_0._tmpPedalId then
			local var_14_3 = {
				param = string.format("{\"stepType\":%s,\"id\":%s,\"pedalStatus\":%s}", Va3ChessEnum.GameStepType.RefreshPedalStatus, arg_14_0._tmpPedalId, arg_14_0._tmpPedalStatus)
			}

			var_14_0:insertStep(var_14_3)
		end
	end

	arg_14_0:_setFireBallDirGOActive()

	arg_14_0._isFiring = false
	arg_14_0._tmpTargetId = nil
	arg_14_0._tmpPedalId = nil
	arg_14_0._tmpPedalStatus = nil

	Activity142Helper.setAct142UIBlock(false, Activity142Enum.FIRING_BALL)
end

function var_0_0.dispose(arg_15_0)
	if arg_15_0._fireBallBulletAssetItem then
		arg_15_0._fireBallBulletAssetItem:Release()

		arg_15_0._fireBallBulletAssetItem = nil
	end

	if arg_15_0._fireBallTweenMoveId then
		ZProj.TweenHelper.KillById(arg_15_0._fireBallTweenMoveId)

		arg_15_0._fireBallTweenMoveId = nil
	end

	arg_15_0:onFireBallTweenComplete()

	if arg_15_0.fireBallBulletItem then
		if arg_15_0.fireBallBulletItem.dir2GO then
			for iter_15_0, iter_15_1 in pairs(arg_15_0.fireBallBulletItem.dir2GO) do
				iter_15_1 = nil
			end

			arg_15_0.fireBallBulletItem.dir2GO = nil
		end

		arg_15_0.fireBallBulletItem.hitEffect = nil

		gohelper.destroy(arg_15_0.fireBallBulletItem.go)

		arg_15_0.fireBallBulletItem.go = nil
	end

	arg_15_0.fireBallBulletItem = {}
	arg_15_0._isFiring = false
	arg_15_0._tmpTargetId = nil
	arg_15_0._tmpPedalId = nil
	arg_15_0._tmpPedalStatus = nil

	var_0_0.super.dispose(arg_15_0)
end

return var_0_0
