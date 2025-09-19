module("modules.logic.character.view.destiny.CharacterDestinyStoneView", package.seeall)

local var_0_0 = class("CharacterDestinyStoneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "#go_drag")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_icon")
	arg_1_0._txtstonename = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_stonename")
	arg_1_0._gostone = gohelper.findChild(arg_1_0.viewGO, "root/#go_stone")
	arg_1_0._goprestone = gohelper.findChild(arg_1_0.viewGO, "root/#go_prestone")
	arg_1_0._btnprestone = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_prestone/#btn_prestone")
	arg_1_0._gonextstone = gohelper.findChild(arg_1_0.viewGO, "root/#go_nextstone")
	arg_1_0._btnnextstone = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_nextstone/#btn_nextstone")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "root/btn/#go_unlock")
	arg_1_0._gounlockitem = gohelper.findChild(arg_1_0.viewGO, "root/btn/#go_unlock/#go_unlockitem")
	arg_1_0._btnunlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#go_unlock/#btn_unlock")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "root/btn/#go_select")
	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#go_select/#btn_select")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.viewGO, "root/btn/#go_unselect")
	arg_1_0._btnunselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#go_unselect/#btn_unselect")
	arg_1_0._goexchange = gohelper.findChild(arg_1_0.viewGO, "root/btn/#go_exchange")
	arg_1_0._btnexchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#go_exchange/#btn_exchange")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "root/point/#go_point")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnprestone:AddClickListener(arg_2_0._btnprestoneOnClick, arg_2_0)
	arg_2_0._btnnextstone:AddClickListener(arg_2_0._btnnextstoneOnClick, arg_2_0)
	arg_2_0._btnunlock:AddClickListener(arg_2_0._btnunlockOnClick, arg_2_0)
	arg_2_0._btnselect:AddClickListener(arg_2_0._btnselectOnClick, arg_2_0)
	arg_2_0._btnunselect:AddClickListener(arg_2_0._btnunselectOnClick, arg_2_0)
	arg_2_0._btnexchange:AddClickListener(arg_2_0._btnexchangeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnprestone:RemoveClickListener()
	arg_3_0._btnnextstone:RemoveClickListener()
	arg_3_0._btnunlock:RemoveClickListener()
	arg_3_0._btnselect:RemoveClickListener()
	arg_3_0._btnunselect:RemoveClickListener()
	arg_3_0._btnexchange:RemoveClickListener()
end

function var_0_0._btnprestoneOnClick(arg_4_0)
	if arg_4_0._openUnlockStoneView then
		return
	end

	arg_4_0._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchRight, 0, 0)
	TaskDispatcher.runDelay(arg_4_0._cutPreStoneCB, arg_4_0, 0.16)
end

function var_0_0._btnnextstoneOnClick(arg_5_0)
	if arg_5_0._openUnlockStoneView then
		return
	end

	arg_5_0._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchLeft, 0, 0)
	TaskDispatcher.runDelay(arg_5_0._cutNextStoneCB, arg_5_0, 0.16)
end

function var_0_0._btnunselectOnClick(arg_6_0)
	CharacterDestinyController.instance:onUseStone(arg_6_0._heroMO.heroId, 0)
end

function var_0_0._btnunlockOnClick(arg_7_0)
	if not arg_7_0._curStoneMo then
		return
	end

	if arg_7_0._curStoneMo.conusmeCo then
		local var_7_0 = ItemModel.instance:getItemDataListByConfigStr(arg_7_0._curStoneMo.conusmeCo.consume)
		local var_7_1, var_7_2, var_7_3 = ItemModel.instance:hasEnoughItemsByCellData(var_7_0)

		if not var_7_2 then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_7_3, var_7_1)

			return
		end
	end

	local var_7_4 = arg_7_0._facetMos[arg_7_0._selectStoneIndex]

	if var_7_4 then
		arg_7_0:openUnlockStoneView(var_7_4.stoneId)
	end
end

function var_0_0._btnselectOnClick(arg_8_0)
	local var_8_0 = arg_8_0._facetMos[arg_8_0._selectStoneIndex]

	if var_8_0 then
		CharacterDestinyController.instance:onUseStone(arg_8_0._heroMO.heroId, var_8_0.stoneId)
	end
