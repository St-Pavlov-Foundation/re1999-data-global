-- chunkname: @modules/logic/fight/mgr/FightCheckCrashMgr.lua

module("modules.logic.fight.mgr.FightCheckCrashMgr", package.seeall)

local FightCheckCrashMgr = class("FightCheckCrashMgr", FightBaseClass)

function FightCheckCrashMgr:onConstructor()
	self:com_registFightEvent(FightEvent.OnRoundSequenceStart, self._onRoundSequenceStart)
	self:com_registFightEvent(FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish)
	self:com_registFightEvent(FightEvent.OnRestartStageBefore, self._onRestartStageBefore)
	self:com_registFightEvent(FightEvent.FightDialogEnd, self._onFightDialogEnd)
	self:com_registFightEvent(FightEvent.StartFightEnd, self.onStartFightEnd)
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView)
end

function FightCheckCrashMgr:_onFightDialogEnd()
	self:clearTab()
end

function FightCheckCrashMgr:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		self:clearTab()
	end
end

function FightCheckCrashMgr:checkFunc()
	if FightViewDialog.playingDialog then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.StoryView) then
		return
	end

	local same = true

	self.hpDic = self.hpDic or {}
	self.exPointDic = self.exPointDic or {}
	self.buffCount = self.buffCount or {}

	local entityDataDic = FightDataHelper.entityMgr.entityDataDic

	for entityId, entityData in pairs(entityDataDic) do
		local curHp = entityData.currentHp

		if self.hpDic[entityId] ~= curHp then
			same = false
			self.hpDic[entityId] = curHp
		end

		local curExpoint = entityData:getExPoint()

		if self.exPointDic[entityId] ~= curExpoint then
			same = false
			self.exPointDic[entityId] = curExpoint
		end

		local buffList = entityData:getBuffList()
		local curBuffCount = buffList and #buffList or 0

		if self.buffCount[entityId] ~= curBuffCount then
			same = false
			self.buffCount[entityId] = curBuffCount
		end
	end

	if same then
		logError("场上角色数据一分钟没有变化了,可能卡住了")
		FightMsgMgr.sendMsg(FightMsgId.MaybeCrashed)
		self:releaseTimer()
	end
end

function FightCheckCrashMgr:_onRoundSequenceStart()
	self:com_registSingleRepeatTimer(self.checkFunc, 60, -1)
end

function FightCheckCrashMgr:_onRoundSequenceFinish()
	self:com_releaseSingleTimer(self.checkFunc)
end

function FightCheckCrashMgr:_onRestartStageBefore()
	self:com_releaseSingleTimer(self.checkFunc)
end

function FightCheckCrashMgr:releaseTimer()
	self:com_releaseSingleTimer(self.checkFunc)
	self:clearTab()
end

function FightCheckCrashMgr:onStartFightEnd()
	self:releaseTimer()
end

function FightCheckCrashMgr:clearTab()
	self.hpDic = nil
	self.exPointDic = nil
	self.buffCount = nil
end

function FightCheckCrashMgr:onDestructor()
	return
end

return FightCheckCrashMgr
