module("modules.logic.fight.view.rouge.FightViewRougeTongPin", package.seeall)

local var_0_0 = class("FightViewRougeTongPin", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._polarizationRoot = arg_1_0.viewGO
	arg_1_0._polarizationItem = gohelper.findChild(arg_1_0.viewGO, "item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.PolarizationLevel, arg_2_0._onPolarizationLevel, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onClothSkillRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.tongPingGoList = arg_4_0:getUserDataTb_()

	table.insert(arg_4_0.tongPingGoList, arg_4_0._polarizationItem)
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0.hideTongPinObj(arg_6_0)
	gohelper.setActive(arg_6_0._polarizationRoot, false)
	FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.RougeTongPin)
end

function var_0_0.showTongPinObj(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._polarizationRoot, true)

	local var_7_0 = FightRightElementEnum.ElementsSizeDict[FightRightElementEnum.Elements.RougeTongPin]
	local var_7_1 = arg_7_1 and var_7_0.y * arg_7_1 or nil

	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.RougeTongPin, var_7_1)
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_8_0)
	arg_8_0:hideTongPinObj()
end

function var_0_0._onRoundSequenceFinish(arg_9_0)
	arg_9_0:hideTongPinObj()
end

function var_0_0._onPolarizationLevel(arg_10_0)
	arg_10_0:_refreshTongPin()
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:hideTongPinObj()
end

var_0_0.tempDataList = {}

function var_0_0._refreshTongPin(arg_12_0)
	arg_12_0._polarizationDic = FightRoundSequence.roundTempData.PolarizationLevel

	if arg_12_0._polarizationDic then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._polarizationDic) do
			if iter_12_1.effectNum == 0 then
				arg_12_0._polarizationDic[iter_12_0] = nil
			end
		end
	end

	if arg_12_0._polarizationDic and tabletool.len(arg_12_0._polarizationDic) > 0 then
		local var_12_0 = var_0_0.tempDataList

		tabletool.clear(var_12_0)

		for iter_12_2, iter_12_3 in pairs(arg_12_0._polarizationDic) do
			table.insert(var_12_0, iter_12_3)
		end

		table.sort(var_12_0, arg_12_0.sortPolarization)
		arg_12_0:com_createObjList(arg_12_0._onPolarizationItemShow, var_12_0, arg_12_0._polarizationRoot, arg_12_0._polarizationItem)
		arg_12_0:showTongPinObj(#var_12_0)
	else
		arg_12_0:hideTongPinObj()
	end
end

function var_0_0.sortPolarization(arg_13_0, arg_13_1)
	return arg_13_0.configEffect < arg_13_1.configEffect
end

var_0_0.TempParam = {}

function var_0_0._onPolarizationItemShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = lua_polarization.configDict[arg_14_2.effectNum] and lua_polarization.configDict[arg_14_2.effectNum][arg_14_2.configEffect]

	if not var_14_0 then
		gohelper.setActive(arg_14_1, false)

		return
	end

	local var_14_1 = gohelper.findChildText(arg_14_1, "bg/#txt_name")
	local var_14_2 = gohelper.findChildText(arg_14_1, "bg/#txt_level")

	var_14_1.text = var_14_0 and var_14_0.name

	local var_14_3 = arg_14_2.effectNum

	var_14_2.text = "Lv." .. var_14_3

	local var_14_4 = gohelper.getClickWithDefaultAudio(gohelper.findChild(arg_14_1, "bg"))

	arg_14_0:removeClickCb(var_14_4)

	local var_14_5 = var_0_0.TempParam

	var_14_5.config = var_14_0
	var_14_5.position = arg_14_1.transform.position

	arg_14_0:addClickCb(var_14_4, arg_14_0._onBtnPolarization, arg_14_0, var_14_5)

	for iter_14_0 = 1, 3 do
		local var_14_6 = gohelper.findChild(arg_14_1, "effect_lv/effect_lv" .. iter_14_0)

		gohelper.setActive(var_14_6, iter_14_0 == var_14_3)
	end

	if var_14_3 > 3 then
		gohelper.setActive(gohelper.findChild(arg_14_1, "effect_lv/effect_lv3"), true)
	end
end

function var_0_0._onBtnPolarization(arg_15_0, arg_15_1)
	FightController.instance:dispatchEvent(FightEvent.RougeShowTip, arg_15_1)
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
