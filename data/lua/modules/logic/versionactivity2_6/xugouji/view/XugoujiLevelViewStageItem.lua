local var_0_0 = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiLevelViewStageItem", package.seeall)

local var_0_1 = class("XugoujiLevelViewStageItem", LuaCompBase)
local var_0_2 = VersionActivity2_6Enum.ActivityId.Xugouji

function var_0_1.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1

	gohelper.setActive(arg_1_0.viewGO, true)

	arg_1_0._goStageType1Item = gohelper.findChild(arg_1_0.viewGO, "#go_StageType1")
	arg_1_0._goStageType2Item = gohelper.findChild(arg_1_0.viewGO, "#go_StageType2")
	arg_1_0._goStageType1Lock = gohelper.findChild(arg_1_0._goStageType1Item, "#go_Lock")
	arg_1_0._goStageType2Lock = gohelper.findChild(arg_1_0._goStageType2Item, "#go_Lock")
	arg_1_0._animator = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._imageStageIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_StageType1")
	arg_1_0._imageStageIconLock = gohelper.findChildImage(arg_1_0.viewGO, "#go_StageType1/#go_Lock")
	arg_1_0._txtType1StageName = gohelper.findChildText(arg_1_0.viewGO, "#go_StageType1/#txt_StageName")
	arg_1_0._txtType1StageNum = gohelper.findChildText(arg_1_0.viewGO, "#go_StageType1/#txt_ChapterNum")
	arg_1_0._txtType2StageNum = gohelper.findChildText(arg_1_0.viewGO, "#go_StageType2/#txt_ChapterNum")
	arg_1_0._goCompleteEffect = gohelper.findChild(arg_1_0.viewGO, "vx_complete")
	arg_1_0._completeEffectAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0._goCompleteEffect)
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClick")

	arg_1_0:_addEvents()
end

function var_0_1.refreshItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._actId = VersionActivity2_6Enum.ActivityId.Xugouji
	arg_2_0._index = arg_2_2
	arg_2_0._config = arg_2_1
	arg_2_0.episodeId = arg_2_0._config.episodeId

	if arg_2_0.episodeId == XugoujiEnum.ChallengeEpisodeId then
		gohelper.setActive(arg_2_0.viewGO, false)

		return
	end

	arg_2_0._stageType = arg_2_1.gameId ~= 0 and XugoujiEnum.LevelType.Level or XugoujiEnum.LevelType.Story

	local var_2_0 = Activity188Model.instance:getCurEpisodeId()

	arg_2_0:refreshTitle()

	local var_2_1

	var_2_1 = arg_2_0._config.mapId ~= 0

	local var_2_2 = Activity188Model.instance:isEpisodeFinished(arg_2_0.episodeId)
	local var_2_3 = Activity188Model.instance:isEpisodeUnlock(arg_2_0.episodeId)

	if not string.nilorempty(arg_2_1.resource) then
		UISpriteSetMgr.instance:setXugoujiSprite(arg_2_0._imageStageIcon, arg_2_1.resource)
		UISpriteSetMgr.instance:setXugoujiSprite(arg_2_0._imageStageIconLock, arg_2_1.resource)
	end

	gohelper.setActive(arg_2_0._goStageType1Item, arg_2_0._stageType == XugoujiEnum.LevelType.Story)
	gohelper.setActive(arg_2_0._goStageType2Item, arg_2_0._stageType == XugoujiEnum.LevelType.Level)
	gohelper.setActive(arg_2_0._goStageType1Lock, not var_2_3)
	gohelper.setActive(arg_2_0._goStageType2Lock, not var_2_3)
	gohelper.setActive(arg_2_0._goCompleteEffect, var_2_2)
	arg_2_0._completeEffectAnimator:Play(var_0_0.Idle, nil, nil)
end

function var_0_1.refreshTitle(arg_3_0)
	arg_3_0._txtType1StageName.text = arg_3_0._config.name
	arg_3_0._txtType1StageNum.text = string.format("%02d", arg_3_0._index)
	arg_3_0._txtType2StageNum.text = string.format("%02d", arg_3_0._index)
