-- chunkname: @modules/logic/necrologiststory/model/NecrologistStoryGameBaseMO.lua

module("modules.logic.necrologiststory.model.NecrologistStoryGameBaseMO", package.seeall)

local NecrologistStoryGameBaseMO = class("NecrologistStoryGameBaseMO")

function NecrologistStoryGameBaseMO:ctor()
	self.id = nil
	self.data = nil
	self.dataIsDirty = false
	self.isAutoSave = true
end

function NecrologistStoryGameBaseMO:init(id)
	self.id = id
	self.plotInfoDict = {}

	self:onInit()
end

function NecrologistStoryGameBaseMO:updateInfo(info)
	local infoStr = info.info

	self.data = string.nilorempty(infoStr) and {} or cjson.decode(infoStr)
	self.plotInfoDict = {}

	for i = 1, #info.plotInfos do
		local plotInfo = info.plotInfos[i]

		self:updatePlotInfo(plotInfo)
	end

	self:onUpdateData()

	self.dataIsDirty = false
end

function NecrologistStoryGameBaseMO:getPlotInfo(plotId, createIfNotExist)
	local mo = self.plotInfoDict[plotId]

	if not mo and createIfNotExist then
		mo = NecrologistStoryPlotMO.New()

		mo:init(plotId)

		self.plotInfoDict[plotId] = mo
	end

	return mo
end

function NecrologistStoryGameBaseMO:updatePlotInfo(plotInfo)
	local plotMo = self:getPlotInfo(plotInfo.id, true)

	plotMo:updateInfo(plotInfo)
end

function NecrologistStoryGameBaseMO:getData()
	return self.data
end

function NecrologistStoryGameBaseMO:saveData(callback, callbackObj)
	if not self.dataIsDirty then
		if callback then
			callback(callbackObj)
		end

		return
	end

	self:onSaveData()
	NecrologistStoryRpc.instance:sendUpdateNecrologistStoryRequest(self.id, self, callback, callbackObj)
end

function NecrologistStoryGameBaseMO:setDataDirty()
	self.dataIsDirty = true

	if self.isAutoSave then
		self:saveData()
	end
end

function NecrologistStoryGameBaseMO:getStoryState(storyId)
	local plotMo = self:getPlotInfo(storyId)
	local state = plotMo and plotMo:getState()

	if state == nil then
		local config = NecrologistStoryConfig.instance:getPlotGroupCo(storyId)

		if config.preId == 0 then
			state = NecrologistStoryEnum.StoryState.Normal
		else
			local prePlotMo = self:getPlotInfo(config.preId)
			local preState = prePlotMo and prePlotMo:getState()

			if preState == NecrologistStoryEnum.StoryState.Finish then
				state = NecrologistStoryEnum.StoryState.Normal
			else
				state = NecrologistStoryEnum.StoryState.Lock
			end
		end
	end

	return state
end

function NecrologistStoryGameBaseMO:isStoryFinish(storyId)
	local state = self:getStoryState(storyId)

	return state == NecrologistStoryEnum.StoryState.Finish
end

function NecrologistStoryGameBaseMO:setStoryState(storyId, state)
	local curState = self:getStoryState(storyId)

	if state <= curState then
		return
	end

	local plotMo = self:getPlotInfo(storyId, true)

	plotMo:setState(state)
	self:onStoryStateChange(storyId, state)

	if state == NecrologistStoryEnum.StoryState.Finish then
		HeroStoryRpc.instance:sendHeroStoryPlotFinishRequest(storyId)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryStateChange, storyId)
	self:setDataDirty()
end

function NecrologistStoryGameBaseMO:getPlotSituationTab(excludePlotId)
	local dict = {}

	setmetatable(dict, {
		__index = function(t, k)
			return 0
		end
	})

	for plotId, info in pairs(self.plotInfoDict) do
		if plotId ~= excludePlotId then
			for key, value in pairs(info:getSituationValueTab()) do
				dict[key] = dict[key] + value
			end
		end
	end

	return dict
end

function NecrologistStoryGameBaseMO:setPlotSituationTab(plotId, dict)
	local plotMo = self:getPlotInfo(plotId, true)

	plotMo:setSituationValueTab(dict)
	self:setDataDirty()
end

function NecrologistStoryGameBaseMO:toString()
	local jsonStr = cjson.encode(self.data)

	return jsonStr
end

function NecrologistStoryGameBaseMO:onInit()
	return
end

function NecrologistStoryGameBaseMO:onUpdateData()
	return
end

function NecrologistStoryGameBaseMO:onSaveData()
	return
end

function NecrologistStoryGameBaseMO:onStoryStateChange(storyId, state)
	return
end

function NecrologistStoryGameBaseMO:setNecrologistStoryRequest(req)
	req.info = self:toString()

	for plotId, plotMo in pairs(self.plotInfoDict) do
		table.insert(req.plotInfos, plotMo:getSaveData())
	end
end

return NecrologistStoryGameBaseMO
