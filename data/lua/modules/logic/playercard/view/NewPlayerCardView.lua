module("modules.logic.playercard.view.NewPlayerCardView", package.seeall)

local var_0_0 = class("NewPlayerCardView", BaseView)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1

	arg_1_0:onInitView()
end

function var_0_0.canOpen(arg_2_0, arg_2_1)
	arg_2_0:onOpen(arg_2_1)
	arg_2_0:addEvents()
end

function var_0_0.onInitView(arg_3_0)
	arg_3_0._root = gohelper.findChild(arg_3_0.viewGO, "root")
	arg_3_0._simagerole = gohelper.findChildSingleImage(arg_3_0.viewGO, "root/main/top/role/skinnode/#simage_role")
	arg_3_0._imageIcon = gohelper.findChildImage(arg_3_0.viewGO, "root/main/top/role/skinnode/#simage_role")
	arg_3_0._btnrole = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "root/main/top/role/skinnode/#simage_role/#btn_role")
	arg_3_0._btnleftcontent = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "root/main/top/leftcontent/#btn_leftcontent")
	arg_3_0._btnrightcontent = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "root/main/top/rightcontent/#btn_rightcontent")
	arg_3_0._txtdungeon = gohelper.findChildText(arg_3_0.viewGO, "root/main/top/rightcontent/#txt_dungeon")
	arg_3_0._gocritter = gohelper.findChild(arg_3_0.viewGO, "root/main/critter/go_critter")
	arg_3_0._gocritterlight = gohelper.findChild(arg_3_0.viewGO, "root/main/critter/light")
	arg_3_0._btncritter = gohelper.findChildButton(arg_3_0.viewGO, "root/main/critter/#btn_critter")
	arg_3_0._goBgEffect = gohelper.findChild(arg_3_0.viewGO, "#bg_effect")
	arg_3_0._goTopEffect = gohelper.findChild(arg_3_0.viewGO, "#top_effect")
	arg_3_0._openswitchskin = false
	arg_3_0._progressItemList = {}
	arg_3_0._baseInfoItemList = {}
	arg_3_0._animator = arg_3_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_3_0._has_onInitView = true

	if arg_3_0._editableInitView then
		arg_3_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0._btnrole:AddClickListener(arg_4_0._btnroleOnClick, arg_4_0)
	arg_4_0._btnleftcontent:AddClickListener(arg_4_0._btnleftcontentOnClick, arg_4_0)
	arg_4_0._btnrightcontent:AddClickListener(arg_4_0._btnrightcontentOnClick, arg_4_0)
	arg_4_0._btncritter:AddClickListener(arg_4_0._btncritterOnClick, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshSwitchView, arg_4_0._onRefreshSwitchView, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshProgressView, arg_4_0._refreshProgress, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshBaseInfoView, arg_4_0._refreshBaseInfo, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SelectCritter, arg_4_0._onRefreshCritter, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.OnCloseHeroView, arg_4_0._onCloseHeroView, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.OnCloseProgressView, arg_4_0._onCloseProgressView, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.OnCloseBaseInfoView, arg_4_0._onCloseBaseInfoView, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.OnCloseCritterView, arg_4_0._onCloseCritterView, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnrole:RemoveClickListener()
	arg_5_0._btnleftcontent:RemoveClickListener()
	arg_5_0._btnrightcontent:RemoveClickListener()
	arg_5_0._btncritter:RemoveClickListener()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:_initProgress()
	arg_6_0:_initBaseInfo()
end

function var_0_0._creatBgEffect(arg_7_0)
	local var_7_0 = PlayerCardConfig.instance:getBgPath(arg_7_0.themeId)
	local var_7_1 = PlayerCardConfig.instance:getTopEffectPath()

	if var_7_0 or var_7_1 then
		arg_7_0._bgLoder = MultiAbLoader.New()

		if var_7_0 then
			arg_7_0._bgLoder:addPath(var_7_0)
		end

		if var_7_1 then
			arg_7_0._bgLoder:addPath(var_7_1)
		end

		arg_7_0._bgLoder:startLoad(arg_7_0._loadBgDone, arg_7_0)
	end
end

function var_0_0._loadBgDone(arg_8_0)
	local var_8_0 = arg_8_0._bgLoder:getAssetItem(PlayerCardConfig.instance:getBgPath(arg_8_0.themeId))
	local var_8_1 = arg_8_0._bgLoder:getAssetItem(PlayerCardConfig.instance:getTopEffectPath())

	if var_8_0 then
		arg_8_0._bgGo = gohelper.clone(var_8_0:GetResource(), arg_8_0._goBgEffect, "bg")
	end

	if var_8_1 then
		arg_8_0._effectGo = gohelper.clone(var_8_1:GetResource(), arg_8_0._goTopEffect, "topeffect")
	end
end

function var_0_0._initProgress(arg_9_0)
	for iter_9_0 = 1, 5 do
		local var_9_0 = arg_9_0:getUserDataTb_()

		var_9_0.pos = iter_9_0
		var_9_0.go = gohelper.findChild(arg_9_0.viewGO, "root/main/top/leftcontent/node" .. iter_9_0)
		var_9_0.gofull = gohelper.findChild(var_9_0.go, "fill")
		var_9_0.goempty = gohelper.findChild(var_9_0.go, "empty")
		var_9_0.imgpic = gohelper.findChildImage(var_9_0.gofull, "#image_pic")
		var_9_0.imgicon = gohelper.findChildImage(var_9_0.gofull, "#image_icon")
		var_9_0.txtname = gohelper.findChildText(var_9_0.gofull, "#txt_name")
		var_9_0.anim = var_9_0.gofull:GetComponent(typeof(UnityEngine.Animator))

		gohelper.setActive(var_9_0.gofull, false)
		gohelper.setActive(var_9_0.goempty, true)
		table.insert(arg_9_0._progressItemList, var_9_0)
	end
end

function var_0_0._initBaseInfo(arg_10_0)
	for iter_10_0 = 1, 4 do
		local var_10_0 = arg_10_0:getUserDataTb_()

		var_10_0.pos = iter_10_0
		var_10_0.go = gohelper.findChild(arg_10_0.viewGO, "root/main/top/rightcontent/node" .. iter_10_0)
		var_10_0.imgBg = gohelper.findChildImage(var_10_0.go, "#image_bg")
		var_10_0.gofull = gohelper.findChild(var_10_0.go, "fill")
		var_10_0.goempty = gohelper.findChild(var_10_0.go, "empty")
		var_10_0.anim = var_10_0.gofull:GetComponent(typeof(UnityEngine.Animator))

		table.insert(arg_10_0._baseInfoItemList, var_10_0)
	end
end

function var_0_0.onOpen(arg_11_0, arg_11_1)
	arg_11_0._animator.enabled = true

	if arg_11_0.viewParam and arg_11_0.viewParam.userId then
		arg_11_0.userId = arg_11_0.viewParam.userId
	end

	arg_11_0.playercardinfo = PlayerCardModel.instance:getCardInfo(arg_11_0.userId)

	if arg_11_0.playercardinfo:isSelf() then
		PlayerCardController.instance:statStart()
	end

	local var_11_0 = arg_11_1 or arg_11_0.playercardinfo:getThemeId()

	if var_11_0 == 0 or string.nilorempty(var_11_0) then
		var_11_0 = nil
	end

	arg_11_0.themeId = var_11_0

	arg_11_0:_creatBgEffect()

	local var_11_1, var_11_2, var_11_3, var_11_4 = arg_11_0.playercardinfo:getMainHero()

	arg_11_0:_updateHero(var_11_1, var_11_2)
	arg_11_0:_refreshProgress()
	arg_11_0:_refreshBaseInfo()
	arg_11_0:_initCritter()
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_1)

	arg_11_0.progressopen = false
	arg_11_0.baseinfoopen = false
