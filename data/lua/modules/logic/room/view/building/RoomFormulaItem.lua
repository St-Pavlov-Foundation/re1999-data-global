module("modules.logic.room.view.building.RoomFormulaItem", package.seeall)

local var_0_0 = class("RoomFormulaItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/layout/#txt_name")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_normal/materials/#go_coinitem/#go_item")
	arg_1_0._imagecoinRare = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/materials/#go_coinitem/#go_item/image_coinRare")
	arg_1_0._simagecoinIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/materials/#go_coinitem/#go_item/simage_coinIcon")
	arg_1_0._txtgold = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/materials/#go_coinitem/#txt_gold")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_normal/materials/#go_coinitem/#go_empty")
	arg_1_0._txtCombineNum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/layout/itemNum/#txt_num")
	arg_1_0._simageproduceitem = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_produceitem")
	arg_1_0._gomaterialitem = gohelper.findChild(arg_1_0.viewGO, "#go_normal/materials/#go_materialitem")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._golockitem = gohelper.findChildText(arg_1_0.viewGO, "#go_lock/locklayout/#go_lockitem")
	arg_1_0._txtlock = gohelper.findChildText(arg_1_0.viewGO, "#go_lock/#txt_lock")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/raremask/#image_rare")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_click")
	arg_1_0._btncoin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/materials/#go_coinitem/#go_item/#btn_coin")
	arg_1_0._btnlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_lock/#btn_lock")
	arg_1_0._goNeedTag = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_TagNeed")
	arg_1_0._goOwnNum = gohelper.findChild(arg_1_0.viewGO, "#go_normal/itemNum")
	arg_1_0._txtOwnNum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/itemNum/#txt_num")
	arg_1_0._goNeed = gohelper.findChild(arg_1_0.viewGO, "#go_normal/layout/#go_Need")
	arg_1_0._goCanCombine = gohelper.findChild(arg_1_0.viewGO, "#go_normal/layout/#go_Mix")
	arg_1_0._txtCanCombine = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/layout/#go_Mix/#txt_Mix")
	arg_1_0._gonormalTrs = arg_1_0._gonormal.transform
	arg_1_0._golockTrs = arg_1_0._golock.transform

	gohelper.setActive(arg_1_0._goNeed, false)
	gohelper.setActive(arg_1_0._goOwnNum, false)
	gohelper.setActive(arg_1_0._goCanCombine, false)

	arg_1_0._animator = arg_1_0.viewGO:GetComponent(RoomEnum.ComponentType.Animator)
	arg_1_0._lineAnimator = arg_1_0._gonormal:GetComponent(RoomEnum.ComponentType.Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btncoin:AddClickListener(arg_2_0._btncoinOnClick, arg_2_0)
	arg_2_0._btnlock:AddClickListener(arg_2_0._btnlockOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.RefreshFormulaCombineCount, arg_2_0._onFormulaCombineCountRefresh, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelHideAnim, arg_2_0._onHideAnimAnimation, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelShowAnim, arg_2_0._onShowAnimAnimation, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelMoveAnim, arg_2_0._onMoveAnimAnimation, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.RefreshNeedFormulaItem, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btncoin:RemoveClickListener()
	arg_3_0._btnlock:RemoveClickListener()
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.RefreshFormulaCombineCount, arg_3_0._onFormulaCombineCountRefresh, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelHideAnim, arg_3_0._onHideAnimAnimation, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelShowAnim, arg_3_0._onShowAnimAnimation, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.UIFormulaIdTreeLevelMoveAnim, arg_3_0._onMoveAnimAnimation, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.RefreshNeedFormulaItem, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._unlock then
		local var_4_0 = arg_4_0._mo:getId()
		local var_4_1 = arg_4_0._mo:getFormulaTreeLevel()

		RoomBuildingFormulaController.instance:setSelectFormulaStrId(var_4_0, nil, var_4_1)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_transverse_tabs_click)
	else
		arg_4_0:_btnlockOnClick()
	end
end

function var_0_0._btncoinOnClick(arg_5_0)
	if not arg_5_0._unlock then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Gold, false, nil, false, {
		type = MaterialEnum.MaterialType.Currency,
		id = CurrencyEnum.CurrencyType.Gold,
		quantity = arg_5_0.costScore,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function var_0_0._btnlockOnClick(arg_6_0)
	local var_6_0 = arg_6_0._mo:getFormulaId()
	local var_6_1, var_6_2, var_6_3, var_6_4 = RoomProductionHelper.isFormulaUnlock(var_6_0, arg_6_0._lineMO.level)

	if var_6_2 then
		GameFacade.showToast(ToastEnum.ClickRoomFormulaEpisode, var_6_2)
	elseif var_6_3 then
		GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, arg_6_0._lineMO.config.name, var_6_3)
	elseif var_6_4 then
		GameFacade.showToast(ToastEnum.ClickRoomFormula)
	end
end

function var_0_0._onFormulaCombineCountRefresh(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._mo:getId() then
		arg_7_0:_refreshCoinCount()
		arg_7_0:_refreshMaterialItemCount()
	end
end

function var_0_0._onChangePartStart(arg_8_0, arg_8_1)
	if arg_8_1 == arg_8_0._mo:getId() then
		gohelper.setActive(arg_8_0._gosynthesis, false)
		gohelper.setActive(arg_8_0._gosynthesis, true)
	end
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._materialItemList = {}

	gohelper.setActive(arg_9_0._gomaterialitem, false)

	arg_9_0._maxMaterialItemCount = 3

	for iter_9_0 = 1, arg_9_0._maxMaterialItemCount do
		local var_9_0 = arg_9_0:getUserDataTb_()

		var_9_0.go = gohelper.cloneInPlace(arg_9_0._gomaterialitem, "item" .. iter_9_0)
		var_9_0.goitem = gohelper.findChild(var_9_0.go, "go_item")
		var_9_0.gopos = gohelper.findChild(var_9_0.go, "go_item/go_pos")
		var_9_0.txtnum = gohelper.findChildText(var_9_0.go, "go_item/txt_num")
		var_9_0.goempty = gohelper.findChild(var_9_0.go, "go_empty")

		table.insert(arg_9_0._materialItemList, var_9_0)
		gohelper.setActive(var_9_0.go, true)
	end

	arg_9_0._canvasGroup = arg_9_0._gonormal:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.removeUIClickAudio(arg_9_0._btnclick.gameObject)

	arg_9_0._gosynthesis = gohelper.findChild(arg_9_0.viewGO, "#go_normal/#synthesis")
	arg_9_0._treeLevelItemList = {}

	for iter_9_1 = 1, RoomFormulaModel.MAX_FORMULA_TREE_LEVEL do
		local var_9_1 = arg_9_0:getUserDataTb_()

		var_9_1.go = gohelper.findChild(arg_9_0.viewGO, "#go_normal/#go_BG" .. iter_9_1)
		var_9_1.goSelect = gohelper.findChild(var_9_1.go, "#go_Select")
		var_9_1.lineT = gohelper.findChild(var_9_1.go, "#go_LineT")
		var_9_1.lineTNo = gohelper.findChild(var_9_1.go, "#go_LineT/normal")
		var_9_1.lineTHL = gohelper.findChild(var_9_1.go, "#go_LineT/highlight")
		var_9_1.lineL = gohelper.findChild(var_9_1.go, "#go_LineL")
		var_9_1.lineLNo = gohelper.findChild(var_9_1.go, "#go_LineL/normal")
		var_9_1.lineLHL = gohelper.findChild(var_9_1.go, "#go_LineL/highlight")
		var_9_1.lineI1 = gohelper.findChild(var_9_1.go, "#go_LineI1")
		var_9_1.lineI1No = gohelper.findChild(var_9_1.go, "#go_LineI1/normal")
		var_9_1.lineI1HL = gohelper.findChild(var_9_1.go, "#go_LineI1/highlight")
		var_9_1.lineI2 = gohelper.findChild(var_9_1.go, "#go_LineI2")
		var_9_1.lineI2No = gohelper.findChild(var_9_1.go, "#go_LineI2/normal")
		var_9_1.lineI2HL = gohelper.findChild(var_9_1.go, "#go_LineI2/highlight")

		table.insert(arg_9_0._treeLevelItemList, var_9_1)
	end
end

function var_0_0._editableAddEvents(arg_10_0)
	arg_10_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_10_0._refreshUI, arg_10_0)
	arg_10_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_10_0._refreshUI, arg_10_0)
	arg_10_0:addEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, arg_10_0._refreshSelect, arg_10_0)
	arg_10_0:addEventCb(RoomMapController.instance, RoomEvent.OnChangePartStart, arg_10_0._onChangePartStart, arg_10_0)
