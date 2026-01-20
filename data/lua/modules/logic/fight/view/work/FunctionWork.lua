-- chunkname: @modules/logic/fight/view/work/FunctionWork.lua

module("modules.logic.fight.view.work.FunctionWork", package.seeall)

local FunctionWork = class("FunctionWork", BaseWork)

function FunctionWork:ctor(func, target, param)
	self:setParam(func, target, param)
end

function FunctionWork:setParam(func, target, param)
	self._func = func
	self._target = target
	self._param = param
end

function FunctionWork:onStart()
	self._func(self._target, self._param)
	self:onDone(true)
end

return FunctionWork
