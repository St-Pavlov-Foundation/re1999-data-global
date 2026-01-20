-- chunkname: @modules/logic/rouge2/outside/work/Rouge2_WaitFinishViewDoneWork.lua

module("modules.logic.rouge2.outside.work.Rouge2_WaitFinishViewDoneWork", package.seeall)

local Rouge2_WaitFinishViewDoneWork = class("Rouge2_WaitFinishViewDoneWork", BaseWork)

function Rouge2_WaitFinishViewDoneWork:ctor(rougeFinish, endId)
	self.rougeFinish = rougeFinish
	self.endId = endId
end

function Rouge2_WaitFinishViewDoneWork:onStart()
	local state = self.rougeFinish and Rouge2_OutsideEnum.FinishEnum.Finish or Rouge2_OutsideEnum.FinishEnum.Fail

	Rouge2_OutsideController.instance:openRougeFinishView(state, self.endId)
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.onFinishViewDone, self.onFinishViewDone, self)
end

function Rouge2_WaitFinishViewDoneWork:onFinishViewDone()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.onFinishViewDone, self.onFinishViewDone, self)
	self:onDone(true)
end

function Rouge2_WaitFinishViewDoneWork:clearWork()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_MapEvent.onFinishViewDone, self.onFinishViewDone, self)
end

return Rouge2_WaitFinishViewDoneWork
