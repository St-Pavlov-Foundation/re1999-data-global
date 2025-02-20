module("modules.logic.fight.mgr.FightOperateMgr", package.seeall)

slot0 = class("FightOperateMgr", FightBaseClass)

function slot0.onInitialization(slot0)
	slot0:com_registFightEvent(FightEvent.EnterStage, slot0._onEnterStage)
	slot0:com_registFightEvent(FightEvent.ExitStage, slot0._onExitStage)
end

function slot0.onAwake(slot0)
end

function slot0._onEnterStage(slot0, slot1)
end

function slot0._onExitStage(slot0, slot1)
end

function slot0.onDestructor(slot0)
end

function slot0.onDestructorFinish(slot0)
end

return slot0
