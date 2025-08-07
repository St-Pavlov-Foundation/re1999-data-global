module("modules.logic.fight.view.FightAiJiAoQteSelectItemView", package.seeall)

local var_0_0 = class("FightAiJiAoQteSelectItemView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.hpSlider = gohelper.findChildSlider(arg_1_0.viewGO, "#slider_hp")
	arg_1_0.shieldSlider = gohelper.findChildSlider(arg_1_0.viewGO, "#slider_hp/#slider_hudun")
	arg_1_0.roleIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0.restrain = gohelper.findChild(arg_1_0.viewGO, "restrain")
	arg_1_0.restrainAni = gohelper.findChildComponent(arg_1_0.viewGO, "restrain/restrain", gohelper.Type_Animator)
	arg_1_0.actRoot = gohelper.findChild(arg_1_0.viewGO, "actLayout")
	arg_1_0.actItemObj = gohelper.findChild(arg_1_0.viewGO, "actLayout/act")
	arg_1_0.goSelect = gohelper.findChild(arg_1_0.viewGO, "go_select")
	arg_1_0.click = gohelper.findChildClick(arg_1_0.viewGO, "click")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.click, arg_2_0.onClick)
end

function var_0_0.onClick(arg_3_0)
	arg_3_0.PARENT_VIEW:onSelectItem(arg_3_0.toId)
end

function var_0_0.onConstructor(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.fromId = arg_4_1
	arg_4_0.toId = arg_4_2
end

function var_0_0.showSelect(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0.goSelect, arg_5_1 == arg_5_0.toId)
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = FightDataHelper.entityMgr:getById(arg_6_0.toId)
	local var_6_1 = FightConfig.instance:getSkinCO(var_6_0.skin)
	local var_6_2 = ""

	if var_6_0:isEnemySide() then
		var_6_2 = ResUrl.monsterHeadIcon(var_6_1.headIcon)
	else
		var_6_2 = ResUrl.getHeadIconSmall(var_6_1.retangleIcon)
	end

	arg_6_0.roleIcon:LoadImage(var_6_2)

	local var_6_3 = var_6_0.currentHp
	local var_6_4 = var_6_0.shieldValue
	local var_6_5, var_6_6 = FightNameUI.getHpFillAmount(var_6_3, var_6_4, var_6_0.id)

	arg_6_0.hpSlider:SetValue(var_6_5)
	arg_6_0.shieldSlider:SetValue(var_6_6)

	local var_6_7 = FightDataHelper.entityMgr:getById(arg_6_0.fromId)

	if (FightConfig.instance:getRestrain(var_6_7.career, var_6_0.career) or 1000) > 1000 then
		gohelper.setActive(arg_6_0.restrain, true)
		arg_6_0.restrainAni:Play("fight_restrain_all_in", 0, 0)
		arg_6_0.restrainAni:Update(0)
	else
		gohelper.setActive(arg_6_0.restrain, false)
	end

	local var_6_8 = FightDataHelper.roundMgr:getRoundData():getEntityAIUseCardMOList(arg_6_0.toId)

	arg_6_0:com_createObjList(arg_6_0.onActItemShow, var_6_8, arg_6_0.actRoot, arg_6_0.actItemObj)
end

function var_0_0.onActItemShow(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:com_openSubView(FightNameUIOperationItem, arg_7_1):refreshItemData(arg_7_2)
	gohelper.setActive(gohelper.findChild(arg_7_1, "round"), false)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
