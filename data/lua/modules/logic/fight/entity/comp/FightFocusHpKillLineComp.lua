module("modules.logic.fight.entity.comp.FightFocusHpKillLineComp", package.seeall)

local var_0_0 = class("FightFocusHpKillLineComp", FightHpKillLineComp)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.loadStatus = FightHpKillLineComp.LoadStatus.NotLoaded
	arg_1_0.containerGo = arg_1_1
	arg_1_0.containerWidth = recthelper.getWidth(arg_1_0.containerGo:GetComponent(gohelper.Type_RectTransform))

	arg_1_0:loadRes()
end

function var_0_0.refreshByEntityMo(arg_2_0, arg_2_1)
	arg_2_0.entityMo = arg_2_1
	arg_2_0.entityId = arg_2_1.id

	arg_2_0:updateKillLine()
end

return var_0_0
