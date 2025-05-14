module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapLevelBaseView", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapLevelBaseView", BaseView)

function var_0_0._btnreplayStoryOnClick(arg_1_0)
	if not arg_1_0.storyIdList or #arg_1_0.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(arg_1_0.storyIdList)
end

function var_0_0.refreshStoryIdList(arg_2_0)
	local var_2_0 = arg_2_0._episode_list[1]

	if var_2_0.type == DungeonEnum.EpisodeType.Story then
		arg_2_0.storyIdList = nil

		return
	end

	if arg_2_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		arg_2_0.storyIdList = nil

		return
	end

	arg_2_0.storyIdList = {}

	if var_2_0.beforeStory > 0 and StoryModel.instance:isStoryHasPlayed(var_2_0.beforeStory) then
		table.insert(arg_2_0.storyIdList, var_2_0.beforeStory)
	end

	if var_2_0.afterStory > 0 and StoryModel.instance:isStoryHasPlayed(var_2_0.afterStory) then
		table.insert(arg_2_0.storyIdList, var_2_0.afterStory)
	end
end

function var_0_0._btncloseviewOnClick(arg_3_0)
	arg_3_0:startCloseTaskNextFrame()
end

function var_0_0.startCloseTaskNextFrame(arg_4_0)
	TaskDispatcher.runDelay(arg_4_0.reallyClose, arg_4_0, 0.01)
end

function var_0_0.cancelStartCloseTask(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.reallyClose, arg_5_0)
end

function var_0_0.reallyClose(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnleftarrowOnClick(arg_7_0)
	if arg_7_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		return
	end

	if #arg_7_0._episode_list == 1 then
		return
	end

	if arg_7_0._cur_select_index <= 1 then
		return
	end

	arg_7_0._cur_select_index = arg_7_0._cur_select_index - 1

	arg_7_0:refreshUIByMode(arg_7_0._cur_select_index)
end

function var_0_0._btnrightarrowOnClick(arg_8_0)
	if arg_8_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		return
	end

	if #arg_8_0._episode_list == 1 then
		return
	end

	if arg_8_0._cur_select_index >= #arg_8_0._episode_list then
		return
	end

	arg_8_0._cur_select_index = arg_8_0._cur_select_index + 1

	arg_8_0:refreshUIByMode(arg_8_0._cur_select_index)
end

function var_0_0.refreshUIByMode(arg_9_0, arg_9_1)
	arg_9_0.animator:Play("switch", 0, 0)
	arg_9_0:_refreshSelectData(arg_9_1)
	arg_9_0:refreshUI()
end

function var_0_0._refreshSelectData(arg_10_0, arg_10_1)
	arg_10_0.showEpisodeCo = arg_10_0._episode_list[arg_10_1]

	if not arg_10_0.showEpisodeCo then
		arg_10_0._cur_select_index = 1
		arg_10_0.showEpisodeCo = arg_10_0._episode_list[arg_10_0._cur_select_index]
	end

	arg_10_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_10_0.showEpisodeCo.id)

	if not arg_10_0.showEpisodeMo then
		arg_10_0.showEpisodeMo = UserDungeonMO.New()

		arg_10_0.showEpisodeMo:initFromManual(arg_10_0.showEpisodeCo.chapterId, arg_10_0.showEpisodeCo.id, 0, 0)
	end

	arg_10_0._chapterConfig = DungeonConfig.instance:getChapterCO(arg_10_0.showEpisodeCo.chapterId)
	arg_10_0.modeCanFight = DungeonModel.instance:hasPassLevelAndStory(arg_10_0.showEpisodeCo.preEpisode) and DungeonModel.instance:isFinishElementList(arg_10_0.showEpisodeCo)

	local var_10_0 = FightHelper.getEpisodeRecommendLevel(arg_10_0.showEpisodeCo.id)

	gohelper.setActive(arg_10_0._gorecommond, var_10_0 > 0)

	if var_10_0 > 0 then
		arg_10_0._txtrecommondlv.text = HeroConfig.instance:getCommonLevelDisplay(var_10_0)
	end

	local var_10_1 = not DungeonModel.instance:isUnlock(arg_10_0.showEpisodeCo)

	gohelper.setActive(arg_10_0._golock, var_10_1)
	arg_10_0._lockAni:Play("idle")
end

