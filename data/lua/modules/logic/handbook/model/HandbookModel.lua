-- chunkname: @modules/logic/handbook/model/HandbookModel.lua

module("modules.logic.handbook.model.HandbookModel", package.seeall)

local HandbookModel = class("HandbookModel", BaseModel)

function HandbookModel:onInit()
	self._cgReadDict = {}
	self._fragmentDict = {}
	self._characterReadDict = {}
	self._equipDict = {}
end

function HandbookModel:reInit()
	self._cgReadDict = {}
	self._fragmentDict = {}
	self._characterReadDict = {}
	self._equipDict = {}
end

function HandbookModel:setReadInfos(infos)
	self._cgReadDict = {}

	for i, info in ipairs(infos) do
		self:setReadInfo(info)
	end
end

function HandbookModel:setReadInfo(info)
	if info.type == HandbookEnum.Type.CG then
		if info.isRead then
			self._cgReadDict[info.id] = true
		elseif self._cgReadDict[info.id] then
			self._cgReadDict[info.id] = nil
		end
	elseif info.type == HandbookEnum.Type.Character then
		if info.isRead then
			self._characterReadDict[info.id] = true
		end
	elseif info.type == HandbookEnum.Type.Equip then
		local handbookEquipCo = lua_handbook_equip.configDict[info.id]

		if not handbookEquipCo then
			logError(string.format("handbook equip not found id : %s config", info.id))

			return
		end

		self._equipDict[handbookEquipCo.equipId] = true
	end
end

function HandbookModel:setFragmentInfo(infos)
	self._fragmentDict = {}

	for i, info in ipairs(infos) do
		local elementConfig = lua_chapter_map_element.configDict[info.element]

		if elementConfig and elementConfig.fragment ~= 0 then
			local dialogIdList = {}

			for j, dialogId in ipairs(info.dialogIds) do
				table.insert(dialogIdList, dialogId)
			end

			self._fragmentDict[elementConfig.fragment] = dialogIdList
		end
	end
end

function HandbookModel:isRead(type, id)
	if type == HandbookEnum.Type.CG then
		return self._cgReadDict[id]
	elseif type == HandbookEnum.Type.Character then
		return self._characterReadDict[id]
	end

	return false
end

function HandbookModel:isCGUnlock(cgId)
	local config = HandbookConfig.instance:getCGConfig(cgId)
	local episodeId = config.episodeId
	local herostoryId = config.herostoryId

	if episodeId == 0 and herostoryId == 0 then
		return true
	end

	if episodeId ~= 0 then
		return DungeonModel.instance:hasPassLevelAndStory(episodeId)
	end

	return RoleStoryModel.instance:isCGUnlock(herostoryId)
end

function HandbookModel:getCGUnlockCount(storyChapterId, cgType)
	local count = 0
	local cgList = HandbookConfig.instance:getCGList(cgType)

	for i, config in ipairs(cgList) do
		if (not storyChapterId or config.storyChapterId == storyChapterId) and HandbookModel.instance:isCGUnlock(config.id) then
			count = count + 1
		end
	end

	return count
end

function HandbookModel:getCGUnlockIndex(cgId, cgType)
	local count = 1
	local cgList = HandbookConfig.instance:getCGList(cgType)

	for i, config in ipairs(cgList) do
		if config.id == cgId then
			return count
		end

		if HandbookModel.instance:isCGUnlock(config.id) then
			count = count + 1
		end
	end
end

function HandbookModel:getCGUnlockIndexInChapter(chapterId, cgId, cgType)
	local count = 1
	local cgList = HandbookConfig.instance:getCGDictByChapter(chapterId, cgType)

	for i, config in ipairs(cgList) do
		if config.id == cgId then
			return count
		end

		if HandbookModel.instance:isCGUnlock(config.id) then
			count = count + 1
		end
	end
end

function HandbookModel:getNextCG(cgId, cgType)
	local index = HandbookConfig.instance:getCGIndex(cgId, cgType)
	local cgList = HandbookConfig.instance:getCGList(cgType)

	for i = index + 1, #cgList do
		local config = cgList[i]

		if self:isCGUnlock(config.id) then
			return config
		end
	end

	for i = 1, index - 1 do
		local config = cgList[i]

		if self:isCGUnlock(config.id) then
			return config
		end
	end

	return nil
end

function HandbookModel:getPrevCG(cgId, cgType)
	local index = HandbookConfig.instance:getCGIndex(cgId, cgType)
	local cgList = HandbookConfig.instance:getCGList(cgType)

	for i = index - 1, 1, -1 do
		local config = cgList[i]

		if self:isCGUnlock(config.id) then
			return config
		end
	end

	for i = #cgList, index + 1, -1 do
		local config = cgList[i]

		if self:isCGUnlock(config.id) then
			return config
		end
	end

	return nil
end

function HandbookModel:isStoryGroupUnlock(storyGroupId)
	local storyGroupConfig = HandbookConfig.instance:getStoryGroupConfig(storyGroupId)
	local episodeId = storyGroupConfig.episodeId

	return episodeId == 0 or DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function HandbookModel:getStoryGroupUnlockCount(storyChapterId)
	local count = 0
	local storyGroupList = HandbookConfig.instance:getStoryGroupList()

	for i, config in ipairs(storyGroupList) do
		if (not storyChapterId or config.storyChapterId == storyChapterId) and HandbookModel.instance:isStoryGroupUnlock(config.id) then
			count = count + 1
		end
	end

	return count
end

function HandbookModel:getFragmentDialogIdList(fragmentId)
	return self._fragmentDict[fragmentId]
end

function HandbookModel:haveEquip(equipId)
	return self._equipDict[equipId]
end

HandbookModel.instance = HandbookModel.New()

return HandbookModel
