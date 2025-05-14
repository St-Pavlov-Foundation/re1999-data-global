module("modules.logic.gm.view.GMHelpViewBrowseItem", package.seeall)

local var_0_0 = class("GMHelpViewBrowseItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._guideCO = nil
	arg_1_0._txtPageId = gohelper.findChildText(arg_1_1, "txtPageID")
	arg_1_0._txtPageName = gohelper.findChildText(arg_1_1, "txtPageName")
	arg_1_0._btnShow = gohelper.findChildButtonWithAudio(arg_1_1, "btnShow")

	arg_1_0._btnShow:AddClickListener(arg_1_0._onClickShow, arg_1_0)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._pageCO = arg_2_1
	arg_2_0._configId = arg_2_1.id
	arg_2_0._txtPageId.text = arg_2_0._configId
	arg_2_0._txtPageName.text = arg_2_0._pageCO.icon
end

function var_0_0._onClickShow(arg_3_0)
	local var_3_0 = GMHelpViewBrowseModel.instance:getCurrentTabMode()
	local var_3_1 = GMHelpViewBrowseModel.tabModeEnum

	if var_3_0 == var_3_1.helpView then
		ViewMgr.instance:openView(ViewName.HelpView, {
			pageId = arg_3_0._configId
		})
	elseif var_3_0 == var_3_1.fightGuideView then
		ViewMgr.instance:openView(ViewName.FightGuideView, {
			viewParam = {
				arg_3_0._configId
			}
		})
	elseif var_3_0 == var_3_1.fightTechniqueView then
		ViewMgr.instance:openView(ViewName.FightTechniqueView, {
			isGMShowAll = true,
			defaultShowId = arg_3_0._configId
		})
	elseif var_3_0 == var_3_1.fightTechniqueTipView then
		local var_3_2 = lua_fight_technique.configDict[arg_3_0._configId]

		ViewMgr.instance:openView(ViewName.FightTechniqueTipsView, {
			isGMShow = true,
			config = var_3_2
		})
	elseif var_3_0 == var_3_1.fightTechniqueGuide then
		ViewMgr.instance:openView(ViewName.FightTechniqueGuideView, {
			modelId = arg_3_0._pageCO.cfg.monster,
			config = arg_3_0._pageCO.cfg
		})
	elseif var_3_0 == var_3_1.weekWalkRuleView then
		WeekWalkController.instance:openWeekWalkRuleView({
			issueId = arg_3_0._configId
		})
	else
		logError("GMHelpViewBrowseItem:_onClickShow错误，tabMode对应处理未定义：" .. var_3_0)

		return
	end
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0._btnShow:RemoveClickListener()
end

return var_0_0
