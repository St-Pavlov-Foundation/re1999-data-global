module("modules.logic.explore.map.scene.ExploreMapLightMapObj", package.seeall)

slot0 = class("ExploreMapLightMapObj", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:__onInit()

	slot0.isActive = false
	slot0._lightmapData = slot1
	slot0._emptRes = slot3
	slot0._lightmapColorAssetItem = slot4
	slot0._lightmapDirAssetItem = slot5
	slot0.lightmapColorPath = string.gsub(slot2[1], "lightmap", "Lightmap")
	slot0.lightmapDirPath = string.gsub(slot2[2], "lightmap", "Lightmap")
end

function slot0.show(slot0)
	slot0.isActive = true

	slot0:updateLightMap()
end

function slot0.hide(slot0)
	slot0.isActive = false

	slot0:updateLightMap()
end

function slot0.updateLightMap(slot0, slot1)
	if slot0.isActive then
		slot0._colorRes = slot0._colorRes or slot0._lightmapColorAssetItem:GetResource(slot0.lightmapColorPath)
		slot0._dirRes = slot0._dirRes or slot0._lightmapDirAssetItem:GetResource(slot0.lightmapDirPath)
		slot0._lightmapData.lightmapColor = slot0._colorRes
		slot0._lightmapData.lightmapDir = slot0._dirRes
	else
		slot0:_clear()

		slot0._lightmapData.lightmapColor = slot0._emptRes
		slot0._lightmapData.lightmapDir = slot0._emptRes
	end
end

function slot0.dispose(slot0)
	slot0:_clear()

	slot0._lightmapData = nil
	slot0._lightmapColorAssetItem = nil
	slot0._lightmapDirAssetItem = nil

	slot0:__onDispose()
end

function slot0._clear(slot0)
	if slot0._colorRes then
		UnityEngine.Resources.UnloadAsset(slot0._colorRes)
	end

	if slot0._dirRes then
		UnityEngine.Resources.UnloadAsset(slot0._dirRes)
	end

	slot0._dirRes = nil
	slot0._colorRes = nil
end

return slot0
