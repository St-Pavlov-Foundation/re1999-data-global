module("modules.logic.versionactivity2_1.activity165.model.Activity165StepMo", package.seeall)

slot0 = class("Activity165StepMo")

function slot0.ctor(slot0)
	slot0._actId = nil
	slot0.stepId = nil
	slot0.stepCo = nil
	slot0.isEndingStep = nil
	slot0.isFirstStep = nil
	slot0.nextSteps = nil
	slot0.lastSteps = nil
	slot0.roundSteps = nil
	slot0.isUnlock = nil
	slot0.isFixStep = nil
	slot0.canUseKeywordMos = nil
end

function slot0.onInit(slot0, slot1, slot2, slot3)
	slot0._actId = slot1
	slot0.stepId = slot2
	slot0.stepCo = Activity165Config.instance:getStepCo(slot1, slot2)
	slot0.nextSteps = {}

	if not string.nilorempty(slot0.stepCo.answersKeywordIds) then
		slot0.isEndingStep = slot0.stepCo.answersKeywordIds == "-1"

		if not slot0.isEndingStep then
			for slot8, slot9 in pairs(GameUtil.splitString2(slot0.stepCo.answersKeywordIds, "#", "|")) do
				if LuaUtil.tableNotEmpty(slot9) then
					slot12 = (slot0.nextSteps[slot9[1]] or {
						nextId = slot10
					}).needKws or {}
					slot13 = {}

					for slot17 = 2, #slot9 do
						table.insert(slot13, slot9[slot17])
					end

					table.insert(slot12, slot13)

					slot11.needKws = slot12
					slot0.nextSteps[slot10] = slot11
				end
			end
		end
	end

	slot0.lastSteps = {}
	slot0.roundSteps = {}

	if not string.nilorempty(slot0.stepCo.nextStepConditionIds) then
		for slot8, slot9 in pairs(GameUtil.splitString2(slot0.stepCo.nextStepConditionIds, "#", "|")) do
			if LuaUtil.tableNotEmpty(slot9) then
				slot10 = {}

				for slot14 = 2, #slot9 do
					table.insert(slot10, slot9[slot14])
				end

				if LuaUtil.tableNotEmpty(slot10) then
					table.insert(slot0.lastSteps, slot10)
				end

				slot11 = tabletool.copy(slot10)

				table.insert(slot11, slot0.stepId)
				table.insert(slot11, slot9[1])
				table.insert(slot0.roundSteps, slot11)
			end
		end
	end

	slot0.isUnlock = false
	slot0.canUseKeywordMos = {}

	if not string.nilorempty(slot0.stepCo.optionalKeywordIds) then
		for slot8, slot9 in pairs(string.splitToNumber(slot0.stepCo.optionalKeywordIds, "#")) do
			table.insert(slot0.canUseKeywordMos, slot3:getKeywordMo(slot9))
		end
	end
end

function slot0.setCanUseKeywords(slot0)
end

function slot0.isSameTableValue(slot0, slot1, slot2)
	if LuaUtil.tableNotEmpty(slot1) and LuaUtil.tableNotEmpty(slot2) then
		if tabletool.len(slot1) ~= tabletool.len(slot2) then
			return false
		end

		for slot6, slot7 in pairs(slot1) do
			if not LuaUtil.tableContains(slot2, slot7) then
				return false
			end
		end

		return true
	end
end

function slot0.onReset(slot0)
	slot0.isUnlock = nil
	slot0.isFixStep = nil
end

function slot0.getNextStep(slot0, slot1)
	for slot5, slot6 in pairs(slot0.nextSteps) do
		for slot10, slot11 in pairs(slot6.needKws) do
			if slot0:isSameTableValue(slot11, slot1) then
				return slot6.nextId
			end
		end
	end
end

function slot0.getNextStepKeyword(slot0, slot1)
	for slot5, slot6 in pairs(slot0.nextSteps) do
		if slot6.nextId == slot1 then
			slot7, slot8 = next(slot6.needKws)

			return slot8
		end
	end
end

function slot0.setUnlock(slot0, slot1)
	slot0.isUnlock = slot1
end

function slot0.getCanEndingRound(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0.roundSteps) do
		if LuaUtil.tableContains(slot1, slot7[#slot7]) then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getCanUseKeywords(slot0)
	return slot0.canUseKeywordMos
end

return slot0
