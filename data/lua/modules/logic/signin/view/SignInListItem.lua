module("modules.logic.signin.view.SignInListItem", package.seeall)

slot0 = class("SignInListItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._gonormal = gohelper.findChild(slot1, "normal")
	slot0._bgImg = gohelper.findChildImage(slot1, "normal/bg")
	slot0._gobirthday = gohelper.findChild(slot1, "birthday")
	slot0._txtbirthdaydate = gohelper.findChildText(slot1, "birthday/date")
	slot0._gosingle = gohelper.findChild(slot1, "birthday/single")
	slot0._imagesinglerolebg = gohelper.findChildImage(slot1, "birthday/single/bg")
	slot0._simagesingleicon = gohelper.findChildSingleImage(slot1, "birthday/single/icon")
	slot5 = "birthday/multiple"
	slot0._gomultiple = gohelper.findChild(slot1, slot5)
	slot0._goroles = {}
	slot0._imagerolesbg = {}
	slot0._simagemultiroleicons = {}

	for slot5 = 1, 3 do
		slot0._goroles[slot5] = gohelper.findChild(slot1, "birthday/multiple/role" .. tostring(slot5))
		slot0._imagerolesbg[slot5] = gohelper.findChildImage(slot1, "birthday/multiple/role" .. tostring(slot5) .. "/bg")
		slot0._simagemultiroleicons[slot5] = gohelper.findChildSingleImage(slot1, "birthday/multiple/role" .. tostring(slot5) .. "/icon")
	end

	slot0._gocurrent = gohelper.findChild(slot1, "current")
	slot0._gogold = gohelper.findChild(slot1, "#go_gold")
	slot0._txtgolddaydate = gohelper.findChildText(slot1, "#go_gold/date")
	slot0._imageweek = gohelper.findChildImage(slot1, "img_week")
	slot0._imagebirthdayicon = gohelper.findChildImage(slot1, "img_birthdayicon")
	slot0._icon = gohelper.findChildSingleImage(slot1, "icon")
	slot0._gocount = gohelper.findChild(slot1, "count")
	slot0._quantity = gohelper.findChildText(slot1, "count/num")
	slot0._txtnormaldate = gohelper.findChildText(slot1, "normal/date")
	slot0._gomask = gohelper.findChild(slot1, "mask")
	slot0._gopast = gohelper.findChild(slot1, "#go_past")
	slot0._gosigned = gohelper.findChild(slot1, "#go_past/#go_signed")
	slot0._gonosigned = gohelper.findChild(slot1, "#go_past/#go_nosigned")
	slot0._pastselect = gohelper.findChild(slot1, "#go_past/select")
	slot0._get = gohelper.findChild(slot1, "get")
	slot0._itemClick = gohelper.getClickWithAudio(slot1)
	slot0._goanim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._bgcanvasGroup = slot0._bgImg:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._datecanvasGroup = slot0._txtnormaldate:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(slot0._go, false)
end

function slot0.addEventListeners(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
	SignInController.instance:registerCallback(SignInEvent.ClickSignInMonthItem, slot0._closeItemEffect, slot0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInReply, slot0._onGetSignInReply, slot0)
	SignInController.instance:registerCallback(SignInEvent.SwitchBirthdayState, slot0._onRefreshBirthdayState, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._itemClick:RemoveClickListener()
	SignInController.instance:unregisterCallback(SignInEvent.ClickSignInMonthItem, slot0._closeItemEffect, slot0)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInReply, slot0._onGetSignInReply, slot0)
	SignInController.instance:unregisterCallback(SignInEvent.SwitchBirthdayState, slot0._onRefreshBirthdayState, slot0)
end

function slot0._onItemClick(slot0)
	if slot0._isCurMonth then
		if not SignInModel.instance:isSignDayRewardGet(slot0._index) and slot0._index <= slot0._curDate.day then
			GameFacade.showToast(ToastEnum.SignInError)

			return
		end
	elseif 12 * (slot0._curDate.year - slot0._targetDate[1] - 1) + 13 - slot0._targetDate[2] + slot0._curDate.month <= 13 and not SignInModel.instance:isHistoryDaySigned(slot0._targetDate[2], slot0._index) then
		GameFacade.showToast(ToastEnum.SignInError)

		return
	end

	if not slot0._isCurMonth or slot0._index <= slot0._curDate.day then
		SignInModel.instance:setTargetDate(slot0._targetDate[1], slot0._targetDate[2], slot0._index)
		SignInController.instance:dispatchEvent(SignInEvent.SignInItemClick)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_calendar_day_turn)
	elseif not slot0._showBirthday then
		MaterialTipController.instance:showMaterialInfo(slot0._mo.materilType, slot0._mo.materilId)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._showItemEffect)

	if slot0._mo == slot1 then
		return
	end

	slot0._mo = slot1

	gohelper.setActive(slot0._go, false)
	slot0:_refreshData()
	slot0:_startShowItem()
