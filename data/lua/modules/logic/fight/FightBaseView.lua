module("modules.logic.fight.FightBaseView", package.seeall)

local var_0_0 = class("FightBaseView", FightBaseClass)

var_0_0.IS_FIGHT_BASE_VIEW = true

function var_0_0.onConstructor(arg_1_0, ...)
	arg_1_0.inner_visible = true
	arg_1_0.viewGO = nil
	arg_1_0.viewContainer = nil
	arg_1_0.viewParam = nil
	arg_1_0.viewName = nil
	arg_1_0.PARENT_VIEW = nil
end

function var_0_0.setViewVisible(arg_2_0, arg_2_1)
	arg_2_0:setViewVisibleInternal(arg_2_1)
end

function var_0_0.setViewVisibleInternal(arg_3_0, arg_3_1)
	if arg_3_0.inner_visible == arg_3_1 then
		return
	end

	arg_3_0.inner_visible = arg_3_1

	if not arg_3_0.viewGO then
		return
	end

	arg_3_0.canvasGroup_internal = arg_3_0.canvasGroup_internal or gohelper.onceAddComponent(arg_3_0.viewGO, typeof(UnityEngine.CanvasGroup))
	arg_3_0.canvasGroup_internal.alpha = arg_3_1 and 1 or 0
	arg_3_0.canvasGroup_internal.interactable = arg_3_1
	arg_3_0.canvasGroup_internal.blocksRaycasts = arg_3_1
end

function var_0_0.inner_startView(arg_4_0)
	arg_4_0:onInitViewInternal()
	arg_4_0:addEventsInternal()
	arg_4_0:onOpenInternal()
	arg_4_0:onOpenFinishInternal()
end

function var_0_0.onInitViewInternal(arg_5_0)
	arg_5_0.INVOKED_OPEN_VIEW = true

	arg_5_0:onInitView()
end

function var_0_0.addEventsInternal(arg_6_0)
	arg_6_0:addEvents()
end

function var_0_0.onOpenInternal(arg_7_0)
	arg_7_0:onOpen()
end

function var_0_0.onOpenFinishInternal(arg_8_0)
	arg_8_0:onOpenFinish()
end

function var_0_0.onUpdateParamInternal(arg_9_0)
	arg_9_0:onUpdateParam()
end

function var_0_0.onClickModalMaskInternal(arg_10_0)
	arg_10_0:onClickModalMask()
end

function var_0_0.inner_destroyView(arg_11_0)
	arg_11_0:onCloseInternal()
	arg_11_0:onCloseFinishInternal()
	arg_11_0:removeEventsInternal()
	arg_11_0:onDestroyViewInternal()
end

function var_0_0.onCloseInternal(arg_12_0)
	arg_12_0:onClose()
end

function var_0_0.onCloseFinishInternal(arg_13_0)
	arg_13_0:onCloseFinish()
end

function var_0_0.removeEventsInternal(arg_14_0)
	arg_14_0:removeEvents()
end

function var_0_0.onDestroyViewInternal(arg_15_0)
	arg_15_0:onDestroyView()

	arg_15_0.INVOKED_DESTROY_VIEW = true
end

function var_0_0.onDestructor(arg_16_0)
	if arg_16_0.INVOKED_OPEN_VIEW and not arg_16_0.INVOKED_DESTROY_VIEW then
		arg_16_0:killComponent(FightViewComponent)
		arg_16_0:inner_destroyView()
	end
end

function var_0_0.__onInit(arg_17_0)
	return
end

function var_0_0.__onDispose(arg_18_0)
	arg_18_0:disposeSelf()
end

function var_0_0.onInitView(arg_19_0)
	return
end

function var_0_0.addEvents(arg_20_0)
	return
end

function var_0_0.onOpen(arg_21_0)
	return
end

function var_0_0.onOpenFinish(arg_22_0)
	return
end

function var_0_0.onUpdateParam(arg_23_0)
	return
end

function var_0_0.onClickModalMask(arg_24_0)
	return
end

function var_0_0.onClose(arg_25_0)
	return
end

function var_0_0.onCloseFinish(arg_26_0)
	return
end

function var_0_0.removeEvents(arg_27_0)
	return
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

