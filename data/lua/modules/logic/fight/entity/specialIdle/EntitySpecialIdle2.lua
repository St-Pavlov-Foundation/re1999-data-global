module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle2", package.seeall)

slot0 = class("EntitySpecialIdle2", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnBeginWave, slot0._onBeginWave, slot0)

	slot0._act_count = 0
	slot0._entity = slot1
end

function slot0._onSkillPlayFinish(slot0, slot1)
	if slot1.id ~= slot0._entity.id then
		return
	end

	if not slot0._last_round_id then
		slot0._last_round_id = FightModel.instance:getCurRoundId()
	end

	if FightModel.instance:getCurRoundId() - slot0._last_round_id > 1 then
		slot0._act_count = 0
	else
		slot0._act_count = slot0._act_count + 1
	end

	slot0._last_round_id = FightModel.instance:getCurRoundId()

	if slot0._act_count >= 3 then
		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, slot1.id)

		slot0._act_count = 0
	end
end

function slot0._onBeginWave(slot0)
	slot0._act_count = 0
end

function slot0.releaseSelf(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, slot0._onBeginWave, slot0)

	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
