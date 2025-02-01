module("modules.logic.story.view.StoryVideoItem", package.seeall)

slot0 = class("StoryVideoItem")

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.viewGO = slot1
	slot0._videoName = slot2
	slot0._videoCo = slot3
	slot0._videoGo = nil
	slot0._loop = slot3.loop
	slot0._startCallBack = slot4
	slot0._startCallBackObj = slot5
	slot0._playList = slot6

	slot0:_build()
end

function slot0.pause(slot0, slot1)
	if slot1 then
		slot0._playList:setPauseState(true)
	else
		slot0._playList:setPauseState(false)
		slot0._playList:setParent(slot0.viewGO)
	end
end

function slot0.reset(slot0, slot1, slot2)
	slot0.viewGO = slot1
	slot0._videoCo = slot2
	slot0._loop = slot2.loop

	TaskDispatcher.cancelTask(slot0._playVideo, slot0)

	if slot0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_playVideo()

		return
	end

	TaskDispatcher.runDelay(slot0._playVideo, slot0, slot0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0._build(slot0)
	slot0._videoName = string.split(slot0._videoName, ".")[1]

	TaskDispatcher.cancelTask(slot0._playVideo, slot0)

	if slot0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_playVideo()

		return
	end

	TaskDispatcher.runDelay(slot0._playVideo, slot0, slot0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0._playVideo(slot0)
	StoryModel.instance:setSpecialVideoPlaying(slot0._videoName)

	if slot0._playList then
		slot0._playList:buildAndStart(slot0._videoName, slot0._loop, slot0._startCallBack, slot0._startCallBackObj, slot0)
		slot0._playList:setParent(slot0.viewGO)
	end
end

function slot0.destroyVideo(slot0, slot1)
	slot0._videoCo = slot1

	TaskDispatcher.cancelTask(slot0._playVideo, slot0)
	TaskDispatcher.cancelTask(slot0._realDestroy, slot0)

	if slot0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_realDestroy()

		return
	end

	TaskDispatcher.runDelay(slot0._realDestroy, slot0, slot0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0._realDestroy(slot0)
	slot0:onDestroy()
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._realDestroy, slot0)
	TaskDispatcher.cancelTask(slot0._playVideo, slot0)
	StoryModel.instance:setSpecialVideoEnd(slot0._videoName)
	slot0._playList:stop(slot0._videoName)
	gohelper.destroy(slot0._videoGo)
end

return slot0
