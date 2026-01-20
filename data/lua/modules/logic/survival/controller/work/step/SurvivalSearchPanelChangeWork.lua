-- chunkname: @modules/logic/survival/controller/work/step/SurvivalSearchPanelChangeWork.lua

module("modules.logic.survival.controller.work.step.SurvivalSearchPanelChangeWork", package.seeall)

local SurvivalSearchPanelChangeWork = class("SurvivalSearchPanelChangeWork", SurvivalStepBaseWork)

function SurvivalSearchPanelChangeWork:onStart(context)
	SurvivalMapModel.instance.searchChangeItems = {
		items = self._stepMo.items,
		panelUid = self._stepMo.paramLong[1]
	}

	self:onDone(true)
end

return SurvivalSearchPanelChangeWork
