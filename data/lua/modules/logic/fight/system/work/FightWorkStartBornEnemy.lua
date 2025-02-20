module("modules.logic.fight.system.work.FightWorkStartBornEnemy", package.seeall)

slot0 = class("FightWorkStartBornEnemy", BaseWork)
slot1 = 10

function slot0.onStart(slot0)
	if FightWorkAppearTimeline.hasAppearTimeline() then
		slot0:onDone(true)

		return
	end

	slot0._flowParallel = FlowParallel.New()

	for slot5, slot6 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)) do
		if not slot0.context.oldEntityIdDict or not slot0.context.oldEntityIdDict[slot6.id] then
			slot7 = true

			if FightMsgMgr.sendMsg(FightMsgId.IsEvolutionSkin, slot6:getMO().skin) then
				slot7 = false
			end

			if slot7 then
				slot0._flowParallel:addWork(FightWorkStartBornNormal.New(slot6, false))
			else
				FightController.instance:dispatchEvent(FightEvent.OnStartFightPlayBornNormal, slot6.id)
			end
		end
	end

	TaskDispatcher.runDelay(slot0._onBornTimeout, slot0, uv0)
	slot0._flowParallel:registerDoneListener(slot0._onEnemyBornDone, slot0)
	slot0._flowParallel:start()
end

function slot0._onEnemyBornDone(slot0)
	slot0._flowParallel:unregisterDoneListener(slot0._onEnemyBornDone, slot0)
	slot0:onDone(true)
end

function slot0._onBornTimeout(slot0)
	logError("播放出生效果时间超过" .. uv0 .. "秒")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._flowParallel then
		slot0._flowParallel:stop()
		slot0._flowParallel:unregisterDoneListener(slot0._onEnemyBornDone, slot0)
	end

	TaskDispatcher.cancelTask(slot0._onBornTimeout, slot0)
end

return slot0
