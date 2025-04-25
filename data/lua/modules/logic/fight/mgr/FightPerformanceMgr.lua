module("modules.logic.fight.mgr.FightPerformanceMgr", package.seeall)

slot0 = class("FightPerformanceMgr", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0.gamePlayMgr = {}
	slot0.userDataMgrList = {}

	slot0:com_registMsg(FightMsgId.RestartGame, slot0._onRestartGame)
end

function slot0.onAwake(slot0)
	slot0:registFightMgr()
	slot0:registGamePlayMgr()
end

function slot0.registFightMgr(slot0)
end

function slot0.registGamePlayMgr(slot0)
	slot0:registGamePlayClass(FightOperationMgr)
	slot0:registGamePlayClass(FightEntityEvolutionMgr)
	slot0:registGamePlayClass(FightBuffTypeId2EffectMgr)
	slot0:registGamePlayClass(FightEntrustedWorkMgr)
	slot0:registGamePlayClass(FightPlayMgr)

	slot0.asfdMgr = slot0:registerUserDataClass(FightASFDMgr)
end

function slot0.registGamePlayClass(slot0, slot1)
	slot2 = slot0:newClass(slot1)

	table.insert(slot0.gamePlayMgr, slot2)

	return slot2
end

function slot0.registerUserDataClass(slot0, slot1)
	slot2 = slot1.New()

	slot2:init()
	table.insert(slot0.userDataMgrList, slot2)

	return slot2
end

function slot0._onRestartGame(slot0)
	for slot4 = #slot0.gamePlayMgr, 1, -1 do
		slot0.gamePlayMgr[slot4]:disposeSelf()
	end

	tabletool.clear(slot0.gamePlayMgr)
	slot0:clearUserDataMgr()
	slot0:registGamePlayMgr()
end

function slot0.clearUserDataMgr(slot0)
	for slot4 = #slot0.userDataMgrList, 1, -1 do
		slot0.userDataMgrList[slot4]:dispose()
	end

	tabletool.clear(slot0.userDataMgrList)

	slot0.asfdMgr = nil
end

function slot0.getASFDMgr(slot0)
	return slot0.asfdMgr
end

function slot0.onDestructor(slot0)
	slot0:clearUserDataMgr()
end

return slot0
