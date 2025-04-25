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
	slot0:addLineIndex()

	slot0.countASFDInput = slot0:addInputText(slot0:getLineGroup(), "", "奥术飞弹数量...", nil, , {
		fsize = 30,
		w = 200
	})
	slot0.optionStrList = {
		"我方",
		"敌方"
	}
	slot0.optionValueList = {
		FightEnum.EntitySide.MySide,
		FightEnum.EntitySide.EnemySide
	}
	slot0.sideASFDDrop = slot0:addDropDown(slot0:getLineGroup(), "奥术飞弹发射方:", slot0.optionStrList, nil, , {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})
	slot0.toEntityASFDInput = slot0:addInputText(slot0:getLineGroup(), "", "奥术飞弹目标uid...")
	slot0.btnSendASFD = slot0:addButton(slot0:getLineGroup(), "发射", slot0.onClickSendASFDBtn, slot0)

	slot0:getEntityNameList()
	slot0:getMountList()
	slot0:addLineIndex()
	slot0:addLabel(slot0:getLineGroup(), "特效预览：", {
		fsize = 30,
		w = 100
	})

	slot0.effectPath = slot0:addInputText(slot0:getLineGroup(), "", "特效资源名...")
	slot0.entityDrop = slot0:addDropDown(slot0:getLineGroup(), "挂载对象:", slot0.entityNameList, nil, , {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	slot0.mountDrop = slot0:addDropDown(slot0:getLineGroup(), "挂载节点:", slot0.mountList, nil, , {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	slot0.btnMount = slot0:addButton(slot0:getLineGroup(), "挂载", slot0.onClickBtnMount, slot0)

	slot0:addTitleSplitLine("战中打印")
	slot0:addLineIndex()

	slot0.btnEnableFightLog = slot0:addButton(slot0:getLineGroup(), "开启战斗打印", slot0.onClickEnableFightLog, slot0)
	slot0.btnLogAttr = slot0:addButton(slot0:getLineGroup(), "打印当前属性", slot0.onClickLogAttr, slot0)
	slot0.btnLogBaseAttr = slot0:addButton(slot0:getLineGroup(), "打印基础属性", slot0.onClickLogBaseAttr, slot0)
	slot0.btnLogLife = slot0:addButton(slot0:getLineGroup(), "打印生命百分比", slot0.onClickLogLife, slot0)
end

function slot0.getEntityNameList(slot0)
	slot0.entityNameList = {}
	slot0.entityList = {}

	FightDataHelper.entityMgr:getAllEntityList(slot0.entityList)

	for slot4, slot5 in ipairs(slot0.entityList) do
		table.insert(slot0.entityNameList, slot5:getCO() and slot6.name or slot5.id)
	end
end

function slot0.getMountList(slot0)
	slot0.mountList = {
		ModuleEnum.SpineHangPointRoot
	}

	for slot4, slot5 in pairs(ModuleEnum.SpineHangPoint) do
		table.insert(slot0.mountList, slot5)
	end
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
	if not (tonumber(slot0.battleInput:GetText()) and lua_battle.configDict[slot2]) then
		slot4 = string.format("没有找到战斗id ：%s 对应的配置", slot2)

		logError(slot4)
		ToastController.instance:showToastWithString(slot4)

		return
	end

	slot4 = nil

	for slot8, slot9 in ipairs(lua_episode.configList) do
		if slot9.battleId == slot2 or slot9.firstBattleId == slot2 then
			slot4 = slot9

			break
		end
	end

	if not slot4 then
		logError("没有找到战斗id对应的关卡id")
		ToastController.instance:showToastWithString("没有找到战斗id对应的关卡id")

		return
	end

	slot5 = FightController.instance:setFightParamByBattleId(slot2)

	HeroGroupModel.instance:setParam(slot2, nil, )

	if not HeroGroupModel.instance:getCurGroupMO() then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	slot7, slot8 = slot6:getMainList()
	slot9, slot10 = slot6:getSubList()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, slot1)
	slot0:closeThis()

	slot5.episodeId = slot4.id
	FightResultModel.instance.episodeId = slot4.id

	DungeonModel.instance:SetSendChapterEpisodeId(slot4.chapterId, slot4.id)
	slot5:setMySide(slot6.clothId, slot7, slot9, slot6:getAllHeroEquips())
	FightController.instance:sendTestFightId(slot5)
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

function slot0.onClickSendASFDBtn(slot0)
	slot1 = tonumber(slot0.countASFDInput:GetText()) or 1
	slot3 = slot0.optionValueList[slot0.sideASFDDrop:GetValue() + 1]

	if not FightHelper.getEntity(slot0.toEntityASFDInput:GetText()) then
		slot6 = nil
		slot6 = (slot3 ~= FightEnum.TeamType.MySide or FightDataHelper.entityMgr:getEnemyNormalList()) and FightDataHelper.entityMgr:getMyNormalList()
		slot4 = slot6 and slot6[1] and slot6[1].id
		slot5 = FightHelper.getEntity(slot4)

		if not slot4 then
			ToastController.instance:showToastWithString("没有找到奥术飞弹目标实体")

			return
		end
	end

	for slot11 = 1, slot1 do
		slot12 = FightStepMO.New()

		slot12:init({
			cardIndex = 1,
			actType = 1,
			fromId = (FightDataHelper.entityMgr:getASFDEntityMo(slot3) or slot0:createASFDEmitter(slot3)).id,
			toId = slot4,
			actId = FightASFDConfig.instance.skillId,
			actEffect = {}
		})
		table.insert({}, slot12)
	end

	if slot0.asfdSequence then
		slot0.asfdSequence:stop()
	end

	slot0.asfdSequence = FlowSequence.New()

	for slot11, slot12 in ipairs(slot7) do
		slot0.asfdSequence:addWork(FightASFDFlow.New(slot12, slot7[slot11 + 1], slot11))
	end

	slot0.asfdSequence:start()
	slot0:closeThis()
end

function slot0.createASFDEmitter(slot0, slot1)
	slot2 = FightEntityMO.New()

	slot2:init({
		skin = 0,
		exSkillLevel = 0,
		userId = 0,
		career = 0,
		exSkill = 0,
		status = 0,
		position = 0,
		level = 0,
		teamType = 0,
		guard = 0,
		subCd = 0,
		exPoint = 0,
		shieldValue = 0,
		modelId = 0,
		uid = slot1 == FightEnum.TeamType.MySide and "99998" or "-99998",
		entityType = FightEnum.EntityType.ASFDEmitter,
		side = slot1,
		attr = {
			defense = 0,
			multiHpNum = 0,
			hp = 0,
			multiHpIdx = 0,
			mdefense = 0,
			technic = 0,
			attack = 0
		},
		buffs = {},
		skillGroup1 = {},
		skillGroup2 = {},
		passiveSkill = {},
		powerInfos = {},
		SummonedList = {}
	})

	slot2.side = slot1
	slot2 = FightDataHelper.entityMgr:addEntityMO(slot2)

	table.insert(FightDataHelper.entityMgr:getOriginASFDEmitterList(slot2.side), slot2)
	(GameSceneMgr.instance:getCurScene() and slot4.entityMgr):addASFDUnit()

	return slot2
end

function slot0.onClickBtnMount(slot0)
	slot2 = slot0.entityDrop:GetValue() + 1
	slot3 = slot0.mountDrop:GetValue() + 1

	if string.nilorempty(slot0.effectPath:GetText()) then
		ToastController.instance:showToastWithString("特效资源名 不能为空 ！")

		return
	end

	if not (slot0.entityList[slot2] and FightHelper.getEntity(slot4.id)) then
		ToastController.instance:showToastWithString("没有找到对应 entity 实体 ！")

		return
	end

	if slot5.effect:addHangEffect(slot1, slot0.mountList[slot3]) then
		slot7:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(slot5.id, slot7)
	end
end

return slot0
