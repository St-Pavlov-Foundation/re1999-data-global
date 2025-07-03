module("modules.logic.versionactivity2_7.act191.view.item.Act191RewardItem", package.seeall)

local var_0_0 = class("Act191RewardItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.bg = gohelper.findChildImage(arg_1_1, "bg")
	arg_1_0.rare = gohelper.findChildImage(arg_1_1, "rare")
	arg_1_0.icon = gohelper.findChildImage(arg_1_1, "icon")
	arg_1_0.num = gohelper.findChildText(arg_1_1, "num")
	arg_1_0.click = gohelper.findChildButtonWithAudio(arg_1_1, "clickArea")
	arg_1_0.effAutoFight = gohelper.findChild(arg_1_1, "eff_AutoFight")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.click, arg_2_0.onClick, arg_2_0)
end

function var_0_0.setData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.config = lua_activity191_item.configDict[arg_3_1]
	arg_3_0.num.text = arg_3_2

	if arg_3_0.config then
		UISpriteSetMgr.instance:setAct174Sprite(arg_3_0.icon, arg_3_0.config.icon)

		if arg_3_0.config.rare ~= 0 then
			UISpriteSetMgr.instance:setAct174Sprite(arg_3_0.rare, "act174_roleframe_" .. arg_3_0.config.rare)
		end

		gohelper.setActive(arg_3_0.rare, arg_3_0.config.rare ~= 0)
	end
end

function var_0_0.onClick(arg_4_0)
	if arg_4_0.param then
		Act191StatController.instance:statButtonClick(arg_4_0.param.fromView, string.format("clickArea_%s_%s", arg_4_0.param.index, arg_4_0.config.name))
	end

	if arg_4_0.config then
		Activity191Controller.instance:openItemView(arg_4_0.config)
	end
end

function var_0_0.setClickEnable(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0.click, arg_5_1)
end

function var_0_0.setExtraParam(arg_6_0, arg_6_1)
	arg_6_0.param = arg_6_1
end

function var_0_0.showAutoEff(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0.effAutoFight, arg_7_1)
end

return var_0_0
