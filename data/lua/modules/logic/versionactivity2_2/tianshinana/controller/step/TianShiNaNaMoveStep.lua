module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaMoveStep", package.seeall)

slot0 = class("TianShiNaNaMoveStep", TianShiNaNaStepBase)

function slot0.onStart(slot0)
	if not TianShiNaNaEntityMgr.instance:getEntity(slot0._data.id) then
		logError("步骤Move 找不到元件ID" .. slot0._data.id)
		slot0:onDone(true)

		return
	end

	slot0._isPlayer = TianShiNaNaModel.instance:getHeroMo().co.id == slot0._data.id

	if slot0._isPlayer then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_foot)
	end

	slot1:moveTo(slot0._data.x, slot0._data.y, slot0._data.direction, slot0._onMoveEnd, slot0)
end

function slot0._onMoveEnd(slot0)
	if slot0._isPlayer then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.stop_ui_youyu_foot)
		TianShiNaNaEffectPool.instance:getFromPool(slot0._data.x, slot0._data.y, 1, 0, 0.4)
	end

	slot0:onDone(true)
end

return slot0
