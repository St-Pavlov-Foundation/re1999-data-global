-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookStoryItem.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookStoryItem", package.seeall)

local SurvivalHandbookStoryItem = class("SurvivalHandbookStoryItem", SimpleListItem)

function SurvivalHandbookStoryItem:onInit()
	self.Underway = gohelper.findChild(self.viewGO, "finishing")
	self.finished = gohelper.findChild(self.viewGO, "finished")
	self.unfinish = gohelper.findChild(self.viewGO, "unfinish")
	self.textUnderway = gohelper.findChildTextMesh(self.Underway, "#txt_task")
	self.textFinished = gohelper.findChildTextMesh(self.finished, "#txt_task")
	self.textUnfinish = gohelper.findChildTextMesh(self.unfinish, "#txt_task")
end

function SurvivalHandbookStoryItem:onAddListeners()
	return
end

function SurvivalHandbookStoryItem:onItemShow(data)
	self.survivalHandbookMo = data.survivalHandbookMo
	self.isFinish = data.isFinish
	self.isUnderway = self.survivalHandbookMo:isUnderway()
	self.isUnFinish = not self.isFinish and not self.survivalHandbookMo.isUnlock

	gohelper.setActive(self.finished, self.isFinish)
	gohelper.setActive(self.Underway, self.isUnderway)
	gohelper.setActive(self.unfinish, self.isUnFinish)

	if self.isFinish then
		if self.survivalHandbookMo:isCanFinishStory() then
			local cfg = self.survivalHandbookMo:getStoryTaskCfg()

			self.textFinished.text = cfg and cfg.desc2 or ""
		else
			self.textFinished.text = self.survivalHandbookMo.cfg.desc
		end
	elseif self.isUnderway then
		local cfg = self.survivalHandbookMo:getStoryTaskCfg()

		self.textUnderway.text = cfg and cfg.desc or ""
	elseif self.isUnFinish then
		local cfg = self.survivalHandbookMo:getStoryTaskCfg()

		self.textUnfinish.text = cfg and cfg.desc or ""
	end
end

return SurvivalHandbookStoryItem
