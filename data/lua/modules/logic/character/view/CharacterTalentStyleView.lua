module("modules.logic.character.view.CharacterTalentStyleView", package.seeall)

slot0 = class("CharacterTalentStyleView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagefrontbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_frontbg")
	slot0._goinspirationItem = gohelper.findChild(slot0.viewGO, "#go_inspirationItem")
	slot0._gocubeinfo = gohelper.findChild(slot0.viewGO, "#go_cubeinfo")
	slot0._txtcompareStyleName = gohelper.findChildText(slot0.viewGO, "#go_cubeinfo/panel/compare/title/name/#txt_compareStyleName")
	slot0._txtcompareLabel = gohelper.findChildText(slot0.viewGO, "#go_cubeinfo/panel/compare/title/desc/go_career/#txt_compareLabel")
	slot0._gocurrency = gohelper.findChild(slot0.viewGO, "#go_cubeinfo/panel/compare/#go_currency")
	slot0._txtcurStyleName = gohelper.findChildText(slot0.viewGO, "#go_cubeinfo/panel/cur/title/name/#txt_curStyleName")
	slot0._txtcurLabel = gohelper.findChildText(slot0.viewGO, "#go_cubeinfo/panel/cur/title/desc/go_career/#txt_curLabel")
	slot0._gostate = gohelper.findChild(slot0.viewGO, "#go_cubeinfo/#go_state")
	slot0._btncompare = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cubeinfo/#go_state/#btn_compare")
	slot0._btninteam = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cubeinfo/#go_state/#btn_inteam")
	slot0._btnfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_cubeinfo/#go_state/#btn_fold")
	slot0._gorequest = gohelper.findChild(slot0.viewGO, "go_unlock/#go_request")
	slot0._btnunlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_unlock/#btn_unlock")
	slot0._btnuse = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_unlock/#btn_use")
	slot0._gousing = gohelper.findChild(slot0.viewGO, "go_unlock/#go_using")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "go_unlock/#go_reward")
	slot0._scrollstyle = gohelper.findChildScrollRect(slot0.viewGO, "go_style/#scroll_style")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_style/#item_style/#btn_click")
	slot0._txtstyle = gohelper.findChildText(slot0.viewGO, "go_style/#item_style/#txt_style")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_style/#item_style/#go_select")
	slot0._gouse = gohelper.findChild(slot0.viewGO, "go_style/#item_style/#go_use")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "go_style/#item_style/#go_new")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncompare:AddClickListener(slot0._btncompareOnClick, slot0)
	slot0._btninteam:AddClickListener(slot0._btninteamOnClick, slot0)
	slot0._btnfold:AddClickListener(slot0._btnfoldOnClick, slot0)
	slot0._btnunlock:AddClickListener(slot0._btnunlockOnClick, slot0)
	slot0._btnuse:AddClickListener(slot0._btnuseOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncompare:RemoveClickListener()
	slot0._btninteam:RemoveClickListener()
	slot0._btnfold:RemoveClickListener()
	slot0._btnunlock:RemoveClickListener()
	slot0._btnuse:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnuseOnClick(slot0)
	TalentStyleModel.instance:UseStyle(slot0._heroId, slot0:_getSelectCubeMo())
end

function slot0._btncompareOnClick(slot0)
	slot0:_showComparePanel()
end

function slot0._btninteamOnClick(slot0)
end

function slot0._btnfoldOnClick(slot0)
	slot0:_hideComparePanel()
end

function slot0._btnclickOnClick(slot0)
end

function slot0._btnunlockOnClick(slot0)
	slot1 = slot0:_getSelectCubeMo()
	slot2, slot3, slot4, slot5 = slot0:_isEnoughUnlock()

	if slot4 then
		if not slot1._isUnlock then
			slot1._isUnlock = true

			HeroRpc.instance:setUnlockTalentStyleRequest(slot0._heroId, slot1._styleId)
		end
	else
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot5, slot3)
	end
end

