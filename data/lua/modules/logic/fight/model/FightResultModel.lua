module("modules.logic.fight.model.FightResultModel", package.seeall)

local var_0_0 = class("FightResultModel", ListScrollModel)

function var_0_0.onEndDungeonPush(arg_1_0, arg_1_1)
	arg_1_0.chapterId = arg_1_1.chapterId
	arg_1_0.episodeId = arg_1_1.episodeId
	arg_1_0.playerExp = arg_1_1.playerExp
	arg_1_0.star = arg_1_1.star
	arg_1_0.firstPass = arg_1_1.firstPass
	arg_1_0._materialDataList = {}

	arg_1_0:_initFirstBonus(arg_1_1)
	arg_1_0:_initNormalBonus(arg_1_1)
	var_0_0._addMaterialDatasToList(arg_1_1.advencedBonus, arg_1_0._materialDataList, FightEnum.FightBonusTag.AdvencedBonus)
	arg_1_0:_initAdditionBonus(arg_1_1)
	arg_1_0:_initTimeFirstBonus(arg_1_1)
	arg_1_0:_initCommonDropBonus(arg_1_1)
	arg_1_0:_addExp(arg_1_1.firstBonus)
	arg_1_0:_addExp(arg_1_1.normalBonus)
	arg_1_0:_addExp(arg_1_1.advencedBonus)
	arg_1_0:_addExp(arg_1_1.additionBonus)
	arg_1_0:_addExp(arg_1_1.timeFirstBonus)
	table.sort(arg_1_0._materialDataList, var_0_0._sortMaterial)
	arg_1_0:_setLastEpisodePass()

	arg_1_0.updateDungeonRecord = arg_1_1.updateDungeonRecord
	arg_1_0.canUpdateDungeonRecord = arg_1_1.canUpdateDungeonRecord
	arg_1_0.oldRecordRound = arg_1_1.oldRecordRound
	arg_1_0.newRecordRound = arg_1_1.newRecordRound
	arg_1_0.assistUserId = arg_1_1.assistUserId
	arg_1_0.assistNickname = arg_1_1.assistNickname
	arg_1_0.totalRound = arg_1_1.totalRound

	if BossRushController.instance:isInBossRushFight(true) then
		BossRushModel.instance:onEndDungeonExtraStr(arg_1_1.extraStr)
	end
end

function var_0_0._initCommonDropBonus(arg_2_0, arg_2_1)
	arg_2_0.act155BonusList = {}
	arg_2_0.act153BonusList = {}
	arg_2_0.normal2SimpleList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.dropBonus) do
		local var_2_0 = iter_2_1.type

		if var_2_0 == FightEnum.DropType.Act155 or var_2_0 == FightEnum.DropType.Act158 then
			for iter_2_2, iter_2_3 in ipairs(iter_2_1.bonus) do
				if iter_2_3.materilType ~= MaterialEnum.MaterialType.Faith and iter_2_3.materilType ~= MaterialEnum.MaterialType.Exp then
					local var_2_1 = MaterialDataMO.New()

					var_2_1.bonusTag = FightEnum.FightBonusTag.ActBonus

					var_2_1:init(iter_2_3)
					table.insert(arg_2_0.act155BonusList, var_2_1)
				end
			end
		elseif var_2_0 == FightEnum.DropType.Act153 then
			for iter_2_4, iter_2_5 in ipairs(iter_2_1.bonus) do
				if iter_2_5.materilType ~= MaterialEnum.MaterialType.Faith and iter_2_5.materilType ~= MaterialEnum.MaterialType.Exp then
					local var_2_2 = MaterialDataMO.New()

					var_2_2.bonusTag = FightEnum.FightBonusTag.AdditionBonus

					var_2_2:init(iter_2_5)
					table.insert(arg_2_0.act153BonusList, var_2_2)
				end
			end

			table.sort(arg_2_0.act153BonusList, var_0_0._sortMaterial)
		elseif var_2_0 == FightEnum.DropType.Normal2Simple then
			for iter_2_6, iter_2_7 in ipairs(iter_2_1.bonus) do
				if iter_2_7.materilType ~= MaterialEnum.MaterialType.Faith and iter_2_7.materilType ~= MaterialEnum.MaterialType.Exp then
					local var_2_3 = MaterialDataMO.New()

					var_2_3.bonusTag = FightEnum.FightBonusTag.SimpleBouns

					var_2_3:init(iter_2_7)
					table.insert(arg_2_0.normal2SimpleList, var_2_3)
				end
			end
		end
	end
