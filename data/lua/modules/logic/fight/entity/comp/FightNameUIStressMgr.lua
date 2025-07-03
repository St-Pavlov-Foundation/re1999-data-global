module("modules.logic.fight.entity.comp.FightNameUIStressMgr", package.seeall)

local var_0_0 = class("FightNameUIStressMgr", UserDataDispose)

var_0_0.HeroDefaultIdentityId = 1001
var_0_0.UiType = {
	Act183 = 1,
	Normal = 0
}
var_0_0.UiType2PrefabPath = {
	[var_0_0.UiType.Normal] = "ui/viewres/fight/fightstressitem.prefab",
	[var_0_0.UiType.Act183] = "ui/viewres/fight/fightstressitem2.prefab"
}
var_0_0.UiType2Behaviour = {
	[var_0_0.UiType.Normal] = StressNormalBehavior,
	[var_0_0.UiType.Act183] = StressAct183Behavior
}

function var_0_0.initMgr(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.goStress = arg_1_1
	arg_1_0.entity = arg_1_2
	arg_1_0.entityId = arg_1_0.entity.id

	arg_1_0:loadPrefab()
end

function var_0_0.loadPrefab(arg_2_0)
	arg_2_0.uiType = FightStressHelper.getStressUiType(arg_2_0.entityId)

	local var_2_0 = var_0_0.UiType2PrefabPath[arg_2_0.uiType] or var_0_0.UiType2PrefabPath[var_0_0.UiType.Normal]

	arg_2_0.loader = PrefabInstantiate.Create(arg_2_0.goStress)

	arg_2_0.loader:startLoad(var_2_0, arg_2_0.onLoadFinish, arg_2_0)
end

function var_0_0.onLoadFinish(arg_3_0)
	arg_3_0.instanceGo = arg_3_0.loader:getInstGO()
	arg_3_0.stressBehavior = (var_0_0.UiType2Behaviour[arg_3_0.uiType] or StressNormalBehavior).New()

	arg_3_0.stressBehavior:init(arg_3_0.instanceGo, arg_3_0.entity)
end

function var_0_0.beforeDestroy(arg_4_0)
	if arg_4_0.stressBehavior then
		arg_4_0.stressBehavior:beforeDestroy()
	end

	arg_4_0.loader:dispose()

	arg_4_0.loader = nil

	arg_4_0:__onDispose()
end

return var_0_0
