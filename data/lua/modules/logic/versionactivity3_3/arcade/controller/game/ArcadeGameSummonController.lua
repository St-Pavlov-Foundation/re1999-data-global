-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeGameSummonController.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeGameSummonController", package.seeall)

local ArcadeGameSummonController = class("ArcadeGameSummonController", BaseController)
local __G__TRACKBACK__ = __G__TRACKBACK__
local xpcall = xpcall
local rawget = rawget

function ArcadeGameSummonController:onInit()
	return
end

function ArcadeGameSummonController:onInitFinish()
	return
end

function ArcadeGameSummonController:addConstEvents()
	return
end

function ArcadeGameSummonController:reInit()
	return
end

function ArcadeGameSummonController:summonMonsterList(monsterIdList, delayTimeShow)
	RoomHelper.randomArray(self:getGridList())

	return self:_summonEntityByIdList(monsterIdList, ArcadeGameEnum.EntityType.Monster, delayTimeShow)
end

function ArcadeGameSummonController:summonBombList(bombIdList, delayTimeShow)
	RoomHelper.randomArray(self:getGridList())

	return self:_summonEntityByIdList(bombIdList, ArcadeGameEnum.EntityType.Bomb, delayTimeShow)
end

function ArcadeGameSummonController:summonInteractiveList(interactiveIdList, isNotRandom, delayTimeShow)
	if isNotRandom ~= true then
		RoomHelper.randomArray(self:getGridList())
	end

	return self:_summonEntityByIdList(interactiveIdList, ArcadeGameEnum.EntityType.BaseInteractive, delayTimeShow)
end

function ArcadeGameSummonController:_summonEntityByIdList(idList, entityType, delayTimeShow)
	local unitMOList = self:getRoomUnitMOList()
	local useGridIdMap = {}
	local entityDataList = {}

	for _, entityId in ipairs(idList) do
		local sizeX, sizeY = self:_getEntitySize(entityId, entityType)
		local gridX, gridY = self:_tryfindSizeGridXY(sizeX, sizeY, unitMOList, useGridIdMap)

		if gridX and gridY then
			entityDataList[#entityDataList + 1] = {
				id = entityId,
				x = gridX,
				y = gridY,
				sizeX = sizeX,
				sizeY = sizeY,
				entityType = entityType,
				extraParam = {
					groupId = 0
				},
				delayTimeShow = delayTimeShow
			}

			self:_addUseGrid(gridX, gridY, sizeX, sizeY, useGridIdMap)
		end
	end

	ArcadeGameController.instance:tryAddEntityList(entityDataList, true)

	return entityDataList
end

function ArcadeGameSummonController:_getOtherEntityTypeList()
	if not self._otherEntityTypeList then
		self._otherEntityTypeList = {}

		for _, eType in pairs(ArcadeGameEnum.EntityType) do
			if not ArcadeGameEnum.EntityTypeNotOccupyDict[eType] and eType ~= ArcadeGameEnum.EntityType.Grid and eType ~= ArcadeGameEnum.EntityType.Monster and eType ~= ArcadeGameEnum.EntityType.Character then
				table.insert(self._otherEntityTypeList, eType)
			end
		end
	end

	return self._otherEntityTypeList
end

function ArcadeGameSummonController:getRoomUnitMOList()
	local unitMOList = {}
	local tArcadeGameModel = ArcadeGameModel.instance

	self:_addUnitMOList(unitMOList, tArcadeGameModel:getEntityMOList(ArcadeGameEnum.EntityType.Monster))

	local curRoom = ArcadeGameController.instance:getCurRoom()

	for i = #unitMOList, 1, -1 do
		local unitMO = unitMOList[i]
		local gridX, gridY = unitMO:getGridPos()
		local occupyEntityData = curRoom:getEntityDataInTargetGrid(gridX, gridY)

		if not occupyEntityData then
			table.remove(unitMOList, i)
		end
	end

	table.insert(unitMOList, tArcadeGameModel:getCharacterMO())

	local enTypeList = self:_getOtherEntityTypeList()

	for _, entityType in ipairs(enTypeList) do
		self:_addUnitMOList(unitMOList, tArcadeGameModel:getEntityMOList(entityType))
	end

	return unitMOList
end

