module("modules.ugui.icon.IconMaterialMgr", package.seeall)

slot0 = class("IconMaterialMgr")
slot0.LoadFail = -1

function slot0.init(slot0)
	slot0.variantIdToMaterialPath = {
		"ui/materials/dynamic/ui_headicon_stylization_1.mat",
		"ui/materials/dynamic/ui_headicon_stylization_2.mat",
		"ui/materials/dynamic/ui_headicon_stylization_3.mat",
		"ui/materials/dynamic/ui_headicon_stylization_4.mat",
		"ui/materials/dynamic/ui_headicon_stylization_5.mat",
		"ui/materials/dynamic/ui_headicon_stylization_6.mat",
		"ui/materials/dynamic/ui_headicon_stylization_assist.mat",
		"ui/materials/dynamic/ui_headicon_stylization_7.mat"
	}
	slot0.variantIdToMaterialPathWithRound = {
		[0] = "ui/materials/dynamic/ui_enemyinfo_headicon_mask.mat",
		"ui/materials/dynamic/ui_headicon_stylization_1_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_2_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_3_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_4_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_5_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_6_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_assist_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_7_round.mat"
	}
	slot0.needSetMaterialIconImages = {}
	slot0.loadedMaterials = {}
	slot0.loadingMaterialCount = 0
	slot0.assetItems = {}
end

function slot0.getMaterialPath(slot0, slot1)
	return slot0.variantIdToMaterialPath[slot1]
end

function slot0.getMaterialPathWithRound(slot0, slot1)
	return slot0.variantIdToMaterialPathWithRound[slot1]
end

function slot0.loadMaterialAddSet(slot0, slot1, slot2)
	if not slot1 then
		logError("materialPath is nil")

		return
	end

	if slot0.loadedMaterials[slot1] then
		if slot0.loadedMaterials[slot1] ~= uv0.LoadFail then
			slot2.material = slot0.loadedMaterials[slot1]
		end

		return
	end

	slot0.loadingMaterialCount = slot0.loadingMaterialCount + 1

	if not slot0.needSetMaterialIconImages[slot1] then
		slot0.needSetMaterialIconImages[slot1] = {}
	end

	table.insert(slot0.needSetMaterialIconImages[slot1], slot2)
	loadAbAsset(slot1, false, slot0.loadAssetCallback, slot0)
end

function slot0.loadAssetCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		table.insert(slot0.assetItems, slot1)
		slot1:Retain()

		slot0.loadedMaterials[slot1.AssetUrl] = slot1:GetResource(slot1.AssetUrl)
	else
		logError(string.format("load '%s' failed", slot1.AssetUrl))

		slot0.loadedMaterials[slot1.AssetUrl] = uv0.LoadFail
	end

	slot0.loadingMaterialCount = slot0.loadingMaterialCount - 1

	if slot0.loadingMaterialCount == 0 then
		for slot5, slot6 in pairs(slot0.needSetMaterialIconImages) do
			for slot10 = 1, #slot6 do
				if slot0.loadedMaterials[slot5] ~= uv0.LoadFail and not gohelper.isNil(slot6[slot10]) then
					slot6[slot10].material = slot11
				end
			end
		end

		slot0:recycleNeedSetMaterialImages()
	end
end

function slot0.recycleNeedSetMaterialImages(slot0)
	for slot4, slot5 in pairs(slot0.needSetMaterialIconImages) do
		tabletool.clear(slot5)
	end
end

slot0.instance = slot0.New()

return slot0
