module("modules.logic.fight.model.data.FightLocalDataMgr", package.seeall)

slot0 = class("FightLocalDataMgr", FightDataMgr)
slot0.instance = slot0.New()

slot0.instance:initDataMgr()

return slot0
