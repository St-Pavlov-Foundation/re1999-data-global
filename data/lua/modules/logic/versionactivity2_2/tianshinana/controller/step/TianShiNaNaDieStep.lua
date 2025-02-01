module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaDieStep", package.seeall)

slot0 = class("TianShiNaNaDieStep", TianShiNaNaStepBase)

function slot0.onStart(slot0, slot1)
	if not TianShiNaNaModel.instance:getHeroMo() then
		slot0:_delayDone()

		return
	end

	if not TianShiNaNaEntityMgr.instance:getEntity(slot2.co.id) then
		slot0:_delayDone()

		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_death)
	slot3:playCloseAnim()
	UIBlockMgr.instance:startBlock("TianShiNaNaDieStep")
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 1)
end

function slot0._delayDone(slot0)
	ViewMgr.instance:openView(ViewName.TianShiNaNaResultView, {
		isWin = false,
		reason = slot0._data.reason
	})
	slot0:onDone(false)
end

function slot0.clearWork(slot0)
	UIBlockMgr.instance:endBlock("TianShiNaNaDieStep")
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
