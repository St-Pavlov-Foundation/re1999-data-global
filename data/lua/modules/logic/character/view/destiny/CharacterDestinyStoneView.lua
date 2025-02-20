module("modules.logic.character.view.destiny.CharacterDestinyStoneView", package.seeall)

slot0 = class("CharacterDestinyStoneView", BaseView)

function slot0.onInitView(slot0)
	slot0._godrag = gohelper.findChild(slot0.viewGO, "#go_drag")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "root/#image_icon")
	slot0._txtstonename = gohelper.findChildText(slot0.viewGO, "root/#txt_stonename")
	slot0._gostone = gohelper.findChild(slot0.viewGO, "root/#go_stone")
	slot0._goprestone = gohelper.findChild(slot0.viewGO, "root/#go_prestone")
	slot0._btnprestone = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_prestone/#btn_prestone")
	slot0._gonextstone = gohelper.findChild(slot0.viewGO, "root/#go_nextstone")
	slot0._btnnextstone = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_nextstone/#btn_nextstone")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "root/btn/#go_unlock")
	slot0._gounlockitem = gohelper.findChild(slot0.viewGO, "root/btn/#go_unlock/#go_unlockitem")
	slot0._btnunlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#go_unlock/#btn_unlock")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "root/btn/#go_select")
	slot0._btnselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#go_select/#btn_select")
	slot0._gounselect = gohelper.findChild(slot0.viewGO, "root/btn/#go_unselect")
	slot0._btnunselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#go_unselect/#btn_unselect")
	slot0._goexchange = gohelper.findChild(slot0.viewGO, "root/btn/#go_exchange")
	slot0._btnexchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#go_exchange/#btn_exchange")
	slot0._gopoint = gohelper.findChild(slot0.viewGO, "root/point/#go_point")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnprestone:AddClickListener(slot0._btnprestoneOnClick, slot0)
	slot0._btnnextstone:AddClickListener(slot0._btnnextstoneOnClick, slot0)
	slot0._btnunlock:AddClickListener(slot0._btnunlockOnClick, slot0)
	slot0._btnselect:AddClickListener(slot0._btnselectOnClick, slot0)
	slot0._btnunselect:AddClickListener(slot0._btnunselectOnClick, slot0)
	slot0._btnexchange:AddClickListener(slot0._btnexchangeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnprestone:RemoveClickListener()
	slot0._btnnextstone:RemoveClickListener()
	slot0._btnunlock:RemoveClickListener()
	slot0._btnselect:RemoveClickListener()
	slot0._btnunselect:RemoveClickListener()
	slot0._btnexchange:RemoveClickListener()
end

function slot0._btnprestoneOnClick(slot0)
	slot0._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchRight, 0, 0)
	TaskDispatcher.runDelay(slot0._cutPreStoneCB, slot0, 0.16)
end

function slot0._btnnextstoneOnClick(slot0)
	slot0._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchLeft, 0, 0)
	TaskDispatcher.runDelay(slot0._cutNextStoneCB, slot0, 0.16)
end

function slot0._btnunselectOnClick(slot0)
	CharacterDestinyController.instance:onUseStone(slot0._heroMO.heroId, 0)
end

function slot0._btnunlockOnClick(slot0)
	if not slot0._curStoneMo then
		return
	end

	if slot0._curStoneMo.conusmeCo then
		slot2, slot3, slot4 = ItemModel.instance:hasEnoughItemsByCellData(ItemModel.instance:getItemDataListByConfigStr(slot0._curStoneMo.conusmeCo.consume))

		if not slot3 then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot4, slot2)

			return
		end
	end

	if slot0._facetMos[slot0._selectStoneIndex] then
		slot0:openUnlockStoneView(slot1.stoneId)
	end
end

function slot0._btnselectOnClick(slot0)
	if slot0._facetMos[slot0._selectStoneIndex] then
		CharacterDestinyController.instance:onUseStone(slot0._heroMO.heroId, slot1.stoneId)
	end
end

function slot0._btnexchangeOnClick(slot0)
	if slot0._facetMos[slot0._selectStoneIndex] then
		CharacterDestinyController.instance:onUseStone(slot0._heroMO.heroId, slot1.stoneId)
	end
end

function slot0._editableInitView(slot0)
	slot0._simagestone = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_stone/#simage_stone")
	slot0._simagepre = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_prestone/#btn_prestone")
	slot0._simagenext = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_nextstone/#btn_nextstone")
	slot0._gounlockstone = gohelper.findChild(slot0.viewGO, "unlockstone")
	slot0._root = gohelper.findChild(slot0.viewGO, "root")
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "root/effectItem")
	slot0._imgstone = gohelper.findChildImage(slot0.viewGO, "root/#go_stone/#simage_stone")
	slot0._goEquip = gohelper.findChild(slot0.viewGO, "root/#go_stone/#equip")
	slot0._animRoot = slot0._root:GetComponent(typeof(UnityEngine.Animator))
	slot0._animPlayerRoot = ZProj.ProjAnimatorPlayer.Get(slot0._root)
	slot0._animPlayerUnlockStone = ZProj.ProjAnimatorPlayer.Get(slot0._gounlockstone)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godrag.gameObject)