end

function var_0_0._btnexchangeOnClick(arg_9_0)
	local var_9_0 = arg_9_0._facetMos[arg_9_0._selectStoneIndex]

	if var_9_0 then
		CharacterDestinyController.instance:onUseStone(arg_9_0._heroMO.heroId, var_9_0.stoneId)
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._simagestone = gohelper.findChildSingleImage(arg_10_0.viewGO, "root/#go_stone/#simage_stone")
	arg_10_0._simagepre = gohelper.findChildSingleImage(arg_10_0.viewGO, "root/#go_prestone/#btn_prestone")
	arg_10_0._simagenext = gohelper.findChildSingleImage(arg_10_0.viewGO, "root/#go_nextstone/#btn_nextstone")
	arg_10_0._gounlockstone = gohelper.findChild(arg_10_0.viewGO, "unlockstone")
	arg_10_0._root = gohelper.findChild(arg_10_0.viewGO, "root")
	arg_10_0._goeffect = gohelper.findChild(arg_10_0.viewGO, "root/effectItem")
	arg_10_0._imgstone = gohelper.findChildImage(arg_10_0.viewGO, "root/#go_stone/#simage_stone")
	arg_10_0._goEquip = gohelper.findChild(arg_10_0.viewGO, "root/#go_stone/#equip")
	arg_10_0._animRoot = arg_10_0._root:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0._animPlayerRoot = ZProj.ProjAnimatorPlayer.Get(arg_10_0._root)
	arg_10_0._animPlayerUnlockStone = ZProj.ProjAnimatorPlayer.Get(arg_10_0._gounlockstone)
	arg_10_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_10_0._godrag.gameObject)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0._addEvents(arg_12_0)
	arg_12_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, arg_12_0._onUnlockStoneReply, arg_12_0)
	arg_12_0:addEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, arg_12_0._onUseStoneReply, arg_12_0)
	arg_12_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_12_0._refreshConsume, arg_12_0)
	arg_12_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_12_0._refreshConsume, arg_12_0)

	if arg_12_0._drag then
		arg_12_0._drag:AddDragBeginListener(arg_12_0._dragBeginEventCb, arg_12_0)
		arg_12_0._drag:AddDragListener(arg_12_0._dragEventCb, arg_12_0)
		arg_12_0._drag:AddDragEndListener(arg_12_0._dragEndEventCb, arg_12_0)
	end
end

function var_0_0._removeEvents(arg_13_0)
	arg_13_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, arg_13_0._onUnlockStoneReply, arg_13_0)
	arg_13_0:removeEventCb(CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, arg_13_0._onUseStoneReply, arg_13_0)
	arg_13_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_13_0._refreshConsume, arg_13_0)
	arg_13_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_13_0._refreshConsume, arg_13_0)

	if arg_13_0._drag then
		arg_13_0._drag:RemoveDragBeginListener()
		arg_13_0._drag:RemoveDragListener()
		arg_13_0._drag:RemoveDragEndListener()
	end
end

function var_0_0._refreshView(arg_14_0)
	arg_14_0:_refreshStoneItem(arg_14_0._selectStoneIndex)
	arg_14_0:_refreshBtn()
end

function var_0_0._onUnlockStoneReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._curStoneMo then
		arg_15_0._curStoneMo:refresUnlock(true)
	end

	arg_15_0:_refreshView()
	gohelper.setActive(arg_15_0._root, true)
	gohelper.setActive(arg_15_0._gounlockstone, false)

	arg_15_0._openUnlockStoneView = false
end

