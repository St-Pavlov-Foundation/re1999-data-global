module("modules.logic.rouge.map.controller.RougeMapDLCResHelper", package.seeall)

local var_0_0 = class("RougeMapDLCResHelper")

function var_0_0.handleLoadMapDLCRes(arg_1_0, ...)
	local var_1_0 = var_0_0._getMapDLCResHandle(arg_1_0)

	if not var_1_0 then
		return
	end

	var_1_0(...)
end

function var_0_0._getMapDLCResHandle(arg_2_0)
	var_0_0._initHandleLoadMapDLCRes()

	return var_0_0._mapDLCResLoadHandleMap[arg_2_0]
end

function var_0_0._loadMapDLCResHandle_101(arg_3_0, arg_3_1)
	arg_3_1.fogPrefab = arg_3_0:getAssetItem(RougeMapEnum.FogMaterialUrl):GetResource()
end

function var_0_0._initHandleLoadMapDLCRes()
	if not var_0_0._mapDLCResLoadHandleMap then
		var_0_0._mapDLCResLoadHandleMap = {
			[RougeDLCEnum.DLCEnum.DLC_101] = var_0_0._loadMapDLCResHandle_101
		}
	end
end

function var_0_0.handleCreateMapDLC(arg_5_0, ...)
	local var_5_0 = var_0_0._getCreateMapDLCHandle(arg_5_0)

	if not var_5_0 then
		return
	end

	var_5_0(...)
end

function var_0_0._getCreateMapDLCHandle(arg_6_0)
	var_0_0._initHandleCreateMapDLC()

	return var_0_0._mapDLCHandleMap[arg_6_0]
end

function var_0_0._createMapDLCHandle_101(arg_7_0)
	local var_7_0 = gohelper.findChild(arg_7_0.mapGo, "root/BackGround")
	local var_7_1 = gohelper.clone(arg_7_0.fogPrefab, var_7_0, "fog")

	MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, RougeMapFogEffect)
end

function var_0_0._initHandleCreateMapDLC()
	if not var_0_0._mapDLCHandleMap then
		var_0_0._mapDLCHandleMap = {
			[RougeDLCEnum.DLCEnum.DLC_101] = var_0_0._createMapDLCHandle_101
		}
	end
end

function var_0_0.addMapDLCRes(arg_9_0, arg_9_1, arg_9_2)
	var_0_0._initMapDLCResUrl()

	local var_9_0 = RougeMapHelper._mapDLCResUrlMap[arg_9_0]
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1 or {}) do
		local var_9_2 = var_9_0 and var_9_0[iter_9_1]

		for iter_9_2, iter_9_3 in ipairs(var_9_2 or {}) do
			if not var_9_1[iter_9_3] then
				arg_9_2:addPath(iter_9_3)

				var_9_1[iter_9_3] = true
			end
		end
	end
end

function var_0_0._initMapDLCResUrl()
	if not RougeMapHelper._mapDLCResUrlMap then
		RougeMapHelper._mapDLCResUrlMap = {
			[RougeMapEnum.MapType.Normal] = {
				[RougeDLCEnum.DLCEnum.DLC_101] = {
					RougeMapEnum.FogMaterialUrl
				}
			}
		}
	end
end

return var_0_0
