module("modules.logic.gm.view.GMHelpViewBrowseItem", package.seeall)

slot0 = class("GMHelpViewBrowseItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._guideCO = nil
	slot0._txtPageId = gohelper.findChildText(slot1, "txtPageID")
	slot0._txtPageName = gohelper.findChildText(slot1, "txtPageName")
	slot0._btnShow = gohelper.findChildButtonWithAudio(slot1, "btnShow")

	slot0._btnShow:AddClickListener(slot0._onClickShow, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._pageCO = slot1
	slot0._configId = slot1.id
	slot0._txtPageId.text = slot0._configId
	slot0._txtPageName.text = slot0._pageCO.icon
end

function slot0._onClickShow(slot0)
	if GMHelpViewBrowseModel.instance:getCurrentTabMode() == GMHelpViewBrowseModel.tabModeEnum.helpView then
		ViewMgr.instance:openView(ViewName.HelpView, {
			pageId = slot0._configId
		})
	elseif slot1 == slot2.fightGuideView then
		ViewMgr.instance:openView(ViewName.FightGuideView, {
			viewParam = {
				slot0._configId
			}
		})
	elseif slot1 == slot2.fightTechniqueView then
		ViewMgr.instance:openView(ViewName.FightTechniqueView, {
			isGMShowAll = true,
			defaultShowId = slot0._configId
		})
	elseif slot1 == slot2.fightTechniqueTipView then
		ViewMgr.instance:openView(ViewName.FightTechniqueTipsView, {
			isGMShow = true,
			config = lua_fight_technique.configDict[slot0._configId]
		})
	elseif slot1 == slot2.fightTechniqueGuide then
		ViewMgr.instance:openView(ViewName.FightTechniqueGuideView, {
			modelId = slot0._pageCO.cfg.monster,
			config = slot0._pageCO.cfg
		})
	elseif slot1 == slot2.weekWalkRuleView then
		WeekWalkController.instance:openWeekWalkRuleView({
			issueId = slot0._configId
		})
	else
		logError("GMHelpViewBrowseItem:_onClickShow错误，tabMode对应处理未定义：" .. slot1)

		return
	end
end

function slot0.onDestroy(slot0)
	slot0._btnShow:RemoveClickListener()
end

return slot0
