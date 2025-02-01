module("modules.logic.chessgame.game.interact.ChessInteractBase", package.seeall)

slot0 = class("ChessInteractBase")

function slot0.init(slot0, slot1)
	slot0._target = slot1
	slot0._isMoving = false
end

function slot0.onSelectCall(slot0)
end

function slot0.onCancelSelect(slot0)
end

function slot0.onSelectPos(slot0, slot1, slot2)
end

function slot0.updatePos(slot0, slot1, slot2)
	slot0._srcY = slot0._target.mo.posY
	slot0._srcX = slot0._target.mo.posX
	slot0._target.mo.posX = slot1
	slot0._target.mo.posY = slot2
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4)
	if slot0._target.avatar then
		slot6 = ChessGameHelper.nodePosToWorldPos({
			z = 0,
			x = slot1,
			y = slot2
		})

		slot0:killMoveTween()

		slot0._moveCallback = slot3
		slot0._moveCallbackObj = slot4
		slot0._isMoving = true
		slot0._tweenIdMoveScene = ZProj.TweenHelper.DOLocalMove(slot0._target.avatar.sceneTf, slot6.x, slot6.y, slot6.z, 0.225, slot0.onMoveCompleted, slot0, nil, EaseType.Linear)

		slot0:onMoveBegin()
		slot0:faceTo(ChessGameHelper.ToDirection(slot0._srcX or slot0._target.mo.posX, slot0._srcY or slot0._target.mo.posY, slot1, slot2))
		slot0:_setDirNodeShow(false)
	elseif slot3 then
		slot3(slot4)
	end
end

function slot0.faceTo(slot0, slot1)
	slot0._curDir = slot1

	if slot0._target.avatar then
		if not ChessInteractComp.DirectionSet[slot0._curDir] then
			return
		end

		for slot5, slot6 in ipairs(ChessInteractComp.DirectionList) do
			if not gohelper.isNil(slot0._target.avatar["goFaceTo" .. slot6]) then
				gohelper.setActive(slot7, slot1 == slot6)
			end

			if not gohelper.isNil(slot0._target.avatar["goMovetoDir" .. slot6]) then
				gohelper.setActive(slot8, slot1 == slot6)
			end
		end

		if slot0._target.mo then
			slot0._target.mo:setDirection(slot1)
		end
	end

	if slot0._target.chessEffectObj and slot0._target.chessEffectObj.refreshEffectFaceTo then
		slot0._target.chessEffectObj:refreshEffectFaceTo()
	end
end

function slot0._setDirNodeShow(slot0, slot1)
	if slot0._target.avatar and not gohelper.isNil(slot0._target.avatar.goNextDirection) then
		gohelper.setActive(slot2, slot1)
	end
end

function slot0.onMoveBegin(slot0)
end

function slot0.onMoveCompleted(slot0)
	slot0:_setDirNodeShow(true)
	slot0:refreshAlarmArea()

	if slot0._moveCallback then
		slot0._moveCallback = nil
		slot0._moveCallbackObj = nil
		slot0._isMoving = false

		slot0._moveCallback(slot0._moveCallbackObj)
	end
end

function slot0.onDrawAlert(slot0, slot1)
end

function slot0.setAlertActive(slot0, slot1)
end

function slot0.refreshAlarmArea(slot0)
end

function slot0.onAvatarLoaded(slot0)
	if (slot0._curDir or slot0._target.mo.direction or slot0._target.mo:getConfig().dir) ~= nil and slot1 ~= 0 then
		slot0:faceTo(slot1)
	end

	if not slot0._target.avatar.loader then
		return
	end

	if not gohelper.isNil(slot2:getInstGO()) then
		slot0._animSelf = slot3:GetComponent(typeof(UnityEngine.Animator))
	end
end

function slot0.showDestoryAni(slot0, slot1, slot2)
	if slot0._animSelf then
		slot0._animSelf:Update(0)
		slot0._animSelf:Play("close", 0, 0)

		slot0._closeAnimCallback = slot1
		slot0._closeAnimCallbackObj = slot2

		TaskDispatcher.runDelay(slot0._closeAnimCallback, slot0._closeAnimCallbackObj, ChessGameEnum.CloseAnimTime)
	else
		slot1(slot2)
	end
end

function slot0.killMoveTween(slot0)
	if slot0._tweenIdMoveScene then
		ZProj.TweenHelper.KillById(slot0._tweenIdMoveScene)

		slot0._tweenIdMoveScene = nil
	end
end

function slot0.dispose(slot0)
	slot0:killMoveTween()
	TaskDispatcher.cancelTask(slot0._closeAnimCallback, slot0._closeAnimCallbackObj, ChessGameEnum.CloseAnimTime)
end

return slot0
