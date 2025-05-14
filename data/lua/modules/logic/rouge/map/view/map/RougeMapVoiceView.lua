module("modules.logic.rouge.map.view.map.RougeMapVoiceView", package.seeall)

local var_0_0 = class("RougeMapVoiceView", BaseView)

function var_0_0._onScreenResize(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0, var_1_1 = recthelper.getAnchor(arg_1_0.rectTr)

	arg_1_0:_updatePos_overseas(var_1_0, var_1_1)
end

function var_0_0._updatePos_overseas(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = UIDockingHelper.calcDockLocalPosV2(UIDockingHelper.Dock.ML_R, arg_2_0.rectTr, arg_2_0.rectTr.parent)
	local var_2_1 = UIDockingHelper.calcDockLocalPosV2(UIDockingHelper.Dock.MR_L, arg_2_0.rectTr, arg_2_0.rectTr.parent)

	recthelper.setAnchor(arg_2_0.rectTr, GameUtil.clamp(arg_2_1, var_2_0.x, var_2_1.x), arg_2_2)
end

function var_0_0.onInitView(arg_3_0)
	arg_3_0._gochesstalk = gohelper.findChild(arg_3_0.viewGO, "#go_chesstalk")
	arg_3_0._txtchesstalk = gohelper.findChildText(arg_3_0.viewGO, "#go_chesstalk/Scroll View/Viewport/Content/#txt_talk")

	if arg_3_0._editableInitView then
		arg_3_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_4_0)
	return
end

function var_0_0.removeEvents(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:hideVoice()

	arg_6_0.rectTr = arg_6_0._gochesstalk:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.viewRectTr = arg_6_0.viewGO:GetComponent(gohelper.Type_RectTransform)

	arg_6_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_6_0._onScreenResize, arg_6_0)
	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onTriggerShortVoice, arg_6_0.onTriggerShortVoice, arg_6_0)
	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onEndTriggerShortVoice, arg_6_0.onEndTriggerShortVoice, arg_6_0)
	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onActorPosChange, arg_6_0.onActorPosChange, arg_6_0)
	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onMapPosChange, arg_6_0.onMapPosChange, arg_6_0)
	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onCameraSizeChange, arg_6_0.onMapPosChange, arg_6_0)
	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, arg_6_0.onChangeMapInfo, arg_6_0, LuaEventSystem.High)
end

function var_0_0.onChangeMapInfo(arg_7_0)
	arg_7_0:hideVoice()
end

function var_0_0.onActorPosChange(arg_8_0, arg_8_1)
	if not arg_8_0.showIng then
		return
	end

	arg_8_0:updatePos(arg_8_1)
end

function var_0_0.onMapPosChange(arg_9_0)
	if RougeMapModel.instance:isPathSelect() then
		return
	end

	if not arg_9_0.showIng then
		return
	end

	local var_9_0 = RougeMapController.instance:getActorMap()

	if var_9_0 then
		arg_9_0:updatePos(var_9_0:getActorWordPos())
	end
end

function var_0_0.onTriggerShortVoice(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.desc

	AudioMgr.instance:trigger(arg_10_1.audioId)

	if string.nilorempty(var_10_0) then
		return
	end

	if RougeMapModel.instance:isPathSelect() then
		return
	end

	arg_10_0:showVoice()

	arg_10_0._txtchesstalk.text = var_10_0

	local var_10_1 = RougeMapController.instance:getActorMap()

	if var_10_1 then
		arg_10_0:updatePos(var_10_1:getActorWordPos())
	end
end

function var_0_0.onEndTriggerShortVoice(arg_11_0)
	arg_11_0:hideVoice()
end

function var_0_0.hideVoice(arg_12_0)
	gohelper.setActive(arg_12_0._gochesstalk, false)

	arg_12_0.showIng = false
end

function var_0_0.showVoice(arg_13_0)
	gohelper.setActive(arg_13_0._gochesstalk, true)

	arg_13_0.showIng = true
end

function var_0_0.updatePos(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = recthelper.worldPosToAnchorPos2(arg_14_1, arg_14_0.viewRectTr)
	local var_14_2

	if RougeMapModel.instance:isNormalLayer() then
		var_14_2 = RougeMapEnum.TalkAnchorOffset[RougeMapEnum.MapType.Normal]
	else
		var_14_2 = RougeMapEnum.TalkAnchorOffset[RougeMapEnum.MapType.Middle]
	end

	local var_14_3 = var_14_2.x
	local var_14_4 = var_14_2.y

	arg_14_0:_updatePos_overseas(var_14_0 + var_14_3, var_14_1 + var_14_4)
end

return var_0_0
