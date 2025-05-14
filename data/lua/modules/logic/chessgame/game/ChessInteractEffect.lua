module("modules.logic.chessgame.game.ChessInteractEffect", package.seeall)

local var_0_0 = class("ChessInteractEffect")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
	arg_1_0.effectGoDict = {}
	arg_1_0.assetItemList = {}
	arg_1_0.loadedEffectTypeList = {}
end

function var_0_0.onAvatarLoaded(arg_2_0)
	local var_2_0 = arg_2_0._target.avatar.loader

	if not var_2_0 then
		return
	end

	arg_2_0.effectGoContainer = var_2_0:getInstGO()
end

function var_0_0.showEffect(arg_3_0, arg_3_1)
	arg_3_0.showEffectType = arg_3_1

	if not arg_3_0.effectGoDict[arg_3_0.showEffectType] then
		arg_3_0:loadEffect()

		return
	end

	arg_3_0:_realShowEffect()
end

function var_0_0._realShowEffect(arg_4_0)
	local var_4_0 = arg_4_0.effectGoDict[arg_4_0.showEffectType]

	gohelper.setActive(var_4_0, false)
	gohelper.setActive(var_4_0, true)
end

function var_0_0.loadEffect(arg_5_0)
	local var_5_0 = arg_5_0.showEffectType

	if tabletool.indexOf(arg_5_0.loadedEffectTypeList, var_5_0) then
		return
	end

	table.insert(arg_5_0.loadedEffectTypeList, var_5_0)

	local var_5_1 = ChessGameEnum.EffectPath[var_5_0]

	loadAbAsset(var_5_1, true, arg_5_0._onLoadCallback, arg_5_0)
end

function var_0_0._onLoadCallback(arg_6_0, arg_6_1)
	if arg_6_1.IsLoadSuccess then
		table.insert(arg_6_0.assetItemList, arg_6_1)
		arg_6_1:Retain()

		local var_6_0 = gohelper.clone(arg_6_1:GetResource(), arg_6_0.effectGoContainer)

		arg_6_0.effectGoDict[arg_6_0.showEffectType] = var_6_0

		gohelper.setActive(var_6_0, false)
		arg_6_0:showEffect(arg_6_0.showEffectType)
	end
end

function var_0_0.dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.loadedEffectTypeList) do
		removeAssetLoadCb(ChessGameEnum.EffectPath[iter_7_1], arg_7_0._onLoadCallback, arg_7_0)
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.assetItemList) do
		iter_7_3:Release()

		arg_7_0.assetItemList[iter_7_2] = nil
	end

	arg_7_0.assetItemList = {}

	for iter_7_4, iter_7_5 in pairs(arg_7_0.effectGoDict) do
		if not gohelper.isNil(iter_7_5) then
			gohelper.destroy(iter_7_5)
		end

		arg_7_0.effectGoDict[iter_7_4] = nil
	end

	arg_7_0.effectGoDict = {}
	arg_7_0._target = nil
	arg_7_0.effectGoContainer = nil
end

return var_0_0