function ArcadeGameSummonController:_addUnitMOList(trageMOList, unitMOList)
	if trageMOList and unitMOList and #unitMOList > 0 then
		for _, unitMO in ipairs(unitMOList) do
			local gridX, gridY = unitMO:getGridPos()

			if not ArcadeGameHelper.isOutSideRoom(gridX, gridY) then
				trageMOList[#trageMOList + 1] = unitMO
			end
		end
	end
end

function ArcadeGameSummonController:_getEntitySize(id, entityType)
	if not self._entitySizeFuncDict then
		self._entitySizeFuncDict = {
			[ArcadeGameEnum.EntityType.Monster] = function(monsterId)
				return ArcadeConfig.instance:getMonsterSize(monsterId)
			end,
			[ArcadeGameEnum.EntityType.Bomb] = function(bombId)
				return 1, 1
			end,
			[ArcadeGameEnum.EntityType.BaseInteractive] = function(interactiveId)
				return ArcadeConfig.instance:getInteractiveGrid(interactiveId)
			end
		}
	end

	local func = self._entitySizeFuncDict[entityType]

	if func then
		return func(id)
	end

	return 1, 1
end

function ArcadeGameSummonController:summonMonster(monsterId)
	local cfg = ArcadeConfig.instance:getMonsterCfg(monsterId)

	if not cfg then
		return false
	end

	RoomHelper.randomArray(self:getGridList())

	local sizeX, sizeY = ArcadeConfig.instance:getMonsterSize(monsterId)
	local unitMOList = self:getRoomUnitMOList()
	local gridX, gridY = self:_tryfindSizeGridXY(sizeX, sizeY, unitMOList)

	if gridX and gridY then
		local entityData = {
			id = monsterId,
			x = gridX,
			y = gridY,
			sizeX = sizeX,
			sizeY = sizeY,
			entityType = ArcadeGameEnum.EntityType.Monster,
			extraParam = {
				groupId = 0
			}
		}

		ArcadeGameController.instance:tryAddEntityList({
			entityData
		}, true)

		return true, gridX, gridY
	end

	return false
end

function ArcadeGameSummonController:summonMonsterByXY(monsterId, gridX, gridY)
	local cfg = ArcadeConfig.instance:getMonsterCfg(monsterId)

	if not cfg then
		return false
	end

	local sizeX, sizeY = ArcadeConfig.instance:getMonsterSize(monsterId)
	local unitMOList = self:getRoomUnitMOList()

	if self:checkSizeGridXY(gridX, gridY, sizeX, sizeY, unitMOList) then
		local entityData = {
			id = monsterId,
			x = gridX,
			y = gridY,
			sizeX = sizeX,
			sizeY = sizeY,
			entityType = ArcadeGameEnum.EntityType.Monster,
			extraParam = {
				groupId = 0
			}
		}

		ArcadeGameController.instance:tryAddEntityList({
			entityData
		}, true)

		return true, gridX, gridY
	end

	return false
end

function ArcadeGameSummonController:getGridList()
	if not self._gridList then
		local maxGrid = ArcadeGameEnum.Const.RoomSize

		self._gridList = {}

		for x = 1, maxGrid do
			for y = 1, maxGrid do
				table.insert(self._gridList, {
					x = x,
					y = y
				})
			end
		end
	end

	return self._gridList
end

function ArcadeGameSummonController:getNearGirdList(gridX, gridY, sizeX, sizeY)
	local gridList = self:getGridList()
	local maxGX = gridX + sizeX - 1
	local maxGY = gridY + sizeY - 1

	for _i, grid in ipairs(gridList) do
		local x = grid.x
		local y = grid.y

		if ArcadeGameHelper.isRectXYIntersect(x, x, y, y, gridX, maxGX, gridY, maxGY) then
			grid.dir = 0
		else
			grid.dir = math.max(math.abs(x - maxGX), math.abs(x - gridX)) + math.max(math.abs(y - maxGY), math.abs(y - gridY))
		end
	end

	table.sort(gridList, ArcadeGameSummonController._nearGirdSort)

	return gridList
end

function ArcadeGameSummonController._nearGirdSort(a, b)
	if a.dir ~= b.dir then
		return a.dir < b.dir
	end
end

function ArcadeGameSummonController:_tryfindSizeGridXY(sizeX, sizeY, unitMOList, useGridIdMap)
	local gridList = self:getGridList()

	for _i, grid in ipairs(gridList) do
		local x = grid.x
		local y = grid.y

		if not self:_chechUseGrid(x, y, useGridIdMap) and self:checkSizeGridXY(x, y, sizeX, sizeY, unitMOList) then
			return x, y
		end
	end

	return nil, nil
end

function ArcadeGameSummonController:_chechUseGrid(gridX, gridY, useGridIdMap)
	if useGridIdMap then
		local gridId = ArcadeGameHelper.getGridId(gridX, gridY)

		if useGridIdMap[gridId] then
			return true
		end
	end

	return false
end

function ArcadeGameSummonController:_addUseGrid(gridX, gridY, sizeX, sizeY, useGridIdMap)
	sizeX = math.max(1, sizeX)
	sizeY = math.max(1, sizeY)

	for x = 1, sizeX do
		for y = 1, sizeY do
			local gridId = ArcadeGameHelper.getGridId(gridX + x - 1, gridY + y - 1)

			useGridIdMap[gridId] = true
		end
	end
end

function ArcadeGameSummonController:checkSizeGridXY(x, y, sizeX, sizeY, unitMOList)
	local maxGrid = ArcadeGameEnum.Const.RoomSize
	local maxX = maxGrid - sizeX + 1
	local maxY = maxGrid - sizeY + 1

	if x >= 1 and x <= maxX and y >= 1 and y <= maxY then
		local flag = true
		local gx, gy, gsx, gsy = 0, 0, 0, 0

		for _, unitMO in ipairs(unitMOList) do
			gx, gy = unitMO:getGridPos()
			gsx, gsy = unitMO:getSize()

			if ArcadeGameHelper.isRectXYIntersect(x, x + sizeX - 1, y, y + sizeY - 1, gx, gx + gsx - 1, gy, gy + gsy - 1) then
				flag = false

				break
			end
		end

		return flag
	end

	return false
end

ArcadeGameSummonController.instance = ArcadeGameSummonController.New()

return ArcadeGameSummonController
