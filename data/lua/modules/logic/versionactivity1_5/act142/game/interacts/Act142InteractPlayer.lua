module("modules.logic.versionactivity1_5.act142.game.interacts.Act142InteractPlayer", package.seeall)

slot0 = class("Act142InteractPlayer", Va3ChessInteractBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._fireBallTweenMoveId = nil
	slot0._isFiring = false
end

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)

	if not slot0._target.avatar.loader then
		return
	end

	if not gohelper.isNil(slot1:getInstGO()) then
		slot7 = true

		gohelper.setActive(gohelper.findChild(slot2, "fireball"), slot7)

		for slot7 = 1, Activity142Enum.MAX_FIRE_BALL_NUM do
			if not gohelper.isNil(gohelper.findChild(slot2, "fireball/fireball" .. slot7)) then
				slot0._target.avatar["goFireBall" .. slot7] = slot9

				gohelper.setActive(slot9, false)
			end
		end

		slot0._animSelf = slot2:GetComponent(Va3ChessEnum.ComponentType.Animator)

		if slot0._animSelf and Va3ChessGameModel.instance:getObjectDataById(slot0._target.id) and slot4:getHaveBornEff() then
			slot0._animSelf:Play(Activity142Enum.SWITCH_OPEN_ANIM, 0, 0)
			slot4:setHaveBornEff(false)
		end
	end

	slot0:updateFireBallCount()
	loadAbAsset(Va3ChessEnum.Bullet.FireBall.path, false, slot0._onLoadFireBallBulletComplete, slot0)
end

function slot0.onSelected(slot0)
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.SelectObjWaitPos)

	slot1 = slot0._target.originData.posX
	slot2 = slot0._target.originData.posY
	slot3 = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = slot1,
		selfPosY = slot2,
		selectType = Va3ChessEnum.ChessSelectType.Normal
	}

	slot0:insertPosToList(slot1 + 1, slot2, slot3.posXList, slot3.posYList)
	slot0:insertPosToList(slot1 - 1, slot2, slot3.posXList, slot3.posYList)
	slot0:insertPosToList(slot1, slot2 + 1, slot3.posXList, slot3.posYList)
	slot0:insertPosToList(slot1, slot2 - 1, slot3.posXList, slot3.posYList)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, slot3)
end

function slot0.insertPosToList(slot0, slot1, slot2, slot3, slot4)
	if Va3ChessGameController.instance:posCanWalk(slot1, slot2, Va3ChessMapUtils.ToDirection(slot0._target.originData.posX, slot0._target.originData.posY, slot1, slot2), slot0._target.objType) then
		table.insert(slot3, slot1)
		table.insert(slot4, slot2)
	end
end

function slot0.onCancelSelect(slot0)
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.None)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
end

function slot0.onSelectPos(slot0, slot1, slot2)
	slot3, slot4 = slot0:isCanFire(slot1, slot2)

	if slot3 and slot4 then
		slot0:requestFire(slot1, slot2, slot4)
	else
		slot0:requestBeginRound(slot1, slot2)
	end
end

function slot0.requestBeginRound(slot0, slot1, slot2)
	slot3 = slot0._target.originData.posX
	slot4 = slot0._target.originData.posY

	if not Activity142Helper.isSurroundPlayer(slot1, slot2) then
		GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)

		return
	end

	if not Va3ChessGameController.instance:posCanWalk(slot1, slot2, Va3ChessMapUtils.ToDirection(slot3, slot4, slot1, slot2), slot0._target.objType) then
		GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)

		return
	end

	Va3ChessGameModel.instance:appendOpt({
		id = slot0._target.originData.id,
		dir = Va3ChessMapUtils.ToDirection(slot3, slot4, slot1, slot2)
	})
	Va3ChessRpcController.instance:sendActBeginRoundRequest(Va3ChessGameModel.instance:getActId(), Va3ChessGameModel.instance:getOptList(), slot0.onMoveSuccess, slot0)
	Va3ChessGameController.instance:saveTempSelectObj()
	Va3ChessGameController.instance:setSelectObj(nil)

	if Va3ChessGameController.instance.event then
		slot11:setLockEvent()
	end
