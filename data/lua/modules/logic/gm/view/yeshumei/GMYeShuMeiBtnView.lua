-- chunkname: @modules/logic/gm/view/yeshumei/GMYeShuMeiBtnView.lua

module("modules.logic.gm.view.yeshumei.GMYeShuMeiBtnView", package.seeall)

local GMYeShuMeiBtnView = class("GMYeShuMeiBtnView", GMSubViewBase)

function GMYeShuMeiBtnView:ctor()
	self.tabName = "野树莓"
end

function GMYeShuMeiBtnView:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMYeShuMeiBtnView:getLineGroup()
	return "L" .. self.lineIndex
end

function GMYeShuMeiBtnView:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)
	self:addButton("L1", "打开野树莓编辑器", self._openGMYeShuMeiView, self)

	self._act211EpisodeId = self:addInputText("L2", nil, "关卡ID")

	self:addButton("L2", "打开指定关卡", self._openGame, self)
	self:addButton("L3", "打开选关界面", self._openLevelView, self)
	self:addButton("L4", "完成当前关卡", self._finishCurrentGame, self)

	self._beilierEpisodeId = self:addInputText("L5", nil, "关卡ID")

	self:addButton("L5", "贝利尔打开指定关卡", self._openBeilierGame, self)
	self:addButton("L6", "贝利尔提示次数99", self.setMaxTipCount, self)
	self:addButton("L7", "完成贝利尔当前关卡", self._finishBeiLiErCurrentGame, self)
end

function GMYeShuMeiBtnView:_openGMYeShuMeiView()
	GMYeShuMeiModel.instance:clearData()
	YeShuMeiConfig.instance:_initYeShuMeiLevelData()
	ViewMgr.instance:openView(ViewName.GMYeShuMeiView)
	ViewMgr.instance:closeView(ViewName.GMToolView)
end

function GMYeShuMeiBtnView:_openGame()
	local episodeId = tonumber(self._act211EpisodeId:GetText())
	local episodeCo = YeShuMeiConfig.instance:getYeShuMeiEpisodeConfigById(VersionActivity3_1Enum.ActivityId.YeShuMei, episodeId)

	if not episodeCo then
		GameFacade.showToastString("关卡配置不存在")

		return
	end

	if episodeCo.gameId == 0 then
		GameFacade.showToastString("不是游戏关卡")

		return
	end

	YeShuMeiGameController.instance:enterGame(episodeId)
end

function GMYeShuMeiBtnView:_openBeilierGame()
	local episodeId = tonumber(self._beilierEpisodeId:GetText())
	local episodeCo = BeiLiErConfig.instance:getBeiLiErEpisodeConfigById(VersionActivity3_2Enum.ActivityId.BeiLiEr, episodeId)

	if not episodeCo then
		GameFacade.showToastString("关卡配置不存在")

		return
	end

	if episodeCo.gameId == 0 then
		GameFacade.showToastString("不是游戏关卡")

		return
	end

	BeiLiErGameController.instance:enterGame(episodeId)
end

function GMYeShuMeiBtnView:setMaxTipCount()
	if ViewMgr.instance:isOpen(ViewName.BeiLiErGameView) then
		BeiLiErGameModel.instance:setMaxTipCount()
	end
end

function GMYeShuMeiBtnView:_openLevelView()
	YeShuMeiController.instance:enterLevelView()
end

function GMYeShuMeiBtnView:_finishCurrentGame()
	local episodeId = YeShuMeiModel.instance:getCurEpisode()

	YeShuMeiController.instance:_onGameFinished(VersionActivity3_1Enum.ActivityId.YeShuMei, episodeId)
end

function GMYeShuMeiBtnView:_finishBeiLiErCurrentGame()
	local episodeId = BeiLiErModel.instance:getCurEpisode()

	BeiLiErController.instance:_onGameFinished(VersionActivity3_2Enum.ActivityId.BeiLiEr, episodeId)
end

return GMYeShuMeiBtnView
