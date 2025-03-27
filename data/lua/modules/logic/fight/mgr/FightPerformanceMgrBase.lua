module("modules.logic.fight.mgr.FightPerformanceMgrBase", package.seeall)

slot0 = class("FightPerformanceMgrBase", FightBaseClass)

function slot0.onInitialization(slot0)
	slot0:com_registMsg(FightMsgId.AfterInitDataMgrRef, slot0.initDataMgrRef)
	slot0:initDataMgrRef()
end

function slot0.initDataMgrRef(slot0)
end

function slot0.onDestructor(slot0)
end

return slot0
