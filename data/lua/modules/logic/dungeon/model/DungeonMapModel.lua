module("modules.logic.dungeon.model.DungeonMapModel", package.seeall)

local var_0_0 = class("DungeonMapModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._mapIds = {}
	arg_2_0._elements = {}
	arg_2_0._rewardPointInfoList = {}
	arg_2_0._curMap = nil
	arg_2_0._dialogHistory = {}
	arg_2_0._dialogIdHistory = {}
	arg_2_0._equipSpChapters = {}
	arg_2_0.lastElementBattleId = nil
	arg_2_0.playAfterStory = nil
	arg_2_0._finishElements = {}
	arg_2_0.focusEpisodeTweenDuration = nil
	arg_2_0.directFocusElement = nil
	arg_2_0.preloadMapCfg = nil
	arg_2_0._puzzleStatusMap = nil
	arg_2_0._mapInteractiveItemVisible = nil
end

function var_0_0.addDialog(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	table.insert(arg_3_0._dialogHistory, {
		arg_3_1,
		arg_3_2,
		arg_3_3,
		arg_3_4
	})
end

function var_0_0.getDialog(arg_4_0)
	return arg_4_0._dialogHistory
end

function var_0_0.clearDialog(arg_5_0)
	arg_5_0._dialogHistory = {}
end

function var_0_0.addDialogId(arg_6_0, arg_6_1)
	table.insert(arg_6_0._dialogIdHistory, arg_6_1)
end

function var_0_0.getDialogId(arg_7_0)
	return arg_7_0._dialogIdHistory
end

function var_0_0.clearDialogId(arg_8_0)
	arg_8_0._dialogIdHistory = {}
end

function var_0_0.updateMapIds(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		arg_9_0._mapIds[iter_9_1] = iter_9_1
	end
end

function var_0_0.mapIsUnlock(arg_10_0, arg_10_1)
	return arg_10_0._mapIds[arg_10_1]
end

function var_0_0.getElementById(arg_11_0, arg_11_1)
	return arg_11_0._elements[arg_11_1]
end

function var_0_0.addFinishedElement(arg_12_0, arg_12_1)
	arg_12_0._finishElements[arg_12_1] = true
end

function var_0_0.addFinishedElements(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		arg_13_0._finishElements[iter_13_1] = true
	end
end

function var_0_0.elementIsFinished(arg_14_0, arg_14_1)
	return arg_14_0._finishElements[arg_14_1]
end

function var_0_0.getNewElements(arg_15_0)
	return arg_15_0._newElements
end

function var_0_0.clearNewElements(arg_16_0)
	arg_16_0._newElements = nil
end

function var_0_0.setNewElements(arg_17_0, arg_17_1)
	arg_17_0._newElements = arg_17_1
end

function var_0_0.addElements(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		arg_18_0._elements[iter_18_1] = iter_18_1
	end
end

function var_0_0.removeElement(arg_19_0, arg_19_1)
	arg_19_0._elements[arg_19_1] = nil
end

function var_0_0.getAllElements(arg_20_0)
	return arg_20_0._elements
end

function var_0_0.getElements(arg_21_0, arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(arg_21_0._elements) do
		local var_21_1 = DungeonConfig.instance:getChapterMapElement(iter_21_1)

		if VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(iter_21_1) and DungeonConfig.instance:isActivity1_2Map(arg_21_1) then
			table.insert(var_21_0, var_21_1)
		elseif var_21_1 and var_21_1.mapId == arg_21_1 then
			local var_21_2 = true

			if ToughBattleConfig.instance:isActEleCo(var_21_1) and not ToughBattleModel.instance:getActIsOnline() then
				var_21_2 = false
			end

			if var_21_2 then
				table.insert(var_21_0, var_21_1)
			end
		end
	end

	return var_21_0
end

function var_0_0.initEquipSpChapters(arg_22_0, arg_22_1)
	arg_22_0._equipSpChapters = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		table.insert(arg_22_0._equipSpChapters, iter_22_1)
	end
end

function var_0_0.updateEquipSpChapter(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_2 == false then
		table.insert(arg_23_0._equipSpChapters, arg_23_1)

		return
	end

	tabletool.removeValue(arg_23_0._equipSpChapters, arg_23_1)
	DungeonModel.instance:resetEpisodeInfoByChapterId(arg_23_1)
end

function var_0_0.getEquipSpChapters(arg_24_0)
	return arg_24_0._equipSpChapters
end

function var_0_0.isUnlockSpChapter(arg_25_0, arg_25_1)
	return tabletool.indexOf(arg_25_0._equipSpChapters, arg_25_1)
end

function var_0_0.updateRewardPoint(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:getRewardPointInfo(arg_26_1)

	if var_26_0 then
		var_26_0:setRewardPoint(arg_26_2)
	end
end

function var_0_0.initRewardPointInfo(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		local var_27_0 = RewardPointInfoMO.New()

		var_27_0:init(iter_27_1)

		arg_27_0._rewardPointInfoList[var_27_0.chapterId] = var_27_0
	end
end

function var_0_0.getTotalRewardPointProgress(arg_28_0, arg_28_1)
	local var_28_0, var_28_1 = arg_28_0:_getRewardPointProgress(arg_28_1)

	return var_28_0, var_28_1
end

function var_0_0._getRewardPointProgress(arg_29_0, arg_29_1)
	if not arg_29_1 or arg_29_1 <= 0 then
		return 0, 0
	end

	local var_29_0 = var_0_0.instance:getRewardPointValue(arg_29_1)
	local var_29_1 = DungeonConfig.instance:getChapterPointReward(arg_29_1)

	if not var_29_1 then
		local var_29_2 = DungeonConfig.instance:getChapterCO(arg_29_1)

		return arg_29_0:_getRewardPointProgress(var_29_2.preChapter)
	end

	local var_29_3 = var_29_1[#var_29_1].rewardPointNum

	return math.min(var_29_0, var_29_3), var_29_3
end

function var_0_0.getRewardPointInfo(arg_30_0, arg_30_1)
	arg_30_1 = 0

	return arg_30_0._rewardPointInfoList[arg_30_1]
end

function var_0_0.getRewardPointValue(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getRewardPointInfo(arg_31_1)

	return var_31_0 and var_31_0.rewardPoint or 0
end

function var_0_0.addRewardPoint(arg_32_0, arg_32_1)
	local var_32_0 = lua_chapter_map_element.configDict[arg_32_1]

	if var_32_0.rewardPoint <= 0 then
		return
	end

	local var_32_1 = lua_chapter_map.configDict[var_32_0.mapId]
	local var_32_2 = arg_32_0:getRewardPointInfo(var_32_1.chapterId)

	var_32_2.rewardPoint = var_32_2.rewardPoint + var_32_0.rewardPoint
end

function var_0_0.addPointRewardIds(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		local var_33_0 = lua_chapter_point_reward.configDict[iter_33_1]
		local var_33_1 = arg_33_0:getRewardPointInfo(var_33_0.chapterId)

		table.insert(var_33_1.hasGetPointRewardIds, iter_33_1)
	end
end

function var_0_0.getUnfinishedTargetReward(arg_34_0)
	local var_34_0 = var_0_0.instance:getRewardPointInfo()
	local var_34_1

	for iter_34_0, iter_34_1 in ipairs(lua_chapter_point_reward.configList) do
		if iter_34_1.display > 0 then
			var_34_1 = iter_34_1

			if var_34_0.rewardPoint < var_34_1.rewardPointNum or not tabletool.indexOf(var_34_0.hasGetPointRewardIds, var_34_1.id) then
				break
			end
		end
	end

	return var_34_1
end

function var_0_0.canGetAllRewardsList(arg_35_0)
	local var_35_0 = lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList].chapterId

	return (var_0_0.instance:canGetRewardsList(var_35_0))
end

function var_0_0.canGetRewardsList(arg_36_0, arg_36_1)
	local var_36_0 = {}

	for iter_36_0 = 101, arg_36_1 do
		local var_36_1 = var_0_0.instance:canGetRewards(iter_36_0)

		tabletool.addValues(var_36_0, var_36_1)
	end

	return var_36_0
end

function var_0_0.canGetRewards(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:getRewardPointInfo(arg_37_1)

	if not var_37_0 then
		return nil
	end

	local var_37_1 = var_37_0.rewardPoint

	if var_37_1 <= 0 then
		return nil
	end

	local var_37_2 = {}
	local var_37_3 = DungeonConfig.instance:getChapterPointReward(arg_37_1)

	if not var_37_3 then
		return var_37_2
	end

	for iter_37_0, iter_37_1 in ipairs(var_37_3) do
		if iter_37_1.rewardPointNum > 0 and var_37_1 >= iter_37_1.rewardPointNum and not tabletool.indexOf(var_37_0.hasGetPointRewardIds, iter_37_1.id) then
			table.insert(var_37_2, iter_37_1.id)
		end
	end

	return var_37_2
end

function var_0_0.isUnFinishedElement(arg_38_0, arg_38_1)
	local var_38_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_38_1)
	local var_38_1 = DungeonConfig.instance:getChapterMapCfg(arg_38_1, 0)

	if arg_38_0:_getMapElementsNum(var_38_1) > 0 then
		return true
	end

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		local var_38_2 = DungeonConfig.instance:getChapterMapCfg(iter_38_1.chapterId, iter_38_1.id)

		if arg_38_0:_getMapElementsNum(var_38_2) > 0 then
			return true
		end
	end

	return false
end

function var_0_0._getMapElementsNum(arg_39_0, arg_39_1)
	if arg_39_1 and var_0_0.instance:mapIsUnlock(arg_39_1.id) then
		local var_39_0 = var_0_0.instance:getElements(arg_39_1.id)
		local var_39_1 = 0

		for iter_39_0, iter_39_1 in ipairs(var_39_0) do
			if not string.nilorempty(iter_39_1.effect) then
				var_39_1 = var_39_1 + 1
			end
		end

		return var_39_1
	end

	return 0
end

function var_0_0.getChapterLastMap(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_40_1)
	local var_40_1
	local var_40_2

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		local var_40_3 = DungeonModel.instance:getEpisodeInfo(iter_40_1.id)

		if var_40_3 and var_40_3.isNew then
			local var_40_4 = DungeonConfig.instance:getChapterMapCfg(arg_40_1, iter_40_1.id)

			if var_40_4 then
				var_40_1 = var_40_4

				break
			end
		end

		if not (iter_40_1.id == arg_40_2) and DungeonModel.instance:hasPassLevelAndStory(iter_40_1.id) then
			local var_40_5 = DungeonConfig.instance:getChapterMapCfg(arg_40_1, iter_40_1.id)

			if var_40_5 then
				var_40_1 = var_40_5
			end
		end
	end

	var_40_1 = var_40_1 or DungeonConfig.instance:getChapterMapCfg(arg_40_1, 0)

	return var_40_1
end

function var_0_0.initMapPuzzleStatus(arg_41_0, arg_41_1)
	arg_41_0._puzzleStatusMap = {}

	if arg_41_1 then
		for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
			arg_41_0._puzzleStatusMap[iter_41_1] = true
		end
	end
end

function var_0_0.hasMapPuzzleStatus(arg_42_0, arg_42_1)
	return arg_42_0._puzzleStatusMap ~= nil and arg_42_0._puzzleStatusMap[arg_42_1]
end

function var_0_0.setPuzzleStatus(arg_43_0, arg_43_1)
	arg_43_0._puzzleStatusMap = arg_43_0._puzzleStatusMap or {}
	arg_43_0._puzzleStatusMap[arg_43_1] = true
end

function var_0_0.setMapInteractiveItemVisible(arg_44_0, arg_44_1)
	arg_44_0._mapInteractiveItemVisible = arg_44_1
end

function var_0_0.getMapInteractiveItemVisible(arg_45_0)
	return arg_45_0._mapInteractiveItemVisible
end

var_0_0.instance = var_0_0.New()

return var_0_0
