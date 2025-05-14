module("modules.logic.signin.view.SignInListItem", package.seeall)

local var_0_0 = class("SignInListItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._gonormal = gohelper.findChild(arg_1_1, "normal")
	arg_1_0._bgImg = gohelper.findChildImage(arg_1_1, "normal/bg")
	arg_1_0._gobirthday = gohelper.findChild(arg_1_1, "birthday")
	arg_1_0._gobirthday_act = gohelper.findChild(arg_1_1, "birthday_act")
	arg_1_0._txtbirthdaydate = gohelper.findChildText(arg_1_1, "birthday/date")
	arg_1_0._txtbirthdaydate_act = gohelper.findChildText(arg_1_0._gobirthday_act, "date")
	arg_1_0._gosingle = gohelper.findChild(arg_1_1, "single")
	arg_1_0._imagesinglerolebg = gohelper.findChildImage(arg_1_0._gosingle, "bg")
	arg_1_0._simagesingleicon = gohelper.findChildSingleImage(arg_1_0._gosingle, "icon")
	arg_1_0._gomultiple = gohelper.findChild(arg_1_1, "multiple")
	arg_1_0._goroles = {}
	arg_1_0._imagerolesbg = {}
	arg_1_0._simagemultiroleicons = {}

	for iter_1_0 = 1, 3 do
		arg_1_0._goroles[iter_1_0] = gohelper.findChild(arg_1_0._gomultiple, "role" .. tostring(iter_1_0))
		arg_1_0._imagerolesbg[iter_1_0] = gohelper.findChildImage(arg_1_0._gomultiple, "role" .. tostring(iter_1_0) .. "/bg")
		arg_1_0._simagemultiroleicons[iter_1_0] = gohelper.findChildSingleImage(arg_1_0._gomultiple, "role" .. tostring(iter_1_0) .. "/icon")
	end

	arg_1_0._gocurrent = gohelper.findChild(arg_1_1, "current")
	arg_1_0._gogold = gohelper.findChild(arg_1_1, "#go_gold")
	arg_1_0._txtgolddaydate = gohelper.findChildText(arg_1_1, "#go_gold/date")
	arg_1_0._imageweek = gohelper.findChildImage(arg_1_1, "img_week")
	arg_1_0._imagebirthdayicon = gohelper.findChildImage(arg_1_1, "img_birthdayicon")
	arg_1_0._icon = gohelper.findChildSingleImage(arg_1_1, "icon")
	arg_1_0._gocount = gohelper.findChild(arg_1_1, "count")
	arg_1_0._quantity = gohelper.findChildText(arg_1_1, "count/num")
	arg_1_0._txtnormaldate = gohelper.findChildText(arg_1_1, "normal/date")
	arg_1_0._gomask = gohelper.findChild(arg_1_1, "mask")
	arg_1_0._gopast = gohelper.findChild(arg_1_1, "#go_past")
	arg_1_0._gosigned = gohelper.findChild(arg_1_1, "#go_past/#go_signed")
	arg_1_0._gonosigned = gohelper.findChild(arg_1_1, "#go_past/#go_nosigned")
	arg_1_0._pastselect = gohelper.findChild(arg_1_1, "#go_past/select")
	arg_1_0._get = gohelper.findChild(arg_1_1, "get")
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_1)
	arg_1_0._goanim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._bgcanvasGroup = arg_1_0._bgImg:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._datecanvasGroup = arg_1_0._txtnormaldate:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(arg_1_0._go, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	SignInController.instance:registerCallback(SignInEvent.ClickSignInMonthItem, arg_2_0._closeItemEffect, arg_2_0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInReply, arg_2_0._onGetSignInReply, arg_2_0)
	SignInController.instance:registerCallback(SignInEvent.SwitchBirthdayState, arg_2_0._onRefreshBirthdayState, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._itemClick:RemoveClickListener()
	SignInController.instance:unregisterCallback(SignInEvent.ClickSignInMonthItem, arg_3_0._closeItemEffect, arg_3_0)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInReply, arg_3_0._onGetSignInReply, arg_3_0)
	SignInController.instance:unregisterCallback(SignInEvent.SwitchBirthdayState, arg_3_0._onRefreshBirthdayState, arg_3_0)
end

function var_0_0._onItemClick(arg_4_0)
	if arg_4_0._isCurMonth then
		if not SignInModel.instance:isSignDayRewardGet(arg_4_0._index) and arg_4_0._index <= arg_4_0._curDate.day then
			GameFacade.showToast(ToastEnum.SignInError)

			return
		end
	elseif 12 * (arg_4_0._curDate.year - arg_4_0._targetDate[1] - 1) + 13 - arg_4_0._targetDate[2] + arg_4_0._curDate.month <= 13 and not SignInModel.instance:isHistoryDaySigned(arg_4_0._targetDate[2], arg_4_0._index) then
		GameFacade.showToast(ToastEnum.SignInError)

		return
	end

	if not arg_4_0._isCurMonth or arg_4_0._index <= arg_4_0._curDate.day then
		SignInModel.instance:setTargetDate(arg_4_0._targetDate[1], arg_4_0._targetDate[2], arg_4_0._index)
		SignInController.instance:dispatchEvent(SignInEvent.SignInItemClick)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_calendar_day_turn)
	elseif not arg_4_0._showBirthday then
		MaterialTipController.instance:showMaterialInfo(arg_4_0._mo.materilType, arg_4_0._mo.materilId)
	end
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	TaskDispatcher.cancelTask(arg_5_0._showItemEffect)

	if arg_5_0._mo == arg_5_1 then
		return
	end

	arg_5_0._mo = arg_5_1

	gohelper.setActive(arg_5_0._go, false)
	arg_5_0:_refreshData()
	arg_5_0:_startShowItem()
