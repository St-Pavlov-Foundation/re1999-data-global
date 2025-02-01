module("modules.common.res.AssetInstanceComp", package.seeall)

slot0 = class("AssetInstanceComp", LuaCompBase)

function slot0.setAsset(slot0, slot1)
	slot0._assetMO = slot1
end

function slot0.onDestroy(slot0)
	if slot0._assetMO then
		slot0._assetMO:release()
	end

	slot0._assetMO = nil
end

return slot0
