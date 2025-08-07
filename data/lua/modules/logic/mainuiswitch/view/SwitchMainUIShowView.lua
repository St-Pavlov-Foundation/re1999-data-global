module("modules.logic.mainuiswitch.view.SwitchMainUIShowView", package.seeall)

local var_0_0 = class("SwitchMainUIShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golightspinecontrol = gohelper.findChild(arg_1_0.viewGO, "#go_lightspinecontrol")
	arg_1_0._btnquest = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_quest")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "left/#btn_quest/#go_taskreddot")
	arg_1_0._btnstorage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_storage")
	arg_1_0._godeadline = gohelper.findChild(arg_1_0.viewGO, "left/#btn_storage/#go_deadline")
	arg_1_0._godeadlineEffect = gohelper.findChild(arg_1_0.viewGO, "left/#btn_storage/#go_deadline/#effect")
	arg_1_0._imagetimebg = gohelper.findChildImage(arg_1_0.viewGO, "left/#btn_storage/#go_deadline/timebg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "left/#btn_storage/#go_deadline/#txt_time")
	arg_1_0._imagetimeicon = gohelper.findChildImage(arg_1_0.viewGO, "left/#btn_storage/#go_deadline/#txt_time/timeicon")
	arg_1_0._txtformat = gohelper.findChildText(arg_1_0.viewGO, "left/#btn_storage/#go_deadline/#txt_time/#txt_format")
	arg_1_0._gostoragereddot = gohelper.findChild(arg_1_0.viewGO, "left/#btn_storage/#go_storagereddot")
	arg_1_0._btnbank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_bank")
	arg_1_0._gobankreddot = gohelper.findChild(arg_1_0.viewGO, "left/#btn_bank/#go_bankreddot")
	arg_1_0._godeadlinebank = gohelper.findChild(arg_1_0.viewGO, "left/#btn_bank/#go_deadlinebank")
	arg_1_0._gobankeffect = gohelper.findChild(arg_1_0.viewGO, "left/#btn_bank/#go_bankeffect")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "right")
	arg_1_0._btnroom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_room")
	arg_1_0._goroomlock = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_roomlock")
	arg_1_0._goroomreddot = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_roomreddot")
	arg_1_0._gogreendot = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_roomreddot/#go_greendot")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_roomreddot/#go_reddot")
	arg_1_0._goroomgiftreddot = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_v1a9actroom")
	arg_1_0._gobanners = gohelper.findChild(arg_1_0.viewGO, "left/#go_banners")
	arg_1_0._goactivity = gohelper.findChild(arg_1_0.viewGO, "left/#go_activity")
	arg_1_0._btnswitchrole = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_switchrole")
	arg_1_0._gothumbnialreddot = gohelper.findChild(arg_1_0.viewGO, "left/#btn_switchrole/#go_thumbnailreddot")
	arg_1_0._btnplayerinfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_top/playerinfos/info/#btn_playerinfo")
	arg_1_0._imageslider = gohelper.findChildImage(arg_1_0.viewGO, "left_top/playerinfos/info/#image_slider")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "left_top/playerinfos/txtContainer/#txt_name")
	arg_1_0._txtid = gohelper.findChildText(arg_1_0.viewGO, "left_top/playerinfos/txtContainer/#txt_id")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "left_top/playerinfos/txtContainer/layout/#txt_level")
	arg_1_0._goplayerreddot = gohelper.findChild(arg_1_0.viewGO, "left_top/#go_reddot")
	arg_1_0._btnmail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_mail")
	arg_1_0._gomailreddot = gohelper.findChild(arg_1_0.viewGO, "left/#btn_mail/#go_mailreddot")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._btnpower = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_power")
	arg_1_0._btnrole = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_role")
	arg_1_0._btnsummon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_summon")
	arg_1_0._imagesummonnew1 = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/1/#image_summonnew")
	arg_1_0._imagesummonnew2 = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/2/#image_summonnew")
	arg_1_0._imagesummonfree = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/#image_free")
	arg_1_0._imagesummonreddot = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/#image_summonreddot")
	arg_1_0._txtpower = gohelper.findChildText(arg_1_0.viewGO, "right/txtContainer/#txt_power")
	arg_1_0._gospinescale = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_contentbg")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_en")
	arg_1_0._btnhide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_hide")
	arg_1_0._btnbgm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_bgm")
	arg_1_0._gobgmnone = gohelper.findChild(arg_1_0.viewGO, "#btn_bgm/none")
	arg_1_0._gobgmplay = gohelper.findChild(arg_1_0.viewGO, "#btn_bgm/playing")
	arg_1_0._btnlimitedshow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "limitedshow/#btn_limitedshow")
	arg_1_0._golimitedshow = gohelper.findChild(arg_1_0.viewGO, "limitedshow")
	arg_1_0._pcBtnHide = gohelper.findChild(arg_1_0._btnhide.gameObject, "#go_pcbtn")
	arg_1_0._pcBtnRoom = gohelper.findChild(arg_1_0._btnroom.gameObject, "#go_pcbtn")
	arg_1_0._pcBtnCharactor = gohelper.findChild(arg_1_0._btnrole.gameObject, "#go_pcbtn")
	arg_1_0._pcBtnSummon = gohelper.findChild(arg_1_0._btnsummon.gameObject, "#go_pcbtn")

	gohelper.setActive(arg_1_0._btnlimitedshow.gameObject, true)
	gohelper.setActive(arg_1_0._golimitedshow, false)

	arg_1_0._showMainView = true

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, arg_2_0._onSwitchUIVisible, arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, arg_2_0._onSwitchUIVisible, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, arg_3_0._onSwitchUIVisible, arg_3_0)
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, arg_3_0._onSwitchUIVisible, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goleft = gohelper.findChild(arg_4_0.viewGO, "left")
	arg_4_0._golefttop = gohelper.findChild(arg_4_0.viewGO, "left_top")
	arg_4_0._goright = gohelper.findChild(arg_4_0.viewGO, "right")
	arg_4_0._gorighttop = gohelper.findChild(arg_4_0.viewGO, "#go_righttop")
	arg_4_0._goactbgGo = gohelper.findChild(arg_4_0.viewGO, "#simage_actbg")
	arg_4_0._currencyObjs = {}
	arg_4_0._currencyView = arg_4_0:getResInst(CurrencyView.prefabPath, arg_4_0._gorighttop)
	arg_4_0._gocurrency = gohelper.findChild(arg_4_0._currencyView, "#go_container/#go_currency")

	arg_4_0:_initOffsetGos()

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_4_0._cameraAnimator.speed = 1
	arg_4_0._animatorRight = gohelper.findChildComponent(arg_4_0.viewGO, "right", typeof(UnityEngine.Animator))
	arg_4_0._openOtherView = false
	arg_4_0._goroomImage = gohelper.findChild(arg_4_0.viewGO, "right/#btn_room")
	arg_4_0._roomCanvasGroup = gohelper.onceAddComponent(arg_4_0._goroomImage, typeof(UnityEngine.CanvasGroup))
	arg_4_0._openMainThumbnailTime = Time.realtimeSinceStartup
	arg_4_0._animator.enabled = false
	arg_4_0._mailreddot = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._gomailreddot, SwitchMainUIReddotIcon)
	arg_4_0._taskreddot = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._gotaskreddot, SwitchMainUIReddotIcon)
	arg_4_0._bankreddot = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._gobankreddot, SwitchMainUIReddotIcon)

	gohelper.setActive(arg_4_0._btnhide.gameObject, false)
	gohelper.setActive(arg_4_0._goactivity.gameObject, false)
