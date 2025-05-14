module("modules.logic.investigate.controller.InvestigateController", package.seeall)

local var_0_0 = class("InvestigateController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_1_0._onLoginEnd, arg_1_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_1_0._onUpdateDungeonInfo, arg_1_0)
end

function var_0_0._onLoginEnd(arg_2_0)
	InvestigateModel.instance:refreshUnlock(true)
end

function var_0_0._onUpdateDungeonInfo(arg_3_0)
	InvestigateModel.instance:refreshUnlock()
end

function var_0_0.openInvestigateView(arg_4_0, arg_4_1)
	ViewMgr.instance:openView(ViewName.InvestigateView, arg_4_1)
end

function var_0_0.openInvestigateOpinionView(arg_5_0, arg_5_1)
	ViewMgr.instance:openView(ViewName.InvestigateOpinionView, arg_5_1)
end

function var_0_0.openInvestigateOpinionExtendView(arg_6_0, arg_6_1)
	ViewMgr.instance:openView(ViewName.InvestigateOpinionExtendView, arg_6_1)
end

function var_0_0.openInvestigateRoleStoryView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.InvestigateRoleStoryView, arg_7_1)
end

function var_0_0.openInvestigateTaskView(arg_8_0, arg_8_1)
	ViewMgr.instance:openView(ViewName.InvestigateTaskView, arg_8_1)
end

function var_0_0.openInvestigateTipsView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.InvestigateTipsView, arg_9_1)
end

function var_0_0.openInvestigateOpinionTabView(arg_10_0, arg_10_1)
	InvestigateOpinionModel.instance:setInfo(arg_10_1.mo, arg_10_1.moList)

	if InvestigateOpinionModel.instance:allOpinionLinked(arg_10_1.mo.id) then
		arg_10_1.defaultTabIds = {
			[2] = InvestigateEnum.OpinionTab.Extend
		}
	end

	ViewMgr.instance:openView(ViewName.InvestigateOpinionTabView, arg_10_1)
end

function var_0_0.jumpToInvestigateOpinionTabView(arg_11_0, arg_11_1)
	local var_11_0 = lua_investigate_info.configDict[arg_11_1]
	local var_11_1 = InvestigateConfig.instance:getRoleGroupInfoList(var_11_0.group)
	local var_11_2 = {
		mo = var_11_0
	}

	if #var_11_1 > 1 then
		var_11_2.moList = var_11_1
	end

	arg_11_0:openInvestigateOpinionTabView(var_11_2)
end

function var_0_0.hasOnceActionKey(arg_12_0, arg_12_1)
	local var_12_0 = string.format("%s%s_%s_%s", PlayerPrefsKey.InvestigateOnceAnim, PlayerModel.instance:getPlayinfo().userId, arg_12_0, arg_12_1)

	return PlayerPrefsHelper.hasKey(var_12_0)
end

function var_0_0.setOnceActionKey(arg_13_0, arg_13_1)
	local var_13_0 = string.format("%s%s_%s_%s", PlayerPrefsKey.InvestigateOnceAnim, PlayerModel.instance:getPlayinfo().userId, arg_13_0, arg_13_1)

	PlayerPrefsHelper.setNumber(var_13_0, 1)
end

function var_0_0.showClueRedDot(arg_14_0)
	local var_14_0 = InvestigateOpinionModel.instance:isUnlocked(arg_14_0)
	local var_14_1 = InvestigateOpinionModel.instance:getLinkedStatus(arg_14_0)

	if var_14_0 and not var_14_1 and not var_0_0.hasOnceActionKey(InvestigateEnum.OnceActionType.ReddotClue, arg_14_0) then
		return true
	end

	return false
end

function var_0_0.showInfoRedDot(arg_15_0)
	local var_15_0 = lua_investigate_info.configDict[arg_15_0]
	local var_15_1 = InvestigateConfig.instance:getRoleGroupInfoList(var_15_0.group)

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		local var_15_2 = InvestigateConfig.instance:getInvestigateRelatedClueInfos(iter_15_1.id)

		for iter_15_2, iter_15_3 in ipairs(var_15_2) do
			local var_15_3 = var_0_0.showClueRedDot(iter_15_3.id)

			if not InvestigateOpinionModel.instance:getLinkedStatus(iter_15_3.id) and var_15_3 then
				return true
			end
		end
	end

	return false
end

function var_0_0.showSingleInfoRedDot(arg_16_0)
	local var_16_0 = InvestigateConfig.instance:getInvestigateRelatedClueInfos(arg_16_0)

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = var_0_0.showClueRedDot(iter_16_1.id)

		if not InvestigateOpinionModel.instance:getLinkedStatus(iter_16_1.id) and var_16_1 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
