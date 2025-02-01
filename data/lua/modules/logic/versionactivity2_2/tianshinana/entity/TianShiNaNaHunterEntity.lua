module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaHunterEntity", package.seeall)

slot0 = class("TianShiNaNaHunterEntity", TianShiNaNaUnitEntityBase)

function slot0.updateMo(slot0, slot1)
	slot0._range = string.splitToNumber(slot1.co.specialData, "#") and slot2[1] or 0

	uv0.super.updateMo(slot0, slot1)
end

function slot0.onResLoaded(slot0)
	slot1 = gohelper.findChild(slot0._resGo, "vx_warn")

	gohelper.setActive(slot1, true)

	if slot1 then
		slot0._rootAnim = slot1:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0:checkActive()
end

function slot0.addEventListeners(slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.CubePointUpdate, slot0.checkActive, slot0)
end

function slot0.removeEventListeners(slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.CubePointUpdate, slot0.checkActive, slot0)
end

function slot0.willActive(slot0)
	for slot4, slot5 in pairs(TianShiNaNaModel.instance.curPointList) do
		if TianShiNaNaHelper.getMinDis(slot5.x, slot5.y, slot0._unitMo.x, slot0._unitMo.y) <= slot0._range then
			return true
		end
	end

	return false
end

function slot0.checkActive(slot0)
	if not slot0._rootAnim then
		return
	end

	if (slot0._unitMo.isActive or slot0:willActive()) == slot0._isActive then
		return
	end

	slot0._isActive = slot1

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_warn)
		slot0._rootAnim:Play("warn_red", 0, 0)
	else
		slot0._rootAnim:Play("warn_open", 0, 0)
	end
end

return slot0
