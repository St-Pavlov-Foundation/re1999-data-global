-- chunkname: @modules/logic/commandstation/view/CommandStationPaperGetView.lua

module("modules.logic.commandstation.view.CommandStationPaperGetView", package.seeall)

local CommandStationPaperGetView = class("CommandStationPaperGetView", BaseView)

function CommandStationPaperGetView:onInitView()
	self._imageDisk = gohelper.findChildSingleImage(self.viewGO, "image_Disk")
	self._txtDesc = gohelper.findChildTextMesh(self.viewGO, "#txt_Descr")
end

function CommandStationPaperGetView:onClickModalMask()
	self:closeThis()
end

function CommandStationPaperGetView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_tangren_fei)
	self._imageDisk:LoadImage(ResUrl.getCommandStationPaperIcon(self.viewParam.paperCo.diskIcon))

	self._txtDesc.text = self.viewParam.paperCo.diskText
end

return CommandStationPaperGetView
