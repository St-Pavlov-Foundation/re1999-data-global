module("modules.logic.fight.model.data.FightLocalDataMgr", package.seeall)

local var_0_0 = class("FightLocalDataMgr", FightDataMgr)

var_0_0.isLocalDataMgr = true
var_0_0.instance = var_0_0.New()

var_0_0.instance:initDataMgr()

return var_0_0
