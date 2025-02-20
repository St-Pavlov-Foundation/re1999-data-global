module("modules.logic.gm.view.GMSubViewNewFightView", package.seeall)

slot0 = class("GMSubViewNewFightView", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "战斗·新"
end

function slot0.addLineIndex(slot0)
	slot0.lineIndex = slot0.lineIndex + 1
end

function slot0.getLineGroup(slot0)
	return "L" .. slot0.lineIndex
end

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	GMSubViewBase.initViewContent(slot0)

	slot0.lineIndex = 0

	slot0:addLineIndex()

	slot0.gmInput = slot0:addInputText(slot0:getLineGroup(), "", "GM 命令 ...", nil, , {
		w = 500
	})
	slot0.btnSend = slot0:addButton(slot0:getLineGroup(), "发送", slot0.onClickSendBtn, slot0)

	slot0:addTitleSplitLine("战前GM")
	slot0:addLineIndex()

	slot0.battleInput = slot0:addInputText(slot0:getLineGroup(), "", "怪物组/战斗id")
	slot0.btnEnterFightByMonsterGroupId = slot0:addButton(slot0:getLineGroup(), "进战斗怪物组", slot0.onClickBtnEnterFightByMonsterGroupId, slot0)
	slot0.btnEnterFightByBattleId = slot0:addButton(slot0:getLineGroup(), "进战斗战斗ID", slot0.onClickBtnEnterFightByBattleId, slot0)

	slot0:addLineIndex()

	slot0.btnSimulateBattle = slot0:addButton(slot0:getLineGroup(), "战场模拟", slot0.onClickSimulateBattle, slot0)
	slot0.btnSkillEditor = slot0:addButton(slot0:getLineGroup(), "技能编辑器", slot0.onClickSkillEditor, slot0)

	slot0:addTitleSplitLine("战中GM")
	slot0:addLineIndex()
	slot0:addFightNumToggle()
	slot0:addShowFightUIToggle()

	slot0.btnLockLifeMySide = slot0:addButton(slot0:getLineGroup(), "我方锁血", slot0.onClickLockLifeMySide, slot0)
	slot0.btnLockLifeEnemySide = slot0:addButton(slot0:getLineGroup(), "敌方锁血", slot0.onClickLockLifeEnemySide, slot0)

	slot0:addLineIndex()

	slot0.btnAddHurtMySide = slot0:addButton(slot0:getLineGroup(), "我方伤害*10", slot0.onClickAddHurtMySide, slot0)
	slot0.btnAddHurtEnemySide = slot0:addButton(slot0:getLineGroup(), "敌方伤害*10", slot0.onClickAddHurtEnemySide, slot0)
	slot0.btnReduceDamageMySide = slot0:addButton(slot0:getLineGroup(), "我方承伤/10", slot0.onClickReduceDamageMySide, slot0)
	slot0.btnReduceDamageEnemySide = slot0:addButton(slot0:getLineGroup(), "敌方承伤/10", slot0.onClickReduceDamageEnemySide, slot0)

	slot0:addLineIndex()

	slot0.costInput = slot0:addInputText(slot0:getLineGroup(), "", "增加cost...")
	slot0.btnAddCost = slot0:addButton(slot0:getLineGroup(), "增加cost", slot0.onClickAddCost, slot0)
	slot0.btnAddExPointMySide = slot0:addButton(slot0:getLineGroup(), "获取我方激情", slot0.onClickAddExPointMySide, slot0)
	slot0.btnAddExPointEnemySide = slot0:addButton(slot0:getLineGroup(), "获取敌方激情", slot0.onClickAddExPointEnemySide, slot0)

	slot0:addLineIndex()

	slot0.btnChangeCard = slot0:addButton(slot0:getLineGroup(), "修改手牌", slot0.onClickChangeCard, slot0)
	slot0.btnFightGm = slot0:addButton(slot0:getLineGroup(), "战中外挂", slot0.onClickFightGm, slot0)

	slot0:addButton(slot0:getLineGroup(), "我方牌库", slot0.onClickMyCardDeck, slot0)
	slot0:addButton(slot0:getLineGroup(), "敌方牌库", slot0.onClickEnemyCardDeck, slot0)
	slot0:addTitleSplitLine("战中打印")
	slot0:addLineIndex()

	slot0.btnEnableFightLog = slot0:addButton(slot0:getLineGroup(), "开启战斗打印", slot0.onClickEnableFightLog, slot0)
	slot0.btnLogAttr = slot0:addButton(slot0:getLineGroup(), "打印当前属性", slot0.onClickLogAttr, slot0)
	slot0.btnLogBaseAttr = slot0:addButton(slot0:getLineGroup(), "打印基础属性", slot0.onClickLogBaseAttr, slot0)
	slot0.btnLogLife = slot0:addButton(slot0:getLineGroup(), "打印生命百分比", slot0.onClickLogLife, slot0)
end

function slot0.addFightNumToggle(slot0)
	slot0.showFightNumToggle = slot0:addToggle(slot0:getLineGroup(), "显示战斗数值", slot0.onFightNumToggleValueChange, slot0)
	slot0.showFightNumToggle.isOn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1
end

function slot0.addShowFightUIToggle(slot0)
	slot0.showFightUIToggle = slot0:addToggle(slot0:getLineGroup(), "显示战斗UI", slot0.onFightUIToggleValueChange, slot0)
	slot0.showFightUIToggle.isOn = true
end

function slot0.onClickMyCardDeck(slot0)
	FightRpc.instance:sendGetFightCardDeckDetailInfoRequest(FightRpc.DeckInfoRequestType.MySide)
end

function slot0.onClickEnemyCardDeck(slot0)
	FightRpc.instance:sendGetFightCardDeckDetailInfoRequest(FightRpc.DeckInfoRequestType.EnemySide)
end

function slot0.onClickSendBtn(slot0)
	if string.nilorempty(slot0.gmInput:GetText()) then
		return
	end

	GMRpc.instance:sendGMRequest(slot1)
end

function slot0.onClickBtnEnterFightByMonsterGroupId(slot0)
	if not string.nilorempty(slot0.battleInput:GetText()) and #string.splitToNumber(slot1, "#") > 0 then
		PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, slot1)
		HeroGroupModel.instance:setParam(nil, , )

		if not HeroGroupModel.instance:getCurGroupMO() then
			logError("current HeroGroupMO is nil")
			GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

			return
		end

		slot4, slot5 = slot3:getMainList()
		slot6, slot7 = slot3:getSubList()

		slot0:closeThis()

		slot9 = FightParam.New()
		slot9.monsterGroupIds = slot2
		slot9.isTestFight = true

		slot9:setSceneLevel(10601)
		slot9:setMySide(slot3.clothId, slot4, slot6, slot3:getAllHeroEquips())
		FightModel.instance:setFightParam(slot9)
		FightController.instance:sendTestFight(slot9)

		return
	end
