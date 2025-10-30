module("modules.logic.commandstation.view.CommandStationMapVersionView", package.seeall)

local var_0_0 = class("CommandStationMapVersionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goversionname = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname")
	arg_1_0._gonameViewport = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport")
	arg_1_0._gonameContent = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport/#go_nameContent")
	arg_1_0._gonameItem = gohelper.findChild(arg_1_0.viewGO, "#go_TimeAxis/go/timeline/Sort/#go_versionname/#go_nameViewport/#go_nameContent/#go_nameItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	gohelper.setActive(arg_2_0._gonameItem, false)

	arg_2_0._itemList = arg_2_0:getUserDataTb_()
	arg_2_0._recycleList = arg_2_0:getUserDataTb_()
	arg_2_0._versionConfigList = lua_copost_version.configList
	arg_2_0._versionConfigLen = #arg_2_0._versionConfigList
	arg_2_0._itemHeight = 136
	arg_2_0._itemSpace = -45
	arg_2_0._itemHeightWithSpace = arg_2_0._itemHeight + arg_2_0._itemSpace
	arg_2_0._halfItemHeight = arg_2_0._itemHeight / 2
	arg_2_0._startIndex = -1
	arg_2_0._endIndex = 5
	arg_2_0._noScaleOffsetIndex = 3

	arg_2_0:_initDrag()
end

function var_0_0._initDrag(arg_3_0)
	arg_3_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_3_0._gonameViewport)

	arg_3_0._drag:AddDragBeginListener(arg_3_0._onDragBegin, arg_3_0)
	arg_3_0._drag:AddDragEndListener(arg_3_0._onDragEnd, arg_3_0)
	arg_3_0._drag:AddDragListener(arg_3_0._onDrag, arg_3_0)
end