function var_0_0._btnactivityrewardOnClick(arg_11_0)
	DungeonController.instance:openDungeonRewardView(arg_11_0.showEpisodeCo)
end

function var_0_0._btnnormalStartOnClick(arg_12_0)
	if not arg_12_0.modeCanFight then
		GameFacade.showToast(ToastEnum.VersionActivityCanFight, arg_12_0:getPreModeName())

		return
	end

	arg_12_0:startBattle()
end

function var_0_0._btnhardStartOnClick(arg_13_0)
	arg_13_0:startBattle()
end

function var_0_0._btncloseruleOnClick(arg_14_0)
	return
end

function var_0_0.startBattle(arg_15_0)
	if arg_15_0.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		arg_15_0:_playMainStory()

		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(arg_15_0.showEpisodeCo.id) then
		arg_15_0:_enterFight()

		return
	end

	if arg_15_0.showEpisodeCo.beforeStory > 0 and not StoryModel.instance:isStoryFinished(arg_15_0.showEpisodeCo.beforeStory) then
		arg_15_0:_playStoryAndEnterFight(arg_15_0.showEpisodeCo.beforeStory)

		return
	end

	if arg_15_0.showEpisodeMo.star <= DungeonEnum.StarType.None then
		arg_15_0:_enterFight()

		return
	end

	if arg_15_0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_15_0.showEpisodeCo.afterStory) then
		arg_15_0:playAfterStory(arg_15_0.showEpisodeCo.afterStory)

		return
	end

	arg_15_0:_enterFight()
end

function var_0_0._playMainStory(arg_16_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_16_0.showEpisodeCo.chapterId, arg_16_0.showEpisodeCo.id)

	local var_16_0 = {}

	var_16_0.mark = true
	var_16_0.episodeId = arg_16_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_16_0.showEpisodeCo.beforeStory, var_16_0, arg_16_0.onStoryFinished, arg_16_0)
end

function var_0_0.playAfterStory(arg_17_0, arg_17_1)
	local var_17_0 = {}

	var_17_0.mark = true
	var_17_0.episodeId = arg_17_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_17_1, var_17_0, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		arg_17_0:closeThis()
	end, arg_17_0)
end

function var_0_0._playStoryAndEnterFight(arg_19_0, arg_19_1)
	if StoryModel.instance:isStoryFinished(arg_19_1) then
		arg_19_0:_enterFight()

		return
	end

	local var_19_0 = {}

	var_19_0.mark = true
	var_19_0.episodeId = arg_19_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_19_1, var_19_0, arg_19_0._enterFight, arg_19_0)
end

function var_0_0._enterFight(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._episode_list) do
		var_0_0.setlastBattleEpisodeId2Index(iter_20_1.id, arg_20_0._cur_select_index)
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.enterFight, arg_20_0._episode_list[1].id)

	DungeonModel.instance.versionActivityChapterType = DungeonConfig.instance:getChapterTypeByEpisodeId(arg_20_0.showEpisodeCo.id)

	DungeonFightController.instance:enterFight(arg_20_0.showEpisodeCo.chapterId, arg_20_0.showEpisodeCo.id, 1)
end

function var_0_0.getlastBattleEpisodeId2Index(arg_21_0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleEpisodeId2Index .. "_" .. arg_21_0, 1)
end

function var_0_0.setlastBattleEpisodeId2Index(arg_22_0, arg_22_1)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleEpisodeId2Index .. "_" .. arg_22_0, arg_22_1)
end

function var_0_0.onStoryFinished(arg_23_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_23_0.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	arg_23_0:closeThis()
end

function var_0_0._onClueFlowDone(arg_24_0)
	arg_24_0:closeThis()
end

function var_0_0._editableInitView(arg_25_0)
	gohelper.setActive(arg_25_0._goactivityrewarditem, false)

	arg_25_0.storyGoType = arg_25_0._gotype1
	arg_25_0.story3GoType = arg_25_0._gotype2
	arg_25_0.story4GoType = arg_25_0._gotype3
	arg_25_0.hardGoType = arg_25_0._gotype4
	arg_25_0.rewardItems = {}

	arg_25_0._simageactivitynormalbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bg002"))
	arg_25_0._simageactivityhardbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bg003"))

	arg_25_0.goVersionActivity = gohelper.findChild(arg_25_0.viewGO, "anim/versionactivity")
	arg_25_0.animator = arg_25_0.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_26_0)
	gohelper.setActive(arg_26_0.viewGO, false)
	gohelper.setActive(arg_26_0.viewGO, true)
	arg_26_0:onOpen()
