module("modules.logic.versionactivity1_5.aizila.view.AiZiLaStageItem", package.seeall)

slot0 = class("AiZiLaStageItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goUnLocked = gohelper.findChild(slot0.viewGO, "Root/#go_UnLocked")
	slot0._txtStageName = gohelper.findChildText(slot0.viewGO, "Root/#go_UnLocked/Info/#txt_StageName")
	slot0._btnPlay = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#go_UnLocked/Info/#txt_StageName/#btn_Play")
	slot0._txtStageNum = gohelper.findChildText(slot0.viewGO, "Root/#go_UnLocked/Info/#txt_StageNum")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "Root/#go_Locked")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPlay:AddClickListener(slot0._btnPlayOnClick, slot0)
	slot0._btnClick:AddClickListener(slot0._btnClickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnPlay:RemoveClickListener()
	slot0._btnClick:RemoveClickListener()
end

function slot0._btnPlayOnClick(slot0)
	if slot0._stroyIds and #slot0._stroyIds > 0 then
		if #slot0._stroyIds == 1 then
			AiZiLaGameController.instance:playStory(slot0._stroyIds[1])
		else
			AiZiLaController.instance:openStoryView(slot0._config.episodeId)
		end
	end
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0._btnClickOnClick(slot0)
	if AiZiLaModel.instance:getEpisodeMO(slot0._config.episodeId) then
		AiZiLaController.instance:openEpsiodeDetailView(slot0._config.episodeId)
	else
		GameFacade.showToast(ToastEnum.V1a5AiZiLaEpisodeNotOpen, slot0._config.unlockDesc)
	end
end

function slot0._editableInitView(slot0)
	slot0._txtLockStageNum = gohelper.findChildText(slot0.viewGO, "Root/#go_Locked/Info/#txt_StageNum")
	slot0._goRoot = gohelper.findChild(slot0.viewGO, "Root")
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
end

function slot0.onDestroy(slot0)
end

function slot0.setCfg(slot0, slot1)
	slot0._config = slot1
	slot0._stroyIds = {}

	if slot1 then
		if slot1.storyBefore and slot1.storyBefore ~= 0 then
			table.insert(slot0._stroyIds, slot1.storyBefore)
		end

		if slot1.storyClear and slot1.storyClear ~= 0 then
			table.insert(slot0._stroyIds, slot1.storyClear)
		end
	end

	slot0._isPlayUnLockAnim = nil
end

function slot0.getEpisodeId(slot0)
	return slot0._config and slot0._config.episodeId
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goRoot, slot0._config ~= nil)

	if slot0._config then
		slot0._txtStageName.text = slot0._config.name
		slot0._txtStageNum.text = slot0._config.nameen
		slot0._txtLockStageNum.text = slot0._config.nameen
		slot0._isLock = AiZiLaModel.instance:getEpisodeMO(slot0._config.episodeId) == nil

		if slot0._isPlayUnLockAnim == nil then
			slot0._isPlayUnLockAnim = slot0:_isPlayedUnLock(slot0._config.episodeId)
		end

		if slot0._isLock then
			slot0._isPlayUnLockAnim = false
		end

		slot0._isShowStoryPlay = slot0:_checkShowStory()

		slot0:_refreshStateUI()
	end
end

function slot0._refreshStateUI(slot0)
	slot1 = slot0._isLock or slot0._isPlayUnLockAnim == false

	gohelper.setActive(slot0._goUnLocked, not slot1)
	gohelper.setActive(slot0._goLocked, slot1)
	gohelper.setActive(slot0._btnPlay, slot0._isShowStoryPlay)
end

function slot0._playAnim(slot0, slot1)
	if slot0._animator then
		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0.playUnlockAnim(slot0)
	if slot0._isLock == false and slot0._isPlayUnLockAnim == false then
		slot0._isPlayUnLockAnim = true

		slot0:_playAnim("unlock")
		gohelper.setActive(slot0._goUnLocked, true)
		gohelper.setActive(slot0._goLocked, true)
		TaskDispatcher.runDelay(slot0._refreshStateUI, slot0, 0.8)
		slot0:_setUnLockAnim(slot0:getEpisodeId(), true)
		AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_unlock)
	end
end

function slot0.playFinish(slot0)
	slot0:_playAnim("finish")
end

function slot0._checkShowStory(slot0)
	if slot0._stroyIds and #slot0._stroyIds > 0 then
		for slot4, slot5 in ipairs(slot0._stroyIds) do
			if StoryModel.instance:isStoryHasPlayed(slot5) then
				return true
			end
		end
	end

	return false
end

function slot0._isPlayedUnLock(slot0, slot1)
	return PlayerPrefsHelper.getNumber(slot0:_getLockAnimKey(slot1), 0) == 1
end

function slot0._getLockAnimKey(slot0, slot1)
	return string.format("AiZiLaStageItem_PLAY_UNLOCK_ANIM_KEY_%s_%s_%s", PlayerModel.instance:getPlayinfo().userId, VersionActivity1_5Enum.ActivityId.AiZiLa, slot1)
end

function slot0._setUnLockAnim(slot0, slot1)
	return PlayerPrefsHelper.setNumber(slot0:_getLockAnimKey(slot1), 1)
end

slot0.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_stageitem.prefab"

return slot0
