module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_ForceAuto", package.seeall)

local var_0_0 = class("FightBuffBehaviour_ForceAuto", FightBuffBehaviourBase)
local var_0_1 = "ui/viewres/fight/fighttower/fightautobtnlockview.prefab"
local var_0_2 = 3

function var_0_0.onAddBuff(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.btnRoot = gohelper.findChild(arg_1_0.viewGo, "root/btns")
	arg_1_0.srcAutoBtn = gohelper.findChild(arg_1_0.viewGo, "root/btns/btnAuto")
	arg_1_0.loader = PrefabInstantiate.Create(arg_1_0.btnRoot)

	arg_1_0.loader:startLoad(var_0_1, arg_1_0.onLoadFinish, arg_1_0)
	FightDataHelper.stateMgr:setBuffForceAuto(true)
	FightGameMgr.operateMgr:requestAutoFight()
	AudioMgr.instance:trigger(310004)
end

function var_0_0.onLoadFinish(arg_2_0)
	arg_2_0.autoBtn = arg_2_0.loader:getInstGO()

	gohelper.setSibling(arg_2_0.autoBtn, var_0_2)
	gohelper.setActive(arg_2_0.srcAutoBtn, false)
	gohelper.setActive(arg_2_0.autoBtn, true)
end

function var_0_0.onUpdateBuff(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	return
end

function var_0_0.onRemoveBuff(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	gohelper.destroy(arg_4_0.autoBtn)
	gohelper.setActive(arg_4_0.srcAutoBtn, true)
	FightDataHelper.stateMgr:setBuffForceAuto(false)
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0.loader then
		arg_5_0.loader:dispose()

		arg_5_0.loader = nil
	end

	FightDataHelper.stateMgr:setBuffForceAuto(false)
	var_0_0.super.onDestroy(arg_5_0)
end

return var_0_0
