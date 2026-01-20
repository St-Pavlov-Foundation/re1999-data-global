-- chunkname: @modules/logic/story/model/StorySelectListModel.lua

module("modules.logic.story.model.StorySelectListModel", package.seeall)

local StorySelectListModel = class("StorySelectListModel", ListScrollModel)

function StorySelectListModel:setSelectList(infos)
	local moList = {}

	for _, info in ipairs(infos) do
		local selectMo = StorySelectMo.New()

		selectMo:init(info)
		table.insert(moList, selectMo)
	end

	self:setList(moList)
end

StorySelectListModel.instance = StorySelectListModel.New()

return StorySelectListModel
