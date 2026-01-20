-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUnitShowWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUnitShowWork", package.seeall)

local SurvivalUnitShowWork = class("SurvivalUnitShowWork", SurvivalStepBaseWork)

function SurvivalUnitShowWork:onStart(context)
	local newUnitIds = {}
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	for i, unit in ipairs(self._stepMo.unit) do
		local unitMo = SurvivalUnitMo.New()

		unitMo:init(unit)
		sceneMo:addUnit(unitMo)

		newUnitIds[unitMo.id] = true
	end

	local reason = self._stepMo.paramInt[1] or 0

	if reason == 1002 then
		if type(context.tryTrigger) == "table" then
			for id in pairs(newUnitIds) do
				context.tryTrigger[id] = true
			end
		else
			context.tryTrigger = newUnitIds
		end
	end

	self:onDone(true)
end

function SurvivalUnitShowWork:getRunOrder(params, flow)
	if params.haveHeroMove then
		params.beforeFlow = FlowParallel.New()

		flow:addWork(params.beforeFlow)

		params.moveIdSet = {}
		params.haveHeroMove = false
	end

	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalUnitShowWork
