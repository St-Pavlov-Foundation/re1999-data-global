module("modules.logic.weekwalk.view.WeekWalkLayerPage", package.seeall)

local var_0_0 = class("WeekWalkLayerPage", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebgimg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgimg")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_line")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content")
	arg_1_0._gopos5 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos5")
	arg_1_0._gopos3 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos3")
	arg_1_0._gotopblock = gohelper.findChild(arg_1_0.viewGO, "#go_topblock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._scrollview:AddOnValueChanged(arg_2_0._setEdgFadeStrengthen, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._scrollview:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simageline:LoadImage(ResUrl.getWeekWalkBg("hw2.png"))

	arg_4_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO)
	arg_4_0._bgAnimation = arg_4_0._simagebgimg.gameObject:GetComponent(typeof(UnityEngine.Animation))
end

function var_0_0.removeScrollDragListener(arg_5_0, arg_5_1)
	arg_5_1:RemoveDragBeginListener()
	arg_5_1:RemoveDragEndListener()
	arg_5_1:RemoveDragListener()
end

function var_0_0.initScrollDragListener(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:AddDragBeginListener(arg_6_0._onDragBegin, arg_6_0, arg_6_2)
	arg_6_1:AddDragListener(arg_6_0._onDrag, arg_6_0, arg_6_2)
	arg_6_1:AddDragEndListener(arg_6_0._onDragEnd, arg_6_0, arg_6_2)
end

function var_0_0._onScrollValueChanged(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._curScroll then
		return
	end

	local var_7_0 = arg_7_0._curScroll.horizontalNormalizedPosition

	if arg_7_0._curNormalizedPos and var_7_0 >= 0 and var_7_0 <= 1 then
		local var_7_1 = var_7_0 - arg_7_0._curNormalizedPos

		if math.abs(var_7_1) >= arg_7_0._cellCenterPos then
			if var_7_1 > 0 then
				arg_7_0._curNormalizedPos = arg_7_0._curNormalizedPos + arg_7_0._cellCenterPos
			else
				arg_7_0._curNormalizedPos = arg_7_0._curNormalizedPos - arg_7_0._cellCenterPos
			end

			arg_7_0._curNormalizedPos = var_7_0

			if var_7_1 <= -arg_7_0._cellCenterPos and var_7_0 <= 0 then
				return
			end

			AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_slip)
		end
	end
end

function var_0_0._onDragBegin(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._beginDragScrollNormalizePos = arg_8_1.horizontalNormalizedPosition
	arg_8_0._beginDrag = true

	arg_8_0:initNormalizePos(arg_8_1)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_slipmap)
end

function var_0_0.initNormalizePos(arg_9_0, arg_9_1)
	local var_9_0 = recthelper.getWidth(arg_9_1.content)
	local var_9_1 = recthelper.getWidth(arg_9_1.transform)
	local var_9_2 = arg_9_1.content
	local var_9_3 = var_9_2.childCount

	if var_9_3 == 0 then
		return
	end

	local var_9_4 = var_9_2:GetChild(var_9_3 - 1)
	local var_9_5 = recthelper.getWidth(var_9_4)
	local var_9_6 = var_9_0 - var_9_1

	if var_9_6 > 0 then
		arg_9_0._cellCenterPos = 1 / (var_9_6 / var_9_5) / 3
		arg_9_0._curNormalizedPos = arg_9_1.horizontalNormalizedPosition

		if arg_9_0._curScroll then
			arg_9_0._curScroll = nil
		end

		arg_9_0._curScroll = arg_9_1
	else
		arg_9_0._curNormalizedPos = nil
	end
end

function var_0_0._onDrag(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._beginDrag then
		arg_10_0._beginDrag = false

		return
	end

	local var_10_0 = arg_10_2.delta.x
	local var_10_1 = arg_10_1.horizontalNormalizedPosition

	if arg_10_0._beginDragScrollNormalizePos then
		arg_10_0._beginDragScrollNormalizePos = nil
	end
end

function var_0_0._onDragEnd(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._beginDrag = false
	arg_11_0._beginDragScrollNormalizePos = nil
end

function var_0_0.playAnim(arg_12_0, arg_12_1)
	if not arg_12_0._animatorPlayer then
		return
	end

	arg_12_0._animName = arg_12_1

	arg_12_0._animatorPlayer:Play(arg_12_1, arg_12_0._animDone, arg_12_0)
	gohelper.setActive(arg_12_0._gotopblock, true)
	TaskDispatcher.cancelTask(arg_12_0._hideBlock, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0._hideBlock, arg_12_0, 0.5)
end

function var_0_0._hideBlock(arg_13_0)
	gohelper.setActive(arg_13_0._gotopblock, false)
end

function var_0_0.playBgAnim(arg_14_0, arg_14_1)
	arg_14_0._bgAnimation:Play(arg_14_1)
end

function var_0_0._animDone(arg_15_0)
	if arg_15_0._animName == "weekwalklayerpage_in" then
		arg_15_0:_changeRightBtnVisible()
	end

	if arg_15_0._visible then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._itemList) do
			iter_15_1:updateUnlockStatus()
		end
	end
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.setVisible(arg_17_0, arg_17_1)
	arg_17_0._visible = arg_17_1
end

function var_0_0.getVisible(arg_18_0)
	return arg_18_0._visible
end

function var_0_0.resetPos(arg_19_0, arg_19_1)
	if arg_19_1 then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0._layerList) do
			if iter_19_1.id == arg_19_1 then
				arg_19_0:focusPos(iter_19_0)

				return
			end
		end
	end

	for iter_19_2, iter_19_3 in ipairs(arg_19_0._layerList) do
		local var_19_0 = WeekWalkModel.instance:getMapInfo(iter_19_3.id)

		if var_19_0 and var_19_0.isFinish <= 0 then
			arg_19_0:focusPos(iter_19_2)

			return
		end

		if not var_19_0 and iter_19_2 == 1 then
			arg_19_0._scrollview.horizontalNormalizedPosition = 0

			return
		end
	end

	for iter_19_4, iter_19_5 in ipairs(arg_19_0._layerList) do
		local var_19_1 = WeekWalkModel.instance:getMapInfo(iter_19_5.id)

		if var_19_1 then
			local var_19_2, var_19_3 = var_19_1:getStarInfo()

			if var_19_2 ~= var_19_3 then
				arg_19_0:focusPos(iter_19_4)

				return
			end
		end
	end

	arg_19_0._scrollview.horizontalNormalizedPosition = 1
end

function var_0_0.focusPos(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._itemList[arg_20_1]

	if not var_20_0 then
		return
	end

	local var_20_1 = var_20_0._relativeAnchorPos

	recthelper.setAnchorX(arg_20_0._gocontent.transform, -var_20_1.x + 300)
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0._layerView = arg_21_0.viewParam[1]
	arg_21_0._pageIndex = arg_21_0.viewParam[2]
	arg_21_0._layerList = arg_21_0.viewParam[3]
	arg_21_0._itemList = arg_21_0:getUserDataTb_()

	arg_21_0:_initItems()

	if WeekWalkLayerView.isShallowPage(arg_21_0._pageIndex) then
		if arg_21_0._pageIndex <= 1 then
			arg_21_0._simagebgimg:LoadImage(ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_1"))
		else
			arg_21_0._simagebgimg:LoadImage(ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_2"))
		end
	else
		arg_21_0._simagebgimg:LoadImage(ResUrl.getWeekWalkLayerIcon("full/bg_choose_deep"))
	end

	arg_21_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_21_0._scrollview.gameObject)

	arg_21_0:initScrollDragListener(arg_21_0._drag, arg_21_0._scrollview)
	gohelper.setActive(arg_21_0._goshallowicon, WeekWalkLayerView.isShallowPage(arg_21_0._pageIndex))
	gohelper.setActive(arg_21_0._godeepicon, not WeekWalkLayerView.isShallowPage(arg_21_0._pageIndex))
	arg_21_0:_setEdgFadeStrengthen()
end

function var_0_0.updateLayerList(arg_22_0, arg_22_1)
	arg_22_0._layerList = arg_22_1

	arg_22_0:_initItems()
end

function var_0_0._initItems(arg_23_0)
	gohelper.setActive(arg_23_0._gopos3, false)
	gohelper.setActive(arg_23_0._gopos5, false)

	local var_23_0 = #arg_23_0._layerList ~= WeekWalkEnum.ShallowLayerMaxNum
	local var_23_1 = arg_23_0._gopos5
	local var_23_2 = #arg_23_0._layerList == WeekWalkEnum.NewDeepLayerMaxNum

	gohelper.setActive(var_23_1, true)

	local var_23_3 = var_23_1.transform

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._layerList) do
		local var_23_4 = var_23_3:GetChild(iter_23_0 - 1).gameObject

		arg_23_0:_addItem(var_23_4, iter_23_1, iter_23_0)
	end

	if var_23_0 then
		if var_23_2 then
			recthelper.setWidth(arg_23_0._gocontent.transform, 3932)
		else
			recthelper.setWidth(arg_23_0._gocontent.transform, 3400)
		end
	end
end

function var_0_0._addItem(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0._itemList[arg_24_3] then
		return
	end

	local var_24_0 = arg_24_0._layerView.viewContainer:getSetting().otherRes[2]
	local var_24_1 = arg_24_0._layerView.viewContainer:getResInst(var_24_0, arg_24_1)

	var_24_1.name = "weekwalklayerpageitem" .. arg_24_2.layer

	local var_24_2 = MonoHelper.addLuaComOnceToGo(var_24_1, WeekWalkLayerPageItem, {
		arg_24_2,
		arg_24_0._pageIndex,
		arg_24_0
	})

	var_24_2._relativeAnchorPos = recthelper.rectToRelativeAnchorPos(var_24_1.transform.position, arg_24_0._gocontent.transform)
	arg_24_0._itemList[arg_24_3] = var_24_2
end

function var_0_0._setEdgFadeStrengthen(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0._scrollview.horizontalNormalizedPosition < 0.01 then
		arg_25_0._scrollview.horizontalNormalizedPosition = 0
	end

	local var_25_0 = Mathf.Clamp(Mathf.Abs(arg_25_0._scrollview.horizontalNormalizedPosition * 8), 0, 1)

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnScrollPage, var_25_0, arg_25_0._pageIndex)
	arg_25_0:_changeRightBtnVisible()
	arg_25_0:_onScrollValueChanged(arg_25_1, arg_25_2)
end

function var_0_0._changeRightBtnVisible(arg_26_0)
	if not WeekWalkLayerView.isShallowPage(arg_26_0._pageIndex) or not arg_26_0._visible or not arg_26_0._scrollview then
		return
	end

	local var_26_0 = arg_26_0._scrollview.horizontalNormalizedPosition

	if var_26_0 >= 0.95 then
		arg_26_0._showRightBtn = true

		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnChangeRightBtnVisible, arg_26_0._showRightBtn)
	elseif var_26_0 <= 0.5 and arg_26_0._showRightBtn then
		arg_26_0._showRightBtn = false

		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnChangeRightBtnVisible, arg_26_0._showRightBtn)
	end
end

function var_0_0.onClose(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._hideBlock, arg_27_0)
	arg_27_0._animatorPlayer:Stop()

	if arg_27_0._drag then
		arg_27_0:removeScrollDragListener(arg_27_0._drag)
	end

	for iter_27_0, iter_27_1 in ipairs(arg_27_0._itemList) do
		iter_27_1:onDestroy()
	end
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0._simagebgimg:UnLoadImage()
	arg_28_0._simageline:UnLoadImage()
end

return var_0_0
