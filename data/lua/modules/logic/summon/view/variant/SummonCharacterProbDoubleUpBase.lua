module("modules.logic.summon.view.variant.SummonCharacterProbDoubleUpBase", package.seeall)

slot0 = class("SummonCharacterProbDoubleUpBase", SummonMainCharacterProbUp)

function slot0._editableInitView(slot0)
	slot0._gobefore30 = gohelper.findChild(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#go_before30")
	slot0._txtcurrency_current = gohelper.findChildText(slot0._gobefore30, "#txt_currency_current")
	slot0._txtcurrency_before = gohelper.findChildText(slot0._gobefore30, "#txt_currency_before")
	slot0._gotag = gohelper.findChild(slot0._gobefore30, "#go_tag")
	slot0._txtnum = gohelper.findChildText(slot0._gotag, "#txt_num")
	slot0._textEN = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon10/textEN")
	slot0._freetag = gohelper.findChild(slot0.viewGO, "#go_ui/current/tip/tip/freetag")
	slot0._txtcurrency102.text = ""
	slot0._txtcurrency101.text = ""

	uv0.super._editableInitView(slot0)
end

function slot1(slot0)
	if string.nilorempty(slot0) then
		return -1, 0, 0
	end

	return SummonMainModel.instance.getCostByConfig(slot0)
end

function slot2(slot0)
	if not slot0 then
		return {
			cost_num = 0,
			cost_num_before = 0,
			discountPercent01 = 0,
			cost_id = 0,
			cost_type = -1
		}
	end

	if not SummonConfig.instance:getSummonPool(slot0) then
		return slot1
	end

	slot3, slot4, slot5 = uv0(slot2.cost10)

	if slot3 < 0 then
		return slot1
	end

	slot1.cost_type = slot3
	slot1.cost_id = slot4
	slot1.cost_num = slot5
	slot1.cost_num_before = slot5

	if string.nilorempty(slot2.discountCost10) then
		return slot1
	end

	for slot10, slot11 in ipairs(string.split(slot2.discountCost10, "|")) do
		slot12 = string.splitToNumber(slot11, "#")
		slot15 = slot12[3]

		if slot12[1] == slot1.cost_type and slot1.cost_id == slot12[2] then
			if SummonMainModel.instance:getDiscountTime10Server(slot0) > 0 then
				slot1.discountPercent01 = (slot1.cost_num - slot15) / slot1.cost_num
				slot1.cost_num = slot15
			end

			break
		end
	end

	return slot1
end

function slot0._refreshView(slot0, ...)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot0._currentCostInfo = uv0(slot1.id)

	uv1.super._refreshView(slot0, ...)
end

function slot0._btnsummon10OnClick(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2 = slot0._currentCostInfo
	slot5 = slot2.cost_num

	if not (slot5 <= ItemModel.instance:getItemQuantity(slot2.cost_type, slot2.cost_id)) and SummonMainModel.instance:getOwnCostCurrencyNum() < SummonMainModel.instance.everyCostCount * (slot5 - slot7) then
		-- Nothing
	end

	if slot8 then
		slot6.needTransform = false

		slot0:_summon10Confirm()

		return
	else
		slot6.needTransform = true
		slot6.cost_type = SummonMainModel.instance.costCurrencyType
		slot6.cost_id = SummonMainModel.instance.costCurrencyId
		slot6.cost_quantity = slot12
		slot6.miss_quantity = slot11
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, {
		type = slot3,
		id = slot4,
		quantity = slot5,
		callback = slot0._summon10Confirm,
		callbackObj = slot0,
		notEnough = false,
		notEnough = true
	})
end

function slot0._refreshCost(slot0)
	if SummonMainModel.instance:getCurPool() then
		slot0:_refreshSingleCost(slot1.cost1, slot0._simagecurrency1, "_txtcurrency1")
		slot0:_refreshCost10()
	end
end

function slot0._refreshCost10(slot0)
	if not SummonMainModel.instance:getCurPool() then
		slot0._txtcurrency101.text = ""
		slot0._txtcurrency102.text = ""
		slot0._textEN.text = ""

		gohelper.setActive(slot0._gobefore30, false)

		return
	end

	slot2 = slot0._currentCostInfo
	slot4 = slot2.cost_id
	slot5 = slot2.cost_type
	slot7 = slot2.cost_num_before
	slot8 = slot2.discountPercent01 > 0

	gohelper.setActive(slot0._gotag, slot8)
	gohelper.setActive(slot0._gobefore30, slot8)
	gohelper.setActive(slot0._freetag, slot8)

	slot0._textEN.text = "SUMMON*" .. slot2.cost_num

	if slot6 <= 0 then
		slot0:_refreshSingleCost(slot1.cost10, slot0._simagecurrency10, "_txtcurrency10")
	else
		slot0._simagecurrency10:LoadImage(SummonMainModel.getSummonItemIcon(slot5, slot4))

		slot0._txtcurrency102.text = ""
		slot0._txtcurrency101.text = ""
		slot0._txtnum.text = "-" .. slot6 * 100 .. "%"
		slot0._txtcurrency_before.text = slot7
		slot0._txtcurrency_current.text = luaLang("multiple") .. slot3
	end
end

return slot0
