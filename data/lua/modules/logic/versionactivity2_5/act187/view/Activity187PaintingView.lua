module("modules.logic.versionactivity2_5.act187.view.Activity187PaintingView", package.seeall)

slot0 = class("Activity187PaintingView", BaseView)
slot1 = 1
slot2 = 0.3

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "v2a5_lanternfestivalpainting/#btn_close")
	slot0._golowribbon = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#go_decorationLower")
	slot0._simagelantern = gohelper.findChildSingleImage(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern")
	slot0._goupribbon = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#go_decorationUpper")
	slot0._simagepicturebg = gohelper.findChildSingleImage(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#simage_pictureshadow")
	slot0._simagepicture = gohelper.findChildSingleImage(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#simage_pictureshadow/#simage_picture")
	slot0._goriddles = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles")
	slot0._txtriddles = gohelper.findChildText(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#txt_riddles")
	slot0._goriddlesRewards = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#go_riddlesRewards")
	slot0._goriddlesRewardItem = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#go_riddlesRewards/#go_riddlesRewardItem")
	slot0._gopaintTips = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#go_paintTips")
	slot0._gopaintingArea = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/#go_paintingArea")
	slot0._gofinishVx = gohelper.findChild(slot0.viewGO, "v2a5_lanternfestivalpainting/vx_finish")
	slot0._rawimage = slot0._gopaintingArea:GetComponent(gohelper.Type_RawImage)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0:addEventCb(Activity187Controller.instance, Activity187Event.PaintViewDisplayChange, slot0._onDisplayChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
	slot0:removeEventCb(Activity187Controller.instance, Activity187Event.PaintViewDisplayChange, slot0._onDisplayChange, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0.viewContainer:setPaintingViewDisplay()
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if slot0._status == Activity187Enum.PaintStatus.Finish then
		return
	end

	slot0:setPaintStatus(Activity187Enum.PaintStatus.Painting)
	slot0:_onDrag(slot1, slot2)
	TaskDispatcher.cancelTask(slot0._checkMouseMove, slot0)
	TaskDispatcher.runRepeat(slot0._checkMouseMove, slot0, uv0)
end

function slot0._onDrag(slot0, slot1, slot2)
	if slot0._status == Activity187Enum.PaintStatus.Finish then
		return
	end

	slot0._mouseMove = true

	slot0:_playPaintingAudio(true)
	slot0._writingBrush:OnMouseMove(slot2.position.x, slot2.position.y)
end

function slot0._checkMouseMove(slot0)
	if not slot0._mouseMove then
		slot0:_playPaintingAudio(false)
	end

	slot0._mouseMove = false
end

function slot0._playPaintingAudio(slot0, slot1)
	if slot0._isPlayPaintingAudio == slot1 then
		return
	end

	AudioMgr.instance:trigger(slot1 and AudioEnum.Act187.play_ui_tangren_yuanxiao_draw_loop or AudioEnum.Act187.stop_ui_tangren_yuanxiao_draw_loop)

	slot0._isPlayPaintingAudio = slot1
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0:_playPaintingAudio(false)

	if slot0._status == Activity187Enum.PaintStatus.Finish then
		return
	end

	slot0._writingBrush:OnMouseUp()

	if slot0.viewContainer:isShowPaintView() then
		slot0._paintAreaAnimatorPlayer:Play("close", slot0._onCloseAreaFinish, slot0)
		Activity187Controller.instance:finishPainting(slot0.onPainFinish, slot0)
	end

	slot0._mouseMove = false

	TaskDispatcher.cancelTask(slot0._checkMouseMove, slot0)
end

function slot0._onCloseAreaFinish(slot0)
	slot0._writingBrush:Clear()
	gohelper.setActive(slot0._gopaintingArea, false)
end

function slot0.onPainFinish(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0._rewardsMaterials = MaterialRpc.receiveMaterial({
			dataList = slot3.randomBonusList
		})

		UIBlockMgr.instance:startBlock(Activity187Enum.BlockKey.GetPaintingReward)
		TaskDispatcher.cancelTask(slot0._showMaterials, slot0)
		TaskDispatcher.runDelay(slot0._showMaterials, slot0, uv0)
	end

	slot0:setPaintStatus(Activity187Enum.PaintStatus.Finish)
end

function slot0._showMaterials(slot0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot0._rewardsMaterials)

	slot0._rewardsMaterials = nil

	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetPaintingReward)
end

function slot0._onDisplayChange(slot0, slot1, slot2)
	slot0._mouseMove = false

	if slot1 then
		slot0:ready2Paint(slot2)
	else
		TaskDispatcher.cancelTask(slot0._checkMouseMove, slot0)
		slot0:_playPaintingAudio(false)
		gohelper.setActive(slot0._gopaintingArea, false)
	end
end

function slot0.ready2Paint(slot0, slot1)
	slot0._curIndex = slot1

	slot0._writingBrush:OnMouseUp()

	if slot0._rawimage.texture then
		slot0._writingBrush:Clear()
	end

	slot0:setPaintStatus(Activity187Enum.PaintStatus.Ready)
	slot0._paintAreaAnimator:Play("idle", 0, 0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 ~= ViewName.CommonPropView or not slot0._waitOpenCommonProp then
		return
	end

	slot2 = Activity187Enum.EmptyLantern
	slot3 = nil

	if Activity187Model.instance:getPaintingRewardId(slot0._curIndex) then
		slot5 = Activity187Model.instance:getAct187Id()
		slot2 = Activity187Config.instance:getLantern(slot5, slot4)
		slot3 = Activity187Config.instance:getLanternRibbon(slot5, slot4)
	end

	slot8 = slot2

	slot0._simagelantern:LoadImage(ResUrl.getAct184LanternIcon(slot8))

	for slot8, slot9 in pairs(slot0._lowRibbonDict) do
		gohelper.setActive(slot9, slot8 == slot3)
	end

	for slot8, slot9 in pairs(slot0._upRibbonDict) do
		gohelper.setActive(slot9, slot8 == slot3)
	end

	slot0._waitOpenCommonProp = nil
	slot0._waitCloseCommonProp = true
end

function slot0._onCloseView(slot0, slot1)
	if slot1 ~= ViewName.CommonPropView or not slot0._waitCloseCommonProp then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_shuori_dreamsong_open)
	gohelper.setActive(slot0._simagepicturebg, true)
	gohelper.setActive(slot0._goriddles, true)

	slot0._waitCloseCommonProp = nil
end

function slot0._editableInitView(slot0)
	slot0._writingBrush = slot0._gopaintingArea:GetComponent(typeof(ZProj.WritingBrush))
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gopaintingArea)
	slot0._paintAreaAnimator = slot0._gopaintingArea:GetComponent(typeof(UnityEngine.Animator))
	slot0._paintAreaAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._gopaintingArea)
	slot0._lowRibbonDict = slot0:getUserDataTb_()
	slot0._upRibbonDict = slot0:getUserDataTb_()

	slot0:_fillRibbonDict(slot0._golowribbon.transform, slot0._lowRibbonDict)
	slot0:_fillRibbonDict(slot0._goupribbon.transform, slot0._upRibbonDict)

	slot0._riddlesRewardItemList = {}

	gohelper.setActive(slot0._goriddlesRewardItem, false)

	slot0._rewardsMaterials = nil
	slot0._status = nil
end

function slot0._fillRibbonDict(slot0, slot1, slot2)
	for slot7 = 1, slot1.childCount do
		slot8 = slot1:GetChild(slot7 - 1)
		slot2[slot8.name] = slot8
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.setPaintStatus(slot0, slot1)
	slot0._status = slot1
	slot0._waitOpenCommonProp = nil
	slot0._waitCloseCommonProp = nil
	slot2 = slot1 == Activity187Enum.PaintStatus.Ready

	slot0:hideAllRiddlesRewardItem()

	if slot1 == Activity187Enum.PaintStatus.Finish and Activity187Model.instance:getPaintingRewardId(slot0._curIndex) then
		slot0._waitOpenCommonProp = true
		slot5 = Activity187Model.instance:getAct187Id()

		slot0._simagepicture:LoadImage(ResUrl.getAct184LanternIcon(Activity187Config.instance:getLanternImg(slot5, slot4)))
		slot0._simagepicturebg:LoadImage(ResUrl.getAct184LanternIcon(Activity187Config.instance:getLanternImgBg(slot5, slot4)))

		slot12 = slot4
		slot0._txtriddles.text = Activity187Config.instance:getBlessing(slot5, slot12)

		for slot12, slot13 in ipairs(Activity187Model.instance:getPaintingRewardList(slot0._curIndex)) do
			slot0:getRiddlesRewardItem(slot12).itemIcon:onUpdateMO(slot13)
		end
	end

	slot7 = Activity187Enum.EmptyLantern

	slot0._simagelantern:LoadImage(ResUrl.getAct184LanternIcon(slot7))

	for slot7, slot8 in pairs(slot0._lowRibbonDict) do
		gohelper.setActive(slot8, false)
	end

	for slot7, slot8 in pairs(slot0._upRibbonDict) do
		gohelper.setActive(slot8, false)
	end

	if not slot3 then
		gohelper.setActive(slot0._gopaintingArea, true)
		slot0._paintAreaAnimator:Play("idle", 0, 1)
	end

	gohelper.setActive(slot0._gopaintTips, slot2)
	gohelper.setActive(slot0._btnclose, slot3)
	gohelper.setActive(slot0._gofinishVx, slot3)
	gohelper.setActive(slot0._simagepicturebg, false)
	gohelper.setActive(slot0._goriddles, false)
end

function slot0.hideAllRiddlesRewardItem(slot0)
	if not slot0._riddlesRewardItemList then
		slot0._riddlesRewardItemList = {}
	end

	for slot4, slot5 in ipairs(slot0._riddlesRewardItemList) do
		gohelper.setActive(slot5.go, false)
	end
end

function slot0.getRiddlesRewardItem(slot0, slot1)
	if not slot0._riddlesRewardItemList then
		slot0._riddlesRewardItemList = {}
	end

	if not slot0._riddlesRewardItemList[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.clone(slot0._goriddlesRewardItem, slot0._goriddlesRewards, slot1)
		slot2.itemIcon = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot2.go, "#go_item"))

		slot2.itemIcon:setCountFontSize(40)

		slot0._riddlesRewardItemList[slot1] = slot2
	end

	gohelper.setActive(slot2.go, true)

	return slot2
end

function slot0.onClose(slot0)
	slot0._simagepicture:UnLoadImage()
	slot0._simagepicturebg:UnLoadImage()
	slot0._simagelantern:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._showMaterials, slot0)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetPaintingReward)

	slot0._rewardsMaterials = nil
	slot0._status = nil
end

function slot0.onDestroyView(slot0)
end

return slot0
