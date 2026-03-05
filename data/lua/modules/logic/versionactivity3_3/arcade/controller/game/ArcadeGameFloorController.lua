-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeGameFloorController.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeGameFloorController", package.seeall)

local ArcadeGameFloorController = class("ArcadeGameFloorController", BaseController)
local __G__TRACKBACK__ = __G__TRACKBACK__
local xpcall = xpcall
local rawget = rawget

function ArcadeGameFloorController:onInit()
	return
end

function ArcadeGameFloorController:onInitFinish()
	return
end

function ArcadeGameFloorController:addConstEvents()
	return
end

function ArcadeGameFloorController:reInit()
	return
end

function ArcadeGameFloorController:tryAddFloor(floorId, gridX, gridY)
	if ArcadeGameHelper.isOutSideRoom(gridX, gridY) then
		return nil
	end

	local moData = {
		sizeY = 1,
		sizeX = 1,
		entityType = ArcadeGameEnum.EntityType.Floor,
		id = floorId,
		x = gridX,
		y = gridY
	}
	local floorMO = ArcadeGameModel.instance:addEntityMO(moData, true)

	if floorMO then
		local gameScent = ArcadeGameController.instance:getGameScene()

		if gameScent then
			gameScent.entityMgr:addEntityByList({
				floorMO
			})
		end
	end

	return floorMO
end

function ArcadeGameFloorController:tryAddFloorByList(dataList)
	if not dataList or #dataList < 1 then
		return
	end

	local entityType = ArcadeGameEnum.EntityType.Floor
	local floorMOList = ArcadeGameModel.instance:getEntityMOList(entityType)
	local ccupyDict

	if floorMOList and #floorMOList > 0 then
		ccupyDict = {}

		local gridX, gridY

		for _, floorMO in ipairs(floorMOList) do
			gridX, gridY = floorMO:getGridPos()

			local gridId = ArcadeGameHelper.getGridId(gridX, gridY)

			ccupyDict[gridId] = floorMO
		end
	end

	local removeUidList

	for i = #dataList, 1, -1 do
		local moData = dataList[i]
		local gridId = ArcadeGameHelper.getGridId(moData.x, moData.y)
		local isReset = false
		local floorMO = ccupyDict and ccupyDict[gridId]

		if floorMO then
			if floorMO:getId() == moData.id then
				isReset = true

				floorMO:setCdRound(0)
			else
				removeUidList = removeUidList or {}

				table.insert(removeUidList, floorMO:getUid())
			end
		end

		if isReset or ArcadeGameHelper.isOutSideRoom(moData.x, moData.y) then
			table.remove(dataList, i)
		else
			moData.sizeX = 1
			moData.sizeY = 1
			moData.entityType = entityType
		end
	end

	if removeUidList and #removeUidList > 0 then
		for _, floorUid in ipairs(removeUidList) do
			ArcadeGameController.instance:removeEntity(entityType, floorUid)
		end
	end

	local moList = ArcadeGameModel.instance:addEntityMOByList(dataList, true)

	logNormal(string.format(" ArcadeGameFloorController:tryAddFloorByList %s %s", #dataList, #moList))

	if moList and #moList > 0 then
		local gameScent = ArcadeGameController.instance:getGameScene()

		if gameScent then
			gameScent.entityMgr:addEntityByList(moList)
		end
	end

	return moList
end

ArcadeGameFloorController.instance = ArcadeGameFloorController.New()

return ArcadeGameFloorController
