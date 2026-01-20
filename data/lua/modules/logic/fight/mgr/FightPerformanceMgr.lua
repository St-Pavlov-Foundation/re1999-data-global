-- chunkname: @modules/logic/fight/mgr/FightPerformanceMgr.lua

module("modules.logic.fight.mgr.FightPerformanceMgr", package.seeall)

local FightPerformanceMgr = class("FightPerformanceMgr", FightBaseClass)

function FightPerformanceMgr:onConstructor()
	self.gamePlayMgr = {}
	self.userDataMgrList = {}

	self:com_registMsg(FightMsgId.RestartGame, self._onRestartGame)
end

function FightPerformanceMgr:onLogicEnter()
	self:registFightMgr()
	self:registGamePlayMgr()
end

function FightPerformanceMgr:registFightMgr()
	return
end

function FightPerformanceMgr:registGamePlayMgr()
	self.asfdMgr = self:registerUserDataClass(FightASFDMgr)
end

function FightPerformanceMgr:registGamePlayClass(class)
	local mgr = self:newClass(class)

	table.insert(self.gamePlayMgr, mgr)

	return mgr
end

function FightPerformanceMgr:registerUserDataClass(class)
	local mgr = class.New()

	mgr:init()
	table.insert(self.userDataMgrList, mgr)

	return mgr
end

function FightPerformanceMgr:_onRestartGame()
	for i = #self.gamePlayMgr, 1, -1 do
		self.gamePlayMgr[i]:disposeSelf()
	end

	tabletool.clear(self.gamePlayMgr)
	self:clearUserDataMgr()
	self:registGamePlayMgr()
end

function FightPerformanceMgr:clearUserDataMgr()
	for i = #self.userDataMgrList, 1, -1 do
		self.userDataMgrList[i]:dispose()
	end

	tabletool.clear(self.userDataMgrList)

	self.asfdMgr = nil
end

function FightPerformanceMgr:getASFDMgr()
	return self.asfdMgr
end

function FightPerformanceMgr:onDestructor()
	self:clearUserDataMgr()
end

return FightPerformanceMgr
