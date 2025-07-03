module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonEscapeRuleComp", package.seeall)

local var_0_0 = class("Act183DungeonEscapeRuleComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._goescaperuleitem = gohelper.findChild(arg_1_0.go, "#go_escaperules/#go_escaperuleitem")
	arg_1_0._escapeRuleItemTab = arg_1_0:getUserDataTb_()
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	var_0_0.super.updateInfo(arg_4_0, arg_4_1)

	arg_4_0._escapeRules = arg_4_0._groupEpisodeMo:getEscapeRules(arg_4_0._episodeId)
	arg_4_0._maxPassOrder = arg_4_0._groupEpisodeMo:findMaxPassOrder()
end

function var_0_0.checkIsVisible(arg_5_0)
	return arg_5_0._escapeRules and #arg_5_0._escapeRules > 0
end

function var_0_0.show(arg_6_0)
	var_0_0.super.show(arg_6_0)

	arg_6_0._hasPlayRefreshAnimRuleIds = Act183Helper.getHasPlayRefreshAnimRuleIdsInLocal(arg_6_0._episodeId)
	arg_6_0._hasPlayRefreshAnimRuleIdMap = Act183Helper.listToMap(arg_6_0._hasPlayRefreshAnimRuleIds)
	arg_6_0._needFocusEscapeRule = false
	arg_6_0._needFocusMinRuleIndex = 100

	arg_6_0:createObjList(arg_6_0._escapeRules, arg_6_0._escapeRuleItemTab, arg_6_0._goescaperuleitem, arg_6_0._initEscapeRuleItemFunc, arg_6_0._refreshEscapeRuleItemFunc, arg_6_0._defaultItemFreeFunc)

	if arg_6_0._needFocusEscapeRule then
		arg_6_0.mgr:focus(var_0_0, arg_6_0._needFocusMinRuleIndex)
	end

	Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(arg_6_0._episodeId, arg_6_0._hasPlayRefreshAnimRuleIds)
end

function var_0_0._initEscapeRuleItemFunc(arg_7_0, arg_7_1)
	arg_7_1.txtdesc = gohelper.findChildText(arg_7_1.go, "txt_desc")
	arg_7_1.imageicon = gohelper.findChildImage(arg_7_1.go, "image_icon")
	arg_7_1.anim = gohelper.onceAddComponent(arg_7_1.go, gohelper.Type_Animator)

	SkillHelper.addHyperLinkClick(arg_7_1.txtdesc)
end

function var_0_0._refreshEscapeRuleItemFunc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2.episodeId
	local var_8_1 = arg_8_2.ruleIndex

	arg_8_1.txtdesc.text = SkillHelper.buildDesc(arg_8_2.ruleDesc)

	Act183Helper.setRuleIcon(var_8_0, var_8_1, arg_8_1.imageicon)

	local var_8_2 = arg_8_0._maxPassOrder and arg_8_2.passOrder == arg_8_0._maxPassOrder
	local var_8_3 = string.format("%s_%s", var_8_0, var_8_1)
	local var_8_4 = arg_8_0._hasPlayRefreshAnimRuleIdMap[var_8_3] ~= nil
	local var_8_5 = var_8_2 and not var_8_4

	arg_8_1.anim:Play(var_8_5 and "in" or "idle", 0, 0)

	if var_8_5 then
		arg_8_0._hasPlayRefreshAnimRuleIdMap[var_8_3] = true

		table.insert(arg_8_0._hasPlayRefreshAnimRuleIds, var_8_3)

		arg_8_0._needFocusEscapeRule = true
		arg_8_0._needFocusMinRuleIndex = arg_8_3 < arg_8_0._needFocusMinRuleIndex and arg_8_3 or arg_8_0._needFocusMinRuleIndex
	end
end

function var_0_0.focus(arg_9_0, arg_9_1)
	local var_9_0 = 0

	arg_9_1 = arg_9_1 or 1

	if not arg_9_0._escapeRuleItemTab[arg_9_1] then
		return var_9_0
	end

	for iter_9_0 = 1, #arg_9_0._escapeRuleItemTab do
		if arg_9_1 <= iter_9_0 then
			break
		end

		local var_9_1 = arg_9_0._escapeRuleItemTab[iter_9_0].go

		var_9_0 = var_9_0 + recthelper.getHeight(var_9_1.transform)
	end

	return var_9_0
end

function var_0_0.onDestroy(arg_10_0)
	var_0_0.super.onDestroy(arg_10_0)
end

return var_0_0
