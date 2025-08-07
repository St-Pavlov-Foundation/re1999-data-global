module("modules.logic.fight.view.FightExPointBeliefItemView", package.seeall)

local var_0_0 = class("FightExPointBeliefItemView", FightBaseView)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.index = arg_1_1
	arg_1_0.entityData = arg_1_2
	arg_1_0.entityId = arg_1_2.id

	local var_1_0 = (arg_1_1 - 1) % 8 + 1

	arg_1_0.bgName = string.format("fight_nuodika_fuwen_%d_0", var_1_0)
	arg_1_0.pointName = string.format("fight_nuodika_fuwen_%d_1", var_1_0)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.bg = gohelper.findChildImage(arg_2_0.viewGO, "empty")
	arg_2_0.point = gohelper.findChildImage(arg_2_0.viewGO, "full")

	UISpriteSetMgr.instance:setFightSprite(arg_2_0.bg, arg_2_0.bgName)
	UISpriteSetMgr.instance:setFightSprite(arg_2_0.point, arg_2_0.pointName)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:com_registFightEvent(FightEvent.OnExPointChange, arg_3_0.onExPointChange)
	arg_3_0:com_registFightEvent(FightEvent.UpdateExPoint, arg_3_0.onUpdateExPoint)
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0.point, arg_5_0.index <= arg_5_0.entityData.exPoint)
end

function var_0_0.onExPointChange(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 ~= arg_6_0.entityId then
		return
	end

	gohelper.setActive(arg_6_0.point, arg_6_3 >= arg_6_0.index)
end

function var_0_0.onUpdateExPoint(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 ~= arg_7_0.entityId then
		return
	end

	gohelper.setActive(arg_7_0.point, arg_7_0.index <= arg_7_0.entityData.exPoint)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
