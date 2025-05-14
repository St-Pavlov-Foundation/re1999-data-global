module("modules.logic.seasonver.act123.view2_3.Season123_2_3AdditionRuleTipView", package.seeall)

local var_0_0 = class("Season123_2_3AdditionRuleTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "content/layout/#go_ruleitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._itemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam.actId
	local var_5_1 = arg_5_0.viewParam.stage
	local var_5_2 = Season123Config.instance:getRuleTips(var_5_0, var_5_1)
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_2) do
		table.insert(var_5_3, iter_5_0)
	end

	for iter_5_2 = 1, math.max(#var_5_3, #arg_5_0._itemList) do
		local var_5_4 = arg_5_0:getOrCreateItem(iter_5_2)

		arg_5_0:updateItem(var_5_4, var_5_3[iter_5_2])
	end

	NavigateMgr.instance:addEscape(arg_5_0.viewName, arg_5_0.closeThis, arg_5_0)
end

function var_0_0.getOrCreateItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._itemList[arg_6_1]

	if not var_6_0 then
		var_6_0 = arg_6_0:getUserDataTb_()
		var_6_0.go = gohelper.cloneInPlace(arg_6_0._goitem, "item" .. tostring(arg_6_1))
		var_6_0.icon = gohelper.findChildImage(var_6_0.go, "mask/icon")
		var_6_0.txtTag = gohelper.findChildTextMesh(var_6_0.go, "mask/scroll_tag/Viewport/Content/tag")
		arg_6_0._itemList[arg_6_1] = var_6_0
	end

	return var_6_0
end

function var_0_0.updateItem(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 then
		gohelper.setActive(arg_7_1.go, false)

		return
	end

	gohelper.setActive(arg_7_1.go, true)

	local var_7_0 = lua_rule.configDict[arg_7_2]

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(arg_7_1.icon, var_7_0.icon)

	arg_7_1.txtTag.text = var_7_0.desc
end

function var_0_0.onClose(arg_8_0)
	return
end

return var_0_0
