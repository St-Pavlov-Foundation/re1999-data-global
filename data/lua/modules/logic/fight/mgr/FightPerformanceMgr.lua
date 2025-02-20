module("modules.logic.fight.mgr.FightPerformanceMgr", package.seeall)

slot0 = class("FightPerformanceMgr", FightBaseClass)

function slot0.onInitialization(slot0)
	slot0.gamePlayMgr = {}

	slot0:com_registMsg(FightMsgId.RestartGame, slot0._onRestartGame)
end

function slot0.onAwake(slot0)
	slot0:registFightMgr()
	slot0:registGamePlayMgr()
end

function slot0.registFightMgr(slot0)
end

function slot0.registGamePlayMgr(slot0)
	slot0:registGamePlayClass(FightOperateMgr)
	slot0:registGamePlayClass(FightEntityEvolutionMgr)
	slot0:registGamePlayClass(FightPlayMgr)
end

function slot0.registGamePlayClass(slot0, slot1)
	slot2 = slot0:registClass(slot1)

	table.insert(slot0.gamePlayMgr, slot2)

	return slot2
end

function slot0._onRestartGame(slot0)
	for slot4 = #slot0.gamePlayMgr, 1, -1 do
		slot0.gamePlayMgr[slot4]:disposeSelf()
	end

	tabletool.clear(slot0.gamePlayMgr)
	slot0:registGamePlayMgr()
end

function slot0.onDestructor(slot0)
end

function slot0.onDestructorFinish(slot0)
end

return slot0