function var_0_0._onUseStoneReply(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._heroMO.destinyStoneMo:refreshUseStone()

	arg_16_0._curUseStoneId = arg_16_0._heroMO.destinyStoneMo.curUseStoneId

	arg_16_0:_refreshBtn()
	gohelper.setActive(arg_16_0._goEquip, arg_16_0._curStoneMo.isUse)
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:_addEvents()

	arg_17_0._effectItems = arg_17_0:getUserDataTb_()

	for iter_17_0 = 1, CharacterDestinyEnum.EffectItemCount do
		local var_17_0 = gohelper.findChild(arg_17_0._goeffect, iter_17_0)
		local var_17_1 = arg_17_0:getUserDataTb_()

		var_17_1.go = var_17_0
		var_17_1.lockicon = gohelper.findChildImage(var_17_0, "#txt_dec/#go_lockicon")
		var_17_1.unlockicon = gohelper.findChildImage(var_17_0, "#txt_dec/#go_unlockicon")
		var_17_1.txt = gohelper.findChildText(var_17_0, "#txt_dec")
		var_17_1.gounlock = gohelper.findChild(var_17_0, "#unlock")
		var_17_1.canvasgroup = var_17_0:GetComponent(typeof(UnityEngine.CanvasGroup))
		arg_17_0._effectItems[iter_17_0] = var_17_1
	end

	arg_17_0._heroMO = arg_17_0.viewParam.heroMo
	arg_17_0._curUseStoneId = arg_17_0._heroMO.destinyStoneMo.curUseStoneId

	local var_17_2 = arg_17_0._heroMO.destinyStoneMo.stoneMoList

	arg_17_0._facetMos = {}

	if var_17_2 then
		local var_17_3 = 1

		for iter_17_1, iter_17_2 in pairs(var_17_2) do
			table.insert(arg_17_0._facetMos, iter_17_2)
		end

		table.sort(arg_17_0._facetMos, arg_17_0._sortStone)

		if arg_17_0._curUseStoneId and arg_17_0._curUseStoneId ~= 0 then
			for iter_17_3, iter_17_4 in ipairs(arg_17_0._facetMos) do
				if iter_17_4.stoneId == arg_17_0._curUseStoneId then
					var_17_3 = iter_17_3
				end
			end
		end

		arg_17_0:_refreshStoneItem(var_17_3)
		arg_17_0:_refreshBtn()
	end

	gohelper.setActive(arg_17_0._root, true)
	gohelper.setActive(arg_17_0._gounlockstone, false)

	arg_17_0._openUnlockStoneView = false
end

function var_0_0._sortStone(arg_18_0, arg_18_1)
	local var_18_0 = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(arg_18_0.stoneId)
	local var_18_1 = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(arg_18_1.stoneId)

	if var_18_0.facetsSort ~= var_18_1.facetsSort then
		return var_18_0.facetsSort < var_18_1.facetsSort
	end

	return arg_18_0.stoneId > arg_18_1.stoneId
end

function var_0_0._refreshStoneItem(arg_19_0, arg_19_1)
	if not arg_19_1 or arg_19_1 == 0 then
		arg_19_1 = 1
	end

	arg_19_0._selectStoneIndex = arg_19_1

	local var_19_0 = #arg_19_0._facetMos

	arg_19_0._curStoneMo = arg_19_0._facetMos[arg_19_1]

	if arg_19_0._curStoneMo then
		arg_19_0._levelCos = arg_19_0._curStoneMo:getFacetCo()

		local var_19_1 = arg_19_0._curStoneMo.conusmeCo

		if arg_19_0._levelCos then
			for iter_19_0, iter_19_1 in ipairs(arg_19_0._effectItems) do
				local var_19_2 = arg_19_0._levelCos[iter_19_0]

				iter_19_1.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(iter_19_1.txt.gameObject, SkillDescComp)

				iter_19_1.skillDesc:updateInfo(iter_19_1.txt, var_19_2.desc, arg_19_0._heroMO.heroId)
				iter_19_1.skillDesc:setTipParam(0, Vector2(300, 100))

				local var_19_3 = arg_19_0._curStoneMo.isUnlock and iter_19_0 <= arg_19_0._heroMO.destinyStoneMo.rank
				local var_19_4 = iter_19_1.txt.color

				var_19_4.a = var_19_3 and 1 or 0.43
				iter_19_1.txt.color = var_19_4

				if var_19_3 then
					local var_19_5 = iter_19_1.unlockicon.color

					var_19_5.a = var_19_3 and 1 or 0.43
					iter_19_1.unlockicon.color = var_19_5
				else
					local var_19_6 = iter_19_1.lockicon.color

					var_19_6.a = var_19_3 and 1 or 0.43
					iter_19_1.lockicon.color = var_19_6
				end

				gohelper.setActive(iter_19_1.lockicon.gameObject, not var_19_3)
				gohelper.setActive(iter_19_1.unlockicon.gameObject, var_19_3)
			end
		end

		gohelper.setActive(arg_19_0._goEquip, arg_19_0._curStoneMo.isUse)

		if var_19_1 then
			local var_19_7, var_19_8 = arg_19_0._curStoneMo:getNameAndIcon()

			arg_19_0._txtstonename.text = var_19_7

			arg_19_0._simagestone:LoadImage(var_19_8)

			local var_19_9 = CharacterDestinyEnum.SlotTend[var_19_1.tend]
			local var_19_10 = var_19_9.TitleIconName

			UISpriteSetMgr.instance:setUiCharacterSprite(arg_19_0._imageicon, var_19_10)

			arg_19_0._txtstonename.color = GameUtil.parseColor(var_19_9.TitleColor)
		end

		local var_19_11 = arg_19_0._curStoneMo.isUnlock and Color.white or Color(0.5, 0.5, 0.5, 1)

		arg_19_0._imgstone.color = var_19_11

		arg_19_0:_checkPlayAttrUnlockAnim(arg_19_0._curStoneMo.stoneId)
	end

	if not arg_19_0._pointItems then
		arg_19_0._pointItems = arg_19_0:getUserDataTb_()
	end

	if var_19_0 > 1 then
		for iter_19_2 = 1, var_19_0 do
			local var_19_12 = arg_19_0:_getPointItem(iter_19_2)

			gohelper.setActive(var_19_12.select, arg_19_1 == iter_19_2)
			gohelper.setActive(var_19_12.go, true)
		end
	else
		for iter_19_3, iter_19_4 in ipairs(arg_19_0._pointItems) do
			gohelper.setActive(iter_19_4.go, false)
		end
	end

	arg_19_0:_refreshConsume()
	arg_19_0:_refreshPreAndNextStoneItem(arg_19_1)
end

function var_0_0._refreshConsume(arg_20_0)
	if not arg_20_0._curStoneMo then
		return
	end

	local var_20_0 = arg_20_0._curStoneMo.conusmeCo

	if not arg_20_0._curStoneMo.isUnlock then
		local var_20_1 = ItemModel.instance:getItemDataListByConfigStr(var_20_0.consume)

		IconMgr.instance:getCommonPropItemIconList(arg_20_0, arg_20_0._onCostItemShow, var_20_1, arg_20_0._gounlockitem)
	end
end

function var_0_0._checkPlayAttrUnlockAnim(arg_21_0, arg_21_1)
	if arg_21_0._effectItems then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._effectItems) do
			local var_21_0 = arg_21_0._heroMO.destinyStoneMo:isCanPlayAttrUnlockAnim(arg_21_1, iter_21_0)

			gohelper.setActive(iter_21_1.gounlock, var_21_0)
		end
	end
