-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/cond/ArcadeSkillCondNotInSpecifyFloor.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.cond.ArcadeSkillCondNotInSpecifyFloor", package.seeall)

local ArcadeSkillCondNotInSpecifyFloor = class("ArcadeSkillCondNotInSpecifyFloor", ArcadeSkillCondInSpecifyFloor)

function ArcadeSkillCondNotInSpecifyFloor:onIsCondSuccess()
	local target = self._context.specTargetEntityMO or self._context.target

	if not target then
		return
	end

	local sizeX, sizeY = target:getSize()
	local gridX, gridY = target:getGridPos()
	local checkGridX = self._context.specTargetGridX or gridX
	local checkGridY = self._context.specTargetGridY or gridY
	local isOnFloor, hitGridX, hitGridY = self:_checkOnSpecifyFloor(sizeX, sizeY, checkGridX, checkGridY)

	if isOnFloor then
		logNormal(string.format("%s:isCondSuccess() == > 不处于指定地块：false floorId=%s target={entityType:%s,uid:%s,pos:(%s,%s),size:(%s,%s)} hitGrid=(%s,%s)", self.__cname, self._floorId, target:getEntityType(), target:getUid(), checkGridX, checkGridY, sizeX, sizeY, hitGridX, hitGridY))
	else
		logNormal(string.format("%s:isCondSuccess() == > 不处于指定地块：true floorId=%s target={entityType:%s,uid:%s,pos:(%s,%s),size:(%s,%s)}", self.__cname, self._floorId, target:getEntityType(), target:getUid(), checkGridX, checkGridY, sizeX, sizeY))
	end

	return not isOnFloor
end

return ArcadeSkillCondNotInSpecifyFloor
