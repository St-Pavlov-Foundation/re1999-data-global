module("modules.logic.fight.view.cardeffect.FightEnemyPlayCardInEffect", package.seeall)

slot0 = class("FightEnemyPlayCardInEffect", BaseWork)
slot1 = Color.white

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	for slot5 = 1, slot1.enemyNowActPoint do
		gohelper.setActive(gohelper.findChild(slot1.viewGO, string.format("root/enemycards/item%d/op", slot5)), true)

		slot7 = gohelper.findChild(slot1.viewGO, string.format("root/enemycards/item%d/empty", slot5))

		gohelper.setActive(slot7, true)

		gohelper.onceAddComponent(slot7, gohelper.Type_Image).color = uv1
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.34)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

return slot0
