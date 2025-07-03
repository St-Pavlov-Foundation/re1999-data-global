module("modules.logic.fight.view.FightChangeHeroSelectSkillTargetView", package.seeall)

local var_0_0 = class("FightChangeHeroSelectSkillTargetView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._block = gohelper.findChildClick(arg_1_0.viewGO, "block")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._block, arg_2_0._onBlock, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ChangeSubHeroExSkillReply, arg_2_0._onChangeSubHeroExSkillReply, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.ChangeSubHeroExSkillReply, arg_3_0._onChangeSubHeroExSkillReply, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onCloseViewFinish(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.FightSkillTargetView then
		arg_5_0:closeThis()
	end
end

function var_0_0._onChangeSubHeroExSkillReply(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._onBtnEsc(arg_7_0)
	return
end

function var_0_0._onBlock(arg_8_0)
	arg_8_0._clickCounter = arg_8_0._clickCounter + 1

	if arg_8_0._clickCounter >= 5 then
		arg_8_0:closeThis()
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._clickCounter = 0

	NavigateMgr.instance:addEscape(arg_9_0.viewContainer.viewName, arg_9_0._onBtnEsc, arg_9_0)

	local var_9_0 = arg_9_0.viewParam.skillConfig
	local var_9_1 = arg_9_0.viewParam.fromId

	if FightEnum.ShowLogicTargetView[var_9_0.logicTarget] and var_9_0.targetLimit == FightEnum.TargetLimit.MySide then
		local var_9_2 = FightDataHelper.entityMgr:getMyNormalList()
		local var_9_3 = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
		local var_9_4 = #var_9_2 + #var_9_3

		if var_9_4 > 1 then
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				mustSelect = true,
				fromId = var_9_1,
				skillId = var_9_0.id,
				callback = arg_9_0._onChangeHeroSkillSelected,
				callbackObj = arg_9_0
			})
		elseif var_9_4 == 1 then
			local var_9_5 = #var_9_2 > 0 and var_9_2 or var_9_3

			FightRpc.instance:sendChangeSubHeroExSkillRequest(var_9_5[1].id)
		else
			arg_9_0:closeThis()
		end
	else
		FightRpc.instance:sendChangeSubHeroExSkillRequest(FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function var_0_0._onChangeHeroSkillSelected(arg_10_0, arg_10_1)
	FightRpc.instance:sendChangeSubHeroExSkillRequest(arg_10_1)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
