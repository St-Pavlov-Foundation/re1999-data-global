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
	sortByRareDescend = function (slot0, slot1)
		return slot1:getDefineCfg().rare < slot0:getDefineCfg().rare
	end,
	sortByRareAscend = function (slot0, slot1)
		return slot0:getDefineCfg().rare < slot1:getDefineCfg().rare
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
	sortByEfficiencyDescend = function (slot0, slot1)
		if slot0.efficiency ~= slot1.efficiency then
			return slot0.efficiency < slot1.efficiency
		end
	end,
	sortByEfficiencyAscend = function (slot0, slot1)
		if slot0.efficiency ~= slot1.efficiency then
			return slot1.efficiency < slot0.efficiency
		end
	end,
	sortByPatienceDescend = function (slot0, slot1)
		if slot0.patience ~= slot1.patience then
			return slot0.patience < slot1.patience
		end
	end,
	sortByPatienceAscend = function (slot0, slot1)
		if slot0.patience ~= slot1.patience then
			return slot1.patience < slot0.patience
		end
	end,
	sortByLuckyDescend = function (slot0, slot1)
		if slot0.lucky ~= slot1.lucky then
			return slot0.lucky < slot1.lucky
		end
	end,
	sortByLuckyAscend = function (slot0, slot1)
		if slot0.lucky ~= slot1.lucky then
			return slot1.lucky < slot0.lucky
		end
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
	end
}
