module("modules.logic.fight.view.FightExPointView", package.seeall)

local var_0_0 = class("FightExPointView", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entityId = arg_1_1
	arg_1_0.fightNameObj = arg_1_2
	arg_1_0.containerObj = gohelper.findChild(arg_1_0.fightNameObj, "expointContainer")
	arg_1_0.viewComp = arg_1_0:addComponent(FightViewComponent)
end

local var_0_1 = {
	[FightEnum.ExPointType.Common] = FightExPointCommonView,
	[FightEnum.ExPointType.Belief] = FightExPointBeliefView,
	[FightEnum.ExPointType.Synchronization] = FightExPointSynchronizationView,
	[FightEnum.ExPointType.Adrenaline] = FightExPointAdrenalineView
}
local var_0_2 = {
	[FightEnum.ExPointType.Belief] = "ui/viewres/fight/fight_nuodika_energyview.prefab",
	[FightEnum.ExPointType.Synchronization] = "ui/viewres/fight/fightaijiaoenergeyview.prefab",
	[FightEnum.ExPointType.Adrenaline] = "ui/viewres/fight/fight_expoint_adrenalineview.prefab"
}

function var_0_0.onLogicEnter(arg_2_0)
	arg_2_0.entityData = FightDataHelper.entityMgr:getById(arg_2_0.entityId)

	if not arg_2_0.entityData then
		return
	end

	local var_2_0 = arg_2_0.entityData.exPointType

	if var_2_0 ~= FightEnum.ExPointType.Common then
		local var_2_1 = arg_2_0.containerObj.transform

		for iter_2_0 = 0, var_2_1.childCount - 1 do
			local var_2_2 = var_2_1:GetChild(iter_2_0)

			gohelper.setActive(var_2_2.gameObject, false)
		end
	end

	local var_2_3 = var_0_1[var_2_0]

	if var_2_3 then
		local var_2_4 = var_0_2[var_2_0] or arg_2_0.containerObj

		arg_2_0.viewComp:openSubView(var_2_3, var_2_4, arg_2_0.containerObj, arg_2_0.entityData)
	end
end

function var_0_0.onDestructor(arg_3_0)
	return
end

return var_0_0
