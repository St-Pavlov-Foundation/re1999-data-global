module("modules.logic.room.view.critter.RoomTrainAccelerateView", package.seeall)

slot0 = class("RoomTrainAccelerateView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "itemArea/#simage_bg")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "itemArea/#scroll_item")
	slot0._goaccelerateItem = gohelper.findChild(slot0.viewGO, "itemArea/#scroll_item/viewport/content/#go_accelerateItem")
	slot0._godetailitemtab = gohelper.findChild(slot0.viewGO, "#go_detailitemtab")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._previewForwardTime = 0
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "itemArea/#scroll_item/viewport/content")
	slot1 = slot0:getResInst(RoomCritterTrainDetailItem.prefabPath, slot0._godetailitemtab)
	slot0.detailItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot1, RoomCritterTrainDetailItem, slot0)

	slot0.detailItem:setFinishCallback(slot0._btncloseOnClick, slot0)
	recthelper.setAnchorY(gohelper.findChild(slot1, "TrainProgress").transform, -120)

	slot0.detailItem.addBarValue = gohelper.findChildImage(slot1, "TrainProgress/ProgressBg/#bar_add")
	slot0.detailItem.gohasten = gohelper.findChild(slot1, "TrainProgress/ProgressBg/#image_totalBarValue/hasten")

	gohelper.setActive(slot0.detailItem.addBarValue, true)
	slot0.detailItem:setShowStateInfo(false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._critterUid = slot0.viewParam and slot0.viewParam.critterUid
	slot0._critterMO = CritterModel.instance:getCritterMOByUid(slot0._critterUid)

	if not slot0._critterMO then
		slot0:closeThis()

		return
	end

	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainCdTime, slot0._opTranCdTimeUpdate, slot0)
	end

	slot0:addEventCb(CritterController.instance, CritterEvent.FastForwardTrainReply, slot0._onForwardTrainReply, slot0)
	slot0.detailItem:onUpdateMO(slot0._critterMO)
	TaskDispatcher.cancelTask(slot0._onRunCdTimeTask, slot0)
	TaskDispatcher.runRepeat(slot0._onRunCdTimeTask, slot0, 1)
	slot0:setAccelerateItemList()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRunCdTimeTask, slot0)
end

function slot0.onDestroyView(slot0)
	slot0.detailItem:onDestroy()

	if slot0._fadeInTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeInTweenId)

		slot0._fadeInTweenId = nil
	end
end

function slot0._onRunCdTimeTask(slot0)
	if slot0.viewContainer and slot0.viewContainer:isOpen() then
		slot0.viewContainer:dispatchEvent(CritterEvent.UITrainCdTime)
	else
		TaskDispatcher.cancelTask(slot0._onRunCdTimeTask, slot0)
	end
end

function slot0._opTranCdTimeUpdate(slot0)
	if slot0._isPlayBarAnim then
		return
	end

	if not slot0._critterMO or slot0._critterMO:isMaturity() or slot0._critterMO.trainInfo:isTrainFinish() then
		slot0:closeThis()

		return
	end

	slot0.detailItem:tranCdTimeUpdate()

	slot0.detailItem.addBarValue.fillAmount = slot0:getPreviewPross()
end

function slot0._onForwardTrainReply(slot0)
	if slot0._critterMO and slot0._critterMO.trainInfo then
		slot0._isPlayBarAnim = true
		slot1 = slot0.detailItem:getBarValue()
		slot2 = slot0._critterMO.trainInfo:getProcess()

		if slot0._fadeInTweenId then
			ZProj.TweenHelper.KillById(slot0._fadeInTweenId)

			slot0._fadeInTweenId = nil
		end

		gohelper.setActive(slot0.detailItem.gohasten, false)
		gohelper.setActive(slot0.detailItem.gohasten, true)

		slot0._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(slot1, slot2, 0.5, slot0._fadeUpdate, slot0._fadeInFinished, slot0, nil, EaseType.Linear)
	else
		slot0:_opTranCdTimeUpdate()
	end

	slot0.viewContainer:dispatchEvent(CritterEvent.FastForwardTrainReply)
end

function slot0._fadeUpdate(slot0, slot1)
	slot0.detailItem:setBarValue(slot1)
end

function slot0._fadeInFinished(slot0)
	slot0._isPlayBarAnim = false

	slot0:_opTranCdTimeUpdate()
end

function slot0.setPreviewForwardTime(slot0, slot1)
	slot0._previewForwardTime = slot1

	if not slot0._isPlayBarAnim then
		slot0.detailItem.addBarValue.fillAmount = slot0:getPreviewPross()
	end
end

function slot0.getPreviewPross(slot0)
	if slot0._critterMO and slot0._critterMO.trainInfo then
		slot1 = slot0._critterMO.trainInfo:getProcessTime() + slot0._previewForwardTime

		if slot0._critterMO.trainInfo.trainTime > 0 and slot1 > 0 then
			if slot2 < slot1 then
				return 1
			end

			return slot1 / slot2
		end
	end

	return 0
end

function slot0.setAccelerateItemList(slot0)
	gohelper.CreateObjList(slot0, slot0._onSetAccelerateItem, ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.CritterAccelerateItem), slot0._gocontent, slot0._goaccelerateItem, RoomTrainAccelerateItem)
end

function slot0._onSetAccelerateItem(slot0, slot1, slot2, slot3)
	if slot1._view == nil then
		slot1._view = slot0

		slot1:_editableAddEvents()
	end

	slot1:setData(slot0._critterUid, slot2.id)
end

return slot0