end

function slot0.onClickBtnEnterFightByBattleId(slot0)
	if tonumber(slot0.battleInput:GetText()) and lua_battle.configDict[slot2] then
		slot4 = FightController.instance:setFightParamByBattleId(slot2)

		HeroGroupModel.instance:setParam(slot2, nil, )

		if not HeroGroupModel.instance:getCurGroupMO() then
			logError("current HeroGroupMO is nil")
			GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

			return
		end

		slot6, slot7 = slot5:getMainList()
		slot8, slot9 = slot5:getSubList()
		slot10 = slot5:getAllHeroEquips()
		slot14 = slot1

		PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, slot14)
		slot0:closeThis()

		for slot14, slot15 in ipairs(lua_episode.configList) do
			if slot15.battleId == slot2 then
				slot4.episodeId = slot15.id
				FightResultModel.instance.episodeId = slot15.id

				DungeonModel.instance:SetSendChapterEpisodeId(slot15.chapterId, slot15.id)

				break
			end
		end

		if not slot4.episodeId then
			slot4.episodeId = 10101
		end

		slot4:setMySide(slot5.clothId, slot6, slot8, slot10)
		FightController.instance:sendTestFightId(slot4)
	end
end

function slot0.onClickSimulateBattle(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightSimulateView)
end

function slot0.onClickSkillEditor(slot0)
	SkillEditorMgr.instance:start()
end

function slot0.onFightNumToggleValueChange(slot0)
	slot1 = slot0.showFightNumToggle.isOn

	FightFloatMgr.instance:setCanShowFightNumUI(slot1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FightShowFightNum, slot1 and 1 or 0)
end

function slot0.onFightUIToggleValueChange(slot0)
	for slot5, slot6 in ipairs(GMFightShowState.getList()) do
		GMFightShowState.setStatus(slot6.valueKey, true)
	end

	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function slot0.onClickLockLifeMySide(slot0)
	GMRpc.instance:sendGMRequest("fight lockLife 0")
end

function slot0.onClickLockLifeEnemySide(slot0)
	GMRpc.instance:sendGMRequest("fight lockLife 1")
end

function slot0.onClickAddHurtMySide(slot0)
	GMRpc.instance:sendGMRequest("fight addHurt 0")
end

function slot0.onClickAddHurtEnemySide(slot0)
	GMRpc.instance:sendGMRequest("fight addHurt 1")
end

function slot0.onClickReduceDamageMySide(slot0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 0")
end

function slot0.onClickReduceDamageEnemySide(slot0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 1")
end

function slot0.onClickAddCost(slot0)
	if string.nilorempty(slot0.costInput:GetText()) then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("fight addPower %s 0", slot1))
end

function slot0.onClickAddExPointMySide(slot0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 0")
end

function slot0.onClickAddExPointEnemySide(slot0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 1")
end

function slot0.onClickChangeCard(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		slot0:closeThis()
		ViewMgr.instance:openView(ViewName.GMResetCardsView)
	else
		GameFacade.showToast(ToastEnum.IconId, "not in fight")
	end
end

function slot0.onClickFightGm(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightEntityView)
end

function slot0.onClickEnableFightLog(slot0)
	GMRpc.instance:sendGMRequest("fight log 2")
end

function slot0.onClickLogAttr(slot0)
	GMRpc.instance:sendGMRequest("fight printAttrWithCompute")
end

function slot0.onClickLogBaseAttr(slot0)
	GMRpc.instance:sendGMRequest("fight printAttr")
end

function slot0.onClickLogLife(slot0)
	GMRpc.instance:sendGMRequest("fight printLife")
end

return slot0
