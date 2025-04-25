module("modules.logic.currency.view.CurrencyView", package.seeall)

slot0 = class("CurrencyView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocurrency = gohelper.findChild(slot0.viewGO, "#go_container/#go_currency")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")

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

	if type(slot1) == "number" then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, slot1, false, nil, slot0._cantJump)
	else
		MaterialTipController.instance:showMaterialInfo(slot1.type, slot1.id, false, nil, slot0._cantJump)
	end

	if slot0._callback then
		slot0._callback(slot0._callbackObj)
	end
end

function slot0.setOpenCallback(slot0, slot1, slot2)
	slot0._openCallback = slot1
	slot0._openCallbackObj = slot2
end

function slot0.ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	uv0.super.ctor(slot0)

	slot0.param = slot1
	slot0._callback = slot2
	slot0._callbackObj = slot3
	slot0._localItemsEvent = slot4
	slot0._cantJump = slot5
end

function slot0.overrideCurrencyClickFunc(slot0, slot1, slot2)
	slot0.overrideClickFunc = slot1
	slot0.overrideClickFuncObj = slot2
end

function slot0._onLocalItemChanged(slot0, slot1, slot2)
	slot0._minusItemDict = {}

	if slot1 then
		for slot6 = 1, #slot1 do
			if slot1[slot6].type == MaterialEnum.MaterialType.Currency then
				slot0._minusItemDict[slot7.id] = (slot0._minusItemDict[slot7.id] or 0) + slot7.quantity
			end
		end
	end

	if slot2 then
		return
	end

	slot0:_onCurrencyChange()
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

	if not slot0.param then
		logError("没有传入货币类型给CurrencyView")

		return
	end

	slot0._initialized = true

	slot0:_onCurrencyChange()
end

function slot0.setCurrencyType(slot0, slot1)
	slot0.param = slot1

	slot0:_onCurrencyChange()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._currencyObjs) do
		slot5.simage:UnLoadImage()
		slot5.btn:RemoveClickListener()
		slot5.btncurrency:RemoveClickListener()
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onCurrencyChange, slot0)

	if slot0._localItemsEvent then
		slot0:addEventCb(CharacterController.instance, CharacterEvent.levelUplocalItem, slot0._onLocalItemChanged, slot0)
	end

	if slot0.viewContainer.viewParam and slot0.viewContainer.viewParam.enterViewName == ViewName.HeroGroupEditView then
		slot0._animator:Play("currencyview_in2")
	else
		slot0._animator:Play("currencyview_in")
	end

	if slot0._openCallback then
		slot0._openCallback(slot0._openCallbackObj)

		slot0._openCallback = nil
		slot0._openCallbackObj = nil
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadlineUI, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onCurrencyChange, slot0)

	if slot0.viewContainer.viewParam and slot0.viewContainer.viewParam.enterViewName == ViewName.HeroGroupEditView then
		slot0._animator:Play("currencyview_out2")
	else
		slot0._animator:Play("currencyview_out")
	end
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
			slot9 = false

			if type(slot8) == "number" then
				slot10 = slot8
				slot12 = CurrencyConfig.instance:getCurrencyCo(slot10)

				if slot0._minusItemDict and slot0._minusItemDict[slot10] then
					slot13 = (CurrencyModel.instance:getCurrency(slot10) and slot11.quantity or 0) - slot0._minusItemDict[slot10]
				end

				if slot0.showMaxLimit then
					slot7.txt.text = string.format("%s/%s", GameUtil.numberDisplay(slot13), GameUtil.numberDisplay(slot12.maxLimit))
				else
					slot7.txt.text = GameUtil.numberDisplay(slot13)
				end

				slot7.go:SetActive(true)
				UISpriteSetMgr.instance:setCurrencyItemSprite(slot7.image, slot12.icon .. "_1")

				if slot0:isNeedShieldAddBtn() then
					gohelper.setActive(slot7.btn.gameObject, false)
				end

				if slot10 == CurrencyEnum.CurrencyType.Power then
					slot0.powerItemObj = slot7

					slot0:_onRefreshDeadline()
				end

				slot9 = false
			else
				slot12 = slot8.isIcon
				slot7.txt.text = GameUtil.numberDisplay(slot8.quantity or ItemModel.instance:getItemQuantity(slot8.type, slot8.id))

				slot7.go:SetActive(true)

				if slot8.isCurrencySprite then
					UISpriteSetMgr.instance:setCurrencyItemSprite(slot7.image, tostring(slot8.icon or slot11) .. "_1")
				else
					if not slot8.icon then
						if slot12 then
							slot14 = ItemModel.instance:getItemSmallIcon(slot11)
						else
							slot15, slot14 = ItemModel.instance:getItemConfigAndIcon(slot10, slot11, slot12)
						end
					end

					slot7.simage:LoadImage(slot14)
				end

				if slot0:isNeedShieldAddBtn() then
					gohelper.setActive(slot7.btn.gameObject, false)
				end

				if slot10 == MaterialEnum.MaterialType.PowerPotion then
					slot0.powerItemObj = slot7

					slot0:_onRefreshDeadline()
				end

				slot9 = not slot8.isCurrencySprite
			end

			gohelper.setActive(slot7.image.gameObject, not slot9)
			gohelper.setActive(slot7.simage.gameObject, slot9)
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

	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.BanDiamond) then
		slot0:_hideAddBtn(CurrencyEnum.CurrencyType.Diamond)
	end
