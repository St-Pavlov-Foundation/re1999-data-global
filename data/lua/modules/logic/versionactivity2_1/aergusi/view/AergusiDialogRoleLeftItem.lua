-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogRoleLeftItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleLeftItem", package.seeall)

local AergusiDialogRoleLeftItem = class("AergusiDialogRoleLeftItem", AergusiDialogRoleItemBase)
local kMarkTopOffsetY = -4.9039
local kMarkTopLineSpacine = 22

function AergusiDialogRoleLeftItem:ctor(...)
	AergusiDialogRoleLeftItem.super.ctor(self, ...)
end

function AergusiDialogRoleLeftItem:init(go, path)
	self.go = go
	self._resPath = path
	self._golight = gohelper.findChild(go, "light")
	self._gochess = gohelper.findChild(go, "chessitem")
	self._simagechess = gohelper.findChildSingleImage(go, "chessitem/#chess")
	self._gotalk = gohelper.findChild(go, "go_talking")
	self._gobubble = gohelper.findChild(go, "go_bubble")
	self._gospeakbubble = gohelper.findChild(go, "go_bubble/go_speakbubble")
	self._txtspeakbubbledesc = gohelper.findChildText(go, "go_bubble/go_speakbubble/txt_dec")
	self._gothinkbubble = gohelper.findChild(go, "go_bubble/go_thinkbubble")
	self._txtthinkbubbledesc = gohelper.findChildText(go, "go_bubble/go_thinkbubble/txt_dec")
	self._gopatience = gohelper.findChild(go, "#go_patience")
	self._imageprogress = gohelper.findChildImage(go, "#go_patience/#image_progress")
	self._goprogress = gohelper.findChild(go, "#go_patience/#progress")

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._gobubble, false)
	gohelper.setActive(self._golight, false)
	gohelper.setActive(self._gotalk, false)

	self._chessAni = self._gochess:GetComponent(typeof(UnityEngine.Animator))
	self._progressAni = self._goprogress:GetComponent(typeof(UnityEngine.Animator))

	self:showPatience()
	self._simagechess:LoadImage(ResUrl.getV2a1AergusiSingleBg(self._resPath))
	self:_addEvents()

	self._txtspeakbubbledescMarkTopIndex = self:createMarktopCmp(self._txtspeakbubbledesc)
	self._txtthinkbubbledescMarkTopIndex = self:createMarktopCmp(self._txtthinkbubbledesc)

	self:setTopOffset(self._txtspeakbubbledescMarkTopIndex, 0, kMarkTopOffsetY)
	self:setTopOffset(self._txtthinkbubbledescMarkTopIndex, 0, kMarkTopOffsetY)
	self:setLineSpacing(self._txtspeakbubbledescMarkTopIndex, kMarkTopLineSpacine)
	self:setLineSpacing(self._txtthinkbubbledescMarkTopIndex, kMarkTopLineSpacine)
end

function AergusiDialogRoleLeftItem:showTalking()
	self._chessAni:Play("jump", 0, 0)
	gohelper.setActive(self._golight, true)
	gohelper.setActive(self._gotalk, true)
	TaskDispatcher.runDelay(self.hideTalking, self, 3)
end

function AergusiDialogRoleLeftItem:hideTalking()
	TaskDispatcher.cancelTask(self.hideTalking, self)
	gohelper.setActive(self._golight, false)
	gohelper.setActive(self._gotalk, false)
end

function AergusiDialogRoleLeftItem:showPatience()
	gohelper.setActive(self._gopatience, true)

	local leftTimes = AergusiDialogModel.instance:getLeftErrorTimes()
	local episodeId = AergusiModel.instance:getCurEpisode()
	local episodeCo = AergusiConfig.instance:getEpisodeConfig(nil, episodeId)
	local leftErrorRate = leftTimes / episodeCo.maxError

	self._imageprogress.fillAmount = leftErrorRate

	if leftTimes == 3 then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(self._imageprogress, "v2a1_aergusi_chat_progress_green")
	elseif leftTimes == 2 then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(self._imageprogress, "v2a1_aergusi_chat_progress_yellow")
		gohelper.setActive(self._goprogress, true)
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_error)
		self._progressAni:Play("toyellow")
	elseif leftTimes == 1 then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(self._imageprogress, "v2a1_aergusi_chat_progress_red")
		gohelper.setActive(self._goprogress, true)
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_error)
		self._progressAni:Play("tored")
	else
		gohelper.setActive(self._goprogress, true)
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_error)
		self._progressAni:Play("toempty")
	end
end

function AergusiDialogRoleLeftItem:showBubble(bubbleCo)
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

function AergusiDialogRoleLeftItem:hideBubble()
	gohelper.setActive(self._gobubble, false)
end

function AergusiDialogRoleLeftItem:_addEvents()
	AergusiController.instance:registerCallback(AergusiEvent.OnStartErrorBubbleDialog, self._onStartErrorBubbleDialog, self)
end

function AergusiDialogRoleLeftItem:_removeEvents()
	AergusiController.instance:unregisterCallback(AergusiEvent.OnStartErrorBubbleDialog, self._onStartErrorBubbleDialog, self)
end

function AergusiDialogRoleLeftItem:_onStartErrorBubbleDialog(bubbleId)
	self:showPatience()
end

function AergusiDialogRoleLeftItem:destroy()
	self._simagechess:UnLoadImage()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self.hideTalking, self)
	AergusiDialogRoleLeftItem.super.destroy(self)
end

return AergusiDialogRoleLeftItem