end

function slot0.updateFireBallCount(slot0)
	for slot5 = 1, Activity142Enum.MAX_FIRE_BALL_NUM do
		if not gohelper.isNil(slot0._target.avatar["goFireBall" .. slot5]) then
			gohelper.setActive(slot7, slot5 <= Va3ChessGameModel.instance:getFireBallCount())
		end
	end
end

function slot0._onLoadFireBallBulletComplete(slot0, slot1)
	if slot1 and slot1.IsLoadSuccess then
		slot2 = nil

		if not gohelper.isNil(slot0._target:tryGetSceneGO()) then
			slot2 = slot3.transform.parent and slot4.parent.gameObject or nil
		end

		if slot0._fireBallBulletAssetItem then
			slot0._fireBallBulletAssetItem:Release()
		end

		slot0._fireBallBulletAssetItem = slot1

		slot0._fireBallBulletAssetItem:Retain()

		if not gohelper.isNil(gohelper.clone(slot0._fireBallBulletAssetItem:GetResource(Va3ChessEnum.Bullet.FireBall.path), slot2)) then
			slot0.fireBallBulletItem = {
				go = slot4,
				dir2GO = {}
			}

			for slot8, slot9 in pairs(Va3ChessEnum.Direction) do
				slot0.fireBallBulletItem.dir2GO[slot9] = gohelper.findChild(slot0.fireBallBulletItem.go, string.format("dir_%s", slot9))
			end

			slot0:_setFireBallDirGOActive()

			slot0.fireBallBulletItem.hitEffect = gohelper.findChild(slot0.fireBallBulletItem.go, "vx_fire_hit")

			gohelper.setActive(slot0.fireBallBulletItem.hitEffect, false)
		else
			logError("Act142InteractPlayer._onLoadFireBallBulletComplete error, get bulletGO fail")
		end
	end
end

function slot0.isCanFire(slot0, slot1, slot2)
	slot3 = false

	if slot0._isFiring then
		return slot3, nil
	end

	slot5, slot6 = Va3ChessGameController.instance:searchInteractByPos(slot1, slot2, Activity142Helper.filterCanFireKill)
	slot7 = nil
	slot7 = slot5 == 1 and slot6 or slot6 and slot6[1] or nil

	return slot3, Activity142Helper.isCanFireKill(slot7) and slot7.id or nil
end

function slot0.requestFire(slot0, slot1, slot2, slot3)
	if slot0._isFiring then
		logError("Act142InteractPlayer:requestFire error, cannot repeat fire")

		return
	end

	if Va3ChessGameModel.instance:getFireBallCount() < 0 then
		logError("Act142InteractPlayer:requestFire error, not have fireBall showing")

		return
	end

	Activity142Rpc.instance:sendAct142UseFireballRequest(Activity142Model.instance:getActivityId(), slot0._target.originData.posX, slot0._target.originData.posY, slot1, slot2, slot3, slot0.playFireBallTween, slot0)
end

