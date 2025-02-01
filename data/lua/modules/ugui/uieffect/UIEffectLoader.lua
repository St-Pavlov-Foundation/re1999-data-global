module("modules.ugui.uieffect.UIEffectLoader", package.seeall)

slot0 = class("UIEffectLoader")

function slot0.ctor(slot0)
end

slot1 = SLFramework.EffectPhotographerPool.Instance

function slot0.Init(slot0, slot1, slot2, slot3)
	slot0._effectPath = slot1
	slot0._width = slot2
	slot0._height = slot3
	slot0._photographer = uv0:Get(slot2, slot3)
	slot0._refCount = 0
end

function slot0.startLoad(slot0)
	if slot0._loader then
		return
	end

	slot2 = MultiAbLoader.New()
	slot0._loader = slot2

	slot2:addPath(slot0._effectPath)
	slot2:addPath("ui/materials/dynamic/ui_photo_additive.mat")
	slot2:startLoad(function (slot0)
		if uv0:CheckDispose() then
			return
		end

		slot3 = gohelper.clone(uv1:getAssetItem(uv2):GetResource(uv2), nil, uv2)

		slot3:SetActive(false)
		SLFramework.GameObjectHelper.SetLayer(slot3, uv3.DefaultEffectLayer, true)
		slot3.transform:SetParent(uv0._photographer.effectRootGo.transform, false)
		slot3:SetActive(true)

		uv0._effectGo = slot3

		if uv0._loadcallback ~= nil then
			uv0._loadcallback(uv0._callbackTarget)
		end

		uv0._material = uv1:getAssetItem(uv4):GetResource(uv4)

		for slot8, slot9 in ipairs(uv0._rawImageList) do
			slot9.material = slot4
		end
	end)
end

function slot0.GetPhotographer(slot0)
	slot0._refCount = slot0._refCount + 1

	return slot0._photographer
end

function slot0.getEffectGo(slot0)
	return slot0._effectGo
end

function slot0.getEffect(slot0, slot1, slot2, slot3)
	slot1.texture = slot0:GetPhotographer().renderTexture

	if slot0._material then
		slot1.material = slot0._material

		return
	end

	slot0._rawImageList = slot0._rawImageList or {}

	table.insert(slot0._rawImageList, slot1)

	slot0._loadcallback = slot2
	slot0._callbackTarget = slot3

	slot0:startLoad()
end

function slot0.ReduceRef(slot0)
	slot0._refCount = slot0._refCount - 1

	slot0:CheckDispose()
end

function slot0.CheckDispose(slot0)
	if slot0._refCount <= 0 then
		if not slot0._loader then
			return true
		end

		slot0._loader:dispose()

		slot0._loader = nil
		slot0._rawImageList = nil
		slot0._material = nil

		uv0:Put(slot0._photographer)

		slot0._photographer = nil

		if slot0._effectGo then
			gohelper.destroy(slot0._effectGo)

			slot0._effectGo = nil
		end

		UIEffectManager.instance:_delEffectLoader(slot0._effectPath, slot0._width, slot0._height)

		return true
	end
end

return slot0