end

function var_0_0.onOpen(arg_27_0)
	arg_27_0.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(arg_27_0.viewParam.episodeId)
	arg_27_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_27_0.viewParam.episodeId)
	arg_27_0.isFromJump = arg_27_0.viewParam.isJump

	arg_27_0:initMode()

	arg_27_0.modeCanFight = true

	arg_27_0:refreshStoryIdList()
	arg_27_0:refreshBg()
	arg_27_0:refreshUI()
	VersionActivity1_2DungeonController.instance:setDungeonSelectedEpisodeId(arg_27_0._episode_list[1].id)
end

function var_0_0.getEpisodeUnlockAniFinish(arg_28_0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2EpisodeUnlockAniFinish .. "_" .. arg_28_0, 0)
end

function var_0_0.setEpisodeUnlockAniFinish(arg_29_0)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2EpisodeUnlockAniFinish .. "_" .. arg_29_0, 1)
end

function var_0_0.initMode(arg_30_0)
	local var_30_0 = var_0_0.getlastBattleEpisodeId2Index(arg_30_0.showEpisodeCo.id)

	arg_30_0.mode = VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[arg_30_0.showEpisodeCo.chapterId]
	arg_30_0._episode_list = {}
	arg_30_0._playUnlockAniIndex = nil

	local var_30_1 = DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(arg_30_0.showEpisodeCo.id)

	for iter_30_0, iter_30_1 in ipairs(DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(arg_30_0.showEpisodeCo.id)) do
		local var_30_2 = DungeonConfig.instance:getEpisodeCO(iter_30_1)

		table.insert(arg_30_0._episode_list, var_30_2)
	end

	if arg_30_0.isFromJump then
		if DungeonModel.instance:isUnlock(arg_30_0.showEpisodeCo) then
			for iter_30_2, iter_30_3 in ipairs(arg_30_0._episode_list) do
				if iter_30_3.id == arg_30_0.showEpisodeCo.id then
					arg_30_0._cur_select_index = iter_30_2

					break
				end
			end

			local var_30_3 = var_0_0.getEpisodeUnlockAniFinish(arg_30_0.showEpisodeCo.id)

			if not arg_30_0._playUnlockAniIndex and var_30_3 == 0 then
				arg_30_0._playUnlockAniIndex = arg_30_0._cur_select_index

				var_0_0.setEpisodeUnlockAniFinish(arg_30_0.showEpisodeCo.id)
			end
		end
	else
		for iter_30_4, iter_30_5 in ipairs(var_30_1) do
			local var_30_4 = DungeonConfig.instance:getEpisodeCO(iter_30_5)

			if iter_30_4 > 1 and DungeonModel.instance:isUnlock(var_30_4) then
				local var_30_5 = var_0_0.getEpisodeUnlockAniFinish(iter_30_5)

				if not arg_30_0._playUnlockAniIndex and var_30_5 == 0 then
					arg_30_0._playUnlockAniIndex = iter_30_4
					arg_30_0._cur_select_index = iter_30_4

					var_0_0.setEpisodeUnlockAniFinish(iter_30_5)
				end
			end
		end
	end

	arg_30_0._cur_select_index = arg_30_0._cur_select_index or var_30_0

	arg_30_0:_refreshSelectData(arg_30_0._cur_select_index)

	if arg_30_0._playUnlockAniIndex then
		gohelper.setActive(arg_30_0._golock, true)
		arg_30_0._lockAni:Play("unlock")
		TaskDispatcher.runDelay(arg_30_0._playUnlockAudio, arg_30_0, 1)
	end
end

