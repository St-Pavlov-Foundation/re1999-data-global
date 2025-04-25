module("modules.logic.playercard.view.NewPlayerCardView", package.seeall)

slot0 = class("NewPlayerCardView", BaseView)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.canOpen(slot0, slot1)
	slot0:onOpen(slot1)
	slot0:addEvents()
end

function slot0.onInitView(slot0)
	slot0._root = gohelper.findChild(slot0.viewGO, "root")
	slot0._simagerole = gohelper.findChildSingleImage(slot0.viewGO, "root/main/top/role/skinnode/#simage_role")
	slot0._imageIcon = gohelper.findChildImage(slot0.viewGO, "root/main/top/role/skinnode/#simage_role")
	slot0._btnrole = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/main/top/role/skinnode/#simage_role/#btn_role")
	slot0._btnleftcontent = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/main/top/leftcontent/#btn_leftcontent")
	slot0._btnrightcontent = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/main/top/rightcontent/#btn_rightcontent")
	slot0._txtdungeon = gohelper.findChildText(slot0.viewGO, "root/main/top/rightcontent/#txt_dungeon")
	slot0._gocritter = gohelper.findChild(slot0.viewGO, "root/main/critter/go_critter")
	slot0._gocritterlight = gohelper.findChild(slot0.viewGO, "root/main/critter/light")
	slot0._btncritter = gohelper.findChildButton(slot0.viewGO, "root/main/critter/#btn_critter")
	slot0._goBgEffect = gohelper.findChild(slot0.viewGO, "#bg_effect")
	slot0._goTopEffect = gohelper.findChild(slot0.viewGO, "#top_effect")
	slot0._openswitchskin = false
	slot0._progressItemList = {}
	slot0._baseInfoItemList = {}
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._has_onInitView = true

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrole:AddClickListener(slot0._btnroleOnClick, slot0)
	slot0._btnleftcontent:AddClickListener(slot0._btnleftcontentOnClick, slot0)
	slot0._btnrightcontent:AddClickListener(slot0._btnrightcontentOnClick, slot0)
	slot0._btncritter:AddClickListener(slot0._btncritterOnClick, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshSwitchView, slot0._onRefreshSwitchView, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshProgressView, slot0._refreshProgress, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.RefreshBaseInfoView, slot0._refreshBaseInfo, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SelectCritter, slot0._onRefreshCritter, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.OnCloseHeroView, slot0._onCloseHeroView, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.OnCloseProgressView, slot0._onCloseProgressView, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.OnCloseBaseInfoView, slot0._onCloseBaseInfoView, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.OnCloseCritterView, slot0._onCloseCritterView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrole:RemoveClickListener()
	slot0._btnleftcontent:RemoveClickListener()
	slot0._btnrightcontent:RemoveClickListener()
	slot0._btncritter:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0:_initProgress()
	slot0:_initBaseInfo()
end

function slot0._creatBgEffect(slot0)
	slot2 = PlayerCardConfig.instance:getTopEffectPath()

	if PlayerCardConfig.instance:getBgPath(slot0.themeId) or slot2 then
		slot0._bgLoder = MultiAbLoader.New()

		if slot1 then
			slot0._bgLoder:addPath(slot1)
		end

		if slot2 then
			slot0._bgLoder:addPath(slot2)
		end

		slot0._bgLoder:startLoad(slot0._loadBgDone, slot0)
	end
end

function slot0._loadBgDone(slot0)
	slot2 = slot0._bgLoder:getAssetItem(PlayerCardConfig.instance:getTopEffectPath())

	if slot0._bgLoder:getAssetItem(PlayerCardConfig.instance:getBgPath(slot0.themeId)) then
		slot0._bgGo = gohelper.clone(slot1:GetResource(), slot0._goBgEffect, "bg")
	end

	if slot2 then
		slot0._effectGo = gohelper.clone(slot2:GetResource(), slot0._goTopEffect, "topeffect")
	end
end

function slot0._initProgress(slot0)
	for slot4 = 1, 5 do
		slot5 = slot0:getUserDataTb_()
		slot5.pos = slot4
		slot5.go = gohelper.findChild(slot0.viewGO, "root/main/top/leftcontent/node" .. slot4)
		slot5.gofull = gohelper.findChild(slot5.go, "fill")
		slot5.goempty = gohelper.findChild(slot5.go, "empty")
		slot5.imgpic = gohelper.findChildImage(slot5.gofull, "#image_pic")
		slot5.imgicon = gohelper.findChildImage(slot5.gofull, "#image_icon")
		slot5.txtname = gohelper.findChildText(slot5.gofull, "#txt_name")
		slot5.anim = slot5.gofull:GetComponent(typeof(UnityEngine.Animator))

		gohelper.setActive(slot5.gofull, false)
		gohelper.setActive(slot5.goempty, true)
		table.insert(slot0._progressItemList, slot5)
	end
end

function slot0._initBaseInfo(slot0)
	for slot4 = 1, 4 do
		slot5 = slot0:getUserDataTb_()
		slot5.pos = slot4
		slot5.go = gohelper.findChild(slot0.viewGO, "root/main/top/rightcontent/node" .. slot4)
		slot5.imgBg = gohelper.findChildImage(slot5.go, "#image_bg")
		slot5.gofull = gohelper.findChild(slot5.go, "fill")
		slot5.goempty = gohelper.findChild(slot5.go, "empty")
		slot5.anim = slot5.gofull:GetComponent(typeof(UnityEngine.Animator))

		table.insert(slot0._baseInfoItemList, slot5)
	end
end

function slot0.onOpen(slot0, slot1)
	slot0._animator.enabled = true

	if slot0.viewParam and slot0.viewParam.userId then
		slot0.userId = slot0.viewParam.userId
	end

	slot0.playercardinfo = PlayerCardModel.instance:getCardInfo(slot0.userId)

	if slot0.playercardinfo:isSelf() then
		PlayerCardController.instance:statStart()
	end

	if (slot1 or slot0.playercardinfo:getThemeId()) == 0 or string.nilorempty(slot2) then
		slot2 = nil
	end

	slot0.themeId = slot2

	slot0:_creatBgEffect()

	slot3, slot4, slot5, slot6 = slot0.playercardinfo:getMainHero()

	slot0:_updateHero(slot3, slot4)
	slot0:_refreshProgress()
	slot0:_refreshBaseInfo()
	slot0:_initCritter()
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_1)

	slot0.progressopen = false
	slot0.baseinfoopen = false
