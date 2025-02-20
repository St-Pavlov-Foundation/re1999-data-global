module("modules.logic.act189.rpc.Activity189Event", package.seeall)

slot1 = 1

function slot2(slot0)
	assert(uv0[slot0] == nil, "[Activity189Event] error redefined Activity189Event." .. slot0)

	uv0[slot0] = uv1
	uv1 = uv1 + 1
end

slot2("onReceiveGetAct189InfoReply")
slot2("onReceiveGetAct189OnceBonusReply")

return _M
