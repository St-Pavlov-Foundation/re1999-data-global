module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_500M_BGMask", package.seeall)

local var_0_0 = class("FightBuffBehaviour_500M_BGMask", FightBuffBehaviourBase)
local var_0_1 = "ui/viewres/fight/fighttower/fightmaskview.prefab"

function var_0_0.onAddBuff(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.root = gohelper.findChild(arg_1_0.viewGo, "root")

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

	arg_2_0.bgMask = gohelper.clone(arg_2_1:GetResource(var_0_1), arg_2_0.root)
	arg_2_0.animator = arg_2_0.bgMask:GetComponent(gohelper.Type_Animator)
	arg_2_0.simageBg = gohelper.findChildSingleImage(arg_2_0.bgMask, "stage")

	gohelper.setAsFirstSibling(arg_2_0.bgMask)
	arg_2_0:refreshStage()
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnMonsterChange, arg_2_0.onMonsterChange, arg_2_0)
end

function var_0_0.onMonsterChange(arg_3_0)
	arg_3_0:refreshStage()
end

function var_0_0.refreshStage(arg_4_0)
	local var_4_0 = FightHelper.getBossCurStageCo_500M()

	if var_4_0 == arg_4_0.preCo then
		return
	end

	arg_4_0.preCo = var_4_0

	gohelper.setActive(arg_4_0.bgMask, var_4_0 ~= nil)

	if var_4_0 then
		arg_4_0.simageBg:UnLoadImage()
		arg_4_0.simageBg:LoadImage(string.format("singlebg/fight/tower/%s", var_4_0.param2))
		arg_4_0.animator:Play("open", 0, 0)
		AudioMgr.instance:trigger(310009)
	end
end

function var_0_0.onRemoveBuff(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	gohelper.destroy(arg_5_0.bgMask)
end

function var_0_0.onDestroy(arg_6_0)
	if arg_6_0.simageBg then
		arg_6_0.simageBg:UnLoadImage()
	end

	if arg_6_0.assetItem then
		arg_6_0.assetItem:Release()

		arg_6_0.assetItem = nil
	end

	removeAssetLoadCb(var_0_1, arg_6_0.onLoadFinish, arg_6_0)
	var_0_0.super.onDestroy(arg_6_0)
end

return var_0_0
