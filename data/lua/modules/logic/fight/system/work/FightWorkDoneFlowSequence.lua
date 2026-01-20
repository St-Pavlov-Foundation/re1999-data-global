-- chunkname: @modules/logic/fight/system/work/FightWorkDoneFlowSequence.lua

module("modules.logic.fight.system.work.FightWorkDoneFlowSequence", package.seeall)

local FightWorkDoneFlowSequence = class("FightWorkDoneFlowSequence", FightWorkFlowSequence)

function FightWorkDoneFlowSequence:start(context)
	local logicClass = self.PARENT_ROOT_OBJECT and self.PARENT_ROOT_OBJECT.PARENT_ROOT_OBJECT

	if logicClass and logicClass.cancelFightWorkSafeTimer then
		logicClass:cancelFightWorkSafeTimer()
	end

	return FightWorkDoneFlowSequence.super.start(self, context)
end

return FightWorkDoneFlowSequence
