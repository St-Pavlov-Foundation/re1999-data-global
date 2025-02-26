module("modules.logic.room.view.building.RoomFormulaItem", package.seeall)

slot0 = class("RoomFormulaItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_normal/layout/#txt_name")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_normal/materials/#go_coinitem/#go_item")
	slot0._imagecoinRare = gohelper.findChildImage(slot0.viewGO, "#go_normal/materials/#go_coinitem/#go_item/image_coinRare")
	slot0._simagecoinIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/materials/#go_coinitem/#go_item/simage_coinIcon")
	slot0._txtgold = gohelper.findChildText(slot0.viewGO, "#go_normal/materials/#go_coinitem/#txt_gold")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_normal/materials/#go_coinitem/#go_empty")
	slot0._txtCombineNum = gohelper.findChildText(slot0.viewGO, "#go_normal/layout/itemNum/#txt_num")
	slot0._simageproduceitem = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_produceitem")
	slot0._gomaterialitem = gohelper.findChild(slot0.viewGO, "#go_normal/materials/#go_materialitem")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._golockitem = gohelper.findChildText(slot0.viewGO, "#go_lock/locklayout/#go_lockitem")
	slot0._txtlock = gohelper.findChildText(slot0.viewGO, "#go_lock/#txt_lock")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "#go_normal/raremask/#image_rare")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_click")
	slot0._btncoin = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/materials/#go_coinitem/#go_item/#btn_coin")
	slot0._btnlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_lock/#btn_lock")
	slot0._goNeedTag = gohelper.findChild(slot0.viewGO, "#go_normal/#go_TagNeed")
	slot0._goOwnNum = gohelper.findChild(slot0.viewGO, "#go_normal/itemNum")
	slot0._txtOwnNum = gohelper.findChildText(slot0.viewGO, "#go_normal/itemNum/#txt_num")
	slot0._goNeed = gohelper.findChild(slot0.viewGO, "#go_normal/layout/#go_Need")
	slot0._goCanCombine = gohelper.findChild(slot0.viewGO, "#go_normal/layout/#go_Mix")
	slot0._txtCanCombine = gohelper.findChildText(slot0.viewGO, "#go_normal/layout/#go_Mix/#txt_Mix")
	slot0._gonormalTrs = slot0._gonormal.transform
	slot0._golockTrs = slot0._golock.transform

	gohelper.setActive(slot0._goNeed, false)
	gohelper.setActive(slot0._goOwnNum, false)
	gohelper.setActive(slot0._goCanCombine, false)

	slot0._animator = slot0.viewGO:GetComponent(RoomEnum.ComponentType.Animator)
	slot0._lineAnimator = slot0._gonormal:GetComponent(RoomEnum.ComponentType.Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btncoin:AddClickListener(slot0._btncoinOnClick, slot0)
	slot0._btnlock:AddClickListener(slot0._btnlockOnClick, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.RefreshFormulaCombineCount, slot0._onFormulaCombineCountRefresh, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelHideAnim, slot0._onHideAnimAnimation, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelShowAnim, slot0._onShowAnimAnimation, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelMoveAnim, slot0._onMoveAnimAnimation, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.RefreshNeedFormulaItem, slot0._refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btncoin:RemoveClickListener()
	slot0._btnlock:RemoveClickListener()
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.RefreshFormulaCombineCount, slot0._onFormulaCombineCountRefresh, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelHideAnim, slot0._onHideAnimAnimation, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelShowAnim, slot0._onShowAnimAnimation, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelMoveAnim, slot0._onMoveAnimAnimation, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.RefreshNeedFormulaItem, slot0._refreshUI, slot0)
end

function slot0._btnclickOnClick(slot0)
	if slot0._unlock then
		RoomBuildingFormulaController.instance:setSelectFormulaStrId(slot0._mo:getId(), nil, slot0._mo:getFormulaTreeLevel())
		AudioMgr.instance:trigger(AudioEnum.UI.UI_transverse_tabs_click)
	else
		slot0:_btnlockOnClick()
	end
end

function slot0._btncoinOnClick(slot0)
	if not slot0._unlock then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Gold, false, nil, false, {
		type = MaterialEnum.MaterialType.Currency,
		id = CurrencyEnum.CurrencyType.Gold,
		quantity = slot0.costScore,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function slot0._btnlockOnClick(slot0)
	slot2, slot3, slot4, slot5 = RoomProductionHelper.isFormulaUnlock(slot0._mo:getFormulaId(), slot0._lineMO.level)

	if slot3 then
		GameFacade.showToast(ToastEnum.ClickRoomFormulaEpisode, slot3)
	elseif slot4 then
		GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, slot0._lineMO.config.name, slot4)
	elseif slot5 then
		GameFacade.showToast(ToastEnum.ClickRoomFormula)
	end
end

function slot0._onFormulaCombineCountRefresh(slot0, slot1)
	if slot1 == slot0._mo:getId() then
		slot0:_refreshCoinCount()
		slot0:_refreshMaterialItemCount()
	end
end

function slot0._onChangePartStart(slot0, slot1)
	if slot1 == slot0._mo:getId() then
		gohelper.setActive(slot0._gosynthesis, false)
		gohelper.setActive(slot0._gosynthesis, true)
	end
end

function slot0._editableInitView(slot0)
	slot0._materialItemList = {}

	gohelper.setActive(slot0._gomaterialitem, false)

	slot0._maxMaterialItemCount = 3

	for slot4 = 1, slot0._maxMaterialItemCount do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.cloneInPlace(slot0._gomaterialitem, "item" .. slot4)
		slot5.goitem = gohelper.findChild(slot5.go, "go_item")
		slot5.gopos = gohelper.findChild(slot5.go, "go_item/go_pos")
		slot5.txtnum = gohelper.findChildText(slot5.go, "go_item/txt_num")
		slot5.goempty = gohelper.findChild(slot5.go, "go_empty")

		table.insert(slot0._materialItemList, slot5)
		gohelper.setActive(slot5.go, true)
	end

	slot4 = UnityEngine.CanvasGroup
	slot0._canvasGroup = slot0._gonormal:GetComponent(typeof(slot4))

	gohelper.removeUIClickAudio(slot0._btnclick.gameObject)

	slot0._gosynthesis = gohelper.findChild(slot0.viewGO, "#go_normal/#synthesis")
	slot0._treeLevelItemList = {}

	for slot4 = 1, RoomFormulaModel.MAX_FORMULA_TREE_LEVEL do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "#go_normal/#go_BG" .. slot4)
		slot5.goSelect = gohelper.findChild(slot5.go, "#go_Select")
		slot5.lineT = gohelper.findChild(slot5.go, "#go_LineT")
		slot5.lineTNo = gohelper.findChild(slot5.go, "#go_LineT/normal")
		slot5.lineTHL = gohelper.findChild(slot5.go, "#go_LineT/highlight")
		slot5.lineL = gohelper.findChild(slot5.go, "#go_LineL")
		slot5.lineLNo = gohelper.findChild(slot5.go, "#go_LineL/normal")
		slot5.lineLHL = gohelper.findChild(slot5.go, "#go_LineL/highlight")
		slot5.lineI1 = gohelper.findChild(slot5.go, "#go_LineI1")
		slot5.lineI1No = gohelper.findChild(slot5.go, "#go_LineI1/normal")
		slot5.lineI1HL = gohelper.findChild(slot5.go, "#go_LineI1/highlight")
		slot5.lineI2 = gohelper.findChild(slot5.go, "#go_LineI2")
		slot5.lineI2No = gohelper.findChild(slot5.go, "#go_LineI2/normal")
		slot5.lineI2HL = gohelper.findChild(slot5.go, "#go_LineI2/highlight")

		table.insert(slot0._treeLevelItemList, slot5)
	end
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshUI, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, slot0._refreshSelect, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.OnChangePartStart, slot0._onChangePartStart, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshUI, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshUI, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, slot0._refreshSelect, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.OnChangePartStart, slot0._onChangePartStart, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._lineMO = slot0._view.viewParam.lineMO
	slot0._callback = slot0._view.viewParam.callback
	slot0._callbackObj = slot0._view.viewParam.callbackObj
	slot0._mo = slot1

	slot0:_refreshUI()
	slot0:_refreshSelect()
	slot0:_checkAnimation()
	gohelper.setActive(slot0._gosynthesis, false)
