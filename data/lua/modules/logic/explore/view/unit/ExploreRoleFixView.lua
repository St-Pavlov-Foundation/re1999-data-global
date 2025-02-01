module("modules.logic.explore.view.unit.ExploreRoleFixView", package.seeall)

slot0 = class("ExploreRoleFixView", ExploreUnitBaseView)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1, "ui/viewres/explore/exploreinteractiveitem.prefab")
end

function slot0.onInit(slot0)
	slot0._goslider = gohelper.findChildImage(slot0.viewGO, "#image_progress")
	slot0._nowValue = 0

	TaskDispatcher.runRepeat(slot0._everyFrame, slot0, 0)
end

function slot0.setFixUnit(slot0, slot1)
	slot0._fixUnit = slot1
end

function slot0._everyFrame(slot0)
	slot0._nowValue = slot0._nowValue + UnityEngine.Time.deltaTime
	slot1 = slot0._nowValue / (ExploreAnimEnum.RoleAnimLen[ExploreAnimEnum.RoleAnimStatus.Fix] or 1)
	slot0._goslider.fillAmount = slot1

	if slot1 > 1 then
		if slot0._fixUnit then
			slot2, slot3, slot4, slot5 = ExploreConfig.instance:getUnitEffectConfig(slot0._fixUnit:getResPath(), "fix_finish")

			ExploreHelper.triggerAudio(slot4, slot5, slot0._fixUnit.go)
		end

		slot0.unit.uiComp:removeUI(uv0)
	end
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._everyFrame, slot0)

	slot0._goslider = nil
	slot0._fixUnit = nil
end

return slot0
