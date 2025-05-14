module("modules.logic.scene.room.asset.RoomAssetItem", package.seeall)

local var_0_0 = class("RoomAssetItem")

function var_0_0.ctor(arg_1_0)
	arg_1_0._initialized = false
	arg_1_0.createTime = 0
	arg_1_0._refCount = 0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._initialized then
		logError(string.format("初始化失败: [RoomAssetItem] ab: %s", tostring(arg_2_2)))

		return
	end

	arg_2_0._refCount = 0
	arg_2_0._abPath = arg_2_2
	arg_2_0._initialized = true
	arg_2_0._assetItem = arg_2_1

	arg_2_1:Retain()

	arg_2_0._cacheResourceDict = {}
	arg_2_0.createTime = Time.time
end

function var_0_0.getResource(arg_3_0, arg_3_1)
	if not arg_3_0._initialized then
		return
	end

	local var_3_0 = arg_3_0._cacheResourceDict[arg_3_1]

	if var_3_0 then
		return var_3_0
	end

	local var_3_1 = arg_3_0._assetItem:GetResource(arg_3_1)

	arg_3_0._cacheResourceDict[arg_3_1] = var_3_1

	if not var_3_1 then
		logError(string.format("获取资源失败, [RoomAssetItem] res: %s, ab: %s", tostring(arg_3_1), tostring(arg_3_0._abPath)))
	end

	return var_3_1
end

function var_0_0.dispose(arg_4_0)
	arg_4_0._initialized = false

	if arg_4_0._cacheResourceDict then
		local var_4_0 = arg_4_0._cacheResourceDict

		arg_4_0._cacheResourceDict = nil

		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			var_4_0[iter_4_0] = nil
		end
	end

	if arg_4_0._assetItem then
		arg_4_0._assetItem:Release()

		arg_4_0._assetItem = nil
	end

	arg_4_0._refCount = 0
end

function var_0_0.retain(arg_5_0)
	if arg_5_0._initialized then
		arg_5_0._refCount = arg_5_0._refCount + 1
	end
end

function var_0_0.release(arg_6_0)
	if not arg_6_0._initialized then
		return
	end

	if arg_6_0._refCount <= 1 then
		arg_6_0._refCount = 0

		arg_6_0:dispose()
	else
		arg_6_0._refCount = arg_6_0._refCount - 1
	end
end

var_0_0.GetResource = var_0_0.getResource
var_0_0.Release = var_0_0.release
var_0_0.Retain = var_0_0.retain
var_0_0.Dispose = var_0_0.dispose

return var_0_0
