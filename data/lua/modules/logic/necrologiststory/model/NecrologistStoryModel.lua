-- chunkname: @modules/logic/necrologiststory/model/NecrologistStoryModel.lua

module("modules.logic.necrologiststory.model.NecrologistStoryModel", package.seeall)

local NecrologistStoryModel = class("NecrologistStoryModel", BaseModel)

function NecrologistStoryModel:onInit()
	self.storyGroupClientMos = {}
	self._curStoryGroupId = nil
end

function NecrologistStoryModel:reInit()
	self.storyGroupClientMos = {}
	self._curStoryGroupId = nil
end

function NecrologistStoryModel:getCurStoryMO()
	return self:getStoryMO(self._curStoryGroupId)
end

function NecrologistStoryModel:getStoryMO(id)
	if not id then
		return
	end

	local mo = self.storyGroupClientMos[id]

	if not mo then
		mo = NecrologistStoryMO.New()

		mo:init(id)

		self.storyGroupClientMos[id] = mo
	end

	self._curStoryGroupId = id

	return mo
end

function NecrologistStoryModel:getGameMO(id)
	return self:getMOById(id)
end

function NecrologistStoryModel:getMOById(id)
	local mo = self:getById(id)

	if not mo then
		local clsName = NecrologistStoryEnum.RoleStoryId2MOCls[id]
		local cls = _G[clsName] or NecrologistStoryGameBaseMO

		mo = cls.New()

		mo:init(id)
		self:addAtLast(mo)
	end

	return mo
end

function NecrologistStoryModel:updateStoryInfos(infos)
	for i = 1, #infos do
		self:updateStoryInfo(infos[i])
	end
end

function NecrologistStoryModel:updateStoryInfo(info)
	local id = info.storyId
	local mo = self:getMOById(id)

	if not mo then
		return
	end

	mo:updateInfo(info)
end

function NecrologistStoryModel:saveGameData(id, callback, callbackObj)
	local mo = self:getById(id)

	if not mo then
		return
	end

	mo:saveData(callback, callbackObj)
end

function NecrologistStoryModel:isReviewCanShow(storyId)
	local mo = self:getGameMO(storyId)

	if not mo then
		return false
	end

	local plotList = NecrologistStoryConfig.instance:getPlotListByStoryId(storyId)
	local hasPlotFinish = false

	if plotList then
		for i, v in ipairs(plotList) do
			if mo:isStoryFinish(v.id) then
				hasPlotFinish = true

				break
			end
		end
	end

	return hasPlotFinish
end

NecrologistStoryModel.instance = NecrologistStoryModel.New()

return NecrologistStoryModel
