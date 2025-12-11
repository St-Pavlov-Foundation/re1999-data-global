module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_500M_RemoveActPoint", package.seeall)

local var_0_0 = class("FightBuffBehaviour_500M_RemoveActPoint", FightBuffBehaviourBase)
local var_0_1 = "ui/viewres/fight/fighttower/fightcardremoveview.prefab"

function var_0_0.onAddBuff(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	FightModel.instance:setNeedPlay500MRemoveActEffect(true)
	loadAbAsset(arg_1_0.co.param, true, arg_1_0.onLoadFinish, arg_1_0)
end

function var_0_0.onLoadFinish(arg_2_0, arg_2_1)
	if not arg_2_1.IsLoadSuccess then
		return
	end

	local var_2_0 = arg_2_0.assetItem

	arg_2_0.assetItem = arg_2_1

	arg_2_1:Retain()

	if var_2_0 then
		var_2_0:Release()
	end

	arg_2_0.goRemoveEffect = gohelper.clone(arg_2_1:GetResource(arg_2_0.co.param), arg_2_0.viewGo)

	gohelper.setActive(arg_2_0.goRemoveEffect, false)
	FightModel.instance:setRemoveActEffectObj(arg_2_0)
end

function var_0_0.onRemoveBuff(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	FightModel.instance:setRemoveActEffectObj(nil)
	FightModel.instance:setNeedPlay500MRemoveActEffect(nil)
end

function var_0_0.getRemoveEffectGo(arg_4_0)
	return arg_4_0.goRemoveEffect
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0.assetItem then
		arg_5_0.assetItem:Release()

		arg_5_0.assetItem = nil
	end

	removeAssetLoadCb(arg_5_0.co.param, arg_5_0.onLoadFinish, arg_5_0)
	FightModel.instance:setRemoveActEffectObj(nil)
	FightModel.instance:setNeedPlay500MRemoveActEffect(nil)
	var_0_0.super.onDestroy(arg_5_0)
end

return var_0_0
