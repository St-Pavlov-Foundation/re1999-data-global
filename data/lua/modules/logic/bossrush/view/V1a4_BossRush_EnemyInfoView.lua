-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_EnemyInfoView.lua

module("modules.logic.bossrush.view.V1a4_BossRush_EnemyInfoView", package.seeall)

local V1a4_BossRush_EnemyInfoView = class("V1a4_BossRush_EnemyInfoView", EnemyInfoView)

function V1a4_BossRush_EnemyInfoView:onInitView()
	V1a4_BossRush_EnemyInfoView.super.onInitView(self)
end

function V1a4_BossRush_EnemyInfoView:_refreshUI()
	if not self._battleId then
		logError("地方信息界面缺少战斗Id")

		return
	end

	V1a4_BossRush_EnemyInfoView.super._refreshUI(self)
end

function V1a4_BossRush_EnemyInfoView:_getBossId(groupIndex)
	local fightParam = FightController.instance:setFightParamByBattleId(self._battleId)
	local monsterGroupId = fightParam and fightParam.monsterGroupIds and fightParam.monsterGroupIds[groupIndex]
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
	local bossId = monsterGroupCO and not string.nilorempty(monsterGroupCO.bossId) and monsterGroupCO.bossId or nil

	return bossId
end

function V1a4_BossRush_EnemyInfoView:onUpdateParam()
	local stage, layer = self.viewParam.bossRushStage, self.viewParam.bossRushLayer

	self._battleId = BossRushConfig.instance:getDungeonBattleId(stage, layer)

	self:_refreshUI()
end

function V1a4_BossRush_EnemyInfoView:onOpen()
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, self._refreshInfo, self)
	self:onUpdateParam()
end

function V1a4_BossRush_EnemyInfoView:onClose()
	self:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, self._refreshInfo, self)
end

function V1a4_BossRush_EnemyInfoView:_doUpdateSelectIcon(battleId)
	local ruleView = self.viewContainer:getBossRushViewRule()

	ruleView:refreshUI(battleId)
end

return V1a4_BossRush_EnemyInfoView
