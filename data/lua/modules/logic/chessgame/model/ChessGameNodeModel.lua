module("modules.logic.chessgame.model.ChessGameNodeModel", package.seeall)

slot0 = class("ChessGameNodeModel", BaseModel)

function slot0.onInit(slot0)
	slot0._nodes = {}
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.setNodeDatas(slot0, slot1)
	slot0._nodes = {}

	for slot5, slot6 in pairs(slot1) do
		ChessGameNodeMo.New():setNode(slot6)

		if not slot0._nodes[slot6.x] then
			slot0._nodes[slot6.x] = {}
		end

		slot0._nodes[slot6.x][slot6.y] = slot7
	end
end

function slot0.getNode(slot0, slot1, slot2)
	if not slot0._nodes[slot1] then
		return
	end

	return slot0._nodes[slot1][slot2]
end

function slot0.getAllNodes(slot0)
	return slot0._nodes
end

function slot0.clear(slot0)
	slot0._nodes = {}
end

slot0.instance = slot0.New()

return slot0