function slot0._addEvents(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.onUnlockTalentStyleReply, slot0._onUnlockTalentStyleReply, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, slot0._onUseTalentStyleReply, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.onSelectTalentStyle, slot0._onSelectTalentStyle, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.currencyChangeEvent, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.currencyChangeEvent, slot0)
	slot0._scrollstyle:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.onUnlockTalentStyleReply, slot0._onUnlockTalentStyleReply, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, slot0._onUseTalentStyleReply, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.onSelectTalentStyle, slot0._onSelectTalentStyle, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.currencyChangeEvent, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.currencyChangeEvent, slot0)
	slot0._animEvent:RemoveAllEventListener()
	slot0._scrollstyle:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "#go_cubeinfo/panel")
	slot0._attrItem = gohelper.findChild(slot1, "attributeItem")
	slot0._curAttrPanel = gohelper.findChild(slot1, "cur/panel")
	slot0._compareAttrPanel = gohelper.findChild(slot1, "compare/panel")
	slot0._objCompareAttrPanel = gohelper.findChild(slot1, "compare")
	slot0._itemCircle = gohelper.findChild(slot0.viewGO, "#go_inspirationItem/item/slot/dec1")
	slot0._txtunlock = gohelper.findChildText(slot0.viewGO, "go_unlock/#btn_unlock/txt")
	slot0._goitemUnlock = gohelper.findChild(slot0.viewGO, "#go_inspirationItem/item/#unlock")
	slot0._goitemUse = gohelper.findChild(slot0.viewGO, "#go_inspirationItem/item/#use")
	slot0._animUnlock = SLFramework.AnimatorPlayer.Get(gohelper.findChild(slot0.viewGO, "go_unlock"))
	slot0._requestCanvas = slot0._gorequest:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._txtusing = gohelper.findChildText(slot0.viewGO, "go_unlock/#go_using/txt_using")
	slot0._txtuse = gohelper.findChildText(slot0.viewGO, "go_unlock/#btn_use/txt")

	slot0:_hideItemUnlock()
	slot0:_hideItemUse()
	gohelper.setActive(slot0._attrItem, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_addEvents()

	slot0._isHideNewTag = nil

	TalentStyleModel.instance:setNewUnlockStyle()
	TalentStyleModel.instance:setNewSelectStyle()

	slot0._animPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._animEvent = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animEvent:AddEventListener("switch", slot0._refreshView, slot0)

	if not slot0.viewParam.isJustOpen then
		slot0._animPlayer:Play("open", nil, slot0)
	end

	slot0._heroId = slot0.viewParam.hero_id
	slot0._heroMo = HeroModel.instance:getByHeroId(slot0._heroId)
	slot0._txtusing.text = luaLang("talent_style_title_using_cn_" .. CharacterEnum.TalentTxtByHeroType[slot0._heroMo.config.heroType])
	slot0._txtuse.text = luaLang("talent_style_title_use_cn_" .. CharacterEnum.TalentTxtByHeroType[slot0._heroMo.config.heroType])

	TalentStyleModel.instance:openView(slot0._heroId)
	slot0:_initInspirationItem()

	slot0._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(slot0._heroId)

	slot0:_hideComparePanel()
	slot0:_refreshView()
	HeroRpc.instance:setTalentStyleReadRequest(slot0._heroId)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
	TaskDispatcher.cancelTask(slot0._hideItemUse, slot0)
	TaskDispatcher.cancelTask(slot0._hideItemUnlock, slot0)
	TaskDispatcher.cancelTask(slot0._hideNewTag, slot0)
end

function slot0._refreshView(slot0)
	TalentStyleListModel.instance:refreshData(slot0._heroId)
	slot0:_refreshAttribute()
	slot0:_refreshBtn()
	slot0:_refreshUnlockItem()
	slot0:_refreshAttrCompareBtn()
	slot0:_refreshInspirationItem()
end

function slot0._onScrollValueChanged(slot0)
	if slot0._isHideNewTag then
		return
	end

	slot0._isHideNewTag = true

	TaskDispatcher.runDelay(slot0._hideNewTag, slot0, 0.2)
end

function slot0._hideNewTag(slot0)
	TalentStyleModel.instance:hideNewState(slot0._heroId)
end

function slot0._initInspirationItem(slot0)
	slot1 = TalentStyleModel.instance:getHeroMainCubeMo(slot0._heroId)
	slot2 = gohelper.findChild(slot0._goinspirationItem, "item")
	slot0._slot = gohelper.findChildImage(slot2, "slot")
	slot0._slotAnim = slot0._slot:GetComponent(typeof(UnityEngine.Animator))
	slot0._cubeIcon = gohelper.findChildImage(slot2, "slot/icon")
	slot0._cubeglow = gohelper.findChildImage(slot2, "slot/glow")
	slot5 = string.split(HeroResonanceConfig.instance:getCubeConfig(slot1.id).icon, "_")
	slot0._slotSprite = "gz_" .. slot5[#slot5]
	gohelper.findChildText(slot2, "level/level").text = "Lv." .. slot1.level
end

slot1 = Color.white
slot2 = Color(1, 1, 1, 0.5)

function slot0._refreshInspirationItem(slot0)
	slot5 = slot0._slotSprite
	slot6 = 1.7

	if HeroResonanceConfig.instance:getCubeConfig(TalentStyleModel.instance:getSelectCubeMo(slot0._heroId)._replaceId) then
		slot8 = slot4.icon

		if slot0._heroMo.talentCubeInfos.own_main_cube_id ~= slot2 and not string.nilorempty(slot7) then
			slot8 = "mk_" .. slot7
			slot5 = slot0._slotSprite .. "_2"
		end

		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._cubeIcon, slot8, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._cubeglow, slot8, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._slot, slot5, true)
		transformhelper.setLocalScale(slot0._slot.transform, slot6, slot6, slot6)
	end

	slot7 = slot1._isUnlock
	slot8 = slot1._isUse

	gohelper.setActive(slot0._itemCircle, slot8)

	slot0._cubeIcon.enabled = slot8
	slot0._slotAnim.enabled = slot7

	slot0._slotAnim:Play("slot_loop", 0, 0)

	slot0._slot.color = slot7 and uv0 or uv1
	slot0._cubeglow.color = slot7 and uv0 or uv1

	gohelper.setActive(slot0._cubeIcon.gameObject, slot7)
end

function slot0._getAttributeDataList(slot0, slot1)
	slot3 = TalentStyleModel.instance:getHeroMainCubeMo(slot0._heroId).level
	slot4 = HeroConfig.instance:getTalentCubeAttrConfig(slot1, slot3)
	slot5 = {}
	slot10, slot11 = nil

	slot0._heroMo:getTalentAttrGainSingle(slot1, slot5, slot10, slot11, slot3)

	slot6 = {}

	for slot10, slot11 in pairs(slot5) do
		table.insert(slot6, {
			key = slot10,
			value = slot11,
			is_special = slot4.calculateType == 1,
			config = slot4
		})
	end

	table.sort(slot6, function (slot0, slot1)
		return HeroConfig.instance:getIDByAttrType(slot0.key) < HeroConfig.instance:getIDByAttrType(slot1.key)
	end)

	return slot6
end

function slot0._showComparePanel(slot0)
	gohelper.CreateObjList(slot0, slot0._onItemShow, slot0:_getAttributeDataList(TalentStyleModel.instance:getHeroUseCubeId(slot0._heroId)), slot0._compareAttrPanel, slot0._attrItem)
	gohelper.setActive(slot0._objCompareAttrPanel, true)

	slot0._txtcompareStyleName.text, slot0._txtcompareLabel.text = TalentStyleModel.instance:getHeroUseCubeMo(slot0._heroId):getStyleTag()

	slot0:_refreshAttrCompareBtn()
end

function slot0._hideComparePanel(slot0)
	gohelper.setActive(slot0._objCompareAttrPanel, false)
	slot0:_refreshAttrCompareBtn()
end

function slot0._refreshAttrCompareBtn(slot0)
	if TalentStyleModel.instance:getSelectStyleId(slot0._heroId) == TalentStyleModel.instance:getHeroUseCubeStyleId(slot0._heroId) and slot0._objCompareAttrPanel.gameObject.activeSelf then
		gohelper.setActive(slot0._objCompareAttrPanel, false)

		slot4 = false
	end

	gohelper.setActive(slot0._btncompare.gameObject, not slot3 and not slot4)
	gohelper.setActive(slot0._btninteam.gameObject, slot3)
	gohelper.setActive(slot0._btnfold.gameObject, slot4)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot5 = slot4:Find("icon"):GetComponent(gohelper.Type_Image)
	slot6 = slot4:Find("bg")
	slot7 = slot4:Find("name"):GetComponent(gohelper.Type_TextMesh)
	slot8 = slot4:Find("name/num"):GetComponent(gohelper.Type_TextMesh)

	if HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot2.key)).type ~= 1 then
		slot2.value = tonumber(string.format("%.3f", slot2.value / 10)) .. "%"
	else
		slot2.value = math.floor(slot2.value)
	end

	slot8.text = slot2.value
	slot7.text = slot9.name

	gohelper.setActive(slot6.gameObject, slot3 % 2 == 0)
	UISpriteSetMgr.instance:setCommonSprite(slot5, "icon_att_" .. slot9.id, true)
