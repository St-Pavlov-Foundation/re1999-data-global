module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicChapterItem", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicChapterItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSpecial = gohelper.findChild(arg_1_0.viewGO, "root/#go_Special")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_num")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "root/image_txtBG/#txt_name")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "root/image_txtBG/#txt_name/#txt_en")
	arg_1_0._imagestargray = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_stargray")
	arg_1_0._imagestarlight = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_starlight")
	arg_1_0._imagecurrentdown = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_currentdown")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._hasOpen then
		GameFacade.showToast(ToastEnum.PreLevelNotCompleted)

		return
	end

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.ClickChapterItem, arg_4_0._episodeId)
end

function var_0_0._onClickHandler(arg_5_0)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_4MusicSelectEpisode, arg_5_0._episodeId)

	if arg_5_0._episodeConfig.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Story then
		StoryController.instance:playStory(arg_5_0._episodeConfig.storyBefore, nil, arg_5_0._onFinishStory, arg_5_0)

		if not arg_5_0._hasFinished then
			Activity179Rpc.instance:sendSet179ScoreRequest(Activity179Model.instance:getActivityId(), arg_5_0._episodeId, 0)
		end

		return
	end

	if arg_5_0._episodeConfig.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Beat then
		if not StoryModel.instance:isStoryFinished(arg_5_0._episodeConfig.storyBefore) or arg_5_0._hasFinished then
			StoryController.instance:playStory(arg_5_0._episodeConfig.storyBefore, nil, arg_5_0._enterBeatView, arg_5_0)
		else
			arg_5_0:_enterBeatView()
		end
	end
end

function var_0_0._enterBeatView(arg_6_0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatView(arg_6_0._episodeId)
end

function var_0_0._onFinishStory(arg_7_0)
	if not arg_7_0._hasFinished then
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EpisodeStoryBeforeFinished)
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._canvas = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(arg_8_0._imagecurrentdown, false)
	arg_8_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ClickChapterItem, arg_8_0._onClickChapterItem, arg_8_0)
end

function var_0_0._onClickChapterItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._isSelected

	arg_9_0._isSelected = arg_9_0._episodeId == arg_9_1

	gohelper.setActive(arg_9_0._imagecurrentdown, arg_9_0._isSelected)

	if arg_9_0._episodeId == arg_9_1 then
		local var_9_1 = 0.3

		TaskDispatcher.cancelTask(arg_9_0._onClickHandler, arg_9_0)
		TaskDispatcher.runDelay(arg_9_0._onClickHandler, arg_9_0, var_9_1)
		UIBlockHelper.instance:startBlock("VersionActivity2_4MusicChapterItem ClickChapterItem", var_9_1)
	end

	if not var_9_0 and arg_9_0._isSelected then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_unlock)
	end
end

function var_0_0._editableAddEvents(arg_10_0)
	return
end

function var_0_0._editableRemoveEvents(arg_11_0)
	return
end

function var_0_0.getEpisodeId(arg_12_0)
	return arg_12_0._episodeId
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1)
	arg_13_0._episodeConfig = arg_13_1
	arg_13_0._episodeId = arg_13_0._episodeConfig.id
	arg_13_0._txtname.text = arg_13_0._episodeConfig.name
	arg_13_0._txten.text = arg_13_0._episodeConfig.name_En
	arg_13_0._txtnum.text = arg_13_0._episodeConfig.orderId

	local var_13_0 = arg_13_0._episodeConfig.episodeType == VersionActivity2_4MusicEnum.EpisodeType.Beat

	gohelper.setActive(arg_13_0._goSpecial, var_13_0)
	arg_13_0:updateSelectedFlag()
	arg_13_0:updateView()
end

function var_0_0.updateSelectedFlag(arg_14_0)
	arg_14_0._isSelected = Activity179Model.instance:getSelectedEpisodeId() == arg_14_0._episodeId

	gohelper.setActive(arg_14_0._imagecurrentdown, arg_14_0._isSelected)
end

function var_0_0.updateView(arg_15_0)
	arg_15_0._hasOpen = arg_15_0._episodeConfig.preEpisode == 0 or Activity179Model.instance:episodeIsFinished(arg_15_0._episodeConfig.preEpisode)
	arg_15_0._hasFinished = Activity179Model.instance:episodeIsFinished(arg_15_0._episodeId)

	gohelper.setActive(arg_15_0._imagestargray, not arg_15_0._hasFinished)
	gohelper.setActive(arg_15_0._imagestarlight, arg_15_0._hasFinished)

	arg_15_0._canvas.alpha = arg_15_0._hasFinished and 1 or 0.8
end

function var_0_0.getHasFinished(arg_16_0)
	return arg_16_0._hasFinished
end

function var_0_0.getHasOpened(arg_17_0)
	return arg_17_0._hasOpen
end

function var_0_0.onDestroyView(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._onClickHandler, arg_18_0)
end

return var_0_0
