module("modules.logic.chessgame.model.ChessGameInteractMo", package.seeall)

slot0 = class("ChessGameInteractMo")

function slot0.init(slot0, slot1, slot2)
	slot0:setCo(slot1)
	slot0:setMo(slot2)
end

function slot0.setCo(slot0, slot1)
	slot0.config = slot1
	slot0.interactType = slot1.interactType
	slot0.path = slot1.path
	slot0.walkable = slot1.walkable
	slot0.show = slot1.show
	slot0.canMove = slot1.canMove
	slot0.touchTrigger = slot1.touchTrigger
	slot0.iconType = slot1.iconType
	slot0.posX = slot1.x
	slot0.posY = slot1.y
	slot0.direction = slot1.dir
end

function slot0.setMo(slot0, slot1)
	slot0.id = slot1.id
	slot0.direction = slot1.direction or slot1.dir or slot0.config.dir
	slot0.show = slot1.show
	slot0.triggerByClick = slot1.triggerByclick
	slot0.mapIndex = slot1.mapIndex
	slot0.posX = slot1.posX or slot1.x or slot0.config.x
	slot0.posY = slot1.posY or slot1.y or slot0.config.y

	if slot1.attrMap then
		slot0:setIsFinsh(slot1.attrMap)
	end

	slot0:setParamStr(slot1.attrData)
end

function slot0.isShow(slot0)
	return slot0.show
end

function slot0.getConfig(slot0)
	return slot0.config
end

function slot0.getId(slot0)
	return slot0.id or slot0:getConfig().id
end

function slot0.getInteractTypeName(slot0)
	return ChessGameEnum.InteractTypeToName[slot0.interactType]
end

function slot0.setDirection(slot0, slot1)
	slot0.direction = slot1
end

function slot0.getDirection(slot0)
	return slot0.direction
end

function slot0.setXY(slot0, slot1, slot2)
	slot0.posX = slot1
	slot0.posY = slot2
end

function slot0.getXY(slot0)
	return slot0.posX, slot0.posY
end

function slot0.setParamStr(slot0, slot1)
	if string.nilorempty(slot1) then
		return
	end

	if cjson.decode(slot1) then
		slot0.isFinish = slot2.Completed
	end
end

function slot0.setIsFinsh(slot0, slot1)
	if slot1 then
		slot0.isFinish = slot1.Completed
	end
end

function slot0.CheckInteractFinish(slot0)
	return slot0.isFinish
end

function slot0.isInCurrentMap(slot0)
	return slot0.mapIndex == ChessGameModel.instance:getNowMapIndex()
end

function slot0.checkWalkable(slot0)
	return slot0.isWalkable and not slot0.show
end

function slot0.getEffectType(slot0)
	return slot0.iconType
end

return slot0
