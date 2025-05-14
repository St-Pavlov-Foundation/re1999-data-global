module("modules.logic.versionactivity1_5.act142.view.Activity142StoryItem", package.seeall)

local var_0_0 = class("Activity142StoryItem", ListScrollCellExtend)
local var_0_1 = 0.25

function var_0_0.onInitView(arg_1_0)
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "normal")
	arg_1_0._txtUnlockNum = gohelper.findChildText(arg_1_0.viewGO, "normal/txt_titlenum")
	arg_1_0._imageUnlockStoryIcon = gohelper.findChildImage(arg_1_0.viewGO, "normal/icon_bg/icon_story")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "normal/middle/txt_name")
	arg_1_0._txtNameEn = gohelper.findChildText(arg_1_0.viewGO, "normal/middle/txt_name_en")
	arg_1_0._btnReplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "normal/bottom/btn_replay")
	arg_1_0._goUnlockEff = gohelper.findChild(arg_1_0.viewGO, "unlock")
	arg_1_0._goLock = gohelper.findChild(arg_1_0.viewGO, "locked")
	arg_1_0._txtLockNum = gohelper.findChildText(arg_1_0.viewGO, "locked/txt_titlenum")
	arg_1_0._imageLockStoryIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "locked/icon_bg/icon_story")
	arg_1_0._btnLockReplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "locked/bottom/btn_replay")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnReplay:AddClickListener(arg_2_0._btnReviewOnClick, arg_2_0)
	arg_2_0._btnLockReplay:AddClickListener(arg_2_0._btnReviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnReplay:RemoveClickListener()
	arg_3_0._btnLockReplay:RemoveClickListener()
end

function var_0_0._btnReviewOnClick(arg_4_0)
	if not arg_4_0._storyMO then
		return
	end

	local var_4_0 = arg_4_0._storyMO.storyId

	if not StoryModel.instance:isStoryHasPlayed(var_4_0) then
		GameFacade.showToast(ToastEnum.Va3Act122StoryIsLock)

		return
	end

	local var_4_1 = {}

	var_4_1.hideStartAndEndDark = true

	StoryController.instance:playStory(var_4_0, var_4_1)
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goNormal, false)
	gohelper.setActive(arg_5_0._goLock, false)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._storyMO = arg_6_1

	arg_6_0:_refreshUI()
end

function var_0_0._refreshUI(arg_7_0)
	if not arg_7_0._storyMO then
		return
	end

	gohelper.setActive(arg_7_0._goUnlockEff, false)

	local var_7_0 = arg_7_0._storyMO.storyId
	local var_7_1 = Activity142Model.instance:getActivityId()
	local var_7_2 = Activity142Config.instance:getAct142StoryCfg(var_7_1, var_7_0)

	if not var_7_2 then
		return
	end

	local var_7_3 = StoryModel.instance:isStoryHasPlayed(var_7_0)

	if var_7_3 and not string.nilorempty(var_7_2.icon) then
		UISpriteSetMgr.instance:setV1a5ChessSprite(arg_7_0._imageUnlockStoryIcon, var_7_2.icon)
	end

	local var_7_4 = string.format("%02d", arg_7_0._storyMO.index)

	arg_7_0._txtUnlockNum.text = var_7_4
	arg_7_0._txtName.text = var_7_2.name
	arg_7_0._txtNameEn.text = var_7_3 and var_7_2.nameen or "UNKNOWN"
	arg_7_0._txtLockNum.text = var_7_4

	local var_7_5 = arg_7_0._animatorPlayer and arg_7_0._animatorPlayer.isActiveAndEnabled

	if var_7_5 then
		arg_7_0._animatorPlayer:Play(Activity142Enum.STORY_REVIEW_IDLE_ANIM)
	end

	local var_7_6 = string.format("%s_%s", Activity142Enum.STORY_REVIEW__CACHE_KEY, var_7_0)

	if not Activity142Controller.instance:havePlayedUnlockAni(var_7_6) and var_7_5 and var_7_3 then
		Activity142Helper.setAct142UIBlock(true, Activity142Enum.STORY_REVIEW_UNLOCK)
		gohelper.setActive(arg_7_0._goNormal, true)
		gohelper.setActive(arg_7_0._goLock, true)
		TaskDispatcher.runDelay(arg_7_0.playUnlockAudio, arg_7_0, var_0_1)
		arg_7_0._animatorPlayer:Play(Activity142Enum.STORY_REVIEW_UNLOCK_ANIM, arg_7_0._finishUnlockAnim, arg_7_0)
	else
		gohelper.setActive(arg_7_0._goNormal, var_7_3)
		gohelper.setActive(arg_7_0._goLock, not var_7_3)
	end
end

function var_0_0.playUnlockAudio(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity142.UnlockItem)
end

function var_0_0._finishUnlockAnim(arg_9_0)
	local var_9_0 = arg_9_0._storyMO.storyId
	local var_9_1 = string.format("%s_%s", Activity142Enum.STORY_REVIEW__CACHE_KEY, var_9_0)

	Activity142Controller.instance:setPlayedUnlockAni(var_9_1)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.STORY_REVIEW_UNLOCK)
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.playUnlockAudio, arg_10_0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.STORY_REVIEW_UNLOCK)
end

return var_0_0
