-- chunkname: @modules/logic/versionactivity3_3/arcade/model/hall/ArcadeHallModel.lua

module("modules.logic.versionactivity3_3.arcade.model.hall.ArcadeHallModel", package.seeall)

local ArcadeHallModel = class("ArcadeHallModel", BaseModel)

function ArcadeHallModel:onInit()
	return
end

function ArcadeHallModel:reInit()
	return
end

function ArcadeHallModel:onOpenHallView()
	if not self._interactiveMos then
		self:initInteractiveMOs()
	end

	self:refreshInteractiveReddot()
end

function ArcadeHallModel:initInteractiveMOs()
	self._interactiveMos = {}

	for id, param in pairs(ArcadeHallEnum.HallInteractiveParams) do
		local mo = param and param.MO or ArcadeHallInteractiveMO

		self._interactiveMos[id] = mo.New(id)
	end
end

function ArcadeHallModel:refreshInteractiveReddot()
	self:refreshHandBookReddot()
	self:refreshDevelopReddot()
	self:refreshTaskReddot()
end

function ArcadeHallModel:refreshHandBookReddot()
	local mo = self._interactiveMos[ArcadeHallEnum.HallInteractiveId.HandBook]

	if not mo then
		return
	end

	local hasReddot = ArcadeHandBookModel.instance:hasReddot()
	local type = hasReddot and ArcadeEnum.ReddotType.New or ArcadeEnum.ReddotType.None

	mo:setReddotType(type)
end

function ArcadeHallModel:refreshDevelopReddot()
	local mo = self._interactiveMos[ArcadeHallEnum.HallInteractiveId.Develop]

	if not mo then
		return
	end

	local type = ArcadeHeroModel.instance:getReddotType()

	mo:setReddotType(type)
end

function ArcadeHallModel:refreshTaskReddot()
	local mo = self._interactiveMos[ArcadeHallEnum.HallInteractiveId.Task]

	if not mo then
		return
	end

	local hasReddot = ArcadeOutSizeModel.instance:hasRewardReddot()
	local type = hasReddot and ArcadeEnum.ReddotType.Normal or ArcadeEnum.ReddotType.None

	mo:setReddotType(type)
end

function ArcadeHallModel:getInteractiveMOs()
	if not self._interactiveMos then
		self:initInteractiveMOs()
	end

	return self._interactiveMos
end

function ArcadeHallModel:getInteractiveMO(interactiveId)
	if not self._interactiveMos then
		self:initInteractiveMOs()
	end

	return self._interactiveMos and self._interactiveMos[interactiveId]
end

function ArcadeHallModel:getEquipedCharacterMO()
	return self:getCharacterMOById(ArcadeHeroModel.instance:getEquipHeroId())
end

function ArcadeHallModel:getCharacterMOById(id)
	if not self._characterMO then
		self._characterMO = {}
	end

	id = id or ArcadeHeroModel.instance:getEquipHeroId()

	if not self._characterMO[id] then
		self._characterMO[id] = ArcadeHallHeroMO.New(id)
	end

	return self._characterMO[id]
end

function ArcadeHallModel:setHeroGrid(x, y)
	self._heroGridX, self._heroGridY = x, y
end

function ArcadeHallModel:getHeroGrid()
	return self._heroGridX, self._heroGridY
end

function ArcadeHallModel:getHallGridSize()
	if not self._hallGridSize then
		self._hallGridSize = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.HallGridSize, true, "#")
	end

	return self._hallGridSize
end

function ArcadeHallModel:saveHeroGrid()
	local characterMo = self:getEquipedCharacterMO()

	if characterMo then
		local curGridX, curGridY = characterMo:getGridPos()

		ArcadeOutSideRpc.instance:sendArcadeGamePlayerMOveRequest(curGridX, curGridY)
	end
end

ArcadeHallModel.instance = ArcadeHallModel.New()

return ArcadeHallModel
