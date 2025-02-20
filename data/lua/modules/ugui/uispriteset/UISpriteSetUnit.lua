module("modules.ugui.uispriteset.UISpriteSetUnit", package.seeall)

slot0 = class("UISpriteSetUnit")

function slot0.init(slot0, slot1)
	slot0._loader = nil
	slot0._spriteSetAsset = nil
	slot0._assetPath = slot1
	slot0._refImageList = {}
	slot0._refCacheImages = {}
	slot0._loading = false
	slot0._loadDone = false
end

function slot0.getSpriteSetAsset(slot0)
	return slot0._spriteSetAsset
end

function slot0._checkLoadAsset(slot0)
	if slot0._loader then
		return
	end

	slot0._loading = true
	slot1 = MultiAbLoader.New()
	slot0._loader = slot1

	slot1:addPath(slot0._assetPath)
	slot1:startLoad(function (slot0)
		uv1._spriteSetAsset = uv0:getAssetItem(uv1._assetPath):GetResource(uv1._assetPath)

		for slot6, slot7 in pairs(uv1._refCacheImages) do
			if gohelper.isNil(slot6) == false then
				uv1:_setImgAlpha(slot6, slot7.alpha or 1)

				slot6.sprite = uv1._spriteSetAsset:GetSprite(slot7.spriteName)

				if slot7.setNativeSize then
					slot6:SetNativeSize()
				end

				table.insert(uv1._refImageList, slot6)
			end
		end

		uv1._refCacheImages = {}
		uv1._hasCache = false
		uv1._loading = false
		uv1._loadDone = true

		if uv1.callback then
			uv1.callback(uv1.callbackObj)
		end
	end)
end

function slot0.setImageAlpha(slot0, slot1, slot2)
	if slot0._refCacheImages[slot1] then
		slot3.alpha = slot2
	else
		slot0:_setImgAlpha(slot1, slot2)
	end
end

function slot0._setImgAlpha(slot0, slot1, slot2)
	slot3 = slot1.color
	slot3.a = slot2
	slot1.color = slot3
end

function slot0.setSprite(slot0, slot1, slot2, slot3, slot4)
	if gohelper.isNil(slot1) then
		logError("set SpriteSet fail, image = null, spriteName = " .. (slot2 or "nil"))

		return
	end

	if string.nilorempty(slot2) then
		logError("set SpriteSet fail, spriteName = null, image = " .. (slot1 and slot1.name or "nil"))

		return
	end

	slot0:_checkLoadAsset()

	if not slot0._spriteSetAsset then
		if gohelper.isNil(slot1.sprite) then
			slot0:_setImgAlpha(slot1, 0)
		end

		slot0._refCacheImages[slot1] = {
			spriteName = slot2,
			setNativeSize = slot3,
			alpha = slot4
		}
		slot0._hasCache = true

		return
	end

	if slot2 then
		slot1.sprite = slot0._spriteSetAsset:GetSprite(slot2)

		if slot3 then
			slot1:SetNativeSize()
		end
	end

	table.insert(slot0._refImageList, slot1)
end

function slot0.loadAsset(slot0, slot1, slot2)
	if slot0._loadDone then
		slot1(slot2)

		return
	end

	slot0.callback = slot1
	slot0.callbackObj = slot2

	if slot0._loading then
		return
	end

	slot0._loading = true
	slot3 = MultiAbLoader.New()
	slot0._loader = slot3

	slot3:addPath(slot0._assetPath)
	slot3:startLoad(function (slot0)
		uv1._spriteSetAsset = uv0:getAssetItem(uv1._assetPath):GetResource(uv1._assetPath)
		uv1._loading = false
		uv1._loadDone = true

		if uv1.callback then
			uv1.callback(uv1.callbackObj)
		end
	end)
end

function slot0.getSprite(slot0, slot1)
	if not slot0._loadDone then
		logError("sprite not load done, please use self:loadAsset() load.")

		return nil
	end

	return slot0._spriteSetAsset:GetSprite(slot1)
end

function slot0.tryDispose(slot0)
	if slot0._hasCache then
		return
	end

	for slot4 = #slot0._refImageList, 1, -1 do
		if gohelper.isNil(slot0._refImageList[slot4]) then
			table.remove(slot0._refImageList, slot4)
		end
	end

	if slot0._loader and #slot0._refImageList == 0 then
		slot0._spriteSetAsset = nil

		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
