module("modules.logic.fight.FightBaseView", package.seeall)

local var_0_0 = class("FightBaseView", FightBaseClass)

var_0_0.IS_FIGHT_BASE_VIEW = true

function var_0_0.onConstructor(arg_1_0, ...)
	arg_1_0.inner_visible = true
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
		arg_16_0:killMyComponent(FightViewComponent)
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

function var_0_0.com_registViewItemList(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	return arg_33_0:getComponent(FightObjItemListComponent):registViewItemList(arg_33_1, arg_33_2, arg_33_3)
end

function var_0_0.com_openSubView(arg_34_0, arg_34_1, arg_34_2, arg_34_3, ...)
	return arg_34_0:getComponent(FightViewComponent):openSubView(arg_34_1, arg_34_2, arg_34_3, ...)
end

function var_0_0.com_openSubViewForBaseView(arg_35_0, arg_35_1, arg_35_2, ...)
	return arg_35_0:getComponent(FightViewComponent):openSubViewForBaseView(arg_35_1, arg_35_2, ...)
end

function var_0_0.com_openExclusiveView(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, ...)
	return arg_36_0:getComponent(FightViewComponent):openExclusiveView(arg_36_1, arg_36_2, arg_36_3, arg_36_4, ...)
end

function var_0_0.com_hideExclusiveGroup(arg_37_0, arg_37_1)
	return arg_37_0:getComponent(FightViewComponent):hideExclusiveGroup(arg_37_1)
end

function var_0_0.com_hideExclusiveView(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	return arg_38_0:getComponent(FightViewComponent):hideExclusiveView(arg_38_1, arg_38_2, arg_38_3)
end

function var_0_0.com_setExclusiveViewVisible(arg_39_0, arg_39_1, arg_39_2)
	return arg_39_0:getComponent(FightViewComponent):setExclusiveViewVisible(arg_39_1, arg_39_2)
end

function var_0_0.com_registClick(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	return arg_40_0:getComponent(FightClickComponent):registClick(arg_40_1, arg_40_2, arg_40_0, arg_40_3)
end

function var_0_0.com_removeClick(arg_41_0, arg_41_1)
	return arg_41_0:getComponent(FightClickComponent):removeClick(arg_41_1)
end

function var_0_0.com_registDragBegin(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	return arg_42_0:getComponent(FightDragComponent):registDragBegin(arg_42_1, arg_42_2, arg_42_0, arg_42_3)
end

function var_0_0.com_registDrag(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	return arg_43_0:getComponent(FightDragComponent):registDrag(arg_43_1, arg_43_2, arg_43_0, arg_43_3)
end

function var_0_0.com_registDragEnd(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	return arg_44_0:getComponent(FightDragComponent):registDragEnd(arg_44_1, arg_44_2, arg_44_0, arg_44_3)
end

function var_0_0.com_registLongPress(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	return arg_45_0:getComponent(FightLongPressComponent):registLongPress(arg_45_1, arg_45_2, arg_45_0, arg_45_3)
end

function var_0_0.com_registHover(arg_46_0, arg_46_1, arg_46_2)
	return arg_46_0:getComponent(FightLongPressComponent):registHover(arg_46_1, arg_46_2, arg_46_0)
end

function var_0_0.com_playTween(arg_47_0, arg_47_1, ...)
	return arg_47_0:getComponent(FightTweenComponent):playTween(arg_47_1, ...)
end

function var_0_0.com_killTween(arg_48_0, arg_48_1)
	if not arg_48_1 then
		return
	end

	return arg_48_0:getComponent(FightTweenComponent):killTween(arg_48_1)
end

function var_0_0.com_KillTweenByObj(arg_49_0, arg_49_1, arg_49_2)
	return arg_49_0:getComponent(FightTweenComponent):KillTweenByObj(arg_49_1, arg_49_2)
end

return var_0_0
