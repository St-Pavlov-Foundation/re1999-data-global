module("modules.logic.fight.view.FightNamePowerInfoView", package.seeall)

local var_0_0 = class("FightNamePowerInfoView", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entityId = arg_1_1
	arg_1_0.fightNameObj = arg_1_2
	arg_1_0.viewComp = arg_1_0:addComponent(FightViewComponent)
end

local var_0_1 = {
	[FightEnum.PowerType.Alert] = FightNamePowerInfoView6
}
local var_0_2 = {
	[FightEnum.PowerType.Alert] = "ui/viewres/fight/fightalertview.prefab"
}

function var_0_0.onAwake(arg_2_0)
	arg_2_0.entityData = FightDataHelper.entityMgr:getById(arg_2_0.entityId)

	if not arg_2_0.entityData then
		return
	end

	local var_2_0 = arg_2_0.entityData._powerInfos

	if var_2_0 then
		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			local var_2_1 = var_0_1[iter_2_0]

			if var_2_1 then
				local var_2_2 = var_0_2[iter_2_0]
				local var_2_3 = arg_2_0:getParentRoot(iter_2_0)

				arg_2_0.viewComp:openSubView(var_2_1, var_2_2, var_2_3, arg_2_0.entityId, iter_2_1)
			end
		end
	end
end

function var_0_0.getParentRoot(arg_3_0, arg_3_1)
	if arg_3_1 == FightEnum.PowerType.Alert then
		return (gohelper.create2d(arg_3_0.fightNameObj, "alertRoot"))
	end
end

function var_0_0.onDestructor(arg_4_0)
	return
end

return var_0_0
