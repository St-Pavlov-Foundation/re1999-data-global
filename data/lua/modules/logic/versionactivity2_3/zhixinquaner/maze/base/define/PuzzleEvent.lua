module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.define.PuzzleEvent", package.seeall)

slot1 = 1

function slot2(slot0)
	assert(uv0[slot0] == nil, "[PuzzleEvent] error redefined RougeEvent." .. slot0)

	uv0[slot0] = uv1
	uv1 = uv1 + 1
end

slot2("InitGameDone")
slot2("OnBeginDragPawn")
slot2("OnEndDragPawn")
slot2("SimulatePlane")
slot2("SwitchLineState")
slot2("RecyclePlane")
slot2("OnGameFinished")
slot2("OnStartDialog")
slot2("OnFinishDialog")
slot2("GuideStart")
slot2("OnSimulatePlaneDone")
slot2("OnTriggerEffectDone")
slot2("EnableTriggerEffect")

return _M
