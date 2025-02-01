module("modules.logic.fight.system.work.FightWorkChangeWaveView", package.seeall)

slot0 = class("FightWorkChangeWaveView", BaseWork)

function slot0.onStart(slot0)
	if FightReplayModel.instance:isReplay() then
		slot0:onDone(true)
	else
		if FightModel.instance:getFightParam() then
			slot2 = false

			if slot1.episodeId == 1310102 or slot3 == 1310111 then
				slot2 = true
			end

			if slot1.battleId == 9130101 or slot4 == 9130107 then
				slot2 = true
			end

			if slot2 then
				ViewMgr.instance:openView(ViewName.FightWaveChangeView)
				TaskDispatcher.runDelay(slot0._done, slot0, 1)

				return
			end
		end

		slot0:onDone(true)
	end
end

function slot0._done(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	ViewMgr.instance:closeView(ViewName.FightWaveChangeView)
	TaskDispatcher.cancelTask(slot0._done, slot0)
end

return slot0