function var_0_0._onDragBegin(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._beginDragPosY = arg_4_2.position.y
	arg_4_0._beginPosY = recthelper.getAnchorY(arg_4_0._gonameContent.transform)
end

function var_0_0._onDragEnd(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._beginPosY then
		return
	end

	if arg_5_0._beginPosY == arg_5_0._dragResultY then
		return
	end

	local var_5_0 = (arg_5_0._beginPosY < arg_5_0._dragResultY and math.ceil(arg_5_0._dragResultY / arg_5_0._itemHeightWithSpace) or math.floor(arg_5_0._dragResultY / arg_5_0._itemHeightWithSpace)) * arg_5_0._itemHeightWithSpace

	arg_5_0:_startTween(var_5_0)
end

function var_0_0._startTween(arg_6_0, arg_6_1)
	if arg_6_0._tweenId then
		ZProj.TweenHelper.KillById(arg_6_0._tweenId)

		arg_6_0._tweenId = nil
	end

	local var_6_0 = recthelper.getAnchorY(arg_6_0._gonameContent.transform)

	arg_6_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_6_0, arg_6_1, 0.5, arg_6_0._tweenFrame, arg_6_0._tweenFinish, arg_6_0)
end

function var_0_0._tweenFrame(arg_7_0, arg_7_1)
	arg_7_0:_setContentPosY(arg_7_1)
end

function var_0_0._onDrag(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._beginPosY then
		return
	end

	arg_8_0._dragResultY = arg_8_0._beginPosY + (arg_8_2.position.y - arg_8_0._beginDragPosY)

	arg_8_0:_setContentPosY(arg_8_0._dragResultY)
end

function var_0_0._setContentPosY(arg_9_0, arg_9_1)
	recthelper.setAnchorY(arg_9_0._gonameContent.transform, arg_9_1)

	local var_9_0, var_9_1 = arg_9_0:_checkBoundry()

	arg_9_0._curCenterIndex = var_9_0

	if arg_9_0._leftVersionView then
		arg_9_0._leftVersionView:setContentPosY(var_9_0 - arg_9_0._initFocusIndex, var_9_1)
	end
end

function var_0_0._checkBoundry(arg_10_0)
	local var_10_0 = recthelper.getAnchorY(arg_10_0._gonameContent.transform)
	local var_10_1 = Mathf.Round(var_10_0 / arg_10_0._itemHeightWithSpace)
	local var_10_2 = arg_10_0._startIndex + var_10_1
	local var_10_3 = arg_10_0._endIndex + var_10_1
	local var_10_4 = var_10_2 + arg_10_0._noScaleOffsetIndex
	local var_10_5 = 0
	local var_10_6 = -182
	local var_10_7 = 20
	local var_10_8 = 0.1

	for iter_10_0, iter_10_1 in pairs(arg_10_0._itemList) do
		if var_10_2 > iter_10_1.index or var_10_3 < iter_10_1.index then
			gohelper.setActive(iter_10_1.go, false)

			arg_10_0._itemList[iter_10_0] = nil

			table.insert(arg_10_0._recycleList, iter_10_1)
		end
	end

	for iter_10_2 = var_10_2, var_10_3 do
		if not arg_10_0._itemList[iter_10_2] then
			local var_10_9 = arg_10_0:_getItem(iter_10_2)

			arg_10_0._itemList[iter_10_2] = var_10_9
		end

		local var_10_10 = arg_10_0._itemList[iter_10_2]
		local var_10_11 = var_10_10.posY + var_10_0 + arg_10_0._halfItemHeight - var_10_6
		local var_10_12 = math.abs(iter_10_2 - var_10_4)
		local var_10_13 = var_10_12 <= 1 and 1 or 1.5
		local var_10_14 = var_10_12 <= 0 and 1 or 2
		local var_10_15 = math.abs(var_10_11) * 0.1 / arg_10_0._itemHeightWithSpace
		local var_10_16 = var_10_15 * var_10_13
		local var_10_17 = var_10_15 * var_10_14

		if iter_10_2 == var_10_4 then
			var_10_5 = var_10_11 / arg_10_0._itemHeightWithSpace
		end

		local var_10_18 = 1 - var_10_16

		transformhelper.setLocalScale(var_10_10.transform, var_10_18, var_10_18, 1)

		var_10_10.color.a = 1 - var_10_17
		var_10_10.txt.color = var_10_10.color

		if var_10_8 <= var_10_15 then
			local var_10_19 = var_10_4 <= iter_10_2 and 1 or -1

			recthelper.setAnchorY(var_10_10.transform, var_10_10.posY + (var_10_15 - var_10_8) * 10 * var_10_7 * var_10_19)
		else
			recthelper.setAnchorY(var_10_10.transform, var_10_10.posY)
		end
	end

	return var_10_4, var_10_5
end

function var_0_0._getItem(arg_11_0, arg_11_1)
	local var_11_0 = table.remove(arg_11_0._recycleList)

	if not var_11_0 then
		local var_11_1 = gohelper.cloneInPlace(arg_11_0._gonameItem)
		local var_11_2 = gohelper.findChildText(var_11_1, "Text")
		local var_11_3 = var_11_2.color

		var_11_0 = {
			transform = var_11_1.transform,
			go = var_11_1,
			txt = var_11_2,
			color = var_11_3
		}

		local var_11_4 = SLFramework.UGUI.UIClickListener.Get(var_11_1)

		var_11_4:AddClickListener(arg_11_0._onVersionClick, arg_11_0, var_11_0)

		var_11_0.clickListener = var_11_4
	end

	var_11_0.index = arg_11_1

	local var_11_5 = math.abs(arg_11_1 % arg_11_0._versionConfigLen)
	local var_11_6 = arg_11_0._versionConfigList[var_11_5 + 1]

	var_11_0.txt.text = var_11_6.timeId
	var_11_0.versionId = var_11_6.versionId

	local var_11_7 = -arg_11_1 * arg_11_0._itemHeightWithSpace - arg_11_0._halfItemHeight

	recthelper.setAnchorY(var_11_0.transform, var_11_7)

	var_11_0.posY = var_11_7

	gohelper.setActive(var_11_0.go, true)

	var_11_0.go.name = arg_11_1

	return var_11_0
end

function var_0_0._onVersionClick(arg_12_0, arg_12_1)
	CommandStationMapModel.instance:setVersionId(arg_12_1.versionId)
	CommandStationMapModel.instance:initTimeId()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.ChangeVersionId, arg_12_1.versionId)
	arg_12_0:_focusByItemIndex(arg_12_1.index, true)
end

function var_0_0._focusByItemIndex(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == arg_13_0._curFocusIndex and arg_13_1 == arg_13_0._curCenterIndex then
		return
	end

	arg_13_0._curFocusIndex = arg_13_1

	local var_13_0 = arg_13_0._focusVersionPosY + (arg_13_1 - arg_13_0._initFocusIndex) * arg_13_0._itemHeightWithSpace

	if arg_13_2 then
		arg_13_0:_startTween(var_13_0)
	else
		arg_13_0:_setContentPosY(var_13_0)
	end
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0._leftVersionView = arg_14_0.viewContainer:getLeftVersionView()

	local var_14_0 = arg_14_0._startIndex + arg_14_0._noScaleOffsetIndex
	local var_14_1 = math.abs(var_14_0 % arg_14_0._versionConfigLen)
	local var_14_2 = arg_14_0._versionConfigList[var_14_1 + 1].versionId
	local var_14_3 = CommandStationMapModel.instance:getVersionId()

	if var_14_3 ~= var_14_2 then
		arg_14_0._focusVersionPosY = (CommandStationConfig.instance:getVersionIndex(var_14_3) - 1 - var_14_1) * arg_14_0._itemHeightWithSpace

		recthelper.setAnchorY(arg_14_0._gonameContent.transform, arg_14_0._focusVersionPosY)
	else
		arg_14_0._focusVersionPosY = 0

		recthelper.setAnchorY(arg_14_0._gonameContent.transform, arg_14_0._focusVersionPosY)
	end

	arg_14_0._initFocusIndex = arg_14_0:_checkBoundry()
	arg_14_0._curFocusIndex = arg_14_0._initFocusIndex

	arg_14_0:addEventCb(CommandStationController.instance, CommandStationEvent.HideVersionSelectView, arg_14_0._onHideVersionSelectView, arg_14_0)
end

function var_0_0._onHideVersionSelectView(arg_15_0)
	if not arg_15_0._curCenterIndex then
		return
	end

	if arg_15_0._curFocusIndex ~= arg_15_0._curCenterIndex then
		if math.abs(arg_15_0._curFocusIndex % arg_15_0._versionConfigLen) == math.abs(arg_15_0._curCenterIndex % arg_15_0._versionConfigLen) then
			return
		end

		local var_15_0 = arg_15_0:_getNearSameIndex()

		if var_15_0 then
			arg_15_0:_focusByItemIndex(var_15_0, true)
		else
			arg_15_0:_focusByItemIndex(arg_15_0._curFocusIndex)
		end
	end
end

function var_0_0._getNearSameIndex(arg_16_0)
	local var_16_0 = math.abs(arg_16_0._curFocusIndex % arg_16_0._versionConfigLen)

	if arg_16_0._curFocusIndex < arg_16_0._curCenterIndex then
		for iter_16_0 = 1, arg_16_0._versionConfigLen do
			local var_16_1 = arg_16_0._curCenterIndex - iter_16_0

			if var_16_0 == math.abs(var_16_1 % arg_16_0._versionConfigLen) then
				return var_16_1
			end
		end
	else
		for iter_16_1 = 1, arg_16_0._versionConfigLen do
			local var_16_2 = arg_16_0._curCenterIndex + iter_16_1

			if var_16_0 == math.abs(var_16_2 % arg_16_0._versionConfigLen) then
				return var_16_2
			end
		end
	end
end

function var_0_0.onClose(arg_17_0)
	if arg_17_0._drag then
		arg_17_0._drag:RemoveDragBeginListener()
		arg_17_0._drag:RemoveDragListener()
		arg_17_0._drag:RemoveDragEndListener()

		arg_17_0._drag = nil
	end

	if arg_17_0._tweenId then
		ZProj.TweenHelper.KillById(arg_17_0._tweenId)

		arg_17_0._tweenId = nil
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0._itemList) do
		iter_17_1.clickListener:RemoveClickListener()
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0._recycleList) do
		iter_17_3.clickListener:RemoveClickListener()
	end
end

return var_0_0
