module("modules.logic.rouge.map.view.map.RougeMapInputView", package.seeall)

local var_0_0 = class("RougeMapInputView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goFullScreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.click = gohelper.getClickWithDefaultAudio(arg_4_0.goFullScreen)

	arg_4_0.click:AddClickListener(arg_4_0.onClickMap, arg_4_0)

	arg_4_0.trFullScreen = arg_4_0.goFullScreen:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.mapComp = RougeMapController.instance:getMapComp()

	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onLoadMapDone, arg_4_0.onLoadMapDone, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onBeforeChangeMapInfo, arg_4_0.onBeforeChangeMapInfo, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0.onCloseView, arg_4_0)
end

function var_0_0.onBeforeChangeMapInfo(arg_5_0)
	arg_5_0.mapComp = nil
end

function var_0_0.onLoadMapDone(arg_6_0)
	arg_6_0.mapComp = RougeMapController.instance:getMapComp()
end

function var_0_0.onClickMap(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.mapComp then
		return
	end

	local var_7_0, var_7_1 = recthelper.screenPosToAnchorPos2(arg_7_2, arg_7_0.trFullScreen)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.mapComp:getMapItemList()) do
		if iter_7_1:checkInClickArea(var_7_0, var_7_1, arg_7_0.trFullScreen) then
			iter_7_1:onClick()

			return
		end
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
end

function var_0_0.onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.RougeMapChoiceView then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
	end
end

function var_0_0.onClose(arg_9_0)
	arg_9_0.click:RemoveClickListener()

	arg_9_0.click = nil
end

return var_0_0
