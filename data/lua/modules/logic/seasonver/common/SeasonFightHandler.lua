module("modules.logic.seasonver.common.SeasonFightHandler", package.seeall)

slot0 = class("SeasonFightHandler")
slot0.SeasonFightRuleTipViewList = {
	ViewName.SeasonFightRuleTipView,
	Season123Controller.instance:getFightRuleTipViewName()
}

function slot0.getSeasonEquips(slot0, slot1)
	slot2 = nil

	return (not Season123Controller.isEpisodeFromSeason123(slot1.episodeId) or Season123HeroGroupUtils.getAllHeroActivity123Equips(slot0)) and slot0:getAllHeroActivity104Equips()
end

function slot0.closeSeasonFightRuleTipView()
	Activity104Controller.instance:closeSeasonView(Activity104Enum.ViewName.FightRuleTipView)

	if ViewMgr.instance:isOpen(Season123Controller.instance:getFightRuleTipViewName()) then
		ViewMgr.instance:closeView(Season123Controller.instance:getFightRuleTipViewName())
	end
end

function slot0.openSeasonFightRuleTipView(slot0)
	slot1 = false

	if Activity104Model.instance:isSeasonEpisodeType(slot0) then
		Activity104Controller.instance:openSeasonFightRuleTipView()

		slot1 = true
	elseif Season123Controller.isSeason123EpisodeType(slot0) then
		Season123Controller.instance:openFightTipViewName()

		slot1 = true
	end

	return slot1
end

function slot0.canSeasonShowTips(slot0, slot1)
	slot2 = true

	if Activity104Model.instance:isSeasonEpisodeType(slot1) then
		slot2 = SeasonConfig.instance:filterRule(GameUtil.splitString2(slot0, true, "|", "#")) and #slot3 > 0
	elseif Season123Controller.isSeason123EpisodeType(slot1) then
		if Season123Model.instance:getBattleContext() then
			if slot4.stage then
				slot3 = Season123Config.instance:filterRule(Season123HeroGroupModel.filterRule(slot4.actId, GameUtil.splitString2(slot0, true, "|", "#")), slot4.stage)
			end
		end

		slot2 = slot3 and #slot3 > 0
	end

	return slot2
end

function slot0.checkSeasonAndOpenGroupFightView(slot0, slot1)
	slot2 = false

	if Activity104Model.instance:isSeasonEpisodeType(slot1.type) then
		Activity104HeroGroupController.instance:openGroupFightView(slot0.battleId, slot0.episodeId)

		slot2 = true
	elseif Season123Controller.isSeason123EpisodeType(slot1.type) then
		Season123HeroGroupController.instance:openHeroGroupView(slot0.battleId, slot0.episodeId)

		slot2 = true
	elseif Season166Controller.isSeason166EpisodeType(slot1.type) then
		Season166HeroGroupController.instance:openHeroGroupView(slot0.battleId, slot0.episodeId)

		slot2 = true
	end

	return slot2
end

function slot0.checkProcessFightReconnect(slot0)
	Season123Controller.instance:checkProcessFightReconnect()
	Season166Controller.instance:checkProcessFightReconnect()

	if slot0.episodeId == Activity104Enum.SeasonEpisodeId and slot0.data ~= "" then
		slot1 = string.split(slot0.data, "#")
		slot2 = tonumber(slot1[2])
		slot3 = tonumber(slot1[3])

		for slot8 = 4, #slot1 do
			if tonumber(slot1[slot8]) then
				table.insert({}, tonumber(slot1[slot8]))
			end
		end

		FightController.instance:setFightParamByEpisodeBattleId(slot0.episodeId, FightModel.instance:getBattleId())
	end
end

function slot0.loadSeasonCondition(slot0, slot1, slot2, slot3)
	slot4 = DungeonModel.instance.curSendEpisodeId

	if slot0 == DungeonEnum.EpisodeType.SeasonRetail then
		gohelper.setActive(slot1, false)

		for slot12, slot13 in ipairs(Activity104Model.instance:getAllRetailMo()) do
			if slot13.id == slot4 then
				if lua_condition.configDict[slot13.advancedId] then
					gohelper.setActive(slot1, true)

					gohelper.findChildText(slot2, "").text = slot14.desc
					gohelper.findChildText(slot3, "passtargetTip/tip").text = luaLang("season_retail_special_rule_title")
					slot15 = Activity104Model.instance:getEpisodeRetail(slot4)
					slot18 = gohelper.findChildImage(slot3, "desc/star")

					UISpriteSetMgr.instance:setCommonSprite(slot18, DungeonConfig.instance:getChapterCO(DungeonModel.instance.curSendChapterId) and slot7.type == DungeonEnum.ChapterType.Hard and "zhuxianditu_kn_xingxing_002" or "zhuxianditu_pt_xingxing_001")
					SLFramework.UGUI.GuiHelper.SetColor(slot18, "#87898C")
				end

				break
			end
		end

		return true
	elseif slot0 == DungeonEnum.EpisodeType.Season166Base then
		if Season166Model.instance:getBattleContext() and slot5.baseId and slot5.baseId > 0 then
			slot9 = false

			gohelper.setActive(slot2, slot9)

			for slot9 = 1, 3 do
				slot10 = gohelper.clone(slot2, slot3, "desc" .. slot9)
				slot11 = Season166Config.instance:getSeasonScoreCo(slot5.actId, slot9)
				slot13 = gohelper.findChildImage(slot10, "star")

				gohelper.setActive(slot10, true)

				gohelper.findChildText(slot10, "").text = GameUtil.getSubPlaceholderLuaLang(luaLang("season166_herogroup_fightScoreTarget"), {
					slot11.needScore
				})

				UISpriteSetMgr.instance:setSeason166Sprite(slot13, slot11.needScore <= Season166BaseSpotModel.instance:getBaseSpotMaxScore(slot5.actId, slot5.baseId) and "season166_result_inclinedbulb2" or "season166_result_inclinedbulb1", true)
				transformhelper.setLocalScale(slot13.transform, 0.5, 0.5, 0.5)
				SLFramework.UGUI.GuiHelper.SetColor(slot13, "#FFFFFF")
			end

			return true
		else
			return false
		end
	end

	return false
end

return slot0
