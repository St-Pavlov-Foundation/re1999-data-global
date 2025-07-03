module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonConditionComp", package.seeall)

local var_0_0 = class("Act183DungeonConditionComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._txtconditionitem = gohelper.findChildText(arg_1_0.go, "#go_conditiondescs/#txt_conditionitem")
	arg_1_0._imageconditionstar = gohelper.findChildImage(arg_1_0.go, "top/title/#image_conditionstar")

	Act183Helper.setEpisodeConditionStar(arg_1_0._imageconditionstar, true)

	arg_1_0._conditionItemTab = arg_1_0:getUserDataTb_()
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	var_0_0.super.updateInfo(arg_4_0, arg_4_1)

	arg_4_0._conditionIds = arg_4_0._episodeMo:getConditionIds()
	arg_4_0._isAllConditionPass = arg_4_0._episodeMo:isAllConditionPass()
end

function var_0_0.checkIsVisible(arg_5_0)
	return arg_5_0._conditionIds and #arg_5_0._conditionIds > 0
end

function var_0_0.show(arg_6_0)
	var_0_0.super.show(arg_6_0)
	arg_6_0:createObjList(arg_6_0._conditionIds, arg_6_0._conditionItemTab, arg_6_0._txtconditionitem.gameObject, arg_6_0._initConditionItemFunc, arg_6_0._refreshConditionItemFunc, arg_6_0._defaultItemFreeFunc)
	ZProj.UGUIHelper.SetGrayscale(arg_6_0._imageconditionstar.gameObject, not arg_6_0._isAllConditionPass)
end

function var_0_0._initConditionItemFunc(arg_7_0, arg_7_1)
	arg_7_1.txtcondition = gohelper.onceAddComponent(arg_7_1.go, gohelper.Type_TextMesh)

	SkillHelper.addHyperLinkClick(arg_7_1.txtcondition)

	arg_7_1.gostar = gohelper.findChild(arg_7_1.go, "star")
end

function var_0_0._refreshConditionItemFunc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = Act183Config.instance:getConditionCo(arg_8_2)

	if not var_8_0 then
		return
	end

	arg_8_1.txtcondition.text = SkillHelper.buildDesc(var_8_0.decs1)

	local var_8_1 = arg_8_0._episodeMo:isConditionPass(arg_8_2)

	gohelper.setActive(arg_8_1.gostar, var_8_1)
end

function var_0_0.onDestroy(arg_9_0)
	var_0_0.super.onDestroy(arg_9_0)
end

return var_0_0