end

function var_0_0.onClose(arg_12_0)
	arg_12_0:resetSpine()

	if arg_12_0.playercardinfo and arg_12_0.playercardinfo:isSelf() then
		PlayerCardController.instance:statEnd()
	end

	arg_12_0:removeEvents()

	arg_12_0._has_onInitView = false

	if arg_12_0._scrollView then
		arg_12_0._scrollView:onDestroyViewInternal()
		arg_12_0._scrollView:__onDispose()
	end

	gohelper.destroy(arg_12_0.goskinpreview)

	arg_12_0._scrollView = nil
end

function var_0_0._btnroleOnClick(arg_13_0)
	if arg_13_0.playercardinfo:isSelf() then
		ViewMgr.instance:openView(ViewName.PlayerCardCharacterSwitchView)
		arg_13_0._animator:Update(0)
		arg_13_0._animator:Play("to_role")
	end
end

function var_0_0._btnleftcontentOnClick(arg_14_0)
	if arg_14_0.playercardinfo:isSelf() then
		ViewMgr.instance:openView(ViewName.PlayerCardProgressView, arg_14_0.playercardinfo)

		arg_14_0.progressopen = true

		arg_14_0._animator:Update(0)
		arg_14_0._animator:Play("to_left")
	end
end

function var_0_0._btnrightcontentOnClick(arg_15_0)
	if arg_15_0.playercardinfo:isSelf() then
		ViewMgr.instance:openView(ViewName.PlayerCardBaseInfoView, arg_15_0.playercardinfo)

		arg_15_0.baseinfoopen = true

		arg_15_0._animator:Update(0)
		arg_15_0._animator:Play("to_right")
	end
