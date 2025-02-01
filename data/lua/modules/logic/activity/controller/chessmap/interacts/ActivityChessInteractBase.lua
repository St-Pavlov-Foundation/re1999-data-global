module("modules.logic.activity.controller.chessmap.interacts.ActivityChessInteractBase", package.seeall)

slot0 = class("ActivityChessInteractBase")

function slot0.init(slot0, slot1)
	slot0._target = slot1
end

function slot0.onSelectCall(slot0)
end

function slot0.onCancelSelect(slot0)
end

function slot0.onSelectPos(slot0, slot1, slot2)
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4)
	if slot0._target.avatar then
		slot0._target.originData.posX = slot1
		slot0._target.originData.posY = slot2
		slot7, slot8, slot9 = ActivityChessGameController.instance:calcTilePosInScene(slot1, slot2, slot0._target.avatar.order)

		slot0:killMoveTween()

		slot0._moveCallback = slot3
		slot0._moveCallbackObj = slot4
		slot0._tweenIdMoveScene = ZProj.TweenHelper.DOLocalMove(slot0._target.avatar.sceneTf, slot7, slot8, slot9, 0.3, slot0.onMoveCompleted, slot0, nil, EaseType.Linear)

		slot0:faceTo(ActivityChessMapUtils.ToDirection(slot0._target.originData.posX, slot0._target.originData.posY, slot1, slot2))
	elseif slot3 then
		slot3(slot4)
	end
end

function slot0.faceTo(slot0, slot1)
	slot0._curDir = slot1

	if slot0._target.avatar then
		if not ActivityChessInteractObject.DirectionSet[slot0._curDir] then
			return
		end

		for slot5, slot6 in ipairs(ActivityChessInteractObject.DirectionList) do
			if not gohelper.isNil(slot0._target.avatar["goFaceTo" .. slot6]) then
				gohelper.setActive(slot7, slot1 == slot6)
			end
		end
	end
end

function slot0.onMoveCompleted(slot0)
	if slot0._moveCallback then
		slot0._moveCallback = nil
		slot0._moveCallbackObj = nil

		slot0._moveCallback(slot0._moveCallbackObj)
	end
end

function slot0.onDrawAlert(slot0, slot1)
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