function var_0_0._playUnlockAudio(arg_31_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
end

function var_0_0.refreshBg(arg_32_0)
	gohelper.setActive(arg_32_0._simageactivitynormalbg.gameObject, arg_32_0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard)
	gohelper.setActive(arg_32_0._simageactivityhardbg.gameObject, arg_32_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function var_0_0.refreshUI(arg_33_0)
	arg_33_0:refreshEpisodeTextInfo()
	arg_33_0:refreshStar()
	arg_33_0:refreshMode()
	arg_33_0:refreshArrow()
	arg_33_0:refreshReward()
	arg_33_0:refreshStartBtn()
end

function var_0_0.refreshEpisodeTextInfo(arg_34_0)
	arg_34_0._txtmapName.text = arg_34_0:buildEpisodeName()
	arg_34_0._txtmapNameEn.text = arg_34_0.showEpisodeCo.name_En
	arg_34_0._txtmapNum.text = string.format("%02d", VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(arg_34_0.showEpisodeCo.id))
	arg_34_0._txtactivitydesc.text = arg_34_0.showEpisodeCo.desc
end

function var_0_0.refreshStar(arg_35_0)
	local var_35_0 = arg_35_0.showEpisodeCo.id
	local var_35_1 = var_35_0 and DungeonModel.instance:hasPassLevelAndStory(var_35_0)
	local var_35_2 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_35_0)

	arg_35_0:setImage(arg_35_0._imagestar1, var_35_1)

	if string.nilorempty(var_35_2) then
		gohelper.setActive(arg_35_0._imagestar2.gameObject, false)
	else
		arg_35_0:setImage(arg_35_0._imagestar2, arg_35_0.showEpisodeMo.star >= DungeonEnum.StarType.Advanced)
	end
end

function var_0_0.refreshMode(arg_36_0)
	gohelper.setActive(arg_36_0.storyGoType, arg_36_0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and arg_36_0._cur_select_index == 1)
	gohelper.setActive(arg_36_0.story3GoType, arg_36_0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and arg_36_0._cur_select_index == 2)
	gohelper.setActive(arg_36_0.story4GoType, arg_36_0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and arg_36_0._cur_select_index == 3)
	gohelper.setActive(arg_36_0.hardGoType, arg_36_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function var_0_0.refreshArrow(arg_37_0)
	local var_37_0 = arg_37_0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and #arg_37_0._episode_list > 1

	gohelper.setActive(arg_37_0._btnleftarrow.gameObject, var_37_0)
	gohelper.setActive(arg_37_0._btnrightarrow.gameObject, var_37_0)

	if var_37_0 then
		arg_37_0._leftArrow = arg_37_0._leftArrow or gohelper.findChildImage(arg_37_0._btnleftarrow.gameObject, "left_arrow")
		arg_37_0._rightArrow = arg_37_0._rightArrow or gohelper.findChildImage(arg_37_0._btnrightarrow.gameObject, "right_arrow")

		SLFramework.UGUI.GuiHelper.SetColor(arg_37_0._leftArrow, arg_37_0._cur_select_index == 1 and "#8C8C8C" or "#FFFFFF")
		SLFramework.UGUI.GuiHelper.SetColor(arg_37_0._rightArrow, arg_37_0._cur_select_index == #arg_37_0._episode_list and "#8C8C8C" or "#FFFFFF")
	end
end

function var_0_0.refreshReward(arg_38_0)
	local var_38_0 = {}
	local var_38_1 = 0
	local var_38_2 = 0

	if arg_38_0.showEpisodeMo and arg_38_0.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_38_0, DungeonModel.instance:getEpisodeAdvancedBonus(arg_38_0.showEpisodeCo.id))

		var_38_2 = #var_38_0
	end

	if arg_38_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		tabletool.addValues(var_38_0, DungeonModel.instance:getEpisodeFirstBonus(arg_38_0.showEpisodeCo.id))

		var_38_1 = #var_38_0
	elseif arg_38_0.showEpisodeMo and arg_38_0.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_38_0, DungeonModel.instance:getEpisodeFirstBonus(arg_38_0.showEpisodeCo.id))

		var_38_1 = #var_38_0
	end

	tabletool.addValues(var_38_0, DungeonModel.instance:getEpisodeRewardDisplayList(arg_38_0.showEpisodeCo.id))

	local var_38_3 = #var_38_0

	gohelper.setActive(arg_38_0._gorewards, var_38_3 > 0)
	gohelper.setActive(arg_38_0._gonorewards, var_38_3 == 0)

	if var_38_3 == 0 then
		return
	end

	local var_38_4 = math.min(#var_38_0, 3)
	local var_38_5
	local var_38_6

	for iter_38_0 = 1, var_38_4 do
		local var_38_7 = arg_38_0.rewardItems[iter_38_0]

		if not var_38_7 then
			var_38_7 = arg_38_0:getUserDataTb_()
			var_38_7.go = gohelper.cloneInPlace(arg_38_0._goactivityrewarditem, "item" .. iter_38_0)
			var_38_7.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(var_38_7.go, "itemicon"))
			var_38_7.gorare = gohelper.findChild(var_38_7.go, "rare")
			var_38_7.gonormal = gohelper.findChild(var_38_7.go, "rare/#go_rare1")
			var_38_7.gofirst = gohelper.findChild(var_38_7.go, "rare/#go_rare2")
			var_38_7.goadvance = gohelper.findChild(var_38_7.go, "rare/#go_rare3")
			var_38_7.gofirsthard = gohelper.findChild(var_38_7.go, "rare/#go_rare4")
			var_38_7.txtnormal = gohelper.findChildText(var_38_7.go, "rare/#go_rare1/txt")
			var_38_7.count = gohelper.findChildText(var_38_7.go, "countbg/count")
			var_38_7.countBg = gohelper.findChild(var_38_7.go, "countbg")
			var_38_7.got = gohelper.findChild(var_38_7.go, "got")

			table.insert(arg_38_0.rewardItems, var_38_7)
		end

		local var_38_8 = var_38_0[iter_38_0]

		gohelper.setActive(var_38_7.gonormal, false)
		gohelper.setActive(var_38_7.gofirst, false)
		gohelper.setActive(var_38_7.goadvance, false)
		gohelper.setActive(var_38_7.gofirsthard, false)
		gohelper.setActive(var_38_7.got, false)
		gohelper.setActive(var_38_7.gorare, true)

		local var_38_9
		local var_38_10
		local var_38_11 = var_38_8[3]
		local var_38_12 = true

		if arg_38_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
			var_38_9 = var_38_7.gofirsthard
			var_38_10 = var_38_7.goadvance
		else
			var_38_9 = var_38_7.gofirst
			var_38_10 = var_38_7.goadvance
		end

		if iter_38_0 <= var_38_2 then
			gohelper.setActive(var_38_10, true)
		elseif iter_38_0 <= var_38_1 then
			gohelper.setActive(var_38_9, true)
		else
			gohelper.setActive(var_38_7.gonormal, true)

			var_38_7.txtnormal.text = luaLang("dungeon_prob_flag" .. var_38_8[3])

			if #var_38_8 >= 4 then
				var_38_11 = var_38_8[4]
			else
				var_38_12 = false
			end
		end

		gohelper.setActive(var_38_7.countBg, var_38_12)

		var_38_7.count.text = var_38_12 and var_38_11 or ""

		var_38_7.iconItem:setMOValue(var_38_8[1], var_38_8[2], var_38_11, nil, true)
		var_38_7.iconItem:setCountFontSize(0)
		var_38_7.iconItem:setHideLvAndBreakFlag(true)
		var_38_7.iconItem:hideEquipLvAndBreak(true)
		var_38_7.iconItem:isShowCount(var_38_12)

		if DungeonModel.instance:hasPassLevelAndStory(arg_38_0.showEpisodeCo.id) and arg_38_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
			gohelper.setActive(var_38_7.got, true)
			gohelper.setActive(var_38_7.gorare, false)
		end

		gohelper.setActive(var_38_7.go, true)
	end

	for iter_38_1 = var_38_4 + 1, #arg_38_0.rewardItems do
		gohelper.setActive(arg_38_0.rewardItems[iter_38_1].go, false)
	end
end

function var_0_0.refreshStartBtn(arg_39_0)
	local var_39_0 = 0

	if not string.nilorempty(arg_39_0.showEpisodeCo.cost) then
		var_39_0 = string.splitToNumber(arg_39_0.showEpisodeCo.cost, "#")[3]
	end

	local var_39_1 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_39_2 = ResUrl.getCurrencyItemIcon(var_39_1.icon)

	if arg_39_0._simagepower then
		arg_39_0._simagepower:LoadImage(var_39_2)
	end

	if arg_39_0._simagepower2 then
		arg_39_0._simagepower2:LoadImage(var_39_2)
	end

	arg_39_0._txtusepowernormal.text = "-" .. var_39_0
	arg_39_0._txtusepowernormal2.text = "-" .. var_39_0
	arg_39_0._txtusepowerhard.text = "-" .. var_39_0

	if var_39_0 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._txtusepowernormal, "#ACCB8C")
		SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._txtusepowernormal2, "#ACCB8C")
		SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._txtusepowerhard, "#FFB7B7")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._txtusepowernormal2, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._txtusepowerhard, "#C44945")
	end

	local var_39_3 = DungeonModel.instance:hasPassLevelAndStory(arg_39_0._episode_list[1].id) and arg_39_0.storyIdList and #arg_39_0.storyIdList > 0

	if arg_39_0._btnreplayStory then
		gohelper.setActive(arg_39_0._btnreplayStory.gameObject, var_39_3)
	end

	gohelper.setActive(arg_39_0._btnnormalStart.gameObject, arg_39_0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and not var_39_3)
	gohelper.setActive(arg_39_0._btnnormalStart2.gameObject, arg_39_0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and var_39_3)
	gohelper.setActive(arg_39_0._btnhardStart.gameObject, arg_39_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)

	if DungeonModel.instance:hasPassLevel(arg_39_0.showEpisodeCo.id) and arg_39_0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_39_0.showEpisodeCo.afterStory) then
		arg_39_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")
		arg_39_0._txtnorstarttext2.text = luaLang("p_dungeonlevelview_continuestory")

		gohelper.setActive(arg_39_0._txtusepowernormal.gameObject, false)
		gohelper.setActive(arg_39_0._gonormalStartnode, false)

		if arg_39_0._simagepower then
			gohelper.setActive(arg_39_0._simagepower.gameObject, false)
		end
	else
		arg_39_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")
		arg_39_0._txtnorstarttext2.text = luaLang("p_dungeonlevelview_startfight")

		gohelper.setActive(arg_39_0._txtusepowernormal.gameObject, true)
		gohelper.setActive(arg_39_0._txtusepowernormal2.gameObject, true)

		if arg_39_0._simagepower then
			gohelper.setActive(arg_39_0._simagepower.gameObject, true)
			gohelper.setActive(arg_39_0._simagepower2.gameObject, true)
		end
	end
