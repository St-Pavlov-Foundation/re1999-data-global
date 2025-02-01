module("modules.logic.versionactivity1_2.yaxian.controller.game.interacts.YaXianInteractTriggerFailHandle", package.seeall)

slot0 = class("YaXianInteractTriggerFailHandle", YaXianInteractHandleBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._enableAlarm = true
end

function slot0.onDrawAlert(slot0, slot1)
	if not slot0._enableAlarm then
		return
	end

	slot2 = slot0._target.originData.posX
	slot3 = slot0._target.originData.posY

	uv0.insertToAlertMap(slot1, slot2 + 1, slot3)
	uv0.insertToAlertMap(slot1, slot2 - 1, slot3)
	uv0.insertToAlertMap(slot1, slot2, slot3 + 1)
	uv0.insertToAlertMap(slot1, slot2, slot3 - 1)
end

function slot0.insertToAlertMap(slot0, slot1, slot2)
	if YaXianGameController.instance:posCanWalk(slot1, slot2) then
		slot0[slot1] = slot0[slot1] or {}
		slot0[slot1][slot2] = true
	end
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4)
	slot0._enableAlarm = false

	uv0.super.moveTo(slot0, slot1, slot2, slot3, slot4)
	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function slot0.onMoveCompleted(slot0)
	uv0.super.onMoveCompleted(slot0)

	slot0._enableAlarm = true

	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)
	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

function slot0.dispose(slot0)
	slot0._enableAlarm = false

	uv0.super.dispose(slot0)
	YaXianGameController.instance:dispatchEvent(ActivityChessEvent.RefreshAlarmArea)
end

return slot0
