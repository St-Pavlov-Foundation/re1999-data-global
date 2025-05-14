module("modules.logic.room.view.critter.RoomCritterPlaceItem", package.seeall)

local var_0_0 = class("RoomCritterPlaceItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "#go_icon")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#go_click")
	arg_1_0._goratio = gohelper.findChild(arg_1_0.viewGO, "#go_ratio")
	arg_1_0._txtratio = gohelper.findChildText(arg_1_0.viewGO, "#go_ratio/#txt_ratio")
	arg_1_0._uiclick = gohelper.getClickWithDefaultAudio(arg_1_0._goclick)
	arg_1_0._uidrag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._goclick)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._uiclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._uiclick:AddClickDownListener(arg_2_0._btnclickOnClickDown, arg_2_0)
	arg_2_0._uidrag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._uidrag:AddDragListener(arg_2_0._onDrag, arg_2_0)
	arg_2_0._uidrag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._uiclick:RemoveClickListener()
	arg_3_0._uiclick:RemoveClickDownListener()
	arg_3_0._uidrag:RemoveDragBeginListener()
	arg_3_0._uidrag:RemoveDragListener()
	arg_3_0._uidrag:RemoveDragEndListener()
end

function var_0_0._btnclickOnClickDown(arg_4_0)
	arg_4_0._isDragUI = false
end

function var_0_0._btnclickOnClick(arg_5_0)
	if arg_5_0._isDragUI then
		return
	end

	local var_5_0 = arg_5_0:getViewBuilding()
	local var_5_1 = arg_5_0:getCritterId()

	CritterController.instance:clickCritterPlaceItem(var_5_0, var_5_1)
end

function var_0_0._onDragBegin(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._isDragUI = true

	CritterController.instance:dispatchEvent(CritterEvent.CritterListOnDragBeginListener, arg_6_2)
end

function var_0_0._onDrag(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._isDragUI = true

	CritterController.instance:dispatchEvent(CritterEvent.CritterListOnDragListener, arg_7_2)
end

function var_0_0._onDragEnd(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._isDragUI = false

	CritterController.instance:dispatchEvent(CritterEvent.CritterListOnDragEndListener, arg_8_2)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._goarrow = gohelper.findChild(arg_9_0.viewGO, "#go_ratio/#txt_ratio/arrow")
	arg_9_0._isDragUI = false
	arg_9_0._dragStartY = 250 * UnityEngine.Screen.height / 1080
end

function var_0_0._editableAddEvents(arg_10_0)
	arg_10_0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, arg_10_0._onAttrPreviewUpdate, arg_10_0)
end

function var_0_0._editableRemoveEvents(arg_11_0)
	arg_11_0:removeEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, arg_11_0._onAttrPreviewUpdate, arg_11_0)
end

function var_0_0._onAttrPreviewUpdate(arg_12_0, arg_12_1)
	if arg_12_0._mo and arg_12_1[arg_12_0._mo:getId()] then
		arg_12_0:setCritter()
	end
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1)
	arg_13_0._mo = arg_13_1

	arg_13_0:setCritter()
	arg_13_0:refresh()
end

function var_0_0.setCritter(arg_14_0)
	local var_14_0, var_14_1 = arg_14_0:getCritterId()

	if not arg_14_0.critterIcon then
		arg_14_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_14_0._goicon)

		arg_14_0.critterIcon:setSelectUIVisible(true)
	end

	arg_14_0.critterIcon:setMOValue(var_14_0, var_14_1)
	arg_14_0.critterIcon:showMood()

	local var_14_2, var_14_3 = arg_14_0:getViewBuilding()
	local var_14_4 = ManufactureModel.instance:getCritterRestingBuilding(var_14_0)

	arg_14_0.critterIcon:setIsShowBuildingIcon(var_14_4 ~= var_14_2)

	local var_14_5 = false

	if var_14_4 then
		local var_14_6 = RoomMapBuildingModel.instance:getBuildingMOById(var_14_4)
		local var_14_7 = var_14_6 and var_14_6.buildingId
		local var_14_8 = CritterHelper.getPreViewAttrValue(CritterEnum.AttributeType.MoodRestore, var_14_0, var_14_7, false)

		if var_14_8 > 0 then
			arg_14_0._txtratio.text = "+" .. CritterHelper.formatAttrValue(CritterEnum.AttributeType.MoodRestore, var_14_8)
			var_14_5 = true
		end

		local var_14_9 = var_14_3 and var_14_3.config and var_14_3.config.buildingType
		local var_14_10 = var_14_8 > arg_14_0:getBuildingMoodValue(var_14_9)

		gohelper.setActive(arg_14_0._goarrow, var_14_10)
		SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._txtratio, var_14_10 and "#D9A06F" or "#D4C399")
	end

	gohelper.setActive(arg_14_0._goratio, var_14_5)
end

function var_0_0.getBuildingMoodValue(arg_15_0, arg_15_1)
	return CritterHelper.getPatienceChangeValue(arg_15_1)
end

function var_0_0.refresh(arg_16_0)
	return
end

function var_0_0.onSelect(arg_17_0, arg_17_1)
	if arg_17_0.critterIcon then
		arg_17_0.critterIcon:onSelect(arg_17_1)
	end

	arg_17_0._isSelect = arg_17_1
end

function var_0_0.getCritterId(arg_18_0)
	local var_18_0
	local var_18_1

	if arg_18_0._mo then
		var_18_0 = arg_18_0._mo:getId()
		var_18_1 = arg_18_0._mo:getDefineId()
	end

	return var_18_0, var_18_1
end

function var_0_0.getViewBuilding(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0._view.viewContainer:getContainerViewBuilding(true)

	return var_19_0, var_19_1
end

function var_0_0.onDestroy(arg_20_0)
	return
end

return var_0_0
