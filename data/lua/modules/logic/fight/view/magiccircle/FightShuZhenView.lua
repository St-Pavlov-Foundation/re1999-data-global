module("modules.logic.fight.view.magiccircle.FightShuZhenView", package.seeall)

local var_0_0 = class("FightShuZhenView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._topLeftRoot = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent")
	arg_1_0._obj = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/#go_shuzhentips")
	arg_1_0._detail = gohelper.findChild(arg_1_0.viewGO, "root/#go_shuzhendetails")
	gohelper.onceAddComponent(arg_1_0._detail, typeof(UnityEngine.Animator)).enabled = true
	arg_1_0._detailHeightObj = gohelper.findChild(arg_1_0.viewGO, "root/#go_shuzhendetails/details")
	arg_1_0._detailTitle = gohelper.findChildText(arg_1_0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_title")
	arg_1_0._detailRound = gohelper.findChildText(arg_1_0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_title/#txt_round")
	arg_1_0._detailText = gohelper.findChildText(arg_1_0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_details")
	arg_1_0._detailClick = gohelper.getClickWithDefaultAudio(gohelper.findChild(arg_1_0._detail, "#btn_shuzhendetailclick"))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._detailClick:AddClickListener(arg_2_0._onDetailClick, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.AddMagicCircile, arg_2_0._onAddMagicCircile, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.DeleteMagicCircile, arg_2_0._onDeleteMagicCircile, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.UpdateMagicCircile, arg_2_0._onUpdateMagicCircile, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClickMagicCircleText, arg_2_0.OnClickMagicCircleText, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._detailClick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:hideObj()
	gohelper.setActive(arg_4_0._detail, false)
	SkillHelper.addHyperLinkClick(arg_4_0._detailText, arg_4_0.onClickShuZhenHyperDesc, arg_4_0)

	arg_4_0.detailRectTr = arg_4_0._detail:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.viewGoRectTr = arg_4_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.scrollRectTr = gohelper.findChildComponent(arg_4_0.viewGO, "root/#go_shuzhendetails/details/#scroll_details", gohelper.Type_RectTransform)
	arg_4_0.topLeftRootTr = arg_4_0._topLeftRoot.transform
	arg_4_0.detailTr = arg_4_0._detail.transform

	for iter_4_0, iter_4_1 in pairs(FightEnum.MagicCircleUIType2Name) do
		gohelper.setActive(gohelper.findChild(arg_4_0._obj, "layout/" .. iter_4_1), false)
	end
end

var_0_0.TipIntervalX = 10

function var_0_0.onClickShuZhenHyperDesc(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = recthelper.getWidth(arg_5_0.viewGoRectTr) / 2
	local var_5_1 = recthelper.getAnchorX(arg_5_0.detailRectTr)
	local var_5_2 = recthelper.getWidth(arg_5_0.scrollRectTr)
	local var_5_3 = var_5_0 - var_5_1 - var_5_2 - var_0_0.TipIntervalX

	arg_5_0.commonBuffTipAnchorPos = arg_5_0.commonBuffTipAnchorPos or Vector2()

	arg_5_0.commonBuffTipAnchorPos:Set(-var_5_3, 312.24)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(arg_5_1, arg_5_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Left)
end

function var_0_0.OnClickMagicCircleText(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = recthelper.rectToRelativeAnchorPos(arg_6_2, arg_6_0.topLeftRootTr).y - arg_6_1 + recthelper.getAnchorY(arg_6_0.topLeftRootTr)

	recthelper.setAnchorY(arg_6_0.detailTr, var_6_0)
	gohelper.setActive(arg_6_0._detail, true)

	local var_6_1 = FightModel.instance:getMagicCircleInfo()
	local var_6_2 = var_6_1 and var_6_1.magicCircleId and lua_magic_circle.configDict[var_6_1.magicCircleId]

	if var_6_1 and var_6_2 then
		local var_6_3 = var_6_1.round == -1 and "∞" or var_6_1.round

		arg_6_0._detailTitle.text = var_6_2.name
		arg_6_0._detailRound.text = formatLuaLang("x_round", var_6_3)
		arg_6_0._detailText.text = SkillHelper.buildDesc(var_6_2.desc)
	end
end

function var_0_0._onDetailClick(arg_7_0)
	gohelper.setActive(arg_7_0._detail, false)
end

function var_0_0.addMagic(arg_8_0)
	arg_8_0:clearFlow()

	arg_8_0.flow = FlowSequence.New()

	local var_8_0 = arg_8_0.magicItem

	arg_8_0.magicItem = nil

	arg_8_0.flow:addWork(FightMagicCircleRemoveWork.New(var_8_0))
	arg_8_0.flow:addWork(FunctionWork.New(arg_8_0.createMagicItem, arg_8_0))
	arg_8_0.flow:start()
end

function var_0_0.removeMagic(arg_9_0)
	arg_9_0:clearFlow()

	arg_9_0.flow = FlowSequence.New()

	local var_9_0 = arg_9_0.magicItem

	arg_9_0.magicItem = nil

	arg_9_0.flow:addWork(FightMagicCircleRemoveWork.New(var_9_0))
	arg_9_0.flow:registerDoneListener(arg_9_0.hideObj, arg_9_0)
	arg_9_0.flow:start()
end

var_0_0.UiType2Class = {
	[FightEnum.MagicCircleUIType.Normal] = FightMagicCircleNormal,
	[FightEnum.MagicCircleUIType.Electric] = FightMagicCircleElectric
}

function var_0_0.createMagicItem(arg_10_0)
	local var_10_0 = FightModel.instance:getMagicCircleInfo()

	if not var_10_0 then
		return
	end

	if not var_10_0.magicCircleId then
		return
	end

	local var_10_1 = lua_magic_circle.configDict[var_10_0.magicCircleId]

	if not var_10_1 then
		return
	end

	arg_10_0:showObj()

	local var_10_2 = var_10_1.uiType

	arg_10_0.magicItem = (arg_10_0.UiType2Class[var_10_2] or FightMagicCircleNormal).New()

	local var_10_3 = gohelper.findChild(arg_10_0._obj, "layout/" .. FightEnum.MagicCircleUIType2Name[var_10_2])

	arg_10_0.magicItem:init(var_10_3)
	arg_10_0.magicItem:onCreateMagic(var_10_0, var_10_1)
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:addMagic()
end

function var_0_0._onAddMagicCircile(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:addMagic()
end

function var_0_0._onDeleteMagicCircile(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:removeMagic()
end

function var_0_0._onUpdateMagicCircile(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = FightModel.instance:getMagicCircleInfo()

	if not var_14_0 then
		return arg_14_0:removeMagic()
	end

	if not var_14_0.magicCircleId then
		return arg_14_0:removeMagic()
	end

	local var_14_1 = lua_magic_circle.configDict[var_14_0.magicCircleId]

	if not var_14_1 then
		return arg_14_0:removeMagic()
	end

	if var_14_1.uiType == (arg_14_0.magicItem and arg_14_0.magicItem:getUIType()) then
		arg_14_0.magicItem:onUpdateMagic(var_14_0, var_14_1, arg_14_2)
	else
		arg_14_0:addMagic()
	end
end

function var_0_0.hideObj(arg_15_0)
	gohelper.setActive(arg_15_0._obj, false)
end

function var_0_0.showObj(arg_16_0)
	gohelper.setActive(arg_16_0._obj, true)
end

function var_0_0.clearFlow(arg_17_0)
	if arg_17_0.flow then
		arg_17_0.flow:stop()
		arg_17_0.flow:destroy()

		arg_17_0.flow = nil
	end
end

function var_0_0.onClose(arg_18_0)
	arg_18_0:clearFlow()

	if arg_18_0.magicItem then
		arg_18_0.magicItem:destroy()

		arg_18_0.magicItem = nil
	end
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
