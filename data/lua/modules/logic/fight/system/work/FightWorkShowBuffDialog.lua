module("modules.logic.fight.system.work.FightWorkShowBuffDialog", package.seeall)

slot0 = class("FightWorkShowBuffDialog", BaseWork)
slot0.needStopWork = nil
slot0.addBuffRoundId = nil
slot0.delBuffRoundId = nil

function slot0.onStart(slot0)
	if FightModel.instance:getCurRoundId() == 1 then
		uv0.addBuffRoundId = nil
		uv0.delBuffRoundId = nil
	end

	uv0.needStopWork = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.BuffRoundBefore)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.BuffRoundAfter)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.RoundEndAndCheckBuff)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.checkHaveMagicCircle)

	if uv0.needStopWork then
		slot0._flow = FlowSequence.New()

		slot0._flow:addWork(FunctionWork.New(slot0._detectPlayTimeline, slot0))
		slot0._flow:addWork(FightWorkWaitDialog.New())
		slot0._flow:registerDoneListener(slot0._onFightDialogEnd, slot0)
		slot0._flow:start()
	else
		slot0:onDone(true)
	end
end

slot1 = {
	[13304021.0] = "630404_innate1",
	[13304022.0] = "630404_innate1",
	[13304020.0] = "630404_innate1",
	[13304024.0] = "630404_innate1",
	[13304011.0] = "630404_innate1",
	[13304019.0] = "630404_innate1",
	[13304013.0] = "630404_innate1",
	[13304023.0] = "630404_innate1",
	[13304012.0] = "630404_innate1",
	[13304025.0] = "630404_innate1",
	[13304026.0] = "630404_innate1",
	[13304027.0] = "630404_innate1",
	[13304010.0] = "630404_innate1"
}

function slot0._detectPlayTimeline(slot0)
	if uv0.needStopWork and uv1[slot1.id] and FightHelper.getEntity("-1") and slot3.skill then
		slot3.skill:playTimeline(uv1[uv0.needStopWork.id], {
			actId = 0,
			stepUid = 0,
			actEffectMOs = {
				{
					targetId = slot2
				}
			},
			actEffect = {},
			fromId = slot2,
			toId = slot2,
			actType = FightEnum.ActType.SKILL
		})
	end
end

function slot0._onFightDialogEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onFightDialogEnd, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end
end

return slot0
