module("modules.logic.fight.view.FightViewMultiBossHp", package.seeall)

local var_0_0 = class("FightViewMultiBossHp", FightViewBossHp)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._ani = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)

	arg_1_0._ani:Play("idle", nil, nil)
end

function var_0_0.onConstructor(arg_2_0, arg_2_1)
	arg_2_0._entityId = arg_2_1
end

function var_0_0._checkBossAndUpdate(arg_3_0)
	arg_3_0._bossEntityMO = arg_3_0:_getBossEntityMO()

	if arg_3_0._bossEntityMO then
		gohelper.setActive(arg_3_0.viewGO, true)
		gohelper.setActive(arg_3_0._bossHpGO, true)
		arg_3_0:_refreshBossHpUI()
	end
end

function var_0_0._onEntityDead(arg_4_0, arg_4_1)
	if arg_4_0._bossEntityMO and arg_4_0._bossEntityMO.id == arg_4_1 then
		arg_4_0._bossEntityMO = nil

		arg_4_0:_tweenFillAmount()
		arg_4_0._ani:Play("die", nil, nil)
	end
end

function var_0_0._getBossEntityMO(arg_5_0)
	return FightDataHelper.entityMgr:getById(arg_5_0._entityId)
end

return var_0_0