end

function slot0._refreshSelect(slot0, slot1)
	if slot1 and slot0._mo:getId() == slot1 then
		slot0:_refreshCoinCount()
		slot0:_refreshMaterialItemCount()
	end

	if slot0._treeLevelItemList[slot0._mo:getFormulaTreeLevel()] then
		gohelper.setActive(slot0._treeLevelItemList[slot4].goSelect, RoomFormulaListModel.instance:getSelectFormulaStrId() == slot2)
	end
end

function slot0._refreshUI(slot0)
	slot1, slot2, slot3 = nil
	slot0._unlock, slot1, slot2, slot3 = RoomProductionHelper.isFormulaUnlock(slot0._mo:getFormulaId(), slot0._lineMO.level)

	if not slot0._unlock then
		slot0:_refreshLockText(slot1, slot2, slot3)
	end

	slot0._canvasGroup.alpha = slot0._unlock and 1 or 0.2

	gohelper.setActive(slot0._golock, not slot0._unlock)
	ZProj.UGUIHelper.SetColorAlpha(slot0._simageproduceitem.gameObject:GetComponent(gohelper.Type_Image), slot0._unlock and 1 or 0.5)
	UISpriteSetMgr.instance:setRoomSprite(slot0._imagecoinRare, "bg_wupindi_3")
	slot0._simagecoinIcon:LoadImage(ResUrl.getCurrencyItemIcon("203"))

	slot9 = #RoomProductionHelper.getCostMaterialItemList(slot4)

	for slot9 = 1, math.min(slot0._maxMaterialItemCount, slot9) do
		slot10 = slot5[slot9]
		slot11.costItem = slot0._materialItemList[slot9].costItem or IconMgr.instance:getRoomGoodsItem(slot11.gopos, ViewMgr.instance:getContainer(ViewName.RoomFormulaView))

		slot11.costItem:canShowRareCircle(false)
		slot11.costItem:setMOValue(slot10.type, slot10.id, slot10.quantity)
		slot11.costItem:isEnableClick(true)
		slot11.costItem:isShowCount(false)
		slot11.costItem:setRecordFarmItem(true)
		slot11.costItem:setConsume(true)
		slot11.costItem:setJumpFinishCallback(slot0.jumpFinishCallback, slot0)
		gohelper.setActive(slot11.goitem, true)
		gohelper.setActive(slot11.goempty, false)
	end

	for slot9 = math.min(slot0._maxMaterialItemCount, #slot5) + 1, #slot0._materialItemList do
		slot10 = slot0._materialItemList[slot9]

		gohelper.setActive(slot10.goempty, true)
		gohelper.setActive(slot10.goitem, false)
	end

	slot6 = false
	slot7 = RoomProductionHelper.getFormulaProduceItem(slot4)

	gohelper.setActive(slot0._simageproduceitem.gameObject, slot7)
	gohelper.setActive(slot0._txtname.gameObject, slot7)

	slot8 = 1

	if slot7 then
		slot9, slot10 = ItemModel.instance:getItemConfigAndIcon(slot7.type, slot7.id)

		slot0._simageproduceitem:LoadImage(slot10)

		slot8 = slot9.rare
		slot0._txtname.text = slot9.name

		if JumpModel.instance:getRecordFarmItem() and not slot0._mo:isTreeFormula() then
			slot6 = slot12.id == slot7.id
		end
	end

	gohelper.setActive(slot0._goNeedTag, slot6)
	UISpriteSetMgr.instance:setRoomSprite(slot0._imagerare, "huangyuan_pz_" .. CharacterEnum.Color[slot8])
	slot0:_refreshTreeLevel()
	slot0:_refreshCoinCount()
	slot0:_refreshMaterialItemCount()
end

function slot0._refreshLockText(slot0, slot1, slot2, slot3)
	if slot1 then
		table.insert({}, string.format(luaLang("room_formula_lock_roomlevel"), slot1))
	end

	if slot2 then
		table.insert(slot4, string.format(luaLang("room_formula_lock_productionlevel"), slot2))
	end

	if slot3 then
		slot7 = slot5
		slot8 = ""

		if DungeonConfig.instance:getEpisodeCO(slot3) and DungeonConfig.instance:getChapterCO(slot5.chapterId) and slot6.type == DungeonEnum.ChapterType.Hard then
			slot8 = luaLang("dungeon_lock_tips_hard2")
			slot7 = DungeonConfig.instance:getEpisodeCO(slot5.preEpisode)
		end

		table.insert(slot4, string.format(luaLang("room_formula_lock_episode"), "<color=#FF0000>" .. slot8 .. (slot7 and DungeonController.getEpisodeName(slot7) or "") .. "</color>"))
	end

	slot0._golockitem.text = #slot4 > 0 and slot4[1] or ""
end

function slot0._refreshTreeLevel(slot0)
	slot1, slot2, slot3 = slot0:getShowLineObj()

	if slot0._mo:getParentStrId() and slot1.hasData then
		slot5 = RoomFormulaListModel.instance:isSelectedFormula(slot4)

		gohelper.setActive(slot1.normal, not slot5)
		gohelper.setActive(slot1.highlight, slot5)
	end

	if slot2.hasData then
		slot5 = RoomFormulaListModel.instance:isSelectedFormula(slot2.grandParentStrId)

		gohelper.setActive(slot2.normal, not slot5)
		gohelper.setActive(slot2.highlight, slot5)
	end

	if slot3.hasData then
		slot5 = RoomFormulaListModel.instance:isSelectedFormula(slot3.greatGrandParentStrId)

		gohelper.setActive(slot3.normal, not slot5)
		gohelper.setActive(slot3.highlight, slot5)
	end
end

function slot0.getShowLineObj(slot0)
	slot2 = {
		hasData = false
	}
	slot3 = {
		hasData = false
	}
	slot5 = slot0._mo:getIsLast()
	slot6 = slot0._mo:getParentStrId()

	for slot10, slot11 in ipairs(slot0._treeLevelItemList) do
		slot12 = slot10 == slot0._mo:getFormulaTreeLevel()

		gohelper.setActive(slot11.go, slot12)

		if slot12 then
			if slot11.lineT then
				gohelper.setActive(slot11.lineT, not slot5)

				if not slot5 then
					-- Nothing
				end
			end

			if slot11.lineL then
				gohelper.setActive(slot11.lineL, slot5)

				if slot5 then
					slot1.normal = slot11.lineLNo
					slot1.highlight = slot11.lineLHL
					slot1.hasData = true
				end
			end

			if slot6 then
				if slot11.lineI1 then
					slot14 = RoomFormulaModel.instance:getFormulaIsLast(slot6)

					gohelper.setActive(slot11.lineI1, not slot14)

					if not slot14 then
						slot2.normal = slot11.lineI1No
						slot2.highlight = slot11.lineI1HL
						slot2.grandParentStrId = RoomFormulaModel.instance:getFormulaParentStrId(slot6)
						slot2.hasData = true
					end
				end

				if slot11.lineI2 then
					slot14 = RoomFormulaModel.instance:getFormulaIsLast(slot13)

					gohelper.setActive(slot11.lineI2, not slot14)

					if not slot14 then
						slot3.normal = slot11.lineI2No
						slot3.highlight = slot11.lineI2HL
						slot3.greatGrandParentStrId = RoomFormulaModel.instance:getFormulaParentStrId(slot13)
						slot3.hasData = true
					end
				end
			end
		end
	end

	return {
		hasData = false,
		normal = slot11.lineTNo,
		highlight = slot11.lineTHL,
		hasData = true
	}, slot2, slot3
end

function slot0._refreshCoinCount(slot0)
	slot0.costScore = 0
	slot2 = true

	if RoomProductionHelper.getCostCoinItemList(slot0._mo:getFormulaId())[1] then
		slot0.costScore = (slot4.quantity or 0) * slot0._mo:getFormulaCombineCount()
		slot2 = slot0.costScore <= ItemModel.instance:getItemQuantity(slot4.type, slot4.id)
	end

	if slot2 then
		slot0._txtgold.text = GameUtil.numberDisplay(slot0.costScore)
	else
		slot0._txtgold.text = string.format("<color=#d97373>%s</color>", slot0.costScore)
	end

	gohelper.setActive(slot0._goitem, slot0.costScore > 0)
	gohelper.setActive(slot0._goempty, slot0.costScore <= 0)
end

function slot0._refreshMaterialItemCount(slot0)
	slot7 = #RoomProductionHelper.getCostMaterialItemList(slot0._mo:getFormulaId())

	for slot7 = 1, math.min(slot0._maxMaterialItemCount, slot7) do
		slot9 = slot3[slot7]
		slot12 = slot9.quantity * slot0._mo:getFormulaCombineCount() <= ItemModel.instance:getItemQuantity(slot9.type, slot9.id)

		if slot0._materialItemList[slot7].costItem then
			slot8.costItem:setMOValue(slot9.type, slot9.id, slot10)
			slot8.costItem:setGrayscale(not slot12)
		end

		if slot12 then
			slot8.txtnum.text = string.format("%s/%s", RoomProductionHelper.formatItemNum(slot11), slot10)
		else
			slot8.txtnum.text = string.format("<color=#d97373>%s/%s</color>", slot13, slot10)
		end
	end

	slot4 = RoomProductionHelper.getFormulaProduceItem(slot1)

	gohelper.setActive(slot0._txtCombineNum.gameObject, slot4)

	if slot4 then
		slot0._txtCombineNum.text = luaLang("multiple") .. slot4.quantity * slot2
	end
end

function slot0._refreshOwnQuantityAndTag(slot0)
	slot2 = 0

	if RoomProductionHelper.getFormulaProduceItem(slot0._mo:getFormulaId()) then
		slot2 = ItemModel.instance:getItemQuantity(slot3.type, slot3.id)
	end

	if RoomProductionHelper.getFormulaNeedQuantity(slot0._mo:getId()) and slot5 ~= 0 then
		slot6 = ""

		if slot5 <= slot2 then
			slot6 = string.format("%s/%s", slot2, slot5)

			gohelper.setActive(slot0._goCanCombine, false)
			gohelper.setActive(slot0._goNeed, false)
		else
			slot6 = string.format("<color=#d97373>%s</color>/%s", slot2, slot5)

			if RoomProductionHelper.getTotalCanCombineNum(slot1) ~= 0 then
				slot0._txtCanCombine.text = formatLuaLang("room_formula_can_combine", slot8)
			end

			gohelper.setActive(slot0._goCanCombine, slot9)
			gohelper.setActive(slot0._goNeed, not slot9)
		end

		slot0._txtOwnNum.text = slot6
	else
		slot0._txtOwnNum.text = slot2

		gohelper.setActive(slot0._goCanCombine, false)
		gohelper.setActive(slot0._goNeed, false)
	end
end

function slot0._playAnimByName(slot0, slot1)
	slot0._lastAnimName = slot1

	slot0._animator:Play(slot1, 0, 0)
end

function slot0._onHideAnimAnimation(slot0, slot1)
	if slot0:_canTreeAnim(slot1) then
		slot0:_playAnimByName(RoomProductLineEnum.AnimName.TreeHide)
	end
end

function slot0._onShowAnimAnimation(slot0, slot1)
	slot0._showLevel = slot1
end

function slot0._onMoveAnimAnimation(slot0, slot1)
	slot0._checkMove = true
end

function slot0._checkAnimation(slot0)
	slot1 = slot0._showLevel
	slot0._showLevel = nil

	if slot0._checkMove then
		slot0._lineAnimator:Play(RoomProductLineEnum.AnimName.TreeHide, 0, 0)
	end

	if slot1 and slot0:_canTreeAnim(slot1) then
		slot0:_playAnimByName(RoomProductLineEnum.AnimName.TreeShow, 0, 0)

		slot0._checkMove = false
	end

	slot0:_checkMoveAnimation()

	if slot0._lastAnimName == RoomProductLineEnum.AnimName.TreeHide then
		slot0:_playAnimByName(RoomProductLineEnum.AnimName.TreeIdle, 0, 0)
	end
end

function slot0._checkMoveAnimation(slot0)
	if slot0._checkMove ~= true then
		slot0:_tweenKill(true)

		return
	end

	slot0._checkMove = false

	if RoomFormulaListModel.instance:getRankDiff(slot0._mo) and slot1 ~= 0 then
		slot0:_tweenKill()
		slot0:_playAnimByName(RoomProductLineEnum.AnimName.TreeIdle)

		slot2 = RoomFormulaViewContainer.cellHeightSize * slot1

		transformhelper.setLocalPosXY(slot0._gonormalTrs, 0, slot2)
		transformhelper.setLocalPosXY(slot0._golockTrs, 0, slot2)

		slot0._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(slot0._gonormalTrs, 0, RoomProductLineEnum.AnimTime.TreeAnim)
		slot0._golockMoveId = ZProj.TweenHelper.DOAnchorPosY(slot0._golockTrs, 0, RoomProductLineEnum.AnimTime.TreeAnim)
	else
		slot0:_tweenKill(true)
	end
end

function slot0._tweenKill(slot0, slot1)
	if slot0._rankDiffMoveId then
		ZProj.TweenHelper.KillById(slot0._rankDiffMoveId)
		ZProj.TweenHelper.KillById(slot0._golockMoveId)

		slot0._rankDiffMoveId = nil
		slot0._golockMoveId = nil

		if slot1 then
			transformhelper.setLocalPosXY(slot0._gonormalTrs, 0, 0)
			transformhelper.setLocalPosXY(slot0._golockTrs, 0, 0)
		end
	end
end

function slot0._canTreeAnim(slot0, slot1)
	if slot1 and slot0._mo:getFormulaTreeLevel() and slot1 < slot2 then
		return true
	end

	return false
end

function slot0.jumpFinishCallback(slot0)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshNeedFormula)
end

function slot0.onDestroyView(slot0)
	slot0._simageproduceitem:UnLoadImage()
	slot0._simagecoinIcon:UnLoadImage()
	slot0:_tweenKill()
end

return slot0