end

function slot0._refreshData(slot0)
	slot0._targetDate = SignInModel.instance:getSignTargetDate()
	slot0._curDate = SignInModel.instance:getCurDate()
	slot0._isCurMonth = slot0._targetDate[1] == slot0._curDate.year and slot0._targetDate[2] == slot0._curDate.month
	slot0._isSelect = slot0._index == slot0._targetDate[3]
	slot0._isFollowDay = slot0._curDate.day < slot0._index
	slot0._rewardGet = SignInModel.instance:isSignDayRewardGet(slot0._index)
	slot0._isBeforeRegisterTime = slot0._targetDate[1] == os.date("!*t", tonumber(PlayerModel.instance:getPlayinfo().registerTime) / 1000 + ServerTime.serverUtcOffset() - TimeDispatcher.DailyRefreshTime * 3600).year and slot0._targetDate[2] == slot2.month and slot0._index < slot2.day
	slot0._showBirthday = SignInModel.instance:isShowBirthday()
	slot0._birthHeros = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._index)

	if slot0._isCurMonth and not slot0._isBeforeRegisterTime then
		if slot0._index == slot0._curDate.day then
			slot0._birthHeros = SignInModel.instance:getCurDayBirthdayHeros()
		elseif slot0._curDate.day < slot0._index then
			slot0._birthHeros = SignInModel.instance:getNoSignBirthdayHeros(slot0._targetDate[2], slot0._index)
		elseif not slot0._rewardGet then
			slot0._birthHeros = SignInModel.instance:getNoSignBirthdayHeros(slot0._targetDate[2], slot0._index)
		end
	end
end

function slot0._startShowItem(slot0)
	if SignInModel.instance:isNewShowDetail() then
		slot0._delayTime = (slot0._index - 1) % 7 * 0.03

		TaskDispatcher.runDelay(slot0._showItemEffect, slot0, slot0._delayTime)

		return
	end

	if SignInModel.instance:isNewSwitch() then
		slot0._delayTime = (slot0._index - 1) % 7 * 0.03

		TaskDispatcher.runDelay(slot0._showSwitchEffect, slot0, slot0._delayTime)

		return
	end

	slot0._goanim.enabled = false

	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	if slot0._isCurMonth then
		if slot0._showBirthday then
			slot0:_refreshBirthdayCurrentMonth()
		else
			slot0:_refreshNormalCurrentMonth()
		end
	elseif slot0._showBirthday then
		slot0:_refreshBirthdayPastMonth()
	else
		slot0:_refreshNormalPastMonth()
	end
end

function slot0._showSwitchEffect(slot0)
	if slot0._delayTime >= 0.16 then
		SignInModel.instance:setNewSwitch(false)
	end

	slot0._goanim.enabled = true

	slot0._goanim:Play(UIAnimationName.Switch, 0, 0)
	TaskDispatcher.runDelay(slot0._refreshItem, slot0, 0.3)
end

function slot0._showItemEffect(slot0)
	if slot0._delayTime >= 0.16 then
		SignInModel.instance:setNewShowDetail(false)
	end

	slot0:_refreshItem()

	slot0._goanim.enabled = true

	slot0._goanim:Play(UIAnimationName.Open)
end

