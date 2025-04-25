module("modules.logic.fight.mgr.FightPlayMgr", package.seeall)

slot0 = class("FightPlayMgr", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0:com_registFightEvent(FightEvent.EnterStage, slot0._onEnterStage)
	slot0:com_registFightEvent(FightEvent.ExitStage, slot0._onExitStage)
	slot0:com_registMsg(FightMsgId.PlayDouQuQu, slot0._onPlayDouQuQu)
	slot0:com_registMsg(FightMsgId.GMDouQuQuSkip2IndexRound, slot0._onGMDouQuQuSkip2IndexRound)
end

function slot0.onAwake(slot0)
end

function slot0._onEnterStage(slot0, slot1)
end

function slot0._onExitStage(slot0, slot1)
end

function slot0._onPlayDouQuQu(slot0, slot1)
	slot0.douQuQuPlayMgr = slot0.douQuQuPlayMgr or slot0:newClass(FightDouQuQuPlayMgr)

	slot0.douQuQuPlayMgr:_onPlayDouQuQu(slot1)
end

function slot0._onGMDouQuQuSkip2IndexRound(slot0, slot1, slot2)
	slot0.douQuQuPlayMgr = slot0.douQuQuPlayMgr or slot0:newClass(FightDouQuQuPlayMgr)

	slot0.douQuQuPlayMgr:_onGMDouQuQuSkip2IndexRound(slot1, slot2)
end

function slot0.onDestructor(slot0)
end

return slot0
