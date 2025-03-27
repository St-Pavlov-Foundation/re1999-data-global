module("modules.logic.fight.entity.comp.FightNameUISeasonGuard", package.seeall)

slot0 = class("FightNameUISeasonGuard", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._parentView = slot1
	slot0._entity = slot0._parentView.entity
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	gohelper.setActive(slot1, true)

	slot0._shieldText = gohelper.findChildText(slot1, "#txt_Shield")
	slot0._aniPlayer = SLFramework.AnimatorPlayer.Get(slot1)
	slot0._ani = gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator))

	slot0:_refreshUI()
	FightController.instance:registerCallback(FightEvent.EntityGuardChange, slot0._onEntityGuardChange, slot0)

	slot0._btnGuardTran = gohelper.findChild(slot1, "btn_guard").transform
	slot0._btnGuard = gohelper.findChildClick(slot0.viewGO, "btn_guard")

	slot0:addClickCb(slot0._btnGuard, slot0._onBtnGuardClick, slot0)
	FightController.instance:registerCallback(FightEvent.StageChanged, slot0._onStageChanged, slot0)
end

function slot0._onBtnGuardClick(slot0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	slot2, slot3 = recthelper.rectToRelativeAnchorPos2(slot0._btnGuardTran.position, ViewMgr.instance:getUILayer(UILayerName.Hud).transform)

	FightController.instance:dispatchEvent(FightEvent.ShowSeasonGuardIntro, slot0._entity.id, slot2, slot3)
end

function slot0._onEntityGuardChange(slot0, slot1, slot2, slot3)
	if slot1 == slot0._entity.id then
		slot0:_refreshUI()

		if slot2 == -1 then
			slot0:_playAni("shake1")
		elseif slot2 < -1 then
			slot0:_playAni("shake2")
		else
			slot0:_refreshAni()
		end
	end
end

function slot0._refreshAni(slot0)
	if not slot0.viewGO then
		return
	end

	if not slot0._entity:getMO() then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	if slot1.guard == 1 then
		if slot0._curAniName == "idle3" then
			slot0:_playAni("idle3_out")
		else
			slot0:_playIdle("idle2")
		end
	elseif slot1.guard > 1 then
		if slot0._curAniName == "idle3" then
			slot0:_playAni("idle3_out")
		else
			slot0:_playIdle("idle")
		end
	elseif slot0._curAniName ~= "idle3" and slot0._curAniName ~= "idle3_in" then
		slot0:_playAni("idle3_in")
	else
		slot0:_playIdle("idle3")
	end
end

function slot0._playIdle(slot0, slot1)
	slot0._curAniName = slot1
	slot0._ani.enabled = true

	slot0._ani:Play(slot1)
end

function slot0._playAni(slot0, slot1)
	slot0._curAniName = slot1

	slot0._aniPlayer:Play(slot1, slot0._refreshAni, slot0)
end

function slot0._refreshUI(slot0)
	slot0._shieldText.text = slot0._entity:getMO().guard
end

function slot0._onStageChanged(slot0)
	slot0:_refreshAni()
end

function slot0.releaseSelf(slot0)
	FightController.instance:unregisterCallback(FightEvent.EntityGuardChange, slot0._onEntityGuardChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.StageChanged, slot0._onStageChanged, slot0)
	slot0:__onDispose()
end

return slot0
