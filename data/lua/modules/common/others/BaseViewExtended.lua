module("modules.common.others.BaseViewExtended", package.seeall)

local var_0_0 = class("BaseViewExtended", BaseView)

var_0_0.ViewState = {
	Dead = 3,
	Close = 2,
	Open = 1
}

function var_0_0.ctor(arg_1_0, ...)
	arg_1_0:__onInit()
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0.initViewGOInternal(arg_2_0, arg_2_1)
	arg_2_0.viewGO_parent_obj = arg_2_1
	arg_2_0.VIEW_STATE = var_0_0.ViewState.Open

	arg_2_0:logicStartInternal()
end

function var_0_0.logicStartInternal(arg_3_0)
	if arg_3_0.viewGO then
		arg_3_0:viewLogicBootInternal()
	else
		arg_3_0:definePrefabUrl()

		if arg_3_0.internal_pre_url then
			arg_3_0:com_loadAsset(arg_3_0.internal_pre_url, arg_3_0.viewGOLoadFinishCallbackInternal)
		else
			arg_3_0:viewLogicBootInternal()
		end
	end
end

function var_0_0.viewGOLoadFinishCallbackInternal(arg_4_0, arg_4_1)
	if arg_4_0.VIEW_STATE == var_0_0.ViewState.Dead then
		return
	end

	local var_4_0 = arg_4_1:GetResource()

	arg_4_0.viewGO = gohelper.clone(var_4_0, arg_4_0.viewGO_parent_obj)

	arg_4_0:viewLogicBootInternal()
end

function var_0_0.viewLogicBootInternal(arg_5_0)
	arg_5_0.INIT_FINISH_INTERNAL = true

	arg_5_0:onInitViewInternal()
	arg_5_0:addEventsInternal()

	if arg_5_0.VIEW_STATE == var_0_0.ViewState.Open then
		arg_5_0:bootOnOpenInternal()
	else
		arg_5_0:setViewVisibleInternal(false)
	end
end

function var_0_0.openExclusiveView(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, ...)
	if not arg_6_0.exclusive_tab then
		arg_6_0.exclusive_tab = {}
		arg_6_0.exclusive_opening = {}
	end

	arg_6_1 = arg_6_1 or 1
	arg_6_0.exclusive_tab[arg_6_1] = arg_6_0.exclusive_tab[arg_6_1] or {}

	local var_6_0 = arg_6_0.exclusive_tab[arg_6_1][arg_6_0.exclusive_opening[arg_6_1]]

	if var_6_0 then
		if arg_6_2 == arg_6_0.exclusive_opening[arg_6_1] then
			return var_6_0
		end

		arg_6_0:hideExclusiveView(var_6_0, arg_6_1, arg_6_2)
	end

	if arg_6_0.exclusive_tab[arg_6_1][arg_6_2] then
		arg_6_0:setExclusiveViewVisible(arg_6_0.exclusive_tab[arg_6_1][arg_6_2], true)

		arg_6_0.exclusive_opening[arg_6_1] = arg_6_2

		return arg_6_0.exclusive_tab[arg_6_1][arg_6_2]
	end

	local var_6_1 = arg_6_0:openSubView(arg_6_3, arg_6_4, arg_6_5, ...)

	var_6_1.internalExclusiveSign = arg_6_1
	var_6_1.internalExclusiveID = arg_6_2
	arg_6_0.exclusive_tab[arg_6_1][arg_6_2] = var_6_1
	arg_6_0.exclusive_opening[arg_6_1] = arg_6_2

	return var_6_1
end

