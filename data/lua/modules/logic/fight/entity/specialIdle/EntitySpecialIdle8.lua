module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle8", package.seeall)

slot0 = class("EntitySpecialIdle8", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnMySideRoundEnd, slot0._onMySideRoundEnd, slot0)

	slot0._act_round = 0
	slot0._round = 0
	slot0._entity = slot1
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot1.id ~= slot0._entity.id then
		return
	end

	slot0._act_round = FightModel.instance:getCurRoundId()
end

function slot0._onMySideRoundEnd(slot0)
	slot0._round = FightModel.instance:getCurRoundId()

	if slot0._round - slot0._act_round > 1 then
		slot0._act_round = slot0._round

		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, slot0._entity.id)
	end
end

function slot0.releaseSelf(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnMySideRoundEnd, slot0._onMySideRoundEnd, slot0)

	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
