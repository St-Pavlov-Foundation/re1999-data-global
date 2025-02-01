module("modules.common.res.ResDispose", package.seeall)

slot0 = _M
slot1 = 4
slot2 = {}

function slot0.dispose()
	uv0 = {}
end

function slot0.open()
	TaskDispatcher.runRepeat(uv0._loop, nil, uv1)
end

function slot0.close()
	TaskDispatcher.cancelTask(uv0._loop, nil)
end

function slot0.unloadTrue()
	uv0 = {}

	for slot4, slot5 in pairs(ResMgr.getAssetPool()) do
		if slot5:canRelease() then
			table.insert(uv0, slot5)
		end
	end

	for slot4, slot5 in ipairs(uv0) do
		slot5:tryDispose()
	end
end

function slot0._loop()
	uv0 = {}

	for slot4, slot5 in pairs(ResMgr.getAssetPool()) do
		if slot5:canRelease() then
			table.insert(uv0, slot5)
		end
	end

	for slot4, slot5 in ipairs(uv0) do
		slot5:tryDispose()
	end
end

return slot0
