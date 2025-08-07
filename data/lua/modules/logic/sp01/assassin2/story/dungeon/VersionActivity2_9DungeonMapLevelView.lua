module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapLevelView", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapLevelView", VersionActivityFixedDungeonMapLevelView)
local var_0_1 = "#562626"
local var_0_2 = "#562626"
local var_0_3 = "#562626"
local var_0_4 = "#562626"
local var_0_5 = 2.7

function var_0_0.onOpen(arg_1_0)
	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_clickEpisode)
	arg_1_0:initViewParam()
	arg_1_0:initMode()
	arg_1_0:markSelectEpisode()
	arg_1_0:refreshStoryIdList()
	arg_1_0:refreshBg()
	arg_1_0:refreshUI()
	arg_1_0.animator:Play(UIAnimationName.Open, 0, 0)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OpenFinishMapLevelView, arg_1_0.viewGO)
end

function var_0_0.onInitView(arg_2_0)
	var_0_0.super.onInitView(arg_2_0)

	arg_2_0._gonormalprogress = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_progress/#go_normal")
	arg_2_0._gomiddleprogress = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_progress/#go_middle")
	arg_2_0._gohardprogress = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_progress/#go_hard")
	arg_2_0._sliderprogress = gohelper.findChildSlider(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_progress/#slider_progress")
	arg_2_0._imageprogress = gohelper.findChildImage(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_progress/#slider_progress/Fill Area/Fill")

	gohelper.setActive(arg_2_0._btnactivityreward, false)
end

function var_0_0.playModeUnlockAnimation(arg_3_0)
	if not arg_3_0.needPlayUnlockModeAnimation then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_unlockMode)
	arg_3_0:_playModeUnLockAnimation(UIAnimationName.Unlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum().BlockKey.MapLevelViewPlayUnlockAnim)
	TaskDispatcher.runDelay(arg_3_0.onModeUnlockAnimationPlayDone, arg_3_0, var_0_5)
end

function var_0_0.refreshEpisodeTextInfo(arg_4_0)
	local var_4_0 = DungeonConfig.instance:getChapterCO(arg_4_0.showEpisodeCo.chapterId)
	local var_4_1

	if var_4_0.id == VersionActivityFixedHelper.getVersionActivityDungeonEnum().DungeonChapterId.Story then
		var_4_1 = arg_4_0.showEpisodeCo
	else
		var_4_1 = VersionActivityFixedDungeonConfig.instance:getStoryEpisodeCo(arg_4_0.showEpisodeCo.id)
	end

	arg_4_0._txtmapName.text = arg_4_0:buildEpisodeName(var_4_1)

	local var_4_2 = arg_4_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and var_0_4 or var_0_3

	arg_4_0._txtmapNameEn.text = arg_4_0:buildColorText(var_4_1.name_En, var_4_2)
	arg_4_0._txtmapNum.text = arg_4_0:buildColorText(string.format("%02d", arg_4_0.index), var_4_2)
	arg_4_0._txtmapChapterIndex.text = arg_4_0:buildColorText(var_4_0.chapterIndex .. " .", var_4_2)
	arg_4_0._txtactivitydesc.text = var_4_1.desc

	local var_4_3 = DungeonHelper.getEpisodeRecommendLevel(arg_4_0.showEpisodeCo.id)
	local var_4_4 = lua_battle.configDict[arg_4_0.showEpisodeCo.battleId]
	local var_4_5 = lua_battle.configDict[arg_4_0.showEpisodeCo.firstBattleId]
	local var_4_6 = var_4_5 and not string.nilorempty(var_4_5.balance)
	local var_4_7 = var_4_4 and not string.nilorempty(var_4_4.balance)
	local var_4_8 = DungeonModel.instance:hasPassLevel(arg_4_0.showEpisodeCo.id)

	gohelper.setActive(arg_4_0._gorecommend, var_4_3 > 0)

	if (var_4_6 or var_4_7) and not var_4_8 then
		arg_4_0._txtrecommendlv.text = "---"
	elseif var_4_3 > 0 then
		arg_4_0._txtrecommendlv.text = HeroConfig.instance:getCommonLevelDisplay(var_4_3)
	end
end

function var_0_0.buildEpisodeName(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.name
	local var_5_1 = GameUtil.utf8sub(var_5_0, 1, 1)
	local var_5_2 = ""
	local var_5_3 = GameUtil.utf8len(var_5_0)

	if var_5_3 > 1 then
		var_5_2 = GameUtil.utf8sub(var_5_0, 2, var_5_3 - 1)
	end

	local var_5_4 = arg_5_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and var_0_2 or var_0_1

	return arg_5_0:buildColorText(string.format("<size=112>%s</size>%s", var_5_1, var_5_2), var_5_4)
end

function var_0_0.refreshStar(arg_6_0)
	if not arg_6_0._progressGoTab then
		arg_6_0._progressGoTab = arg_6_0:getUserDataTb_()
		arg_6_0._progressGoTab[VersionActivityDungeonBaseEnum.DungeonMode.Story] = arg_6_0._gonormalprogress
		arg_6_0._progressGoTab[VersionActivityDungeonBaseEnum.DungeonMode.Story2] = arg_6_0._gomiddleprogress
		arg_6_0._progressGoTab[VersionActivityDungeonBaseEnum.DungeonMode.Story3] = arg_6_0._gohardprogress
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0._progressGoTab) do
		gohelper.setActive(iter_6_1, iter_6_0 == arg_6_0.mode)

		if iter_6_0 == arg_6_0.mode then
			arg_6_0:refreshProgressUI(iter_6_1)
		end
	end
end

function var_0_0.refreshProgressUI(arg_7_0, arg_7_1)
	VersionActivity2_9DungeonHelper.setEpisodeProgressBg(arg_7_0.showEpisodeCo.id, arg_7_0._imageprogress)

	local var_7_0 = VersionActivity2_9DungeonHelper.calcEpisodeProgress(arg_7_0.showEpisodeCo.id)
	local var_7_1 = VersionActivity2_9DungeonHelper.formatEpisodeProgress(var_7_0)

	gohelper.findChildText(arg_7_1, "#txt_progress").text = var_7_1

	arg_7_0._sliderprogress:SetValue(var_7_0)
end

function var_0_0._playMainStory(arg_8_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_8_0.showEpisodeCo.chapterId, arg_8_0.showEpisodeCo.id)

	local var_8_0 = arg_8_0.showEpisodeCo.beforeStory
	local var_8_1 = DungeonModel.instance:hasPassLevel(arg_8_0.showEpisodeCo.id)
	local var_8_2 = VersionActivity2_9DungeonHelper.getEpisodeAfterStoryId(arg_8_0.showEpisodeCo.id)

	if var_8_2 and var_8_2 ~= 0 then
		var_8_1 = var_8_1 and StoryModel.instance:isStoryFinished(var_8_2)
	end

	if var_8_1 then
		arg_8_0:_onFinishedEpisodeStories(var_8_0, var_8_2)

		return
	end

	arg_8_0:_buildStoryEpisodeFlow(var_8_0, var_8_2):start()
end

function var_0_0._onFinishedEpisodeStories(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	if arg_9_1 ~= 0 then
		table.insert(var_9_0, arg_9_1)
	end

	if arg_9_2 ~= 0 then
		table.insert(var_9_0, arg_9_2)
	end

	local var_9_1 = {}

	var_9_1.mark = true
	var_9_1.episodeId = arg_9_0.showEpisodeCo.id

	StoryController.instance:playStories(var_9_0, var_9_1, arg_9_0.onStoryFinished, arg_9_0)
end

function var_0_0._buildStoryEpisodeFlow(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:destroyStoryFlow()

	arg_10_0._storyFlow = FlowSequence.New()

	if arg_10_1 and arg_10_1 ~= 0 then
		arg_10_0._storyFlow:addWork(PlayStoryWork.New(arg_10_1))
	end

	if VersionActivity2_9DungeonHelper.getEpisdoeLittleGameType(arg_10_0.showEpisodeCo.id) then
		arg_10_0._storyFlow:addWork(FunctionWork.New(VersionActivity2_9DungeonController.startEpisodeLittleGame, VersionActivity2_9DungeonController.instance, arg_10_0.showEpisodeCo.id))

		local var_10_0 = "AssassinController;AssassinEvent;OnGameEpisodeFinished;" .. arg_10_0.showEpisodeCo.id

		arg_10_0._storyFlow:addWork(WaitEventWork.New(var_10_0))
	end

	if arg_10_2 and arg_10_2 ~= 0 then
		arg_10_0._storyFlow:addWork(PlayStoryWork.New(arg_10_2))
	end

	arg_10_0._storyFlow:addWork(FunctionWork.New(AssassinController.instance.dispatchEvent, AssassinController.instance, AssassinEvent.OnGameAfterStoryDone))
	arg_10_0._storyFlow:addWork(FunctionWork.New(arg_10_0.closeThis, arg_10_0))
	arg_10_0._storyFlow:registerDoneListener(arg_10_0.onFinishEpisode, arg_10_0)

	return arg_10_0._storyFlow
end

function var_0_0.onFinishEpisode(arg_11_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_11_0.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
end

function var_0_0.refreshReward(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = 0
	local var_12_2 = 0

	if arg_12_0.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_12_0, DungeonModel.instance:getEpisodeAdvancedBonus(arg_12_0.showEpisodeCo.id))

		var_12_2 = #var_12_0
	end

	if arg_12_0.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_12_0, DungeonModel.instance:getEpisodeFirstBonus(arg_12_0.showEpisodeCo.id))

		var_12_1 = #var_12_0
	end

	tabletool.addValues(var_12_0, DungeonModel.instance:getEpisodeReward(arg_12_0.showEpisodeCo.id))
	tabletool.addValues(var_12_0, DungeonModel.instance:getEpisodeRewardDisplayList(arg_12_0.showEpisodeCo.id))

	local var_12_3 = #var_12_0

	gohelper.setActive(arg_12_0._gorewards, var_12_3 > 0)
	gohelper.setActive(arg_12_0._gonorewards, var_12_3 == 0)

	if var_12_3 == 0 then
		return
	end

	local var_12_4 = math.min(#var_12_0, 3)
	local var_12_5
	local var_12_6

	for iter_12_0 = 1, var_12_4 do
		local var_12_7 = arg_12_0.rewardItems[iter_12_0]

		if not var_12_7 then
			var_12_7 = arg_12_0:getUserDataTb_()
			var_12_7.go = gohelper.cloneInPlace(arg_12_0._goactivityrewarditem, "item" .. iter_12_0)
			var_12_7.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(var_12_7.go, "itemicon"))
			var_12_7.gonormal = gohelper.findChild(var_12_7.go, "rare/#go_rare1")
			var_12_7.gofirst = gohelper.findChild(var_12_7.go, "rare/#go_rare2")
			var_12_7.goadvance = gohelper.findChild(var_12_7.go, "rare/#go_rare3")
			var_12_7.gofirsthard = gohelper.findChild(var_12_7.go, "rare/#go_rare4")
			var_12_7.txtnormal = gohelper.findChildText(var_12_7.go, "rare/#go_rare1/txt")
			var_12_7.goprogress = gohelper.findChild(var_12_7.go, "rare/#go_progress")
			var_12_7.imageprogress = gohelper.findChildImage(var_12_7.go, "rare/#go_progress/#image_icon")
			var_12_7.txtprogress = gohelper.findChildText(var_12_7.go, "rare/#go_progress/#txt_progress")

			table.insert(arg_12_0.rewardItems, var_12_7)
		end

		local var_12_8 = var_12_0[iter_12_0]

		gohelper.setActive(var_12_7.gonormal, false)
		gohelper.setActive(var_12_7.gofirst, false)
		gohelper.setActive(var_12_7.goadvance, false)
		gohelper.setActive(var_12_7.gofirsthard, false)
		gohelper.setActive(var_12_7.goprogress, false)

		local var_12_9 = var_12_8[3]
		local var_12_10 = true

		if iter_12_0 <= var_12_2 then
			gohelper.setActive(var_12_7.goprogress, true)
			VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(arg_12_0.showEpisodeCo.id, var_12_7.imageprogress)
			VersionActivity2_9DungeonHelper.setEpisodeTargetProgress(arg_12_0.showEpisodeCo.id, DungeonEnum.StarType.Advanced, var_12_7.txtprogress)
		elseif iter_12_0 <= var_12_1 then
			gohelper.setActive(var_12_7.goprogress, true)
			VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(arg_12_0.showEpisodeCo.id, var_12_7.imageprogress)
			VersionActivity2_9DungeonHelper.setEpisodeTargetProgress(arg_12_0.showEpisodeCo.id, DungeonEnum.StarType.Normal, var_12_7.txtprogress)
		else
			gohelper.setActive(var_12_7.gonormal, true)

			local var_12_11 = var_12_8[3]

			var_12_10 = true

			if var_12_8.tagType then
				var_12_11 = var_12_8.tagType
				var_12_10 = var_12_9 ~= 0
			elseif #var_12_8 >= 4 then
				var_12_9 = var_12_8[4]
			else
				var_12_10 = false
			end

			var_12_7.txtnormal.text = luaLang("dungeon_prob_flag" .. var_12_11)
		end

		var_12_7.iconItem:setMOValue(var_12_8[1], var_12_8[2], var_12_9, nil, true)
		var_12_7.iconItem:setCountFontSize(40)
		var_12_7.iconItem:setHideLvAndBreakFlag(true)
		var_12_7.iconItem:hideEquipLvAndBreak(true)
		var_12_7.iconItem:isShowCount(var_12_10)
		gohelper.setActive(var_12_7.go, true)
	end

	for iter_12_1 = var_12_4 + 1, #arg_12_0.rewardItems do
		gohelper.setActive(arg_12_0.rewardItems[iter_12_1].go, false)
	end
end

function var_0_0.refreshMode(arg_13_0)
	gohelper.setActive(arg_13_0._gotype1, arg_13_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(arg_13_0._gotype2, arg_13_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(arg_13_0._gotype3, arg_13_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(arg_13_0._gotype4, arg_13_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)

	local var_13_0 = not arg_13_0.modeCanFight or arg_13_0.needPlayUnlockModeAnimation

	gohelper.setActive(arg_13_0._gotype0, var_13_0)

	if var_13_0 then
		arg_13_0.lockTypeAnimator.enabled = true
		arg_13_0.txtLockType.text = luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[arg_13_0.mode])
	end

	gohelper.setActive(arg_13_0.lockTypeIconGo, var_13_0)
	arg_13_0:refreshBg()
end

function var_0_0.refreshBg(arg_14_0)
	gohelper.setActive(arg_14_0._simageactivitynormalbg.gameObject, arg_14_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(arg_14_0._simageactivityhardbg.gameObject, arg_14_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
end

function var_0_0.refreshCostPower(arg_15_0)
	local var_15_0 = 0

	if not string.nilorempty(arg_15_0.showEpisodeCo.cost) then
		var_15_0 = string.splitToNumber(arg_15_0.showEpisodeCo.cost, "#")[3]
	end

	arg_15_0._txtusepowernormal.text = "-" .. var_15_0
	arg_15_0._txtusepowerhard.text = "-" .. var_15_0

	if var_15_0 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._txtusepowernormal, "#F5EFE6")
		SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._txtusepowerhard, "#F5EFE6")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._txtusepowerhard, "#C44945")
	end
end

function var_0_0.refreshStartBtn(arg_16_0)
	var_0_0.super.refreshStartBtn(arg_16_0)
	arg_16_0:_setBtnVisible(arg_16_0._btnnormalStart.gameObject)
	arg_16_0:_setBtnVisible(arg_16_0._btnhardStart.gameObject)
	arg_16_0:_setBtnVisible(arg_16_0._simagepower.gameObject)
	arg_16_0:_setBtnVisible(arg_16_0._btnreplayStory.gameObject)
end

function var_0_0._setBtnVisible(arg_17_0, arg_17_1)
	if gohelper.isNil(arg_17_1) then
		return
	end

	gohelper.setActive(arg_17_1, arg_17_1.activeSelf and not arg_17_0.needPlayUnlockModeAnimation)
end

function var_0_0.destroyStoryFlow(arg_18_0)
	if arg_18_0._storyFlow then
		arg_18_0._storyFlow:destroy()
		arg_18_0._storyFlow:destroy()
	end
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0:destroyStoryFlow()
	var_0_0.super.onDestroyView(arg_19_0)
end

return var_0_0
