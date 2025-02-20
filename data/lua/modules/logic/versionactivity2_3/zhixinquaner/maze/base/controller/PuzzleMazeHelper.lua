module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.controller.PuzzleMazeHelper", package.seeall)

slot0 = _M
slot1 = PuzzleEnum.dir.left
slot2 = PuzzleEnum.dir.right
slot3 = PuzzleEnum.dir.down
slot4 = PuzzleEnum.dir.up

function slot0.formatPos(slot0, slot1, slot2, slot3)
	if slot2 < slot0 then
		slot0 = slot0
	end

	if slot3 < slot1 then
		slot1 = slot1
	end

	return slot0, slot1, slot2, slot3
end

function slot0.getFromToDir(slot0, slot1, slot2, slot3)
	if slot0 ~= slot2 then
		if slot1 ~= slot3 then
			return nil
		end

		return slot0 < slot2 and uv0 or uv1
	else
		return slot1 < slot3 and uv2 or uv3
	end
end

function slot0.getPosKey(slot0, slot1)
	return string.format("%s_%s", slot0, slot1)
end

function slot0.getLineKey(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6, slot7 = uv0.formatPos(slot0, slot1, slot2, slot3)

	return string.format("%s_%s_%s_%s", slot4, slot5, slot6, slot7)
end

return slot0
