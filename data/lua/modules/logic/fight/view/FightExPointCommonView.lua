module("modules.logic.fight.view.FightExPointCommonView", package.seeall)

local var_0_0 = class("FightExPointCommonView", FightBaseView)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.entityData = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	return
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:com_registMsg(FightMsgId.GetExPointView, arg_3_0.onGetExPointView)
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0.onGetExPointView(arg_5_0, arg_5_1)
	if arg_5_1 == arg_5_0.entityData.id and arg_5_0.commonExPoint and not arg_5_0.commonExPoint:checkNeedShieldExPoint() then
		arg_5_0:com_replyMsg(FightMsgId.GetExPointView, arg_5_0)
	end
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = FightHelper.getEntity(arg_6_0.entityData.id)

	if not var_6_0 then
		return
	end

	arg_6_0.commonExPoint = FightNameUIExPointMgr.New()

	arg_6_0.commonExPoint:initMgr(arg_6_0.viewGO, var_6_0)
end

function var_0_0.onClose(arg_7_0)
	if arg_7_0.commonExPoint then
		arg_7_0.commonExPoint:beforeDestroy()
	end
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
