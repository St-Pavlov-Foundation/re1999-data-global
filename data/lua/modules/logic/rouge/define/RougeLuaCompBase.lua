module("modules.logic.rouge.define.RougeLuaCompBase", package.seeall)

local var_0_0 = class("RougeLuaCompBase", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
	var_0_0.super.init(arg_1_0, arg_1_1)
	arg_1_0:initDLCs(arg_1_1)
end

function var_0_0.initDLCs(arg_2_0, arg_2_1)
	arg_2_0._parentGo = arg_2_1

	arg_2_0:_collectAllClsAndLoadRes()
end

function var_0_0.onUpdateDLC(arg_3_0, ...)
	return
end

function var_0_0.tickUpdateDLCs(arg_4_0, ...)
	if not arg_4_0._dlcComps or not arg_4_0._resLoadDone then
		arg_4_0.params = {
			...
		}

		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._dlcComps) do
		iter_4_1:onUpdateDLC(...)
	end
end

function var_0_0._collectAllClsAndLoadRes(arg_5_0)
	arg_5_0._clsList = arg_5_0:getUserDataTb_()

	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = RougeOutsideModel.instance:season()
	local var_5_3 = RougeModel.instance:getVersion()

	for iter_5_0, iter_5_1 in ipairs(var_5_3 or {}) do
		local var_5_4 = string.format("%s_%s_%s", arg_5_0.__cname, var_5_2, iter_5_1)
		local var_5_5 = _G[var_5_4]

		table.insert(arg_5_0._clsList, var_5_5)
		arg_5_0:_collectNeedLoadRes(var_5_5, var_5_0, var_5_1)
	end

	arg_5_0:_loadAllNeedRes(var_5_0)
end

function var_0_0._collectNeedLoadRes(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_1 and arg_6_1.AssetUrl

	if var_6_0 then
		arg_6_3[var_6_0] = true

		table.insert(arg_6_2, var_6_0)
	end
end

function var_0_0._loadAllNeedRes(arg_7_0, arg_7_1)
	arg_7_0._resLoadDone = false

	if not arg_7_1 or #arg_7_1 <= 0 then
		arg_7_0:_resLoadDoneCallBack()

		return
	end

	arg_7_0._abLoader = arg_7_0._abLoader or MultiAbLoader.New()

	arg_7_0._abLoader:setPathList(arg_7_1)
	arg_7_0._abLoader:startLoad(arg_7_0._resLoadDoneCallBack, arg_7_0)
end

function var_0_0._resLoadDoneCallBack(arg_8_0)
	arg_8_0._dlcComps = arg_8_0:getUserDataTb_()

	local var_8_0

	if arg_8_0.params then
		var_8_0 = unpack(arg_8_0.params)
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._clsList) do
		local var_8_1 = arg_8_0:_createGo(iter_8_1.ParentObjPath, iter_8_1.AssetUrl, iter_8_1.ResInitPosition)

		if var_8_1 then
			local var_8_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, iter_8_1, arg_8_0)

			var_8_2:onUpdateDLC(var_8_0)
			table.insert(arg_8_0._dlcComps, var_8_2)
		end
	end

	arg_8_0._resLoadDone = true
end

function var_0_0._createGo(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if string.nilorempty(arg_9_1) or string.nilorempty(arg_9_2) or not arg_9_0._abLoader then
		return
	end

	local var_9_0 = arg_9_0._abLoader:getAssetItem(arg_9_2)
	local var_9_1 = var_9_0 and var_9_0:GetResource(arg_9_2)

	if not var_9_1 then
		logError("无法找到指定资源 :" .. arg_9_2)

		return
	end

	local var_9_2 = gohelper.findChild(arg_9_0._parentGo, arg_9_1)

	if gohelper.isNil(var_9_2) then
		logError("无法找到指定肉鸽DLC界面挂点:" .. tostring(arg_9_1))

		return
	end

	local var_9_3 = gohelper.clone(var_9_1, var_9_2)

	if arg_9_3 then
		recthelper.setAnchor(var_9_3.transform, arg_9_3.x or 0, arg_9_3.y or 0)
	end

	return var_9_3
end

function var_0_0.onDestroy(arg_10_0)
	if arg_10_0._abLoader then
		arg_10_0._abLoader:dispose()

		arg_10_0._abLoader = nil
	end

	var_0_0.super.onDestroy(arg_10_0)
	arg_10_0:__onDispose()
end

return var_0_0
