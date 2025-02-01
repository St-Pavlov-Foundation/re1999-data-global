module("modules.logic.chessgame.model.ChessGameNodeMo", package.seeall)

slot0 = pureTable("ChessGameNodeMo")

function slot0.setNode(slot0, slot1)
	slot0.x = slot1.x
	slot0.y = slot1.y
	slot0.noWalkCount = 0
	slot0.noWalkCanDestoryCount = 0
end

function slot0.addNoWalkCount(slot0, slot1, slot2)
	if slot2 then
		slot0.noWalkCanDestoryCount = slot0.noWalkCanDestoryCount + slot1
	else
		slot0.noWalkCount = slot0.noWalkCount + slot1
	end
end

function slot0.isCanWalk(slot0, slot1)
	if slot0.noWalkCount > 0 then
		return false
	end

	if slot1 then
		return true
	else
		return slot0.noWalkCanDestoryCount > 0
	end
end

return slot0