end

function slot0._refreshAttribute(slot0)
	slot1 = slot0:_getSelectCubeMo()

	gohelper.CreateObjList(slot0, slot0._onItemShow, slot0:_getAttributeDataList(slot1._replaceId), slot0._curAttrPanel, slot0._attrItem)

	slot0._txtcurStyleName.text, slot0._txtcurLabel.text = slot1:getStyleTag()
end

function slot0._refreshBtn(slot0)
	slot3 = slot0:_getSelectCubeMo()._isUnlock and slot1._isUse

	gohelper.setActive(slot0._btnunlock.gameObject, not slot2)
	gohelper.setActive(slot0._btnuse.gameObject, slot2 and not slot3)
	gohelper.setActive(slot0._gousing.gameObject, slot2 and slot3)

	if not slot2 then
		slot4, slot5, slot6, slot7 = slot0:_isEnoughUnlock()

		ZProj.UGUIHelper.SetGrayscale(slot0._btnunlock.gameObject, not slot6)
	end

	gohelper.setActive(slot0._gorequest, not slot2)

	slot0._requestCanvas.alpha = slot2 and 0 or 1
end

function slot0._refreshUnlockItem(slot0)
	if not slot0:_getSelectCubeMo()._isUnlock then
		IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onCostItemShow, slot0:_isEnoughUnlock(), slot0._gorequest)
	end
