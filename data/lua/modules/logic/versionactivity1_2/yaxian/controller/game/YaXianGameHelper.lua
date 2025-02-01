module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianGameHelper", package.seeall)

slot0 = class("YaXianGameHelper")

function slot0.getRowStartPosInScene(slot0)
	return slot0 * YaXianGameEnum.TileSetting.halfWidth, -slot0 * YaXianGameEnum.TileSetting.halfHeight
end

function slot0.getPosZ(slot0)
	return Mathf.Lerp(YaXianGameEnum.LevelScenePosZRange.Min, YaXianGameEnum.LevelScenePosZRange.Max, (slot0 - YaXianGameEnum.ScenePosYRange.Min) / YaXianGameEnum.ScenePosYRangeArea)
end

function slot0.calcTilePosInScene(slot0, slot1)
	slot2, slot3 = uv0.getRowStartPosInScene(slot0)
	slot3 = slot3 + slot1 * YaXianGameEnum.TileSetting.halfHeight + YaXianGameModel.instance.mapOffsetY

	return slot2 + slot1 * YaXianGameEnum.TileSetting.halfWidth + YaXianGameModel.instance.mapOffsetX, slot3, uv0.getPosZ(slot3)
end

function slot0.calBafflePosInScene(slot0, slot1, slot2)
	slot3, slot4, slot5 = uv0.calcTilePosInScene(slot0, slot1)

	if slot2 == YaXianGameEnum.BaffleDirection.Left then
		slot3 = slot3 - YaXianGameEnum.TileSetting.baffleOffsetX
		slot4 = slot4 + YaXianGameEnum.TileSetting.baffleOffsetY
	elseif slot2 == YaXianGameEnum.BaffleDirection.Top then
		slot3 = slot3 + YaXianGameEnum.TileSetting.baffleOffsetX
		slot4 = slot4 + YaXianGameEnum.TileSetting.baffleOffsetY
	elseif slot2 == YaXianGameEnum.BaffleDirection.Right then
		slot3 = slot3 + YaXianGameEnum.TileSetting.baffleOffsetX
		slot4 = slot4 - YaXianGameEnum.TileSetting.baffleOffsetY
	elseif slot2 == YaXianGameEnum.BaffleDirection.Bottom then
		slot3 = slot3 - YaXianGameEnum.TileSetting.baffleOffsetX
		slot4 = slot4 - YaXianGameEnum.TileSetting.baffleOffsetY
	else
		logError("un support direction, please check ... " .. slot2)
	end

	return slot3, slot4, uv0.getPosZ(slot4)
end

function slot0.hasBaffle(slot0, slot1)
	return bit.band(slot0, bit.lshift(1, slot1)) ~= 0
end

function slot0.getBaffleType(slot0, slot1)
	return bit.band(slot0, bit.lshift(1, slot1 - 1)) == 0 and 0 or 1
end

function slot0.canBlock(slot0)
	if slot0 then
		return slot0.interactType == YaXianGameEnum.InteractType.Obstacle or slot0.interactType == YaXianGameEnum.InteractType.TriggerFail or slot0.interactType == YaXianGameEnum.InteractType.Player
	end

	return false
end

function slot0.canSelect(slot0)
	return slot0 and slot0.interactType == YaXianGameEnum.InteractType.Player
end

function slot0.getDirection(slot0, slot1, slot2, slot3)
	if slot0 ~= slot2 then
		if slot0 < slot2 then
			return YaXianGameEnum.MoveDirection.Right
		else
			return YaXianGameEnum.MoveDirection.Left
		end
	end

	if slot1 ~= slot3 then
		if slot1 < slot3 then
			return YaXianGameEnum.MoveDirection.Top
		else
			return YaXianGameEnum.MoveDirection.Bottom
		end
	end

	logError(string.format("get direction fail ... startX : %s, startY : %s, targetX : %s, targetY : %s", slot0, slot1, slot2, slot3))
end

function slot0.getNextPos(slot0, slot1, slot2)
	if slot2 == YaXianGameEnum.MoveDirection.Bottom then
		slot1 = slot1 - 1
	elseif slot2 == YaXianGameEnum.MoveDirection.Left then
		slot0 = slot0 - 1
	elseif slot2 == YaXianGameEnum.MoveDirection.Right then
		slot0 = slot0 + 1
	elseif slot2 == YaXianGameEnum.MoveDirection.Top then
		slot1 = slot1 + 1
	else
		logError(string.format("un support direction, x : %s, y : %s, direction : %s", slot0, slot1, slot2))
	end

	return slot0, slot1
end

function slot0.getPassPosGenerator(slot0, slot1, slot2, slot3)
	slot4 = uv0.getDirection(slot0, slot1, slot2, slot3)
	slot5 = false

	return function ()
		if uv0 then
			return nil
		end

		slot0, slot1 = uv1.getNextPos(uv2, uv3, uv4)

		if slot0 == uv5 and slot1 == uv6 then
			uv0 = true
		end

		uv3 = slot1
		uv2 = slot0

		return slot0, slot1
	end
end

function slot0.getPosHashKey(slot0, slot1)
	return slot0 .. "." .. slot1
end

return slot0
