module("booter.LuaResMgr", package.seeall)

local var_0_0 = SLFramework.ResMgr.Instance

function _checkIsPathValid(arg_1_0)
	if arg_1_0 == nil then
		logError("LuaResMgr _checkIsPathValid, assetUrl can not be nil!")

		return false
	end

	if var_0_0.IsFromEditorDir and string.match(arg_1_0, "[A-Z]+") ~= nil then
		logError("LuaResMgr _checkIsPathValid, 资源路径必须都是小写，请检查: assetUrl = " .. arg_1_0)

		return false
	end

	return true
end

function loadAbAsset(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not _checkIsPathValid(arg_2_0) then
		return
	end

	var_0_0:GetAbAssetForLua(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
end

function loadNonAbAsset(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not _checkIsPathValid(arg_3_0) then
		return
	end

	var_0_0:GetNonAbAssetForLua(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
end

function loadPersistentRes(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0 == nil then
		logError("LuaResMgr loadPersistentRes, fullUrl can not be nil!")

		return false
	end

	var_0_0:GetPersistenResForLua(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
end

function removeAssetLoadCb(arg_5_0, arg_5_1, arg_5_2)
	var_0_0:RemoveAssetItemCb(arg_5_0, arg_5_1, arg_5_2)
end

setGlobal("loadAbAsset", loadAbAsset)
setGlobal("loadNonAbAsset", loadNonAbAsset)
setGlobal("loadPersistentRes", loadPersistentRes)
setGlobal("removeAssetLoadCb", removeAssetLoadCb)
setGlobal("GameResMgr", var_0_0)
