-- chunkname: @modules/logic/rouge/map/view/map/RougeMapVoiceView.lua

module("modules.logic.rouge.map.view.map.RougeMapVoiceView", package.seeall)

local RougeMapVoiceView = class("RougeMapVoiceView", BaseView)

function RougeMapVoiceView:_onScreenResize(w, h)
	local x, y = recthelper.getAnchor(self.rectTr)

	self:_updatePos_overseas(x, y)
end

function RougeMapVoiceView:_updatePos_overseas(newX, newY)
	local v2L = UIDockingHelper.calcDockLocalPosV2(UIDockingHelper.Dock.ML_R, self.rectTr, self.rectTr.parent)
	local v2R = UIDockingHelper.calcDockLocalPosV2(UIDockingHelper.Dock.MR_L, self.rectTr, self.rectTr.parent)

	recthelper.setAnchor(self.rectTr, GameUtil.clamp(newX, v2L.x, v2R.x), newY)
end

function RougeMapVoiceView:onInitView()
	self._gochesstalk = gohelper.findChild(self.viewGO, "#go_chesstalk")
	self._txtchesstalk = gohelper.findChildText(self.viewGO, "#go_chesstalk/Scroll View/Viewport/Content/#txt_talk")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapVoiceView:addEvents()
	return
end

function RougeMapVoiceView:removeEvents()
	return
end

function RougeMapVoiceView:_editableInitView()
	self:hideVoice()

	self.rectTr = self._gochesstalk:GetComponent(gohelper.Type_RectTransform)
	self.viewRectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)

	self:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:addEventCb(RougeMapController.instance, RougeMapEvent.onTriggerShortVoice, self.onTriggerShortVoice, self)
	self:addEventCb(RougeMapController.instance, RougeMapEvent.onEndTriggerShortVoice, self.onEndTriggerShortVoice, self)
	self:addEventCb(RougeMapController.instance, RougeMapEvent.onActorPosChange, self.onActorPosChange, self)
	self:addEventCb(RougeMapController.instance, RougeMapEvent.onMapPosChange, self.onMapPosChange, self)
	self:addEventCb(RougeMapController.instance, RougeMapEvent.onCameraSizeChange, self.onMapPosChange, self)
	self:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self, LuaEventSystem.High)
end

function RougeMapVoiceView:onChangeMapInfo()
	self:hideVoice()
end

function RougeMapVoiceView:onActorPosChange(pos)
	if not self.showIng then
		return
	end

	self:updatePos(pos)
end

function RougeMapVoiceView:onMapPosChange()
	if RougeMapModel.instance:isPathSelect() then
		return
	end

	if not self.showIng then
		return
	end

	local actorComp = RougeMapController.instance:getActorMap()

	if actorComp then
		self:updatePos(actorComp:getActorWordPos())
	end
end

function RougeMapVoiceView:onTriggerShortVoice(voiceCo)
	local desc = voiceCo.desc

	AudioMgr.instance:trigger(voiceCo.audioId)

	if string.nilorempty(desc) then
		return
	end

	if RougeMapModel.instance:isPathSelect() then
		return
	end

	self:showVoice()

	self._txtchesstalk.text = desc

	local actorComp = RougeMapController.instance:getActorMap()

	if actorComp then
		self:updatePos(actorComp:getActorWordPos())
	end
end

function RougeMapVoiceView:onEndTriggerShortVoice()
	self:hideVoice()
end

function RougeMapVoiceView:hideVoice()
	gohelper.setActive(self._gochesstalk, false)

	self.showIng = false
end

function RougeMapVoiceView:showVoice()
	gohelper.setActive(self._gochesstalk, true)

	self.showIng = true
end

function RougeMapVoiceView:updatePos(worldPos)
	local anchorX, anchorY = recthelper.worldPosToAnchorPos2(worldPos, self.viewRectTr)
	local anchor

	if RougeMapModel.instance:isNormalLayer() then
		anchor = RougeMapEnum.TalkAnchorOffset[RougeMapEnum.MapType.Normal]
	else
		anchor = RougeMapEnum.TalkAnchorOffset[RougeMapEnum.MapType.Middle]
	end

	local offsetX, offsetY = anchor.x, anchor.y

	self:_updatePos_overseas(anchorX + offsetX, anchorY + offsetY)
end

return RougeMapVoiceView
