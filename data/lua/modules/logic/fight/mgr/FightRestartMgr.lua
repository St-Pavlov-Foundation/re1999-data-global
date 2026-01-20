-- chunkname: @modules/logic/fight/mgr/FightRestartMgr.lua

module("modules.logic.fight.mgr.FightRestartMgr", package.seeall)

local FightRestartMgr = class("FightRestartMgr", FightBaseClass)

function FightRestartMgr:onConstructor()
	return
end

function FightRestartMgr:restart()
	FightSystem.instance.restarting = true

	local flow = self:com_registFlowSequence()

	flow:registWork(FightRestartSequence)
	flow:registFinishCallback(self.onRestartFinish)
	flow:start()
end

function FightRestartMgr:onRestartFinish()
	FightSystem.instance.restarting = false
end

function FightRestartMgr:cancelRestart()
	FightSystem.instance.restarting = false
end

function FightRestartMgr:restartFightFail()
	ToastController.instance:showToast(-80)
	self:cancelRestart()
	FightController.instance:exitFightScene()
end

function FightRestartMgr:directStartNewFight()
	local work = self:com_registWork(FightWorkDirectStartNewFightAfterEndFight)

	work:start()
end

function FightRestartMgr:fastRestart()
	FightSystem.instance.restarting = true

	local flow = self:com_registFlowSequence()

	flow:registWork(FightFastRestartSequence)
	flow:registFinishCallback(self.onRestartFinish)
	flow:start()
end

function FightRestartMgr:onDestructor()
	FightSystem.instance.restarting = false
end

return FightRestartMgr
