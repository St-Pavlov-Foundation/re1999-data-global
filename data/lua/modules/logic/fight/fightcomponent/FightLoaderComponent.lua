module("modules.logic.fight.fightcomponent.FightLoaderComponent", package.seeall)

local var_0_0 = class("FightLoaderComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._urlDic = {}
	arg_1_0._callback = {}
	arg_1_0._assetDic = arg_1_0:newUserDataTable()
	arg_1_0._failedDic = {}
	arg_1_0._listLoadCallback = {}
end

function var_0_0.getAssetItem(arg_2_0, arg_2_1)
	return arg_2_0._assetDic[arg_2_1]
end

function var_0_0.loadAsset(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_0.component_dead then
		return
	end

	if arg_3_0._failedDic[arg_3_1] then
		arg_3_2(arg_3_3, false, nil, arg_3_4)

		return
	end

	if arg_3_0._assetDic[arg_3_1] then
		arg_3_2(arg_3_3, true, arg_3_0._assetDic[arg_3_1], arg_3_4)

		return
	end

	if not arg_3_0._callback[arg_3_1] then
		arg_3_0._callback[arg_3_1] = {}
	end

	table.insert(arg_3_0._callback[arg_3_1], {
		call_back = arg_3_2,
		handler = arg_3_3,
		param = arg_3_4
	})

	if not arg_3_0._urlDic[arg_3_1] then
		arg_3_0._urlDic[arg_3_1] = true

		loadAbAsset(arg_3_1, false, arg_3_0._onLoadCallback, arg_3_0)
	end
end

function var_0_0.loadListAsset(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	if arg_4_0.component_dead then
		return
	end

	if arg_4_3 then
		arg_4_0._listLoadCallback[arg_4_1] = {
			finishCallback = arg_4_3,
			handler = arg_4_4
		}
	end

	arg_4_5 = arg_4_5 or {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:loadAsset(iter_4_1, arg_4_2, arg_4_4, arg_4_5[iter_4_0])
	end

	arg_4_0:_invokeUrlListCallback()
end

function var_0_0._invokeUrlListCallback(arg_5_0)
	if not arg_5_0._listLoadCallback then
		return
	end

	if arg_5_0.component_dead then
		return
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0._listLoadCallback) do
		local var_5_0 = 0
		local var_5_1 = false

		for iter_5_2, iter_5_3 in ipairs(iter_5_0) do
			if arg_5_0._assetDic[iter_5_3] then
				var_5_0 = var_5_0 + 1
			end

			if arg_5_0._failedDic[iter_5_3] then
				var_5_0 = var_5_0 + 1
				var_5_1 = true
			end
		end

		if var_5_0 == #iter_5_0 then
			if var_5_1 then
				iter_5_1.finishCallback(iter_5_1.handler, false)
			else
				iter_5_1.finishCallback(iter_5_1.handler, true)
			end

			arg_5_0._listLoadCallback[iter_5_0] = nil

			if arg_5_0.component_dead then
				return
			end
		end
	end
end

function var_0_0._onLoadCallback(arg_6_0, arg_6_1)
	if arg_6_0.component_dead then
		return
	end

	local var_6_0 = arg_6_1.ResPath
	local var_6_1 = arg_6_1.IsLoadSuccess

	if var_6_1 then
		arg_6_0._assetDic[var_6_0] = arg_6_1

		arg_6_1:Retain()
	else
		arg_6_0._failedDic[var_6_0] = true

		logError("资源加载失败,URL:" .. var_6_0)
	end

	if arg_6_0._callback[var_6_0] then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._callback[var_6_0]) do
			iter_6_1.call_back(iter_6_1.handler, var_6_1, arg_6_1, iter_6_1.param)

			if arg_6_0.component_dead then
				return
			end
		end
	end

	arg_6_0:_invokeUrlListCallback()

	arg_6_0._callback[var_6_0] = nil
end

function var_0_0.onDestructor(arg_7_0)
	arg_7_0.component_dead = true

	for iter_7_0, iter_7_1 in pairs(arg_7_0._urlDic) do
		removeAssetLoadCb(iter_7_0, arg_7_0._onLoadCallback, arg_7_0)
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._assetDic) do
		iter_7_3:Release()
	end

	arg_7_0._urlDic = nil
	arg_7_0._callback = nil
	arg_7_0._listLoadCallback = nil
	arg_7_0._failedDic = nil
end

return var_0_0
