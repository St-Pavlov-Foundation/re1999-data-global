module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapInfo", package.seeall)

local var_0_0 = class("GaoSiNiaoMapInfo")

function var_0_0.make_bagCO(arg_1_0, arg_1_1, arg_1_2)
	if false and arg_1_0.version == GaoSiNiaoEnum.Version.V1_0_0 then
		-- block empty
	else
		return {
			ptype = arg_1_1,
			count = arg_1_2 or 0
		}
	end
end

function var_0_0.make_gridCO(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if false and arg_2_0.version == GaoSiNiaoEnum.Version.V1_0_0 then
		-- block empty
	else
		return {
			gtype = arg_2_1,
			ptype = arg_2_2,
			bMovable = arg_2_3 or false,
			zRot = arg_2_4 or 0
		}
	end
end

function var_0_0.make_gridCOZot(arg_3_0, arg_3_1, arg_3_2)
	if false and arg_3_0.version == GaoSiNiaoEnum.Version.V1_0_0 then
		-- block empty
	else
		return {
			bMovable = false,
			gtype = arg_3_1,
			ptype = GaoSiNiaoEnum.PathType.None,
			zRot = arg_3_2 or 0
		}
	end
end

local var_0_1 = "modules.configs.gaosiniao.map_"

function var_0_0._getMapRequireLuaPath(arg_4_0)
	return var_0_1 .. arg_4_0.version
end

function var_0_0._loadMapConfig(arg_5_0)
	local var_5_0 = arg_5_0:_getMapRequireLuaPath()

	return require(var_5_0)
end

function var_0_0.ctor(arg_6_0, arg_6_1)
	arg_6_0.version = assert(arg_6_1)

	arg_6_0:clear()
end

function var_0_0.clear(arg_7_0)
	arg_7_0._mapCO = false
	arg_7_0.mapId = 0
	arg_7_0.mapCOList = arg_7_0.mapCOList or arg_7_0:_loadMapConfig()
end

function var_0_0.mapCO(arg_8_0)
	if not arg_8_0._mapCO then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.mapCOList) do
			if iter_8_1.id == arg_8_0.mapId then
				arg_8_0._mapCO = tabletool.copy(iter_8_1)

				break
			end
		end
	end

	if isDebugBuild and not arg_8_0._mapCO then
		logError("Not Found MapCO!! mapId=" .. tostring(arg_8_0.mapId))
	end

	return arg_8_0._mapCO or {}
end

function var_0_0.reset(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		arg_9_0.version = arg_9_2
	end

	arg_9_0:clear()

	arg_9_0.mapId = arg_9_1

	return arg_9_0:mapCO()
end

function var_0_0.mapSize(arg_10_0)
	local var_10_0 = arg_10_0:mapCO() or {}
	local var_10_1 = var_10_0.width or 0
	local var_10_2 = var_10_0.height or 0

	return var_10_1, var_10_2
end

function var_0_0.bagList(arg_11_0)
	local var_11_0 = arg_11_0:mapCO()

	return var_11_0 and var_11_0.bagList or {}
end

function var_0_0.gridList(arg_12_0)
	local var_12_0 = arg_12_0:mapCO()

	return var_12_0 and var_12_0.gridList or {}
end

return var_0_0
