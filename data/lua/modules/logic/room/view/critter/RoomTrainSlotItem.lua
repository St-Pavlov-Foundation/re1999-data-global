module("modules.logic.room.view.critter.RoomTrainSlotItem", package.seeall)

local var_0_0 = class("RoomTrainSlotItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goadd = gohelper.findChild(arg_1_0.viewGO, "#go_add")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_unlock")
	arg_1_0._gocrittenIcon = gohelper.findChild(arg_1_0.viewGO, "#go_unlock/#go_crittenIcon")
	arg_1_0._simageheroIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_unlock/#simage_heroIcon")
	arg_1_0._simagetotalBarValue = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_unlock/ProgressBg/#simage_totalBarValue")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_unlock/#go_select")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_unlock/#go_finish")
	arg_1_0._gobubble = gohelper.findChild(arg_1_0.viewGO, "#go_unlock/#go_bubble")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickitemOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickitemOnClick(arg_4_0)
	if arg_4_0._view and arg_4_0._view.viewContainer then
		if not arg_4_0._slotMO or arg_4_0._slotMO.isLock then
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)

			return
		end

		arg_4_0._view.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, arg_4_0:getDataMO())
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._imageTrainBarValue = gohelper.findChildImage(arg_5_0.viewGO, "#go_unlock/ProgressBg/#simage_totalBarValue")
end

function var_0_0._editableAddEvents(arg_6_0)
	if arg_6_0._view and arg_6_0._view.viewContainer then
		arg_6_0._view.viewContainer:registerCallback(CritterEvent.UITrainCdTime, arg_6_0._opTranCdTimeUpdate, arg_6_0)
	end
end

function var_0_0._editableRemoveEvents(arg_7_0)
	if arg_7_0._view and arg_7_0._view.viewContainer then
		arg_7_0._view.viewContainer:unregisterCallback(CritterEvent.UITrainCdTime, arg_7_0._opTranCdTimeUpdate, arg_7_0)
	end
end

function var_0_0.getDataMO(arg_8_0)
	return arg_8_0._slotMO
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._slotMO = arg_9_1

	arg_9_0:refreshUI()
end

function var_0_0._opTranCdTimeUpdate(arg_10_0)
	arg_10_0:_refreshTrainProgressUI()
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goselect, arg_11_1)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

function var_0_0.refreshUI(arg_13_0)
	local var_13_0 = arg_13_0._slotMO.isLock
	local var_13_1 = arg_13_0._slotMO.critterMO ~= nil

	gohelper.setActive(arg_13_0._golock, var_13_0)
	gohelper.setActive(arg_13_0._goadd, not var_13_1)
	gohelper.setActive(arg_13_0._gounlock, not var_13_0 and var_13_1)

	if not var_13_0 and var_13_1 then
		arg_13_0:_refreshCritterUI()
		arg_13_0:_refreshTrainProgressUI()
	end

	local var_13_2 = not var_13_0 and arg_13_0._slotMO.id == 1

	gohelper.setActive(arg_13_0._goreddot, var_13_2)

	if var_13_2 then
		RedDotController.instance:addRedDot(arg_13_0._goreddot, RedDotEnum.DotNode.RoomCritterTrainOcne)
	end
end

function var_0_0._refreshCritterUI(arg_14_0)
	local var_14_0 = arg_14_0._slotMO.critterMO

	if var_14_0 then
		if not arg_14_0.critterIcon then
			arg_14_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_14_0._gocrittenIcon)
		end

		arg_14_0.critterIcon:setMOValue(var_14_0:getId(), var_14_0:getDefineId())

		local var_14_1 = HeroModel.instance:getByHeroId(var_14_0.trainInfo.heroId)
		local var_14_2 = var_14_1 and SkinConfig.instance:getSkinCo(var_14_1.skin)

		if var_14_2 then
			arg_14_0._simageheroIcon:LoadImage(ResUrl.getRoomHeadIcon(var_14_2.headIcon))
		end
	end
end

function var_0_0._refreshTrainProgressUI(arg_15_0)
	local var_15_0 = arg_15_0._slotMO and arg_15_0._slotMO.critterMO

	if var_15_0 and var_15_0.trainInfo then
		local var_15_1 = var_15_0.trainInfo

		gohelper.setActive(arg_15_0._gofinish, var_15_0.trainInfo:isTrainFinish())
		gohelper.setActive(arg_15_0._gobubble, var_15_0.trainInfo:isHasEventTrigger())

		local var_15_2 = var_15_1:getProcess()
		local var_15_3 = 0.05
		local var_15_4 = 0.638

		arg_15_0._imageTrainBarValue.fillAmount = var_15_3 + var_15_2 * (var_15_4 - var_15_3)
	end
end

var_0_0.prefabPath = "ui/viewres/room/critter/roomtrainslotitem.prefab"

return var_0_0
