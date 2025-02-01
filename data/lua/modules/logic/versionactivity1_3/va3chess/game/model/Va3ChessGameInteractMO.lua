module("modules.logic.versionactivity1_3.va3chess.game.model.Va3ChessGameInteractMO", package.seeall)

slot0 = pureTable("Va3ChessGameInteractMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot2.id
	slot0.actId = slot1

	slot0:updateMO(slot2)
end

function slot0.updateMO(slot0, slot1)
	slot0.posX = slot1.x
	slot0.posY = slot1.y
	slot0.direction = slot1.direction or 6

	if slot1.data and not string.nilorempty(slot1.data) then
		slot0.data = cjson.decode(slot1.data)
	end
end

function slot0.setXY(slot0, slot1, slot2)
	slot0.posX = slot1
	slot0.posY = slot2
end

function slot0.getXY(slot0)
	return slot0.posX, slot0.posY
end

function slot0.getPosIndex(slot0)
	return Va3ChessMapUtils.calPosIndex(slot0.posX, slot0.posY)
end

function slot0.getPedalStatusInDataField(slot0)
	if slot0.data then
		return slot0.data.pedalStatus
	end
end

function slot0.setPedalStatus(slot0, slot1)
	if slot0.data then
		slot0.data.pedalStatus = slot1
	end

	if Va3ChessGameController.instance.interacts:get(slot0.id) and slot2:getHandler().refreshPedalStatus then
		slot2:getHandler():refreshPedalStatus()
	end
end

function slot0.setBrazierIsLight(slot0, slot1)
	slot0._isLight = slot1
end

function slot0.getBrazierIsLight(slot0)
	return slot0._isLight or false
end

function slot0.setDirection(slot0, slot1)
	slot0.direction = slot1
end

function slot0.getDirection(slot0)
	return slot0.direction
end

function slot0.setHaveBornEff(slot0, slot1)
	slot0.haveBornEff = slot1
end

function slot0.getHaveBornEff(slot0)
	return slot0.haveBornEff
end

return slot0
