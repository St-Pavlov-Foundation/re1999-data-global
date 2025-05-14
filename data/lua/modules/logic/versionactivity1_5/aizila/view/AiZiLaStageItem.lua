module("modules.logic.versionactivity1_5.aizila.view.AiZiLaStageItem", package.seeall)

local var_0_0 = class("AiZiLaStageItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goUnLocked = gohelper.findChild(arg_1_0.viewGO, "Root/#go_UnLocked")
	arg_1_0._txtStageName = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_UnLocked/Info/#txt_StageName")
	arg_1_0._btnPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#go_UnLocked/Info/#txt_StageName/#btn_Play")
	arg_1_0._txtStageNum = gohelper.findChildText(arg_1_0.viewGO, "Root/#go_UnLocked/Info/#txt_StageNum")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Locked")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPlay:AddClickListener(arg_2_0._btnPlayOnClick, arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPlay:RemoveClickListener()
	arg_3_0._btnClick:RemoveClickListener()
end

function var_0_0._btnPlayOnClick(arg_4_0)
	if arg_4_0._stroyIds and #arg_4_0._stroyIds > 0 then
		if #arg_4_0._stroyIds == 1 then
			AiZiLaGameController.instance:playStory(arg_4_0._stroyIds[1])
		else
			AiZiLaController.instance:openStoryView(arg_4_0._config.episodeId)
		end
	end
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEvents()
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0:removeEvents()
end

function var_0_0._btnClickOnClick(arg_7_0)
	if AiZiLaModel.instance:getEpisodeMO(arg_7_0._config.episodeId) then
		AiZiLaController.instance:openEpsiodeDetailView(arg_7_0._config.episodeId)
	else
		GameFacade.showToast(ToastEnum.V1a5AiZiLaEpisodeNotOpen, arg_7_0._config.unlockDesc)
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._txtLockStageNum = gohelper.findChildText(arg_8_0.viewGO, "Root/#go_Locked/Info/#txt_StageNum")
	arg_8_0._goRoot = gohelper.findChild(arg_8_0.viewGO, "Root")
	arg_8_0._animator = arg_8_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
end

function var_0_0.onDestroy(arg_9_0)
	return
end

function var_0_0.setCfg(arg_10_0, arg_10_1)
	arg_10_0._config = arg_10_1
	arg_10_0._stroyIds = {}

	if arg_10_1 then
		if arg_10_1.storyBefore and arg_10_1.storyBefore ~= 0 then
			table.insert(arg_10_0._stroyIds, arg_10_1.storyBefore)
		end

		if arg_10_1.storyClear and arg_10_1.storyClear ~= 0 then
			table.insert(arg_10_0._stroyIds, arg_10_1.storyClear)
		end
	end

	arg_10_0._isPlayUnLockAnim = nil
end

function var_0_0.getEpisodeId(arg_11_0)
	return arg_11_0._config and arg_11_0._config.episodeId
end

function var_0_0.refreshUI(arg_12_0)
	gohelper.setActive(arg_12_0._goRoot, arg_12_0._config ~= nil)

	if arg_12_0._config then
		arg_12_0._txtStageName.text = arg_12_0._config.name
		arg_12_0._txtStageNum.text = arg_12_0._config.nameen
		arg_12_0._txtLockStageNum.text = arg_12_0._config.nameen
		arg_12_0._isLock = AiZiLaModel.instance:getEpisodeMO(arg_12_0._config.episodeId) == nil

		if arg_12_0._isPlayUnLockAnim == nil then
			arg_12_0._isPlayUnLockAnim = arg_12_0:_isPlayedUnLock(arg_12_0._config.episodeId)
		end

		if arg_12_0._isLock then
			arg_12_0._isPlayUnLockAnim = false
		end

		arg_12_0._isShowStoryPlay = arg_12_0:_checkShowStory()

		arg_12_0:_refreshStateUI()
	end
end

function var_0_0._refreshStateUI(arg_13_0)
	local var_13_0 = arg_13_0._isLock or arg_13_0._isPlayUnLockAnim == false

	gohelper.setActive(arg_13_0._goUnLocked, not var_13_0)
	gohelper.setActive(arg_13_0._goLocked, var_13_0)
	gohelper.setActive(arg_13_0._btnPlay, arg_13_0._isShowStoryPlay)
end

function var_0_0._playAnim(arg_14_0, arg_14_1)
	if arg_14_0._animator then
		arg_14_0._animator:Play(arg_14_1, 0, 0)
	end
end

function var_0_0.playUnlockAnim(arg_15_0)
	if arg_15_0._isLock == false and arg_15_0._isPlayUnLockAnim == false then
		arg_15_0._isPlayUnLockAnim = true

		arg_15_0:_playAnim("unlock")
		gohelper.setActive(arg_15_0._goUnLocked, true)
		gohelper.setActive(arg_15_0._goLocked, true)
		TaskDispatcher.runDelay(arg_15_0._refreshStateUI, arg_15_0, 0.8)
		arg_15_0:_setUnLockAnim(arg_15_0:getEpisodeId(), true)
		AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_unlock)
	end
end

function var_0_0.playFinish(arg_16_0)
	arg_16_0:_playAnim("finish")
end

function var_0_0._checkShowStory(arg_17_0)
	if arg_17_0._stroyIds and #arg_17_0._stroyIds > 0 then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._stroyIds) do
			if StoryModel.instance:isStoryHasPlayed(iter_17_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0._isPlayedUnLock(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:_getLockAnimKey(arg_18_1)

	return PlayerPrefsHelper.getNumber(var_18_0, 0) == 1
end

function var_0_0._getLockAnimKey(arg_19_0, arg_19_1)
	local var_19_0 = PlayerModel.instance:getPlayinfo().userId
	local var_19_1 = VersionActivity1_5Enum.ActivityId.AiZiLa

	return string.format("AiZiLaStageItem_PLAY_UNLOCK_ANIM_KEY_%s_%s_%s", var_19_0, var_19_1, arg_19_1)
end

function var_0_0._setUnLockAnim(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:_getLockAnimKey(arg_20_1)

	return PlayerPrefsHelper.setNumber(var_20_0, 1)
end

var_0_0.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_stageitem.prefab"

return var_0_0
