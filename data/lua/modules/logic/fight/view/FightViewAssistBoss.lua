-- chunkname: @modules/logic/fight/view/FightViewAssistBoss.lua

module("modules.logic.fight.view.FightViewAssistBoss", package.seeall)

local FightViewAssistBoss = class("FightViewAssistBoss", BaseView)

function FightViewAssistBoss:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewAssistBoss:addEvents()
	return
end

function FightViewAssistBoss:removeEvents()
	return
end

function FightViewAssistBoss:_editableInitView()
	self.assistBossId2Behaviour = {
		FightAssistBoss1,
		FightAssistBoss2,
		FightAssistBoss3,
		FightAssistBoss4,
		FightAssistBoss5,
		FightAssistBoss6
	}
end

function FightViewAssistBoss:onUpdateParam()
	self:onOpen()
end

function FightViewAssistBoss:onOpen()
	if not FightDataHelper.fieldMgr:isPaTa() then
		return
	end

	self:createAssistBossBehaviour()
	self:createAssistBossScore()
end

function FightViewAssistBoss:createAssistBossBehaviour()
	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if not assistBoss then
		return
	end

	if self.bossBehaviour then
		self.bossBehaviour:refreshUI()

		return
	end

	local bossId = assistBoss.modelId
	local behaviourCls = self.assistBossId2Behaviour[bossId]

	if not behaviourCls then
		logError(string.format("boss id : %s, 没有对应的处理逻辑", bossId))

		behaviourCls = FightAssistBoss0
	end

	self.bossBehaviour = behaviourCls.New()

	local goAssistBoss = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.AssistBoss)

	self.bossBehaviour:init(goAssistBoss)
	self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.AssistBoss)
end

function FightViewAssistBoss:createAssistBossScore()
	if not FightDataHelper.fieldMgr:isTowerLimited() then
		return
	end

	if self.scoreComp then
		self.scoreComp:refreshScore()

		return
	end

	self.scoreComp = FightAssistBossScoreView.New()

	local goAssistBoss = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.AssistBossScore)

	self.scoreComp:init(goAssistBoss)
	self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.AssistBossScore)
end

function FightViewAssistBoss:onDestroyView()
	if self.bossBehaviour then
		self.bossBehaviour:destroy()

		self.bossBehaviour = nil
	end

	if self.scoreComp then
		self.scoreComp:destroy()

		self.scoreComp = nil
	end
end

return FightViewAssistBoss
