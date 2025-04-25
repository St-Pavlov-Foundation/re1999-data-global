module("modules.logic.critter.utils.CritterHelper", package.seeall)

return {
	getInitClassMOList = function (slot0, slot1, slot2)
		slot3 = {}

		if slot0 then
			for slot7, slot8 in ipairs(slot0) do
				slot9 = nil

				if slot2 then
					slot9 = slot2[slot7]
				end

				slot9 = slot9 or slot1.New()

				slot9:init(slot8)
				table.insert(slot3, slot9)
			end
		end

		return slot3
	end,
	sortByCritterId = function (slot0, slot1)
		if slot0:getDefineId() ~= slot1:getDefineId() then
			return slot2 < slot3
		end

		return slot0:getId() < slot1:getId()
	end,
	sortByRareDescend = function (slot0, slot1)
		if slot0:getDefineCfg().rare ~= slot1:getDefineCfg().rare then
			return slot5 < slot4
		end

		return uv0.sortByCritterId(slot0, slot1)
	end,
	sortByRareAscend = function (slot0, slot1)
		if slot0:getDefineCfg().rare ~= slot1:getDefineCfg().rare then
			return slot4 < slot5
		end

		return uv0.sortByCritterId(slot0, slot1)
	end,
	getCritterAttrSortFunc = function (slot0, slot1)
		if not uv0._descendFuncMap then
			uv0._descendFuncMap = {
				[CritterEnum.AttributeType.Efficiency] = uv0.sortByEfficiencyDescend,
				[CritterEnum.AttributeType.Patience] = uv0.sortByPatienceDescend,
				[CritterEnum.AttributeType.Lucky] = uv0.sortByLuckyDescend
			}
			uv0._ascendSortFuncMap = {
				[CritterEnum.AttributeType.Efficiency] = uv0.sortByEfficiencyAscend,
				[CritterEnum.AttributeType.Patience] = uv0.sortByPatienceAscend,
				[CritterEnum.AttributeType.Lucky] = uv0.sortByLuckyAscend
			}
		end

		return (slot1 and uv0._ascendSortFuncMap or uv0._descendFuncMap)[slot0]
	end,
	sortByTotalAttrValue = function (slot0, slot1)
		if slot0:getTotalAttrValue() ~= slot1:getTotalAttrValue() then
			return slot3 < slot2
		end

		return uv0.sortByRareDescend(slot0, slot1)
	end,
	sortByEfficiencyDescend = function (slot0, slot1)
		if slot0.efficiencyIncrRate ~= slot1.efficiencyIncrRate then
			return slot3 < slot2
		end

		if slot0:isAddition(CritterEnum.AttributeType.Efficiency) ~= slot1:isAddition(CritterEnum.AttributeType.Efficiency) then
			return slot4
		end

		if slot0.efficiency ~= slot1.efficiency then
			return slot1.efficiency < slot0.efficiency
		end

		return uv0.sortByTotalAttrValue(slot0, slot1)
	end,
	sortByEfficiencyAscend = function (slot0, slot1)
		if slot0.efficiencyIncrRate ~= slot1.efficiencyIncrRate then
			return slot2 < slot3
		end

		if slot0:isAddition(CritterEnum.AttributeType.Efficiency) ~= slot1:isAddition(CritterEnum.AttributeType.Efficiency) then
			return slot4
		end

		if slot0.efficiency ~= slot1.efficiency then
			return slot0.efficiency < slot1.efficiency
		end

		return uv0.sortByTotalAttrValue(slot0, slot1)
	end,
	sortByPatienceDescend = function (slot0, slot1)
		if slot0.patienceIncrRate ~= slot1.patienceIncrRate then
			return slot3 < slot2
		end

		if slot0:isAddition(CritterEnum.AttributeType.Patience) ~= slot1:isAddition(CritterEnum.AttributeType.Patience) then
			return slot4
		end

		if slot0.patience ~= slot1.patience then
			return slot1.patience < slot0.patience
		end

		return uv0.sortByTotalAttrValue(slot0, slot1)
	end,
	sortByPatienceAscend = function (slot0, slot1)
		if slot0.patienceIncrRate ~= slot1.patienceIncrRate then
			return slot2 < slot3
		end

		if slot0:isAddition(CritterEnum.AttributeType.Patience) ~= slot1:isAddition(CritterEnum.AttributeType.Patience) then
			return slot4
		end

		if slot0.patience ~= slot1.patience then
			return slot0.patience < slot1.patience
		end

		return uv0.sortByTotalAttrValue(slot0, slot1)
	end,
	sortByLuckyDescend = function (slot0, slot1)
		if slot0.luckyIncrRate ~= slot1.luckyIncrRate then
			return slot3 < slot2
		end

		if slot0:isAddition(CritterEnum.AttributeType.Lucky) ~= slot1:isAddition(CritterEnum.AttributeType.Lucky) then
			return slot4
		end

		if slot0.lucky ~= slot1.lucky then
			return slot1.lucky < slot0.lucky
		end

		return uv0.sortByRareDescend(slot0, slot1)
	end,
	sortByLuckyAscend = function (slot0, slot1)
		if slot0.luckyIncrRate ~= slot1.luckyIncrRate then
			return slot2 < slot3
		end

		if slot0:isAddition(CritterEnum.AttributeType.Lucky) ~= slot1:isAddition(CritterEnum.AttributeType.Lucky) then
			return slot4
		end

		if slot0.lucky ~= slot1.lucky then
			return slot0.lucky < slot1.lucky
		end

		return uv0.sortByRareDescend(slot0, slot1)
	end,
	sortEvent = function (slot0, slot1)
		if uv0._getEventSortIndex(slot0) ~= uv0._getEventSortIndex(slot1) then
			return slot2 < slot3
		end
	end,
	_getEventSortIndex = function (slot0)
		if slot0:isNoMood() then
			return 1
		elseif slot0:isCultivating() then
			if slot0.trainInfo:isHasEventTrigger() then
				return 2
			elseif slot0.trainInfo:isTrainFinish() then
				return 3
			end
		end

		return 100
	end,
	getEventTypeByCritterMO = function (slot0)
		if not slot0 then
			return nil
		end

		if slot0:isCultivating() then
			if slot0.trainInfo:isHasEventTrigger() then
				return CritterEnum.CritterItemEventType.HasTrainEvent
			elseif slot0.trainInfo:isTrainFinish() then
				return CritterEnum.CritterItemEventType.TrainEventComplete
			end
		elseif slot0:isNoMoodWorking() then
			return CritterEnum.CritterItemEventType.NoMoodWork
		end

		return nil
	end,
	getWorkCritterMOListByBuid = function (slot0)
		slot1 = {}

		for slot6, slot7 in ipairs(CritterModel.instance:getAllCritters()) do
			if slot7:isMaturity() and slot7.workInfo and slot7.workInfo.workBuildingUid == slot0 then
				table.insert(slot1, slot7)
			end
		end

		return slot1
	end,
	_sumTempAttrInfoParam = {},
	sumArrtInfoMOByAttrId = function (slot0, slot1, slot2, slot3)
		slot4 = uv0._sumTempAttrInfoParam
		slot4.attributeId = slot0
		slot4.value = 0
		slot4.rate = 0
		slot4.addRate = 0

		if slot1 and #slot1 > 0 then
			for slot8, slot9 in ipairs(slot1) do
				if slot9:getAttributeInfoByType(slot0, slot2, slot3) then
					slot4.value = slot4.value + slot10.value
					slot4.rate = slot4.rate + slot10.rate
					slot4.addRate = slot4.addRate + slot10:getAdditionRate()
				end
			end
		end

		slot5 = CritterAttributeInfoMO.New()

		slot5:init(slot4)

		return slot5
	end,
	getPreViewAttrValue = function (slot0, slot1, slot2, slot3)
		if ManufactureCritterListModel.instance:getPreviewAttrInfo(slot1, slot2, slot3) then
			if slot0 == CritterEnum.AttributeType.Efficiency then
				return slot4.efficiency or 0
			elseif slot0 == CritterEnum.AttributeType.Patience then
				return slot4.moodCostSpeed or 0
			elseif slot0 == CritterEnum.AttributeType.Lucky then
				return slot4.criRate or 0
			elseif slot0 == CritterEnum.AttributeType.MoodRestore then
				return slot4.moodCostSpeed or 0
			end
		end

		return 0
	end,
	sumPreViewAttrValue = function (slot0, slot1)
		slot2 = 0

		if slot1 and #slot1 > 0 then
			for slot6, slot7 in ipairs(slot1) do
				slot2 = slot2 + uv0.getPreViewAttrValue(slot0, slot7)
			end
		end

		return slot2
	end,
	formatAttrValue = function (slot0, slot1)
		if slot0 == CritterEnum.AttributeType.MoodRestore then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("critter_mood_cost_speed"), slot1)
		elseif slot0 == CritterEnum.AttributeType.Patience then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("critter_mood_cost_speed"), slot1)
		elseif slot0 == CritterEnum.AttributeType.Lucky then
			return string.format("%s%%", slot1)
		end

		return slot1
	end,
	buildFakeCritterMoByConfig = function (slot0)
		slot1 = CritterMO.New()
		slot2 = 0
		slot3 = 0
		slot4 = 0
		slot5 = 0
		slot6 = 0
		slot7 = 0
		slot8 = {}

		if slot0 then
			if not string.nilorempty(slot0.baseAttribute) then
				slot2 = GameUtil.splitString2(slot0.baseAttribute, true)[1][2] or 0
				slot3 = slot9[2][2] or 0
				slot4 = slot9[3][2] or 0
			end

			if not string.nilorempty(slot0.baseAttribute) then
				slot5 = GameUtil.splitString2(slot0.attributeIncrRate, true)[1][2] or 0
				slot6 = slot9[2][2] or 0
				slot7 = slot9[3][2] or 0
			end

			slot8 = {
				tags = {
					slot0.raceTag
				}
			}
		end

		slot1:init({
			uid = "0",
			id = "0",
			specialSkin = false,
			defineId = slot0.id,
			efficiency = slot2,
			patience = slot3,
			lucky = slot4,
			efficiencyIncrRate = slot5,
			patienceIncrRate = slot6,
			luckyIncrRate = slot7,
			tagAttributeRates = {},
			skillInfo = slot8
		})

		return slot1
	end,
	getPatienceChangeValue = function (slot0)
		if CritterConfig.instance:getPatienceChangeCfg(slot0) then
			return slot1.stepTime * slot1.stepValue / 3600
		end

		return 0
	end
}
