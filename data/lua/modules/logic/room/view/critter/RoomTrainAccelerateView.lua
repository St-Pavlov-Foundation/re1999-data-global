module("modules.logic.room.view.critter.RoomTrainAccelerateView", package.seeall)

local var_0_0 = class("RoomTrainAccelerateView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "itemArea/#simage_bg")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "itemArea/#scroll_item")
	arg_1_0._goaccelerateItem = gohelper.findChild(arg_1_0.viewGO, "itemArea/#scroll_item/viewport/content/#go_accelerateItem")
	arg_1_0._godetailitemtab = gohelper.findChild(arg_1_0.viewGO, "#go_detailitemtab")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._previewForwardTime = 0
	arg_5_0._gocontent = gohelper.findChild(arg_5_0.viewGO, "itemArea/#scroll_item/viewport/content")

	local var_5_0 = arg_5_0:getResInst(RoomCritterTrainDetailItem.prefabPath, arg_5_0._godetailitemtab)

	arg_5_0.detailItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0, RoomCritterTrainDetailItem, arg_5_0)

	arg_5_0.detailItem:setFinishCallback(arg_5_0._btncloseOnClick, arg_5_0)

	local var_5_1 = gohelper.findChild(var_5_0, "TrainProgress")

	recthelper.setAnchorY(var_5_1.transform, -120)

	arg_5_0.detailItem.addBarValue = gohelper.findChildImage(var_5_0, "TrainProgress/ProgressBg/#bar_add")
	arg_5_0.detailItem.gohasten = gohelper.findChild(var_5_0, "TrainProgress/ProgressBg/#image_totalBarValue/hasten")

	gohelper.setActive(arg_5_0.detailItem.addBarValue, true)
	arg_5_0.detailItem:setShowStateInfo(false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._critterUid = arg_7_0.viewParam and arg_7_0.viewParam.critterUid
	arg_7_0._critterMO = CritterModel.instance:getCritterMOByUid(arg_7_0._critterUid)

	if not arg_7_0._critterMO then
		arg_7_0:closeThis()

		return
	end

	if arg_7_0.viewContainer then
		arg_7_0:addEventCb(arg_7_0.viewContainer, CritterEvent.UITrainCdTime, arg_7_0._opTranCdTimeUpdate, arg_7_0)
	end

	arg_7_0:addEventCb(CritterController.instance, CritterEvent.FastForwardTrainReply, arg_7_0._onForwardTrainReply, arg_7_0)
	arg_7_0.detailItem:onUpdateMO(arg_7_0._critterMO)
	TaskDispatcher.cancelTask(arg_7_0._onRunCdTimeTask, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0._onRunCdTimeTask, arg_7_0, 1)
	arg_7_0:setAccelerateItemList()
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onRunCdTimeTask, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0.detailItem:onDestroy()

	if arg_9_0._fadeInTweenId then
		ZProj.TweenHelper.KillById(arg_9_0._fadeInTweenId)

		arg_9_0._fadeInTweenId = nil
	end
end

function var_0_0._onRunCdTimeTask(arg_10_0)
	if arg_10_0.viewContainer and arg_10_0.viewContainer:isOpen() then
		arg_10_0.viewContainer:dispatchEvent(CritterEvent.UITrainCdTime)
	else
		TaskDispatcher.cancelTask(arg_10_0._onRunCdTimeTask, arg_10_0)
	end
end

function var_0_0._opTranCdTimeUpdate(arg_11_0)
	if arg_11_0._isPlayBarAnim then
		return
	end

	if not arg_11_0._critterMO or arg_11_0._critterMO:isMaturity() or arg_11_0._critterMO.trainInfo:isTrainFinish() then
		arg_11_0:closeThis()

		return
	end

	arg_11_0.detailItem:tranCdTimeUpdate()

	arg_11_0.detailItem.addBarValue.fillAmount = arg_11_0:getPreviewPross()
end

function var_0_0._onForwardTrainReply(arg_12_0)
	if arg_12_0._critterMO and arg_12_0._critterMO.trainInfo then
		arg_12_0._isPlayBarAnim = true

		local var_12_0 = arg_12_0.detailItem:getBarValue()
		local var_12_1 = arg_12_0._critterMO.trainInfo:getProcess()

		if arg_12_0._fadeInTweenId then
			ZProj.TweenHelper.KillById(arg_12_0._fadeInTweenId)

			arg_12_0._fadeInTweenId = nil
		end

		gohelper.setActive(arg_12_0.detailItem.gohasten, false)
		gohelper.setActive(arg_12_0.detailItem.gohasten, true)

		arg_12_0._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(var_12_0, var_12_1, 0.5, arg_12_0._fadeUpdate, arg_12_0._fadeInFinished, arg_12_0, nil, EaseType.Linear)
	else
		arg_12_0:_opTranCdTimeUpdate()
	end

	arg_12_0.viewContainer:dispatchEvent(CritterEvent.FastForwardTrainReply)
end

function var_0_0._fadeUpdate(arg_13_0, arg_13_1)
	arg_13_0.detailItem:setBarValue(arg_13_1)
end

function var_0_0._fadeInFinished(arg_14_0)
	arg_14_0._isPlayBarAnim = false

	arg_14_0:_opTranCdTimeUpdate()
end

function var_0_0.setPreviewForwardTime(arg_15_0, arg_15_1)
	arg_15_0._previewForwardTime = arg_15_1

	if not arg_15_0._isPlayBarAnim then
		arg_15_0.detailItem.addBarValue.fillAmount = arg_15_0:getPreviewPross()
	end
end

function var_0_0.getPreviewPross(arg_16_0)
	if arg_16_0._critterMO and arg_16_0._critterMO.trainInfo then
		local var_16_0 = arg_16_0._critterMO.trainInfo:getProcessTime() + arg_16_0._previewForwardTime
		local var_16_1 = arg_16_0._critterMO.trainInfo.trainTime

		if var_16_1 > 0 and var_16_0 > 0 then
			if var_16_1 < var_16_0 then
				return 1
			end

			return var_16_0 / var_16_1
		end
	end

	return 0
end

function var_0_0.setAccelerateItemList(arg_17_0)
	local var_17_0 = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.CritterAccelerateItem)

	gohelper.CreateObjList(arg_17_0, arg_17_0._onSetAccelerateItem, var_17_0, arg_17_0._gocontent, arg_17_0._goaccelerateItem, RoomTrainAccelerateItem)
end

function var_0_0._onSetAccelerateItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_1._view == nil then
		arg_18_1._view = arg_18_0

		arg_18_1:_editableAddEvents()
	end

	arg_18_1:setData(arg_18_0._critterUid, arg_18_2.id)
end

return var_0_0
