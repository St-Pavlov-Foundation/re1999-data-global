module("modules.logic.rouge.map.view.map.RougeMapVoiceView", package.seeall)

slot0 = class("RougeMapVoiceView", BaseView)

function slot0._onScreenResize(slot0, slot1, slot2)
	slot3, slot4 = recthelper.getAnchor(slot0.rectTr)

	slot0:_updatePos_overseas(slot3, slot4)
end

function slot0._updatePos_overseas(slot0, slot1, slot2)
	recthelper.setAnchor(slot0.rectTr, GameUtil.clamp(slot1, UIDockingHelper.calcDockLocalPosV2(UIDockingHelper.Dock.ML_R, slot0.rectTr, slot0.rectTr.parent).x, UIDockingHelper.calcDockLocalPosV2(UIDockingHelper.Dock.MR_L, slot0.rectTr, slot0.rectTr.parent).x), slot2)
end

function slot0.onInitView(slot0)
	slot0._gochesstalk = gohelper.findChild(slot0.viewGO, "#go_chesstalk")
	slot0._txtchesstalk = gohelper.findChildText(slot0.viewGO, "#go_chesstalk/Scroll View/Viewport/Content/#txt_talk")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:hideVoice()

	slot0.rectTr = slot0._gochesstalk:GetComponent(gohelper.Type_RectTransform)
	slot0.viewRectTr = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)

	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onTriggerShortVoice, slot0.onTriggerShortVoice, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onEndTriggerShortVoice, slot0.onEndTriggerShortVoice, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onActorPosChange, slot0.onActorPosChange, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onMapPosChange, slot0.onMapPosChange, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onCameraSizeChange, slot0.onMapPosChange, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0, LuaEventSystem.High)
end

function slot0.onChangeMapInfo(slot0)
	slot0:hideVoice()
end

function slot0.onActorPosChange(slot0, slot1)
	if not slot0.showIng then
		return
	end

	slot0:updatePos(slot1)
end

function slot0.onMapPosChange(slot0)
	if RougeMapModel.instance:isPathSelect() then
		return
	end

	if not slot0.showIng then
		return
	end

	if RougeMapController.instance:getActorMap() then
		slot0:updatePos(slot1:getActorWordPos())
	end
end

function slot0.onTriggerShortVoice(slot0, slot1)
	AudioMgr.instance:trigger(slot1.audioId)

	if string.nilorempty(slot1.desc) then
		return
	end

	if RougeMapModel.instance:isPathSelect() then
		return
	end

	slot0:showVoice()

	slot0._txtchesstalk.text = slot2

	if RougeMapController.instance:getActorMap() then
		slot0:updatePos(slot3:getActorWordPos())
	end
end

function slot0.onEndTriggerShortVoice(slot0)
	slot0:hideVoice()
end

function slot0.hideVoice(slot0)
	gohelper.setActive(slot0._gochesstalk, false)

	slot0.showIng = false
end

function slot0.showVoice(slot0)
	gohelper.setActive(slot0._gochesstalk, true)

	slot0.showIng = true
end

function slot0.updatePos(slot0, slot1)
	slot2, slot3 = recthelper.worldPosToAnchorPos2(slot1, slot0.viewRectTr)
	slot4 = nil
	slot4 = (not RougeMapModel.instance:isNormalLayer() or RougeMapEnum.TalkAnchorOffset[RougeMapEnum.MapType.Normal]) and RougeMapEnum.TalkAnchorOffset[RougeMapEnum.MapType.Middle]

	slot0:_updatePos_overseas(slot2 + slot4.x, slot3 + slot4.y)
end

return slot0
