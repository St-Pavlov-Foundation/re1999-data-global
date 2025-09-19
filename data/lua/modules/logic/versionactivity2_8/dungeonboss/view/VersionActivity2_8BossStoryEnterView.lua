module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_8BossStoryEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagedecbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_decbg")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_langtxt")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddot")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_start")
	arg_1_0._btncontinue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_continue")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._btnmap = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_map")
	arg_1_0._gosnow = gohelper.findChild(arg_1_0.viewGO, "#go_snow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btncontinue:AddClickListener(arg_2_0._btncontinueOnClick, arg_2_0)
	arg_2_0._btnmap:AddClickListener(arg_2_0._btnmapOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btncontinue:RemoveClickListener()
	arg_3_0._btnmap:RemoveClickListener()
end

function var_0_0._btnmapOnClick(arg_4_0)
	return
end

function var_0_0._btnresetOnClick(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.BossStoryTip2, MsgBoxEnum.BoxType.Yes_No, function()
		VersionActivity2_8BossRpc.instance:sendBossFightResetChapterRequest(DungeonEnum.ChapterId.BossStory, arg_5_0._onResetHandler, arg_5_0)
	end, nil, nil)
end

function var_0_0._onResetHandler(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 ~= 0 then
		return
	end

	arg_7_0:_updateStars()
end

function var_0_0._btntaskOnClick(arg_8_0)
	VersionActivity2_8DungeonController.instance:openTaskView()
end

function var_0_0._btnstartOnClick(arg_9_0)
	arg_9_0:_enterFight()
end

function var_0_0._btncontinueOnClick(arg_10_0)
	arg_10_0:_enterFight()
end

function var_0_0._enterFight(arg_11_0)
	if not arg_11_0._episodeId then
		logError("VersionActivity2_8BossStoryEnterView:_enterFight episodeId is nil")

		return
	end

	if arg_11_0:_checkAfterStoryFinish() then
		return
	end

	if arg_11_0._episodeId == VersionActivity2_8BossEnum.StoryBossSecondEpisode and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(VersionActivity2_8BossEnum.StoryBossSecondEpisodeGuideId) then
		StoryController.instance:playStory(VersionActivity2_8BossEnum.StoryBoss_EpisodeStoryId, nil, arg_11_0._startEnterFight, arg_11_0)

		return
	end

	arg_11_0:_startEnterFight()
end

function var_0_0._checkAfterStoryFinish(arg_12_0)
	if not DungeonModel.instance:hasPassLevel(arg_12_0._episodeId) then
		return false
	end

	local var_12_0 = DungeonConfig.instance:getEpisodeCO(arg_12_0._episodeId)

	if var_12_0.afterStory > 0 and not StoryModel.instance:isStoryFinished(var_12_0.afterStory) then
		local var_12_1 = {}

		var_12_1.mark = true
		var_12_1.episodeId = arg_12_0._episodeId

		StoryController.instance:playStory(var_12_0.afterStory, var_12_1, function()
			arg_12_0:closeThis()
			VersionActivity2_8DungeonBossController.instance:forceFinishElement()
		end)

		return true
	end

	return false
end

function var_0_0._startEnterFight(arg_14_0)
	VersionActivity2_8BossModel.instance:enterBossStoryFight(arg_14_0._episodeId)

	local var_14_0 = DungeonConfig.instance:getEpisodeCO(arg_14_0._episodeId)

	DungeonFightController.instance:enterFight(var_14_0.chapterId, arg_14_0._episodeId)
end

function var_0_0._editableInitView(arg_15_0)
	gohelper.setActive(arg_15_0._btncontinue, false)
	gohelper.setActive(arg_15_0._btnstart, false)
	gohelper.setActive(arg_15_0._btntask, false)
	gohelper.setActive(arg_15_0._btnreset, false)
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onRefreshActivityState(arg_17_0)
	local var_17_0 = false

	gohelper.setActive(arg_17_0._btntask, var_17_0)
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_18_0.onRefreshActivityState, arg_18_0)
	arg_18_0:onRefreshActivityState()
	gohelper.setActive(arg_18_0._btnstart, true)
	arg_18_0:_initStars()
	arg_18_0:_updateStars()
end

function var_0_0._initStars(arg_19_0)
	if arg_19_0._lightList then
		return
	end

	local var_19_0 = arg_19_0._goprogress.transform
	local var_19_1 = var_19_0.childCount

	arg_19_0._lightList = arg_19_0:getUserDataTb_()

	for iter_19_0 = 0, var_19_1 - 1 do
		local var_19_2 = var_19_0:GetChild(iter_19_0):GetChild(0).gameObject

		gohelper.setActive(var_19_2, false)
		table.insert(arg_19_0._lightList, var_19_2)
	end
end

function var_0_0._updateStars(arg_20_0)
	local var_20_0 = DungeonConfig.instance:getChapterEpisodeCOList(DungeonEnum.ChapterId.BossStory)

	arg_20_0._episodeId = nil

	local var_20_1 = 0

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		local var_20_2 = DungeonModel.instance:hasPassLevelAndStory(iter_20_1.id)

		if not var_20_2 and not arg_20_0._episodeId then
			arg_20_0._episodeId = iter_20_1.id
		end

		local var_20_3 = arg_20_0._lightList[iter_20_0]

		gohelper.setActive(var_20_3, var_20_2)

		if var_20_2 then
			var_20_1 = var_20_1 + 1
		end
	end

	gohelper.setActive(arg_20_0._btnreset, var_20_1 > 0)
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
