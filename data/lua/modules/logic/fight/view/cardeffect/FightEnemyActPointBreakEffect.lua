module("modules.logic.fight.view.cardeffect.FightEnemyActPointBreakEffect", package.seeall)

slot0 = class("FightEnemyActPointBreakEffect", BaseWork)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if not slot1.enemyHasDeadEntity or slot1.enemyBreakActPoint == 0 then
		slot0:onDone(true)

		return
	end

	for slot6 = 1, slot1.enemyNowActPoint + slot1.enemyBreakActPoint do
		gohelper.setActive(gohelper.findChild(slot1.viewGO, string.format("root/enemycards/item%d", slot6)), true)
	end

	for slot6 = slot1.enemyNowActPoint + 1, slot2 do
		if gohelper.findChild(slot1.viewGO, string.format("root/enemycards/item%d/empty", slot6)) and slot7:GetComponent(typeof(UnityEngine.Animation)) then
			slot8:Play()
		end
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.8)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

function slot0._delayDone(slot0)
	slot1 = slot0.context

	for slot6 = 1, slot1.enemyNowActPoint + slot1.enemyBreakActPoint do
		gohelper.setActive(gohelper.findChild(slot1.viewGO, string.format("root/enemycards/item%d", slot6)), slot6 <= slot1.enemyNowActPoint)
	end

	for slot6 = slot1.enemyNowActPoint + 1, slot2 do
		gohelper.setActive(gohelper.findChild(slot1.viewGO, string.format("root/enemycards/item%d/empty/die", slot6)), false)

		if gohelper.findChild(slot1.viewGO, string.format("root/enemycards/item%d/empty", slot6)) then
			if slot8:GetComponent(typeof(UnityEngine.Animation)) then
				slot9:Stop()
			end

			if slot8:GetComponent(gohelper.Type_Image) then
				slot10.color = Color.white
			end
		end
	end

	slot0:onDone(true)
end

return slot0
