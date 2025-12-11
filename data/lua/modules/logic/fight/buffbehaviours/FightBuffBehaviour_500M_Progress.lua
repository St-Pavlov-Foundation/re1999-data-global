module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_500M_Progress", package.seeall)

local var_0_0 = class("FightBuffBehaviour_500M_Progress", FightBuffBehaviourBase)
local var_0_1 = "ui/viewres/fight/fighttower/fightprogressview.prefab"

function var_0_0.onAddBuff(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.goRoot = gohelper.findChild(arg_1_0.viewGo, "root/topLeftContent")

	loadAbAsset(var_0_1, true, arg_1_0.onLoadFinish, arg_1_0)
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

	arg_2_0.goProgress = gohelper.clone(arg_2_1:GetResource(var_0_1), arg_2_0.goRoot)
end

function var_0_0.onRemoveBuff(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	gohelper.destroy(arg_3_0.goProgress)
end

function var_0_0.onDestroy(arg_4_0)
	if arg_4_0.assetItem then
		arg_4_0.assetItem:Release()

		arg_4_0.assetItem = nil
	end

	removeAssetLoadCb(var_0_1, arg_4_0.onLoadFinish, arg_4_0)
	var_0_0.super.onDestroy(arg_4_0)
end

return var_0_0