end

function var_0_0._refreshData(arg_6_0)
	arg_6_0._targetDate = SignInModel.instance:getSignTargetDate()
	arg_6_0._curDate = SignInModel.instance:getCurDate()
	arg_6_0._isCurMonth = arg_6_0._targetDate[1] == arg_6_0._curDate.year and arg_6_0._targetDate[2] == arg_6_0._curDate.month
	arg_6_0._isSelect = arg_6_0._index == arg_6_0._targetDate[3]
	arg_6_0._isFollowDay = arg_6_0._curDate.day < arg_6_0._index
	arg_6_0._rewardGet = SignInModel.instance:isSignDayRewardGet(arg_6_0._index)

	local var_6_0 = tonumber(PlayerModel.instance:getPlayinfo().registerTime)
	local var_6_1 = os.date("!*t", var_6_0 / 1000 + ServerTime.serverUtcOffset() - TimeDispatcher.DailyRefreshTime * 3600)

	arg_6_0._isBeforeRegisterTime = arg_6_0._targetDate[1] == var_6_1.year and arg_6_0._targetDate[2] == var_6_1.month and arg_6_0._index < var_6_1.day
	arg_6_0._showBirthday = SignInModel.instance:isShowBirthday()
	arg_6_0._birthHeros = SignInModel.instance:getSignBirthdayHeros(arg_6_0._targetDate[1], arg_6_0._targetDate[2], arg_6_0._index)

	if arg_6_0._isCurMonth and not arg_6_0._isBeforeRegisterTime then
		if arg_6_0._index == arg_6_0._curDate.day then
			arg_6_0._birthHeros = SignInModel.instance:getCurDayBirthdayHeros()
		elseif arg_6_0._index > arg_6_0._curDate.day then
			arg_6_0._birthHeros = SignInModel.instance:getNoSignBirthdayHeros(arg_6_0._targetDate[2], arg_6_0._index)
		elseif not arg_6_0._rewardGet then
			arg_6_0._birthHeros = SignInModel.instance:getNoSignBirthdayHeros(arg_6_0._targetDate[2], arg_6_0._index)
		end
	end

	local var_6_2 = #arg_6_0._birthHeros > 0

	if var_6_2 and arg_6_0._isCurMonth then
		local var_6_3 = arg_6_0._index >= arg_6_0._curDate.day

		if not var_6_3 then
			var_6_2 = var_6_2 and arg_6_0._rewardGet
		else
			var_6_2 = var_6_2 and var_6_3
		end
	end

	arg_6_0._isAllowShowHead = var_6_2
end

function var_0_0._startShowItem(arg_7_0)
	if SignInModel.instance:isNewShowDetail() then
		arg_7_0._delayTime = (arg_7_0._index - 1) % 7 * 0.03

		TaskDispatcher.runDelay(arg_7_0._showItemEffect, arg_7_0, arg_7_0._delayTime)

		return
	end

	if SignInModel.instance:isNewSwitch() then
		arg_7_0._delayTime = (arg_7_0._index - 1) % 7 * 0.03

		TaskDispatcher.runDelay(arg_7_0._showSwitchEffect, arg_7_0, arg_7_0._delayTime)

		return
	end

	arg_7_0._goanim.enabled = false

	arg_7_0:_refreshItem()
