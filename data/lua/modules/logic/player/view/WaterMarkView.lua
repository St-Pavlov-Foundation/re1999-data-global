-- chunkname: @modules/logic/player/view/WaterMarkView.lua

module("modules.logic.player.view.WaterMarkView", package.seeall)

local WaterMarkView = class("WaterMarkView", BaseView)

function WaterMarkView:onInitView()
	self.goWaterMarkTemplate = gohelper.findChild(self.viewGO, "#txt_template")

	gohelper.setActive(self.goWaterMarkTemplate, false)

	self.goWaterMarkList = self:getUserDataTb_()

	local IdCanvasPopUp = ViewMgr.instance:getUILayer(UILayerName.IDCanvasPopUp)

	self.maxWidth, self.maxHeight = recthelper.getWidth(IdCanvasPopUp.transform), recthelper.getHeight(IdCanvasPopUp.transform)
	self.wInterval, self.hInterval = 200, 50
end

function WaterMarkView:onOpen()
	self:updateWaterMark(self.viewParam.userId)
end

function WaterMarkView:updateWaterMark(userId)
	if GameChannelConfig.getServerType() == GameChannelConfig.ServerType.Develop and BootNativeUtil.isWindows() then
		userId = LoginModel.instance.channelUserId
	end

	if userId == self.userId then
		return
	end

	self.userId = userId

	local width, height = self.wInterval, self.hInterval
	local txtWaterMark, goWaterMark
	local index = 0

	while height <= self.maxHeight do
		index = index + 1
		txtWaterMark = self.goWaterMarkList[index]

		if not txtWaterMark then
			goWaterMark = gohelper.cloneInPlace(self.goWaterMarkTemplate)
			txtWaterMark = goWaterMark:GetComponent(gohelper.Type_TextMesh)

			table.insert(self.goWaterMarkList, txtWaterMark)
		end

		gohelper.setActive(txtWaterMark.gameObject, true)

		txtWaterMark.text = self.userId
		txtWaterMark.color = index % 2 == 0 and Color.New(1, 1, 1, 0.16) or Color.New(0, 0, 0, 0.16)

		recthelper.setAnchor(txtWaterMark.gameObject.transform, width, height)
		transformhelper.setLocalRotation(txtWaterMark.gameObject.transform, 0, 0, -25)

		height = height + self.hInterval
		width = width + self.wInterval

		if width >= self.maxWidth then
			width = width - self.maxWidth
		end
	end

	for i = index + 1, #self.goWaterMarkList do
		gohelper.setActive(self.goWaterMarkList[i].gameObject, false)
	end
end

function WaterMarkView:hideWaterMark()
	gohelper.setActive(self.viewGO, false)
end

function WaterMarkView:showWaterMark()
	gohelper.setActive(self.viewGO, true)
end

function WaterMarkView:onDestroyView()
	self.goWaterMarkList = nil
end

return WaterMarkView
