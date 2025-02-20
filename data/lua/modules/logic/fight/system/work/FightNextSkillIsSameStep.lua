module("modules.logic.fight.system.work.FightNextSkillIsSameStep", package.seeall)

slot0 = class("FightNextSkillIsSameStep", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0.stepMO = slot1
	slot0.prevStepMO = slot2

	FightController.instance:registerCallback(FightEvent.CheckPlaySameSkill, slot0._checkPlaySameSkill, slot0)
end

function slot0.onStart(slot0)
	slot0:onDone(true)
end

function slot0._checkPlaySameSkill(slot0, slot1, slot2)
	if slot1 ~= slot0.prevStepMO then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot0.stepMO.fromId) then
		return
	end

	if slot0.stepMO.fromId ~= slot0.prevStepMO.fromId then
		return
	end

	if FightDataHelper.entityMgr:getById(slot0.stepMO.fromId).side ~= FightDataHelper.entityMgr:getById(slot0.prevStepMO.fromId).side then
		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		if slot0.stepMO.actId ~= slot0.prevStepMO.actId then
			slot7 = -1
			slot8 = nil

			for slot12, slot13 in pairs(SkillConfig.instance:getHeroAllSkillIdDict(slot4.modelId)) do
				for slot17, slot18 in ipairs(slot13) do
					if slot18 == slot0.prevStepMO.actId then
						slot7 = slot12
					end

					if slot18 == slot0.stepMO.actId then
						slot8 = slot12
					end
				end
			end

			if slot7 ~= slot8 then
				return
			end
		end
	elseif slot0.stepMO.actId ~= slot0.prevStepMO.actId then
		slot6 = -1
		slot7 = nil

		for slot11, slot12 in ipairs(slot3.skillGroup1) do
			if slot0.prevStepMO.actId == slot12 then
				slot6 = 1
			end

			if slot0.stepMO.actId == slot12 then
				slot7 = 1
			end
		end

		for slot11, slot12 in ipairs(slot3.skillGroup2) do
			if slot0.prevStepMO.actId == slot12 then
				slot6 = 2
			end

			if slot0.stepMO.actId == slot12 then
				slot7 = 2
			end
		end

		if slot6 ~= slot7 then
			return
		end
	end

	FightController.instance:unregisterCallback(FightEvent.CheckPlaySameSkill, slot0._checkPlaySameSkill, slot0)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySameSkill, slot0.prevStepMO)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.CheckPlaySameSkill, slot0._checkPlaySameSkill, slot0)
end

return slot0
