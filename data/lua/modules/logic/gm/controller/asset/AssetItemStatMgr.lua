-- chunkname: @modules/logic/gm/controller/asset/AssetItemStatMgr.lua

module("modules.logic.gm.controller.asset.AssetItemStatMgr", package.seeall)

local AssetItemStatMgr = class("AssetItemStatMgr", BaseController)
local resMgr = SLFramework.ResMgr.Instance

function AssetItemStatMgr:start()
	return
end

function AssetItemStatMgr.initReflection()
	if AssetItemStatMgr.initedRef then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	local type = tolua.findtype("SLFramework.ResMgr")
	local BindingFlags = System.Reflection.BindingFlags
	local getMask = BindingFlags.GetMask
	local mask = getMask(BindingFlags.Instance, BindingFlags.NonPublic)
	local field = tolua.getfield(type, "assetCache", mask)
	local assetCache = field:Get(resMgr)
	local iter = assetCache:GetEnumerator()

	while iter:MoveNext() do
		local key = iter.Current.Key
		local value = iter.Current.Value

		logError(value.ReferenceCount)
	end
end

AssetItemStatMgr.instance = AssetItemStatMgr.New()

return AssetItemStatMgr
