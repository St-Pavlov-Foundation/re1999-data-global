-- chunkname: @modules/logic/necrologiststory/model/NecrologistStoryPlotMO.lua

module("modules.logic.necrologiststory.model.NecrologistStoryPlotMO", package.seeall)

local NecrologistStoryPlotMO = pureTable("NecrologistStoryPlotMO")

function NecrologistStoryPlotMO:init(id)
	self.id = id
	self.config = NecrologistStoryConfig.instance:getPlotGroupCo(id)
	self.state = NecrologistStoryEnum.StoryState.Lock
	self.situationValueDict = {}
	self.plotMarkDict = {}
end

function NecrologistStoryPlotMO:updateInfo(info)
	self.state = info.state
	self.situationValueDict = {}

	for i = 1, #info.values do
		local valData = info.values[i]

		self.situationValueDict[valData.key] = valData.value
	end
end

function NecrologistStoryPlotMO:getState()
	return self.state
end

function NecrologistStoryPlotMO:setState(state)
	self.state = state
end

function NecrologistStoryPlotMO:getSituationValueTab()
	return self.situationValueDict
end

function NecrologistStoryPlotMO:setSituationValueTab(dict)
	self.situationValueDict = {}

	local tab = self.situationValueDict

	for key, value in pairs(dict) do
		tab[key] = value
	end
end

function NecrologistStoryPlotMO:getSaveData()
	local data = NecrologistStoryModule_pb.NecrologistStoryPlotInfo()

	data.id = self.id
	data.state = self.state

	for key, value in pairs(self.situationValueDict) do
		local valueData = NecrologistStoryModule_pb.NecrologistStorySituationValue()

		valueData.key = key
		valueData.value = value

		table.insert(data.values, valueData)
	end

	return data
end

return NecrologistStoryPlotMO
