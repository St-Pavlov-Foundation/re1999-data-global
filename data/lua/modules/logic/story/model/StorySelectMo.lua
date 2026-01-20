-- chunkname: @modules/logic/story/model/StorySelectMo.lua

module("modules.logic.story.model.StorySelectMo", package.seeall)

local StorySelectMo = pureTable("StorySelectMo")

function StorySelectMo:ctor()
	self.id = 0
	self.name = ""
	self.index = 0
	self.stepId = 0
end

function StorySelectMo:init(info)
	self.id = info.id
	self.name = info.name
	self.index = info.index
	self.stepId = info.stepId
end

return StorySelectMo
