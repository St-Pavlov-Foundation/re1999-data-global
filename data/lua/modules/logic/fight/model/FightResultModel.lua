module("modules.logic.fight.model.FightResultModel", package.seeall)

slot0 = class("FightResultModel", ListScrollModel)

function slot0.onEndDungeonPush(slot0, slot1)
	slot0.chapterId = slot1.chapterId
	slot0.episodeId = slot1.episodeId
	slot0.playerExp = slot1.playerExp
	slot0.star = slot1.star
	slot0.firstPass = slot1.firstPass
	slot0._materialDataList = {}

	slot0:_initFirstBonus(slot1)
	slot0:_initNormalBonus(slot1)
	uv0._addMaterialDatasToList(slot1.advencedBonus, slot0._materialDataList, FightEnum.FightBonusTag.AdvencedBonus)
	slot0:_initAdditionBonus(slot1)
	slot0:_initTimeFirstBonus(slot1)
	slot0:_initCommonDropBonus(slot1)
	slot0:_addExp(slot1.firstBonus)
	slot0:_addExp(slot1.normalBonus)
	slot0:_addExp(slot1.advencedBonus)
	slot0:_addExp(slot1.additionBonus)
	slot0:_addExp(slot1.timeFirstBonus)
	table.sort(slot0._materialDataList, uv0._sortMaterial)
	slot0:_setLastEpisodePass()

	slot0.updateDungeonRecord = slot1.updateDungeonRecord
	slot0.canUpdateDungeonRecord = slot1.canUpdateDungeonRecord
	slot0.oldRecordRound = slot1.oldRecordRound
	slot0.newRecordRound = slot1.newRecordRound
	slot0.assistUserId = slot1.assistUserId
	slot0.assistNickname = slot1.assistNickname
	slot0.totalRound = slot1.totalRound

	if BossRushController.instance:isInBossRushFight(true) then
		BossRushModel.instance:onEndDungeonExtraStr(slot1.extraStr)
	end
end

function slot0._initCommonDropBonus(slot0, slot1)
	slot0.act155BonusList = {}
	slot0.act153BonusList = {}
	slot0.normal2SimpleList = {}

	for slot5, slot6 in ipairs(slot1.dropBonus) do
		if slot6.type == FightEnum.DropType.Act155 or slot7 == FightEnum.DropType.Act158 then
			for slot11, slot12 in ipairs(slot6.bonus) do
				if slot12.materilType ~= MaterialEnum.MaterialType.Faith and slot12.materilType ~= MaterialEnum.MaterialType.Exp then
					slot13 = MaterialDataMO.New()
					slot13.bonusTag = FightEnum.FightBonusTag.ActBonus

					slot13:init(slot12)
					table.insert(slot0.act155BonusList, slot13)
				end
			end
		elseif slot7 == FightEnum.DropType.Act153 then
			for slot11, slot12 in ipairs(slot6.bonus) do
				if slot12.materilType ~= MaterialEnum.MaterialType.Faith and slot12.materilType ~= MaterialEnum.MaterialType.Exp then
					slot13 = MaterialDataMO.New()
					slot13.bonusTag = FightEnum.FightBonusTag.AdditionBonus

					slot13:init(slot12)
					table.insert(slot0.act153BonusList, slot13)
				end
			end

			table.sort(slot0.act153BonusList, uv0._sortMaterial)
		elseif slot7 == FightEnum.DropType.Normal2Simple then
			for slot11, slot12 in ipairs(slot6.bonus) do
				if slot12.materilType ~= MaterialEnum.MaterialType.Faith and slot12.materilType ~= MaterialEnum.MaterialType.Exp then
					slot13 = MaterialDataMO.New()
					slot13.bonusTag = FightEnum.FightBonusTag.SimpleBouns

					slot13:init(slot12)
					table.insert(slot0.normal2SimpleList, slot13)
				end
			end
		end
	end
end

function slot0._initFirstBonus(slot0, slot1)
	slot0._firstList = {}

	uv0._addMaterialDatasToList(slot1.firstBonus, slot0._firstList, FightEnum.FightBonusTag.FirstBonus)
	table.sort(slot0._firstList, uv0._sortMaterial)
end

function slot0._initAdditionBonus(slot0, slot1)
	slot0._additionList = {}

	uv0._addMaterialDatasToList(slot1.additionBonus, slot0._additionList, FightEnum.FightBonusTag.AdditionBonus)
	table.sort(slot0._additionList, uv0._sortMaterial)
end

function slot0._initTimeFirstBonus(slot0, slot1)
	slot0._timeFirstList = {}

	uv0._addMaterialDatasToList(slot1.timeFirstBonus, slot0._timeFirstList, FightEnum.FightBonusTag.TimeFirstBonus)
	table.sort(slot0._timeFirstList, uv0._sortMaterial)
end

