-- chunkname: @modules/logic/explore/model/ExploreTaskModel.lua

module("modules.logic.explore.model.ExploreTaskModel", package.seeall)

local ExploreTaskModel = class("ExploreTaskModel", BaseModel)

function ExploreTaskModel:ctor()
	self._models = {}
end

function ExploreTaskModel:getTaskList(collectType)
	if not self._models[collectType] then
		self._models[collectType] = ListScrollModel.New()
	end

	return self._models[collectType]
end

ExploreTaskModel.instance = ExploreTaskModel.New()

return ExploreTaskModel
