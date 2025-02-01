module("modules.common.res.AssetMO", package.seeall)

slot0 = class("AssetMO")

function slot0.ctor(slot0, slot1)
	slot0:setAssetItem(slot1)
end

function slot0.setAssetItem(slot0, slot1)
	slot0._refCount = 0
	slot0.IsLoadSuccess = slot1.IsLoadSuccess
	slot0._url = slot1.AssetUrl
	slot0._assetItem = slot1

	slot0._assetItem:Retain()
end

function slot0.getUrl(slot0)
	return slot0._url
end

function slot0.getResource(slot0, slot1, slot2)
	if slot0.IsLoadSuccess then
		slot0:_addRef()

		return slot0._assetItem:GetResource(slot1, slot2)
	end
end

function slot0.getInstance(slot0, slot1, slot2, slot3, slot4)
	if slot0.IsLoadSuccess then
		slot6 = gohelper.clone(slot0._assetItem:GetResource(slot1, slot2), slot3, slot4)
		slot6:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false

		MonoHelper.addNoUpdateLuaComOnceToGo(slot6, AssetInstanceComp):setAsset(slot0)
		slot0:_addRef()

		return slot6
	end
end

function slot0.canRelease(slot0)
	return slot0._refCount <= 0
end

function slot0.release(slot0)
	slot0:_subRef()
end

function slot0.tryDispose(slot0)
	slot0:_dispose()
end

function slot0._dispose(slot0)
	ResMgr.removeAsset(slot0)
	slot0._assetItem:Release()
	slot0:_clearItem(slot0._assetItem)

	slot0._assetItem = nil
	slot0._refCount = 0

	logWarn(string.format("lua释放资源给C#——→%s", slot0._url))
end

function slot0._clearItem(slot0, slot1)
	if slot1.ReferenceCount == 1 then
		SLFramework.ResMgr.Instance:ClearItem(slot1)
	end
end

function slot0._addRef(slot0)
	slot0._refCount = slot0._refCount + 1
end

function slot0._subRef(slot0)
	slot0._refCount = slot0._refCount - 1
end

return slot0
