-- chunkname: @modules/logic/ui3drender/controller/UI3DRenderController.lua

module("modules.logic.ui3drender.controller.UI3DRenderController", package.seeall)

local UI3DRenderController = class("UI3DRenderController", BaseController)

function UI3DRenderController:onInit()
	self.curPosIndex = 0
	self.startPos = {
		8000,
		10000
	}
	self.distance = 500
	self.curPos = {
		self.startPos[1],
		self.startPos[2]
	}
end

function UI3DRenderController:getSurvivalUI3DRender(texW, texH, pos)
	self:_addIndex()

	local survivalUI3DRender = SurvivalUI3DRender.New(texW, texH, {
		pos and pos.x or self.curPos[1],
		pos and pos.y or 0,
		pos and pos.z or self.curPos[2]
	})

	survivalUI3DRender:init()

	return survivalUI3DRender
end

function UI3DRenderController:removeSurvivalUI3DRender(survivalUI3DRender)
	survivalUI3DRender:dispose()
	self:_reduceIndex()
end

function UI3DRenderController:_addIndex()
	self.curPosIndex = self.curPosIndex + 1
	self.curPos[1] = self.curPos[1] + self.distance
end

function UI3DRenderController:_reduceIndex()
	self.curPosIndex = self.curPosIndex - 1

	if self.curPosIndex <= 0 then
		self.curPos = {
			self.startPos[1],
			self.startPos[2]
		}
	end
end

UI3DRenderController.instance = UI3DRenderController.New()

return UI3DRenderController