end

function slot0.onClose(slot0)
	slot0:resetSpine()

	if slot0.playercardinfo and slot0.playercardinfo:isSelf() then
		PlayerCardController.instance:statEnd()
	end

	slot0:removeEvents()

	slot0._has_onInitView = false

	if slot0._scrollView then
		slot0._scrollView:onDestroyViewInternal()
		slot0._scrollView:__onDispose()
	end

	gohelper.destroy(slot0.goskinpreview)

	slot0._scrollView = nil
end

function slot0._btnroleOnClick(slot0)
	if slot0.playercardinfo:isSelf() then
		ViewMgr.instance:openView(ViewName.PlayerCardCharacterSwitchView)
		slot0._animator:Update(0)
		slot0._animator:Play("to_role")
	end
end

function slot0._btnleftcontentOnClick(slot0)
	if slot0.playercardinfo:isSelf() then
		ViewMgr.instance:openView(ViewName.PlayerCardProgressView, slot0.playercardinfo)

		slot0.progressopen = true

		slot0._animator:Update(0)
		slot0._animator:Play("to_left")
	end
end

function slot0._btnrightcontentOnClick(slot0)
	if slot0.playercardinfo:isSelf() then
		ViewMgr.instance:openView(ViewName.PlayerCardBaseInfoView, slot0.playercardinfo)

		slot0.baseinfoopen = true

		slot0._animator:Update(0)
		slot0._animator:Play("to_right")
	end
end

function slot0._btncritterOnClick(slot0)
	if slot0.playercardinfo:isSelf() then
		if not PlayerCardModel.instance:getCritterOpen() then
			return
		end

		slot0._animator:Update(0)
		slot0._animator:Play("to_critter")
		ViewMgr.instance:openView(ViewName.PlayerCardCritterPlaceView)
	end
end

function slot0._onCloseHeroView(slot0)
	slot0._animator:Update(0)
	slot0._animator:Play("back_role")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function slot0._onCloseProgressView(slot0)
	slot0._animator:Update(0)
	slot0._animator:Play("back_left")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function slot0._onCloseBaseInfoView(slot0)
	slot0._animator:Update(0)
	slot0._animator:Play("back_right")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function slot0._onCloseCritterView(slot0)
	slot0._animator:Update(0)
	slot0._animator:Play("back_critter")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function slot0.backBottomView(slot0)
	slot0._animator:Play("back_bottom")
end

function slot0.toBottomView(slot0)
	slot0._animator:Play("to_bottom")
end

function slot0._onRefreshSwitchView(slot0, slot1)
	slot0:_updateHero(slot1.heroId, slot1.skinId, slot1.isL2d)
end

