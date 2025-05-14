module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologySelectView", package.seeall)

local var_0_0 = class("VersionActivity1_3AstrologySelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageDec1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "SelectStar/#simage_Dec1")
	arg_1_0._simageDec2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "SelectStar/#simage_Dec2")
	arg_1_0._scrollPlanetList = gohelper.findChildScrollRect(arg_1_0.viewGO, "SelectStar/#scroll_PlanetList")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "SelectStar/#scroll_PlanetList/Viewport/#go_content")
	arg_1_0._txtStarName = gohelper.findChildText(arg_1_0.viewGO, "SelectStar/#txt_StarName")
	arg_1_0._txtAdjustTimes = gohelper.findChildText(arg_1_0.viewGO, "SelectStar/AdjustTimes/image_AdjustTimesBG/#txt_AdjustTimes")
	arg_1_0._txtCurrentAngle = gohelper.findChildText(arg_1_0.viewGO, "CurrentAngle/image_CurrentAngleBG/#txt_CurrentAngle")
	arg_1_0._goBtns = gohelper.findChild(arg_1_0.viewGO, "#go_Btns")
	arg_1_0._goToGet = gohelper.findChild(arg_1_0.viewGO, "#go_Btns/#go_ToGet")
	arg_1_0._btnToGet = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Btns/#go_ToGet/#btn_ToGet")
	arg_1_0._txtToGetTips = gohelper.findChildText(arg_1_0.viewGO, "#go_Btns/#go_ToGet/#txt_ToGetTips")
	arg_1_0._goConfirm = gohelper.findChild(arg_1_0.viewGO, "#go_Btns/#go_Confirm")
	arg_1_0._btnConfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Btns/#go_Confirm/#btn_Confirm")
	arg_1_0._txtConfirmTips = gohelper.findChildText(arg_1_0.viewGO, "#go_Btns/#go_Confirm/#txt_ConfirmTips")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "#go_Btns/#go_Tips")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#go_Btns/#go_Tips/#txt_Tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnToGet:AddClickListener(arg_2_0._btnToGetOnClick, arg_2_0)
	arg_2_0._btnConfirm:AddClickListener(arg_2_0._btnConfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnToGet:RemoveClickListener()
	arg_3_0._btnConfirm:RemoveClickListener()
end

function var_0_0._btnToGetOnClick(arg_4_0)
	JumpController.instance:jump(VersionActivity1_3DungeonEnum.JumpDaily)
end

function var_0_0._btnConfirmOnClick(arg_5_0)
	arg_5_0.viewContainer:sendUpdateProgressRequest()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._viewPortTrans = arg_6_0._gocontent.transform.parent

	arg_6_0:_addItems()
	arg_6_0:addEventCb(VersionActivity1_3AstrologyController.instance, VersionActivity1_3AstrologyEvent.adjustPreviewAngle, arg_6_0._adjustPreviewAngle, arg_6_0)
	arg_6_0:addEventCb(Activity126Controller.instance, Activity126Event.onUpdateProgressReply, arg_6_0._onUpdateProgressReply, arg_6_0)
	arg_6_0:addEventCb(Activity126Controller.instance, Activity126Event.onGetHoroscopeReply, arg_6_0._onGetHoroscopeReply, arg_6_0)

	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._viewPortTrans.gameObject)

	arg_6_0._drag:AddDragBeginListener(arg_6_0._onDragBeginHandler, arg_6_0)
	arg_6_0._drag:AddDragEndListener(arg_6_0._onDragEndHandler, arg_6_0)
	arg_6_0._drag:AddDragListener(arg_6_0._onDrag, arg_6_0)
end