end

function slot0.getCurrencyItem(slot0, slot1)
	if not slot0._currencyObjs[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._gocurrency, "currency")
		slot2.go = slot3
		slot2.btn = gohelper.findChildButtonWithAudio(slot3, "#btn_currency/#btn")
		slot2.simage = gohelper.findChildSingleImage(slot3, "#btn_currency/#simage")
		slot2.image = gohelper.findChildImage(slot3, "#btn_currency/#image")
		slot2.btncurrency = gohelper.findChildButtonWithAudio(slot3, "#btn_currency")
		slot2.txt = gohelper.findChildText(slot3, "#btn_currency/content/#txt")
		slot2.click = gohelper.findChild(slot3, "#btn_currency/click")
		slot2.goCurrentTime = gohelper.findChild(slot3, "#btn_currency/#go_currenttime")
		slot2.txtTime = gohelper.findChildText(slot3, "#btn_currency/#go_currenttime/timetxt")
		slot2.deadlineEffect = gohelper.findChild(slot3, "#btn_currency/#effect")

		slot2.btn:AddClickListener(slot0._onClick, {
			self = slot0,
			index = slot1
		})
		slot2.btncurrency:AddClickListener(slot0._btncurrencyOnClick, {
			self = slot0,
			index = slot1
		})

		slot0._currencyObjs[slot1] = slot2

		gohelper.setActive(slot2.go, true)
	end

	return slot2
end

function slot0.isNeedShieldAddBtn(slot0)
	if slot0.foreShowBtn then
		return false
	end

	if slot0.foreHideBtn then
		return true
	end

	if not uv0.needShieldAddBtnViews then
		uv0.needShieldAddBtnViews = {
			[ViewName.StoreSkinConfirmView] = 1,
			[ViewName.CharacterLevelUpView] = 1,
			[ViewName.StoreView] = 1,
			[ViewName.EquipView] = 1,
			[ViewName.NormalStoreGoodsView] = 1,
			[ViewName.SummonConfirmView] = 1,
			[ViewName.CharacterRankUpView] = 1,
			[ViewName.CurrencyExchangeView] = 1,
			[ViewName.PowerView] = 1,
			[ViewName.PowerBuyTipView] = 1,
			[ViewName.CurrencyDiamondExchangeView] = 1,
			[ViewName.CharacterTalentLevelUpView] = 1,
			[ViewName.RoomStoreGoodsTipView] = 1,
			[ViewName.PackageStoreGoodsView] = 1,
			[ViewName.StoreSkinGoodsView] = 1,
			[ViewName.DecorateStoreGoodsView] = 1,
			[ViewName.VersionActivityStoreView] = 1,
			[ViewName.VersionActivityNormalStoreGoodsView] = 1,
			[ViewName.SeasonStoreView] = 1,
			[ViewName.VersionActivity1_2StoreView] = 1,
			[ViewName.V1a5BuildingView] = 1,
			[ViewName.V1a5BuildingDetailView] = 1,
			[ViewName.PowerActChangeView] = 1,
			[ViewName.SummonStoreGoodsView] = 1
		}
	end

	if not slot0.viewName then
		return false
	end

	return uv0.needShieldAddBtnViews[slot0.viewName] == 1
end

function slot0._hideAddBtn(slot0, slot1)
	for slot6 = #slot0.param, 1, -1 do
		if slot0.param[slot6] == slot1 then
			gohelper.setActive(slot0:getCurrencyItem(slot6).btn.gameObject, false)
		end
	end
end

function slot0._onRefreshDeadline(slot0)
	slot0:_onRefreshDeadlineUI()
	TaskDispatcher.runRepeat(slot0._onRefreshDeadlineUI, slot0, 1)
end

function slot0._onRefreshDeadlineUI(slot0)
	if CurrencyController.instance:getPowerItemDeadLineTime() and slot1 > 0 then
		if slot1 - ServerTime.now() <= 0 then
			ItemRpc.instance:sendGetItemListRequest()
			ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
			gohelper.setActive(slot0.powerItemObj.goCurrentTime, false)
			gohelper.setActive(slot0.powerItemObj.deadlineEffect, false)
			TaskDispatcher.cancelTask(slot0._onRefreshDeadlineUI, slot0)

			return
		end

		slot3, slot4, slot5 = TimeUtil.secondToRoughTime(slot2, true)
		slot0.powerItemObj.txtTime.text = string.format("%s%s", slot3, slot4)

		gohelper.setActive(slot0.powerItemObj.goCurrentTime, not slot5)
		gohelper.setActive(slot0.powerItemObj.deadlineEffect, not slot5)
	else
		gohelper.setActive(slot0.powerItemObj.goCurrentTime, false)
		gohelper.setActive(slot0.powerItemObj.deadlineEffect, false)
	end
end

slot0.prefabPath = "ui/viewres/common/currencyview.prefab"

return slot0
