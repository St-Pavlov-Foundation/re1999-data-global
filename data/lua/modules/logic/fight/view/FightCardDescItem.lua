module("modules.logic.fight.view.FightCardDescItem", package.seeall)

local var_0_0 = class("FightCardDescItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormalcard = gohelper.findChild(arg_1_0.viewGO, "#go_normalcard")
	arg_1_0._gosupercard = gohelper.findChild(arg_1_0.viewGO, "#go_supercard")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simageList = arg_4_0:getUserDataTb_()
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._mo = arg_7_1
	arg_7_0._isSuperCard = arg_7_2

	if arg_7_0._isSuperCard then
		arg_7_0:onRefreshUI(arg_7_0._gosupercard)
	else
		arg_7_0:onRefreshUI(arg_7_0._gonormalcard)
	end

	gohelper.setActive(arg_7_0._gonormalcard, not arg_7_0._isSuperCard)
	gohelper.setActive(arg_7_0._gosupercard, arg_7_0._isSuperCard)
end

function var_0_0.onRefreshUI(arg_8_0, arg_8_1)
	local var_8_0 = gohelper.findChildSingleImage(arg_8_1, "card")
	local var_8_1 = gohelper.findChildSingleImage(arg_8_1, "attribute")
	local var_8_2 = gohelper.findChildText(arg_8_1, "nameen")
	local var_8_3 = gohelper.findChildText(arg_8_1, "nameen/name")
	local var_8_4 = gohelper.findChildText(arg_8_1, "desc")
	local var_8_5 = gohelper.findChildImage(arg_8_1, "tagIcon")

	var_8_0:LoadImage(ResUrl.getFightCardDescIcon(arg_8_0._mo.card1))

	if not string.nilorempty(arg_8_0._mo.attribute) then
		var_8_1:LoadImage(ResUrl.getAttributeIcon(arg_8_0._mo.attribute))
	end

	var_8_2.text = arg_8_0._mo.cardname_en
	var_8_3.text = arg_8_0._mo.cardname
	var_8_4.text = arg_8_0._mo.carddescription2

	UISpriteSetMgr.instance:setFightSprite(var_8_5, arg_8_0._mo.card2)
	gohelper.setActive(var_8_1.gameObject, not arg_8_0._isSuperCard)
	gohelper.setActive(var_8_5.gameObject, not arg_8_0._isSuperCard)
	table.insert(arg_8_0._simageList, var_8_0)
	table.insert(arg_8_0._simageList, var_8_1)
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._simageList) do
		iter_10_1:UnLoadImage()
	end
end

return var_0_0
