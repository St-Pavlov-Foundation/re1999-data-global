module("modules.logic.fight.system.work.FightWorkBeforeStartNoticeView", package.seeall)

local var_0_0 = class("FightWorkBeforeStartNoticeView", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	if not FightReplayModel.instance:isReplay() and ViewMgr.instance:isOpen(ViewName.FightQuitTipView) then
		FightController.instance:registerCallback(FightEvent.OnFightQuitTipViewClose, arg_2_0.bootLogic, arg_2_0)
	else
		arg_2_0:bootLogic()
	end
end

function var_0_0.bootLogic(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnFightQuitTipViewClose, arg_3_0.bootLogic, arg_3_0)

	if var_0_0.canShowTips() and not FightModel.instance:isAuto() then
		FightController.instance:dispatchEvent(FightEvent.SetPlayCardPartOutScreen)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
		FightController.instance:openFightSpecialTipView(true)
	else
		arg_3_0:onDone(true)
	end
end

function var_0_0._onCloseViewFinish(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.FightSpecialTipView or tabletool.indexOf(SeasonFightHandler.SeasonFightRuleTipViewList, arg_4_1) then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
		arg_4_0:onDone(true)
	end
end

function var_0_0.canShowTips()
	if not GMFightShowState.roundSpecialView then
		return false
	end

	local var_5_0 = FightModel.instance:getFightParam()
	local var_5_1
	local var_5_2 = DungeonConfig.instance:getEpisodeCO(var_5_0.episodeId)

	if var_5_2 and not string.nilorempty(var_5_2.battleDesc) then
		var_5_1 = true
	end

	local var_5_3 = lua_battle.configDict[var_5_0.battleId]
	local var_5_4 = var_5_2 and var_5_2.type

	if var_5_3 and not string.nilorempty(var_5_3.additionRule) then
		local var_5_5 = var_5_3.additionRule

		if var_5_4 == DungeonEnum.EpisodeType.Meilanni then
			local var_5_6 = GameUtil.splitString2(var_5_5, true, "|", "#")
			local var_5_7 = HeroGroupFightViewRule.meilanniExcludeRules(var_5_6)

			var_5_1 = var_5_1 or var_5_7 and #var_5_7 > 0
		else
			var_5_1 = SeasonFightHandler.canSeasonShowTips(var_5_5, var_5_4)
		end
	else
		if var_5_4 == DungeonEnum.EpisodeType.Rouge then
			local var_5_8 = RougeMapModel.instance:getCurNode()
			local var_5_9 = var_5_8 and var_5_8.eventMo
			local var_5_10 = var_5_9 and var_5_9:getSurpriseAttackList()

			var_5_1 = var_5_10 and #var_5_10 > 0
		end

		if var_5_4 == DungeonEnum.EpisodeType.Survival then
			local var_5_11 = SurvivalShelterModel.instance:addExRule({})

			var_5_1 = var_5_1 or #var_5_11 > 0
		end
	end

	local var_5_12 = FightDataHelper.fieldMgr.customData

	if var_5_12 then
		local var_5_13 = var_5_12[FightCustomData.CustomDataType.WeekwalkVer2]

		if var_5_13 and cjson.decode(var_5_13).ruleMap then
			var_5_1 = true
		end

		local var_5_14 = var_5_12[FightCustomData.CustomDataType.Act183]

		if var_5_14 then
			if var_5_14.currRules and #var_5_14.currRules > 0 then
				var_5_1 = true
			end

			if var_5_14.transferRules and #var_5_14.transferRules > 0 then
				var_5_1 = true
			end
		end
	end

	local var_5_15 = GuideModel.instance:isDoingFirstGuide()
	local var_5_16 = GuideController.instance:isForbidGuides()
	local var_5_17 = FightReplayModel.instance:isReplay()

	if var_5_1 and (not var_5_15 or var_5_16) and not var_5_17 then
		return true
	else
		return false
	end

	return false
end

function var_0_0.clearWork(arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.OnFightQuitTipViewClose, arg_6_0.bootLogic, arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_6_0._onCloseViewFinish, arg_6_0)
	FightController.instance:dispatchEvent(FightEvent.SetPlayCardPartOriginPos)
end

return var_0_0
