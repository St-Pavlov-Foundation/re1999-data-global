-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillTargetBase.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillTargetBase", package.seeall)

local ArcadeSkillTargetBase = class("ArcadeSkillTargetBase", ArcadeSkillClass)

function ArcadeSkillTargetBase:ctor()
	ArcadeSkillTargetBase.super.ctor(self)

	self._targetList = {}
	self._targetIdDict = {}
	self._targetTypeList = {
		ArcadeGameEnum.EntityType.Monster
	}

	self:tryCallFunc(self.onCtor)
end

function ArcadeSkillTargetBase:setTargetConfig(cfg)
	self._config = cfg
	self._isIgnoreSelf = false

	if cfg then
		if not string.nilorempty(cfg.targets) then
			self._targetTypeList = string.split(cfg.targets, "#")
		end

		if not string.nilorempty(cfg.effect) then
			self._effectParams = string.split(cfg.effect, "#")
		end

		if cfg.ignoreSelf == 1 then
			self._isIgnoreSelf = true
		end
	end

	self:tryCallFunc(self.onConfigParams)
end

function ArcadeSkillTargetBase:setTargetTypeList(targetTypeList)
	self._targetTypeList = targetTypeList
end

function ArcadeSkillTargetBase:getTargetTypeList()
	return self._targetTypeList
end

function ArcadeSkillTargetBase:setRadius(radius)
	self._radius = tonumber(radius) or 0
end

function ArcadeSkillTargetBase:findTarget(gridX, gridY, direction)
	self.gridX = gridX
	self.gridY = gridY
	self.direction = direction
	self._context = nil

	self:tryCallFunc(self.onClearTarget)
	self:tryCallFunc(self.onFindTarget)
end

function ArcadeSkillTargetBase:findByContext(context)
	self.gridX, self.gridY = context.target:getGridPos()
	self.sizeX, self.sizeY = context.target:getSize()
	self.direction = context.target:getDirection()
	self._context = context

	self:tryCallFunc(self.onClearTarget)
	self:tryCallFunc(self.onFindTarget)

	if self._isIgnoreSelf == true and #self._targetList > 0 and self._context and self._context.target then
		tabletool.removeValue(self._targetList, self._context.target)
	end

	self:tryCallFunc(self.onFindTarget)
end

function ArcadeSkillTargetBase:onClearTarget()
	if self._targetList and #self._targetList > 0 or self._isAddNewTarget then
		self._isAddNewTarget = false

		self:clearList(self._targetList)
		self:clearTable(self._targetIdDict)
	end
end

function ArcadeSkillTargetBase:onFindTarget()
	return
end

function ArcadeSkillTargetBase:onConfigParams()
	return
end

function ArcadeSkillTargetBase:onCtor()
	return
end

function ArcadeSkillTargetBase:addTarget(target)
	if not target or target:getIsDead() then
		return
	end

	local uid = target:getUid()
	local gridX, gridY = target:getGridPos()

	if ArcadeGameHelper.isOutSideRoom(gridX, gridY) then
		return
	end

	if not self._targetIdDict[uid] then
		table.insert(self._targetList, target)

		self._targetIdDict[uid] = true
		self._isAddNewTarget = true
	end
end

function ArcadeSkillTargetBase:isHasTarget(target)
	if target then
		local uid = target:getUid()

		if self._targetIdDict[uid] then
			return true
		end
	end

	return false
end

function ArcadeSkillTargetBase:getTargetList()
	return self._targetList
end

function ArcadeSkillTargetBase:getMainTarget()
	return self._targetList[1]
end

function ArcadeSkillTargetBase:getTargetByXY(x, y)
	return
end

function ArcadeSkillTargetBase:getTargetByUid(uid)
	return
end

function ArcadeSkillTargetBase:findUnitMOByRectXY(minX, maxX, minY, maxY)
	if self._targetTypeList and #self._targetTypeList > 0 then
		for _, targetType in ipairs(self._targetTypeList) do
			if targetType == ArcadeGameEnum.EntityType.Character then
				self:_checkAddUnitMOXY(minX, maxX, minY, maxY, ArcadeGameModel.instance:getCharacterMO())
			elseif targetType == ArcadeGameEnum.EntityType.Grid then
				self:_checkAddUnitMOListXY(minX, maxX, minY, maxY, ArcadeGameModel.instance:getGridMOList())
			else
				local unitMOList = ArcadeGameModel.instance:getEntityMOList(targetType)

				self:_checkAddUnitMOListXY(minX, maxX, minY, maxY, unitMOList)
			end
		end
	else
		local masterMOList = ArcadeGameModel.instance:getMonsterList()

		self._findUnitMOByRectXY(minX, maxX, minY, maxY, masterMOList)
	end
end

function ArcadeSkillTargetBase:_checkAddUnitMOListXY(minX, maxX, minY, maxY, unitMOList)
	if not unitMOList or #unitMOList <= 0 then
		return
	end

	for _, unitMO in ipairs(unitMOList) do
		self:_checkAddUnitMOXY(minX, maxX, minY, maxY, unitMO)
	end
end

function ArcadeSkillTargetBase:_checkAddUnitMOXY(minX, maxX, minY, maxY, unitMO)
	if unitMO then
		local bMinX, bMaxX, bMinY, bMaxY = self:getUnitMORectXY(unitMO)

		if self:isRectXYIntersect(minX, maxX, minY, maxY, bMinX, bMaxX, bMinY, bMaxY) then
			self:addTarget(unitMO)
		end
	end
end

function ArcadeSkillTargetBase:isRectXYIntersect(minX, maxX, minY, maxY, bMinX, bMaxX, bMinY, bMaxY)
	if math.max(minX, bMinX) <= math.min(maxX, bMaxX) and math.max(minY, bMinY) <= math.min(maxY, bMaxY) then
		return true
	end
end

function ArcadeSkillTargetBase:isCheckUnitMOByRectXY(unitMO, minX, maxX, minY, maxY)
	local bMinX, bMaxX, bMinY, bMaxY = self:getUnitMORectXY(unitMO)

	if self:isRectXYIntersect(minX, maxX, minY, maxY, bMinX, bMaxX, bMinY, bMaxY) then
		return true
	end
end

function ArcadeSkillTargetBase:getUnitMORectXY(unitMO)
	local gridX, gridY = unitMO:getGridPos()
	local sizeX, sizeY = unitMO:getSize()
	local gMaxX = gridX
	local gMaxY = gridY

	if sizeX and sizeX > 1 then
		gMaxX = gridX + sizeX - 1
	end

	if sizeY and sizeY > 1 then
		gMaxY = gridY + sizeY - 1
	end

	return gridX, gMaxX, gridY, gMaxY
end

return ArcadeSkillTargetBase
