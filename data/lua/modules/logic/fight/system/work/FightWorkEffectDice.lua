module("modules.logic.fight.system.work.FightWorkEffectDice", package.seeall)

slot0 = class("FightWorkEffectDice", FightEffectBase)
slot1 = nil

function slot0.onStart(slot0)
	if uv0 then
		table.insert(uv0, {
			slot0._fightStepMO,
			slot0._actEffectMO
		})
	else
		uv0 = {}

		table.insert(uv0, {
			slot0._fightStepMO,
			slot0._actEffectMO
		})
		TaskDispatcher.runDelay(slot0._delayStart, slot0, 0.01)
	end
end

function slot0._delayStart(slot0)
	FightController.instance:registerCallback(FightEvent.OnDiceEnd, slot0._onDiceEnd, slot0)
	slot0:com_registTimer(slot0._delayDone, 10)

	slot1 = ViewName.FightDiceView

	if Activity104Model.instance:isSeasonEpisodeType(DungeonConfig.instance:getEpisodeCO(FightModel.instance:getFightParam().episodeId) and slot3.type) then
		slot1 = ViewName.FightSeasonDiceView
	end

	ViewMgr.instance:openView(slot1, uv0)

	uv0 = nil
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._onDiceEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnDiceEnd, slot0._onDiceEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delayStart, slot0)
end

return slot0
