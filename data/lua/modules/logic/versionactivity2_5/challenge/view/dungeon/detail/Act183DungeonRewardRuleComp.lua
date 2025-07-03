module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRewardRuleComp", package.seeall)

local var_0_0 = class("Act183DungeonRewardRuleComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.go, "#go_rewards/#go_rewarditem")
	arg_1_0._rewardRuleItemTab = arg_1_0:getUserDataTb_()
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	var_0_0.super.updateInfo(arg_4_0, arg_4_1)

	arg_4_0._subEpisodeConditions = Act183Config.instance:getGroupSubEpisodeConditions(arg_4_0._activityId, arg_4_0._groupId)

	arg_4_0:initSelectConditionMap()
end

function var_0_0.initSelectConditionMap(arg_5_0)
	arg_5_0._selectConditionMap = {}
	arg_5_0._selectConditionIds = {}

	local var_5_0 = false

	arg_5_0._fightConditionIds, arg_5_0._passFightConditionIds = arg_5_0._groupEpisodeMo:getTotalAndPassConditionIds(arg_5_0._episodeId)
	arg_5_0._fightConditionIdMap = Act183Helper.listToMap(arg_5_0._fightConditionIds)
	arg_5_0._passFightConditionIdMap = Act183Helper.listToMap(arg_5_0._passFightConditionIds)

	if arg_5_0._episodeType == Act183Enum.EpisodeType.Boss then
		local var_5_1 = {}

		if PlayerPrefsHelper.hasKey(Act183Helper._generateSaveSelectCollectionIdsKey(arg_5_0._activityId, arg_5_0._episodeId)) then
			var_5_1 = Act183Helper.getSelectConditionIdsInLocal(arg_5_0._activityId, arg_5_0._episodeId)
		else
			var_5_1 = arg_5_0._passFightConditionIds
			var_5_0 = true
		end

		if var_5_1 then
			for iter_5_0, iter_5_1 in ipairs(var_5_1) do
				if arg_5_0._passFightConditionIdMap[iter_5_1] then
					arg_5_0._selectConditionMap[iter_5_1] = true

					table.insert(arg_5_0._selectConditionIds, iter_5_1)
				else
					var_5_0 = true
				end
			end
		end
	end

	if var_5_0 then
		Act183Helper.saveSelectConditionIdsInLocal(arg_5_0._activityId, arg_5_0._episodeId, arg_5_0._selectConditionIds)
	end
end

function var_0_0.checkIsVisible(arg_6_0)
	return arg_6_0._episodeType == Act183Enum.EpisodeType.Boss
end

function var_0_0.show(arg_7_0)
	var_0_0.super.show(arg_7_0)

	arg_7_0._hasPlayRefreshAnimRuleIds = Act183Helper.getHasPlayRefreshAnimRuleIdsInLocal(arg_7_0._episodeId)
	arg_7_0._hasPlayRefreshAnimRuleIdMap = Act183Helper.listToMap(arg_7_0._hasPlayRefreshAnimRuleIds)
	arg_7_0._needFocusEscapeRule = false

	arg_7_0:createObjList(arg_7_0._subEpisodeConditions, arg_7_0._rewardRuleItemTab, arg_7_0._gorewarditem, arg_7_0._initRewardRuleItemFunc, arg_7_0._refreshRewardRuleItemFunc, arg_7_0._defaultItemFreeFunc)
	Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(arg_7_0._episodeId, arg_7_0._hasPlayRefreshAnimRuleIds)
end

function var_0_0._initRewardRuleItemFunc(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1.goselectbg = gohelper.findChild(arg_8_1.go, "btn_check/#go_BG1")
	arg_8_1.gounselectbg = gohelper.findChild(arg_8_1.go, "btn_check/#go_BG2")
	arg_8_1.imageicon = gohelper.findChildImage(arg_8_1.go, "image_icon")
	arg_8_1.txtcondition = gohelper.findChildText(arg_8_1.go, "txt_condition")

	SkillHelper.addHyperLinkClick(arg_8_1.txtcondition)

	arg_8_1.txteffect = gohelper.findChildText(arg_8_1.go, "txt_effect")
	arg_8_1.btncheck = gohelper.findChildButtonWithAudio(arg_8_1.go, "btn_check")

	arg_8_1.btncheck:AddClickListener(arg_8_0._onClickRewardItem, arg_8_0, arg_8_2)

	arg_8_1.goselect = gohelper.findChild(arg_8_1.go, "btn_check/go_select")
end

function var_0_0._onClickRewardItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._subEpisodeConditions and arg_9_0._subEpisodeConditions[arg_9_1]
	local var_9_1 = Act183Config.instance:getConditionCo(var_9_0)

	if not var_9_1 then
		return
	end

	local var_9_2 = not arg_9_0._selectConditionMap[var_9_1.id]

	arg_9_0._selectConditionMap[var_9_1.id] = var_9_2

	tabletool.removeValue(arg_9_0._selectConditionIds, var_9_1.id)

	if var_9_2 then
		table.insert(arg_9_0._selectConditionIds, var_9_1.id)
	end

	Act183Helper.saveSelectConditionIdsInLocal(arg_9_0._activityId, arg_9_0._episodeId, arg_9_0._selectConditionIds)
	arg_9_0:refresh()
end

function var_0_0._refreshRewardRuleItemFunc(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = Act183Config.instance:getConditionCo(arg_10_2)

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0.decs1
	local var_10_2 = var_10_0.decs2

	arg_10_1.txtcondition.text = SkillHelper.buildDesc(var_10_1)
	arg_10_1.txteffect.text = var_10_2

	local var_10_3 = arg_10_0._selectConditionMap[arg_10_2] == true
	local var_10_4 = arg_10_0._groupEpisodeMo:isConditionPass(arg_10_2)

	ZProj.UGUIHelper.SetGrayscale(arg_10_1.imageicon.gameObject, not var_10_4)
	gohelper.setActive(arg_10_1.goselect, var_10_3)
	gohelper.setActive(arg_10_1.btncheck.gameObject, var_10_4 and arg_10_0._status ~= Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(arg_10_1.goselectbg, var_10_3)
	gohelper.setActive(arg_10_1.gounselectbg, not var_10_3 and var_10_4)
	gohelper.setActive(arg_10_1.go, true)
	Act183Helper.setEpisodeConditionStar(arg_10_1.imageicon, var_10_4, var_10_3)
end

function var_0_0._releaseRewardItemsFunc(arg_11_0)
	if arg_11_0._rewardRuleItemTab then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._rewardRuleItemTab) do
			iter_11_1.btncheck:RemoveClickListener()
		end
	end
end

function var_0_0.getSelectConditionMap(arg_12_0)
	return arg_12_0._selectConditionMap
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0:_releaseRewardItemsFunc()
	var_0_0.super.onDestroy(arg_13_0)
end

return var_0_0
