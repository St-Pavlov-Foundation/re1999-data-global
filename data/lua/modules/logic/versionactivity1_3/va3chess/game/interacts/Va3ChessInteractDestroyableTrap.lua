module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractDestroyableTrap", package.seeall)

slot0 = class("Va3ChessInteractDestroyableTrap", Va3ChessInteractBase)

function slot0.showStateView(slot0, slot1, slot2)
	if slot1 == Va3ChessEnum.ObjState.Idle then
		slot0:showIdleStateView()
	elseif slot1 == Va3ChessEnum.ObjState.Interoperable then
		slot0:showInteroperableStateView(slot2)
	end
end

function slot0.showIdleStateView(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmAreaOnXY, slot0._target.originData.posX, slot0._target.originData.posY, false)
end

function slot0.showInteroperableStateView(slot0, slot1)
	if slot1.objType == Va3ChessEnum.InteractType.Player then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmAreaOnXY, slot0._target.originData.posX, slot0._target.originData.posY, true)
	end
end

function slot0.playDeleteObjView(slot0)
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.FireHurt)
end

function slot0.dispose(slot0)
	slot0:showIdleStateView()
	uv0.super.dispose(slot0)
end

return slot0