end

function var_0_0._initFirstBonus(arg_3_0, arg_3_1)
	arg_3_0._firstList = {}

	var_0_0._addMaterialDatasToList(arg_3_1.firstBonus, arg_3_0._firstList, FightEnum.FightBonusTag.FirstBonus)
	table.sort(arg_3_0._firstList, var_0_0._sortMaterial)
end

function var_0_0._initAdditionBonus(arg_4_0, arg_4_1)
	arg_4_0._additionList = {}

	var_0_0._addMaterialDatasToList(arg_4_1.additionBonus, arg_4_0._additionList, FightEnum.FightBonusTag.AdditionBonus)
	table.sort(arg_4_0._additionList, var_0_0._sortMaterial)
end

function var_0_0._initTimeFirstBonus(arg_5_0, arg_5_1)
	arg_5_0._timeFirstList = {}

	var_0_0._addMaterialDatasToList(arg_5_1.timeFirstBonus, arg_5_0._timeFirstList, FightEnum.FightBonusTag.TimeFirstBonus)
	table.sort(arg_5_0._timeFirstList, var_0_0._sortMaterial)
end

function var_0_0._initNormalBonus(arg_6_0, arg_6_1)
	arg_6_0._extraList = nil

	if not FightModel.instance:isEnterUseFreeLimit() then
		var_0_0._addMaterialDatasToList(arg_6_1.normalBonus, arg_6_0._materialDataList, FightEnum.FightBonusTag.NormalBonus)

		return
	end

	local var_6_0 = {}

	var_0_0._addMaterialDatasToList(arg_6_1.normalBonus, var_6_0, FightEnum.FightBonusTag.NormalBonus)

	local var_6_1 = {}

	table.sort(var_6_0, var_0_0._sortMaterial)

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if #var_6_1 < 3 and (iter_6_1.materilType == MaterialEnum.MaterialType.Currency or iter_6_1.materilType == MaterialEnum.MaterialType.Equip) then
			table.insert(var_6_1, iter_6_1)
		else
			table.insert(arg_6_0._materialDataList, iter_6_1)
		end
	end

	arg_6_0._extraList = var_6_1
end

function var_0_0.clear(arg_7_0)
	var_0_0.super.clear(arg_7_0)

	arg_7_0.chapterId = nil
	arg_7_0.episodeId = nil
	arg_7_0.playerExp = nil
	arg_7_0.star = nil
	arg_7_0._firstList = nil
	arg_7_0._extraList = nil
	arg_7_0._materialDataList = nil
	arg_7_0._additionList = nil
	arg_7_0._timeFirstList = nil
	arg_7_0.updateDungeonRecord = nil
	arg_7_0.curSendEpisodePass = nil
end

function var_0_0.getChapterId(arg_8_0)
	return arg_8_0.chapterId or DungeonModel.instance.curSendChapterId
end

function var_0_0.getEpisodeId(arg_9_0)
	return arg_9_0.episodeId or DungeonModel.instance.curSendEpisodeId
end

function var_0_0.getPlayerExp(arg_10_0)
	return arg_10_0.playerExp or 0
end

function var_0_0.getMaterialDataList(arg_11_0)
	return arg_11_0._materialDataList
end

function var_0_0.getExtraMaterialDataList(arg_12_0)
	return arg_12_0._extraList
end

function var_0_0.getFirstMaterialDataList(arg_13_0)
	return arg_13_0._firstList
end

function var_0_0.getAdditionMaterialDataList(arg_14_0)
	return arg_14_0._additionList
end

function var_0_0.getTimeFirstMaterialDataList(arg_15_0)
	return arg_15_0._timeFirstList