function slot0._refreshNormalCurrentMonth(slot0)
	gohelper.setActive(slot0._go, true)
	gohelper.setActive(slot0._gopast, false)
	gohelper.setActive(slot0._gonormal, true)
	gohelper.setActive(slot0._gomultiple, false)
	gohelper.setActive(slot0._gosingle, false)

	slot0._txtnormaldate.text = string.format("%02d", slot0._index)
	slot0._txtbirthdaydate.text = string.format("%02d", slot0._index)
	slot0._txtgolddaydate.text = string.format("%02d", slot0._index)

	UISpriteSetMgr.instance:setSignInSprite(slot0._imageweek, "date_small_" .. os.date("%w", TimeUtil.timeToTimeStamp(slot0._targetDate[1], slot0._targetDate[2], slot0._index, TimeDispatcher.DailyRefreshTime, 1, 1)))

	slot0._bgcanvasGroup.alpha = 1
	slot0._datecanvasGroup.alpha = 1

	gohelper.setActive(slot0._icon.gameObject, true)
	gohelper.setActive(slot0._gocount, true)
	gohelper.setActive(slot0._gocurrent, slot0._isSelect)

	if slot0._isBeforeRegisterTime then
		slot0:_refreshNormalPastMonth()
	else
		gohelper.setActive(slot0._gopast, false)

		slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot0._mo.materilType, slot0._mo.materilId, true)

		if tonumber(slot0._mo.materilType) == MaterialEnum.MaterialType.Equip then
			slot4 = ResUrl.getPropItemIcon(slot3.icon)
		end

		slot0._icon:LoadImage(slot4)

		slot0._quantity.text = luaLang("multiple") .. GameUtil.numberDisplay(slot0._mo.quantity)

		gohelper.setActive(slot0._get, slot0._rewardGet)
		gohelper.setActive(slot0._gomask, not slot0._rewardGet and slot0._index < slot0._curDate.day)
	end

	slot3 = "birthday_icon2"

	if slot0._curDate.day <= slot0._index then
		slot3 = "birthday_icon1"
	end

	gohelper.setActive(slot0._gogold, SignInModel.instance:checkIsGoldDayAndPass(slot0._targetDate, true, slot0._index))
	gohelper.setActive(slot0._imagebirthdayicon.gameObject, #slot0._birthHeros > 0)
	gohelper.setActive(slot0._gobirthday, #slot0._birthHeros > 0)
	UISpriteSetMgr.instance:setSignInSprite(slot0._imagebirthdayicon, slot3)
end

function slot0._refreshBirthdayCurrentMonth(slot0)
	if slot0._isBeforeRegisterTime then
		slot0:_refreshBirthdayPastMonth()

		return
	end

	gohelper.setActive(slot0._go, true)
	gohelper.setActive(slot0._gopast, false)

	slot0._txtnormaldate.text = string.format("%02d", slot0._index)
	slot0._txtbirthdaydate.text = string.format("%02d", slot0._index)
	slot0._txtgolddaydate.text = string.format("%02d", slot0._index)

	UISpriteSetMgr.instance:setSignInSprite(slot0._imageweek, "date_small_" .. os.date("%w", TimeUtil.timeToTimeStamp(slot0._targetDate[1], slot0._targetDate[2], slot0._index, TimeDispatcher.DailyRefreshTime, 1, 1)))
	gohelper.setActive(slot0._icon.gameObject, false)
	gohelper.setActive(slot0._gocurrent, slot0._isSelect)
	gohelper.setActive(slot0._gomask, not slot0._rewardGet and slot0._index < slot0._curDate.day)
	gohelper.setActive(slot0._gonormal, true)
	gohelper.setActive(slot0._gocount, false)
	gohelper.setActive(slot0._get, slot0._rewardGet)

	slot3 = "birthday_icon2"
	slot4 = "birthday_herobg2"

	if slot0._curDate.day <= slot0._index then
		slot3 = "birthday_icon1"
		slot4 = "birthday_herobg1"
	end

	gohelper.setActive(slot0._gosingle, #slot0._birthHeros == 1)
	gohelper.setActive(slot0._gomultiple, #slot0._birthHeros > 1)
	gohelper.setActive(slot0._gobirthday, #slot0._birthHeros > 0)
	gohelper.setActive(slot0._gogold, false)
	gohelper.setActive(slot0._imagebirthdayicon.gameObject, #slot0._birthHeros > 0)
	UISpriteSetMgr.instance:setSignInSprite(slot0._imagebirthdayicon, slot3)

	if #slot0._birthHeros > 1 then
		for slot8 = 1, 3 do
			gohelper.setActive(slot0._goroles[slot8], slot8 <= #slot0._birthHeros)

			if slot8 <= #slot0._birthHeros then
				slot0._simagemultiroleicons[slot8]:LoadImage(ResUrl.getHeadIconSmall(HeroModel.instance:getByHeroId(slot0._birthHeros[slot8]) and slot9.skin or HeroConfig.instance:getHeroCO(slot0._birthHeros[slot8]).skinId))
				UISpriteSetMgr.instance:setSignInSprite(slot0._imagerolesbg[slot8], slot4)
			end
		end
	elseif #slot0._birthHeros == 1 then
		slot0._simagesingleicon:LoadImage(ResUrl.getHeadIconSmall(HeroModel.instance:getByHeroId(slot0._birthHeros[1]) and slot5.skin or HeroConfig.instance:getHeroCO(slot0._birthHeros[1]).skinId))
		UISpriteSetMgr.instance:setSignInSprite(slot0._imagesinglerolebg, slot4)
	end
end

function slot0._refreshNormalPastMonth(slot0)
	slot0._txtnormaldate.text = string.format("%02d", slot0._index)
	slot0._txtbirthdaydate.text = string.format("%02d", slot0._index)
	slot0._txtgolddaydate.text = string.format("%02d", slot0._index)

	UISpriteSetMgr.instance:setSignInSprite(slot0._imageweek, "date_small_" .. os.date("%w", TimeUtil.timeToTimeStamp(slot0._targetDate[1], slot0._targetDate[2], slot0._index, TimeDispatcher.DailyRefreshTime, 1, 1)))
	gohelper.setActive(slot0._go, true)
	gohelper.setActive(slot0._gopast, true)
	gohelper.setActive(slot0._gonormal, true)
	gohelper.setActive(slot0._gosingle, false)
	gohelper.setActive(slot0._gomultiple, false)
	gohelper.setActive(slot0._pastselect, slot0._isSelect)
	gohelper.setActive(slot0._gocurrent, false)
	gohelper.setActive(slot0._gomask, false)
	gohelper.setActive(slot0._icon.gameObject, false)
	gohelper.setActive(slot0._gocount, false)
	gohelper.setActive(slot0._get, false)
	gohelper.setActive(slot0._gobirthday, false)

	slot0._bgcanvasGroup.alpha = 0.6
	slot0._datecanvasGroup.alpha = 0.6

	gohelper.setActive(slot0._imagebirthdayicon.gameObject, #slot0._birthHeros > 0 and SignInModel.instance:isHistoryDaySigned(slot0._targetDate[2], slot0._index))

	if #slot0._birthHeros > 0 and slot1 then
		UISpriteSetMgr.instance:setSignInSprite(slot0._imagebirthdayicon, "birthday_icon2")
		gohelper.setActive(slot0._gobirthday, true)
	end

	if not slot1 then
		gohelper.setActive(slot0._gosigned, true)
		gohelper.setActive(slot0._gonosigned, false)
	else
		gohelper.setActive(slot0._gosigned, false)
		gohelper.setActive(slot0._gonosigned, true)
	end

	if 12 * (slot0._curDate.year - slot0._targetDate[1] - 1) + 13 - slot0._targetDate[2] + slot0._curDate.month > 13 then
		gohelper.setActive(slot0._gosigned, false)
		gohelper.setActive(slot0._gonosigned, true)
	end

	gohelper.setActive(slot0._gogold, SignInModel.instance:checkIsGoldDay(slot0._targetDate, true, slot0._index))
end

function slot0._refreshBirthdayPastMonth(slot0)
	slot0._txtnormaldate.text = string.format("%02d", slot0._index)
	slot0._txtbirthdaydate.text = string.format("%02d", slot0._index)
	slot0._txtgolddaydate.text = string.format("%02d", slot0._index)

	gohelper.setActive(slot0._gopast, true)
	gohelper.setActive(slot0._go, true)
	gohelper.setActive(slot0._gomask, false)
	gohelper.setActive(slot0._icon.gameObject, false)
	gohelper.setActive(slot0._gocount, false)
	gohelper.setActive(slot0._pastselect, slot0._isSelect)
	gohelper.setActive(slot0._gocurrent, false)
	gohelper.setActive(slot0._get, false)

	slot0._bgcanvasGroup.alpha = 0.6
	slot0._datecanvasGroup.alpha = 0.6

	UISpriteSetMgr.instance:setSignInSprite(slot0._imageweek, "date_small_" .. os.date("%w", TimeUtil.timeToTimeStamp(slot0._targetDate[1], slot0._targetDate[2], slot0._index, TimeDispatcher.DailyRefreshTime, 1, 1)))

	if not SignInModel.instance:isHistoryDaySigned(slot0._targetDate[2], slot0._index) then
		gohelper.setActive(slot0._gosigned, true)
		gohelper.setActive(slot0._gonosigned, false)
	else
		gohelper.setActive(slot0._gosigned, false)
		gohelper.setActive(slot0._gonosigned, true)
	end

	if slot0._showBirthday then
		gohelper.setActive(slot0._icon.gameObject, false)
	end

	slot4 = slot0._showBirthday and #slot0._birthHeros > 0

	gohelper.setActive(slot0._gonormal, true)
	gohelper.setActive(slot0._imagebirthdayicon.gameObject, slot4 and slot1)
	gohelper.setActive(slot0._gobirthday, slot4 and slot1)

	if slot4 and slot1 then
		UISpriteSetMgr.instance:setSignInSprite(slot0._imagebirthdayicon, "birthday_icon2")
	end

	slot5 = "birthday_herobg2"

	gohelper.setActive(slot0._gosingle, #slot0._birthHeros == 1)
	gohelper.setActive(slot0._gomultiple, #slot0._birthHeros > 1)

	if #slot0._birthHeros > 1 then
		for slot9 = 1, 3 do
			gohelper.setActive(slot0._goroles[slot9], slot9 <= #slot0._birthHeros)

			if slot9 <= #slot0._birthHeros then
				slot0._simagemultiroleicons[slot9]:LoadImage(ResUrl.getHeadIconSmall(HeroModel.instance:getByHeroId(slot0._birthHeros[slot9]) and slot10.skin or HeroConfig.instance:getHeroCO(slot0._birthHeros[slot9]).skinId))
				UISpriteSetMgr.instance:setSignInSprite(slot0._imagerolesbg[slot9], slot5)
			end
		end
	elseif #slot0._birthHeros == 1 then
		slot0._simagesingleicon:LoadImage(ResUrl.getHeadIconSmall(HeroModel.instance:getByHeroId(slot0._birthHeros[1]) and slot6.skin or HeroConfig.instance:getHeroCO(slot0._birthHeros[1]).skinId))
		UISpriteSetMgr.instance:setSignInSprite(slot0._imagesinglerolebg, slot5)
	end

	if 12 * (slot0._curDate.year - slot0._targetDate[1] - 1) + 13 - slot0._targetDate[2] + slot0._curDate.month > 13 then
		gohelper.setActive(slot0._gosigned, false)
		gohelper.setActive(slot0._gonosigned, true)
	end

	gohelper.setActive(slot0._gogold, false)
end

function slot0._closeItemEffect(slot0)
end

function slot0._onRefreshBirthdayState(slot0)
	slot0:_refreshData()
	slot0:_startShowItem()
end

function slot0._onGetSignInReply(slot0)
	if slot0._targetDate[1] ~= slot0._curDate.year or slot0._targetDate[2] ~= slot0._curDate.month or slot0._curDate.day ~= slot0._index then
		return
	end

	slot0:_refreshData()
	slot0:_startShowItem()
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0._go, false)
end

function slot0.onDestroy(slot0)
	slot0._icon:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._refreshItem, slot0, 0.3)
	TaskDispatcher.cancelTask(slot0._showItemEffect, slot0)
	TaskDispatcher.cancelTask(slot0._showSwitchEffect, slot0)
end

return slot0