end

function slot0.onUpdateParam(slot0)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, slot0._onUnlockStoneReply, slot0)
	slot0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, slot0._onUseStoneReply, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshConsume, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshConsume, slot0)

	if slot0._drag then
		slot0._drag:AddDragBeginListener(slot0._dragBeginEventCb, slot0)
		slot0._drag:AddDragListener(slot0._dragEventCb, slot0)
		slot0._drag:AddDragEndListener(slot0._dragEndEventCb, slot0)
	end
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, slot0._onUnlockStoneReply, slot0)
	slot0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, slot0._onUseStoneReply, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshConsume, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshConsume, slot0)

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()
	end
end

function slot0._refreshView(slot0)
	slot0:_refreshStoneItem(slot0._selectStoneIndex)
	slot0:_refreshBtn()
end

function slot0._onUnlockStoneReply(slot0, slot1, slot2)
	if slot0._curStoneMo then
		slot0._curStoneMo:refresUnlock(true)
	end

	slot0:_refreshView()
	gohelper.setActive(slot0._root, true)
	gohelper.setActive(slot0._gounlockstone, false)
end

function slot0._onUseStoneReply(slot0, slot1, slot2)
	slot0._heroMO.destinyStoneMo:refreshUseStone()

	slot0._curUseStoneId = slot0._heroMO.destinyStoneMo.curUseStoneId

	slot0:_refreshBtn()
	gohelper.setActive(slot0._goEquip, slot0._curStoneMo.isUse)
end

function slot0.onOpen(slot0)
	slot0:_addEvents()

	slot0._effectItems = slot0:getUserDataTb_()

	for slot4 = 1, CharacterDestinyEnum.EffectItemCount do
		slot5 = gohelper.findChild(slot0._goeffect, slot4)
		slot6 = slot0:getUserDataTb_()
		slot6.go = slot5
		slot6.lockicon = gohelper.findChildImage(slot5, "#txt_dec/#go_lockicon")
		slot6.unlockicon = gohelper.findChildImage(slot5, "#txt_dec/#go_unlockicon")
		slot6.txt = gohelper.findChildText(slot5, "#txt_dec")
		slot6.gounlock = gohelper.findChild(slot5, "#unlock")
		slot6.canvasgroup = slot5:GetComponent(typeof(UnityEngine.CanvasGroup))
		slot0._effectItems[slot4] = slot6
	end

	slot0._heroMO = slot0.viewParam.heroMo
	slot0._curUseStoneId = slot0._heroMO.destinyStoneMo.curUseStoneId
	slot0._facetMos = {}

	if slot0._heroMO.destinyStoneMo.stoneMoList then
		slot2 = 1
		slot3 = 1

		for slot7, slot8 in pairs(slot1) do
			if slot8.stoneId == slot0._curUseStoneId then
				slot3 = slot2
			end

			slot2 = slot2 + 1

			table.insert(slot0._facetMos, slot8)
		end

		slot0:_refreshStoneItem(slot3)
		slot0:_refreshBtn()
	end

	gohelper.setActive(slot0._root, true)
	gohelper.setActive(slot0._gounlockstone, false)
end