function var_0_0.getResInst(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	return arg_29_0.viewContainer:getResInst(arg_29_1, arg_29_2, arg_29_3)
end

function var_0_0.closeThis(arg_30_0)
	ViewMgr.instance:closeView(arg_30_0.viewName, nil, true)
end

function var_0_0.tryCallMethodName(arg_31_0, arg_31_1)
	if arg_31_1 == "__onDispose" then
		arg_31_0:__onDispose()
	end
end

function var_0_0.isHasTryCallFail(arg_32_0)
	return false
end

function var_0_0.com_createObjList(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	if type(arg_33_2) == "number" then
		local var_33_0 = arg_33_2

		arg_33_2 = {}

		for iter_33_0 = 1, var_33_0 do
			table.insert(arg_33_2, iter_33_0)
		end
	end

	gohelper.CreateObjList(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
end

function var_0_0.addEventCb(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	arg_34_0:getComponent(FightEventComponent):registEvent(arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
end

function var_0_0.removeEventCb(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	if not arg_35_1 or not arg_35_2 or not arg_35_3 then
		logError("UserDataDispose:removeEventCb ctrlInstance or evtName or callback is null!")

		return
	end

	arg_35_0:getComponent(FightEventComponent):cancelEvent(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
end

function var_0_0.com_registViewItemList(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	return arg_36_0:getComponent(FightObjItemListComponent):registViewItemList(arg_36_1, arg_36_2, arg_36_3)
end

function var_0_0.com_openSubView(arg_37_0, arg_37_1, arg_37_2, arg_37_3, ...)
	return arg_37_0:getComponent(FightViewComponent):openSubView(arg_37_1, arg_37_2, arg_37_3, ...)
end

function var_0_0.com_openSubViewForBaseView(arg_38_0, arg_38_1, arg_38_2, ...)
	return arg_38_0:getComponent(FightViewComponent):openSubViewForBaseView(arg_38_1, arg_38_2, ...)
end

function var_0_0.com_openExclusiveView(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, ...)
	return arg_39_0:getComponent(FightViewComponent):openExclusiveView(arg_39_1, arg_39_2, arg_39_3, arg_39_4, ...)
end

function var_0_0.com_hideExclusiveGroup(arg_40_0, arg_40_1)
	return arg_40_0:getComponent(FightViewComponent):hideExclusiveGroup(arg_40_1)
end

function var_0_0.com_hideExclusiveView(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	return arg_41_0:getComponent(FightViewComponent):hideExclusiveView(arg_41_1, arg_41_2, arg_41_3)
end

function var_0_0.com_setExclusiveViewVisible(arg_42_0, arg_42_1, arg_42_2)
	return arg_42_0:getComponent(FightViewComponent):setExclusiveViewVisible(arg_42_1, arg_42_2)
end

function var_0_0.com_registClick(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	return arg_43_0:getComponent(FightClickComponent):registClick(arg_43_1, arg_43_2, arg_43_0, arg_43_3)
end

function var_0_0.com_removeClick(arg_44_0, arg_44_1)
	return arg_44_0:getComponent(FightClickComponent):removeClick(arg_44_1)
end

function var_0_0.com_registDragBegin(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	return arg_45_0:getComponent(FightDragComponent):registDragBegin(arg_45_1, arg_45_2, arg_45_0, arg_45_3)
end

function var_0_0.com_registDrag(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	return arg_46_0:getComponent(FightDragComponent):registDrag(arg_46_1, arg_46_2, arg_46_0, arg_46_3)
end

function var_0_0.com_registDragEnd(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	return arg_47_0:getComponent(FightDragComponent):registDragEnd(arg_47_1, arg_47_2, arg_47_0, arg_47_3)
end

function var_0_0.com_registLongPress(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	return arg_48_0:getComponent(FightLongPressComponent):registLongPress(arg_48_1, arg_48_2, arg_48_0, arg_48_3)
end

function var_0_0.com_registHover(arg_49_0, arg_49_1, arg_49_2)
	return arg_49_0:getComponent(FightLongPressComponent):registHover(arg_49_1, arg_49_2, arg_49_0)
end

function var_0_0.com_killTween(arg_50_0, arg_50_1)
	if not arg_50_1 then
		return
	end

	return arg_50_0:getComponent(FightTweenComponent):killTween(arg_50_1)
end

function var_0_0.com_KillTweenByObj(arg_51_0, arg_51_1, arg_51_2)
	return arg_51_0:getComponent(FightTweenComponent):KillTweenByObj(arg_51_1, arg_51_2)
end

function var_0_0.com_scrollNumTween(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	return arg_52_0:getComponent(FightTweenComponent):scrollNumTween(arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
end

return var_0_0
