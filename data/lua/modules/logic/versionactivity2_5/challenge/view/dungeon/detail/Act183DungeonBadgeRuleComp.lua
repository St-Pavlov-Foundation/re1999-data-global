module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBadgeRuleComp", package.seeall)

local var_0_0 = class("Act183DungeonBadgeRuleComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._gobadgeruleitem = gohelper.findChild(arg_1_0.go, "#go_badgeruleitem")
	arg_1_0._badgeRuleItemTab = arg_1_0:getUserDataTb_()

	arg_1_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateSelectBadgeNum, arg_1_0._onUpdateSelectBadgeNum, arg_1_0)
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	var_0_0.super.updateInfo(arg_4_0, arg_4_1)

	arg_4_0._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(arg_4_0._episodeId)
	arg_4_0._useBadgeNum = arg_4_0._episodeMo:getUseBadgeNum()
	arg_4_0._readyUseBadgeNum = arg_4_0._useBadgeNum or 0
	arg_4_0._isNeedPlayBadgeAnim = false
end

function var_0_0.checkIsVisible(arg_5_0)
	return arg_5_0._readyUseBadgeNum > 0
end

function var_0_0.show(arg_6_0)
	var_0_0.super.show(arg_6_0)

	local var_6_0 = Act183Config.instance:getBadgeCo(arg_6_0._activityId, arg_6_0._readyUseBadgeNum)

	arg_6_0:createObjList({
		var_6_0
	}, arg_6_0._badgeRuleItemTab, arg_6_0._gobadgeruleitem, arg_6_0._initBadgeRuleItemFunc, arg_6_0._refreshBadgeRuleItemFunc, arg_6_0._defaultItemFreeFunc)
end

function var_0_0._initBadgeRuleItemFunc(arg_7_0, arg_7_1)
	arg_7_1.txtdesc = gohelper.findChildText(arg_7_1.go, "txt_desc")
	arg_7_1.anim = gohelper.onceAddComponent(arg_7_1.go, gohelper.Type_Animator)

	SkillHelper.addHyperLinkClick(arg_7_1.txtdesc)
end

function var_0_0._refreshBadgeRuleItemFunc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_1.txtdesc.text = SkillHelper.buildDesc(arg_8_2.decs)

	if arg_8_0._isNeedPlayBadgeAnim then
		arg_8_1.anim:Play("in", 0, 0)
	end
end

function var_0_0._onUpdateSelectBadgeNum(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._episodeId ~= arg_9_1 then
		return
	end

	arg_9_0._readyUseBadgeNum = arg_9_2
	arg_9_0._isNeedPlayBadgeAnim = true

	arg_9_0.container:refresh()
	arg_9_0.container.mgr:focus(Act183DungeonBaseAndBadgeRuleComp)
end

function var_0_0.onDestroy(arg_10_0)
	var_0_0.super.onDestroy(arg_10_0)
end

return var_0_0
