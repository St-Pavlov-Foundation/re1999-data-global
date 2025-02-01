module("modules.logic.versionactivity1_5.act142.view.Activity142StoryItem", package.seeall)

slot0 = class("Activity142StoryItem", ListScrollCellExtend)
slot1 = 0.25

function slot0.onInitView(slot0)
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._goNormal = gohelper.findChild(slot0.viewGO, "normal")
	slot0._txtUnlockNum = gohelper.findChildText(slot0.viewGO, "normal/txt_titlenum")
	slot0._imageUnlockStoryIcon = gohelper.findChildImage(slot0.viewGO, "normal/icon_bg/icon_story")
	slot0._txtName = gohelper.findChildText(slot0.viewGO, "normal/middle/txt_name")
	slot0._txtNameEn = gohelper.findChildText(slot0.viewGO, "normal/middle/txt_name_en")
	slot0._btnReplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "normal/bottom/btn_replay")
	slot0._goUnlockEff = gohelper.findChild(slot0.viewGO, "unlock")
	slot0._goLock = gohelper.findChild(slot0.viewGO, "locked")
	slot0._txtLockNum = gohelper.findChildText(slot0.viewGO, "locked/txt_titlenum")
	slot0._imageLockStoryIcon = gohelper.findChildSingleImage(slot0.viewGO, "locked/icon_bg/icon_story")
	slot0._btnLockReplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "locked/bottom/btn_replay")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnReplay:AddClickListener(slot0._btnReviewOnClick, slot0)
	slot0._btnLockReplay:AddClickListener(slot0._btnReviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnReplay:RemoveClickListener()
	slot0._btnLockReplay:RemoveClickListener()
end

function slot0._btnReviewOnClick(slot0)
	if not slot0._storyMO then
		return
	end

	if not StoryModel.instance:isStoryHasPlayed(slot0._storyMO.storyId) then
		GameFacade.showToast(ToastEnum.Va3Act122StoryIsLock)

		return
	end

	StoryController.instance:playStory(slot1, {
		hideStartAndEndDark = true
	})
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goNormal, false)
	gohelper.setActive(slot0._goLock, false)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._storyMO = slot1

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if not slot0._storyMO then
		return
	end

	gohelper.setActive(slot0._goUnlockEff, false)

	if not Activity142Config.instance:getAct142StoryCfg(Activity142Model.instance:getActivityId(), slot0._storyMO.storyId) then
		return
	end

	if StoryModel.instance:isStoryHasPlayed(slot1) and not string.nilorempty(slot3.icon) then
		UISpriteSetMgr.instance:setV1a5ChessSprite(slot0._imageUnlockStoryIcon, slot3.icon)
	end

	slot0._txtUnlockNum.text = string.format("%02d", slot0._storyMO.index)
	slot0._txtName.text = slot3.name
	slot0._txtNameEn.text = slot4 and slot3.nameen or "UNKNOWN"
	slot0._txtLockNum.text = slot5

	if slot0._animatorPlayer and slot0._animatorPlayer.isActiveAndEnabled then
		slot0._animatorPlayer:Play(Activity142Enum.STORY_REVIEW_IDLE_ANIM)
	end

	if not Activity142Controller.instance:havePlayedUnlockAni(string.format("%s_%s", Activity142Enum.STORY_REVIEW__CACHE_KEY, slot1)) and slot6 and slot4 then
		Activity142Helper.setAct142UIBlock(true, Activity142Enum.STORY_REVIEW_UNLOCK)
		gohelper.setActive(slot0._goNormal, true)
		gohelper.setActive(slot0._goLock, true)
		TaskDispatcher.runDelay(slot0.playUnlockAudio, slot0, uv0)
		slot0._animatorPlayer:Play(Activity142Enum.STORY_REVIEW_UNLOCK_ANIM, slot0._finishUnlockAnim, slot0)
	else
		gohelper.setActive(slot0._goNormal, slot4)
		gohelper.setActive(slot0._goLock, not slot4)
	end
end

function slot0.playUnlockAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockItem)
end

function slot0._finishUnlockAnim(slot0)
	Activity142Controller.instance:setPlayedUnlockAni(string.format("%s_%s", Activity142Enum.STORY_REVIEW__CACHE_KEY, slot0._storyMO.storyId))
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.STORY_REVIEW_UNLOCK)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.playUnlockAudio, slot0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.STORY_REVIEW_UNLOCK)
end

return slot0