function slot0._refreshProgress(slot0, slot1)
	if (slot1 or slot0.playercardinfo:getProgressSetting()) and #slot2 > 0 then
		for slot6, slot7 in ipairs(slot2) do
			slot8 = slot7[2]

			if slot0._progressItemList[slot7[1]] then
				if not slot10.isload then
					slot10.anim:Update(0)
					slot10.anim:Play("open")

					slot10.isload = true
				end

				slot11 = PlayerCardConfig.instance:getCardProgressById(slot8)

				gohelper.setActive(slot10.gofull, true)
				gohelper.setActive(slot10.goempty, false)

				for slot15, slot16 in pairs(PlayerCardEnum.ProgressShowType) do
					gohelper.setActive(gohelper.findChild(slot10.gofull, "type" .. slot16), false)
				end

				slot12 = slot11.type
				slot10.txtname.text = slot11.name
				slot10.gotype = gohelper.findChild(slot10.gofull, "type" .. slot12)

				gohelper.setActive(slot10.gotype, true)
				slot0:setProgressType(slot10.gotype, slot12, slot8)
				UISpriteSetMgr.instance:setPlayerCardSprite(slot10.imgpic, "playercard_main_img_" .. slot8)
				UISpriteSetMgr.instance:setPlayerCardSprite(slot10.imgicon, "playercard_main_icon_" .. slot8)
			end
		end
	end

	for slot7, slot8 in ipairs(slot0.progressopen and PlayerCardProgressModel.instance:getEmptyPosList() or slot0.playercardinfo:getEmptyPosList()) do
		if slot8 then
			slot9 = slot0._progressItemList[slot7]

			gohelper.setActive(slot9.gofull, false)
			gohelper.setActive(slot9.goempty, true)

			slot9.isload = false
		end
	end
end

function slot0.setProgressType(slot0, slot1, slot2, slot3)
	if slot2 == PlayerCardEnum.ProgressShowType.Normal then
		slot4 = gohelper.findChildText(slot1, "#txt_progress")
		slot7 = slot0.playercardinfo:getProgressByIndex(slot3) ~= -1

		gohelper.setActive(gohelper.findChild(slot1, "none"), not slot7)
		gohelper.setActive(slot4.gameObject, slot7)

		slot4.text = slot6
	elseif slot2 == PlayerCardEnum.ProgressShowType.Explore then
		if not string.nilorempty(slot0.playercardinfo.exploreCollection) then
			slot8 = GameUtil.splitString2(slot4, true) or {}
			gohelper.findChildText(slot1, "#txt_num1").text = slot8[3][1] or 0
			gohelper.findChildText(slot1, "#txt_num2").text = slot8[1][1] or 0
			gohelper.findChildText(slot1, "#txt_num3").text = slot8[2][1] or 0
		else
			slot5.text = 0
			slot6.text = 0
			slot7.text = 0
		end
	elseif slot2 == PlayerCardEnum.ProgressShowType.Room then
		slot5 = gohelper.findChildText(slot1, "#txt_num2")

		if string.splitToNumber(slot0.playercardinfo.roomCollection, "#") and slot7[1] then
			gohelper.findChildText(slot1, "#txt_num1").text = slot8
		else
			slot4.text = 0
		end

		if slot7 and slot7[2] then
			slot5.text = slot9
		else
			slot5.text = 0
		end
	end
end

function slot0._refreshBaseInfo(slot0, slot1)
	slot0:initfirstnode()

	if (slot1 or slot0.playercardinfo:getBaseInfoSetting()) and #slot2 > 0 then
		for slot6, slot7 in ipairs(slot2) do
			slot8 = slot7[1]
			slot9 = slot7[2]
			slot10 = slot0._baseInfoItemList[slot8]

			if slot8 ~= 1 and slot10 then
				if not slot10.isload then
					slot10.anim:Update(0)
					slot10.anim:Play("open")

					slot10.isload = true
				end

				slot11 = PlayerCardConfig.instance:getCardBaseInfoById(slot9)

				gohelper.setActive(slot10.gofull, true)
				gohelper.setActive(slot10.goempty, false)

				for slot15, slot16 in pairs(PlayerCardEnum.BaseInfoType) do
					gohelper.setActive(gohelper.findChild(slot10.gofull, "type" .. slot16), false)
				end

				slot12 = slot11.type
				slot10.gotype = gohelper.findChild(slot10.gofull, "type" .. slot12)

				gohelper.setActive(slot10.gotype, true)

				slot13 = gohelper.findChildText(slot10.gotype, "txt_title")
				slot14 = nil

				if slot12 == 2 then
					gohelper.findChildText(slot10.gotype, "layout/#txt_num").text, gohelper.findChildText(slot10.gotype, "layout/#txt_dec").text = slot0.playercardinfo:getBaseInfoByIndex(slot9, true)
				else
					gohelper.findChildText(slot10.gotype, "#txt_num").text = slot0.playercardinfo:getBaseInfoByIndex(slot9, true)
				end

				slot13.text = slot11.name
			end
		end
	end

	for slot7, slot8 in ipairs(slot0.baseinfoopen and PlayerCardBaseInfoModel.instance:getEmptyPosList() or slot0.playercardinfo:getEmptyBaseInfoPosList()) do
		if slot8 then
			slot9 = slot0._baseInfoItemList[slot7]

			gohelper.setActive(slot9.gofull, false)
			gohelper.setActive(slot9.goempty, true)

			slot9.isload = false
		end
	end
