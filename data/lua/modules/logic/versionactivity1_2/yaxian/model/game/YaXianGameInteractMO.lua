module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameInteractMO", package.seeall)

slot0 = pureTable("YaXianGameInteractMO")

function slot0.init(slot0, slot1, slot2)
	slot0.actId = slot1

	slot0:updateMO(slot2)
end

function slot0.updateMO(slot0, slot1)
	slot0.id = slot1.id

	slot0:setXY(slot1.x, slot1.y)
	slot0:setDirection(slot1.direction)

	slot0.config = YaXianConfig.instance:getInteractObjectCo(slot0.actId, slot0.id)

	slot0:updateDataByJsonData(slot1.data)
end

function slot0.updateDataByJsonData(slot0, slot1)
	if slot1 then
		slot0.data = cjson.decode(slot1)
	else
		slot0.data = nil
	end

	slot0:updateAlertArea()
	slot0:updateNextPos()
end

function slot0.updateDataByTableData(slot0, slot1)
	slot0.data = slot1

	slot0:updateAlertArea()
	slot0:updateNextPos()
end

function slot0.updateAlertArea(slot0)
	if not slot0.data then
		slot0.alertPosList = nil

		return
	end

	if not slot0.data.alertArea then
		slot0.alertPosList = nil

		return
	end

	slot0.alertPosList = {}

	for slot4, slot5 in ipairs(slot0.data.alertArea) do
		table.insert(slot0.alertPosList, {
			posX = slot5.x,
			posY = slot5.y
		})
	end
end

function slot0.updateNextPos(slot0)
	if not slot0.data then
		slot0.nextPos = nil

		return
	end

	if not slot0.data.nextPoint then
		slot0.nextPos = nil

		return
	end

	slot0.nextPos = {
		posX = slot0.data.nextPoint.x,
		posY = slot0.data.nextPoint.y
	}
end

function slot0.setXY(slot0, slot1, slot2)
	slot0.prePosX = slot0.posX
	slot0.prePosY = slot0.posY
	slot0.posX = slot1
	slot0.posY = slot2
end

function slot0.setDirection(slot0, slot1)
	slot0.preDirection = slot0.direction
	slot0.direction = slot1
end

return slot0