end

function var_0_0._refreshPreAndNextStoneItem(arg_22_0, arg_22_1)
	if arg_22_1 > 1 then
		local var_22_0 = arg_22_0._facetMos[arg_22_1 - 1]

		if var_22_0 and var_22_0.conusmeCo then
			local var_22_1, var_22_2 = var_22_0:getNameAndIcon()

			arg_22_0._simagepre:LoadImage(var_22_2)
		end
	end

	if arg_22_1 < #arg_22_0._facetMos then
		local var_22_3 = arg_22_0._facetMos[arg_22_1 + 1]

		if var_22_3 and var_22_3.conusmeCo then
			local var_22_4, var_22_5 = var_22_3:getNameAndIcon()

			arg_22_0._simagenext:LoadImage(var_22_5)
		end
	end

	gohelper.setActive(arg_22_0._goprestone, arg_22_1 > 1)
	gohelper.setActive(arg_22_0._gonextstone, arg_22_1 < #arg_22_0._facetMos)
end

function var_0_0._onCostItemShow(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	transformhelper.setLocalScale(arg_23_1.viewGO.transform, 0.6, 0.6, 1)
	arg_23_1:onUpdateMO(arg_23_2)
	arg_23_1:setConsume(true)
	arg_23_1:showStackableNum2()
	arg_23_1:isShowEffect(true)
	arg_23_1:setAutoPlay(true)
	arg_23_1:setCountFontSize(48)

	local var_23_0 = arg_23_1:getItemIcon():getCount()
	local var_23_1 = 170
	local var_23_2 = var_23_0.gameObject:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))

	var_23_0.enableAutoSizing = true
	var_23_2.enabled = false
	var_23_0.fontSizeMax = 48
	var_23_0.fontSizeMin = 30
	var_23_0.transform.anchorMax = Vector2(0.5, 0.5)
	var_23_0.transform.anchorMin = Vector2(0.5, 0.5)
	var_23_0.transform.pivot = Vector2(0.5, 0.5)
	var_23_0.alignment = TMPro.TextAlignmentOptions.Center

	recthelper.setWidth(var_23_0.transform, var_23_1)
	recthelper.setHeight(var_23_0.transform, 70)
	arg_23_1:SetCountLocalY(-50)
	arg_23_1:setCountText(ItemModel.instance:getItemIsEnoughText(arg_23_2))
	arg_23_1:setOnBeforeClickCallback(arg_23_0.onBeforeClickItem, arg_23_0)
