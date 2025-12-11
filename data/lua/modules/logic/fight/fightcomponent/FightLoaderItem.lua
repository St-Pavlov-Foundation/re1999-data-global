module("modules.logic.fight.fightcomponent.FightLoaderItem", package.seeall)

local var_0_0 = class("FightLoaderItem", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.url = arg_1_1
	arg_1_0.callback = arg_1_2
	arg_1_0.handle = arg_1_3
	arg_1_0.param = arg_1_4
end

function var_0_0.startLoad(arg_2_0)
	loadAbAsset(arg_2_0.url, false, arg_2_0.onLoadCallback, arg_2_0)
end

function var_0_0.onLoadCallback(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.assetItem

	arg_3_0.assetItem = arg_3_1

	local var_3_1 = arg_3_1.ResPath
	local var_3_2 = arg_3_1.IsLoadSuccess

	arg_3_1:Retain()

	if var_3_0 then
		var_3_0:Release()
	end

	if not var_3_2 then
		logError("资源加载失败,URL:" .. var_3_1)
	end

	if not arg_3_0.handle.IS_DISPOSED and arg_3_0.callback then
		arg_3_0.callback(arg_3_0.handle, var_3_2, arg_3_1, arg_3_0.param)
	end
end

function var_0_0.onDestructor(arg_4_0)
	removeAssetLoadCb(arg_4_0.url, arg_4_0.onLoadCallback, arg_4_0)

	if arg_4_0.assetItem then
		arg_4_0.assetItem:Release()
	end
end

return var_0_0
