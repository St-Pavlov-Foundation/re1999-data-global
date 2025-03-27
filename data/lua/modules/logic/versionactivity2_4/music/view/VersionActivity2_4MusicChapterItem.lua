module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicChapterItem", package.seeall)

slot0 = class("VersionActivity2_4MusicChapterItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goSpecial = gohelper.findChild(slot0.viewGO, "root/#go_Special")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "root/#txt_num")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "root/image_txtBG/#txt_name")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "root/image_txtBG/#txt_name/#txt_en")
	slot0._imagestargray = gohelper.findChildImage(slot0.viewGO, "root/#image_stargray")
	slot0._imagestarlight = gohelper.findChildImage(slot0.viewGO, "root/#image_starlight")
	slot0._imagecurrentdown = gohelper.findChildImage(slot0.viewGO, "root/#image_currentdown")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if not slot0._hasOpen then
		GameFacade.showToast(ToastEnum.PreLevelNotCompleted)

		return
	end

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.ClickChapterItem, slot0._episodeId)
end

function slot0._onClickHandler(slot0)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_4MusicSelectEpisode, slot0._episodeId)

	if slot0._episodeConfig.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Story then
		StoryController.instance:playStory(slot0._episodeConfig.storyBefore, nil, slot0._onFinishStory, slot0)

		if not slot0._hasFinished then
			Activity179Rpc.instance:sendSet179ScoreRequest(Activity179Model.instance:getActivityId(), slot0._episodeId, 0)
		end

		return
	end

	if slot0._episodeConfig.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Beat then
		if not StoryModel.instance:isStoryFinished(slot0._episodeConfig.storyBefore) or slot0._hasFinished then
			StoryController.instance:playStory(slot0._episodeConfig.storyBefore, nil, slot0._enterBeatView, slot0)
		else
			slot0:_enterBeatView()
		end
	end
end

function slot0._enterBeatView(slot0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatView(slot0._episodeId)
end

function slot0._onFinishStory(slot0)
	if not slot0._hasFinished then
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EpisodeStoryBeforeFinished)
	end
end

function slot0._editableInitView(slot0)
	slot0._canvas = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(slot0._imagecurrentdown, false)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ClickChapterItem, slot0._onClickChapterItem, slot0)
end

function slot0._onClickChapterItem(slot0, slot1)
	slot2 = slot0._isSelected
	slot0._isSelected = slot0._episodeId == slot1

	gohelper.setActive(slot0._imagecurrentdown, slot0._isSelected)

	if slot0._episodeId == slot1 then
		slot3 = 0.3

		TaskDispatcher.cancelTask(slot0._onClickHandler, slot0)
		TaskDispatcher.runDelay(slot0._onClickHandler, slot0, slot3)
		UIBlockHelper.instance:startBlock("VersionActivity2_4MusicChapterItem ClickChapterItem", slot3)
	end

	if not slot2 and slot0._isSelected then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)
	end
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.getEpisodeId(slot0)
	return slot0._episodeId
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._episodeConfig = slot1
	slot0._episodeId = slot0._episodeConfig.id
	slot0._txtname.text = slot0._episodeConfig.name
	slot0._txten.text = slot0._episodeConfig.name_En
	slot0._txtnum.text = slot0._episodeConfig.orderId

	gohelper.setActive(slot0._goSpecial, slot0._episodeConfig.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Beat)
	slot0:updateSelectedFlag()
	slot0:updateView()
end

function slot0.updateSelectedFlag(slot0)
	slot0._isSelected = Activity179Model.instance:getSelectedEpisodeId() == slot0._episodeId

	gohelper.setActive(slot0._imagecurrentdown, slot0._isSelected)
end

function slot0.updateView(slot0)
	slot0._hasOpen = slot0._episodeConfig.preEpisode == 0 or Activity179Model.instance:episodeIsFinished(slot0._episodeConfig.preEpisode)
	slot0._hasFinished = Activity179Model.instance:episodeIsFinished(slot0._episodeId)

	gohelper.setActive(slot0._imagestargray, not slot0._hasFinished)
	gohelper.setActive(slot0._imagestarlight, slot0._hasFinished)

	slot0._canvas.alpha = slot0._hasFinished and 1 or 0.8
end

function slot0.getHasFinished(slot0)
	return slot0._hasFinished
end

function slot0.getHasOpened(slot0)
	return slot0._hasOpen
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onClickHandler, slot0)
end

return slot0