function slot0._refreshStoneItem(slot0, slot1)
	if not slot1 or slot1 == 0 then
		slot1 = 1
	end

	slot0._selectStoneIndex = slot1
	slot2 = #slot0._facetMos
	slot0._curStoneMo = slot0._facetMos[slot1]

	if slot0._curStoneMo then
		slot0._levelCos = slot0._curStoneMo:getFacetCo()
		slot3 = slot0._curStoneMo.conusmeCo

		if slot0._levelCos then
			for slot7, slot8 in ipairs(slot0._effectItems) do
				slot8.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(slot8.txt.gameObject, SkillDescComp)

				slot8.skillDesc:updateInfo(slot8.txt, slot0._levelCos[slot7].desc, slot0._heroMO.heroId)
				slot8.skillDesc:setTipParam(0, Vector2(300, 100))

				slot10 = slot0._curStoneMo.isUnlock and slot7 <= slot0._heroMO.destinyStoneMo.rank
				slot11 = slot8.txt.color
				slot11.a = slot10 and 1 or 0.43
				slot8.txt.color = slot11

				if slot10 then
					slot12 = slot8.unlockicon.color
					slot12.a = slot10 and 1 or 0.43
					slot8.unlockicon.color = slot12
				else
					slot12 = slot8.lockicon.color
					slot12.a = slot10 and 1 or 0.43
					slot8.lockicon.color = slot12
				end

				gohelper.setActive(slot8.lockicon.gameObject, not slot10)
				gohelper.setActive(slot8.unlockicon.gameObject, slot10)
			end
		end

		gohelper.setActive(slot0._goEquip, slot0._curStoneMo.isUse)

		if slot3 then
			slot0._txtstonename.text, slot5 = slot0._curStoneMo:getNameAndIcon()

			slot0._simagestone:LoadImage(slot5)

			slot6 = CharacterDestinyEnum.SlotTend[slot3.tend]

			UISpriteSetMgr.instance:setUiCharacterSprite(slot0._imageicon, slot6.TitleIconName)

			slot0._txtstonename.color = GameUtil.parseColor(slot6.TitleColor)
		end

		slot0._imgstone.color = slot0._curStoneMo.isUnlock and Color.white or Color(0.5, 0.5, 0.5, 1)

		slot0:_checkPlayAttrUnlockAnim(slot0._curStoneMo.stoneId)
	end

	if not slot0._pointItems then
		slot0._pointItems = slot0:getUserDataTb_()
	end

	if slot2 > 1 then
		for slot6 = 1, slot2 do
			gohelper.setActive(slot0:_getPointItem(slot6).select, slot1 == slot6)
			gohelper.setActive(slot7.go, true)
		end
	else
		for slot6, slot7 in ipairs(slot0._pointItems) do
			gohelper.setActive(slot7.go, false)
		end
	end

	slot0:_refreshConsume()
	slot0:_refreshPreAndNextStoneItem(slot1)
end

function slot0._refreshConsume(slot0)
	if not slot0._curStoneMo then
		return
	end

	if not slot0._curStoneMo.isUnlock then
		IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onCostItemShow, ItemModel.instance:getItemDataListByConfigStr(slot0._curStoneMo.conusmeCo.consume), slot0._gounlockitem)
	end
end

function slot0._checkPlayAttrUnlockAnim(slot0, slot1)
	if slot0._effectItems then
		for slot5, slot6 in ipairs(slot0._effectItems) do
			gohelper.setActive(slot6.gounlock, slot0._heroMO.destinyStoneMo:isCanPlayAttrUnlockAnim(slot1, slot5))
		end
	end
end

function slot0._refreshPreAndNextStoneItem(slot0, slot1)
	if slot1 > 1 and slot0._facetMos[slot1 - 1] and slot2.conusmeCo then
		slot3, slot4 = slot2:getNameAndIcon()

		slot0._simagepre:LoadImage(slot4)
	end

	if slot1 < #slot0._facetMos and slot0._facetMos[slot1 + 1] and slot2.conusmeCo then
		slot3, slot4 = slot2:getNameAndIcon()

		slot0._simagenext:LoadImage(slot4)
	end

	gohelper.setActive(slot0._goprestone, slot1 > 1)
	gohelper.setActive(slot0._gonextstone, slot1 < #slot0._facetMos)
end

function slot0._onCostItemShow(slot0, slot1, slot2, slot3)
	transformhelper.setLocalScale(slot1.viewGO.transform, 0.6, 0.6, 1)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)

	slot4 = slot1:getItemIcon():getCount()
	slot4.enableAutoSizing = true
	slot4.gameObject:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = false
	slot4.fontSizeMax = 48
	slot4.fontSizeMin = 30
	slot4.transform.anchorMax = Vector2(0.5, 0.5)
	slot4.transform.anchorMin = Vector2(0.5, 0.5)
	slot4.transform.pivot = Vector2(0.5, 0.5)
	slot4.alignment = TMPro.TextAlignmentOptions.Center

	recthelper.setWidth(slot4.transform, 170)
	recthelper.setHeight(slot4.transform, 70)
	slot1:SetCountLocalY(-50)
	slot1:setCountText(ItemModel.instance:getItemIsEnoughText(slot2))
	slot1:setOnBeforeClickCallback(slot0.onBeforeClickItem, slot0)
end