function slot0.playFireBallTween(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 or string.nilorempty(slot3.useFireball) then
		return
	end

	slot0:updateFireBallCount()

	if not cjson.decode(slot3.useFireball) then
		return
	end

	if not slot4.targetId or slot5 <= 0 then
		return
	end

	if not slot0.fireBallBulletItem or gohelper.isNil(slot0.fireBallBulletItem.go) then
		return
	end

	slot6 = slot4.x1 or 0
	slot7 = slot4.y1 or 0
	slot10, slot11 = Va3ChessGameModel.instance:getGameSize()

	slot0:_setFireBallDirGOActive(Va3ChessMapUtils.ToDirection(slot6, slot7, Mathf.Clamp(slot4.x2 or 0, 0, slot10 - 1), Mathf.Clamp(slot4.y2 or 0, 0, slot11 - 1)))

	slot14, slot15, slot16 = Va3ChessGameController.instance:calcTilePosInScene(slot6, slot7)

	transformhelper.setLocalPos(slot0.fireBallBulletItem.go.transform, slot14, slot15, slot16)
	Activity142Helper.setAct142UIBlock(true, Activity142Enum.FIRING_BALL)

	slot0._tmpTargetId = slot5

	if slot4.pedalObjectId and slot17 > 0 then
		slot0._tmpPedalId = slot17
		slot0._tmpPedalStatus = slot4.pedalStatus
	end

	slot0._isFiring = true
	slot19, slot20, slot21 = Va3ChessGameController.instance:calcTilePosInScene(slot8, slot9)
	slot0._fireBallTweenMoveId = ZProj.TweenHelper.DOLocalMove(slot13, slot19, slot20, slot21, Va3ChessMapUtils.calBulletFlyTime(Va3ChessEnum.Bullet.FireBall.speed, slot6, slot7, slot8, slot9), slot0.onFireBallTweenComplete, slot0, nil, EaseType.Linear)

	AudioMgr.instance:trigger(AudioEnum.chess_activity142.FireBall)
end

function slot0._setFireBallDirGOActive(slot0, slot1)
	if not slot0.fireBallBulletItem or not slot0.fireBallBulletItem.dir2GO then
		return
	end

	for slot5, slot6 in pairs(slot0.fireBallBulletItem.dir2GO) do
		gohelper.setActive(slot6, slot5 == slot1)
	end
end

function slot0.onFireBallTweenComplete(slot0)
	slot0._fireBallTweenMoveId = nil

	if Va3ChessGameController.instance.event then
		if slot0._tmpTargetId then
			slot1:insertStep({
				param = string.format("{\"stepType\":%s,\"id\":%s,\"reason\":%s,\"refreshAllKillEff\":%s}", Va3ChessEnum.GameStepType.DeleteObject, slot0._tmpTargetId, Va3ChessEnum.DeleteReason.FireBall, 1)
			})
			slot1:insertStep({
				param = string.format("{\"stepType\":%s,\"id\":%s}", Va3ChessEnum.GameStepType.InteractFinish, slot0._tmpTargetId)
			})
			gohelper.setActive(slot0.fireBallBulletItem.hitEffect, false)
			gohelper.setActive(slot0.fireBallBulletItem.hitEffect, true)
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.MonsterBeHit)
		end

		if slot0._tmpPedalId then
			slot1:insertStep({
				param = string.format("{\"stepType\":%s,\"id\":%s,\"pedalStatus\":%s}", Va3ChessEnum.GameStepType.RefreshPedalStatus, slot0._tmpPedalId, slot0._tmpPedalStatus)
			})
		end
	end

	slot0:_setFireBallDirGOActive()

	slot0._isFiring = false
	slot0._tmpTargetId = nil
	slot0._tmpPedalId = nil
	slot0._tmpPedalStatus = nil

	Activity142Helper.setAct142UIBlock(false, Activity142Enum.FIRING_BALL)
end

function slot0.dispose(slot0)
	if slot0._fireBallBulletAssetItem then
		slot0._fireBallBulletAssetItem:Release()

		slot0._fireBallBulletAssetItem = nil
	end

	if slot0._fireBallTweenMoveId then
		ZProj.TweenHelper.KillById(slot0._fireBallTweenMoveId)

		slot0._fireBallTweenMoveId = nil
	end

	slot0:onFireBallTweenComplete()

	if slot0.fireBallBulletItem then
		if slot0.fireBallBulletItem.dir2GO then
			for slot4, slot5 in pairs(slot0.fireBallBulletItem.dir2GO) do
				slot5 = nil
			end

			slot0.fireBallBulletItem.dir2GO = nil
		end

		slot0.fireBallBulletItem.hitEffect = nil

		gohelper.destroy(slot0.fireBallBulletItem.go)

		slot0.fireBallBulletItem.go = nil
	end

	slot0.fireBallBulletItem = {}
	slot0._isFiring = false
	slot0._tmpTargetId = nil
	slot0._tmpPedalId = nil
	slot0._tmpPedalStatus = nil

	uv0.super.dispose(slot0)
end

return slot0
