module("modules.common.res.AssetMO", package.seeall)

local var_0_0 = class("AssetMO")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:setAssetItem(arg_1_1)
end

function var_0_0.setAssetItem(arg_2_0, arg_2_1)
	arg_2_0._refCount = 0
	arg_2_0.IsLoadSuccess = arg_2_1.IsLoadSuccess
	arg_2_0._url = arg_2_1.AssetUrl
	arg_2_0._assetItem = arg_2_1

	arg_2_0._assetItem:Retain()
end

function var_0_0.getUrl(arg_3_0)
	return arg_3_0._url
end

function var_0_0.getResource(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.IsLoadSuccess then
		arg_4_0:_addRef()

		return arg_4_0._assetItem:GetResource(arg_4_1, arg_4_2)
	end
end

function var_0_0.getInstance(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_0.IsLoadSuccess then
		local var_5_0 = arg_5_0._assetItem:GetResource(arg_5_1, arg_5_2)
		local var_5_1 = gohelper.clone(var_5_0, arg_5_3, arg_5_4)
		local var_5_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_1, AssetInstanceComp)

		var_5_1:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false

		var_5_2:setAsset(arg_5_0)
		arg_5_0:_addRef()

		return var_5_1
	end
end

function var_0_0.canRelease(arg_6_0)
	return arg_6_0._refCount <= 0
end

function var_0_0.release(arg_7_0)
	arg_7_0:_subRef()
end

function var_0_0.tryDispose(arg_8_0)
	arg_8_0:_dispose()
end

function var_0_0._dispose(arg_9_0)
	ResMgr.removeAsset(arg_9_0)
	arg_9_0._assetItem:Release()
	arg_9_0:_clearItem(arg_9_0._assetItem)

	arg_9_0._assetItem = nil
	arg_9_0._refCount = 0

	logWarn(string.format("lua释放资源给C#——→%s", arg_9_0._url))
end

function var_0_0._clearItem(arg_10_0, arg_10_1)
	if arg_10_1.ReferenceCount == 1 then
		SLFramework.ResMgr.Instance:ClearItem(arg_10_1)
	end
end

function var_0_0._addRef(arg_11_0)
	arg_11_0._refCount = arg_11_0._refCount + 1
end

function var_0_0._subRef(arg_12_0)
	arg_12_0._refCount = arg_12_0._refCount - 1
end

return var_0_0
