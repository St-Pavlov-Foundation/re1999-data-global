module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEpisodeView", package.seeall)

slot0 = class("V1a6_CachotEpisodeView", BaseView)
slot1 = {
	BeforeSelect = 1,
	AfterSelect = 3,
	Select = 2
}

function slot0.onInitView(slot0)
	slot0._gorotate = gohelper.findChild(slot0.viewGO, "rotate")
	slot0._txttitle = gohelper.findChildTextMesh(slot0.viewGO, "rotate/#simage_title/#txt_title")
	slot0._simageepisode = gohelper.findChildSingleImage(slot0.viewGO, "rotate/layout/#simage_episode")
	slot0._scroll = gohelper.findChild(slot0.viewGO, "rotate/layout/#scroll_view"):GetComponent(gohelper.Type_ScrollRect)
	slot0._viewPort = gohelper.findChild(slot0.viewGO, "rotate/layout/#scroll_view/Viewport")
	slot0._txtLeft = gohelper.findChildTextMesh(slot0.viewGO, "rotate/layout/#scroll_view/Viewport/#txt_NormalContent")
	slot0._goleftarrow = gohelper.findChild(slot0.viewGO, "rotate/layout/#scroll_view/Viewport/#txt_NormalContent/arrow")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "bottom")
	slot0._gobottomarrow = gohelper.findChild(slot0.viewGO, "bottom/go_normalcontent/arrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouchScreenUp, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.PlayChoiceDialog, slot0.playChoiceDialog, slot0)
end

function slot0.removeEvents(slot0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouchScreenUp, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.PlayChoiceDialog, slot0.playChoiceDialog, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._editableInitView(slot0)
	slot0._dialogItem = MonoHelper.addLuaComOnceToGo(slot0._gobottom, TMPFadeIn)
	slot0._dialogItemLeft = MonoHelper.addLuaComOnceToGo(slot0._txtLeft.gameObject, TMPFadeInWithScroll)
	slot1 = slot0._viewPort.transform
	slot0._viewportWidth = recthelper.getWidth(slot1)
	slot0._viewportHeight = recthelper.getHeight(slot1)
end

function slot0.onOpen(slot0)
	slot0._openTime = UnityEngine.Time.realtimeSinceStartup
	V1a6_CachotRoomModel.instance.isFromDramaToDrama = false

	slot0:_refreshView()
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_choices_open_1)
	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Choice)
	gohelper.setActive(slot0._gobottom, false)

	slot0._eventCo = lua_rogue_event_drama_choice.configDict[lua_rogue_event.configDict[slot0.viewParam.eventId].eventId]
	slot0._dialogCo = lua_rogue_dialog.configDict[slot0._eventCo.dialogId]
	slot0._txttitle.text = slot0._eventCo.title
	slot0._status = uv0.BeforeSelect
	slot0._stepIndex = 1

	if not slot0._dialogCo then
		gohelper.setActive(slot0._gorotate, false)
	end

	slot0:onStep()
end

function slot0._onTouchScreen(slot0)
	slot0._touchScreenDt = nil

	if not slot0:_checkCanNextStep() then
		return
	end

	if slot0._dialogItem:isPlaying() then
		slot0._dialogItem:conFinished()

		return
	end

	if slot0._dialogItemLeft:isPlaying() then
		slot0._dialogItemLeft:conFinished()

		return
	end

	if recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0._viewPort.transform).x >= 0 and slot2.x <= slot0._viewportWidth and slot2.y <= 0 and slot2.y >= -slot0._viewportHeight and slot0._viewportHeight < recthelper.getHeight(slot0._txtLeft.transform) then
		slot0._touchScreenDt = UnityEngine.Time.realtimeSinceStartup
		slot0._touchPos = slot1

		return
	end

	slot0._stepIndex = slot0._stepIndex + 1

	slot0:onStep()
end

function slot0._onTouchScreenUp(slot0)
	if slot0._touchScreenDt then
		if UnityEngine.Time.realtimeSinceStartup - slot0._touchScreenDt > 0.2 then
			slot0._touchScreenDt = nil

			return
		end

		slot0._touchScreenDt = nil

		if math.abs(slot0._touchPos.x - GamepadController.instance:getMousePosition().x) <= 10 and math.abs(slot0._touchPos.y - slot1.y) <= 10 then
			slot0._stepIndex = slot0._stepIndex + 1

			slot0:onStep()
		end
	end
end

function slot0._checkCanNextStep(slot0)
	if not slot0._openTime or UnityEngine.Time.realtimeSinceStartup - slot0._openTime < 1 then
		return false
	end

	if slot0._status == uv0.Select then
		return false
	end

	if PopupController.instance:getPopupCount() > 0 then
		return false
	end

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return false
	end

	return true
end

function slot0.playChoiceDialog(slot0, slot1)
	slot0._stepIndex = 1
	slot0._status = uv0.AfterSelect
	slot0._dialogCo = lua_rogue_dialog.configDict[slot1]

	if slot0:_checkCanNextStep() then
		slot0:onStep()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	end
end

function slot0._onCloseViewFinish(slot0)
	if slot0:_checkCanNextStep() then
		slot0:onStep()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	end
end

function slot0.onStep(slot0)
	if not slot0._dialogCo or not slot0._dialogCo[slot0._stepIndex] then
		if slot0._status == uv0.BeforeSelect then
			slot0._status = uv0.Select

			gohelper.setActive(slot0._gobottom, false)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_choices_open_2)
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, V1a6_CachotEventConfig.instance:getChoiceCos(slot0._eventCo.group))
		elseif slot0._status == uv0.AfterSelect then
			if V1a6_CachotRoomModel.instance:getNowTopEventMo() and slot1:getEventCo().type == V1a6_CachotEnum.EventType.ChoiceSelect then
				V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Choice)
				V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, false)
			else
				slot0:closeThis()
			end
		end

		return
	end

	if slot0._dialogCo[slot0._stepIndex].type == 1 then
		gohelper.setActive(slot0._gorotate, true)
		slot0._dialogItemLeft:playNormalText(slot1.text)

		slot0._scroll.horizontalNormalizedPosition = 0

		slot0._scroll:StopMovement()
		slot0._simageepisode:LoadImage(ResUrl.getV1a6CachotIcon("event/" .. slot1.photo))
	else
		gohelper.setActive(slot0._gobottom, true)
		slot0._dialogItem:playNormalText(slot1.text)
	end

	gohelper.setActive(slot0._goleftarrow, slot1.type == 1)
	gohelper.setActive(slot0._gobottomarrow, slot1.type == 2)
end

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMember(slot0, "_dialogItem")
	V1a6_CachotEventController.instance:setPause(false, V1a6_CachotEnum.EventPauseType.Choice)
end

function slot0.onDestroyView(slot0)
	slot0._simageepisode:UnLoadImage()
end

return slot0
