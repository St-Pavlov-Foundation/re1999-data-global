-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/room/ArcadeInteractRoom.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.room.ArcadeInteractRoom", package.seeall)

local ArcadeInteractRoom = class("ArcadeInteractRoom", ArcadeBaseRoom)

function ArcadeInteractRoom:onCtor()
	return
end

function ArcadeInteractRoom:onEnter()
	return
end

function ArcadeInteractRoom:initEntities()
	local allInitEntityDataList = {}

	self:_fillInteractData(allInitEntityDataList)
	self:_fillInitPortalData(allInitEntityDataList)
	ArcadeGameController.instance:tryAddEntityList(allInitEntityDataList, true, false, self._initEntitiesFinished, self)
end

function ArcadeInteractRoom:_fillInteractData(refDataList)
	local interactiveList = ArcadeConfig.instance:getRoomInitInteractiveList(self.id)

	for _, interactive in ipairs(interactiveList) do
		local interactiveId = interactive.id
		local sizeX, sizeY = ArcadeConfig.instance:getInteractiveGrid(interactiveId)
		local interactiveData = {
			entityType = ArcadeGameEnum.EntityType.BaseInteractive,
			id = interactiveId,
			x = interactive.x,
			y = interactive.y,
			sizeX = sizeX,
			sizeY = sizeY
		}

		refDataList[#refDataList + 1] = interactiveData
	end
end

function ArcadeInteractRoom:_fillInitPortalData(refDataList)
	local portalIdList = ArcadeGameModel.instance:getRoomPortalIdList()
	local portalCount = #portalIdList
	local portalCoordinateList = ArcadeConfig.instance:getRoomPortalCoordinates(self.id)
	local coordinateCount = #portalCoordinateList
	local useCoordinateList = portalCoordinateList

	if coordinateCount < portalCount then
		logError(string.format("ArcadeInteractRoom:_fillInitPortalData error, coordinate not enough, roomId:%s portal:%s coordinate:%s", self.id, portalCount, coordinateCount))
	elseif portalCount < coordinateCount then
		useCoordinateList = {}

		local randomIndexList = ArcadeGameHelper.getUniqueRandomNumbers(1, coordinateCount, portalCount)

		for _, index in ipairs(randomIndexList) do
			useCoordinateList[#useCoordinateList + 1] = portalCoordinateList[index]
		end
	end

	for i, portalId in ipairs(portalIdList) do
		local coordinate = useCoordinateList[i]

		if coordinate then
			local sizeX, sizeY = ArcadeConfig.instance:getInteractiveGrid(portalId)
			local x = coordinate[1]
			local y = coordinate[2]
			local portalData = {
				entityType = ArcadeGameEnum.EntityType.Portal,
				id = portalId,
				x = x,
				y = y,
				sizeX = sizeX,
				sizeY = sizeY
			}

			refDataList[#refDataList + 1] = portalData
		end
	end
end

function ArcadeInteractRoom:onExit()
	return
end

function ArcadeInteractRoom:onClear()
	return
end

return ArcadeInteractRoom
