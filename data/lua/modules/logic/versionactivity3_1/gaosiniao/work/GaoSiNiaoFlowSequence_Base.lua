-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoFlowSequence_Base.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoFlowSequence_Base", package.seeall)

local Base = _G.FlowSequence
local GaoSiNiaoFlowSequence_Base = class("GaoSiNiaoFlowSequence_Base", Base)

function GaoSiNiaoFlowSequence_Base:ctor(...)
	Base.ctor(self, ...)
end

function GaoSiNiaoFlowSequence_Base:onDestroyView()
	self:destroy()
end

function GaoSiNiaoFlowSequence_Base:addWork(work)
	if not work then
		return nil
	end

	Base.addWork(self, work)
	work:setRootInternal(self)

	return work
end

function GaoSiNiaoFlowSequence_Base:insertWork(work)
	if not work then
		return nil
	end

	BaseFlow.addWork(self, work)
	work:setRootInternal(self)
	table.insert(self._workList, self:nextIndex(), work)

	return work
end

function GaoSiNiaoFlowSequence_Base:appendFlow(movableFlow)
	local workList = movableFlow:getWorkList()

	for _, work in ipairs(workList) do
		self:addWork(work)
	end

	movableFlow._workList = {}
	movableFlow._curIndex = 0

	return self
end

function GaoSiNiaoFlowSequence_Base:curWork()
	return self._workList[self._curIndex]
end

function GaoSiNiaoFlowSequence_Base:nextIndex()
	return self._curIndex + 1
end

function GaoSiNiaoFlowSequence_Base:onStart()
	return
end

return GaoSiNiaoFlowSequence_Base