end

function var_0_0._btncritterOnClick(arg_16_0)
	if arg_16_0.playercardinfo:isSelf() then
		if not PlayerCardModel.instance:getCritterOpen() then
			return
		end

		arg_16_0._animator:Update(0)
		arg_16_0._animator:Play("to_critter")
		ViewMgr.instance:openView(ViewName.PlayerCardCritterPlaceView)
	end
end

function var_0_0._onCloseHeroView(arg_17_0)
	arg_17_0._animator:Update(0)
	arg_17_0._animator:Play("back_role")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function var_0_0._onCloseProgressView(arg_18_0)
	arg_18_0._animator:Update(0)
	arg_18_0._animator:Play("back_left")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function var_0_0._onCloseBaseInfoView(arg_19_0)
	arg_19_0._animator:Update(0)
	arg_19_0._animator:Play("back_right")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function var_0_0._onCloseCritterView(arg_20_0)
	arg_20_0._animator:Update(0)
	arg_20_0._animator:Play("back_critter")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function var_0_0.backBottomView(arg_21_0)
	arg_21_0._animator:Play("back_bottom")
end

function var_0_0.toBottomView(arg_22_0)
	arg_22_0._animator:Play("to_bottom")
end

function var_0_0._onRefreshSwitchView(arg_23_0, arg_23_1)
	arg_23_0:_updateHero(arg_23_1.heroId, arg_23_1.skinId, arg_23_1.isL2d)
end

