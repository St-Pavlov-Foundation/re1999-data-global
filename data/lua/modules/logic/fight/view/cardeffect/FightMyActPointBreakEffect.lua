module("modules.logic.fight.view.cardeffect.FightMyActPointBreakEffect", package.seeall)

slot0 = class("FightMyActPointBreakEffect", BaseWork)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if not slot1.myHasDeadEntity or slot1.myBreakActPoint == 0 then
		slot0:onDone(true)

		return
	end

	for slot6 = 1, slot1.myNowActPoint + slot1.myBreakActPoint do
		if gohelper.findChild(slot1.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. slot6) then
			slot8, slot9 = FightViewPlayCard.calcCardPosX(slot6, slot2)

			recthelper.setAnchor(slot7.transform, slot8, slot9)
		end
	end

	for slot6 = slot1.myNowActPoint + 1, slot2 do
		if gohelper.findChild(slot1.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. slot6) then
			gohelper.setActive(slot7, true)
			gohelper.setActive(gohelper.findChild(slot7, "imgEmpty"), false)
			gohelper.setActive(gohelper.findChild(slot7, "imgMove"), false)
			gohelper.setActive(gohelper.findChild(slot7, "conversion"), false)
			gohelper.setActive(gohelper.findChild(slot7, "die"), true)
			gohelper.onceAddComponent(slot7, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())

			if slot7:GetComponent(typeof(UnityEngine.Animation)) then
				slot9:Play()
			end
		end
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.8 / FightModel.instance:getUISpeed())
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

function slot0._delayDone(slot0)
	for slot4 = slot0.context.myNowActPoint + 1, slot0.context.myNowActPoint + slot0.context.myBreakActPoint do
		if gohelper.findChild(slot0.context.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. slot4) then
			gohelper.setActive(gohelper.findChild(slot5, "die"), false)

			if slot5:GetComponent(typeof(UnityEngine.Animation)) then
				slot6:Stop()
			end

			gohelper.setActive(slot5, false)
		end
	end

	for slot5 = 1, slot0.context.myNowActPoint do
		if gohelper.findChild(slot0.context.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. slot5) then
			slot7, slot8 = FightViewPlayCard.calcCardPosX(slot5, slot1)

			recthelper.setAnchor(slot6.transform, slot7, slot8)
		end
	end

	slot0:onDone(true)
end

return slot0
