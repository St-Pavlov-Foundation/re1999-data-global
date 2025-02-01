module("modules.spine.SpinePrefabInstantiate", package.seeall)

slot0 = class("SpinePrefabInstantiate", LuaCompBase)

function slot0.Create(slot0)
	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
end

function slot0.init(slot0, slot1)
	slot0._containerGO = slot1
	slot0._path = nil
	slot0._assetPath = nil
	slot0._assetItem = nil
	slot0._instGO = nil
	slot0._finishCallback = nil
	slot0._callbackTarget = nil
end

function slot0.startLoad(slot0, slot1, slot2, slot3, slot4)
	slot0._path = slot1
	slot0._assetPath = slot2
	slot0._finishCallback = slot3
	slot0._callbackTarget = slot4

	loadAbAsset(slot0._path, false, slot0._onLoadCallback, slot0)
end

function slot0.getPath(slot0)
	return slot0._path
end

function slot0.getAssetItem(slot0)
	return slot0._assetItem
end

function slot0.getInstGO(slot0)
	return slot0._instGO
end

function slot0.dispose(slot0)
	if slot0._path then
		removeAssetLoadCb(slot0._path, slot0._onLoadCallback, slot0)
	end

	if slot0._assetItem then
		slot0._assetItem:Release()
	end

	gohelper.destroy(slot0._instGO)

	slot0._path = nil
	slot0._assetPath = nil
	slot0._assetItem = nil
	slot0._instGO = nil
	slot0._finishCallback = nil
	slot0._callbackTarget = nil
end

function slot0.onDestroy(slot0)
	slot0:dispose()

	slot0._containerGO = nil
end

function slot0._onLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0._assetItem = slot1

		slot0._assetItem:Retain()

		slot0._instGO = gohelper.clone(slot0._assetItem:GetResource(slot0._assetPath), slot0._containerGO)

		if slot0._finishCallback then
			if slot0._callbackTarget then
				slot0._finishCallback(slot0._callbackTarget, slot0)
			else
				slot0:_finishCallback()
			end
		end
	end
end

return slot0