function slot0._initNormalBonus(slot0, slot1)
	slot0._extraList = nil

	if not FightModel.instance:isEnterUseFreeLimit() then
		uv0._addMaterialDatasToList(slot1.normalBonus, slot0._materialDataList, FightEnum.FightBonusTag.NormalBonus)

		return
	end

	slot2 = {}

	uv0._addMaterialDatasToList(slot1.normalBonus, slot2, FightEnum.FightBonusTag.NormalBonus)

	slot3 = {}

	table.sort(slot2, uv0._sortMaterial)

	for slot7, slot8 in pairs(slot2) do
		if #slot3 < 3 and (slot8.materilType == MaterialEnum.MaterialType.Currency or slot8.materilType == MaterialEnum.MaterialType.Equip) then
			table.insert(slot3, slot8)
		else
			table.insert(slot0._materialDataList, slot8)
		end
	end

	slot0._extraList = slot3
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)

	slot0.chapterId = nil
	slot0.episodeId = nil
	slot0.playerExp = nil
	slot0.star = nil
	slot0._firstList = nil
	slot0._extraList = nil
	slot0._materialDataList = nil
	slot0._additionList = nil
	slot0._timeFirstList = nil
	slot0.updateDungeonRecord = nil
	slot0.curSendEpisodePass = nil
end

function slot0.getChapterId(slot0)
	return slot0.chapterId or DungeonModel.instance.curSendChapterId
end

function slot0.getEpisodeId(slot0)
	return slot0.episodeId or DungeonModel.instance.curSendEpisodeId
end

function slot0.getPlayerExp(slot0)
	return slot0.playerExp or 0
end

function slot0.getMaterialDataList(slot0)
	return slot0._materialDataList
end

function slot0.getExtraMaterialDataList(slot0)
	return slot0._extraList
end

function slot0.getFirstMaterialDataList(slot0)
	return slot0._firstList
end

function slot0.getAdditionMaterialDataList(slot0)
	return slot0._additionList
end

function slot0.getTimeFirstMaterialDataList(slot0)
	return slot0._timeFirstList
end

function slot0.getAct155MaterialDataList(slot0)
	return slot0.act155BonusList
end

function slot0.getAct153MaterialDataList(slot0)
	return slot0.act153BonusList
end

function slot0._addExp(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot6.materilType == MaterialEnum.MaterialType.Exp then
			slot0.playerExp = slot0.playerExp + slot6.quantity
		end
	end
end

function slot0._setLastEpisodePass(slot0)
	if DungeonModel.instance.curSendEpisodeId then
		slot2 = DungeonConfig.instance:getEpisodeCO(slot1)

		if slot0.episodeId == slot1 or slot2 and slot0.episodeId == slot2.chainEpisode then
			DungeonModel.instance.curSendEpisodePass = not DungeonModel.instance.curSendEpisodePrePass and slot0.star > 0

			return
		end
	end

	slot0.curSendEpisodePass = false
end

function slot0._addMaterialDatasToList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0) do
		if slot7.materilType ~= MaterialEnum.MaterialType.Faith and slot7.materilType ~= MaterialEnum.MaterialType.Exp then
			slot8 = MaterialDataMO.New()
			slot8.bonusTag = slot2

			slot8:init(slot7)
			table.insert(slot1, slot8)
		end
	end
end

function slot0._sortMaterial(slot0, slot1)
	if uv0._sortMaterialByBonusTag(slot0, slot1) == nil then
		slot4 = uv0._sortMaterialByRare(ItemModel.instance:getItemConfig(slot0.materilType, slot0.materilId), ItemModel.instance:getItemConfig(slot1.materilType, slot1.materilId))
	end

	if slot4 == nil then
		slot4 = uv0._sortMaterialByType(slot0, slot1)
	end

	if slot4 == nil then
		slot4 = slot0.materilId < slot1.materilId
	end

	return slot4
end

function slot0._sortMaterialByBonusTag(slot0, slot1)
	if (FightEnum.FightBonusTagPriority[slot0.bonusTag] or 0) == (FightEnum.FightBonusTagPriority[slot1.bonusTag] or 0) then
		return nil
	end

	return slot3 < slot2
end

function slot0._sortMaterialByRare(slot0, slot1)
	if (slot0 and slot0.rare or 0) == (slot1 and slot1.rare or 0) then
		return nil
	end

	return slot3 < slot2
end

function slot0._sortMaterialByType(slot0, slot1)
	uv0.MaterialTypePriority = uv0.MaterialTypePriority or {
		[MaterialEnum.MaterialType.Item] = 1,
		[MaterialEnum.MaterialType.Currency] = 5,
		[MaterialEnum.MaterialType.Hero] = 4,
		[MaterialEnum.MaterialType.Equip] = 3,
		[MaterialEnum.MaterialType.PowerPotion] = 2
	}

	if (uv0.MaterialTypePriority[slot0.materilType] or 0) == (uv0.MaterialTypePriority[slot1.materilType] or 0) then
		return nil
	end

	return slot3 < slot2
end

function slot0.getNormal2SimpleMaterialDataList(slot0)
	return slot0.normal2SimpleList
end

slot0.instance = slot0.New()

return slot0
