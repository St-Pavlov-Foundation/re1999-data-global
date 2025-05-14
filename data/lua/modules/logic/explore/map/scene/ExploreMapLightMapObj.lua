module("modules.logic.explore.map.scene.ExploreMapLightMapObj", package.seeall)

local var_0_0 = class("ExploreMapLightMapObj", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0:__onInit()

	arg_1_0.isActive = false
	arg_1_0._lightmapData = arg_1_1
	arg_1_0._emptRes = arg_1_3
	arg_1_0._lightmapColorAssetItem = arg_1_4
	arg_1_0._lightmapDirAssetItem = arg_1_5
	arg_1_0.lightmapColorPath = string.gsub(arg_1_2[1], "lightmap", "Lightmap")
	arg_1_0.lightmapDirPath = string.gsub(arg_1_2[2], "lightmap", "Lightmap")
end

function var_0_0.show(arg_2_0)
	arg_2_0.isActive = true

	arg_2_0:updateLightMap()
end

function var_0_0.hide(arg_3_0)
	arg_3_0.isActive = false

	arg_3_0:updateLightMap()
end

function var_0_0.updateLightMap(arg_4_0, arg_4_1)
	if arg_4_0.isActive then
		arg_4_0._colorRes = arg_4_0._colorRes or arg_4_0._lightmapColorAssetItem:GetResource(arg_4_0.lightmapColorPath)
		arg_4_0._dirRes = arg_4_0._dirRes or arg_4_0._lightmapDirAssetItem:GetResource(arg_4_0.lightmapDirPath)
		arg_4_0._lightmapData.lightmapColor = arg_4_0._colorRes
		arg_4_0._lightmapData.lightmapDir = arg_4_0._dirRes
	else
		arg_4_0:_clear()

		arg_4_0._lightmapData.lightmapColor = arg_4_0._emptRes
		arg_4_0._lightmapData.lightmapDir = arg_4_0._emptRes
	end
end

function var_0_0.dispose(arg_5_0)
	arg_5_0:_clear()

	arg_5_0._lightmapData = nil
	arg_5_0._lightmapColorAssetItem = nil
	arg_5_0._lightmapDirAssetItem = nil

	arg_5_0:__onDispose()
end

function var_0_0._clear(arg_6_0)
	if arg_6_0._colorRes then
		UnityEngine.Resources.UnloadAsset(arg_6_0._colorRes)
	end

	if arg_6_0._dirRes then
		UnityEngine.Resources.UnloadAsset(arg_6_0._dirRes)
	end

	arg_6_0._dirRes = nil
	arg_6_0._colorRes = nil
end

return var_0_0
