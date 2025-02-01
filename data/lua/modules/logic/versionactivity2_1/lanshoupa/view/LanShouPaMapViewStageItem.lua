module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapViewStageItem", package.seeall)

slot0 = class("LanShouPaMapViewStageItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._imagepoint = gohelper.findChildImage(slot0.viewGO, "#image_point")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "unlock")
	slot0._imagestageline = gohelper.findChildImage(slot0.viewGO, "unlock/#image_stageline")
	slot0._gostagefinish = gohelper.findChild(slot0.viewGO, "unlock/#go_stagefinish")
	slot0._gostagenormal = gohelper.findChild(slot0.viewGO, "unlock/#go_stagenormal")
	slot0._gogame = gohelper.findChild(slot0.viewGO, "unlock/#go_stagenormal/#go_Game")
	slot0._gostory = gohelper.findChild(slot0.viewGO, "unlock/#go_stagenormal/#go_Story")
	slot0._imageline = gohelper.findChildImage(slot0.viewGO, "unlock/#image_line")
	slot0._imageangle = gohelper.findChildImage(slot0.viewGO, "unlock/#image_angle")
	slot0._txtstagename = gohelper.findChildText(slot0.viewGO, "unlock/info/#txt_stagename")
	slot0._txtstagenum = gohelper.findChildText(slot0.viewGO, "unlock/info/#txt_stagename/#txt_stageNum")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "unlock/info/#txt_stagename/#go_star")
	slot0._gohasstar = gohelper.findChild(slot0._gostar, "has/#image_Star")
	slot0._btnreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/info/#txt_stagename/#btn_review")
	slot0._imagechess = gohelper.findChildImage(slot0.viewGO, "unlock/#image_chess")
	slot0._chessAnimator = gohelper.findChild(slot0._imagechess.gameObject, "ani"):GetComponent(typeof(UnityEngine.Animator))
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "unlock/#btn_click")

	slot0:_addEvents()
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot0._actId = VersionActivity2_1Enum.ActivityId.LanShouPa
	slot0._index = slot2
	slot0._config = slot1
	slot0._episodeId = slot0._config.id
	slot0._txtstagename.text = slot0._config.name
	slot0._txtstagenum.text = string.format("STAGE %02d", slot2)
	slot4 = slot0._config.mapIds ~= 0
	slot5 = slot2 <= Activity164Model.instance:getUnlockCount()
	slot6 = Activity164Config.instance:getStoryList(slot0._actId, slot0._episodeId)

	gohelper.setActive(slot0._btnreview.gameObject, slot4 and slot5 and slot6 and #slot6 > 0)
	gohelper.setActive(slot0._imagechess.gameObject, slot0._episodeId == (Activity164Model.instance:getCurEpisodeId() or LanShouPaEnum.episodeId))
	gohelper.setActive(slot0._gounlock, Activity164Model.instance:getUnlockCount() >= slot2 - 1)
	gohelper.setActive(slot0._gostagefinish, slot4)
	gohelper.setActive(slot0._gostagenormal, true)
	gohelper.setActive(slot0._gohasstar, slot5)
	gohelper.setActive(slot0._gogame, slot4)
	gohelper.setActive(slot0._gostory, not slot4)
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnreview:AddClickListener(slot0._btnReviewOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	if slot0._btnclick then
		slot0._btnclick:RemoveClickListener()
		slot0._btnreview:RemoveClickListener()
	end
end

function slot0._btnclickOnClick(slot0)
	if Activity164Model.instance:getCurEpisodeId() == slot0._episodeId then
		slot0:_realPlayStory()
	else
		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.EpisodeClick, slot0._episodeId)
		UIBlockHelper.instance:startBlock("LanShouPaMapViewStageItemEpisodeClick", 0.5, slot0.viewName)
		TaskDispatcher.runDelay(slot0._delayPlayChessOpenAnim, slot0, 0.25)
	end
end

function slot0._delayPlayChessOpenAnim(slot0)
	if not slot0._imagechess then
		return
	end

	gohelper.setActive(slot0._imagechess, true)

	if slot0._episodeId < Activity164Model.instance:getCurEpisodeId() then
		slot0._chessAnimator:Play("open_left", 0, 0)
	else
		slot0._chessAnimator:Play("open_right", 0, 0)
	end

	Activity164Model.instance:setCurEpisodeId(slot0._episodeId)
	TaskDispatcher.runDelay(slot0._realPlayStory, slot0, 0.25)
end

function slot0._realPlayStory(slot0)
	if not slot0._config then
		return
	end

	slot1 = VersionActivity2_1Enum.ActivityId.LanShouPa

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_1LanShouPaSelect .. slot1, tostring(tabletool.indexOf(Activity164Config.instance:getEpisodeCoList(slot1), slot0._config)))

	if slot0._config.storyBefore == 0 or slot0._config.mapIds ~= 0 and Activity164Model.instance.currChessGameEpisodeId == slot0._episodeId then
		slot0:_storyEnd()
	else
		StoryController.instance:playStory(slot0._config.storyBefore, nil, slot0._storyEnd, slot0)
	end
end

function slot0._btnReviewOnClick(slot0)
	if slot0._config.mapIds ~= 0 then
		LanShouPaController.instance:openStoryView(slot0._episodeId)
	else
		StoryController.instance:playStory(slot0._config.storyBefore, nil, slot0._storyEnd, slot0)
	end
end

function slot0._storyEnd(slot0)
	if slot0._config.mapIds ~= 0 then
		Activity164Model.instance.currChessGameEpisodeId = slot0._episodeId

		LanShouPaController.instance:enterChessGame(slot0._actId, slot0._episodeId)
		LanShouPaController.instance:dispatchEvent(LanShouPaEvent.StartEnterGameView)
	else
		Activity164Model.instance:markEpisodeFinish(slot0._episodeId)
	end
end

function slot0._addEvents(slot0)
	LanShouPaController.instance:registerCallback(LanShouPaEvent.EpisodeClick, slot0._playChooseEpisode, slot0)
end

function slot0._removeEvents(slot0)
	LanShouPaController.instance:unregisterCallback(LanShouPaEvent.EpisodeClick, slot0._playChooseEpisode, slot0)
end

function slot0.onPlayFinish(slot0)
	slot0:refreshItem(slot0._config, slot0._index)
	slot0._animator:Play("finish", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function slot0.onPlayUnlock(slot0)
	slot0:refreshItem(slot0._config, slot0._index)
	slot0._animator:Play("unlock", 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function slot0._playChooseEpisode(slot0, slot1)
	if slot0._episodeId == Activity164Model.instance:getCurEpisodeId() then
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)

		if slot1 < slot0._episodeId then
			slot0._chessAnimator:Play("close_left", 0, 0)
		else
			slot0._chessAnimator:Play("close_right", 0, 0)
		end
	end
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
	slot0:removeEventListeners()
end

return slot0
