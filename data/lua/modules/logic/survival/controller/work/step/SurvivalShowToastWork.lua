-- chunkname: @modules/logic/survival/controller/work/step/SurvivalShowToastWork.lua

module("modules.logic.survival.controller.work.step.SurvivalShowToastWork", package.seeall)

local SurvivalShowToastWork = class("SurvivalShowToastWork", SurvivalStepBaseWork)

function SurvivalShowToastWork:onStart(context)
	local toastId = self._stepMo.paramInt[1] or 0

	ToastController.instance:showToast(toastId)
	self:onDone(true)
end

function SurvivalShowToastWork:getRunOrder(params, flow, index, allStep)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalShowToastWork
