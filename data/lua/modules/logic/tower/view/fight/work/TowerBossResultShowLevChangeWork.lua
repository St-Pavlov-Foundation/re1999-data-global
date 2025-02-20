module("modules.logic.tower.view.fight.work.TowerBossResultShowLevChangeWork", package.seeall)

slot0 = class("TowerBossResultShowLevChangeWork", BaseWork)
slot1 = 2

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.goBossLevChange = slot1
	slot0.goBoss = slot2
	slot0.isBossLevChange = slot3
end

function slot0.onStart(slot0)
	gohelper.setActive(slot0.goBossLevChange, true)
	gohelper.setActive(slot0.goBoss, true)

	if not slot0.isBossLevChange then
		slot0:onDone(true)
	else
		TaskDispatcher.runDelay(slot0._triggerAudio, slot0, 0.8)
	end

	TaskDispatcher.runDelay(slot0._delayFinish, slot0, uv0)
end

function slot0._triggerAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_level_up)
end

function slot0._delayFinish(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	gohelper.setActive(slot0.goBossLevChange, false)
	TaskDispatcher.cancelTask(slot0._delayFinish, slot0)
	TaskDispatcher.cancelTask(slot0._triggerAudio, slot0)
end

return slot0
