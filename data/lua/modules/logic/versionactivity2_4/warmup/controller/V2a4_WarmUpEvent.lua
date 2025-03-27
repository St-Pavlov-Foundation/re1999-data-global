module("modules.logic.versionactivity2_4.warmup.controller.V2a4_WarmUpEvent", package.seeall)

slot1 = 1

function slot2(slot0)
	assert(uv0[slot0] == nil, "[V2a4_WarmUpEvent] error redefined V2a4_WarmUpEvent." .. slot0)

	uv0[slot0] = uv1
	uv1 = uv1 + 1
end

slot2("onWaveStart")
slot2("onRoundStart")
slot2("onMoveStep")
slot2("onFlush")
slot2("onWaveEnd")

return _M
