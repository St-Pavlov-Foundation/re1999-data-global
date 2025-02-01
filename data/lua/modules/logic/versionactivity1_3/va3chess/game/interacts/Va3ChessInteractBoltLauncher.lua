module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractBoltLauncher", package.seeall)

slot0 = class("Va3ChessInteractBoltLauncher", Va3ChessInteractBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._enableAlarm = true
end

function slot0.onDrawAlert(slot0, slot1)
	if not slot0._enableAlarm then
		return
	end

	if not slot0._target.originData:getDirection() then
		return
	end

	slot5, slot6 = Va3ChessGameModel.instance:getGameSize()
	slot9 = slot2 == Va3ChessEnum.Direction.Up
	slot4 = (slot9 or slot2 == Va3ChessEnum.Direction.Down) and (slot9 and slot6 - 1 or slot0._target.originData.posY - 1) or slot2 == Va3ChessEnum.Direction.Right and slot5 - 1 or slot0._target.originData.posX - 1

	if nil < 0 or slot4 < 0 then
		return
	end

	if slot4 < slot3 then
		logError(string.format("Va3ChessInteractBoltLauncher:onDrawAlert target error,interactId:%s beginPos:%s endPos:%s", slot0._target.id, slot3, slot4))

		return
	end

	if slot9 or slot10 then
		for slot15 = slot3, slot4 do
			if slot15 == slot3 then
				table.insert({
					Va3ChessEnum.Direction.Left,
					Va3ChessEnum.Direction.Right
				}, Va3ChessEnum.Direction.Down)
			elseif slot15 == slot4 then
				table.insert(slot16, Va3ChessEnum.Direction.Up)
			end

			slot0:_insertToAlertMap(slot1, slot7, slot15, slot16)
		end
	else
		for slot15 = slot3, slot4 do
			if slot15 == slot3 then
				table.insert({
					Va3ChessEnum.Direction.Up,
					Va3ChessEnum.Direction.Down
				}, Va3ChessEnum.Direction.Left)
			elseif slot15 == slot4 then
				table.insert(slot16, Va3ChessEnum.Direction.Right)
			end

			slot0:_insertToAlertMap(slot1, slot15, slot8, slot16)
		end
	end
end

function slot0._insertToAlertMap(slot0, slot1, slot2, slot3, slot4)
	if Va3ChessGameModel.instance:isPosInChessBoard(slot2, slot3) and Va3ChessGameModel.instance:getBaseTile(slot2, slot3) ~= Va3ChessEnum.TileBaseType.None then
		slot1[slot2] = slot1[slot2] or {}
		slot1[slot2][slot3] = slot1[slot2][slot3] or {}

		table.insert(slot1[slot2][slot3], {
			isStatic = true,
			resPath = Va3ChessEnum.SceneResPath.AlarmItem2,
			showDirLine = slot4
		})
	end
end

function slot0.onAvatarLoaded(slot0)
	uv0.super.onAvatarLoaded(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function slot0.dispose(slot0)
	slot0._enableAlarm = false

	uv0.super.dispose(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return slot0
