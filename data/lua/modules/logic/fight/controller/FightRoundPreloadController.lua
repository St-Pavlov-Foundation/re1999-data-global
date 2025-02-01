module("modules.logic.fight.controller.FightRoundPreloadController", package.seeall)

slot0 = class("FightRoundPreloadController", BaseController)

function slot0.onInit(slot0)
	slot0._roundPreloadSequence = FlowSequence.New()

	slot0._roundPreloadSequence:addWork(FightRoundPreloadTimelineWork.New())
	slot0._roundPreloadSequence:addWork(FightPreloadTimelineRefWork.New())
	slot0._roundPreloadSequence:addWork(FightRoundPreloadEffectWork.New())

	slot0._monsterPreloadSequence = FlowSequence.New()

	slot0._monsterPreloadSequence:addWork(FightRoundPreloadMonsterWork.New())

	slot0._context = {
		callback = slot0._onPreloadOneFinish,
		callbackObj = slot0
	}
end

function slot0.addConstEvents(slot0)
	FightController.instance:registerCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

function slot0.reInit(slot0)
	slot0:dispose()
end

function slot0._onStageChange(slot0, slot1)
	if slot1 == FightEnum.Stage.Card or slot1 == FightEnum.Stage.AutoCard then
		slot0:preload()
	elseif slot1 == FightEnum.Stage.Play then
		if slot0._monsterPreloadSequence and slot0._monsterPreloadSequence.status == WorkStatus.Running then
			slot0._monsterPreloadSequence:stop()
		end

		slot0._monsterPreloadSequence:start(slot0._context)
	end
end

function slot0.preload(slot0)
	slot0._assetItemDict = slot0._assetItemDict or slot0:getUserDataTb_()

	if slot0._roundPreloadSequence and slot0._roundPreloadSequence.status == WorkStatus.Running then
		slot0._roundPreloadSequence:stop()
	end

	slot0._roundPreloadSequence:registerDoneListener(slot0._onPreloadDone, slot0)
	slot0._roundPreloadSequence:start(slot0._context)
end

function slot0.dispose(slot0)
	slot0._battleId = nil

	slot0._roundPreloadSequence:stop()
	slot0._monsterPreloadSequence:stop()

	if slot0._assetItemDict then
		for slot4, slot5 in pairs(slot0._assetItemDict) do
			slot5:Release()

			slot0._assetItemDict[slot4] = nil
		end

		slot0._assetItemDict = nil
	end

	slot0._context.timelineDict = nil
	slot0._context.timelineUrlDict = nil
	slot0._context.timelineSkinDict = nil

	slot0._roundPreloadSequence:unregisterDoneListener(slot0._onPreloadDone, slot0)
	slot0:__onDispose()
end

function slot0._onPreloadDone(slot0)
end

function slot0._onPreloadOneFinish(slot0, slot1)
	if not slot0._assetItemDict[slot1.ResPath] then
		slot0._assetItemDict[slot2] = slot1

		slot1:Retain()
	end
end

slot0.instance = slot0.New()

return slot0
