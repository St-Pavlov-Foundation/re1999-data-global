module("modules.logic.versionactivity2_7.act191.view.item.Act191FetterItem", package.seeall)

local var_0_0 = class("Act191FetterItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.imageRare = gohelper.findChildImage(arg_1_1, "bg")
	arg_1_0.goEffect2 = gohelper.findChild(arg_1_1, "effect2")
	arg_1_0.goEffect3 = gohelper.findChild(arg_1_1, "effect3")
	arg_1_0.goEffect4 = gohelper.findChild(arg_1_1, "effect4")
	arg_1_0.goEffect5 = gohelper.findChild(arg_1_1, "effect5")
	arg_1_0.imageIcon = gohelper.findChildImage(arg_1_1, "icon")
	arg_1_0.txtCnt = gohelper.findChildText(arg_1_1, "count")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "clickArea")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClick, arg_2_0)
end

function var_0_0.setData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.config = arg_3_1

	local var_3_0 = Activity191Config.instance:getRelationMaxCo(arg_3_0.config.tag)

	if arg_3_1.level ~= 0 then
		arg_3_0.txtCnt.text = string.format("%d/%d", arg_3_2, var_3_0.activeNum)
	else
		arg_3_0.txtCnt.text = string.format("<color=#ed7f7f>%d</color><color=#838383>/%d</color>", arg_3_2, var_3_0.activeNum)
	end

	UISpriteSetMgr.instance:setAct174Sprite(arg_3_0.imageRare, "act174_shop_tag_" .. arg_3_0.config.tagBg)

	for iter_3_0 = 2, 5 do
		gohelper.setActive(arg_3_0["goEffect" .. iter_3_0], iter_3_0 == arg_3_0.config.tagBg)
	end

	ZProj.UGUIHelper.SetGrayscale(arg_3_0.imageIcon.gameObject, arg_3_1.level == 0)

	local var_3_1

	var_3_1.a, var_3_1 = arg_3_1.level == 0 and 0.5 or 1, arg_3_0.imageIcon.color
	arg_3_0.imageIcon.color = var_3_1

	Activity191Helper.setFetterIcon(arg_3_0.imageIcon, arg_3_0.config.icon)
end

function var_0_0.onClick(arg_4_0)
	if arg_4_0.param then
		Act191StatController.instance:statButtonClick(arg_4_0.param.fromView, string.format("clickArea_%s_%s", arg_4_0.param.index, arg_4_0.config.name))
	end

	local var_4_0 = {
		tag = arg_4_0.config.tag,
		isEnemy = arg_4_0.isEnemy
	}

	Activity191Controller.instance:openFetterTipView(var_4_0)
end

function var_0_0.setEnemyView(arg_5_0)
	arg_5_0.isEnemy = true
end

function var_0_0.setClickEnable(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.btnClick, arg_6_1)
end

function var_0_0.setExtraParam(arg_7_0, arg_7_1)
	arg_7_0.param = arg_7_1
end

return var_0_0
