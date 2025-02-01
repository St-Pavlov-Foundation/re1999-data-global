module("modules.logic.investigate.controller.InvestigateController", package.seeall)

slot0 = class("InvestigateController", BaseController)

function slot0.addConstEvents(slot0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, slot0._onLoginEnd, slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
end

function slot0._onLoginEnd(slot0)
	InvestigateModel.instance:refreshUnlock(true)
end

function slot0._onUpdateDungeonInfo(slot0)
	InvestigateModel.instance:refreshUnlock()
end

function slot0.openInvestigateView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.InvestigateView, slot1)
end

function slot0.openInvestigateOpinionView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.InvestigateOpinionView, slot1)
end

function slot0.openInvestigateOpinionExtendView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.InvestigateOpinionExtendView, slot1)
end

function slot0.openInvestigateRoleStoryView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.InvestigateRoleStoryView, slot1)
end

function slot0.openInvestigateTaskView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.InvestigateTaskView, slot1)
end

function slot0.openInvestigateTipsView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.InvestigateTipsView, slot1)
end

function slot0.openInvestigateOpinionTabView(slot0, slot1)
	InvestigateOpinionModel.instance:setInfo(slot1.mo, slot1.moList)

	if InvestigateOpinionModel.instance:allOpinionLinked(slot1.mo.id) then
		slot1.defaultTabIds = {
			[2] = InvestigateEnum.OpinionTab.Extend
		}
	end

	ViewMgr.instance:openView(ViewName.InvestigateOpinionTabView, slot1)
end

function slot0.jumpToInvestigateOpinionTabView(slot0, slot1)
	slot2 = lua_investigate_info.configDict[slot1]

	if #InvestigateConfig.instance:getRoleGroupInfoList(slot2.group) > 1 then
		-- Nothing
	end

	slot0:openInvestigateOpinionTabView({
		mo = slot2,
		moList = slot3
	})
end

function slot0.hasOnceActionKey(slot0, slot1)
	return PlayerPrefsHelper.hasKey(string.format("%s%s_%s_%s", PlayerPrefsKey.InvestigateOnceAnim, PlayerModel.instance:getPlayinfo().userId, slot0, slot1))
end

function slot0.setOnceActionKey(slot0, slot1)
	PlayerPrefsHelper.setNumber(string.format("%s%s_%s_%s", PlayerPrefsKey.InvestigateOnceAnim, PlayerModel.instance:getPlayinfo().userId, slot0, slot1), 1)
end

function slot0.showClueRedDot(slot0)
	if InvestigateOpinionModel.instance:isUnlocked(slot0) and not InvestigateOpinionModel.instance:getLinkedStatus(slot0) and not uv0.hasOnceActionKey(InvestigateEnum.OnceActionType.ReddotClue, slot0) then
		return true
	end

	return false
end

function slot0.showInfoRedDot(slot0)
	for slot6, slot7 in ipairs(InvestigateConfig.instance:getRoleGroupInfoList(lua_investigate_info.configDict[slot0].group)) do
		for slot12, slot13 in ipairs(InvestigateConfig.instance:getInvestigateRelatedClueInfos(slot7.id)) do
			if not InvestigateOpinionModel.instance:getLinkedStatus(slot13.id) and uv0.showClueRedDot(slot13.id) then
				return true
			end
		end
	end

	return false
end

function slot0.showSingleInfoRedDot(slot0)
	for slot5, slot6 in ipairs(InvestigateConfig.instance:getInvestigateRelatedClueInfos(slot0)) do
		if not InvestigateOpinionModel.instance:getLinkedStatus(slot6.id) and uv0.showClueRedDot(slot6.id) then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
