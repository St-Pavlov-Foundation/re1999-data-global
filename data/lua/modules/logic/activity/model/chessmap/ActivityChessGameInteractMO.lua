module("modules.logic.activity.model.chessmap.ActivityChessGameInteractMO", package.seeall)

slot0 = pureTable("ActivityChessGameInteractMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot2.id
	slot0.actId = slot1

	slot0:updateMO(slot2)
end

function slot0.updateMO(slot0, slot1)
	slot0.posX = slot1.x
	slot0.posY = slot1.y
	slot0.direction = slot1.direction or 6

	if not string.nilorempty(slot1.data) then
		slot0.data = cjson.decode(slot1.data)
	end
end

function slot0.setXY(slot0, slot1, slot2)
	slot0.posX = slot1
	slot0.posY = slot2
end

return slot0
