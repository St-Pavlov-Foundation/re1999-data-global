-- chunkname: @modules/logic/rouge2/map/rpcwork/Rouge2_WaitSendRpcSuccWork.lua

module("modules.logic.rouge2.map.rpcwork.Rouge2_WaitSendRpcSuccWork", package.seeall)

local Rouge2_WaitSendRpcSuccWork = class("Rouge2_WaitSendRpcSuccWork", BaseWork)

function Rouge2_WaitSendRpcSuccWork:ctor(rpcFunc, rpcInstance, param)
	self._rpcFunc = rpcFunc
	self._rpcInstance = rpcInstance
	self._param = param
end

function Rouge2_WaitSendRpcSuccWork:onStart()
	if not self._rpcInstance or not self._rpcFunc then
		self:onDone(true)

		return
	end

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._sendMsg, self))
	self._flow:start()
end

function Rouge2_WaitSendRpcSuccWork:_sendMsg()
	self._rpcFunc(self._rpcInstance, self._param, self._onSendRpcDoneCb, self)
end

function Rouge2_WaitSendRpcSuccWork:_onSendRpcDoneCb()
	self:onDone(true)
end

function Rouge2_WaitSendRpcSuccWork:clearWork()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

return Rouge2_WaitSendRpcSuccWork
