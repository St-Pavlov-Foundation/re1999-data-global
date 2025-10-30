module("modules.logic.fight.entity.comp.FightBossHpKillLineComp", package.seeall)

local var_0_0 = class("FightBossHpKillLineComp", FightHpKillLineComp)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.loadStatus = FightHpKillLineComp.LoadStatus.NotLoaded
	arg_1_0.containerGo = arg_1_1
	arg_1_0.containerWidth = recthelper.getWidth(arg_1_0.containerGo:GetComponent(gohelper.Type_RectTransform))

	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0.onBuffUpdate, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.UpdateBuffActInfo, arg_1_0.onUpdateBuffActInfo, arg_1_0)
end

function var_0_0.refreshByEntityMo(arg_2_0, arg_2_1)
	if not arg_2_1 then
		arg_2_0.entityMo = nil
		arg_2_0.entityId = nil

		arg_2_0:updateKillLine()

		return
	end

	arg_2_0.entityMo = arg_2_1
	arg_2_0.entityId = arg_2_1.id

	if arg_2_0.loadStatus == FightHpKillLineComp.LoadStatus.Loaded then
		arg_2_0:updateKillLine()

		return
	end

	if arg_2_0.loadStatus == FightHpKillLineComp.LoadStatus.NotLoaded then
		arg_2_0:loadRes()

		return
	end
end

return var_0_0
