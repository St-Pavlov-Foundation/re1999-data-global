module("modules.logic.room.view.RoomCharacterPlaceInfoView", package.seeall)

slot0 = class("RoomCharacterPlaceInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_close")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_sure")
	slot0._txttip = gohelper.findChildText(slot0.viewGO, "tip/#txt_tip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnsure:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()

	if slot0._closeCallback then
		if slot0._callbackObj then
			slot0._closeCallback(slot0._callbackObj, slot0._callbackParam)
		else
			slot0._closeCallback(slot0._callbackParam)
		end
	end
end

function slot0._btnsureOnClick(slot0)
	if #slot0._removeHeroMOList < slot0._needRemoveCount then
		GameFacade.showToast(ToastEnum.RoomCharacterPlaceInfo, slot0._needRemoveCount - slot1)

		return
	end

	if slot1 > 0 then
		if slot0._notUpdateMapModel ~= true then
			for slot5, slot6 in ipairs(slot0._removeHeroMOList) do
				RoomCharacterModel.instance:editRemoveCharacterMO(slot6.heroId)
			end
		end

		slot2 = {}

		for slot6, slot7 in ipairs(slot0._currentHeroMOList) do
			slot8, slot9 = slot0:_findHeroMOById(slot0._removeHeroMOList, slot7.heroId)

			if not slot8 then
				table.insert(slot2, slot7.heroId)
			end
		end

		RoomRpc.instance:sendUpdateRoomHeroDataRequest(slot2)
	end

	slot0:closeThis()

	if slot0._sureCallback then
		if slot0._callbackObj then
			slot0._sureCallback(slot0._callbackObj, slot0._callbackParam)
		else
			slot0._sureCallback(slot0._callbackParam)
		end
	end
end

function slot0._btnclickOnclick(slot0, slot1)
	slot2, slot3 = slot0:_findHeroMOById(slot0._currentHeroMOList, slot1)

	if slot2 then
		table.remove(slot0._currentHeroMOList, slot3)
		table.insert(slot0._removeHeroMOList, slot2)
	else
		slot4, slot3 = slot0:_findHeroMOById(slot0._removeHeroMOList, slot1)

		if slot4 then
			table.remove(slot0._removeHeroMOList, slot3)
			table.insert(slot0._currentHeroMOList, slot2)
		end
	end

	slot0:_sort()
	slot0:_refreshUI()
end

function slot0._findHeroMOById(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot7.heroId == slot2 then
			return slot7, slot6
		end
	end

	return nil
end

function slot0._editableInitView(slot0)
	slot0._gocurrentplacecontent = gohelper.findChild(slot0.viewGO, "currentplace/#scroll_currentplace/Viewport/Content")
	slot0._goremoveplacecontent = gohelper.findChild(slot0.viewGO, "removeplace/#scroll_removeplace/Viewport/Content")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "tip")

	slot0._simagebg:LoadImage(ResUrl.getRoomImage("characterplace/bg_dajiandi"))
end

function slot0.initCharacterItem(slot0)
	slot0.simageicon = gohelper.findChildSingleImage(slot0.go, "role/heroicon")
	slot0.goclick = gohelper.findChild(slot0.go, "go_click")
	slot0.txttrust = gohelper.findChildText(slot0.go, "trust/txt_trust")
	slot0.gorole = gohelper.findChild(slot0.go, "role")
	slot0.imagecareer = gohelper.findChildImage(slot0.go, "role/career")
	slot0.imagerare = gohelper.findChildImage(slot0.go, "role/rare")
	slot0.txtname = gohelper.findChildText(slot0.go, "role/name")
	slot0.txtnameen = gohelper.findChildText(slot0.go, "role/name/nameEn")
	slot0.btnclick = gohelper.getClickWithAudio(slot0.goclick)

	gohelper.setActive(gohelper.findChild(slot0.go, "trust"), true)
	gohelper.setActive(gohelper.findChild(slot0.go, "placeicon"), false)
	gohelper.setActive(gohelper.findChild(slot0.go, "select"), false)
	gohelper.setActive(gohelper.findChild(slot0.go, "#go_onbirthdayicon"), false)

	slot0.gorole:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
end

function slot0.refreshCharacterItem(slot0, slot1)
	slot0.simageicon:LoadImage(ResUrl.getHeadIconSmall(slot1.skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0.imagecareer, "lssx_" .. slot1.heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(slot0.imagerare, "equipbar" .. CharacterEnum.Color[slot1.heroConfig.rare])

	slot0.txtname.text = slot1.heroConfig.name
	slot0.txtnameen.text = slot1.heroConfig.nameEng
	slot0.txttrust.text = string.format("%s%%", (HeroModel.instance:getByHeroId(slot1.heroId) and HeroConfig.instance:getFaithPercent(slot2.faith)[1] or 0) * 100)
end

function slot0.destroyCharacterItem(slot0)
	slot0.simageicon:UnLoadImage()
	slot0.btnclick:RemoveClickListener()
end

function slot0._sort(slot0)
	table.sort(slot0._currentHeroMOList, function (slot0, slot1)
		slot3 = HeroModel.instance:getByHeroId(slot1.heroId)

		if (HeroModel.instance:getByHeroId(slot0.heroId) and HeroConfig.instance:getFaithPercent(slot2.faith)[1] or 0) ~= (slot3 and HeroConfig.instance:getFaithPercent(slot3.faith)[1] or 0) then
			return slot5 < slot4
		end

		if slot0.heroConfig.rare ~= slot1.heroConfig.rare then
			return slot1.heroConfig.rare < slot0.heroConfig.rare
		end

		return slot0.heroId < slot1.heroId
	end)
end

function slot0._refreshBtnTips(slot0)
	gohelper.setActive(slot0._gotip, #slot0._removeHeroMOList < slot0._needRemoveCount)

	if slot1 < slot0._needRemoveCount then
		slot0._txttip.text = string.format(luaLang("room_character_remove_tips"), slot0._needRemoveCount - slot1)
	end
end

function slot0._refreshUI(slot0)
	for slot4, slot5 in ipairs(slot0._currentHeroMOList) do
		if not slot0._currentHeroItemList[slot4] then
			slot6 = slot0:getUserDataTb_()
			slot6.go = slot0.viewContainer:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot0._gocurrentplacecontent, "item" .. slot4)

			uv0.initCharacterItem(slot6)
			table.insert(slot0._currentHeroItemList, slot6)
		end

		slot6.btnclick:RemoveClickListener()
		slot6.btnclick:AddClickListener(slot0._btnclickOnclick, slot0, slot5.heroId)
		uv0.refreshCharacterItem(slot6, slot5)
		gohelper.setActive(slot6.go, true)
	end

	for slot4 = #slot0._currentHeroMOList + 1, #slot0._currentHeroItemList do
		gohelper.setActive(slot0._currentHeroItemList[slot4].go, false)
	end

	for slot4, slot5 in ipairs(slot0._removeHeroMOList) do
		if not slot0._removeHeroItemList[slot4] then
			slot6 = slot0:getUserDataTb_()
			slot6.go = slot0.viewContainer:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot0._goremoveplacecontent, "item" .. slot4)

			uv0.initCharacterItem(slot6)
			table.insert(slot0._removeHeroItemList, slot6)
		end

		slot6.btnclick:RemoveClickListener()
		slot6.btnclick:AddClickListener(slot0._btnclickOnclick, slot0, slot5.heroId)
		uv0.refreshCharacterItem(slot6, slot5)
		gohelper.setActive(slot6.go, true)
	end

	for slot4 = #slot0._removeHeroMOList + 1, #slot0._removeHeroItemList do
		gohelper.setActive(slot0._removeHeroItemList[slot4].go, false)
	end

	slot0:_refreshBtnTips()
end

function slot0.onOpen(slot0)
	slot0._needRemoveCount = slot0.viewParam and slot0.viewParam.needRemoveCount or 0
	slot0._closeCallback = slot0.viewParam and slot0.viewParam.closeCallback
	slot0._sureCallback = slot0.viewParam and slot0.viewParam.sureCallback
	slot0._callbackObj = slot0.viewParam and slot0.viewParam.callbackObj
	slot0._callbackParam = slot0.viewParam and slot0.viewParam.callbackParam
	slot0._notUpdateMapModel = slot0.viewParam and slot0.viewParam.notUpdateMapModel
	slot0._currentHeroMOList = {}

	for slot5, slot6 in ipairs(slot0.viewParam and slot0.viewParam.roomCharacterMOList or RoomCharacterModel.instance:getList()) do
		if slot6:isPlaceSourceState() then
			table.insert(slot0._currentHeroMOList, slot6)
		end
	end

	slot0._removeHeroMOList = {}
	slot0._currentHeroItemList = {}
	slot0._removeHeroItemList = {}

	slot0:_sort()
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()

	for slot4, slot5 in ipairs(slot0._currentHeroItemList) do
		uv0.destroyCharacterItem(slot5)
	end

	for slot4, slot5 in ipairs(slot0._removeHeroItemList) do
		uv0.destroyCharacterItem(slot5)
	end
end

return slot0
