module("modules.logic.fight.system.work.FightWorkAct174MonsterAiCard", package.seeall)

slot0 = class("FightWorkAct174MonsterAiCard", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendMsg(FightMsgId.Act174MonsterAiCard)
	slot0:onDone(true)
end

function slot0._onPlayCardOver(slot0)
end

return slot0