end

function slot0.initfirstnode(slot0)
	slot1 = slot0._baseInfoItemList[1]
	slot2 = gohelper.findChildText(slot1.gofull, "type1/txt_role/#txt_num")
	slot3 = gohelper.findChildText(slot1.gofull, "type1/txt_role")
	slot1.chesslist = slot1.chesslist or {}

	if #slot1.chesslist <= 0 then
		for slot7 = 1, 5 do
			slot1.chesslist[slot7] = gohelper.findChildImage(slot1.gofull, "type1/collection/collection" .. slot7 .. "/#image_full")
		end
	end

	slot4, slot5, slot6, slot7, slot8 = slot0.playercardinfo:getHeroRarePercent()
	slot1.chesslist[1].fillAmount = slot4 or 100
	slot1.chesslist[2].fillAmount = slot5 or 100
	slot1.chesslist[3].fillAmount = slot6 or 100
	slot1.chesslist[4].fillAmount = slot7 or 100
	slot1.chesslist[5].fillAmount = slot8 or 100
	slot2.text = slot0.playercardinfo:getHeroCount()
	slot3.text = PlayerCardConfig.instance:getCardBaseInfoById(1).name
end

function slot0._initCritter(slot0)
	if slot0.playercardinfo:isSelf() then
		slot1 = PlayerCardModel.instance:getCritterOpen()

		gohelper.setActive(slot0._gocritterlight, slot1)

		if slot1 then
			slot2, slot3 = slot0.playercardinfo:getCritter()

			if not slot2 then
				gohelper.setActive(slot0._gocritterlight, false)

				return
			end

			slot0:setResPath(slot2, slot3)
		end
	else
		slot1, slot2 = slot0.playercardinfo:getCritter()

		if not slot1 then
			return
		end

		slot0:setResPath(slot1, slot2)
	end
end

function slot0._onRefreshCritter(slot0, slot1)
	if not CritterModel.instance:getCritterMOByUid(tostring(slot1.uid)) then
		return
	end

	slot0:setResPath(slot3:getDefineId(), slot3:getSkinId())
end

function slot0.resetSpine(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end
end

function slot0._getSpine(slot0)
	if not slot0._spine then
		slot0._spine = GuiSpine.Create(slot0._gocritter)
	end

	return slot0._spine
end

function slot0.resetTransform(slot0)
	if not slot0._spine then
		return
	end

	if gohelper.isNil(slot0._spine._spineGo) then
		return
	end

	recthelper.setAnchor(slot1.transform, 0, 0)
	transformhelper.setLocalScale(slot1.transform, 1, 1, 1)
end

function slot0.setResPath(slot0, slot1, slot2)
	if not string.nilorempty(slot2 or CritterConfig.instance:getCritterNormalSkin(slot1)) then
		slot0._curModel = slot0:_getSpine()

		slot0._curModel:setHeroId(slot1)
		slot0._curModel:showModel()
		slot0._curModel:setResPath(RoomResHelper.getCritterUIPath(slot2), function ()
			uv0:resetTransform()
		end, slot0, true)
	end
end

function slot0._updateHero(slot0, slot1, slot2)
	slot3 = HeroModel.instance:getByHeroId(slot1)

	if not SkinConfig.instance:getSkinCo(slot2 or slot3 and slot3.skin) then
		return
	end

	slot0.skinCo = slot4
	slot0.heroCo = HeroConfig.instance:getHeroCO(slot0.skinCo.characterId)

	slot0:resetRes()
	slot0._simagerole:LoadImage(ResUrl.getHeadIconImg(slot0.skinCo.id), slot0._loadedImage, slot0)
end

function slot0.SetNativeSize(slot0)
end

function slot0.resetRes(slot0)
	slot0._simagerole:UnLoadImage()
end

function slot0._loadedImage(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simagerole.gameObject)

	if string.nilorempty(slot0.skinCo.playercardViewImgOffset) then
		slot1 = slot0.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(slot1) then
		slot2 = string.splitToNumber(slot1, "#")

		recthelper.setAnchor(slot0._simagerole.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._simagerole.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
	end
end

function slot0.onDestroy(slot0)
end

return slot0
