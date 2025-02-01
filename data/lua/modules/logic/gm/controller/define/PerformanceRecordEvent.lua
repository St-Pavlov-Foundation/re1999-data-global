module("modules.logic.gm.controller.define.PerformanceRecordEvent", package.seeall)

slot1 = 1

function (slot0)
	assert(uv0[slot0] == nil, "[PerformanceRecordEvent] error redefined PerformanceRecordEvent." .. slot0)

	uv0[slot0] = uv1
	uv1 = uv1 + 1
end("onRecordDone")

return _M