end

function var_0_0._checkActivityImgVisible(arg_5_0)
	local var_5_0 = ActivityModel.showActivityEffect()
	local var_5_1 = ActivityConfig.instance:getMainActAtmosphereConfig()

	if var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(var_5_1.mainView) do
			local var_5_2 = gohelper.findChild(arg_5_0.viewGO, iter_5_1)

			if var_5_2 then
				gohelper.setActive(var_5_2, var_5_0)
			end
		end
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_refreshBtns()
	arg_6_0:_refreshView()
	arg_6_0:_checkActivityImgVisible()
end

function var_0_0._refreshBtns(arg_7_0)
	local var_7_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Task)

	gohelper.setActive(arg_7_0._btnquest.gameObject, var_7_0)

	local var_7_1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Storage)

	gohelper.setActive(arg_7_0._btnstorage.gameObject, var_7_1)

	local var_7_2 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Bank)

	gohelper.setActive(arg_7_0._btnbank.gameObject, var_7_2)

	local var_7_3 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Room)

	gohelper.setActive(arg_7_0._btnroom.gameObject, var_7_3)

	local var_7_4 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room)

	arg_7_0._roomCanvasGroup.alpha = var_7_4 and 1 or 0.65

	gohelper.setActive(arg_7_0._goroomlock, not var_7_4)
	gohelper.setActive(arg_7_0._btnmail.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Mail))
	gohelper.setActive(arg_7_0._btnsummon.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon))
	gohelper.setActive(arg_7_0._btnrole.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Role))
	gohelper.setActive(arg_7_0._btnswitchrole.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.MainThumbnail))
