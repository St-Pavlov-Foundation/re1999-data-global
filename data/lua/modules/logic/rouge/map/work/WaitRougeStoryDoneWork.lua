-- chunkname: @modules/logic/rouge/map/work/WaitRougeStoryDoneWork.lua

module("modules.logic.rouge.map.work.WaitRougeStoryDoneWork", package.seeall)

local WaitRougeStoryDoneWork = class("WaitRougeStoryDoneWork", BaseWork)
local kTimeout = 9.99
local kBlockName = "starWaitRougeStoryDoneWorktBlock"

function WaitRougeStoryDoneWork:_onStoryStart(storyId)
	if self.storyId ~= storyId then
		return
	end

	UIBlockHelper.instance:endBlock(kBlockName)
end

function WaitRougeStoryDoneWork:ctor(storyId)
	self.storyId = storyId
end

function WaitRougeStoryDoneWork:onStart()
	if not self.storyId or self.storyId == 0 then
		return self:onDone(true)
	end

	StoryController.instance:registerCallback(StoryEvent.Start, self._onStoryStart, self)
	UIBlockHelper.instance:startBlock(kBlockName, kTimeout)
	StoryController.instance:playStory(self.storyId, nil, self.onStoryDone, self)
end

function WaitRougeStoryDoneWork:onStoryDone()
	self:onDone(true)
end

function WaitRougeStoryDoneWork:clearWork()
	StoryController.instance:unregisterCallback(StoryEvent.Start, self._onStoryStart, self)
end

return WaitRougeStoryDoneWork