function var_0_0.hideExclusiveGroup(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or 1

	if arg_7_0.exclusive_opening and arg_7_0.exclusive_opening[arg_7_1] then
		arg_7_0:hideExclusiveView(arg_7_0.exclusive_tab[arg_7_1][arg_7_0.exclusive_opening[arg_7_1]])
	end
end

function var_0_0.hideExclusiveView(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_2 = arg_8_2 or 1
	arg_8_1 = arg_8_1 or arg_8_0.exclusive_tab[arg_8_2][arg_8_3]

	if arg_8_0.exclusive_opening[arg_8_1.internalExclusiveSign] == arg_8_1.internalExclusiveID then
		arg_8_0.exclusive_opening[arg_8_1.internalExclusiveSign] = nil
	end

	arg_8_0:setExclusiveViewVisible(arg_8_1, false)
end

function var_0_0.setExclusiveViewVisible(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1.onSetExclusiveViewVisible then
		arg_9_1:onSetExclusiveViewVisible(arg_9_2)
	else
		arg_9_1:setViewVisibleInternal(arg_9_2)
	end
end

function var_0_0.openSubView(arg_10_0, arg_10_1, arg_10_2, arg_10_3, ...)
	if not arg_10_0._childViews then
		arg_10_0._childViews = {}
	end

	local var_10_0 = arg_10_1.New(...)

	if var_10_0.onRefreshViewParam then
		var_10_0:onRefreshViewParam(...)
	end

	if type(arg_10_2) == "string" then
		var_10_0.internal_pre_url = arg_10_2
		arg_10_2 = nil
	end

	var_10_0.viewName = arg_10_0.viewName
	var_10_0.viewContainer = arg_10_0.viewContainer
	var_10_0.PARENT_VIEW = arg_10_0

	if var_10_0.initViewGOInternal then
		var_10_0.viewGO = arg_10_2

		var_10_0:initViewGOInternal(arg_10_3 or arg_10_0.viewGO, arg_10_0)
	else
		var_10_0:__onInit()

		var_10_0.viewGO = arg_10_2

		if arg_10_0._has_onInitView then
			var_10_0:onInitViewInternal()
		end

		if arg_10_0._has_addEvents then
			var_10_0:addEventsInternal()
		end

		if arg_10_0._has_onOpen then
			var_10_0:onOpenInternal()
		end

		if arg_10_0._has_onOpenFinish then
			var_10_0:onOpenFinishInternal()
		end
	end

	table.insert(arg_10_0._childViews, var_10_0)

	return var_10_0
end

function var_0_0.bootOnOpenInternal(arg_11_0)
	if arg_11_0:viewIsReadyInternal() then
		arg_11_0:onOpenInternal()
		arg_11_0:onOpenFinishInternal()
	end
end

function var_0_0.setViewVisible(arg_12_0, arg_12_1)
	arg_12_0:setViewVisibleInternal(arg_12_1)
end

function var_0_0.onCloseInternal(arg_13_0)
	arg_13_0.VIEW_STATE = var_0_0.ViewState.Close

	arg_13_0:invokeChildFunc("onCloseInternal")
	arg_13_0:releaseComponentsInternal()

	if arg_13_0.viewGO then
		arg_13_0:onClose()
	end
end

function var_0_0.onCloseFinishInternal(arg_14_0)
	arg_14_0:invokeChildFunc("onCloseFinishInternal")

	if arg_14_0.viewGO then
		arg_14_0:onCloseFinish()
	end
end

function var_0_0.removeEventsInternal(arg_15_0)
	arg_15_0:invokeChildFunc("removeEventsInternal")

	if arg_15_0.viewGO then
		arg_15_0:removeEvents()
	end
end

function var_0_0.onDestroyViewInternal(arg_16_0)
	arg_16_0.VIEW_STATE = var_0_0.ViewState.Dead

	arg_16_0:invokeChildFunc("onDestroyViewInternal")

	if arg_16_0.viewGO then
		arg_16_0:onDestroyView()
		gohelper.destroy(arg_16_0.viewGO)
	end

	arg_16_0:__onDispose()
end

function var_0_0.invokeChildFunc(arg_17_0, arg_17_1)
	if arg_17_0._childViews then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._childViews) do
			if iter_17_1[arg_17_1] then
				iter_17_1[arg_17_1](iter_17_1)
			end
		end
	end
end

function var_0_0.destroySubView(arg_18_0, arg_18_1)
	arg_18_0:removeChildViewIndex(arg_18_1)
	arg_18_0:playDestroyBehaviour(arg_18_1)
end

function var_0_0.removeChildViewIndex(arg_19_0, arg_19_1)
	for iter_19_0 = #arg_19_0._childViews, 1, -1 do
		if arg_19_0._childViews[iter_19_0] == arg_19_1 then
			table.remove(arg_19_0._childViews, iter_19_0)

			break
		end
	end
end

function var_0_0.playDestroyBehaviour(arg_20_0, arg_20_1)
	if arg_20_1.viewGO then
		arg_20_1:onCloseInternal()
		arg_20_1:onCloseFinishInternal()
		arg_20_1:removeEventsInternal()
		arg_20_1:onDestroyViewInternal()
	else
		arg_20_1.VIEW_STATE = var_0_0.ViewState.Dead

		if arg_20_1.releaseComponentsInternal then
			arg_20_1:releaseComponentsInternal()
		end

		arg_20_1:__onDispose()
	end
end

function var_0_0.DESTROYSELF(arg_21_0)
	arg_21_0:getParentView():destroySubView(arg_21_0)
end

function var_0_0.killAllChildView(arg_22_0)
	if arg_22_0._childViews then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._childViews) do
			arg_22_0:playDestroyBehaviour(iter_22_1)
		end
	end

	arg_22_0._childViews = {}
end

function var_0_0.setViewVisibleInternal(arg_23_0, arg_23_1)
	if arg_23_0.visible_internal == arg_23_1 then
		return
	end

	arg_23_0.visible_internal = arg_23_1

	if not arg_23_0:viewIsReadyInternal() then
		return
	end

	if arg_23_0.viewGO then
		arg_23_0.canvasGroup_internal = arg_23_0.canvasGroup_internal or gohelper.onceAddComponent(arg_23_0.viewGO, typeof(UnityEngine.CanvasGroup))
		arg_23_0.canvasGroup_internal.alpha = arg_23_1 and 1 or 0
		arg_23_0.canvasGroup_internal.interactable = arg_23_1
		arg_23_0.canvasGroup_internal.blocksRaycasts = arg_23_1
	end
end

function var_0_0.registComponent(arg_24_0, arg_24_1)
	if not arg_24_0.components_internal then
		arg_24_0.components_internal = {}
	end

	if arg_24_0.components_internal[arg_24_1.__cname] then
		return arg_24_0.components_internal[arg_24_1.__cname]
	end

	local var_24_0 = arg_24_1.New()

	var_24_0.parentClass = arg_24_0
	arg_24_0.components_internal[arg_24_1.__cname] = var_24_0

	return arg_24_0.components_internal[arg_24_1.__cname]
end

function var_0_0.releaseComponentsInternal(arg_25_0)
	if arg_25_0.components_internal then
		for iter_25_0, iter_25_1 in pairs(arg_25_0.components_internal) do
			if iter_25_1.releaseSelf then
				iter_25_1:releaseSelf()
			end
		end
	end

	arg_25_0.components_internal = nil
end

function var_0_0.getParentView(arg_26_0)
	return arg_26_0.PARENT_VIEW
end

function var_0_0.getParentObj(arg_27_0)
	return arg_27_0.viewGO_parent_obj
end

function var_0_0.getChildViews(arg_28_0)
	return arg_28_0._childViews
end

function var_0_0.viewIsReadyInternal(arg_29_0)
	return arg_29_0.INIT_FINISH_INTERNAL
end

function var_0_0.definePrefabUrl(arg_30_0)
	return
end

function var_0_0.setPrefabUrl(arg_31_0, arg_31_1)
	arg_31_0.internal_pre_url = arg_31_1
end

function var_0_0.onRefreshViewParam(arg_32_0, ...)
	return
end

function var_0_0.com_loadAsset(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_0:registComponent(LoaderComponent):loadAsset(arg_33_1, arg_33_2, arg_33_0, arg_33_3)
end

function var_0_0.com_loadListAsset(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	arg_34_0:registComponent(LoaderComponent):loadListAsset(arg_34_1, arg_34_2, arg_34_3, arg_34_0, arg_34_4, arg_34_5)
end

function var_0_0.com_createObjList(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5, arg_35_6, arg_35_7)
	arg_35_0:registComponent(UICloneComponent):createObjList(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5, arg_35_6, arg_35_7)
end

function var_0_0.com_registScrollView(arg_36_0, arg_36_1, arg_36_2)
	return arg_36_0:registComponent(UISimpleScrollViewComponent):registScrollView(arg_36_1, arg_36_2)
end

function var_0_0.com_registSimpleScrollView(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	return arg_37_0:registComponent(UISimpleScrollViewComponent):registSimpleScrollView(arg_37_1, arg_37_2, arg_37_3)
end

return var_0_0
