module("modules.logic.fight.system.flow.FightClothSkillSequence", package.seeall)

slot0 = class("FightClothSkillSequence", BaseFightSequence)

function slot0.buildFlow(slot0, slot1)
	uv0.super.buildFlow(slot0)

	slot0.roundMO = slot1

	slot0:buildRoundFlows()
end

function slot0.buildRoundFlows(slot0)
	slot0:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.StartPlayClothSkill)
	end))

	if FightStepBuilder.buildStepWorkList(slot0.roundMO and slot0.roundMO.fightStepMOs) then
		for slot5, slot6 in ipairs(slot1) do
			slot0:addWork(slot6)
		end
	end

	slot0:addWork(FunctionWork.New(function ()
		FightDataMgr.instance:afterPlayRoundProto(FightDataModel.instance.cacheRoundProto)
	end))
	slot0:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.AfterPlayClothSkill)
	end))
end

return slot0