end

function var_0_0._refreshItem(arg_8_0)
	if arg_8_0._isCurMonth then
		if arg_8_0._showBirthday then
			arg_8_0:_refreshBirthdayCurrentMonth()
		else
			arg_8_0:_refreshNormalCurrentMonth()
		end
	elseif arg_8_0._showBirthday then
		arg_8_0:_refreshBirthdayPastMonth()
	else
		arg_8_0:_refreshNormalPastMonth()
	end
end

function var_0_0._showSwitchEffect(arg_9_0)
	if arg_9_0._delayTime >= 0.16 then
		SignInModel.instance:setNewSwitch(false)
	end

	arg_9_0._goanim.enabled = true

	arg_9_0._goanim:Play(UIAnimationName.Switch, 0, 0)
	TaskDispatcher.runDelay(arg_9_0._refreshItem, arg_9_0, 0.3)
end

function var_0_0._showItemEffect(arg_10_0)
	if arg_10_0._delayTime >= 0.16 then
		SignInModel.instance:setNewShowDetail(false)
	end

	arg_10_0:_refreshItem()

	arg_10_0._goanim.enabled = true

	arg_10_0._goanim:Play(UIAnimationName.Open)
end

function var_0_0._refreshNormalCurrentMonth(arg_11_0)
	local var_11_0 = "birthday_icon2"

	if arg_11_0._index >= arg_11_0._curDate.day then
		var_11_0 = "birthday_icon1"
	end

	local var_11_1 = SignInModel.instance:checkIsGoldDayAndPass(arg_11_0._targetDate, true, arg_11_0._index)
	local var_11_2 = TimeUtil.timeToTimeStamp(arg_11_0._targetDate[1], arg_11_0._targetDate[2], arg_11_0._index, TimeDispatcher.DailyRefreshTime, 1, 1)
	local var_11_3 = os.date("%w", var_11_2)

	gohelper.setActive(arg_11_0._go, true)
	gohelper.setActive(arg_11_0._gopast, false)
	gohelper.setActive(arg_11_0._gonormal, true)
	gohelper.setActive(arg_11_0._gomultiple, false)
	gohelper.setActive(arg_11_0._gosingle, false)

	arg_11_0._txtnormaldate.text = string.format("%02d", arg_11_0._index)
	arg_11_0._txtbirthdaydate.text = string.format("%02d", arg_11_0._index)
	arg_11_0._txtgolddaydate.text = string.format("%02d", arg_11_0._index)

	UISpriteSetMgr.instance:setSignInSprite(arg_11_0._imageweek, "date_small_" .. var_11_3)

	arg_11_0._bgcanvasGroup.alpha = 1
	arg_11_0._datecanvasGroup.alpha = 1

	gohelper.setActive(arg_11_0._icon.gameObject, true)
	gohelper.setActive(arg_11_0._gocount, true)
	gohelper.setActive(arg_11_0._gocurrent, arg_11_0._isSelect)

	if arg_11_0._isBeforeRegisterTime then
		arg_11_0:_refreshNormalPastMonth()
	else
		gohelper.setActive(arg_11_0._gopast, false)

		local var_11_4, var_11_5 = ItemModel.instance:getItemConfigAndIcon(arg_11_0._mo.materilType, arg_11_0._mo.materilId, true)

		if tonumber(arg_11_0._mo.materilType) == MaterialEnum.MaterialType.Equip then
			var_11_5 = ResUrl.getPropItemIcon(var_11_4.icon)
		end

		arg_11_0._icon:LoadImage(var_11_5)

		arg_11_0._quantity.text = luaLang("multiple") .. GameUtil.numberDisplay(arg_11_0._mo.quantity)

		gohelper.setActive(arg_11_0._get, arg_11_0._rewardGet)
		gohelper.setActive(arg_11_0._gomask, not arg_11_0._rewardGet and arg_11_0._index < arg_11_0._curDate.day)
	end

	gohelper.setActive(arg_11_0._gogold, var_11_1)
	gohelper.setActive(arg_11_0._imagebirthdayicon.gameObject, arg_11_0._isAllowShowHead)
	arg_11_0:_setActive_birthday(arg_11_0._isAllowShowHead)
	UISpriteSetMgr.instance:setSignInSprite(arg_11_0._imagebirthdayicon, var_11_0)
