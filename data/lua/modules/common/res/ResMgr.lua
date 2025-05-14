module("modules.common.res.ResMgr", package.seeall)

local var_0_0 = _M
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = 0
local var_0_6

function var_0_0.getAbAsset(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if var_0_3[arg_1_3] then
		local var_1_0 = var_0_3[arg_1_3].url

		if arg_1_0 == var_1_0 then
			return arg_1_3
		end

		var_0_4[var_1_0][arg_1_3] = nil

		var_0_0._getCBPool():putObject(var_0_3[arg_1_3])

		var_0_3[arg_1_3] = nil
	end

	local var_1_1 = var_0_1[arg_1_0]

	if var_1_1 then
		arg_1_1(arg_1_2, var_1_1)
	else
		var_0_5 = var_0_5 + 1

		local var_1_2 = var_0_0._getCBPool():getObject()

		var_1_2.callback = arg_1_1
		var_1_2.url = arg_1_0
		var_1_2.id = var_0_5

		var_1_2:setCbObj(arg_1_2)

		var_0_3[var_0_5] = var_1_2

		if not var_0_4[arg_1_0] then
			var_0_4[arg_1_0] = {}
		end

		var_0_4[arg_1_0][var_0_5] = var_1_2

		loadAbAsset(arg_1_0, false, _onLoadCallback)

		if not var_0_1[arg_1_0] then
			return var_0_5
		end
	end
end

function var_0_0._getCBPool()
	if not var_0_6 then
		var_0_6 = LuaObjPool.New(200, LuaGeneralCallback._poolNew, LuaGeneralCallback._poolRelease, LuaGeneralCallback._poolReset)
	end

	return var_0_6
end

function var_0_0.removeCallBack(arg_3_0)
	if var_0_3[arg_3_0] then
		local var_3_0 = var_0_3[arg_3_0].url

		var_0_4[var_3_0][arg_3_0] = nil

		var_0_0._getCBPool():putObject(var_0_3[arg_3_0])

		var_0_3[arg_3_0] = nil
	end
end

function var_0_0.removeAsset(arg_4_0)
	var_0_1[arg_4_0:getUrl()] = nil

	table.insert(var_0_2, arg_4_0)
end

function var_0_0.ReleaseObj(arg_5_0)
	if arg_5_0 and gohelper.isNil(arg_5_0) == false then
		local var_5_0 = MonoHelper.getLuaComFromGo(arg_5_0, AssetInstanceComp)

		if var_5_0 then
			var_5_0:onDestroy()
			MonoHelper.removeLuaComFromGo(arg_5_0, AssetInstanceComp)
		end

		gohelper.destroy(arg_5_0)
	end
end

function var_0_0._onLoadCallback(arg_6_0)
	local var_6_0 = arg_6_0.AssetUrl
	local var_6_1 = _getAssetMO(arg_6_0, var_6_0)
	local var_6_2 = var_0_4[var_6_0]

	if var_6_2 then
		for iter_6_0, iter_6_1 in pairs(var_6_2) do
			var_0_3[iter_6_0] = nil

			iter_6_1:invoke(var_6_1)
			var_0_0._getCBPool():putObject(iter_6_1)
		end
	end

	var_0_4[var_6_0] = nil
end

function var_0_0.getAssetPool()
	return var_0_1
end

function var_0_0._getAssetMO(arg_8_0, arg_8_1)
	if var_0_1[arg_8_1] == nil then
		local var_8_0 = table.remove(var_0_2)

		if var_8_0 == nil then
			var_8_0 = AssetMO.New(arg_8_0)
		else
			var_8_0:setAssetItem(arg_8_0)
		end

		var_0_1[arg_8_1] = var_8_0
	end

	return var_0_1[arg_8_1]
end

return var_0_0
