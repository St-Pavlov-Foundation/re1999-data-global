module("modules.common.ShaderKeyWordMgr", package.seeall)

slot0 = class("ShaderKeyWordMgr")
slot0.CLIPALPHA = "_CLIPALPHA_ON"

function slot0.init()
	if not uv0.enableKeyWordDict then
		uv0.enableKeyWordDict = {}
		uv0.disableList = {}
		uv0.updateHandle = UpdateBeat:CreateListener(uv0._onFrame)

		UpdateBeat:AddListener(uv0.updateHandle)
	end
end

function slot0._onFrame()
	tabletool.clear(uv0.disableList)

	for slot6, slot7 in pairs(uv0.enableKeyWordDict) do
		if slot7 < Time.time then
			table.insert(slot1, slot6)
		end
	end

	for slot6, slot7 in ipairs(slot1) do
		uv0.disableKeyWord(slot7)
	end
end

function slot0.enableKeyWordAutoDisable(slot0, slot1)
	if (slot1 or 0) < 0 then
		return
	end

	if not slot0 then
		return
	end

	uv0.init()

	if not uv0.enableKeyWordDict[slot0] then
		slot2[slot0] = Time.time + slot1

		UnityEngine.Shader.EnableKeyword(slot0)
	elseif slot2[slot0] < slot3 then
		slot2[slot0] = slot3
	end
end

function slot0.enableKeyWorkNotDisable(slot0)
	UnityEngine.Shader.EnableKeyword(slot0)

	uv0.enableKeyWordDict[slot0] = nil
end

function slot0.disableKeyWord(slot0)
	if uv0.enableKeyWordDict then
		uv0.enableKeyWordDict[slot0] = nil
	end

	UnityEngine.Shader.DisableKeyword(slot0)
end

function slot0.clear()
	uv0.enableKeyWordDict = nil
	uv0.disableList = nil

	if uv0.updateHandle then
		UpdateBeat:RemoveListener(uv0.updateHandle)
	end
end

return slot0