end

function var_0_0._initOffsetGos(arg_8_0)
	arg_8_0._offsetGos = arg_8_0:getUserDataTb_()

	table.insert(arg_8_0._offsetGos, {
		offsetType = 1,
		go = arg_8_0._goleft
	})
	table.insert(arg_8_0._offsetGos, {
		offsetType = 1,
		go = arg_8_0._golefttop
	})
	table.insert(arg_8_0._offsetGos, {
		offsetType = 2,
		go = arg_8_0._goright
	})
	table.insert(arg_8_0._offsetGos, {
		offsetType = 2,
		go = arg_8_0._gorighttop
	})
	table.insert(arg_8_0._offsetGos, {
		offsetType = 2,
		go = arg_8_0._goactbgGo
	})

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._offsetGos) do
		iter_8_1.anchorX = recthelper.getAnchorX(iter_8_1.go.transform)
	end

	local var_8_0 = arg_8_0.viewContainer:isInitMainFullView()

	arg_8_0:_refreshOffest(var_8_0)
end

function var_0_0._refreshOffest(arg_9_0, arg_9_1)
	local var_9_0 = MainUISwitchEnum.SwitchMainUIOffsetType
	local var_9_1 = arg_9_1 and 1 or MainUISwitchEnum.MainUIScale

	transformhelper.setLocalScale(arg_9_0.viewGO.transform, var_9_1, var_9_1, 1)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._offsetGos) do
		local var_9_2 = var_9_0[iter_9_1.offsetType] and not arg_9_1 and var_9_0[iter_9_1.offsetType].offsetX or 0
		local var_9_3 = iter_9_1.anchorX + var_9_2

		recthelper.setAnchorX(iter_9_1.go.transform, var_9_3)
	end
end

function var_0_0._refreshView(arg_10_0)
	arg_10_0:_refreshRedDot()
	arg_10_0:_refreshPower()
	arg_10_0:_refreshBgm()
	arg_10_0:_refreshBackpack()
	arg_10_0:_refreshSummonNewFlag()
	arg_10_0:_setPlayerInfo(PlayerModel.instance:getPlayinfo())
	arg_10_0:_showCurrency()
	arg_10_0:showStoreDeadline(false)
end

function var_0_0._setPlayerInfo(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.level

	arg_11_0._txtlevel.text = arg_11_1.level
	arg_11_0._txtname.text = arg_11_1.name
	arg_11_0._txtid.text = "ID:" .. arg_11_1.userId

	local var_11_1 = arg_11_1.exp
	local var_11_2 = 0

	if var_11_0 < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		var_11_2 = PlayerConfig.instance:getPlayerLevelCO(var_11_0 + 1).exp
	else
		var_11_2 = PlayerConfig.instance:getPlayerLevelCO(var_11_0).exp
		var_11_1 = var_11_2
	end

	arg_11_0._imageslider.fillAmount = var_11_1 / var_11_2

	if arg_11_0._lastUpdateLevel ~= arg_11_1.level then
		arg_11_0._lastUpdateLevel = arg_11_1.level
	end

	arg_11_0:_refreshPower()
end

function var_0_0._refreshSummonNewFlag(arg_12_0)
	local var_12_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon)
	local var_12_1 = SummonMainModel.instance:entryHasNew()

	gohelper.setActive(arg_12_0._imagesummonnew1, var_12_0 and var_12_1)
	gohelper.setActive(arg_12_0._imagesummonnew2, var_12_0 and var_12_1)

	local var_12_2 = SummonMainModel.instance:entryHasFree()

	gohelper.setActive(arg_12_0._imagesummonfree, var_12_0 and var_12_2)

	local var_12_3 = SummonMainModel.instance:entryNeedReddot()

	gohelper.setActive(arg_12_0._imagesummonreddot, var_12_0 and var_12_3)
end