end

function var_0_0.onBeforeClickItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = JumpController.instance:getCurrentOpenedView(arg_24_0.viewName)

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1.viewName == ViewName.CharacterDestinySlotView then
			iter_24_1.viewParam.isBack = true

			break
		end
	end

	arg_24_2:setRecordFarmItem({
		type = arg_24_2._itemType,
		id = arg_24_2._itemId,
		quantity = arg_24_2._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = var_24_0
	})
end

function var_0_0._refreshBtn(arg_25_0)
	if not arg_25_0._curStoneMo then
		return
	end

	local var_25_0 = arg_25_0._heroMO.destinyStoneMo:isUnlockSlot()
	local var_25_1 = arg_25_0._curStoneMo.isUnlock
	local var_25_2 = arg_25_0._curStoneMo.isUse
	local var_25_3 = arg_25_0._curUseStoneId ~= 0

	gohelper.setActive(arg_25_0._gounlock.gameObject, var_25_0 and not var_25_1)
	gohelper.setActive(arg_25_0._goselect.gameObject, var_25_0 and var_25_1 and not var_25_2 and not var_25_3)
	gohelper.setActive(arg_25_0._gounselect.gameObject, var_25_0 and var_25_1 and var_25_2)
	gohelper.setActive(arg_25_0._goexchange.gameObject, var_25_0 and var_25_1 and not var_25_2 and var_25_3)
end

