module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEpisodeView", package.seeall)

local var_0_0 = class("V1a6_CachotEpisodeView", BaseView)
local var_0_1 = {
	BeforeSelect = 1,
	AfterSelect = 3,
	Select = 2
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorotate = gohelper.findChild(arg_1_0.viewGO, "rotate")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "rotate/#simage_title/#txt_title")
	arg_1_0._simageepisode = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/layout/#simage_episode")
	arg_1_0._scroll = gohelper.findChild(arg_1_0.viewGO, "rotate/layout/#scroll_view"):GetComponent(gohelper.Type_ScrollRect)
	arg_1_0._viewPort = gohelper.findChild(arg_1_0.viewGO, "rotate/layout/#scroll_view/Viewport")
	arg_1_0._txtLeft = gohelper.findChildTextMesh(arg_1_0.viewGO, "rotate/layout/#scroll_view/Viewport/#txt_NormalContent")
	arg_1_0._goleftarrow = gohelper.findChild(arg_1_0.viewGO, "rotate/layout/#scroll_view/Viewport/#txt_NormalContent/arrow")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "bottom")
	arg_1_0._gobottomarrow = gohelper.findChild(arg_1_0.viewGO, "bottom/go_normalcontent/arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, arg_2_0._onTouchScreen, arg_2_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, arg_2_0._onTouchScreenUp, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayChoiceDialog, arg_2_0.playChoiceDialog, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, arg_3_0._onTouchScreen, arg_3_0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, arg_3_0._onTouchScreenUp, arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayChoiceDialog, arg_3_0.playChoiceDialog, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._dialogItem = MonoHelper.addLuaComOnceToGo(arg_4_0._gobottom, TMPFadeIn)
	arg_4_0._dialogItemLeft = MonoHelper.addLuaComOnceToGo(arg_4_0._txtLeft.gameObject, TMPFadeInWithScroll)

	local var_4_0 = arg_4_0._viewPort.transform

	arg_4_0._viewportWidth = recthelper.getWidth(var_4_0)
	arg_4_0._viewportHeight = recthelper.getHeight(var_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._openTime = UnityEngine.Time.realtimeSinceStartup
	V1a6_CachotRoomModel.instance.isFromDramaToDrama = false

	arg_5_0:_refreshView()
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:_refreshView()
end

function var_0_0._refreshView(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_choices_open_1)
	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Choice)
	gohelper.setActive(arg_7_0._gobottom, false)

	arg_7_0._eventCo = lua_rogue_event_drama_choice.configDict[lua_rogue_event.configDict[arg_7_0.viewParam.eventId].eventId]
	arg_7_0._dialogCo = lua_rogue_dialog.configDict[arg_7_0._eventCo.dialogId]
	arg_7_0._txttitle.text = arg_7_0._eventCo.title
	arg_7_0._status = var_0_1.BeforeSelect
	arg_7_0._stepIndex = 1

	if not arg_7_0._dialogCo then
		gohelper.setActive(arg_7_0._gorotate, false)
	end

	arg_7_0:onStep()
end

function var_0_0._onTouchScreen(arg_8_0)
	arg_8_0._touchScreenDt = nil

	if not arg_8_0:_checkCanNextStep() then
		return
	end

	if arg_8_0._dialogItem:isPlaying() then
		arg_8_0._dialogItem:conFinished()

		return
	end

	if arg_8_0._dialogItemLeft:isPlaying() then
		arg_8_0._dialogItemLeft:conFinished()

		return
	end

	local var_8_0 = GamepadController.instance:getMousePosition()
	local var_8_1 = recthelper.screenPosToAnchorPos(var_8_0, arg_8_0._viewPort.transform)

	if var_8_1.x >= 0 and var_8_1.x <= arg_8_0._viewportWidth and var_8_1.y <= 0 and var_8_1.y >= -arg_8_0._viewportHeight and recthelper.getHeight(arg_8_0._txtLeft.transform) > arg_8_0._viewportHeight then
		arg_8_0._touchScreenDt = UnityEngine.Time.realtimeSinceStartup
		arg_8_0._touchPos = var_8_0

		return
	end

	arg_8_0._stepIndex = arg_8_0._stepIndex + 1

	arg_8_0:onStep()
end

function var_0_0._onTouchScreenUp(arg_9_0)
	if arg_9_0._touchScreenDt then
		if UnityEngine.Time.realtimeSinceStartup - arg_9_0._touchScreenDt > 0.2 then
			arg_9_0._touchScreenDt = nil

			return
		end

		arg_9_0._touchScreenDt = nil

		local var_9_0 = GamepadController.instance:getMousePosition()

		if math.abs(arg_9_0._touchPos.x - var_9_0.x) <= 10 and math.abs(arg_9_0._touchPos.y - var_9_0.y) <= 10 then
			arg_9_0._stepIndex = arg_9_0._stepIndex + 1

			arg_9_0:onStep()
		end
	end
end

function var_0_0._checkCanNextStep(arg_10_0)
	if not arg_10_0._openTime or UnityEngine.Time.realtimeSinceStartup - arg_10_0._openTime < 1 then
		return false
	end

	if arg_10_0._status == var_0_1.Select then
		return false
	end

	if PopupController.instance:getPopupCount() > 0 then
		return false
	end

	if not ViewHelper.instance:checkViewOnTheTop(arg_10_0.viewName) then
		return false
	end

	return true
end

function var_0_0.playChoiceDialog(arg_11_0, arg_11_1)
	arg_11_0._stepIndex = 1
	arg_11_0._status = var_0_1.AfterSelect
	arg_11_0._dialogCo = lua_rogue_dialog.configDict[arg_11_1]

	if arg_11_0:_checkCanNextStep() then
		arg_11_0:onStep()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_11_0._onCloseViewFinish, arg_11_0)
	end