function var_0_0._refreshRedDot(arg_13_0)
	local var_13_0 = arg_13_0.viewParam and arg_13_0.viewParam.SkinId or MainUISwitchModel.instance:getCurUseUI()

	arg_13_0._mailreddot:setId(RedDotEnum.DotNode.MailBtn, nil, var_13_0)
	arg_13_0._taskreddot:setId(RedDotEnum.DotNode.TaskBtn, nil, var_13_0)
	arg_13_0._bankreddot:setId(RedDotEnum.DotNode.StoreBtn, nil, var_13_0)
	arg_13_0._mailreddot:defaultRefreshDot()
	arg_13_0._taskreddot:defaultRefreshDot()
	arg_13_0._bankreddot:defaultRefreshDot()
	RedDotController.instance:addRedDotTag(arg_13_0._goreddot, RedDotEnum.DotNode.MainRoomProductionFull)
	RedDotController.instance:addRedDotTag(arg_13_0._gogreendot, RedDotEnum.DotNode.MainRoomCharacterFaithGetFull)
	RedDotController.instance:addRedDotTag(arg_13_0._goroomgiftreddot, RedDotEnum.DotNode.RoomGift)
end

function var_0_0._refreshPower(arg_14_0)
	local var_14_0 = PlayerModel.instance:getPlayinfo().level
	local var_14_1 = PlayerConfig.instance:getPlayerLevelCO(var_14_0).maxAutoRecoverPower
	local var_14_2 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	local var_14_3 = var_14_2 and var_14_2.quantity or 0

	arg_14_0._txtpower.text = string.format("%s/%s", var_14_3, var_14_1)
end

function var_0_0._refreshBgm(arg_15_0)
	local var_15_0 = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Effect/bgm")
	local var_15_1 = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Obj/s01_obj_b")
	local var_15_2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local var_15_3 = BGMSwitchModel.instance:getMechineGear()

	gohelper.setActive(var_15_0, var_15_3 == BGMSwitchEnum.Gear.On1 and var_15_2)
	gohelper.setActive(var_15_1, var_15_2)

	if not var_15_1 then
		logError("_refreshBgm no bgmGo")
	end

	if not var_15_0 then
		logError("_refreshBgm no lightGo")
	end
end

