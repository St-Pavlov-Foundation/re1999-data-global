module("modules.ugui.icon.IconMaterialMgr", package.seeall)

local var_0_0 = class("IconMaterialMgr")

var_0_0.LoadFail = -1

function var_0_0.init(arg_1_0)
	arg_1_0.variantIdToMaterialPath = {
		"ui/materials/dynamic/ui_headicon_stylization_1.mat",
		"ui/materials/dynamic/ui_headicon_stylization_2.mat",
		"ui/materials/dynamic/ui_headicon_stylization_3.mat",
		"ui/materials/dynamic/ui_headicon_stylization_4.mat",
		"ui/materials/dynamic/ui_headicon_stylization_5.mat",
		"ui/materials/dynamic/ui_headicon_stylization_6.mat",
		"ui/materials/dynamic/ui_headicon_stylization_assist.mat",
		"ui/materials/dynamic/ui_headicon_stylization_7.mat",
		"ui/materials/dynamic/ui_headicon_stylization_shadow.mat"
	}
	arg_1_0.variantIdToMaterialPathWithRound = {
		[0] = "ui/materials/dynamic/ui_enemyinfo_headicon_mask.mat",
		"ui/materials/dynamic/ui_headicon_stylization_1_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_2_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_3_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_4_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_5_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_6_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_assist_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_7_round.mat",
		"ui/materials/dynamic/ui_headicon_stylization_shadow_round.mat"
	}
	arg_1_0.needSetMaterialIconImages = {}
	arg_1_0.loadedMaterials = {}
	arg_1_0.loadingMaterialCount = 0
	arg_1_0.assetItems = {}
end

function var_0_0.getMaterialPath(arg_2_0, arg_2_1)
	return arg_2_0.variantIdToMaterialPath[arg_2_1]
end

function var_0_0.getMaterialPathWithRound(arg_3_0, arg_3_1)
	return arg_3_0.variantIdToMaterialPathWithRound[arg_3_1]
end

function var_0_0.loadMaterialAddSet(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 then
		logError("materialPath is nil")

		return
	end

	if arg_4_0.loadedMaterials[arg_4_1] then
		if arg_4_0.loadedMaterials[arg_4_1] ~= var_0_0.LoadFail then
			arg_4_2.material = arg_4_0.loadedMaterials[arg_4_1]
		end

		return
	end

	arg_4_0.loadingMaterialCount = arg_4_0.loadingMaterialCount + 1

	if not arg_4_0.needSetMaterialIconImages[arg_4_1] then
		arg_4_0.needSetMaterialIconImages[arg_4_1] = {}
	end

	table.insert(arg_4_0.needSetMaterialIconImages[arg_4_1], arg_4_2)
	loadAbAsset(arg_4_1, false, arg_4_0.loadAssetCallback, arg_4_0)
end

function var_0_0.loadAssetCallback(arg_5_0, arg_5_1)
	if arg_5_1.IsLoadSuccess then
		table.insert(arg_5_0.assetItems, arg_5_1)
		arg_5_1:Retain()

		arg_5_0.loadedMaterials[arg_5_1.AssetUrl] = arg_5_1:GetResource(arg_5_1.AssetUrl)
	else
		logError(string.format("load '%s' failed", arg_5_1.AssetUrl))

		arg_5_0.loadedMaterials[arg_5_1.AssetUrl] = var_0_0.LoadFail
	end

	arg_5_0.loadingMaterialCount = arg_5_0.loadingMaterialCount - 1

	if arg_5_0.loadingMaterialCount == 0 then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.needSetMaterialIconImages) do
			for iter_5_2 = 1, #iter_5_1 do
				local var_5_0 = arg_5_0.loadedMaterials[iter_5_0]

				if var_5_0 ~= var_0_0.LoadFail and not gohelper.isNil(iter_5_1[iter_5_2]) then
					iter_5_1[iter_5_2].material = var_5_0
				end
			end
		end

		arg_5_0:recycleNeedSetMaterialImages()
	end
end

function var_0_0.recycleNeedSetMaterialImages(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.needSetMaterialIconImages) do
		tabletool.clear(iter_6_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
