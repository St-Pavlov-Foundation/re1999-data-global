module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.ZhiXinQuanErStoryStep", package.seeall)

slot0 = class("ZhiXinQuanErStoryStep", BaseWork)

function slot0.initData(slot0, slot1)
	slot0._data = slot1
end

function slot0.onStart(slot0, slot1)
	slot0._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
	slot0._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
	PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
	StoryController.instance:playStory(tonumber(slot0._data.param), {
		blur = true,
		hideStartAndEndDark = true,
		mark = true,
		isReplay = false
	}, slot0.afterPlayStory, slot0)
end

function slot0.afterPlayStory(slot0)
	TaskDispatcher.runDelay(slot0.onDoneTrue, slot0, 0.3)
end

function slot0.onDoneTrue(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", slot0._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", slot0._initDistortStrength)
	TaskDispatcher.cancelTask(slot0.onDoneTrue, slot0)
end

return slot0
