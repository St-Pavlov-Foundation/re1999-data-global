-- chunkname: @modules/logic/survival/controller/work/step/SurvivalCircleShrinkFinishWork.lua

module("modules.logic.survival.controller.work.step.SurvivalCircleShrinkFinishWork", package.seeall)

local SurvivalCircleShrinkFinishWork = class("SurvivalCircleShrinkFinishWork", SurvivalStepBaseWork)

function SurvivalCircleShrinkFinishWork:onStart(context)
	local round = self._stepMo.paramInt[1] or 0
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	for i, v in ipairs(sceneMo.safeZone) do
		if v.round == round then
			table.remove(sceneMo.safeZone, i)

			break
		end
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShrinkInfoUpdate)
	self:onDone(true)
end

function SurvivalCircleShrinkFinishWork:getRunOrder(params, flow)
	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalCircleShrinkFinishWork
