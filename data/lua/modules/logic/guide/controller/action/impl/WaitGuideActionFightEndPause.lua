module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEndPause", package.seeall)

slot0 = class("WaitGuideActionFightEndPause", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._needSuccess = slot0.actionParam == "1"

	if slot0.actionParam and string.find(slot0.actionParam, ",") then
		slot2 = string.splitToNumber(slot0.actionParam, ",")
		slot0._needSuccess = slot2[1]
		slot0._episodeId = slot2[2]
	end

	FightController.instance:registerCallback(FightEvent.OnGuideFightEndPause, slot0._onGuideFightEndPause, slot0)
end

function slot0._onGuideFightEndPause(slot0, slot1)
	if slot0._episodeId then
		if slot0._episodeId == FightModel.instance:getFightParam().episodeId then
			if slot0._needSuccess then
				if FightModel.instance:getRecordMO().fightResult == FightEnum.FightResult.Succ then
					slot1.OnGuideFightEndPause = true

					FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, slot0._onGuideFightEndPause, slot0)
					slot0:onDone(true)
				end
			else
				slot1.OnGuideFightEndPause = true

				FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, slot0._onGuideFightEndPause, slot0)
				slot0:onDone(true)
			end
		end
	elseif slot0._needSuccess then
		if slot2.fightResult == FightEnum.FightResult.Succ then
			slot1.OnGuideFightEndPause = true

			FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, slot0._onGuideFightEndPause, slot0)
			slot0:onDone(true)
		end
	else
		slot1.OnGuideFightEndPause = true

		FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, slot0._onGuideFightEndPause, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideFightEndPause, slot0._onGuideFightEndPause, slot0)
end

return slot0
