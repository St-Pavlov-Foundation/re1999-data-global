module("modules.logic.seasonver.act166.view.information.Season166InformationCurrencyView", package.seeall)

slot0 = class("Season166InformationCurrencyView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocurrency = gohelper.findChild(slot0.viewGO, "RightTop/#go_container/#go_currency")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "RightTop/#go_container")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btncurrencyOnClick(slot0)
	slot1 = slot0.self

	slot1:_btncurrencyClick(slot1.param[slot0.index])
end

function slot0._btncurrencyClick(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0.overrideClickFunc then
		return slot0.overrideClickFunc(slot0.overrideClickFuncObj, slot1)
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, slot1, false)

	if slot0._callback then
		slot0._callback(slot0._callbackObj)
	end
end

function slot0._onClick(slot0)
	if not slot0.self.param[slot0.index] then
		return
	end

	if type(slot3) == "number" then
		CurrencyJumpHandler.JumpByCurrency(slot3)
	elseif slot3.jumpFunc then
		slot3.jumpFunc()
	end
end

slot1 = CurrencyEnum.CurrencyType

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gocurrency, false)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._currencyObjs = {}
	slot0._currentItemIndex = nil
	slot0._initialized = true
end

function slot0.setCurrencyType(slot0, slot1)
	slot0.param = slot1

	slot0:_onCurrencyChange()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._currencyObjs) do
		slot5.btn:RemoveClickListener()
		slot5.btncurrency:RemoveClickListener()
	end
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId or slot0.viewParam.activityId
	slot0.param = {
		Season166Config.instance:getSeasonConstNum(slot0.actId, Season166Enum.InfoCostId)
	}

	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onCurrencyChange, slot0)
	slot0:_onCurrencyChange()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onCurrencyChange, slot0)
end

function slot0._onCurrencyChange(slot0)
	if not slot0.param then
		gohelper.setActive(slot0._gocontainer, false)

		return
	end

	if not slot0._initialized then
		return
	end

	slot2 = 1

	for slot6 = #slot0.param, 1, -1 do
		gohelper.setSibling(slot0:getCurrencyItem(slot6).go, slot2)

		slot2 = slot2 + 1

		if slot0.param[slot6] then
			slot9 = slot8
			slot7.txt.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(slot9) and slot10.quantity or 0)

			slot7.go:SetActive(true)
			UISpriteSetMgr.instance:setCurrencyItemSprite(slot7.image, CurrencyConfig.instance:getCurrencyCo(slot9).icon .. "_1")
		else
			slot7.go:SetActive(false)
		end
	end

	if slot1 < #slot0._currencyObjs then
		for slot6 = slot1 + 1, #slot0._currencyObjs do
			slot0:getCurrencyItem(slot6).go:SetActive(false)
		end
	end

	gohelper.setActive(slot0._gocontainer, slot1 > 0)
end

function slot0.getCurrencyItem(slot0, slot1)
	if not slot0._currencyObjs[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._gocurrency, "currency")
		slot2.go = slot3
		slot2.btn = gohelper.findChildButtonWithAudio(slot3, "#btn_currency/#btn")
		slot2.image = gohelper.findChildImage(slot3, "#btn_currency/#image")
		slot2.btncurrency = gohelper.findChildButtonWithAudio(slot3, "#btn_currency")
		slot2.txt = gohelper.findChildText(slot3, "#btn_currency/content/#txt")
		slot2.click = gohelper.findChild(slot3, "#btn_currency/click")

		slot2.btn:AddClickListener(slot0._onClick, {
			self = slot0,
			index = slot1
		})
		gohelper.setActive(slot2.btn, false)
		slot2.btncurrency:AddClickListener(slot0._btncurrencyOnClick, {
			self = slot0,
			index = slot1
		})

		slot0._currencyObjs[slot1] = slot2

		gohelper.setActive(slot2.go, true)
	end

	return slot2
end

return slot0
