module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryCompositeView", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryCompositeView", BaseView)
local var_0_1 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._translayout1 = gohelper.findChild(arg_1_0.viewGO, "left/layout").gameObject
	arg_1_0._txtitemname1 = gohelper.findChildText(arg_1_0.viewGO, "left/layout/#txt_leftproductname")
	arg_1_0._txtitemnum1 = gohelper.findChildText(arg_1_0.viewGO, "left/layout/#txt_leftproductnum")
	arg_1_0._simageitemicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/leftproduct_icon")
	arg_1_0._translayout2 = gohelper.findChild(arg_1_0.viewGO, "right/layout").gameObject
	arg_1_0._txtitemname2 = gohelper.findChildText(arg_1_0.viewGO, "right/layout/#txt_rightproductname")
	arg_1_0._txtitemnum2 = gohelper.findChildText(arg_1_0.viewGO, "right/layout/#txt_rightproductnum")
	arg_1_0._simageitemicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/rightproduct_icon")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_composite/valuebg/#input_value")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_composite/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_composite/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_composite/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_composite/#btn_max")
	arg_1_0._btncomposite = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_composite/#btn_composite")
	arg_1_0._simagecosticon1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_composite/cost/#simage_costicon")
	arg_1_0._txtoriginalCost = gohelper.findChildText(arg_1_0.viewGO, "#go_composite/cost/#txt_originalCost")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseClick, arg_2_0)
	arg_2_0._btnmin:AddClickListener(arg_2_0._btnminOnClick, arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._btnmaxOnClick, arg_2_0)
	arg_2_0._btncomposite:AddClickListener(arg_2_0._btncompositeOnClick, arg_2_0)
	arg_2_0._inputvalue:AddOnValueChanged(arg_2_0.onCompositeCountValueChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._btncomposite:RemoveClickListener()
	arg_3_0._inputvalue:RemoveOnValueChanged()
end

function var_0_0._btncloseClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnminOnClick(arg_5_0)
	arg_5_0:changeCompositeCount(var_0_1)
end

function var_0_0._btnsubOnClick(arg_6_0)
	arg_6_0:changeCompositeCount(arg_6_0.compositeCount - 1)
end

function var_0_0._btnaddOnClick(arg_7_0)
	arg_7_0:changeCompositeCount(arg_7_0.compositeCount + 1)
end

function var_0_0._btnmaxOnClick(arg_8_0)
	local var_8_0 = arg_8_0:getMaxCompositeCount()

	arg_8_0:changeCompositeCount(var_8_0)
end

function var_0_0._btncompositeOnClick(arg_9_0)
	local var_9_0 = arg_9_0.compositeCount * arg_9_0.costPerComposite

	Activity157Controller.instance:factoryComposite(arg_9_0.compositeCount, var_9_0, arg_9_0.closeThis, arg_9_0)
end

function var_0_0.onCompositeCountValueChange(arg_10_0, arg_10_1)
	local var_10_0 = tonumber(arg_10_1)

	if not var_10_0 then
		return
	end

	arg_10_0:changeCompositeCount(var_10_0, true)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0.actId = Activity157Model.instance:getActId()

	local var_11_0 = Activity157Config.instance:getAct157CompositeFormula(arg_11_0.actId)
	local var_11_1 = true

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if var_11_1 then
			arg_11_0.costItemType = iter_11_1.materilType
			arg_11_0.costItemId = iter_11_1.materilId
			arg_11_0.costPerComposite = iter_11_1.quantity or 0
			var_11_1 = false
		else
			arg_11_0.targetPerComposite = iter_11_1.quantity or 0
		end

		local var_11_2, var_11_3 = ItemModel.instance:getItemConfigAndIcon(iter_11_1.materilType, iter_11_1.materilId)
		local var_11_4 = "_txtitemname" .. iter_11_0

		if arg_11_0[var_11_4] then
			arg_11_0[var_11_4].text = var_11_2.name
		end

		local var_11_5 = "_simageitemicon" .. iter_11_0

		if arg_11_0[var_11_5] then
			arg_11_0[var_11_5]:LoadImage(var_11_3)
		end

		local var_11_6 = "_simagecosticon" .. iter_11_0

		if arg_11_0[var_11_6] then
			UISpriteSetMgr.instance:setCurrencyItemSprite(arg_11_0[var_11_6], var_11_2.icon .. "_1")
		end
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	local var_13_0 = var_0_1
	local var_13_1 = Activity157Model.instance:getLastWillBeRepairedComponent()

	if var_13_1 then
		local var_13_2, var_13_3, var_13_4 = Activity157Config.instance:getComponentUnlockCondition(arg_13_0.actId, var_13_1)
		local var_13_5 = var_13_4 - ItemModel.instance:getItemQuantity(var_13_2, var_13_3)

		if var_13_5 > 0 then
			local var_13_6 = arg_13_0:getMaxCompositeCount()

			var_13_0 = var_13_6 < var_13_5 and var_13_6 or var_13_5
		end
	end

	arg_13_0:changeCompositeCount(var_13_0)
end

function var_0_0.getMaxCompositeCount(arg_14_0)
	local var_14_0 = var_0_1
	local var_14_1 = ItemModel.instance:getItemQuantity(arg_14_0.costItemType, arg_14_0.costItemId)

	if var_14_1 then
		var_14_0 = math.floor(var_14_1 / arg_14_0.costPerComposite)
	end

	return var_14_0
end

function var_0_0.changeCompositeCount(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getMaxCompositeCount()

	if var_15_0 < arg_15_1 then
		arg_15_1 = var_15_0
	end

	if arg_15_1 < var_0_1 then
		arg_15_1 = var_0_1
	end

	arg_15_0.compositeCount = arg_15_1

	if arg_15_2 then
		arg_15_0._inputvalue:SetTextWithoutNotify(tostring(arg_15_1))
	else
		arg_15_0._inputvalue:SetText(arg_15_1)
	end

	arg_15_0:refreshUI()
end

function var_0_0.refreshUI(arg_16_0)
	local var_16_0 = arg_16_0.compositeCount * arg_16_0.costPerComposite
	local var_16_1 = arg_16_0.compositeCount * arg_16_0.targetPerComposite

	arg_16_0._txtitemnum1.text = luaLang("multiple") .. var_16_0
	arg_16_0._txtitemnum2.text = luaLang("multiple") .. var_16_1

	ZProj.UGUIHelper.RebuildLayout(arg_16_0._translayout1.transform)
	ZProj.UGUIHelper.RebuildLayout(arg_16_0._translayout2.transform)

	local var_16_2 = ItemModel.instance:getItemQuantity(arg_16_0.costItemType, arg_16_0.costItemId)

	arg_16_0:showOriginalCostTxt(var_16_0, var_16_2)
end

function var_0_0.showOriginalCostTxt(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._txtoriginalCost.text = string.format("<color=#E07E25>%s</color>/%s", arg_17_1, arg_17_2)
end

function var_0_0.onClose(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._simageitemicon1:UnLoadImage()
	arg_19_0._simageitemicon2:UnLoadImage()
end

return var_0_0
