module("modules.logic.fight.entity.pool.FightSpineMatPool", package.seeall)

slot0 = class("FightSpineMatPool")
slot1 = 10
slot2 = {}

function slot0.getMat(slot0)
	if not uv0[slot0] then
		uv0[slot0] = {}
	end

	if #slot1 > 0 then
		return table.remove(slot1, #slot1)
	elseif FightHelper.getPreloadAssetItem(ResUrl.getRoleSpineMat(slot0)) and slot3:GetResource() then
		return UnityEngine.Object.Instantiate(slot4)
	end

	logError("Material has not preload: " .. slot0)
end

function slot0.returnMat(slot0, slot1)
	if not uv0[slot0] then
		uv0[slot0] = {}
	end

	if uv1 < #slot2 then
		gohelper.destroy(slot1)
	else
		table.insert(slot2, slot1)
	end
end

function slot0.dispose()
	for slot3, slot4 in pairs(uv0) do
		for slot8, slot9 in ipairs(slot4) do
			gohelper.destroy(slot9)
		end
	end

	uv0 = {}
end

return slot0
