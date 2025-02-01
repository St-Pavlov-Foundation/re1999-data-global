module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapViewContainer", package.seeall)

slot0 = class("YaXianMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, YaXianMapView.New())
	table.insert(slot1, YaXianMapWindowView.New())
	table.insert(slot1, YaXianMapAudioView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_left"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				true
			}, HelpEnum.HelpId.YaxianChessHelp)
		}
	end
end

function slot0.onContainerInit(slot0)
	slot0:initViewParam()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.YaXian)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.YaXian
	})
	AudioMgr.instance:trigger(AudioEnum.YaXian.EnterYaXianMap)
end

function slot0.initViewParam(slot0)
	slot0.chapterId = slot0.viewParam and slot0.viewParam.chapterId

	if not slot0.chapterId then
		slot0.chapterId = YaXianModel.instance:getLastCanFightEpisodeMo().config.chapterId
	end

	if not YaXianController.instance:checkChapterIsUnlock(slot0.chapterId) then
		slot0.chapterId = YaXianEnum.DefaultChapterId
	end
end

function slot0.changeChapterId(slot0, slot1)
	if slot0.chapterId == slot1 then
		return
	end

	slot0.chapterId = slot1

	YaXianController.instance:dispatchEvent(YaXianEvent.OnSelectChapterChange)
end

function slot0.setVisibleInternal(slot0, slot1)
	if YaXianModel.instance:checkIsPlayingClickAnimation() then
		return
	end

	uv0.super.setVisibleInternal(slot0, slot1)
end

return slot0