function slot0.onBeforeClickItem(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(JumpController.instance:getCurrentOpenedView(slot0.viewName)) do
		if slot8.viewName == ViewName.CharacterDestinySlotView then
			slot8.viewParam.isBack = true

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

function slot0._refreshBtn(slot0)
	if not slot0._curStoneMo then
		return
	end

	slot1 = slot0._heroMO.destinyStoneMo:isUnlockSlot()
	slot2 = slot0._curStoneMo.isUnlock
	slot3 = slot0._curStoneMo.isUse
	slot4 = slot0._curUseStoneId ~= 0

	gohelper.setActive(slot0._gounlock.gameObject, slot1 and not slot2)
	gohelper.setActive(slot0._goselect.gameObject, slot1 and slot2 and not slot3 and not slot4)
	gohelper.setActive(slot0._gounselect.gameObject, slot1 and slot2 and slot3)
	gohelper.setActive(slot0._goexchange.gameObject, slot1 and slot2 and not slot3 and slot4)
end

function slot0._getPointItem(slot0, slot1)
	if not slot0._pointItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._gopoint, slot1)
		slot2.go = slot3
		slot2.normal = gohelper.findChild(slot3, "normal")
		slot2.select = gohelper.findChild(slot3, "select")
		slot0._pointItems[slot1] = slot2
	end

	return slot2
end

function slot0.openUnlockStoneView(slot0, slot1)
	if not slot0._unlockStoneView then
		slot0._unlockStoneView = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gounlockstone, CharacterDestinyUnlockStoneComp)

		slot0._unlockStoneView:setStoneView(slot0)
	end

	slot0._unlockStoneView:onUpdateMo(slot0._heroMO.heroId, slot1)
	gohelper.setActive(slot0._gounlockstone, true)
	slot0:playRootOpenCloseAnim(false, slot0._hideRoot, slot0)
	slot0:playUnlockstoneOpenCloseAnim(true, nil, slot0)
	slot0.viewContainer:setOpenUnlockStoneView(true)
end

function slot0.closeUnlockStoneView(slot0)
	gohelper.setActive(slot0._root, true)
	slot0:playRootOpenCloseAnim(true, nil, slot0)
	slot0:playUnlockstoneOpenCloseAnim(false, slot0._hideUnlockstone, slot0)
	slot0.viewContainer:setOpenUnlockStoneView(false)
end

function slot0._cutPreStoneCB(slot0)
	slot0:_refreshStoneItem(slot0._selectStoneIndex - 1)
	slot0:_refreshBtn()
end

function slot0._cutNextStoneCB(slot0)
	slot0:_refreshStoneItem(slot0._selectStoneIndex + 1)
	slot0:_refreshBtn()
end

function slot0._dragBeginEventCb(slot0, slot1, slot2)
	slot0._dragPos = slot2.position
end

function slot0._dragEventCb(slot0, slot1, slot2)
end

function slot0._dragEndEventCb(slot0, slot1, slot2)
	if #slot0._facetMos < 2 then
		slot0._dragPos = nil

		return
	end

	if slot0._dragPos then
		TaskDispatcher.cancelTask(slot0._cutPreStoneCB, slot0)
		TaskDispatcher.cancelTask(slot0._cutNextStoneCB, slot0)

		if slot0._dragPos.x < slot2.position.x and slot0._selectStoneIndex > 1 then
			slot0._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchRight, 0, 0)
			TaskDispatcher.runDelay(slot0._cutPreStoneCB, slot0, 0.16)
		elseif slot2.position.x < slot0._dragPos.x and slot0._selectStoneIndex < #slot0._facetMos then
			slot0._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchLeft, 0, 0)
			TaskDispatcher.runDelay(slot0._cutNextStoneCB, slot0, 0.16)
		end
	end
end

function slot0.onUnlockStone(slot0)
	slot0.viewContainer:setOpenUnlockStoneView(false)
	slot0:_refreshBtn()
end

function slot0.playRootOpenCloseAnim(slot0, slot1, slot2, slot3)
	slot0:playRootAnim(slot1 and CharacterDestinyEnum.StoneViewAnim.Open or CharacterDestinyEnum.StoneViewAnim.Close, slot2, slot3)
end

function slot0.playUnlockstoneOpenCloseAnim(slot0, slot1, slot2, slot3)
	slot0:playUnlockstoneAnim(slot1 and CharacterDestinyEnum.StoneViewAnim.Open or CharacterDestinyEnum.StoneViewAnim.Close, slot2, slot3)
end

function slot0.playRootAnim(slot0, slot1, slot2, slot3)
	slot0._animPlayerRoot:Play(slot1, slot2, slot3)
end

function slot0.playUnlockstoneAnim(slot0, slot1, slot2, slot3)
	slot0._animPlayerUnlockStone:Play(slot1, slot2, slot3)
end

function slot0._hideRoot(slot0)
	gohelper.setActive(slot0._root, false)
end

function slot0._hideUnlockstone(slot0)
	gohelper.setActive(slot0._gounlockstone, false)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
	slot0._simagestone:UnLoadImage()
	slot0._simagepre:UnLoadImage()
	slot0._simagenext:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._cutPreStoneCB, slot0)
	TaskDispatcher.cancelTask(slot0._cutNextStoneCB, slot0)
end

return slot0