end

function var_0_0._refreshBirthdayCurrentMonth(arg_12_0)
	if arg_12_0._isBeforeRegisterTime then
		arg_12_0:_refreshBirthdayPastMonth()

		return
	end

	local var_12_0 = SignInModel.instance:isHistoryDaySigned(arg_12_0._targetDate[2], arg_12_0._index)
	local var_12_1 = arg_12_0._index >= arg_12_0._curDate.day
	local var_12_2 = not var_12_1
	local var_12_3 = TimeUtil.timeToTimeStamp(arg_12_0._targetDate[1], arg_12_0._targetDate[2], arg_12_0._index, TimeDispatcher.DailyRefreshTime, 1, 1)
	local var_12_4 = os.date("%w", var_12_3)
	local var_12_5 = arg_12_0._isAllowShowHead
	local var_12_6 = var_12_5 and #arg_12_0._birthHeros == 1
	local var_12_7 = var_12_5 and #arg_12_0._birthHeros > 1
	local var_12_8 = "birthday_icon2"
	local var_12_9 = "birthday_herobg2"

	if var_12_1 then
		var_12_8 = "birthday_icon1"
		var_12_9 = "birthday_herobg1"
	end

	gohelper.setActive(arg_12_0._go, true)
	gohelper.setActive(arg_12_0._gopast, false)

	arg_12_0._txtnormaldate.text = string.format("%02d", arg_12_0._index)
	arg_12_0._txtbirthdaydate.text = string.format("%02d", arg_12_0._index)
	arg_12_0._txtgolddaydate.text = string.format("%02d", arg_12_0._index)

	UISpriteSetMgr.instance:setSignInSprite(arg_12_0._imageweek, "date_small_" .. var_12_4)
	gohelper.setActive(arg_12_0._icon.gameObject, false)
	gohelper.setActive(arg_12_0._gocurrent, arg_12_0._isSelect)
	gohelper.setActive(arg_12_0._gomask, not arg_12_0._rewardGet and var_12_2)
	gohelper.setActive(arg_12_0._gonormal, true)
	gohelper.setActive(arg_12_0._gocount, false)
	gohelper.setActive(arg_12_0._get, arg_12_0._rewardGet)
	gohelper.setActive(arg_12_0._gosingle, var_12_6)
	gohelper.setActive(arg_12_0._gomultiple, var_12_7)
	gohelper.setActive(arg_12_0._gogold, false)
	gohelper.setActive(arg_12_0._imagebirthdayicon.gameObject, var_12_5)
	UISpriteSetMgr.instance:setSignInSprite(arg_12_0._imagebirthdayicon, var_12_8)

	if var_12_5 then
		if #arg_12_0._birthHeros > 1 then
			for iter_12_0 = 1, 3 do
				gohelper.setActive(arg_12_0._goroles[iter_12_0], iter_12_0 <= #arg_12_0._birthHeros)

				if iter_12_0 <= #arg_12_0._birthHeros then
					local var_12_10 = HeroModel.instance:getByHeroId(arg_12_0._birthHeros[iter_12_0])
					local var_12_11 = var_12_10 and var_12_10.skin or HeroConfig.instance:getHeroCO(arg_12_0._birthHeros[iter_12_0]).skinId

					arg_12_0._simagemultiroleicons[iter_12_0]:LoadImage(ResUrl.getHeadIconSmall(var_12_11))
					UISpriteSetMgr.instance:setSignInSprite(arg_12_0._imagerolesbg[iter_12_0], var_12_9)
				end
			end
		elseif #arg_12_0._birthHeros == 1 then
			local var_12_12 = HeroModel.instance:getByHeroId(arg_12_0._birthHeros[1])
			local var_12_13 = var_12_12 and var_12_12.skin or HeroConfig.instance:getHeroCO(arg_12_0._birthHeros[1]).skinId

			arg_12_0._simagesingleicon:LoadImage(ResUrl.getHeadIconSmall(var_12_13))
			UISpriteSetMgr.instance:setSignInSprite(arg_12_0._imagesinglerolebg, var_12_9)
		end
	end

	arg_12_0:_setActive_birthday(var_12_5)
end

function var_0_0._refreshNormalPastMonth(arg_13_0)
	local var_13_0 = SignInModel.instance:isHistoryDaySigned(arg_13_0._targetDate[2], arg_13_0._index)
	local var_13_1 = TimeUtil.timeToTimeStamp(arg_13_0._targetDate[1], arg_13_0._targetDate[2], arg_13_0._index, TimeDispatcher.DailyRefreshTime, 1, 1)
	local var_13_2 = os.date("%w", var_13_1)
	local var_13_3 = arg_13_0._isAllowShowHead and var_13_0
	local var_13_4 = SignInModel.instance:checkIsGoldDay(arg_13_0._targetDate, true, arg_13_0._index)

	arg_13_0._txtnormaldate.text = string.format("%02d", arg_13_0._index)
	arg_13_0._txtbirthdaydate.text = string.format("%02d", arg_13_0._index)
	arg_13_0._txtgolddaydate.text = string.format("%02d", arg_13_0._index)

	UISpriteSetMgr.instance:setSignInSprite(arg_13_0._imageweek, "date_small_" .. var_13_2)
	gohelper.setActive(arg_13_0._go, true)
	gohelper.setActive(arg_13_0._gopast, true)
	gohelper.setActive(arg_13_0._gonormal, true)
	gohelper.setActive(arg_13_0._gosingle, false)
	gohelper.setActive(arg_13_0._gomultiple, false)
	gohelper.setActive(arg_13_0._pastselect, arg_13_0._isSelect)
	gohelper.setActive(arg_13_0._gocurrent, false)
	gohelper.setActive(arg_13_0._gomask, false)
	gohelper.setActive(arg_13_0._icon.gameObject, false)
	gohelper.setActive(arg_13_0._gocount, false)
	gohelper.setActive(arg_13_0._get, false)

	arg_13_0._bgcanvasGroup.alpha = 0.6
	arg_13_0._datecanvasGroup.alpha = 0.6

	gohelper.setActive(arg_13_0._imagebirthdayicon.gameObject, var_13_3)

	if var_13_3 then
		UISpriteSetMgr.instance:setSignInSprite(arg_13_0._imagebirthdayicon, "birthday_icon2")
	end

	if 12 * (arg_13_0._curDate.year - arg_13_0._targetDate[1] - 1) + 13 - arg_13_0._targetDate[2] + arg_13_0._curDate.month > 13 then
		arg_13_0:_setActive_sign(false)
	else
		arg_13_0:_setActive_sign(not var_13_0)
	end

	gohelper.setActive(arg_13_0._gogold, var_13_4)
	arg_13_0:_setActive_birthday(var_13_3)
end

function var_0_0._refreshBirthdayPastMonth(arg_14_0)
	local var_14_0 = "birthday_herobg2"
	local var_14_1 = SignInModel.instance:isHistoryDaySigned(arg_14_0._targetDate[2], arg_14_0._index)
	local var_14_2 = arg_14_0._showBirthday and arg_14_0._isAllowShowHead and var_14_1
	local var_14_3 = var_14_2 and #arg_14_0._birthHeros == 1
	local var_14_4 = var_14_2 and #arg_14_0._birthHeros > 1
	local var_14_5 = TimeUtil.timeToTimeStamp(arg_14_0._targetDate[1], arg_14_0._targetDate[2], arg_14_0._index, TimeDispatcher.DailyRefreshTime, 1, 1)
	local var_14_6 = os.date("%w", var_14_5)

	arg_14_0._txtnormaldate.text = string.format("%02d", arg_14_0._index)
	arg_14_0._txtbirthdaydate.text = string.format("%02d", arg_14_0._index)
	arg_14_0._txtgolddaydate.text = string.format("%02d", arg_14_0._index)

	gohelper.setActive(arg_14_0._gopast, true)
	gohelper.setActive(arg_14_0._go, true)
	gohelper.setActive(arg_14_0._gomask, false)
	gohelper.setActive(arg_14_0._icon.gameObject, false)
	gohelper.setActive(arg_14_0._gocount, false)
	gohelper.setActive(arg_14_0._pastselect, arg_14_0._isSelect)
	gohelper.setActive(arg_14_0._gocurrent, false)
	gohelper.setActive(arg_14_0._get, false)

	arg_14_0._bgcanvasGroup.alpha = 0.6
	arg_14_0._datecanvasGroup.alpha = 0.6

	UISpriteSetMgr.instance:setSignInSprite(arg_14_0._imageweek, "date_small_" .. var_14_6)

	if arg_14_0._showBirthday then
		gohelper.setActive(arg_14_0._icon.gameObject, false)
	end

	gohelper.setActive(arg_14_0._gonormal, true)
	gohelper.setActive(arg_14_0._imagebirthdayicon.gameObject, var_14_2)

	if var_14_2 then
		UISpriteSetMgr.instance:setSignInSprite(arg_14_0._imagebirthdayicon, "birthday_icon2")
	end

	gohelper.setActive(arg_14_0._gosingle, var_14_3)
	gohelper.setActive(arg_14_0._gomultiple, var_14_4)

	if var_14_2 then
		if #arg_14_0._birthHeros > 1 then
			for iter_14_0 = 1, 3 do
				gohelper.setActive(arg_14_0._goroles[iter_14_0], iter_14_0 <= #arg_14_0._birthHeros)

				if iter_14_0 <= #arg_14_0._birthHeros then
					local var_14_7 = HeroModel.instance:getByHeroId(arg_14_0._birthHeros[iter_14_0])
					local var_14_8 = var_14_7 and var_14_7.skin or HeroConfig.instance:getHeroCO(arg_14_0._birthHeros[iter_14_0]).skinId

					arg_14_0._simagemultiroleicons[iter_14_0]:LoadImage(ResUrl.getHeadIconSmall(var_14_8))
					UISpriteSetMgr.instance:setSignInSprite(arg_14_0._imagerolesbg[iter_14_0], var_14_0)
				end
			end
		elseif #arg_14_0._birthHeros == 1 then
			local var_14_9 = HeroModel.instance:getByHeroId(arg_14_0._birthHeros[1])
			local var_14_10 = var_14_9 and var_14_9.skin or HeroConfig.instance:getHeroCO(arg_14_0._birthHeros[1]).skinId

			arg_14_0._simagesingleicon:LoadImage(ResUrl.getHeadIconSmall(var_14_10))
			UISpriteSetMgr.instance:setSignInSprite(arg_14_0._imagesinglerolebg, var_14_0)
		end
	end

	if 12 * (arg_14_0._curDate.year - arg_14_0._targetDate[1] - 1) + 13 - arg_14_0._targetDate[2] + arg_14_0._curDate.month > 13 then
		arg_14_0:_setActive_sign(false)
	else
		arg_14_0:_setActive_sign(not var_14_1)
	end

	gohelper.setActive(arg_14_0._gogold, false)
	arg_14_0:_setActive_birthday(var_14_2)
end

function var_0_0._closeItemEffect(arg_15_0)
	return
end

function var_0_0._onRefreshBirthdayState(arg_16_0)
	arg_16_0:_refreshData()
	arg_16_0:_startShowItem()
end

function var_0_0._onGetSignInReply(arg_17_0)
	if arg_17_0._targetDate[1] ~= arg_17_0._curDate.year or arg_17_0._targetDate[2] ~= arg_17_0._curDate.month or arg_17_0._curDate.day ~= arg_17_0._index then
		return
	end

	arg_17_0:_refreshData()
	arg_17_0:_startShowItem()
end

function var_0_0.onClose(arg_18_0)
	gohelper.setActive(arg_18_0._go, false)
end

function var_0_0.onDestroy(arg_19_0)
	arg_19_0._icon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_19_0._refreshItem, arg_19_0, 0.3)
	TaskDispatcher.cancelTask(arg_19_0._showItemEffect, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._showSwitchEffect, arg_19_0)
end

function var_0_0.parent(arg_20_0)
	return arg_20_0._mo.parent
end

function var_0_0.haveFestival(arg_21_0)
	local var_21_0 = arg_21_0:parent()

	return var_21_0 and var_21_0:haveFestival() or false
end

function var_0_0._setActive_birthday(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:haveFestival()

	gohelper.setActive(arg_22_0._gobirthday, arg_22_1 and not var_22_0)
	gohelper.setActive(arg_22_0._gobirthday_act, arg_22_1 and var_22_0)

	arg_22_0._txtbirthdaydate_act.text = string.format("%02d", arg_22_0._index)
end

function var_0_0._setActive_sign(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0._gosigned, arg_23_1)
	gohelper.setActive(arg_23_0._gonosigned, not arg_23_1)
end

return var_0_0
