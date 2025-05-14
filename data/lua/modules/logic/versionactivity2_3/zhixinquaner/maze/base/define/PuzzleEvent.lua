module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.define.PuzzleEvent", package.seeall)

local var_0_0 = _M
local var_0_1 = 1

local function var_0_2(arg_1_0)
	assert(var_0_0[arg_1_0] == nil, "[PuzzleEvent] error redefined RougeEvent." .. arg_1_0)

	var_0_0[arg_1_0] = var_0_1
	var_0_1 = var_0_1 + 1
end

var_0_2("InitGameDone")
var_0_2("OnBeginDragPawn")
var_0_2("OnEndDragPawn")
var_0_2("SimulatePlane")
var_0_2("SwitchLineState")
var_0_2("RecyclePlane")
var_0_2("OnGameFinished")
var_0_2("OnStartDialog")
var_0_2("OnFinishDialog")
var_0_2("GuideStart")
var_0_2("OnSimulatePlaneDone")
var_0_2("OnTriggerEffectDone")
var_0_2("EnableTriggerEffect")

return var_0_0
