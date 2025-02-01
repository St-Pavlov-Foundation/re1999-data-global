module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaPlayEffectWork", package.seeall)

slot0 = class("TianShiNaNaPlayEffectWork", BaseWork)

function slot0.setWalkPath(slot0, slot1)
	slot0._playerWalkPaths = slot1
end

function slot0.onStart(slot0, slot1)
	if #slot0._playerWalkPaths == 0 then
		slot0:onDone(true)
	else
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_paving_succeed)

		for slot6 = 1, slot2 do
			slot7 = slot0._playerWalkPaths[slot6]

			TianShiNaNaEffectPool.instance:getFromPool(slot7.x, slot7.y, 2, (slot6 - 1) * 0.1, 0.1)
		end

		TaskDispatcher.runDelay(slot0._delayDone, slot0, slot2 * 0.1)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
