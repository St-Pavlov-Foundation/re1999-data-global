module("modules.logic.scene.fight.comp.FightSceneLowPhoneMemoryComp", package.seeall)

slot0 = class("FightSceneLowPhoneMemoryComp", BaseSceneComp)

function slot0.onScenePrepared(slot0, slot1, slot2)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundEnd, slot0)
end

function slot0._onRoundEnd(slot0)
	logNormal("clear no use effect")
	FightHelper.clearNoUseEffect()
end

function slot0.onSceneClose(slot0, slot1, slot2)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundEnd, slot0)
end

return slot0