end

function var_0_0.getAct155MaterialDataList(arg_16_0)
	return arg_16_0.act155BonusList
end

function var_0_0.getAct153MaterialDataList(arg_17_0)
	return arg_17_0.act153BonusList
end

function var_0_0._addExp(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if iter_18_1.materilType == MaterialEnum.MaterialType.Exp then
			arg_18_0.playerExp = arg_18_0.playerExp + iter_18_1.quantity
		end
	end
end

function var_0_0._setLastEpisodePass(arg_19_0)
	local var_19_0 = DungeonModel.instance.curSendEpisodeId

	if var_19_0 then
		local var_19_1 = DungeonConfig.instance:getEpisodeCO(var_19_0)

		if arg_19_0.episodeId == var_19_0 or var_19_1 and arg_19_0.episodeId == var_19_1.chainEpisode then
			local var_19_2 = not DungeonModel.instance.curSendEpisodePrePass and arg_19_0.star > 0

			DungeonModel.instance.curSendEpisodePass = var_19_2

			return
		end
	end

	arg_19_0.curSendEpisodePass = false
end

function var_0_0._addMaterialDatasToList(arg_20_0, arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
		if iter_20_1.materilType ~= MaterialEnum.MaterialType.Faith and iter_20_1.materilType ~= MaterialEnum.MaterialType.Exp then
			local var_20_0 = MaterialDataMO.New()

			var_20_0.bonusTag = arg_20_2

			var_20_0:init(iter_20_1)
			table.insert(arg_20_1, var_20_0)
		end
	end
end

function var_0_0._sortMaterial(arg_21_0, arg_21_1)
	local var_21_0 = ItemModel.instance:getItemConfig(arg_21_0.materilType, arg_21_0.materilId)
	local var_21_1 = ItemModel.instance:getItemConfig(arg_21_1.materilType, arg_21_1.materilId)
	local var_21_2 = var_0_0._sortMaterialByBonusTag(arg_21_0, arg_21_1)

	if var_21_2 == nil then
		var_21_2 = var_0_0._sortMaterialByRare(var_21_0, var_21_1)
	end

	if var_21_2 == nil then
		var_21_2 = var_0_0._sortMaterialByType(arg_21_0, arg_21_1)
	end

	if var_21_2 == nil then
		var_21_2 = arg_21_0.materilId < arg_21_1.materilId
	end

	return var_21_2
end

function var_0_0._sortMaterialByBonusTag(arg_22_0, arg_22_1)
	local var_22_0 = FightEnum.FightBonusTagPriority[arg_22_0.bonusTag] or 0
	local var_22_1 = FightEnum.FightBonusTagPriority[arg_22_1.bonusTag] or 0

	if var_22_0 == var_22_1 then
		return nil
	end

	return var_22_1 < var_22_0
end

function var_0_0._sortMaterialByRare(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0 and arg_23_0.rare or 0
	local var_23_1 = arg_23_1 and arg_23_1.rare or 0

	if var_23_0 == var_23_1 then
		return nil
	end

	return var_23_1 < var_23_0
end

function var_0_0._sortMaterialByType(arg_24_0, arg_24_1)
	var_0_0.MaterialTypePriority = var_0_0.MaterialTypePriority or {
		[MaterialEnum.MaterialType.Item] = 1,
		[MaterialEnum.MaterialType.Currency] = 5,
		[MaterialEnum.MaterialType.Hero] = 4,
		[MaterialEnum.MaterialType.Equip] = 3,
		[MaterialEnum.MaterialType.PowerPotion] = 2
	}

	local var_24_0 = var_0_0.MaterialTypePriority[arg_24_0.materilType] or 0
	local var_24_1 = var_0_0.MaterialTypePriority[arg_24_1.materilType] or 0

	if var_24_0 == var_24_1 then
		return nil
	end

	return var_24_1 < var_24_0
end

function var_0_0.getNormal2SimpleMaterialDataList(arg_25_0)
	return arg_25_0.normal2SimpleList
end

var_0_0.instance = var_0_0.New()

return var_0_0
