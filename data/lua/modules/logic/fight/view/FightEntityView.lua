module("modules.logic.fight.view.FightEntityView", package.seeall)

local var_0_0 = class("FightEntityView", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entityId = arg_1_1
	arg_1_0.entityData = FightDataHelper.entityMgr:getById(arg_1_1)
	arg_1_0.fightNameObj = arg_1_2
	arg_1_0.viewComp = arg_1_0:addComponent(FightViewComponent)
end

function var_0_0.onLogicEnter(arg_2_0)
	arg_2_0:showEnemyAiUseCardView()
end

function var_0_0.showEnemyAiUseCardView(arg_3_0)
	local var_3_0 = gohelper.findChild(arg_3_0.fightNameObj, "layout/top/op")

	if arg_3_0.entityData:isEnemySide() then
		arg_3_0.viewComp:openSubView(FightEnemyEntityAiUseCardView, var_3_0, nil, arg_3_0.entityData)
	else
		gohelper.setActive(var_3_0, false)
	end
end

function var_0_0.onDestructor(arg_4_0)
	return
end

return var_0_0