end

function var_0_0._editableRemoveEvents(arg_11_0)
	arg_11_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_11_0._refreshUI, arg_11_0)
	arg_11_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_11_0._refreshUI, arg_11_0)
	arg_11_0:removeEventCb(RoomMapController.instance, RoomEvent.SelectFormulaIdChanged, arg_11_0._refreshSelect, arg_11_0)
	arg_11_0:removeEventCb(RoomMapController.instance, RoomEvent.OnChangePartStart, arg_11_0._onChangePartStart, arg_11_0)
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	arg_12_0._lineMO = arg_12_0._view.viewParam.lineMO
	arg_12_0._callback = arg_12_0._view.viewParam.callback
	arg_12_0._callbackObj = arg_12_0._view.viewParam.callbackObj
	arg_12_0._mo = arg_12_1

	arg_12_0:_refreshUI()
	arg_12_0:_refreshSelect()
	arg_12_0:_checkAnimation()
	gohelper.setActive(arg_12_0._gosynthesis, false)
end

function var_0_0._refreshSelect(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._mo:getId()

	if arg_13_1 and var_13_0 == arg_13_1 then
		arg_13_0:_refreshCoinCount()
		arg_13_0:_refreshMaterialItemCount()
	end

	local var_13_1 = RoomFormulaListModel.instance:getSelectFormulaStrId()
	local var_13_2 = arg_13_0._mo:getFormulaTreeLevel()

	if arg_13_0._treeLevelItemList[var_13_2] then
		gohelper.setActive(arg_13_0._treeLevelItemList[var_13_2].goSelect, var_13_1 == var_13_0)
	end
end

function var_0_0._refreshUI(arg_14_0)
	local var_14_0
	local var_14_1
	local var_14_2
	local var_14_3 = arg_14_0._mo:getFormulaId()
	local var_14_4, var_14_5, var_14_6

	arg_14_0._unlock, var_14_4, var_14_5, var_14_6 = RoomProductionHelper.isFormulaUnlock(var_14_3, arg_14_0._lineMO.level)

	if not arg_14_0._unlock then
		arg_14_0:_refreshLockText(var_14_4, var_14_5, var_14_6)
	end

	arg_14_0._canvasGroup.alpha = arg_14_0._unlock and 1 or 0.2

	gohelper.setActive(arg_14_0._golock, not arg_14_0._unlock)
	ZProj.UGUIHelper.SetColorAlpha(arg_14_0._simageproduceitem.gameObject:GetComponent(gohelper.Type_Image), arg_14_0._unlock and 1 or 0.5)
	UISpriteSetMgr.instance:setRoomSprite(arg_14_0._imagecoinRare, "bg_wupindi_3")
	arg_14_0._simagecoinIcon:LoadImage(ResUrl.getCurrencyItemIcon("203"))

	local var_14_7 = RoomProductionHelper.getCostMaterialItemList(var_14_3)

	for iter_14_0 = 1, math.min(arg_14_0._maxMaterialItemCount, #var_14_7) do
		local var_14_8 = var_14_7[iter_14_0]
		local var_14_9 = arg_14_0._materialItemList[iter_14_0]

		var_14_9.costItem = var_14_9.costItem or IconMgr.instance:getRoomGoodsItem(var_14_9.gopos, ViewMgr.instance:getContainer(ViewName.RoomFormulaView))

		var_14_9.costItem:canShowRareCircle(false)
		var_14_9.costItem:setMOValue(var_14_8.type, var_14_8.id, var_14_8.quantity)
		var_14_9.costItem:isEnableClick(true)
		var_14_9.costItem:isShowCount(false)
		var_14_9.costItem:setRecordFarmItem(true)
		var_14_9.costItem:setConsume(true)
		var_14_9.costItem:setJumpFinishCallback(arg_14_0.jumpFinishCallback, arg_14_0)
		gohelper.setActive(var_14_9.goitem, true)
		gohelper.setActive(var_14_9.goempty, false)
	end

	for iter_14_1 = math.min(arg_14_0._maxMaterialItemCount, #var_14_7) + 1, #arg_14_0._materialItemList do
		local var_14_10 = arg_14_0._materialItemList[iter_14_1]

		gohelper.setActive(var_14_10.goempty, true)
		gohelper.setActive(var_14_10.goitem, false)
	end

	local var_14_11 = false
	local var_14_12 = RoomProductionHelper.getFormulaProduceItem(var_14_3)

	gohelper.setActive(arg_14_0._simageproduceitem.gameObject, var_14_12)
	gohelper.setActive(arg_14_0._txtname.gameObject, var_14_12)

	local var_14_13 = 1

	if var_14_12 then
		local var_14_14, var_14_15 = ItemModel.instance:getItemConfigAndIcon(var_14_12.type, var_14_12.id)

		arg_14_0._simageproduceitem:LoadImage(var_14_15)

		var_14_13 = var_14_14.rare
		arg_14_0._txtname.text = var_14_14.name

		local var_14_16 = arg_14_0._mo:isTreeFormula()
		local var_14_17 = JumpModel.instance:getRecordFarmItem()

		if var_14_17 and not var_14_16 then
			var_14_11 = var_14_17.id == var_14_12.id
		end
	end

	gohelper.setActive(arg_14_0._goNeedTag, var_14_11)
	UISpriteSetMgr.instance:setRoomSprite(arg_14_0._imagerare, "huangyuan_pz_" .. CharacterEnum.Color[var_14_13])
	arg_14_0:_refreshTreeLevel()
	arg_14_0:_refreshCoinCount()
	arg_14_0:_refreshMaterialItemCount()
end

function var_0_0._refreshLockText(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = {}

	if arg_15_1 then
		table.insert(var_15_0, string.format(luaLang("room_formula_lock_roomlevel"), arg_15_1))
	end

	if arg_15_2 then
		table.insert(var_15_0, string.format(luaLang("room_formula_lock_productionlevel"), arg_15_2))
	end

	if arg_15_3 then
		local var_15_1 = DungeonConfig.instance:getEpisodeCO(arg_15_3)
		local var_15_2 = var_15_1 and DungeonConfig.instance:getChapterCO(var_15_1.chapterId)
		local var_15_3 = var_15_1
		local var_15_4 = ""

		if var_15_2 and var_15_2.type == DungeonEnum.ChapterType.Hard then
			var_15_4 = luaLang("dungeon_lock_tips_hard2")
			var_15_3 = DungeonConfig.instance:getEpisodeCO(var_15_1.preEpisode)
		end

		table.insert(var_15_0, string.format(luaLang("room_formula_lock_episode"), "<color=#FF0000>" .. var_15_4 .. (var_15_3 and DungeonController.getEpisodeName(var_15_3) or "") .. "</color>"))
	end

	arg_15_0._golockitem.text = #var_15_0 > 0 and var_15_0[1] or ""
end

function var_0_0._refreshTreeLevel(arg_16_0)
	local var_16_0, var_16_1, var_16_2 = arg_16_0:getShowLineObj()
	local var_16_3 = arg_16_0._mo:getParentStrId()

	if var_16_3 and var_16_0.hasData then
		local var_16_4 = RoomFormulaListModel.instance:isSelectedFormula(var_16_3)

		gohelper.setActive(var_16_0.normal, not var_16_4)
		gohelper.setActive(var_16_0.highlight, var_16_4)
	end

	if var_16_1.hasData then
		local var_16_5 = RoomFormulaListModel.instance:isSelectedFormula(var_16_1.grandParentStrId)

		gohelper.setActive(var_16_1.normal, not var_16_5)
		gohelper.setActive(var_16_1.highlight, var_16_5)
	end

	if var_16_2.hasData then
		local var_16_6 = RoomFormulaListModel.instance:isSelectedFormula(var_16_2.greatGrandParentStrId)

		gohelper.setActive(var_16_2.normal, not var_16_6)
		gohelper.setActive(var_16_2.highlight, var_16_6)
	end
end

function var_0_0.getShowLineObj(arg_17_0)
	local var_17_0 = {
		hasData = false
	}
	local var_17_1 = {
		hasData = false
	}
	local var_17_2 = {
		hasData = false
	}
	local var_17_3 = arg_17_0._mo:getFormulaTreeLevel()
	local var_17_4 = arg_17_0._mo:getIsLast()
	local var_17_5 = arg_17_0._mo:getParentStrId()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._treeLevelItemList) do
		local var_17_6 = iter_17_0 == var_17_3

		gohelper.setActive(iter_17_1.go, var_17_6)

		if var_17_6 then
			if iter_17_1.lineT then
				gohelper.setActive(iter_17_1.lineT, not var_17_4)

				if not var_17_4 then
					var_17_0.normal = iter_17_1.lineTNo
					var_17_0.highlight = iter_17_1.lineTHL
					var_17_0.hasData = true
				end
			end

			if iter_17_1.lineL then
				gohelper.setActive(iter_17_1.lineL, var_17_4)

				if var_17_4 then
					var_17_0.normal = iter_17_1.lineLNo
					var_17_0.highlight = iter_17_1.lineLHL
					var_17_0.hasData = true
				end
			end

			if var_17_5 then
				local var_17_7 = RoomFormulaModel.instance:getFormulaParentStrId(var_17_5)

				if iter_17_1.lineI1 then
					local var_17_8 = RoomFormulaModel.instance:getFormulaIsLast(var_17_5)

					gohelper.setActive(iter_17_1.lineI1, not var_17_8)

					if not var_17_8 then
						var_17_1.normal = iter_17_1.lineI1No
						var_17_1.highlight = iter_17_1.lineI1HL
						var_17_1.grandParentStrId = var_17_7
						var_17_1.hasData = true
					end
				end

				if iter_17_1.lineI2 then
					local var_17_9 = RoomFormulaModel.instance:getFormulaIsLast(var_17_7)

					gohelper.setActive(iter_17_1.lineI2, not var_17_9)

					if not var_17_9 then
						var_17_2.normal = iter_17_1.lineI2No
						var_17_2.highlight = iter_17_1.lineI2HL
						var_17_2.greatGrandParentStrId = RoomFormulaModel.instance:getFormulaParentStrId(var_17_7)
						var_17_2.hasData = true
					end
				end
			end
		end
	end

	return var_17_0, var_17_1, var_17_2
end

function var_0_0._refreshCoinCount(arg_18_0)
	arg_18_0.costScore = 0

	local var_18_0 = arg_18_0._mo:getFormulaId()
	local var_18_1 = true
	local var_18_2 = RoomProductionHelper.getCostCoinItemList(var_18_0)[1]

	if var_18_2 then
		local var_18_3 = arg_18_0._mo:getFormulaCombineCount()

		arg_18_0.costScore = (var_18_2.quantity or 0) * var_18_3
		var_18_1 = ItemModel.instance:getItemQuantity(var_18_2.type, var_18_2.id) >= arg_18_0.costScore
	end

	if var_18_1 then
		arg_18_0._txtgold.text = GameUtil.numberDisplay(arg_18_0.costScore)
	else
		arg_18_0._txtgold.text = string.format("<color=#d97373>%s</color>", arg_18_0.costScore)
	end

	gohelper.setActive(arg_18_0._goitem, arg_18_0.costScore > 0)
	gohelper.setActive(arg_18_0._goempty, arg_18_0.costScore <= 0)
end

function var_0_0._refreshMaterialItemCount(arg_19_0)
	local var_19_0 = arg_19_0._mo:getFormulaId()
	local var_19_1 = arg_19_0._mo:getFormulaCombineCount()
	local var_19_2 = RoomProductionHelper.getCostMaterialItemList(var_19_0)

	for iter_19_0 = 1, math.min(arg_19_0._maxMaterialItemCount, #var_19_2) do
		local var_19_3 = arg_19_0._materialItemList[iter_19_0]
		local var_19_4 = var_19_2[iter_19_0]
		local var_19_5 = var_19_4.quantity * var_19_1
		local var_19_6 = ItemModel.instance:getItemQuantity(var_19_4.type, var_19_4.id)
		local var_19_7 = var_19_5 <= var_19_6

		if var_19_3.costItem then
			var_19_3.costItem:setMOValue(var_19_4.type, var_19_4.id, var_19_5)
			var_19_3.costItem:setGrayscale(not var_19_7)
		end

		local var_19_8 = RoomProductionHelper.formatItemNum(var_19_6)

		if var_19_7 then
			var_19_3.txtnum.text = string.format("%s/%s", var_19_8, var_19_5)
		else
			var_19_3.txtnum.text = string.format("<color=#d97373>%s/%s</color>", var_19_8, var_19_5)
		end
	end

	local var_19_9 = RoomProductionHelper.getFormulaProduceItem(var_19_0)

	gohelper.setActive(arg_19_0._txtCombineNum.gameObject, var_19_9)

	if var_19_9 then
		arg_19_0._txtCombineNum.text = luaLang("multiple") .. var_19_9.quantity * var_19_1
	end
end

function var_0_0._refreshOwnQuantityAndTag(arg_20_0)
	local var_20_0 = arg_20_0._mo:getFormulaId()
	local var_20_1 = 0
	local var_20_2 = RoomProductionHelper.getFormulaProduceItem(var_20_0)

	if var_20_2 then
		var_20_1 = ItemModel.instance:getItemQuantity(var_20_2.type, var_20_2.id)
	end

	local var_20_3 = arg_20_0._mo:getId()
	local var_20_4 = RoomProductionHelper.getFormulaNeedQuantity(var_20_3)

	if var_20_4 and var_20_4 ~= 0 then
		local var_20_5 = ""

		if var_20_4 <= var_20_1 then
			var_20_5 = string.format("%s/%s", var_20_1, var_20_4)

			gohelper.setActive(arg_20_0._goCanCombine, false)
			gohelper.setActive(arg_20_0._goNeed, false)
		else
			var_20_5 = string.format("<color=#d97373>%s</color>/%s", var_20_1, var_20_4)

			local var_20_6 = RoomProductionHelper.getTotalCanCombineNum(var_20_0)
			local var_20_7 = var_20_6 ~= 0

			if var_20_7 then
				arg_20_0._txtCanCombine.text = formatLuaLang("room_formula_can_combine", var_20_6)
			end

			gohelper.setActive(arg_20_0._goCanCombine, var_20_7)
			gohelper.setActive(arg_20_0._goNeed, not var_20_7)
		end

		arg_20_0._txtOwnNum.text = var_20_5
	else
		arg_20_0._txtOwnNum.text = var_20_1

		gohelper.setActive(arg_20_0._goCanCombine, false)
		gohelper.setActive(arg_20_0._goNeed, false)
	end
end

function var_0_0._playAnimByName(arg_21_0, arg_21_1)
	arg_21_0._lastAnimName = arg_21_1

	arg_21_0._animator:Play(arg_21_1, 0, 0)
end

function var_0_0._onHideAnimAnimation(arg_22_0, arg_22_1)
	if arg_22_0:_canTreeAnim(arg_22_1) then
		arg_22_0:_playAnimByName(RoomProductLineEnum.AnimName.TreeHide)
	end
end

function var_0_0._onShowAnimAnimation(arg_23_0, arg_23_1)
	arg_23_0._showLevel = arg_23_1
end

function var_0_0._onMoveAnimAnimation(arg_24_0, arg_24_1)
	arg_24_0._checkMove = true
end

function var_0_0._checkAnimation(arg_25_0)
	local var_25_0 = arg_25_0._showLevel

	arg_25_0._showLevel = nil

	if arg_25_0._checkMove then
		arg_25_0._lineAnimator:Play(RoomProductLineEnum.AnimName.TreeHide, 0, 0)
	end

	if var_25_0 and arg_25_0:_canTreeAnim(var_25_0) then
		arg_25_0:_playAnimByName(RoomProductLineEnum.AnimName.TreeShow, 0, 0)

		arg_25_0._checkMove = false
	end

	arg_25_0:_checkMoveAnimation()

	if arg_25_0._lastAnimName == RoomProductLineEnum.AnimName.TreeHide then
		arg_25_0:_playAnimByName(RoomProductLineEnum.AnimName.TreeIdle, 0, 0)
	end
end

function var_0_0._checkMoveAnimation(arg_26_0)
	if arg_26_0._checkMove ~= true then
		arg_26_0:_tweenKill(true)

		return
	end

	arg_26_0._checkMove = false

	local var_26_0 = RoomFormulaListModel.instance:getRankDiff(arg_26_0._mo)

	if var_26_0 and var_26_0 ~= 0 then
		arg_26_0:_tweenKill()
		arg_26_0:_playAnimByName(RoomProductLineEnum.AnimName.TreeIdle)

		local var_26_1 = RoomFormulaViewContainer.cellHeightSize * var_26_0

		transformhelper.setLocalPosXY(arg_26_0._gonormalTrs, 0, var_26_1)
		transformhelper.setLocalPosXY(arg_26_0._golockTrs, 0, var_26_1)

		arg_26_0._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(arg_26_0._gonormalTrs, 0, RoomProductLineEnum.AnimTime.TreeAnim)
		arg_26_0._golockMoveId = ZProj.TweenHelper.DOAnchorPosY(arg_26_0._golockTrs, 0, RoomProductLineEnum.AnimTime.TreeAnim)
	else
		arg_26_0:_tweenKill(true)
	end
end

function var_0_0._tweenKill(arg_27_0, arg_27_1)
	if arg_27_0._rankDiffMoveId then
		ZProj.TweenHelper.KillById(arg_27_0._rankDiffMoveId)
		ZProj.TweenHelper.KillById(arg_27_0._golockMoveId)

		arg_27_0._rankDiffMoveId = nil
		arg_27_0._golockMoveId = nil

		if arg_27_1 then
			transformhelper.setLocalPosXY(arg_27_0._gonormalTrs, 0, 0)
			transformhelper.setLocalPosXY(arg_27_0._golockTrs, 0, 0)
		end
	end
end

function var_0_0._canTreeAnim(arg_28_0, arg_28_1)
	if arg_28_1 then
		local var_28_0 = arg_28_0._mo:getFormulaTreeLevel()

		if var_28_0 and arg_28_1 < var_28_0 then
			return true
		end
	end

	return false
end

function var_0_0.jumpFinishCallback(arg_29_0)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshNeedFormula)
end

function var_0_0.onDestroyView(arg_30_0)
	arg_30_0._simageproduceitem:UnLoadImage()
	arg_30_0._simagecoinIcon:UnLoadImage()
	arg_30_0:_tweenKill()
end

return var_0_0
