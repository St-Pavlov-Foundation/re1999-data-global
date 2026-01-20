-- chunkname: @modules/logic/commandstation/view/CommandStationDetailView.lua

module("modules.logic.commandstation.view.CommandStationDetailView", package.seeall)

local CommandStationDetailView = class("CommandStationDetailView", BaseView)

function CommandStationDetailView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Root/#txt_Title")
	self._goHead = gohelper.findChild(self.viewGO, "Root/#go_Head")
	self._goItem = gohelper.findChild(self.viewGO, "Root/#go_Head/#go_Item")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Root/Scroll View/Viewport/#txt_Descr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationDetailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function CommandStationDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function CommandStationDetailView:_btncloseOnClick()
	self:closeThis()
end

function CommandStationDetailView:_editableInitView()
	gohelper.setActive(self._goItem, false)
end

function CommandStationDetailView:onUpdateParam()
	return
end

function CommandStationDetailView:onOpen()
	local id = self.viewParam.timeId
	local config = lua_copost_time_point_event.configDict[id]
	local textId = config and config.allTextId
	local textConfig = textId and lua_copost_event_text.configDict[textId]

	self._txtDescr.text = textConfig and textConfig.text

	local chaEventId = config and config.chaEventId

	if chaEventId and #chaEventId ~= 0 then
		gohelper.CreateObjList(self, self._onItemShow, chaEventId, self._goHead, self._goItem)
	end
end

function CommandStationDetailView:_onItemShow(obj, chaEventId, index)
	local singleImage = gohelper.findChildSingleImage(obj, "image_Icon")
	local eventConfig = lua_copost_character_event.configDict[chaEventId]
	local chaId = eventConfig and eventConfig.chaId
	local chaConfig = chaId and lua_copost_character.configDict[chaId]

	if chaConfig then
		singleImage:LoadImage(ResUrl.getHeadIconSmall(chaConfig.chaPicture))
	end
end

function CommandStationDetailView:onClose()
	return
end

function CommandStationDetailView:onDestroyView()
	return
end

return CommandStationDetailView
