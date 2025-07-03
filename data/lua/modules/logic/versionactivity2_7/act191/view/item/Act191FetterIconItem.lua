module("modules.logic.versionactivity2_7.act191.view.item.Act191FetterIconItem", package.seeall)

local var_0_0 = class("Act191FetterIconItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.imageFetter = gohelper.findChildImage(arg_1_1, "image_Fetter")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "btn_Click")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClick, arg_2_0)
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.relationCo = Activity191Config.instance:getRelationCo(arg_3_1)

	Activity191Helper.setFetterIcon(arg_3_0.imageFetter, arg_3_0.relationCo.icon)
end

function var_0_0.onClick(arg_4_0)
	if arg_4_0.param then
		Act191StatController.instance:statButtonClick(arg_4_0.param.fromView, string.format("Fetter_%s", arg_4_0.relationCo.name))
	end

	local var_4_0 = {
		tag = arg_4_0.relationCo.tag,
		isEnemy = arg_4_0.isEnemy,
		isPreview = arg_4_0.preview
	}

	Activity191Controller.instance:openFetterTipView(var_4_0)
end

function var_0_0.setEnemyView(arg_5_0)
	arg_5_0.isEnemy = true
end

function var_0_0.setPreview(arg_6_0)
	arg_6_0.preview = true
end

function var_0_0.setExtraParam(arg_7_0, arg_7_1)
	arg_7_0.param = arg_7_1
end

return var_0_0
