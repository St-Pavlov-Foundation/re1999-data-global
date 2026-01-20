-- chunkname: @modules/logic/survival/controller/work/step/SurvivalStepBaseWork.lua

module("modules.logic.survival.controller.work.step.SurvivalStepBaseWork", package.seeall)

local SurvivalStepBaseWork = class("SurvivalStepBaseWork", BaseWork)

function SurvivalStepBaseWork:ctor(stepMo)
	self._stepMo = stepMo
end

function SurvivalStepBaseWork:onStart(context)
	self:onDone(true)
end

function SurvivalStepBaseWork:getRunOrder(params, flow, index, allStep)
	return SurvivalEnum.StepRunOrder.After
end

return SurvivalStepBaseWork
