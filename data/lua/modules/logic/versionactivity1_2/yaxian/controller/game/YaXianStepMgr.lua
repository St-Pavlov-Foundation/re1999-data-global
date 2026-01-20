-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/YaXianStepMgr.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianStepMgr", package.seeall)

local YaXianStepMgr = class("YaXianStepMgr")

YaXianStepMgr.StepClzMap = {
	[YaXianGameEnum.GameStepType.GameFinish] = YaXianStepGameFinish,
	[YaXianGameEnum.GameStepType.Move] = YaXianStepMove,
	[YaXianGameEnum.GameStepType.NextRound] = YaXianStepNextRound,
	[YaXianGameEnum.GameStepType.CallEvent] = YaXianStepCallEvent,
	[YaXianGameEnum.GameStepType.CreateObject] = YaXianStepCreateObject,
	[YaXianGameEnum.GameStepType.DeleteObject] = YaXianStepDeleteObject,
	[YaXianGameEnum.GameStepType.PickUp] = YaXianStepPickUpItem,
	[YaXianGameEnum.GameStepType.InteractFinish] = YaXianStepInteractFinish,
	[YaXianGameEnum.GameStepType.UpdateObjectData] = YaXianStepUpdateObjectData
}

function YaXianStepMgr:ctor()
	self._stepList = nil
	self._stepPool = nil
	self._curStep = nil
end

function YaXianStepMgr:insertStepList(serverData)
	self:beforeBuildStep(serverData)

	for index, data in ipairs(self.stepDataList) do
		self:insertStep(data, index)
	end
end

function YaXianStepMgr:beforeBuildStep(serverData)
	self.stepDataList = {}

	local stepData, preStepData

	for _, jsonData in ipairs(serverData) do
		stepData = cjson.decode(jsonData.param)

		if stepData.stepType ~= YaXianGameEnum.GameStepType.Move then
			if preStepData then
				table.insert(self.stepDataList, preStepData)

				preStepData = nil
			end

			table.insert(self.stepDataList, stepData)
		else
			if preStepData and preStepData.id ~= stepData.id then
				table.insert(self.stepDataList, preStepData)
			end

			preStepData = stepData
		end
	end

	local deleteInteractIndexList = {}
	local moveStepIndexList = {}

	for index, data in ipairs(self.stepDataList) do
		if data.stepType == YaXianGameEnum.GameStepType.DeleteObject and data.reason == YaXianGameEnum.DeleteInteractReason.AssassinateKill then
			table.insert(deleteInteractIndexList, index)
		end

		if data.stepType == YaXianGameEnum.GameStepType.Move then
			table.insert(moveStepIndexList, index)
		end
	end

	for _, deleteIndex in ipairs(deleteInteractIndexList) do
		local preMoveIndex

		for index = #moveStepIndexList, 1, -1 do
			if deleteIndex > moveStepIndexList[index] then
				preMoveIndex = moveStepIndexList[index]

				break
			end
		end

		preStepData = self:getStepData(preMoveIndex)

		if preStepData then
			preStepData.assassinateSourceStep = true
			preStepData.deleteStepIndex = deleteIndex
		else
			logError("not found step data, index : " .. deleteIndex)
		end
	end
end

function YaXianStepMgr:getStepData(index)
	return self.stepDataList and self.stepDataList[index]
end

function YaXianStepMgr:insertStep(serverData, index)
	local step = self:buildStep(serverData, index)

	if step then
		self._stepList = self._stepList or {}

		table.insert(self._stepList, step)
	end

	if self._curStep == nil then
		self:nextStep()
	end
end

function YaXianStepMgr:buildStep(data, index)
	local stepObj
	local typePool = self._stepPool and self._stepPool[data.stepType]

	if typePool and #typePool > 0 then
		stepObj = typePool[#typePool]
		typePool[#typePool] = nil
	else
		stepObj = YaXianStepMgr.StepClzMap[data.stepType].New()
	end

	stepObj:init(data, index)

	return stepObj
end

function YaXianStepMgr:nextStep()
	if self._curStep then
		self:putPool(self._curStep)

		self._curStep = nil
	end

	if self._stepList and #self._stepList > 0 then
		self._curStep = self._stepList[1]

		table.remove(self._stepList, 1)
		self._curStep:start()
	end
end

function YaXianStepMgr:putPool(step)
	if not step then
		return
	end

	step:dispose()

	self._stepPool = self._stepPool or {}

	local typePool = self._stepPool[step.stepType] or {}

	table.insert(typePool, step)

	self._stepPool[step.stepType] = typePool
end

function YaXianStepMgr:disposeAllStep()
	if self._curStep then
		self:putPool(self._curStep)

		self._curStep = nil
	end

	if self._stepList then
		for _, step in pairs(self._stepList) do
			self:putPool(step)
		end

		self._stepList = nil
	end
end

function YaXianStepMgr:removeAll()
	self:disposeAllStep()
end

function YaXianStepMgr:dispose()
	self._stepPool = nil
end

function YaXianStepMgr:log(stepIns)
	logError(string.format("data : %s, index : %s", cjson.encode(stepIns.originData), stepIns.index))
end

return YaXianStepMgr
