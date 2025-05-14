module("modules.logic.fight.view.FightSeasonChangeHeroSelectView", package.seeall)

local var_0_0 = class("FightSeasonChangeHeroSelectView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._block = gohelper.findChildClick(arg_1_0.viewGO, "block")
	arg_1_0._blockTransform = arg_1_0._block:GetComponent(gohelper.Type_RectTransform)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._block, arg_2_0._onBlock, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ReceiveChangeSubHeroReply, arg_2_0._onReceiveChangeSubHeroReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.ReceiveChangeSubHeroReply, arg_3_0._onReceiveChangeSubHeroReply, arg_3_0)
end

function var_0_0._onReceiveChangeSubHeroReply(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._onBlock(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)
	local var_5_1 = FightSkillSelectView.getClickEntity(var_5_0, arg_5_0._blockTransform, arg_5_2)

	if var_5_1 then
		if not FightDataHelper.entityMgr:getById(var_5_1) then
			return
		end

		if arg_5_0._curSelectId == var_5_1 then
			FightRpc.instance:sendChangeSubHeroRequest(arg_5_0._changeId, var_5_1)
		else
			arg_5_0._curSelectId = var_5_1

			FightController.instance:dispatchEvent(FightEvent.SeasonSelectChangeHeroTarget, arg_5_0._curSelectId)
		end

		return
	end

	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)

	arg_6_0._curSelectId = nil
	arg_6_0._changeId = arg_6_0.viewParam
end

function var_0_0.onClose(arg_7_0)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