function var_0_0._onDragBeginHandler(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._startDragPos = recthelper.screenPosToAnchorPos(arg_7_2.position, arg_7_0._viewPortTrans)
	arg_7_0._selectedIndex = tabletool.indexOf(arg_7_0._planetMoList, arg_7_0._selectedItem:getPlanetMo())
end

function var_0_0._onDragEndHandler(arg_8_0, arg_8_1, arg_8_2)
	return
end

function var_0_0._onDrag(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._startDragPos then
		return
	end

	local var_9_0 = recthelper.screenPosToAnchorPos(arg_9_2.position, arg_9_0._viewPortTrans) - arg_9_0._startDragPos
	local var_9_1 = math.floor(math.abs(var_9_0.x) / 120)
	local var_9_2 = arg_9_0._selectedIndex + (var_9_0.x > 0 and -var_9_1 or var_9_1)
	local var_9_3 = arg_9_0._planetMoList[var_9_2]

	if var_9_3 then
		local var_9_4 = arg_9_0._itemList[var_9_3.id]

		arg_9_0:setSelected(var_9_4)
	end
end

function var_0_0._onGetHoroscopeReply(arg_10_0)
	return
end

function var_0_0._onUpdateProgressReply(arg_11_0, arg_11_1)
	if arg_11_1 and arg_11_1.fromReset then
		arg_11_0:_sortAndSelectFirst()
		arg_11_0:_refresh()
	else
		if not VersionActivity1_3AstrologyModel.instance:getStarReward() then
			arg_11_0:_refresh()

			return
		end

		TaskDispatcher.cancelTask(arg_11_0._refresh, arg_11_0)
		TaskDispatcher.runDelay(arg_11_0._refresh, arg_11_0, 2.5)
	end
end

function var_0_0._refresh(arg_12_0)
	arg_12_0:updateItemNum()
	arg_12_0:_updatePlanetItemInfo()
end

function var_0_0._adjustPreviewAngle(arg_13_0)
	arg_13_0:_updatePlanetItemInfo()
end

function var_0_0.onOpen(arg_14_0)
	return
end

function var_0_0._sortItems(arg_15_0)
	table.sort(arg_15_0._planetMoList, var_0_0._sort)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._planetMoList) do
		local var_15_0 = arg_15_0._itemList[iter_15_1.id]

		gohelper.setAsLastSibling(var_15_0.viewGO)
	end
end

function var_0_0._sort(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.num > 0
	local var_16_1 = arg_16_1.num > 0

	if var_16_0 and var_16_1 then
		return arg_16_0.id < arg_16_1.id
	elseif var_16_0 then
		return true
	elseif var_16_1 then
		return false
	end

	return arg_16_0.id < arg_16_1.id
end

function var_0_0._addItems(arg_17_0)
	arg_17_0._itemList = arg_17_0:getUserDataTb_()
	arg_17_0._planetMoList = {}

	local var_17_0 = arg_17_0.viewContainer:getSetting().otherRes[1]

	for iter_17_0 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local var_17_1 = arg_17_0:getResInst(var_17_0, arg_17_0._gocontent)
		local var_17_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_1, VersionActivity1_3AstrologyPlanetItem, {
			iter_17_0,
			arg_17_0
		})

		arg_17_0._itemList[iter_17_0] = var_17_2

		table.insert(arg_17_0._planetMoList, var_17_2:getPlanetMo())
	end

	arg_17_0:_sortAndSelectFirst()
end

function var_0_0._sortAndSelectFirst(arg_18_0)
	arg_18_0:_sortItems()
	arg_18_0:setSelected(arg_18_0._itemList[arg_18_0._planetMoList[1].id])
end

function var_0_0.setSelected(arg_19_0, arg_19_1)
	if arg_19_0._selectedItem == arg_19_1 then
		return
	end

	arg_19_0._selectedItem = arg_19_1
	arg_19_0._planetMo = arg_19_0._selectedItem:getPlanetMo()
	arg_19_0._txtStarName.text = arg_19_0._planetMo:getItemName()

	for iter_19_0, iter_19_1 in pairs(arg_19_0._itemList) do
		iter_19_1:setSelected(iter_19_1 == arg_19_1)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_19_0._gocontent.transform)
	TaskDispatcher.cancelTask(arg_19_0._focusItem, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0._focusItem, arg_19_0, 0)
	VersionActivity1_3AstrologyController.instance:dispatchEvent(VersionActivity1_3AstrologyEvent.selectPlanetItem, arg_19_1)
	arg_19_0:_updatePlanetItemInfo()