function var_0_0._refreshBackpack(arg_16_0)
	arg_16_0._itemDeadline = BackpackModel.instance:getItemDeadline()
	arg_16_0._laststorageDeadLineHasDay = nil

	arg_16_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_17_0)
	if arg_17_0._itemDeadline and arg_17_0._itemDeadline > 0 then
		gohelper.setActive(arg_17_0._txttime.gameObject, true)

		local var_17_0 = arg_17_0._itemDeadline - ServerTime.now()

		if var_17_0 <= 0 then
			ItemRpc.instance:sendGetItemListRequest()
			ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
			gohelper.setActive(arg_17_0._godeadline, false)

			return
		end

		arg_17_0._txttime.text, arg_17_0._txtformat.text, arg_17_0._storageDeadLineHasDay = TimeUtil.secondToRoughTime(math.floor(var_17_0), true)

		gohelper.setActive(arg_17_0._godeadline, true)

		if arg_17_0._laststorageDeadLineHasDay == nil or arg_17_0._laststorageDeadLineHasDay ~= arg_17_0._storageDeadLineHasDay then
			UISpriteSetMgr.instance:setCommonSprite(arg_17_0._imagetimebg, arg_17_0._storageDeadLineHasDay and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(arg_17_0._imagetimeicon, arg_17_0._storageDeadLineHasDay and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(arg_17_0._txttime, arg_17_0._storageDeadLineHasDay and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(arg_17_0._txtformat, arg_17_0._storageDeadLineHasDay and "#98D687" or "#E99B56")
			gohelper.setActive(arg_17_0._godeadlineEffect, not arg_17_0._storageDeadLineHasDay)

			arg_17_0._laststorageDeadLineHasDay = arg_17_0._storageDeadLineHasDay
		end
	else
		gohelper.setActive(arg_17_0._godeadline, false)
		gohelper.setActive(arg_17_0._txttime.gameObject, false)
	end
end

function var_0_0.showStoreDeadline(arg_18_0, arg_18_1)
	if not arg_18_0.viewGO then
		return
	end

	local var_18_0 = arg_18_0:getOrCreateStoreDeadline()

	var_18_0.needShow = arg_18_1 or var_18_0.needShow

	if var_18_0.needShow then
		local var_18_1 = false
		local var_18_2 = StoreConfig.instance:getTabConfig(StoreEnum.StoreId.LimitStore)
		local var_18_3 = 0

		if var_18_2 then
			local var_18_4 = StoreHelper.getRemainExpireTime(var_18_2)

			if var_18_4 and var_18_4 > 0 and var_18_4 <= TimeUtil.OneDaySecond * 7 then
				var_18_3 = var_18_4
			end
		end

		local var_18_5 = StoreHelper.getRemainExpireTimeDeepByStoreId(StoreEnum.StoreId.DecorateStore)

		if var_18_5 > 0 then
			var_18_3 = var_18_3 == 0 and var_18_5 or Mathf.Min(var_18_5, var_18_3)
		end

		if var_18_3 > 0 then
			gohelper.setActive(var_18_0.godeadline, true)
			gohelper.setActive(var_18_0.txttime.gameObject, true)

			local var_18_6

			var_18_0.txttime.text, var_18_0.txtformat.text, var_18_6 = TimeUtil.secondToRoughTime(math.floor(var_18_3), true)

			UISpriteSetMgr.instance:setCommonSprite(var_18_0.imagetimebg, var_18_6 and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(var_18_0.imagetimeicon, var_18_6 and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(var_18_0.txttime, var_18_6 and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(var_18_0.txtformat, var_18_6 and "#98D687" or "#E99B56")
			gohelper.setActive(var_18_0.godeadlineEffect, not var_18_6)

			return
		end
	end

	gohelper.setActive(var_18_0.godeadline, false)
	gohelper.setActive(var_18_0.txttime.gameObject, false)
end

function var_0_0.getOrCreateStoreDeadline(arg_19_0)
	if not arg_19_0._deadlineStore then
		arg_19_0._deadlineStore = arg_19_0:getUserDataTb_()
		arg_19_0._deadlineStore.godeadline = arg_19_0._godeadlinebank
		arg_19_0._deadlineStore.godeadlineEffect = gohelper.findChild(arg_19_0._deadlineStore.godeadline, "#effect")
		arg_19_0._deadlineStore.txttime = gohelper.findChildText(arg_19_0._deadlineStore.godeadline, "#txt_time")
		arg_19_0._deadlineStore.txtformat = gohelper.findChildText(arg_19_0._deadlineStore.godeadline, "#txt_time/#txt_format")
		arg_19_0._deadlineStore.imagetimebg = gohelper.findChildImage(arg_19_0._deadlineStore.godeadline, "timebg")
		arg_19_0._deadlineStore.imagetimeicon = gohelper.findChildImage(arg_19_0._deadlineStore.godeadline, "#txt_time/timeicon")
	end

	return arg_19_0._deadlineStore
end

function var_0_0.showBankNewEffect(arg_20_0, arg_20_1)
	gohelper.setActive(arg_20_0._gobankeffect, arg_20_1)
end

function var_0_0._showCurrency(arg_21_0)
	local var_21_0 = {
		CurrencyEnum.CurrencyType.Gold,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon,
		CurrencyEnum.CurrencyType.Diamond
	}

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		local var_21_1 = arg_21_0:getCurrencyItem(iter_21_0)
		local var_21_2 = CurrencyModel.instance:getCurrency(iter_21_1)
		local var_21_3 = CurrencyConfig.instance:getCurrencyCo(iter_21_1)
		local var_21_4 = var_21_2 and var_21_2.quantity or 0
		local var_21_5 = var_21_3.icon

		UISpriteSetMgr.instance:setCurrencyItemSprite(var_21_1.image, var_21_5 .. "_1")

		var_21_1.txt.text = GameUtil.numberDisplay(var_21_4)

		gohelper.setActive(var_21_1.go, true)
	end
end

function var_0_0.getCurrencyItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._currencyObjs[arg_22_1]

	if not var_22_0 then
		var_22_0 = arg_22_0:getUserDataTb_()

		local var_22_1 = gohelper.cloneInPlace(arg_22_0._gocurrency, "currency")

		var_22_0.go = var_22_1
		var_22_0.image = gohelper.findChildImage(var_22_1, "#btn_currency/#image")
		var_22_0.simage = gohelper.findChildSingleImage(var_22_1, "#btn_currency/#simage")
		var_22_0.txt = gohelper.findChildText(var_22_1, "#btn_currency/content/#txt")

		gohelper.setActive(var_22_0.simage, false)

		arg_22_0._currencyObjs[arg_22_1] = var_22_0
	end

	return var_22_0
end

function var_0_0._onSwitchUIVisible(arg_23_0, arg_23_1)
	arg_23_0:_refreshOffest(not arg_23_1)
end

function var_0_0.onClose(arg_24_0)
	return
end

return var_0_0
