module("modules.logic.versionactivity1_2.yaxian.controller.YaXianController", package.seeall)

slot0 = class("YaXianController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openYaXianMapView(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(YaXianEnum.ActivityId)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		if slot3 then
			GameFacade.showToastWithTableParam(slot3, slot4)
		end

		return
	end

	if not VersionActivityBaseController.instance:isPlayedActivityVideo(YaXianEnum.ActivityId) and ActivityConfig.instance:getActivityCo(YaXianEnum.ActivityId) and slot5.storyId and slot6 ~= 0 then
		slot0.enterChapterId = slot1

		StoryController.instance:playStory(slot6, nil, slot0._onFinishStory, slot0)

		return
	end

	Activity115Rpc.instance:sendGetAct115InfoRequest(YaXianEnum.ActivityId, function ()
		ViewMgr.instance:openView(ViewName.YaXianMapView, {
			chapterId = uv0
		})
	end)
end

function slot0._onFinishStory(slot0)
	slot0:openYaXianMapView(slot0.enterChapterId)

	slot0.enterChapterId = nil
end

function slot0.getChapterStatus(slot0, slot1)
	if YaXianConfig.instance:getChapterConfig(slot1) and slot2.openId and slot3 ~= 0 and not OpenModel.instance:isFunctionUnlock(slot3) then
		return YaXianEnum.ChapterStatus.notOpen
	end

	if not YaXianModel.instance:chapterIsUnlock(slot1) then
		return YaXianEnum.ChapterStatus.Lock
	end

	return YaXianEnum.ChapterStatus.Normal
end

function slot0.checkChapterIsUnlock(slot0, slot1)
	return slot0:getChapterStatus(slot1) == YaXianEnum.ChapterStatus.Normal
end

slot0.instance = slot0.New()

return slot0
