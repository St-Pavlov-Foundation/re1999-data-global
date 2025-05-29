module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupFightView_Level", package.seeall)

local var_0_0 = class("WeekWalk_2HeroGroupFightView_Level", HeroGroupFightViewLevel)

function var_0_0._refreshTarget(arg_1_0)
	local var_1_0 = DungeonConfig.instance:getEpisodeCO(arg_1_0._episodeId)
	local var_1_1 = DungeonConfig.instance:getChapterCO(var_1_0.chapterId)

	gohelper.setActive(arg_1_0._gotargetlist, true)

	local var_1_2 = var_1_1.type == DungeonEnum.ChapterType.Hard

	gohelper.setActive(arg_1_0._gohardEffect, var_1_2)
	gohelper.setActive(arg_1_0._gobalanceEffect, HeroGroupBalanceHelper.getIsBalanceMode())

	arg_1_0._isHardMode = var_1_2

	local var_1_3
	local var_1_4

	if var_1_2 then
		var_1_4 = arg_1_0._episodeId
		var_1_3 = var_1_0.preEpisode
	else
		var_1_3 = arg_1_0._episodeId

		local var_1_5 = var_1_3 and DungeonConfig.instance:getHardEpisode(var_1_3)

		var_1_4 = var_1_5 and var_1_5.id
	end

	local var_1_6 = var_1_3 and DungeonModel.instance:getEpisodeInfo(var_1_3)
	local var_1_7 = var_1_4 and DungeonModel.instance:getEpisodeInfo(var_1_4)
	local var_1_8 = var_1_3 and DungeonModel.instance:hasPassLevelAndStory(var_1_3)
	local var_1_9 = var_1_3 and DungeonConfig.instance:getEpisodeAdvancedConditionText(var_1_3)
	local var_1_10 = var_1_4 and DungeonConfig.instance:getEpisodeAdvancedConditionText(var_1_4)
	local var_1_11 = DungeonModel.instance:isOpenHardDungeon(var_1_0.chapterId)
	local var_1_12 = true

	if var_1_2 then
		gohelper.setActive(arg_1_0._gohardcondition, true)

		arg_1_0._txthardcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(var_1_4)

		local var_1_13 = var_1_7.star >= DungeonEnum.StarType.Normal and var_1_8

		gohelper.setActive(arg_1_0._gohardfinish, var_1_13)
		gohelper.setActive(arg_1_0._gohardunfinish, not var_1_13)
		ZProj.UGUIHelper.SetColorAlpha(arg_1_0._txthardcondition, var_1_13 and 1 or 0.63)
		gohelper.setActive(arg_1_0._gohardplatinumcondition, not string.nilorempty(var_1_10))

		local var_1_14 = var_1_7.star >= DungeonEnum.StarType.Advanced and var_1_8

		if not string.nilorempty(var_1_10) then
			arg_1_0._txthardplatinumcondition.text = var_1_10

			gohelper.setActive(arg_1_0._gohardplatinumfinish, var_1_14)
			gohelper.setActive(arg_1_0._gohardplatinumunfinish, not var_1_14)
			ZProj.UGUIHelper.SetColorAlpha(arg_1_0._txthardplatinumcondition, var_1_14 and 1 or 0.63)

			var_1_12 = false
		end

		arg_1_0:_showStar(var_1_7, var_1_10, var_1_13, var_1_14)
	elseif arg_1_0._isSimple then
		local var_1_15 = DungeonModel.instance:getEpisodeInfo(arg_1_0._episodeId)
		local var_1_16 = var_1_15 and var_1_15.star >= DungeonEnum.StarType.Normal and var_1_8

		gohelper.setActive(arg_1_0._gonormalcondition, true)

		local var_1_17 = DungeonConfig.instance:getFirstEpisodeWinConditionText(var_1_3)

		arg_1_0._txtnormalcondition.text = var_1_17

		gohelper.setActive(arg_1_0._gonormalfinish, var_1_16)
		gohelper.setActive(arg_1_0._gonormalunfinish, not var_1_16)
		ZProj.UGUIHelper.SetColorAlpha(arg_1_0._txtnormalcondition, var_1_16 and 1 or 0.63)
		arg_1_0:_showStar(var_1_15, nil, var_1_16)
	else
		local var_1_18 = DungeonConfig.instance:getFirstEpisodeWinConditionText(var_1_3)

		if BossRushController.instance:isInBossRushInfiniteFight() then
			var_1_18 = luaLang("v1a4_bossrushleveldetail_txt_target")
		end

		arg_1_0._txtnormalcondition.text = var_1_18

		local var_1_19 = var_1_6 and var_1_6.star >= DungeonEnum.StarType.Normal and var_1_8
		local var_1_20 = var_1_6 and var_1_6.star >= DungeonEnum.StarType.Advanced and var_1_8
		local var_1_21 = false

		if var_1_0.type == DungeonEnum.EpisodeType.WeekWalk then
			local var_1_22 = WeekWalkModel.instance:getCurMapInfo():getBattleInfo(arg_1_0._battleId)

			if var_1_22 then
				var_1_19 = var_1_22.star >= DungeonEnum.StarType.Normal
				var_1_20 = var_1_22.star >= DungeonEnum.StarType.Advanced
				var_1_21 = var_1_22.star >= DungeonEnum.StarType.Ultra
			end

			local var_1_23 = var_1_3 and DungeonConfig.instance:getEpisodeAdvancedCondition2Text(var_1_3)

			gohelper.setActive(arg_1_0._goplatinumcondition2, not string.nilorempty(var_1_23))

			if not string.nilorempty(var_1_23) then
				arg_1_0._txtplatinumcondition2.text = var_1_23

				gohelper.setActive(arg_1_0._goplatinumfinish2, var_1_21)
				gohelper.setActive(arg_1_0._goplatinumunfinish2, not var_1_21)
				ZProj.UGUIHelper.SetColorAlpha(arg_1_0._txtplatinumcondition2, var_1_21 and 1 or 0.63)
			end
		end

		if var_1_0.type == DungeonEnum.EpisodeType.Jiexika then
			var_1_19 = false
		end

		gohelper.setActive(arg_1_0._gonormalfinish, var_1_19)
		gohelper.setActive(arg_1_0._gonormalunfinish, not var_1_19)
		ZProj.UGUIHelper.SetColorAlpha(arg_1_0._txtnormalcondition, var_1_19 and 1 or 0.63)
		gohelper.setActive(arg_1_0._goplatinumcondition, not arg_1_0._isSimple and not string.nilorempty(var_1_9))

		if not string.nilorempty(var_1_9) then
			arg_1_0._txtplatinumcondition.text = var_1_9

			gohelper.setActive(arg_1_0._goplatinumfinish, var_1_20)
			gohelper.setActive(arg_1_0._goplatinumunfinish, not var_1_20)
			ZProj.UGUIHelper.SetColorAlpha(arg_1_0._txtplatinumcondition, var_1_20 and 1 or 0.63)

			var_1_12 = false
		end

		gohelper.setActive(arg_1_0._goplace, var_1_12)
		arg_1_0:_refreshWeekWalkTarget()
	end
