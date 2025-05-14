module("modules.logic.weekwalk.view.WeekWalkRuleView", package.seeall)

local var_0_0 = class("WeekWalkRuleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "rule/#go_ruleitem")
	arg_1_0._goruleDescList = gohelper.findChild(arg_1_0.viewGO, "rule/#go_ruleDescList")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gotxt = gohelper.findChild(arg_1_0.viewGO, "#go_txt")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
end

var_0_0.NeedIgnoreLang = {
	"zh",
	"tw"
}

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._childGoList = arg_5_0:getUserDataTb_()
	arg_5_0._rulesimagelineList = arg_5_0:getUserDataTb_()
	arg_5_0._info = WeekWalkModel.instance:getInfo()

	arg_5_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/guize_beijing.jpg"))
end

function var_0_0.onUpdateParam(arg_6_0)
	if arg_6_0._rulesimagelineList then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._rulesimagelineList) do
			rawset(arg_6_0._rulesimagelineList, iter_6_0, nil)
		end
	end

	if arg_6_0._childGoList then
		for iter_6_2, iter_6_3 in pairs(arg_6_0._childGoList) do
			gohelper.destroy(iter_6_3)
			rawset(arg_6_0._childGoList, iter_6_2, nil)
		end
	end

	arg_6_0:_refreshView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_refreshView()
end

function var_0_0._refreshView(arg_8_0)
	local var_8_0

	if arg_8_0.viewParam then
		var_8_0 = arg_8_0.viewParam.issueId
	elseif arg_8_0._info then
		var_8_0 = arg_8_0._info.issueId
	end

	if not var_8_0 then
		logError("WeekWalkRuleView._refreshView, issueId can not be nil!")

		return
	end

	local var_8_1 = lua_weekwalk_rule.configDict[var_8_0]
	local var_8_2

	var_8_2 = var_8_1.isCn == 1

	local var_8_3 = ResUrl.getWeekWalkBg("rule/" .. var_8_1.icon .. ".png")

	arg_8_0._simageicon:LoadImage(var_8_3)

	for iter_8_0, iter_8_1 in pairs(lua_weekwalk_rule.configDict) do
		local var_8_4 = gohelper.findChild(arg_8_0._gotxt, "#go_txt" .. iter_8_1.id)

		if var_8_4 then
			gohelper.setActive(var_8_4, iter_8_1.id == var_8_0)
		end
	end

	local var_8_5 = var_8_1.additionRule

	if string.nilorempty(var_8_5) then
		return
	end

	local var_8_6 = GameUtil.splitString2(var_8_5, true, "|", "#")

	for iter_8_2, iter_8_3 in ipairs(var_8_6) do
		local var_8_7 = iter_8_3[1]
		local var_8_8 = iter_8_3[2]
		local var_8_9 = lua_rule.configDict[var_8_8]

		if var_8_9 then
			arg_8_0:_setRuleDescItem(var_8_9, var_8_7)
		end

		if iter_8_2 == #var_8_6 then
			gohelper.setActive(arg_8_0._rulesimagelineList[iter_8_2], false)
		end
	end
end

function var_0_0._addRuleItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = gohelper.clone(arg_9_0._goruletemp, arg_9_0._gorulelist, arg_9_1.id)

	table.insert(arg_9_0._childGoList, var_9_0)
	gohelper.setActive(var_9_0, true)

	local var_9_1 = gohelper.findChildImage(var_9_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_9_1, "wz_" .. arg_9_2)

	local var_9_2 = gohelper.findChildImage(var_9_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_9_2, arg_9_1.icon)
end

function var_0_0._setRuleDescItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {
		"#BDF291",
		"#D05B4C",
		"#C7b376"
	}
	local var_10_1 = gohelper.clone(arg_10_0._goruleitem, arg_10_0._goruleDescList, arg_10_1.id)

	table.insert(arg_10_0._childGoList, var_10_1)
	gohelper.setActive(var_10_1, true)

	local var_10_2 = gohelper.findChildImage(var_10_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_10_2, arg_10_1.icon)

	local var_10_3 = gohelper.findChild(var_10_1, "line")

	table.insert(arg_10_0._rulesimagelineList, var_10_3)

	local var_10_4 = gohelper.findChildImage(var_10_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_10_4, "wz_" .. arg_10_2)

	local var_10_5 = gohelper.findChildText(var_10_1, "desc")
	local var_10_6 = string.gsub(arg_10_1.desc, "%【(.-)%】", "<color=#FF906A>[%1]</color>")
	local var_10_7 = "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(arg_10_1.desc, var_10_0[1])
	local var_10_8 = luaLang("dungeon_add_rule_target_" .. arg_10_2)
	local var_10_9 = var_10_0[arg_10_2]

	var_10_5.text = SkillConfig.instance:fmtTagDescColor(var_10_8, var_10_6 .. var_10_7, var_10_9)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagebg:UnLoadImage()
	arg_12_0._simageicon:UnLoadImage()
end

return var_0_0
