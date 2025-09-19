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

	arg_2_0.ani = gohelper.onceAddComponent(arg_2_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:com_registFightEvent(FightEvent.OnExPointChange, arg_3_0.onExPointChange)
	arg_3_0:com_registFightEvent(FightEvent.UpdateExPoint, arg_3_0.onUpdateExPoint)
	arg_3_0:com_registFightEvent(FightEvent.AddPlayOperationData, arg_3_0.onAddPlayOperationData)
	arg_3_0:com_registFightEvent(FightEvent.CancelOperation, arg_3_0.onOpen)
	arg_3_0:com_registFightEvent(FightEvent.StageChanged, arg_3_0.onOpen)
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0.point, arg_5_0.index <= arg_5_0.entityData.exPoint)
	arg_5_0.ani:Play("idle", 0, 0)
end

function var_0_0.onAddPlayOperationData(arg_6_0, arg_6_1)
	if arg_6_1:isPlayCard() then
		local var_6_0 = arg_6_1.cardData

		if var_6_0.uid == arg_6_0.entityId and FightCardDataHelper.isBigSkill(var_6_0.skillId) then
			arg_6_0.ani:Play("loop", 0, 0)
		end
	end
end

function var_0_0.onExPointChange(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 ~= arg_7_0.entityId then
		return
	end

	gohelper.setActive(arg_7_0.point, arg_7_3 >= arg_7_0.index)

	if arg_7_2 ~= arg_7_3 then
		if arg_7_2 < arg_7_3 then
			if arg_7_2 < arg_7_0.index and arg_7_3 >= arg_7_0.index then
				arg_7_0.ani:Play("add", 0, 0)
			end
		elseif arg_7_3 < arg_7_0.index and arg_7_2 >= arg_7_0.index then
			arg_7_0.ani:Play("close", 0, 0)
		end
	end
end

function var_0_0.onUpdateExPoint(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 ~= arg_8_0.entityId then
		return
	end

	gohelper.setActive(arg_8_0.point, arg_8_0.index <= arg_8_0.entityData.exPoint)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