end

function var_0_0._focusItem(arg_20_0)
	local var_20_0 = -(recthelper.getAnchorX(arg_20_0._selectedItem.viewGO.transform) - 470) - 42

	arg_20_0:_clearTween()

	arg_20_0._contentTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_20_0._gocontent.transform, var_20_0, 0.2)
end

function var_0_0._clearTween(arg_21_0)
	if arg_21_0._contentTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._contentTweenId)

		arg_21_0._contentTweenId = nil
	end
end

function var_0_0.updateItemNum(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0._itemList) do
		iter_22_1:updateNum()
	end
end

function var_0_0._updatePlanetItemInfo(arg_23_0)
	local var_23_0 = arg_23_0._planetMo.num
	local var_23_1 = arg_23_0._planetMo:getRemainNum()

	arg_23_0:_updateNum(var_23_0, var_23_1)
	arg_23_0:_updateAngle(arg_23_0._planetMo.previewAngle)

	local var_23_2 = Activity126Model.instance:getStarNum() >= 10
	local var_23_3 = VersionActivity1_3AstrologyModel.instance:hasAdjust()
	local var_23_4 = var_23_0 <= 0

	gohelper.setActive(arg_23_0._goConfirm, false)
	gohelper.setActive(arg_23_0._goTips, false)
	gohelper.setActive(arg_23_0._goToGet, false)

	if var_23_2 then
		if var_23_3 then
			gohelper.setActive(arg_23_0._goConfirm, true)

			arg_23_0._txtConfirmTips.text = luaLang("astrology_tip6")

			return
		end

		if var_23_4 then
			gohelper.setActive(arg_23_0._goToGet, true)

			arg_23_0._txtToGetTips.text = luaLang("astrology_tip4")

			return
		end

		gohelper.setActive(arg_23_0._goTips, true)

		arg_23_0._txtTips.text = luaLang("astrology_tip5")
	else
		if var_23_3 then
			gohelper.setActive(arg_23_0._goConfirm, true)

			arg_23_0._txtConfirmTips.text = luaLang("astrology_tip3")

			return
		end

		if var_23_4 then
			gohelper.setActive(arg_23_0._goToGet, true)

			arg_23_0._txtToGetTips.text = luaLang("astrology_tip1")

			return
		end

		gohelper.setActive(arg_23_0._goTips, true)

		arg_23_0._txtTips.text = luaLang("astrology_tip2")
	end
end

function var_0_0._updateNum(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 > 0 then
		if arg_24_1 ~= arg_24_2 then
			arg_24_0._txtAdjustTimes.text = string.format("%s%s<color=#b73850>-%s</color>", luaLang("adjustNum"), arg_24_1, arg_24_1 - arg_24_2)
		else
			arg_24_0._txtAdjustTimes.text = string.format("%s%s", luaLang("adjustNum"), arg_24_1)
		end
	else
		arg_24_0._txtAdjustTimes.text = string.format("%s<color=#b73850>%s</color>", luaLang("adjustNum"), 0)
	end
end

function var_0_0._updateAngle(arg_25_0, arg_25_1)
	arg_25_0._txtCurrentAngle.text = string.format("%s°", arg_25_1 % 360)
end

function var_0_0.getSelectedPlanetId(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0._itemList) do
		if iter_26_1:isSelected() then
			return iter_26_0
		end
	end
end

function var_0_0.onClose(arg_27_0)
	return
end

function var_0_0.onDestroyView(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._focusItem, arg_28_0)
	arg_28_0:_clearTween()
	arg_28_0._drag:RemoveDragBeginListener()
	arg_28_0._drag:RemoveDragListener()
	arg_28_0._drag:RemoveDragEndListener()
	TaskDispatcher.cancelTask(arg_28_0._refresh, arg_28_0)
end

return var_0_0