end

function var_0_0._onCloseViewFinish(arg_12_0)
	if arg_12_0:_checkCanNextStep() then
		arg_12_0:onStep()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_12_0._onCloseViewFinish, arg_12_0)
	end
end

function var_0_0.onStep(arg_13_0)
	if not arg_13_0._dialogCo or not arg_13_0._dialogCo[arg_13_0._stepIndex] then
		if arg_13_0._status == var_0_1.BeforeSelect then
			arg_13_0._status = var_0_1.Select

			gohelper.setActive(arg_13_0._gobottom, false)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_choices_open_2)
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, V1a6_CachotEventConfig.instance:getChoiceCos(arg_13_0._eventCo.group))
		elseif arg_13_0._status == var_0_1.AfterSelect then
			local var_13_0 = V1a6_CachotRoomModel.instance:getNowTopEventMo()

			if var_13_0 and var_13_0:getEventCo().type == V1a6_CachotEnum.EventType.ChoiceSelect then
				V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Choice)
				V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, false)
			else
				arg_13_0:closeThis()
			end
		end

		return
	end

	local var_13_1 = arg_13_0._dialogCo[arg_13_0._stepIndex]

	if var_13_1.type == 1 then
		gohelper.setActive(arg_13_0._gorotate, true)
		arg_13_0._dialogItemLeft:playNormalText(var_13_1.text)

		arg_13_0._scroll.horizontalNormalizedPosition = 0

		arg_13_0._scroll:StopMovement()
		arg_13_0._simageepisode:LoadImage(ResUrl.getV1a6CachotIcon("event/" .. var_13_1.photo))
	else
		gohelper.setActive(arg_13_0._gobottom, true)
		arg_13_0._dialogItem:playNormalText(var_13_1.text)
	end

	gohelper.setActive(arg_13_0._goleftarrow, var_13_1.type == 1)
	gohelper.setActive(arg_13_0._gobottomarrow, var_13_1.type == 2)
end

function var_0_0.onClose(arg_14_0)
	GameUtil.onDestroyViewMember(arg_14_0, "_dialogItem")
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Choice)
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._simageepisode:UnLoadImage()
end

return var_0_0
