module("modules.logic.versionactivity2_5.act187.view.Activity187PaintingView", package.seeall)

local var_0_0 = class("Activity187PaintingView", BaseView)
local var_0_1 = 1
local var_0_2 = 0.3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#btn_close")
	arg_1_0._golowribbon = gohelper.findChild(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#go_decorationLower")
	arg_1_0._simagelantern = gohelper.findChildSingleImage(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern")
	arg_1_0._goupribbon = gohelper.findChild(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#go_decorationUpper")
	arg_1_0._simagepicturebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#simage_pictureshadow")
	arg_1_0._simagepicture = gohelper.findChildSingleImage(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#simage_pictureshadow/#simage_picture")
	arg_1_0._goriddles = gohelper.findChild(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles")
	arg_1_0._txtriddles = gohelper.findChildText(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#txt_riddles")
	arg_1_0._goriddlesRewards = gohelper.findChild(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#go_riddlesRewards")
	arg_1_0._goriddlesRewardItem = gohelper.findChild(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#go_riddlesRewards/#go_riddlesRewardItem")
	arg_1_0._gopaintTips = gohelper.findChild(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#go_paintTips")
	arg_1_0._gopaintingArea = gohelper.findChild(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/#go_paintingArea")
	arg_1_0._gofinishVx = gohelper.findChild(arg_1_0.viewGO, "v2a5_lanternfestivalpainting/vx_finish")
	arg_1_0._rawimage = arg_1_0._gopaintingArea:GetComponent(gohelper.Type_RawImage)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._drag:AddDragListener(arg_2_0._onDrag, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0:addEventCb(Activity187Controller.instance, Activity187Event.PaintViewDisplayChange, arg_2_0._onDisplayChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0:removeEventCb(Activity187Controller.instance, Activity187Event.PaintViewDisplayChange, arg_3_0._onDisplayChange, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0.viewContainer:setPaintingViewDisplay()
end

function var_0_0._onDragBegin(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._status == Activity187Enum.PaintStatus.Finish then
		return
	end

	arg_5_0:setPaintStatus(Activity187Enum.PaintStatus.Painting)
	arg_5_0:_onDrag(arg_5_1, arg_5_2)
	TaskDispatcher.cancelTask(arg_5_0._checkMouseMove, arg_5_0)
	TaskDispatcher.runRepeat(arg_5_0._checkMouseMove, arg_5_0, var_0_2)
end

function var_0_0._onDrag(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._status == Activity187Enum.PaintStatus.Finish then
		return
	end

	arg_6_0._mouseMove = true

	arg_6_0:_playPaintingAudio(true)
	arg_6_0._writingBrush:OnMouseMove(arg_6_2.position.x, arg_6_2.position.y)
end

function var_0_0._checkMouseMove(arg_7_0)
	if not arg_7_0._mouseMove then
		arg_7_0:_playPaintingAudio(false)
	end

	arg_7_0._mouseMove = false
end

function var_0_0._playPaintingAudio(arg_8_0, arg_8_1)
	if arg_8_0._isPlayPaintingAudio == arg_8_1 then
		return
	end

	local var_8_0 = arg_8_1 and AudioEnum.Act187.play_ui_tangren_yuanxiao_draw_loop or AudioEnum.Act187.stop_ui_tangren_yuanxiao_draw_loop

	AudioMgr.instance:trigger(var_8_0)

	arg_8_0._isPlayPaintingAudio = arg_8_1
end

function var_0_0._onDragEnd(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:_playPaintingAudio(false)

	if arg_9_0._status == Activity187Enum.PaintStatus.Finish then
		return
	end

	arg_9_0._writingBrush:OnMouseUp()

	if arg_9_0.viewContainer:isShowPaintView() then
		arg_9_0._paintAreaAnimatorPlayer:Play("close", arg_9_0._onCloseAreaFinish, arg_9_0)
		Activity187Controller.instance:finishPainting(arg_9_0.onPainFinish, arg_9_0)
	end

	arg_9_0._mouseMove = false

	TaskDispatcher.cancelTask(arg_9_0._checkMouseMove, arg_9_0)
end

function var_0_0._onCloseAreaFinish(arg_10_0)
	arg_10_0._writingBrush:Clear()
	gohelper.setActive(arg_10_0._gopaintingArea, false)
end

function var_0_0.onPainFinish(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == 0 then
		arg_11_0._rewardsMaterials = MaterialRpc.receiveMaterial({
			dataList = arg_11_3.randomBonusList
		})

		UIBlockMgr.instance:startBlock(Activity187Enum.BlockKey.GetPaintingReward)
		TaskDispatcher.cancelTask(arg_11_0._showMaterials, arg_11_0)
		TaskDispatcher.runDelay(arg_11_0._showMaterials, arg_11_0, var_0_1)
	end

	arg_11_0:setPaintStatus(Activity187Enum.PaintStatus.Finish)
end

function var_0_0._showMaterials(arg_12_0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_12_0._rewardsMaterials)

	arg_12_0._rewardsMaterials = nil

	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetPaintingReward)
end

function var_0_0._onDisplayChange(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._mouseMove = false

	if arg_13_1 then
		arg_13_0:ready2Paint(arg_13_2)
	else
		TaskDispatcher.cancelTask(arg_13_0._checkMouseMove, arg_13_0)
		arg_13_0:_playPaintingAudio(false)
		gohelper.setActive(arg_13_0._gopaintingArea, false)
	end
end

function var_0_0.ready2Paint(arg_14_0, arg_14_1)
	arg_14_0._curIndex = arg_14_1

	arg_14_0._writingBrush:OnMouseUp()

	if arg_14_0._rawimage.texture then
		arg_14_0._writingBrush:Clear()
	end

	arg_14_0:setPaintStatus(Activity187Enum.PaintStatus.Ready)
	arg_14_0._paintAreaAnimator:Play("idle", 0, 0)
end

function var_0_0._onOpenView(arg_15_0, arg_15_1)
	if arg_15_1 ~= ViewName.CommonPropView or not arg_15_0._waitOpenCommonProp then
		return
	end

	local var_15_0 = Activity187Enum.EmptyLantern
	local var_15_1
	local var_15_2 = Activity187Model.instance:getPaintingRewardId(arg_15_0._curIndex)

	if var_15_2 then
		local var_15_3 = Activity187Model.instance:getAct187Id()

		var_15_0 = Activity187Config.instance:getLantern(var_15_3, var_15_2)
		var_15_1 = Activity187Config.instance:getLanternRibbon(var_15_3, var_15_2)
	end

	arg_15_0._simagelantern:LoadImage(ResUrl.getAct184LanternIcon(var_15_0))

	for iter_15_0, iter_15_1 in pairs(arg_15_0._lowRibbonDict) do
		gohelper.setActive(iter_15_1, iter_15_0 == var_15_1)
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_0._upRibbonDict) do
		gohelper.setActive(iter_15_3, iter_15_2 == var_15_1)
	end

	arg_15_0._waitOpenCommonProp = nil
	arg_15_0._waitCloseCommonProp = true
end

function var_0_0._onCloseView(arg_16_0, arg_16_1)
	if arg_16_1 ~= ViewName.CommonPropView or not arg_16_0._waitCloseCommonProp then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_shuori_dreamsong_open)
	gohelper.setActive(arg_16_0._simagepicturebg, true)
	gohelper.setActive(arg_16_0._goriddles, true)

	arg_16_0._waitCloseCommonProp = nil
end

function var_0_0._editableInitView(arg_17_0)
	arg_17_0._writingBrush = arg_17_0._gopaintingArea:GetComponent(typeof(ZProj.WritingBrush))
	arg_17_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_17_0._gopaintingArea)
	arg_17_0._paintAreaAnimator = arg_17_0._gopaintingArea:GetComponent(typeof(UnityEngine.Animator))
	arg_17_0._paintAreaAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_17_0._gopaintingArea)
	arg_17_0._lowRibbonDict = arg_17_0:getUserDataTb_()
	arg_17_0._upRibbonDict = arg_17_0:getUserDataTb_()

	arg_17_0:_fillRibbonDict(arg_17_0._golowribbon.transform, arg_17_0._lowRibbonDict)
	arg_17_0:_fillRibbonDict(arg_17_0._goupribbon.transform, arg_17_0._upRibbonDict)

	arg_17_0._riddlesRewardItemList = {}

	gohelper.setActive(arg_17_0._goriddlesRewardItem, false)

	arg_17_0._rewardsMaterials = nil
	arg_17_0._status = nil
end

function var_0_0._fillRibbonDict(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1.childCount

	for iter_18_0 = 1, var_18_0 do
		local var_18_1 = arg_18_1:GetChild(iter_18_0 - 1)

		arg_18_2[var_18_1.name] = var_18_1
	end
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	return
end

function var_0_0.setPaintStatus(arg_21_0, arg_21_1)
	arg_21_0._status = arg_21_1
	arg_21_0._waitOpenCommonProp = nil
	arg_21_0._waitCloseCommonProp = nil

	local var_21_0 = arg_21_1 == Activity187Enum.PaintStatus.Ready
	local var_21_1 = arg_21_1 == Activity187Enum.PaintStatus.Finish

	arg_21_0:hideAllRiddlesRewardItem()

	if var_21_1 then
		local var_21_2 = Activity187Model.instance:getPaintingRewardId(arg_21_0._curIndex)

		if var_21_2 then
			arg_21_0._waitOpenCommonProp = true

			local var_21_3 = Activity187Model.instance:getAct187Id()
			local var_21_4 = Activity187Config.instance:getLanternImg(var_21_3, var_21_2)
			local var_21_5 = Activity187Config.instance:getLanternImgBg(var_21_3, var_21_2)

			arg_21_0._simagepicture:LoadImage(ResUrl.getAct184LanternIcon(var_21_4))
			arg_21_0._simagepicturebg:LoadImage(ResUrl.getAct184LanternIcon(var_21_5))

			arg_21_0._txtriddles.text = Activity187Config.instance:getBlessing(var_21_3, var_21_2)

			local var_21_6 = Activity187Model.instance:getPaintingRewardList(arg_21_0._curIndex)

			for iter_21_0, iter_21_1 in ipairs(var_21_6) do
				arg_21_0:getRiddlesRewardItem(iter_21_0).itemIcon:onUpdateMO(iter_21_1)
			end
		end
	end

	arg_21_0._simagelantern:LoadImage(ResUrl.getAct184LanternIcon(Activity187Enum.EmptyLantern))

	for iter_21_2, iter_21_3 in pairs(arg_21_0._lowRibbonDict) do
		gohelper.setActive(iter_21_3, false)
	end

	for iter_21_4, iter_21_5 in pairs(arg_21_0._upRibbonDict) do
		gohelper.setActive(iter_21_5, false)
	end

	if not var_21_1 then
		gohelper.setActive(arg_21_0._gopaintingArea, true)
		arg_21_0._paintAreaAnimator:Play("idle", 0, 1)
	end

	gohelper.setActive(arg_21_0._gopaintTips, var_21_0)
	gohelper.setActive(arg_21_0._btnclose, var_21_1)
	gohelper.setActive(arg_21_0._gofinishVx, var_21_1)
	gohelper.setActive(arg_21_0._simagepicturebg, false)
	gohelper.setActive(arg_21_0._goriddles, false)
end

function var_0_0.hideAllRiddlesRewardItem(arg_22_0)
	if not arg_22_0._riddlesRewardItemList then
		arg_22_0._riddlesRewardItemList = {}
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._riddlesRewardItemList) do
		gohelper.setActive(iter_22_1.go, false)
	end
end

function var_0_0.getRiddlesRewardItem(arg_23_0, arg_23_1)
	if not arg_23_0._riddlesRewardItemList then
		arg_23_0._riddlesRewardItemList = {}
	end

	local var_23_0 = arg_23_0._riddlesRewardItemList[arg_23_1]

	if not var_23_0 then
		var_23_0 = arg_23_0:getUserDataTb_()
		var_23_0.go = gohelper.clone(arg_23_0._goriddlesRewardItem, arg_23_0._goriddlesRewards, arg_23_1)

		local var_23_1 = gohelper.findChild(var_23_0.go, "#go_item")

		var_23_0.itemIcon = IconMgr.instance:getCommonItemIcon(var_23_1)

		var_23_0.itemIcon:setCountFontSize(40)

		arg_23_0._riddlesRewardItemList[arg_23_1] = var_23_0
	end

	gohelper.setActive(var_23_0.go, true)

	return var_23_0
end

function var_0_0.onClose(arg_24_0)
	arg_24_0._simagepicture:UnLoadImage()
	arg_24_0._simagepicturebg:UnLoadImage()
	arg_24_0._simagelantern:UnLoadImage()
	TaskDispatcher.cancelTask(arg_24_0._showMaterials, arg_24_0)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetPaintingReward)

	arg_24_0._rewardsMaterials = nil
	arg_24_0._status = nil
end

function var_0_0.onDestroyView(arg_25_0)
	return
end

return var_0_0