end

function slot0._isEnoughUnlock(slot0)
	if HeroResonanceConfig.instance:getTalentStyleUnlockConsume(slot0._heroId, TalentStyleModel.instance:getSelectStyleId(slot0._heroId)) then
		slot3 = ItemModel.instance:getItemDataListByConfigStr(slot2)
		slot4, slot5, slot6 = ItemModel.instance:hasEnoughItemsByCellData(slot3)

		return slot3, slot4, slot5, slot6
	end

	return nil, "", true, nil
end

function slot0._onCostItemShow(slot0, slot1, slot2, slot3)
	transformhelper.setLocalScale(slot1.viewGO.transform, 0.59, 0.59, 1)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)
	slot1:setCountText(ItemModel.instance:getItemIsEnoughText(slot2))
	slot1:setOnBeforeClickCallback(slot0.onBeforeClickItem, slot0)
	slot1:setRecordFarmItem({
		type = slot2.materilType,
		id = slot2.materilId,
		quantity = slot2.quantity
	})
end

function slot0.onBeforeClickItem(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(JumpController.instance:getCurrentOpenedView()) do
		if slot8.viewName == ViewName.CharacterTalentStyleView then
			slot8.viewParam.isJustOpen = true

			break
		end
	end

	slot2:setRecordFarmItem({
		type = slot2._itemType,
		id = slot2._itemId,
		quantity = slot2._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = slot3
	})
end

function slot0._getSelectCubeMo(slot0)
	if not slot0._selectCubeMo then
		slot0._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(slot0._heroId)
	end

	return slot0._selectCubeMo
end

function slot0._onUnlockTalentStyleReply(slot0, slot1)
	TalentStyleModel.instance:refreshUnlockList(slot1.heroId)
	slot0:_hideComparePanel()
	slot0._animUnlock:Play("unlock", slot0._unlockAnimEnd, slot0)
	TalentStyleModel.instance:setNewUnlockStyle(slot1.style)
	TaskDispatcher.cancelTask(slot0._hideItemUnlock, slot0)
	gohelper.setActive(slot0._goitemUnlock, true)
	TaskDispatcher.runDelay(slot0._hideItemUnlock, slot0, 1.2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_unlock_02)
end

function slot0._unlockAnimEnd(slot0)
	slot0:_refreshView()
end

function slot0._hideItemUnlock(slot0)
	gohelper.setActive(slot0._goitemUnlock, false)
end

function slot0._hideItemUse(slot0)
	gohelper.setActive(slot0._goitemUse, false)
end

function slot0._onUseTalentStyleReply(slot0, slot1)
	slot0:_hideComparePanel()
	slot0:_refreshView()
	TaskDispatcher.cancelTask(slot0._hideItemUse, slot0)
	gohelper.setActive(slot0._goitemUse, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_fm)
	TaskDispatcher.runDelay(slot0._hideItemUse, slot0, 0.6)
end

function slot0._onSelectTalentStyle(slot0, slot1)
	slot0._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(slot0._heroId)

	slot0._animPlayer:Play("switch", nil, slot0)
end

function slot0.currencyChangeEvent(slot0)
	slot0:_refreshUnlockItem()
	slot0:_refreshBtn()
end

function slot0.playCloseAnim(slot0)
	slot0._animPlayer:Play("close", slot0.closeThis, slot0)
end

return slot0
