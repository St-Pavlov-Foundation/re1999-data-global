-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogRoleRightItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleRightItem", package.seeall)

local AergusiDialogRoleRightItem = class("AergusiDialogRoleRightItem", AergusiDialogRoleItemBase)
local kMarkTopOffsetY = -4.9039
local kMarkTopLineSpacine = 22

function AergusiDialogRoleRightItem:ctor(...)
	AergusiDialogRoleRightItem.super.ctor(self, ...)
end

function AergusiDialogRoleRightItem:init(go, path)
	self.go = go
	self._resPath = path
	self._golight = gohelper.findChild(go, "light")
	self._gochess = gohelper.findChild(go, "#chessitem")
	self._simagechess = gohelper.findChildSingleImage(go, "#chessitem/#chess")
	self._gotalk = gohelper.findChild(go, "go_talking")
	self._gobubble = gohelper.findChild(go, "go_bubble")
	self._gospeakbubble = gohelper.findChild(go, "go_bubble/go_speakbubble")
	self._txtspeakbubbledesc = gohelper.findChildText(go, "go_bubble/go_speakbubble/txt_dec")
	self._gothinkbubble = gohelper.findChild(go, "go_bubble/go_thinkbubble")
	self._txtthinkbubbledesc = gohelper.findChildText(go, "go_bubble/go_thinkbubble/txt_dec")
	self._goemo = gohelper.findChild(go, "emobg")
	self._chessAni = self._gochess:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._golight, false)
	gohelper.setActive(self._gotalk, false)
	gohelper.setActive(self._gobubble, false)
	gohelper.setActive(self._goemo, false)
	self._simagechess:LoadImage(ResUrl.getV2a1AergusiSingleBg(self._resPath))

	self._txtspeakbubbledescMarkTopIndex = self:createMarktopCmp(self._txtspeakbubbledesc)
	self._txtthinkbubbledescMarkTopIndex = self:createMarktopCmp(self._txtthinkbubbledesc)

	self:setTopOffset(self._txtspeakbubbledescMarkTopIndex, 0, kMarkTopOffsetY)
	self:setTopOffset(self._txtthinkbubbledescMarkTopIndex, 0, kMarkTopOffsetY)
	self:setLineSpacing(self._txtspeakbubbledescMarkTopIndex, kMarkTopLineSpacine)
	self:setLineSpacing(self._txtthinkbubbledescMarkTopIndex, kMarkTopLineSpacine)
end

function AergusiDialogRoleRightItem:showTalking()
	self._chessAni:Play("jump", 0, 0)
	gohelper.setActive(self._golight, true)
	gohelper.setActive(self._gotalk, true)
	TaskDispatcher.runDelay(self.hideTalking, self, 3)
end

function AergusiDialogRoleRightItem:hideTalking()
	TaskDispatcher.cancelTask(self.hideTalking, self)
	gohelper.setActive(self._gotalk, false)
	gohelper.setActive(self._golight, false)
end

function AergusiDialogRoleRightItem:showEmo()
	gohelper.setActive(self._goemo, true)
end

function AergusiDialogRoleRightItem:showBubble(bubbleCo)
	gohelper.setActive(self._gobubble, true)

	if bubbleCo.bubbleType == AergusiEnum.DialogBubbleType.Speaker then
		gohelper.setActive(self._gospeakbubble, true)
		gohelper.setActive(self._gothinkbubble, false)
		self:setTextWithMarktopByIndex(self._txtspeakbubbledescMarkTopIndex, bubbleCo.content)
	else
		gohelper.setActive(self._gothinkbubble, true)
		gohelper.setActive(self._gospeakbubble, false)
		self:setTextWithMarktopByIndex(self._txtthinkbubbledescMarkTopIndex, bubbleCo.content)
	end
end

function AergusiDialogRoleRightItem:hideBubble()
	gohelper.setActive(self._gobubble, false)
end

function AergusiDialogRoleRightItem:destroy()
	self._simagechess:UnLoadImage()
	AergusiDialogRoleRightItem.super.destroy(self)
end

return AergusiDialogRoleRightItem
