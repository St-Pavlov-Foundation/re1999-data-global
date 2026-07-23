-- chunkname: @modules/logic/sp02/operationactivity/model/AtomicOperationActivityGameModel.lua

module("modules.logic.sp02.operationactivity.model.AtomicOperationActivityGameModel", package.seeall)

local AtomicOperationActivityGameModel = class("AtomicOperationActivityGameModel", BaseModel)

function AtomicOperationActivityGameModel:onInit()
	self:reInit()
end

function AtomicOperationActivityGameModel:reInit()
	self.logicData = nil
end

function AtomicOperationActivityGameModel:getInfoMo()
	if not self.logicData then
		self.logicData = AtomicOperationActivityGameInfoMo.New()
	end

	return self.logicData
end

AtomicOperationActivityGameModel.instance = AtomicOperationActivityGameModel.New()

return AtomicOperationActivityGameModel