function var_0_0._refreshProgress(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1 or arg_24_0.playercardinfo:getProgressSetting()
	local var_24_1 = ItemConfig.instance:getItemCo(arg_24_0.themeId)
	local var_24_2

	if var_24_1 and not string.nilorempty(var_24_1.effect) then
		var_24_2 = string.split(var_24_1.effect, "#")
	end

	if var_24_0 and #var_24_0 > 0 then
		for iter_24_0, iter_24_1 in ipairs(var_24_0) do
			local var_24_3 = iter_24_1[2]
			local var_24_4 = iter_24_1[1]
			local var_24_5 = arg_24_0._progressItemList[var_24_4]

			if var_24_5 then
				if not var_24_5.isload then
					var_24_5.anim:Update(0)
					var_24_5.anim:Play("open")

					var_24_5.isload = true
				end

				local var_24_6 = PlayerCardConfig.instance:getCardProgressById(var_24_3)

				gohelper.setActive(var_24_5.gofull, true)
				gohelper.setActive(var_24_5.goempty, false)

				for iter_24_2, iter_24_3 in pairs(PlayerCardEnum.ProgressShowType) do
					local var_24_7 = gohelper.findChild(var_24_5.gofull, "type" .. iter_24_3)

					gohelper.setActive(var_24_7, false)
				end

				local var_24_8 = var_24_6.type

				var_24_5.txtname.text = var_24_6.name
				var_24_5.gotype = gohelper.findChild(var_24_5.gofull, "type" .. var_24_8)

				gohelper.setActive(var_24_5.gotype, true)
				arg_24_0:setProgressType(var_24_5.gotype, var_24_8, var_24_3)

				if var_24_2 then
					local var_24_9 = var_24_2[1]
					local var_24_10 = var_24_2[2]

					if not string.nilorempty(var_24_9) then
						UISpriteSetMgr.instance:setPlayerCardSprite(var_24_5.imgicon, "playercard_progress_icon_" .. var_24_3 .. "_" .. var_24_9)
					else
						UISpriteSetMgr.instance:setPlayerCardSprite(var_24_5.imgicon, "playercard_main_icon_" .. var_24_3)
					end

					if not string.nilorempty(var_24_10) then
						UISpriteSetMgr.instance:setPlayerCardSprite(var_24_5.imgpic, "playercard_main_img_" .. var_24_3 .. "_" .. var_24_10)
					else
						UISpriteSetMgr.instance:setPlayerCardSprite(var_24_5.imgpic, "playercard_main_img_" .. var_24_3)
					end
				else
					UISpriteSetMgr.instance:setPlayerCardSprite(var_24_5.imgpic, "playercard_main_img_" .. var_24_3)
					UISpriteSetMgr.instance:setPlayerCardSprite(var_24_5.imgicon, "playercard_main_icon_" .. var_24_3)
				end
			end
		end
	end

	local var_24_11 = arg_24_0.progressopen and PlayerCardProgressModel.instance:getEmptyPosList() or arg_24_0.playercardinfo:getEmptyPosList()

	for iter_24_4, iter_24_5 in ipairs(var_24_11) do
		if iter_24_5 then
			local var_24_12 = arg_24_0._progressItemList[iter_24_4]

			gohelper.setActive(var_24_12.gofull, false)
			gohelper.setActive(var_24_12.goempty, true)

			var_24_12.isload = false
		end
	end
end

function var_0_0.setProgressType(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_2 == PlayerCardEnum.ProgressShowType.Normal then
		local var_25_0 = gohelper.findChildText(arg_25_1, "#txt_progress")
		local var_25_1 = gohelper.findChild(arg_25_1, "none")
		local var_25_2 = arg_25_0.playercardinfo:getProgressByIndex(arg_25_3)
		local var_25_3 = var_25_2 ~= -1

		gohelper.setActive(var_25_1, not var_25_3)
		gohelper.setActive(var_25_0.gameObject, var_25_3)

		var_25_0.text = var_25_2
	elseif arg_25_2 == PlayerCardEnum.ProgressShowType.Explore then
		local var_25_4 = arg_25_0.playercardinfo.exploreCollection
		local var_25_5 = gohelper.findChildText(arg_25_1, "#txt_num1")
		local var_25_6 = gohelper.findChildText(arg_25_1, "#txt_num2")
		local var_25_7 = gohelper.findChildText(arg_25_1, "#txt_num3")

		if not string.nilorempty(var_25_4) then
			local var_25_8 = GameUtil.splitString2(var_25_4, true) or {}

			var_25_5.text = var_25_8[3][1] or 0
			var_25_6.text = var_25_8[1][1] or 0
			var_25_7.text = var_25_8[2][1] or 0
		else
			var_25_5.text = 0
			var_25_6.text = 0
			var_25_7.text = 0
		end
	elseif arg_25_2 == PlayerCardEnum.ProgressShowType.Room then
		local var_25_9 = gohelper.findChildText(arg_25_1, "#txt_num1")
		local var_25_10 = gohelper.findChildText(arg_25_1, "#txt_num2")
		local var_25_11 = arg_25_0.playercardinfo.roomCollection
		local var_25_12 = string.splitToNumber(var_25_11, "#")
		local var_25_13 = var_25_12 and var_25_12[1]

		if var_25_13 then
			var_25_9.text = var_25_13
		else
			var_25_9.text = 0
		end

		local var_25_14 = var_25_12 and var_25_12[2]

		if var_25_14 then
			var_25_10.text = var_25_14
		else
			var_25_10.text = 0
		end
	end
end

function var_0_0._refreshBaseInfo(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1 or arg_26_0.playercardinfo:getBaseInfoSetting()

	arg_26_0:initfirstnode()

	if var_26_0 and #var_26_0 > 0 then
		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			local var_26_1 = iter_26_1[1]
			local var_26_2 = iter_26_1[2]
			local var_26_3 = arg_26_0._baseInfoItemList[var_26_1]

			if var_26_1 ~= 1 and var_26_3 then
				if not var_26_3.isload then
					var_26_3.anim:Update(0)
					var_26_3.anim:Play("open")

					var_26_3.isload = true
				end

				local var_26_4 = PlayerCardConfig.instance:getCardBaseInfoById(var_26_2)

				gohelper.setActive(var_26_3.gofull, true)
				gohelper.setActive(var_26_3.goempty, false)

				for iter_26_2, iter_26_3 in pairs(PlayerCardEnum.BaseInfoType) do
					local var_26_5 = gohelper.findChild(var_26_3.gofull, "type" .. iter_26_3)

					gohelper.setActive(var_26_5, false)
				end

				local var_26_6 = var_26_4.type

				var_26_3.gotype = gohelper.findChild(var_26_3.gofull, "type" .. var_26_6)

				gohelper.setActive(var_26_3.gotype, true)

				local var_26_7 = gohelper.findChildText(var_26_3.gotype, "txt_title")
				local var_26_8

				if var_26_6 == 2 then
					local var_26_9 = gohelper.findChildText(var_26_3.gotype, "layout/#txt_num")
					local var_26_10 = gohelper.findChildText(var_26_3.gotype, "layout/#txt_dec")
					local var_26_11, var_26_12 = arg_26_0.playercardinfo:getBaseInfoByIndex(var_26_2, true)

					var_26_9.text = var_26_11
					var_26_10.text = var_26_12
				else
					gohelper.findChildText(var_26_3.gotype, "#txt_num").text = arg_26_0.playercardinfo:getBaseInfoByIndex(var_26_2, true)
				end

				var_26_7.text = var_26_4.name
			end
		end
	end

	local var_26_13 = arg_26_0.baseinfoopen and PlayerCardBaseInfoModel.instance:getEmptyPosList() or arg_26_0.playercardinfo:getEmptyBaseInfoPosList()

	for iter_26_4, iter_26_5 in ipairs(var_26_13) do
		if iter_26_5 then
			local var_26_14 = arg_26_0._baseInfoItemList[iter_26_4]

			gohelper.setActive(var_26_14.gofull, false)
			gohelper.setActive(var_26_14.goempty, true)

			var_26_14.isload = false
		end
	end
end

function var_0_0.initfirstnode(arg_27_0)
	local var_27_0 = arg_27_0._baseInfoItemList[1]
	local var_27_1 = gohelper.findChildText(var_27_0.gofull, "type1/txt_role/#txt_num")
	local var_27_2 = gohelper.findChildText(var_27_0.gofull, "type1/txt_role")

	var_27_0.chesslist = var_27_0.chesslist or {}

	if not (#var_27_0.chesslist > 0) then
		for iter_27_0 = 1, 5 do
			var_27_0.chesslist[iter_27_0] = gohelper.findChildImage(var_27_0.gofull, "type1/collection/collection" .. iter_27_0 .. "/#image_full")
		end
	end

	local var_27_3, var_27_4, var_27_5, var_27_6, var_27_7 = arg_27_0.playercardinfo:getHeroRarePercent()

	var_27_0.chesslist[1].fillAmount = var_27_3 or 100
	var_27_0.chesslist[2].fillAmount = var_27_4 or 100
	var_27_0.chesslist[3].fillAmount = var_27_5 or 100
	var_27_0.chesslist[4].fillAmount = var_27_6 or 100
	var_27_0.chesslist[5].fillAmount = var_27_7 or 100

	local var_27_8 = PlayerCardConfig.instance:getCardBaseInfoById(1)

	var_27_1.text = arg_27_0.playercardinfo:getHeroCount()
	var_27_2.text = var_27_8.name
end

function var_0_0._initCritter(arg_28_0)
	if arg_28_0.playercardinfo:isSelf() then
		local var_28_0 = PlayerCardModel.instance:getCritterOpen()

		gohelper.setActive(arg_28_0._gocritterlight, var_28_0)

		if var_28_0 then
			local var_28_1, var_28_2 = arg_28_0.playercardinfo:getCritter()

			if not var_28_1 then
				gohelper.setActive(arg_28_0._gocritterlight, false)

				return
			end

			arg_28_0:setResPath(var_28_1, var_28_2)
		end
	else
		local var_28_3, var_28_4 = arg_28_0.playercardinfo:getCritter()

		if not var_28_3 then
			return
		end

		arg_28_0:setResPath(var_28_3, var_28_4)
	end
end

function var_0_0._onRefreshCritter(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.uid
	local var_29_1 = CritterModel.instance:getCritterMOByUid(tostring(var_29_0))

	if not var_29_1 then
		return
	end

	local var_29_2 = var_29_1:getDefineId()
	local var_29_3 = var_29_1:getSkinId()

	arg_29_0:setResPath(var_29_2, var_29_3)
end

function var_0_0.resetSpine(arg_30_0)
	if arg_30_0._uiSpine then
		arg_30_0._uiSpine:onDestroy()

		arg_30_0._uiSpine = nil
	end
end

function var_0_0._getSpine(arg_31_0)
	if not arg_31_0._spine then
		arg_31_0._spine = GuiSpine.Create(arg_31_0._gocritter)
	end

	return arg_31_0._spine
end

function var_0_0.resetTransform(arg_32_0)
	if not arg_32_0._spine then
		return
	end

	local var_32_0 = arg_32_0._spine._spineGo

	if gohelper.isNil(var_32_0) then
		return
	end

	recthelper.setAnchor(var_32_0.transform, 0, 0)
	transformhelper.setLocalScale(var_32_0.transform, 1, 1, 1)
end

function var_0_0.setResPath(arg_33_0, arg_33_1, arg_33_2)
	arg_33_2 = arg_33_2 or CritterConfig.instance:getCritterNormalSkin(arg_33_1)

	if not string.nilorempty(arg_33_2) then
		local var_33_0 = RoomResHelper.getCritterUIPath(arg_33_2)

		arg_33_0._curModel = arg_33_0:_getSpine()

		arg_33_0._curModel:setHeroId(arg_33_1)
		arg_33_0._curModel:showModel()
		arg_33_0._curModel:setResPath(var_33_0, function()
			arg_33_0:resetTransform()
		end, arg_33_0, true)
	end
end

function var_0_0._updateHero(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = HeroModel.instance:getByHeroId(arg_35_1)
	local var_35_1 = SkinConfig.instance:getSkinCo(arg_35_2 or var_35_0 and var_35_0.skin)

	if not var_35_1 then
		return
	end

	arg_35_0.skinCo = var_35_1
	arg_35_0.heroCo = HeroConfig.instance:getHeroCO(arg_35_0.skinCo.characterId)

	arg_35_0:resetRes()
	arg_35_0._simagerole:LoadImage(ResUrl.getHeadIconImg(arg_35_0.skinCo.id), arg_35_0._loadedImage, arg_35_0)
end

function var_0_0.SetNativeSize(arg_36_0)
	return
end

function var_0_0.resetRes(arg_37_0)
	arg_37_0._simagerole:UnLoadImage()
end

function var_0_0._loadedImage(arg_38_0)
	ZProj.UGUIHelper.SetImageSize(arg_38_0._simagerole.gameObject)

	local var_38_0 = arg_38_0.skinCo.playercardViewImgOffset

	if string.nilorempty(var_38_0) then
		var_38_0 = arg_38_0.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(var_38_0) then
		local var_38_1 = string.splitToNumber(var_38_0, "#")

		recthelper.setAnchor(arg_38_0._simagerole.transform, tonumber(var_38_1[1]), tonumber(var_38_1[2]))
		transformhelper.setLocalScale(arg_38_0._simagerole.transform, tonumber(var_38_1[3]), tonumber(var_38_1[3]), tonumber(var_38_1[3]))
	end
end

function var_0_0.onDestroy(arg_39_0)
	return
end

return var_0_0