end

function var_0_0._refreshWeekWalkTarget(arg_2_0)
	if arg_2_0._goWeekWalkHeart then
		return
	end

	arg_2_0._goWeekWalkHeart = gohelper.findChild(arg_2_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_weekwalkheart")

	gohelper.setActive(arg_2_0._goWeekWalkHeart, false)

	local var_2_0 = WeekWalk_2Model.instance:getCurMapInfo()
	local var_2_1 = HeroGroupModel.instance.battleId
	local var_2_2 = var_2_0:getBattleInfoByBattleId(var_2_1)
	local var_2_3 = WeekWalk_2Config.instance:getCupTask(var_2_0.id, var_2_2.index)

	if not var_2_3 then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(var_2_3) do
		arg_2_0:_showCupTask(iter_2_1)
	end
end

function var_0_0._showCupTask(arg_3_0, arg_3_1)
	local var_3_0 = GameUtil.splitString2(arg_3_1.cupTask, true, "|", "#")
	local var_3_1 = gohelper.cloneInPlace(arg_3_0._goWeekWalkHeart)

	gohelper.setSiblingBefore(var_3_1, arg_3_0._goplace)
	gohelper.setActive(var_3_1, true)

	gohelper.findChildText(var_3_1, "txt_desc").text = arg_3_1.desc

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = gohelper.findChild(var_3_1, "badgelayout/" .. iter_3_0)

		gohelper.setActive(var_3_2, true)

		local var_3_3 = gohelper.findChildImage(var_3_2, "1")
		local var_3_4 = iter_3_1[1]

		var_3_3.enabled = false

		local var_3_5 = arg_3_0.viewContainer:getResInst(arg_3_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_3_3.gameObject)

		WeekWalk_2Helper.setCupEffectByResult(var_3_5, var_3_4)
	end

	gohelper.setActive(arg_3_0._gostar3, false)
end

return var_0_0
