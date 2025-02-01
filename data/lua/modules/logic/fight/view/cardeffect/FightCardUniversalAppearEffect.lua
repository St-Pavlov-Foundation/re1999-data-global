module("modules.logic.fight.view.cardeffect.FightCardUniversalAppearEffect", package.seeall)

slot0 = class("FightCardUniversalAppearEffect", BaseWork)
slot1 = "ui/viewres/fight/ui_effect_dna_a.prefab"

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._forAnimGO = gohelper.findChild(slot4.go, "foranim")
	slot0._canvasGroup = gohelper.onceAddComponent(slot0._forAnimGO, typeof(UnityEngine.CanvasGroup))
	slot0._canvasGroup.alpha = 0
	slot0._downEffectLoader = PrefabInstantiate.Create(gohelper.findChild(slot1.handCardItemList[#FightCardModel.instance:getHandCards()].go, "downEffect") or gohelper.create2d(slot4.go, "downEffect"))

	slot0._downEffectLoader:startLoad(uv1, function (slot0)
		uv0._tweenId = ZProj.TweenHelper.DOFadeCanvasGroup(uv0._forAnimGO, 0, 1, uv1)
	end)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 1.2 / FightModel.instance:getUISpeed())
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	slot0._forAnimGO = nil

	if not gohelper.isNil(slot0._canvasGroup) then
		slot0._canvasGroup.alpha = 1
	end

	slot0._canvasGroup = nil

	TaskDispatcher.cancelTask(slot0._delayDone, slot0)

	if slot0._downEffectLoader then
		slot0._downEffectLoader:dispose()
	end

	slot0._downEffectLoader = nil

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	slot0._tweenId = nil
end

return slot0