function var_0_0._getPointItem(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._pointItems[arg_26_1]

	if not var_26_0 then
		var_26_0 = arg_26_0:getUserDataTb_()

		local var_26_1 = gohelper.cloneInPlace(arg_26_0._gopoint, arg_26_1)

		var_26_0.go = var_26_1
		var_26_0.normal = gohelper.findChild(var_26_1, "normal")
		var_26_0.select = gohelper.findChild(var_26_1, "select")
		arg_26_0._pointItems[arg_26_1] = var_26_0
	end

	return var_26_0
end

function var_0_0.openUnlockStoneView(arg_27_0, arg_27_1)
	if not arg_27_0._unlockStoneView then
		arg_27_0._unlockStoneView = MonoHelper.addNoUpdateLuaComOnceToGo(arg_27_0._gounlockstone, CharacterDestinyUnlockStoneComp)

		arg_27_0._unlockStoneView:setStoneView(arg_27_0)
	end

	arg_27_0._unlockStoneView:onUpdateMo(arg_27_0._heroMO.heroId, arg_27_1)
	gohelper.setActive(arg_27_0._gounlockstone, true)
	arg_27_0:playRootOpenCloseAnim(false, arg_27_0._hideRoot, arg_27_0)
	arg_27_0:playUnlockstoneOpenCloseAnim(true, nil, arg_27_0)
	arg_27_0.viewContainer:setOpenUnlockStoneView(true)

	arg_27_0._openUnlockStoneView = true
end

function var_0_0.closeUnlockStoneView(arg_28_0)
	gohelper.setActive(arg_28_0._root, true)
	arg_28_0:playRootOpenCloseAnim(true, nil, arg_28_0)
	arg_28_0:playUnlockstoneOpenCloseAnim(false, arg_28_0._hideUnlockstone, arg_28_0)
	arg_28_0.viewContainer:setOpenUnlockStoneView(false)

	arg_28_0._openUnlockStoneView = false
end

function var_0_0._cutPreStoneCB(arg_29_0)
	arg_29_0:_refreshStoneItem(arg_29_0._selectStoneIndex - 1)
	arg_29_0:_refreshBtn()
end

function var_0_0._cutNextStoneCB(arg_30_0)
	arg_30_0:_refreshStoneItem(arg_30_0._selectStoneIndex + 1)
	arg_30_0:_refreshBtn()
end

function var_0_0._dragBeginEventCb(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0._dragPos = arg_31_2.position
end

function var_0_0._dragEventCb(arg_32_0, arg_32_1, arg_32_2)
	return
end

function var_0_0._dragEndEventCb(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0._openUnlockStoneView then
		return
	end

	if #arg_33_0._facetMos < 2 then
		arg_33_0._dragPos = nil

		return
	end

	if arg_33_0._dragPos then
		TaskDispatcher.cancelTask(arg_33_0._cutPreStoneCB, arg_33_0)
		TaskDispatcher.cancelTask(arg_33_0._cutNextStoneCB, arg_33_0)

		if arg_33_0._dragPos.x < arg_33_2.position.x and arg_33_0._selectStoneIndex > 1 then
			arg_33_0._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchRight, 0, 0)
			TaskDispatcher.runDelay(arg_33_0._cutPreStoneCB, arg_33_0, 0.16)
		elseif arg_33_0._dragPos.x > arg_33_2.position.x and arg_33_0._selectStoneIndex < #arg_33_0._facetMos then
			arg_33_0._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchLeft, 0, 0)
			TaskDispatcher.runDelay(arg_33_0._cutNextStoneCB, arg_33_0, 0.16)
		end
	end
end

function var_0_0.onUnlockStone(arg_34_0)
	arg_34_0.viewContainer:setOpenUnlockStoneView(false)
	arg_34_0:_refreshBtn()
end

function var_0_0.playRootOpenCloseAnim(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_1 and CharacterDestinyEnum.StoneViewAnim.Open or CharacterDestinyEnum.StoneViewAnim.Close

	arg_35_0:playRootAnim(var_35_0, arg_35_2, arg_35_3)
end

function var_0_0.playUnlockstoneOpenCloseAnim(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = arg_36_1 and CharacterDestinyEnum.StoneViewAnim.Open or CharacterDestinyEnum.StoneViewAnim.Close

	arg_36_0:playUnlockstoneAnim(var_36_0, arg_36_2, arg_36_3)
end

function var_0_0.playRootAnim(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	arg_37_0._animPlayerRoot:Play(arg_37_1, arg_37_2, arg_37_3)
end

function var_0_0.playUnlockstoneAnim(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	arg_38_0._animPlayerUnlockStone:Play(arg_38_1, arg_38_2, arg_38_3)
end

function var_0_0._hideRoot(arg_39_0)
	gohelper.setActive(arg_39_0._root, false)
end

function var_0_0._hideUnlockstone(arg_40_0)
	gohelper.setActive(arg_40_0._gounlockstone, false)

	arg_40_0._openUnlockStoneView = false
end

function var_0_0.onClose(arg_41_0)
	return
end

function var_0_0.onDestroyView(arg_42_0)
	arg_42_0:_removeEvents()
	arg_42_0._simagestone:UnLoadImage()
	arg_42_0._simagepre:UnLoadImage()
	arg_42_0._simagenext:UnLoadImage()
	TaskDispatcher.cancelTask(arg_42_0._cutPreStoneCB, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._cutNextStoneCB, arg_42_0)
end

return var_0_0