end

function var_0_1.addEventListeners(arg_4_0)
	arg_4_0._btnclick:AddClickListener(arg_4_0._btnclickOnClick, arg_4_0)
end

function var_0_1.removeEventListeners(arg_5_0)
	if arg_5_0._btnclick then
		arg_5_0._btnclick:RemoveClickListener()
	end
end

function var_0_1._btnclickOnClick(arg_6_0)
	if arg_6_0:checkIsOpen() then
		arg_6_0:_delayEnterEpisode()
	end
end

function var_0_1.checkIsOpen(arg_7_0)
	local var_7_0 = ActivityModel.instance:getActMO(var_0_2)
	local var_7_1 = true

	if var_7_0 == nil then
		logError("not such activity id: " .. arg_7_0.actId)

		var_7_1 = false
	end

	if not var_7_0:isOpen() or var_7_0:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		var_7_1 = false
	end

	if not Activity188Model.instance:isEpisodeUnlock(arg_7_0.episodeId) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		var_7_1 = false
	end

	return var_7_1
end

function var_0_1._delayEnterEpisode(arg_8_0)
	if not arg_8_0._config then
		return
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.BeforeEnterEpisode)
	TaskDispatcher.runDelay(arg_8_0._enterGameView, arg_8_0, 0.1)
end

function var_0_1._enterGameView(arg_9_0)
	XugoujiController.instance:enterEpisode(arg_9_0.episodeId)
end

function var_0_1._addEvents(arg_10_0)
	XugoujiController.instance:registerCallback(XugoujiEvent.EnterEpisode, arg_10_0._onEnterEpisode, arg_10_0)
end

function var_0_1._removeEvents(arg_11_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.EnterEpisode, arg_11_0._onEnterEpisode, arg_11_0)
end

function var_0_1.playFinishAni(arg_12_0)
	arg_12_0:refreshItem(arg_12_0._config, arg_12_0._index)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.episodeFinish)
	arg_12_0._animator:Play(var_0_0.Finish, 0, 0)
	arg_12_0._completeEffectAnimator:Play(var_0_0.Open, nil, nil)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function var_0_1.playUnlockAni(arg_13_0)
	arg_13_0:refreshItem(arg_13_0._config, arg_13_0._index)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.episodeUnlock)
	arg_13_0._animator:Play(var_0_0.Unlock, 0, 0)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_activity_hero37_checkpoint_tongguan)
end

function var_0_1._onEnterEpisode(arg_14_0, arg_14_1)
	if arg_14_0.episodeId ~= arg_14_1 then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_6XugoujiSelect .. var_0_2, tostring(arg_14_0._index))

	if arg_14_0._config.gameId and arg_14_0._config.gameId ~= 0 then
		local var_14_0 = arg_14_0._config.storyId == 0
		local var_14_1 = Activity188Model.instance:getCurEpisodeId() == arg_14_1

		if var_14_0 or var_14_1 then
			arg_14_0:_storyEnd()
		else
			StoryController.instance:playStory(arg_14_0._config.storyId, nil, arg_14_0._storyEnd, arg_14_0)
		end
	elseif arg_14_0._config.storyId == 0 then
		arg_14_0:_storyEnd()
	else
		StoryController.instance:playStory(arg_14_0._config.storyId, nil, arg_14_0._storyEnd, arg_14_0)
	end

	Activity188Model.instance:setCurEpisodeId(arg_14_1)
end

function var_0_1._storyEnd(arg_15_0)
	if arg_15_0._config.gameId and arg_15_0._config.gameId ~= 0 then
		XugoujiGameStepController.instance:insertStepListClient({
			{
				stepType = XugoujiEnum.GameStepType.WaitGameStart
			},
			{
				stepType = XugoujiEnum.GameStepType.UpdateInitialCard
			}
		})
		XugoujiController.instance:openXugoujiGameView()
	else
		XugoujiController.instance:finishStoryPlay()
	end
end

function var_0_1.onDestroy(arg_16_0)
	arg_16_0:_removeEvents()
	arg_16_0:removeEventListeners()
end

return var_0_1