end

function var_0_0.setImage(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_2 then
		UISpriteSetMgr.instance:setVersionActivitySprite(arg_40_1, "star_1_3")
	else
		UISpriteSetMgr.instance:setVersionActivitySprite(arg_40_1, "star_1_1")
	end
end

function var_0_0.buildEpisodeName(arg_41_0)
	local var_41_0 = arg_41_0.showEpisodeCo.name
	local var_41_1 = GameUtil.utf8sub(var_41_0, 1, 1)
	local var_41_2 = ""
	local var_41_3 = GameUtil.utf8len(var_41_0)

	if var_41_3 > 1 then
		var_41_2 = GameUtil.utf8sub(var_41_0, 2, var_41_3 - 1)
	end

	local var_41_4 = 112

	if GameConfig:GetCurLangType() == LangSettings.jp then
		var_41_4 = 90
	elseif GameConfig:GetCurLangType() == LangSettings.en then
		var_41_4 = 90
	elseif GameConfig:GetCurLangType() == LangSettings.kr then
		var_41_4 = 110
	end

	return string.format("<size=%s>%s</size>%s", var_41_4, var_41_1, var_41_2)
end

function var_0_0.buildColorText(arg_42_0, arg_42_1, arg_42_2)
	return string.format("<color=%s>%s</color>", arg_42_2, arg_42_1)
end

function var_0_0.getPreModeName(arg_43_0)
	if arg_43_0._cur_select_index - 1 <= 0 then
		logWarn("not modeIndex mode : " .. arg_43_0._cur_select_index)

		return ""
	end

	local var_43_0 = arg_43_0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and 99 or arg_43_0._cur_select_index - 1

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[var_43_0])
end

function var_0_0.onClose(arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0._playUnlockAudio, arg_44_0)

	if arg_44_0._clueFlow then
		arg_44_0._clueFlow:unregisterDoneListener(arg_44_0._onClueFlowDone, arg_44_0)
		arg_44_0._clueFlow:stop()

		arg_44_0._clueFlow = nil
	end
end

function var_0_0.onDestroyView(arg_45_0)
	arg_45_0.rewardItems = nil

	arg_45_0._simageactivitynormalbg:UnLoadImage()
	arg_45_0._simageactivityhardbg:UnLoadImage()

	if arg_45_0._simagepower then
		arg_45_0._simagepower:UnLoadImage()
	end

	if arg_45_0._simagepower2 then
		arg_45_0._simagepower2:UnLoadImage()
	end
end

return var_0_0
