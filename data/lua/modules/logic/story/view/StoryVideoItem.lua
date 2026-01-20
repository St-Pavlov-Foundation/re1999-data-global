-- chunkname: @modules/logic/story/view/StoryVideoItem.lua

module("modules.logic.story.view.StoryVideoItem", package.seeall)

local StoryVideoItem = class("StoryVideoItem")

function StoryVideoItem:init(go, name, co, startCallBack, startCallBackObj)
	self.viewGO = go
	self._videoName = name
	self._videoCo = co
	self._loop = co.loop
	self._startCallBack = startCallBack
	self._startCallBackObj = startCallBackObj
	self._videoPlayer, self._videoGo = VideoPlayerMgr.instance:createGoAndVideoPlayer(self.viewGO, "videoplayer")

	self:_build()
end

function StoryVideoItem:pause(pause)
	if pause then
		self._videoPlayer:pause()
	else
		self._videoPlayer:continue()
	end
end

function StoryVideoItem:reset(go, co)
	self.viewGO = go
	self._videoCo = co
	self._loop = co.loop

	TaskDispatcher.cancelTask(self._playVideo, self)

	if self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_playVideo()

		return
	end

	TaskDispatcher.runDelay(self._playVideo, self, self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryVideoItem:_build()
	local videoArgs = string.split(self._videoName, ".")

	self._videoName = videoArgs[1]

	TaskDispatcher.cancelTask(self._playVideo, self)

	if self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_playVideo()

		return
	end

	TaskDispatcher.runDelay(self._playVideo, self, self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryVideoItem:_playVideo()
	StoryModel.instance:setSpecialVideoPlaying(self._videoName)

	if self._videoPlayer then
		self._videoPlayer:play(self._videoName, self._loop, self._onVideoEvent, self)
	end
end

function StoryVideoItem:_onVideoEvent(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.Started and self._startCallBack then
		self._startCallBack(self._startCallBackObj)
	end
end

function StoryVideoItem:destroyVideo(co)
	self._videoCo = co

	TaskDispatcher.cancelTask(self._playVideo, self)
	TaskDispatcher.cancelTask(self._realDestroy, self)

	if self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_realDestroy()

		return
	end

	TaskDispatcher.runDelay(self._realDestroy, self, self._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryVideoItem:_realDestroy()
	self:onDestroy()
end

function StoryVideoItem:onDestroy()
	TaskDispatcher.cancelTask(self._realDestroy, self)
	TaskDispatcher.cancelTask(self._playVideo, self)
	StoryModel.instance:setSpecialVideoEnd(self._videoName)

	if self._videoName then
		self._videoPlayer:stop()
	end

	gohelper.destroy(self._videoGo)
end

return StoryVideoItem
