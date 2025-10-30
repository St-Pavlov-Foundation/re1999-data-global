module("modules.logic.seasonver.common.SeasonFightHandler", package.seeall)

local var_0_0 = class("SeasonFightHandler")

var_0_0.SeasonFightRuleTipViewList = {
	ViewName.SeasonFightRuleTipView,
	Season123Controller.instance:getFightRuleTipViewName()
}

function var_0_0.getSeasonEquips(arg_1_0, arg_1_1)
	local var_1_0

	if Season123Controller.isEpisodeFromSeason123(arg_1_1.episodeId) then
		var_1_0 = Season123HeroGroupUtils.getAllHeroActivity123Equips(arg_1_0)
	else
		var_1_0 = arg_1_0:getAllHeroActivity104Equips()
	end

	return var_1_0
end

function var_0_0.closeSeasonFightRuleTipView()
	Activity104Controller.instance:closeSeasonView(Activity104Enum.ViewName.FightRuleTipView)

	if ViewMgr.instance:isOpen(Season123Controller.instance:getFightRuleTipViewName()) then
		ViewMgr.instance:closeView(Season123Controller.instance:getFightRuleTipViewName())
	end
end

function var_0_0.openSeasonFightRuleTipView(arg_3_0)
	local var_3_0 = false

	if Activity104Model.instance:isSeasonEpisodeType(arg_3_0) then
		Activity104Controller.instance:openSeasonFightRuleTipView()

		var_3_0 = true
	elseif Season123Controller.isSeason123EpisodeType(arg_3_0) then
		Season123Controller.instance:openFightTipViewName()

		var_3_0 = true
	end

	return var_3_0
end

function var_0_0.canSeasonShowTips(arg_4_0, arg_4_1)
	local var_4_0 = true

	if Activity104Model.instance:isSeasonEpisodeType(arg_4_1) then
		local var_4_1 = GameUtil.splitString2(arg_4_0, true, "|", "#")
		local var_4_2 = SeasonConfig.instance:filterRule(var_4_1)

		var_4_0 = var_4_2 and #var_4_2 > 0
	elseif Season123Controller.isSeason123EpisodeType(arg_4_1) then
		local var_4_3 = GameUtil.splitString2(arg_4_0, true, "|", "#")
		local var_4_4 = Season123Model.instance:getBattleContext()

		if var_4_4 then
			var_4_3 = Season123HeroGroupModel.filterRule(var_4_4.actId, var_4_3)

			if var_4_4.stage then
				var_4_3 = Season123Config.instance:filterRule(var_4_3, var_4_4.stage)
			end
		end

		var_4_0 = var_4_3 and #var_4_3 > 0
	end

	return var_4_0
end

function var_0_0.checkSeasonAndOpenGroupFightView(arg_5_0, arg_5_1)
	local var_5_0 = false

	if Activity104Model.instance:isSeasonEpisodeType(arg_5_1.type) then
		Activity104HeroGroupController.instance:openGroupFightView(arg_5_0.battleId, arg_5_0.episodeId)

		var_5_0 = true
	elseif Season123Controller.isSeason123EpisodeType(arg_5_1.type) then
		Season123HeroGroupController.instance:openHeroGroupView(arg_5_0.battleId, arg_5_0.episodeId)

		var_5_0 = true
	elseif Season166Controller.isSeason166EpisodeType(arg_5_1.type) then
		Season166HeroGroupController.instance:openHeroGroupView(arg_5_0.battleId, arg_5_0.episodeId)

		var_5_0 = true
	end

	return var_5_0
end

function var_0_0.checkProcessFightReconnect(arg_6_0)
	Season123Controller.instance:checkProcessFightReconnect()
	Season166Controller.instance:checkProcessFightReconnect()

	if arg_6_0.episodeId == Activity104Enum.SeasonEpisodeId and arg_6_0.data ~= "" then
		local var_6_0 = string.split(arg_6_0.data, "#")
		local var_6_1 = tonumber(var_6_0[2])
		local var_6_2 = tonumber(var_6_0[3])
		local var_6_3 = {}

		for iter_6_0 = 4, #var_6_0 do
			if tonumber(var_6_0[iter_6_0]) then
				table.insert(var_6_3, tonumber(var_6_0[iter_6_0]))
			end
		end

		FightController.instance:setFightParamByEpisodeBattleId(arg_6_0.episodeId, FightModel.instance:getBattleId())
	end
end

function var_0_0.loadSeasonCondition(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = DungeonModel.instance.curSendEpisodeId

	if arg_7_0 == DungeonEnum.EpisodeType.SeasonRetail then
		gohelper.setActive(arg_7_1, false)

		local var_7_1 = Activity104Model.instance:getAct104Retails()
		local var_7_2 = DungeonModel.instance.curSendChapterId
		local var_7_3 = DungeonConfig.instance:getChapterCO(var_7_2)
		local var_7_4 = var_7_3 and var_7_3.type == DungeonEnum.ChapterType.Hard

		for iter_7_0, iter_7_1 in ipairs(var_7_1) do
			if iter_7_1.id == var_7_0 then
				local var_7_5 = lua_condition.configDict[iter_7_1.advancedId]

				if var_7_5 then
					gohelper.setActive(arg_7_1, true)

					gohelper.findChildText(arg_7_2, "").text = var_7_5.desc
					gohelper.findChildText(arg_7_3, "passtargetTip/tip").text = luaLang("season_retail_special_rule_title")

					local var_7_6 = Activity104Model.instance:getEpisodeRetail(var_7_0)
					local var_7_7 = "#87898C"
					local var_7_8 = var_7_4 and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001"
					local var_7_9 = gohelper.findChildImage(arg_7_3, "desc/star")

					UISpriteSetMgr.instance:setCommonSprite(var_7_9, var_7_8)
					SLFramework.UGUI.GuiHelper.SetColor(var_7_9, var_7_7)
				end

				break
			end
		end

		return true
	elseif arg_7_0 == DungeonEnum.EpisodeType.Season166Base then
		local var_7_10 = Season166Model.instance:getBattleContext()

		if var_7_10 and var_7_10.baseId and var_7_10.baseId > 0 then
			gohelper.setActive(arg_7_2, false)

			for iter_7_2 = 1, 3 do
				local var_7_11 = gohelper.clone(arg_7_2, arg_7_3, "desc" .. iter_7_2)
				local var_7_12 = Season166Config.instance:getSeasonScoreCo(var_7_10.actId, iter_7_2)
				local var_7_13 = gohelper.findChildText(var_7_11, "")
				local var_7_14 = gohelper.findChildImage(var_7_11, "star")

				gohelper.setActive(var_7_11, true)

				local var_7_15 = luaLang("season166_herogroup_fightScoreTarget")

				var_7_13.text = GameUtil.getSubPlaceholderLuaLang(var_7_15, {
					var_7_12.needScore
				})

				local var_7_16 = Season166BaseSpotModel.instance:getBaseSpotMaxScore(var_7_10.actId, var_7_10.baseId) >= var_7_12.needScore

				UISpriteSetMgr.instance:setSeason166Sprite(var_7_14, var_7_16 and "season166_result_inclinedbulb2" or "season166_result_inclinedbulb1", true)
				transformhelper.setLocalScale(var_7_14.transform, 0.5, 0.5, 0.5)
				SLFramework.UGUI.GuiHelper.SetColor(var_7_14, "#FFFFFF")
			end

			return true
		else
			return false
		end
	end

	return false
end

return var_0_0
