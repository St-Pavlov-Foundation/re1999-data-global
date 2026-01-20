-- chunkname: @modules/logic/fight/system/work/FightWorkDoneFlowParallel.lua

module("modules.logic.fight.system.work.FightWorkDoneFlowParallel", package.seeall)

local FightWorkDoneFlowParallel = class("FightWorkDoneFlowParallel", FightWorkFlowParallel)

function FightWorkDoneFlowParallel:start(context)
	local logicClass = self.PARENT_ROOT_OBJECT and self.PARENT_ROOT_OBJECT.PARENT_ROOT_OBJECT

	if logicClass and logicClass.cancelFightWorkSafeTimer then
		logicClass:cancelFightWorkSafeTimer()
	end

	return FightWorkDoneFlowParallel.super.start(self, context)
end

return FightWorkDoneFlowParallel
