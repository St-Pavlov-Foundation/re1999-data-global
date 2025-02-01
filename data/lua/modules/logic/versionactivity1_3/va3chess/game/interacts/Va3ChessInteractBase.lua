module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractBase", package.seeall)

slot0 = class("Va3ChessInteractBase")

function slot0.init(slot0, slot1)
	slot0._target = slot1
end

function slot0.onSelectCall(slot0)
end

function slot0.onCancelSelect(slot0)
end

function slot0.onSelectPos(slot0, slot1, slot2)
end

function slot0.updatePos(slot0, slot1, slot2)
	slot0._srcY = slot0._target.originData.posY
	slot0._srcX = slot0._target.originData.posX
	slot0._target.originData.posX = slot1
	slot0._target.originData.posY = slot2
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4)
	if slot0._target.avatar and slot0._target.avatar.sceneTf then
		slot5, slot6, slot7 = Va3ChessGameController.instance:calcTilePosInScene(slot1, slot2, slot0._target.avatar.order, true)

		slot0:killMoveTween()

		slot0._moveCallback = slot3
		slot0._moveCallbackObj = slot4
		slot0._tweenIdMoveScene = ZProj.TweenHelper.DOLocalMove(slot0._target.avatar.sceneTf, slot5, slot6, slot7, 0.225, slot0.onMoveCompleted, slot0, nil, EaseType.Linear)

		slot0:onMoveBegin()
		slot0:faceTo(Va3ChessMapUtils.ToDirection(slot0._srcX, slot0._srcY, slot1, slot2))
		slot0:_setDirNodeShow(false)
	elseif slot3 then
		slot3(slot4)
	end
end

function slot0.faceTo(slot0, slot1)
	slot0._curDir = slot1

	if slot0._target.avatar then
		if not Va3ChessInteractObject.DirectionSet[slot0._curDir] then
			return
		end

		for slot5, slot6 in ipairs(Va3ChessInteractObject.DirectionList) do
			if not gohelper.isNil(slot0._target.avatar["goFaceTo" .. slot6]) then
				gohelper.setActive(slot7, slot1 == slot6)
			end

			if not gohelper.isNil(slot0._target.avatar["goMovetoDir" .. slot6]) then
				gohelper.setActive(slot8, slot1 == slot6)
			end
		end

		if slot0._target.originData then
			slot0._target.originData:setDirection(slot1)
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

	if slot0._moveCallback then
		slot0._moveCallback = nil
		slot0._moveCallbackObj = nil

		slot0._moveCallback(slot0._moveCallbackObj)
	end
end

function slot0.onDrawAlert(slot0, slot1)
end

function slot0.setAlertActive(slot0, slot1)
end

function slot0.onAvatarLoaded(slot0)
	if (slot0._curDir or slot0._target.originData.direction) ~= nil and slot1 ~= 0 then
		slot0:faceTo(slot1)
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
end

return slot0
