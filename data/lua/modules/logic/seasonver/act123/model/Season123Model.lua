module("modules.logic.seasonver.act123.model.Season123Model", package.seeall)

local var_0_0 = class("Season123Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actInfo = {}
end

function var_0_0.setActInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activityId
	local var_3_1 = arg_3_0._actInfo[var_3_0]

	if not var_3_1 then
		var_3_1 = Season123MO.New()
		arg_3_0._actInfo[var_3_0] = var_3_1
		arg_3_0._curSeasonId = var_3_0
	end

	var_3_1:updateInfo(arg_3_1)
end

function var_0_0.updateActInfoBattle(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.activityId
	local var_4_1 = arg_4_0._actInfo[var_4_0]

	if var_4_1 then
		var_4_1:updateInfoBattle(arg_4_1)
	end
end

function var_0_0.cleanCurSeasonId(arg_5_0)
	arg_5_0._curSeasonId = nil
end

function var_0_0.getActInfo(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return nil
	end

	return arg_6_0._actInfo[arg_6_1]
end

function var_0_0.setBattleContext(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0._battleContext = Season123BattleContext.New()

	arg_7_0._battleContext:init(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
end

function var_0_0.getBattleContext(arg_8_0)
	return arg_8_0._battleContext
end

function var_0_0.getSeasonHeroMO(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = arg_9_0:getActInfo(arg_9_1)

	if not var_9_0 then
		return nil
	end

	local var_9_1 = var_9_0.stageMap[arg_9_2]

	if not var_9_1 then
		return nil
	end

	local var_9_2 = var_9_1.episodeMap[arg_9_3]

	if not var_9_2 then
		return nil
	end

	local var_9_3 = var_9_2.heroesMap

	if not var_9_3 then
		return nil
	end

	return var_9_3[arg_9_4]
end

function var_0_0.getAssistData(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getActInfo(arg_10_1)

	if not var_10_0 then
		return nil
	end

	local var_10_1

	if arg_10_2 == nil then
		var_10_1 = var_10_0:getCurrentStage()
	else
		var_10_1 = var_10_0:getStageMO(arg_10_2)
	end

	if not var_10_1 then
		return nil
	end

	return var_10_1:getAssistHeroMO()
end

function var_0_0.isSeasonStagePosUnlock(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_0:getActInfo(arg_11_1)

	if not var_11_0 then
		return
	end

	local var_11_1 = arg_11_0:getUnlockCardIndex(arg_11_4, arg_11_3)

	return var_11_0:isStageSlotUnlock(arg_11_2, var_11_1) or var_11_0.unlockIndexSet and var_11_0.unlockIndexSet[var_11_1]
end

function var_0_0.getUnlockCardIndex(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == Season123EquipHeroItemListModel.MainCharPos then
		return ModuleEnum.MaxHeroCountInGroup * 2 + arg_12_2
	else
		return arg_12_1 + 1 + ModuleEnum.MaxHeroCountInGroup * (arg_12_2 - 1)
	end
end

function var_0_0.isEpisodeAdvance(arg_13_0, arg_13_1)
	return false
end

function var_0_0.getEpisodeRetail(arg_14_0, arg_14_1)
	return nil
end

function var_0_0.getCurSeasonId(arg_15_0)
	return arg_15_0._curSeasonId
end

function var_0_0.getAllItemMo(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._actInfo[arg_16_1]

	if var_16_0 then
		return var_16_0:getAllItemMap()
	end
end

function var_0_0.getSeasonAllHeroGroup(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._actInfo[arg_17_1]

	if var_17_0 then
		return var_17_0.heroGroupSnapshot
	end
end

function var_0_0.updateItemMap(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0:getAllItemMo(arg_18_1)

	if GameUtil.getTabLen(arg_18_2) > 0 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
			if Season123Config.instance:getSeasonEquipCo(iter_18_1.itemId) and not var_18_0[iter_18_1.uid] and iter_18_1.uid then
				local var_18_1 = Season123ItemMO.New()

				var_18_1:setData(iter_18_1)

				var_18_0[iter_18_1.uid] = var_18_1
			end
		end
	end

	if GameUtil.getTabLen(arg_18_3) > 0 then
		for iter_18_2, iter_18_3 in ipairs(arg_18_3) do
			if Season123Config.instance:getSeasonEquipCo(iter_18_3.itemId) then
				var_18_0[iter_18_3.uid] = nil
			end
		end
	end
end

function var_0_0.getSnapshotHeroGroup(arg_19_0, arg_19_1)
	if arg_19_0._battleContext then
		local var_19_0 = arg_19_0._battleContext.actId
		local var_19_1 = arg_19_0:getActInfo(var_19_0)

		if not var_19_1 then
			return
		end

		return var_19_1.heroGroupSnapshot[arg_19_1 or var_19_1.heroGroupSnapshotSubId]
	end
end

function var_0_0.getRetailHeroGroup(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._battleContext.actId
	local var_20_1 = arg_20_0:getActInfo(var_20_0)

	if not var_20_1 then
		return
	end

	return var_20_1.retailHeroGroups[arg_20_1 or 1]
end

function var_0_0.isEpisodeAfterStory(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	return false
end

function var_0_0.canPlayStageLevelup(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
	if arg_22_1 ~= 1 then
		return
	end

	if arg_22_2 ~= DungeonEnum.EpisodeType.Season123 then
		return
	end

	if arg_22_3 then
		return
	end

	arg_22_4 = arg_22_4 or arg_22_0:getCurSeasonId()

	if arg_22_0:isEpisodeAfterStory(arg_22_4, arg_22_6) then
		return
	end

	local var_22_0 = Season123Config.instance:getSeasonEpisodeCo(arg_22_4, arg_22_5, arg_22_6 + 1)

	return var_22_0 and var_22_0.stage
end

function var_0_0.addCardGetData(arg_23_0, arg_23_1)
	local var_23_0 = Season123ViewHelper.getViewName(arg_23_0._curSeasonId, "CelebrityCardGetView")
	local var_23_1 = ViewName[var_23_0]

	for iter_23_0 = 1, PopupController.instance._popupList:getSize() do
		if PopupController.instance._popupList._dataList[iter_23_0][2] == var_23_1 then
			local var_23_2 = PopupController.instance._popupList._dataList[iter_23_0][3].data

			tabletool.addValues(var_23_2, arg_23_1)

			PopupController.instance._popupList._dataList[iter_23_0][3] = {
				is_item_id = true,
				data = var_23_2
			}

			return
		end
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, var_23_1, {
		is_item_id = true,
		data = arg_23_1
	})
end

function var_0_0.setUnlockAct123EquipIds(arg_24_0, arg_24_1)
	arg_24_0:getActInfo(arg_24_1.activityId):setUnlockAct123EquipIds(arg_24_1.unlockAct123EquipIds)
end

function var_0_0.isNewEquipBookCard(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getActInfo(arg_25_0._curSeasonId)

	if not var_25_0 then
		return
	end

	return not var_25_0.unlockAct123EquipIds[arg_25_1]
end

function var_0_0.getAllUnlockAct123EquipIds(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getActInfo(arg_26_1)

	if not var_26_0 then
		return
	end

	return var_26_0.unlockAct123EquipIds
end

function var_0_0.getFightCardDataList(arg_27_0)
	local var_27_0 = FightModel.instance:getFightParam()
	local var_27_1 = var_27_0.activity104Equips

	return Season123HeroGroupUtils.fiterFightCardDataList(var_27_1, var_27_0.trialHeroList, arg_27_0:getCurSeasonId())
end

function var_0_0.hasSeason123TaskData(arg_28_0, arg_28_1)
	local var_28_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123)

	if var_28_0 then
		for iter_28_0, iter_28_1 in pairs(var_28_0) do
			if iter_28_1.config and iter_28_1.config.seasonId == arg_28_1 and iter_28_1.config.isRewardView == Activity123Enum.TaskRewardViewType then
				return true
			end
		end
	else
		return false
	end
end

function var_0_0.updateTaskReward(arg_29_0)
	for iter_29_0, iter_29_1 in pairs(arg_29_0._actInfo) do
		iter_29_1:initStageRewardConfig()
	end
end

function var_0_0.checkHasUnlockStory(arg_30_0, arg_30_1)
	local var_30_0 = "Season123StoryUnlock" .. "#" .. tostring(arg_30_1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local var_30_1 = PlayerPrefsHelper.getString(var_30_0, "")
	local var_30_2 = {}
	local var_30_3 = {}

	if not string.nilorempty(var_30_1) then
		local var_30_4 = cjson.decode(var_30_1)

		for iter_30_0, iter_30_1 in ipairs(var_30_4) do
			local var_30_5 = string.split(iter_30_1, "|")

			var_30_3[tonumber(var_30_5[1])] = var_30_5[2] == "true"
		end
	end

	local var_30_6 = Season123Config.instance:getAllStoryCo(arg_30_1) or {}

	for iter_30_2, iter_30_3 in pairs(var_30_6) do
		local var_30_7 = var_0_0.instance:getActInfo(arg_30_1).stageMap[iter_30_3.condition]
		local var_30_8 = var_30_7 and var_30_7.isPass
		local var_30_9 = Season123ProgressUtils.isStageUnlock(arg_30_1, iter_30_3.condition) and var_30_8 == true

		if var_30_9 and var_30_3[iter_30_2] ~= var_30_9 then
			return true
		end
	end

	return false
end

function var_0_0.getSingleBgFolder(arg_31_0)
	if arg_31_0._curSeasonId then
		return Activity123Enum.SeasonIconFolder[arg_31_0._curSeasonId]
	end
end

function var_0_0.setRetailRandomSceneId(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1 and arg_32_1.needRandom

	arg_32_0.retailSceneId = PlayerPrefsHelper.getNumber(arg_32_0:getRetailRandomSceneKey(), -1)

	if arg_32_0.retailSceneId < 0 or var_32_0 then
		arg_32_0.retailSceneId = math.random(0, 2)

		PlayerPrefsHelper.setNumber(arg_32_0:getRetailRandomSceneKey(), arg_32_0.retailSceneId)
	end
end

function var_0_0.getRetailRandomSceneKey(arg_33_0)
	return "Season123RetailRandomSceneId" .. "#" .. tostring(arg_33_0._curSeasonId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
