module("modules.logic.gm.view.GMSubViewNewFightView", package.seeall)

local var_0_0 = class("GMSubViewNewFightView", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "战斗·新"
end

function var_0_0._onToggleValueChanged(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super._onToggleValueChanged(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0.scrollRect = gohelper.findChildComponent(arg_2_0._subViewGo, "viewport", gohelper.Type_ScrollRect)

	ZProj.UGUIHelper.RebuildLayout(arg_2_0.scrollRect:GetComponent(gohelper.Type_RectTransform))

	arg_2_0.scrollRect.verticalNormalizedPosition = 0.38659590482712
end

function var_0_0.addLineIndex(arg_3_0)
	arg_3_0.lineIndex = arg_3_0.lineIndex + 1
end

function var_0_0.getLineGroup(arg_4_0)
	return "L" .. arg_4_0.lineIndex
end

function var_0_0.initViewContent(arg_5_0)
	if arg_5_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_5_0)

	arg_5_0.lineIndex = 0

	arg_5_0:addLineIndex()

	arg_5_0.gmInput = arg_5_0:addInputText(arg_5_0:getLineGroup(), "", "GM 命令 ...", nil, nil, {
		w = 500
	})
	arg_5_0.btnSend = arg_5_0:addButton(arg_5_0:getLineGroup(), "发送", arg_5_0.onClickSendBtn, arg_5_0)

	arg_5_0:addTitleSplitLine("战前GM")
	arg_5_0:addLineIndex()

	arg_5_0.battleInput = arg_5_0:addInputText(arg_5_0:getLineGroup(), "", "怪物组/战斗id")
	arg_5_0.btnEnterFightByMonsterGroupId = arg_5_0:addButton(arg_5_0:getLineGroup(), "进战斗怪物组", arg_5_0.onClickBtnEnterFightByMonsterGroupId, arg_5_0)
	arg_5_0.btnEnterFightByBattleId = arg_5_0:addButton(arg_5_0:getLineGroup(), "进战斗战斗ID", arg_5_0.onClickBtnEnterFightByBattleId, arg_5_0)

	arg_5_0:addLineIndex()

	arg_5_0.btnSimulateBattle = arg_5_0:addButton(arg_5_0:getLineGroup(), "战场模拟", arg_5_0.onClickSimulateBattle, arg_5_0)
	arg_5_0.btnSkillEditor = arg_5_0:addButton(arg_5_0:getLineGroup(), "技能编辑器", arg_5_0.onClickSkillEditor, arg_5_0)

	arg_5_0:addLineIndex()
	arg_5_0:initFightFloatCo()

	arg_5_0.fightFloatDrop = arg_5_0:addDropDown(arg_5_0:getLineGroup(), "战斗飘字:", arg_5_0.floatPrefabList)

	local var_5_0 = GMController.instance:getFightFloatPath()
	local var_5_1 = 1

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.floatPrefabList) do
		if iter_5_1 == var_5_0 then
			var_5_1 = iter_5_0

			break
		end
	end

	arg_5_0.fightFloatDrop:SetValue(var_5_1 - 1)

	arg_5_0.btnReplaceFloatPrefab = arg_5_0:addButton(arg_5_0:getLineGroup(), "替换战斗飘字", arg_5_0.onClickReplaceFloatPrefab, arg_5_0)

	arg_5_0:addTitleSplitLine("战中GM")
	arg_5_0:addLineIndex()
	arg_5_0:addFightNumToggle()
	arg_5_0:addShowFightUIToggle()

	arg_5_0.btnLockLifeMySide = arg_5_0:addButton(arg_5_0:getLineGroup(), "我方锁血", arg_5_0.onClickLockLifeMySide, arg_5_0)
	arg_5_0.btnLockLifeEnemySide = arg_5_0:addButton(arg_5_0:getLineGroup(), "敌方锁血", arg_5_0.onClickLockLifeEnemySide, arg_5_0)
	arg_5_0.btnLogSkin = arg_5_0:addButton(arg_5_0:getLineGroup(), "打印皮肤id", arg_5_0.onClickLogSkinBtn, arg_5_0)

	arg_5_0:addLineIndex()

	arg_5_0.btnAddHurtMySide = arg_5_0:addButton(arg_5_0:getLineGroup(), "我方伤害*10", arg_5_0.onClickAddHurtMySide, arg_5_0)
	arg_5_0.btnAddHurtEnemySide = arg_5_0:addButton(arg_5_0:getLineGroup(), "敌方伤害*10", arg_5_0.onClickAddHurtEnemySide, arg_5_0)
	arg_5_0.btnReduceDamageMySide = arg_5_0:addButton(arg_5_0:getLineGroup(), "我方承伤/10", arg_5_0.onClickReduceDamageMySide, arg_5_0)
	arg_5_0.btnReduceDamageEnemySide = arg_5_0:addButton(arg_5_0:getLineGroup(), "敌方承伤/10", arg_5_0.onClickReduceDamageEnemySide, arg_5_0)

	arg_5_0:addLineIndex()

	arg_5_0.costInput = arg_5_0:addInputText(arg_5_0:getLineGroup(), "", "增加cost...")
	arg_5_0.btnAddCost = arg_5_0:addButton(arg_5_0:getLineGroup(), "增加cost", arg_5_0.onClickAddCost, arg_5_0)
	arg_5_0.btnAddExPointMySide = arg_5_0:addButton(arg_5_0:getLineGroup(), "获取我方激情", arg_5_0.onClickAddExPointMySide, arg_5_0)
	arg_5_0.btnAddExPointEnemySide = arg_5_0:addButton(arg_5_0:getLineGroup(), "获取敌方激情", arg_5_0.onClickAddExPointEnemySide, arg_5_0)

	arg_5_0:addLineIndex()

	arg_5_0.btnChangeCard = arg_5_0:addButton(arg_5_0:getLineGroup(), "修改手牌", arg_5_0.onClickChangeCard, arg_5_0)
	arg_5_0.btnFightGm = arg_5_0:addButton(arg_5_0:getLineGroup(), "战中外挂", arg_5_0.onClickFightGm, arg_5_0)

	arg_5_0:addButton(arg_5_0:getLineGroup(), "我方牌库", arg_5_0.onClickMyCardDeck, arg_5_0)
	arg_5_0:addButton(arg_5_0:getLineGroup(), "敌方牌库", arg_5_0.onClickEnemyCardDeck, arg_5_0)
	arg_5_0:getEntityNameList()
	arg_5_0:getMountList()
	arg_5_0:addLineIndex()
	arg_5_0:addLabel(arg_5_0:getLineGroup(), "特效预览：", {
		fsize = 30,
		w = 100
	})

	arg_5_0.effectPath = arg_5_0:addInputText(arg_5_0:getLineGroup(), "", "特效资源名...")
	arg_5_0.entityDrop = arg_5_0:addDropDown(arg_5_0:getLineGroup(), "挂载对象:", arg_5_0.entityNameList, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	arg_5_0.mountDrop = arg_5_0:addDropDown(arg_5_0:getLineGroup(), "挂载节点:", arg_5_0.mountList, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	arg_5_0.btnMount = arg_5_0:addButton(arg_5_0:getLineGroup(), "挂载", arg_5_0.onClickBtnMount, arg_5_0)

	arg_5_0:addLineIndex()
	arg_5_0:addLabel(arg_5_0:getLineGroup(), "播放timeline：", {
		fsize = 30,
		w = 100
	})

	arg_5_0.skillIdInput = arg_5_0:addInputText(arg_5_0:getLineGroup(), "", "技能id")
	arg_5_0.playTimelineEntityDrop = arg_5_0:addDropDown(arg_5_0:getLineGroup(), "技能释放者:", arg_5_0.entityNameList, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	arg_5_0.targetEnumDrop = arg_5_0:addDropDown(arg_5_0:getLineGroup(), "群体or单体:", {
		"单体",
		"群体"
	}, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	arg_5_0.btnPlayTimeline = arg_5_0:addButton(arg_5_0:getLineGroup(), "播放timeline", arg_5_0.onClickBtnPlayTimeline, arg_5_0)

	arg_5_0:addLineIndex()
	arg_5_0:addLabel(arg_5_0:getLineGroup(), "播放指定动作：", {
		fsize = 30,
		w = 100
	})

	arg_5_0.actionNameInput = arg_5_0:addInputText(arg_5_0:getLineGroup(), "", "动作名称")
	arg_5_0.actionEntityDrop = arg_5_0:addDropDown(arg_5_0:getLineGroup(), "动作播放者:", arg_5_0.entityNameList, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	arg_5_0.btnPlayAction = arg_5_0:addButton(arg_5_0:getLineGroup(), "播放动作", arg_5_0.onClickBtnPlayAction, arg_5_0)
	arg_5_0.btnActionReset = arg_5_0:addButton(arg_5_0:getLineGroup(), "动作复原", arg_5_0.onClickBtnActionReset, arg_5_0)

	arg_5_0:addTitleSplitLine("奥术飞弹GM")
	arg_5_0:addLineIndex()

	arg_5_0.emitterList, arg_5_0.missileList, arg_5_0.explosionList = arg_5_0:getASFDUnitList()
	arg_5_0.emitterDrop = arg_5_0:addDropDown(arg_5_0:getLineGroup(), "发射器特效配置:", arg_5_0.emitterList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})
	arg_5_0.missileDrop = arg_5_0:addDropDown(arg_5_0:getLineGroup(), "飞弹特效配置:", arg_5_0.missileList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})
	arg_5_0.explosionDrop = arg_5_0:addDropDown(arg_5_0:getLineGroup(), "爆点特效配置:", arg_5_0.explosionList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})

	local var_5_2 = GMController.instance.emitterId and tostring(GMController.instance.emitterId) or arg_5_0.emitterList[1]
	local var_5_3 = GMController.instance.missileId and tostring(GMController.instance.missileId) or arg_5_0.missileList[1]
	local var_5_4 = GMController.instance.explosionId and tostring(GMController.instance.explosionId) or arg_5_0.explosionList[1]

	arg_5_0.emitterDrop:SetValue((tabletool.indexOf(arg_5_0.emitterList, var_5_2) or 1) - 1)
	arg_5_0.missileDrop:SetValue((tabletool.indexOf(arg_5_0.missileList, var_5_3) or 1) - 1)
	arg_5_0.explosionDrop:SetValue((tabletool.indexOf(arg_5_0.explosionList, var_5_4) or 1) - 1)
	arg_5_0:addLineIndex()

	arg_5_0.countASFDInput = arg_5_0:addInputText(arg_5_0:getLineGroup(), "", "奥术飞弹数量...", nil, nil, {
		fsize = 30,
		w = 200
	})
	arg_5_0.optionStrList = {
		"我方",
		"敌方"
	}
	arg_5_0.optionValueList = {
		FightEnum.EntitySide.MySide,
		FightEnum.EntitySide.EnemySide
	}
	arg_5_0.sideASFDDrop = arg_5_0:addDropDown(arg_5_0:getLineGroup(), "奥术飞弹发射方:", arg_5_0.optionStrList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})
	arg_5_0.toEntityASFDInput = arg_5_0:addInputText(arg_5_0:getLineGroup(), "", "奥术飞弹目标uid...")
	arg_5_0.btnSendASFD = arg_5_0:addButton(arg_5_0:getLineGroup(), "发射", arg_5_0.onClickSendASFDBtn, arg_5_0)

	arg_5_0:addTitleSplitLine("战中打印")
	arg_5_0:addLineIndex()

	arg_5_0.btnEnableFightLog = arg_5_0:addButton(arg_5_0:getLineGroup(), "开启战斗打印", arg_5_0.onClickEnableFightLog, arg_5_0)
	arg_5_0.btnLogAttr = arg_5_0:addButton(arg_5_0:getLineGroup(), "打印当前属性", arg_5_0.onClickLogAttr, arg_5_0)
	arg_5_0.btnLogBaseAttr = arg_5_0:addButton(arg_5_0:getLineGroup(), "打印基础属性", arg_5_0.onClickLogBaseAttr, arg_5_0)
	arg_5_0.btnLogLife = arg_5_0:addButton(arg_5_0:getLineGroup(), "打印生命百分比", arg_5_0.onClickLogLife, arg_5_0)
end

function var_0_0.initFightFloatCo(arg_6_0)
	arg_6_0.floatPrefabList = {}

	for iter_6_0, iter_6_1 in ipairs(lua_fight_float_effect.configList) do
		table.insert(arg_6_0.floatPrefabList, iter_6_1.prefabPath)
	end
end

function var_0_0.getASFDUnitList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in ipairs(lua_fight_asfd.configList) do
		local var_7_3 = iter_7_1.unit

		if var_7_3 == FightEnum.ASFDUnit.Emitter then
			table.insert(var_7_0, tostring(iter_7_1.id))
		elseif var_7_3 == FightEnum.ASFDUnit.Missile then
			table.insert(var_7_1, tostring(iter_7_1.id))
		elseif var_7_3 == FightEnum.ASFDUnit.Explosion then
			table.insert(var_7_2, tostring(iter_7_1.id))
		end
	end

	return var_7_0, var_7_1, var_7_2
end

function var_0_0.getEntityNameList(arg_8_0)
	arg_8_0.entityNameList = {}
	arg_8_0.entityList = {}

	FightDataHelper.entityMgr:getAllEntityList(arg_8_0.entityList)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.entityList) do
		local var_8_0 = iter_8_1:getCO()
		local var_8_1 = var_8_0 and var_8_0.name

		var_8_1 = var_8_1 or iter_8_1.id

		table.insert(arg_8_0.entityNameList, var_8_1)
	end
end

function var_0_0.getMountList(arg_9_0)
	arg_9_0.mountList = {
		ModuleEnum.SpineHangPointRoot
	}

	for iter_9_0, iter_9_1 in pairs(ModuleEnum.SpineHangPoint) do
		table.insert(arg_9_0.mountList, iter_9_1)
	end
end

function var_0_0.addFightNumToggle(arg_10_0)
	arg_10_0.showFightNumToggle = arg_10_0:addToggle(arg_10_0:getLineGroup(), "显示战斗数值", arg_10_0.onFightNumToggleValueChange, arg_10_0)
	arg_10_0.showFightNumToggle.isOn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1
end

function var_0_0.addShowFightUIToggle(arg_11_0)
	arg_11_0.showFightUIToggle = arg_11_0:addToggle(arg_11_0:getLineGroup(), "显示战斗UI", arg_11_0.onFightUIToggleValueChange, arg_11_0)
	arg_11_0.showFightUIToggle.isOn = true
end

function var_0_0.onClickMyCardDeck(arg_12_0)
	FightRpc.instance:sendGetFightCardDeckDetailInfoRequest(FightRpc.DeckInfoRequestType.MySide)
end

function var_0_0.onClickEnemyCardDeck(arg_13_0)
	FightRpc.instance:sendGetFightCardDeckDetailInfoRequest(FightRpc.DeckInfoRequestType.EnemySide)
end

function var_0_0.onClickSendBtn(arg_14_0)
	local var_14_0 = arg_14_0.gmInput:GetText()

	if string.nilorempty(var_14_0) then
		return
	end

	GMRpc.instance:sendGMRequest(var_14_0)
end

function var_0_0.onClickBtnEnterFightByMonsterGroupId(arg_15_0)
	local var_15_0 = arg_15_0.battleInput:GetText()

	if not string.nilorempty(var_15_0) then
		local var_15_1 = string.splitToNumber(var_15_0, "#")

		if #var_15_1 > 0 then
			PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, var_15_0)
			HeroGroupModel.instance:setParam(nil, nil, nil)

			local var_15_2 = HeroGroupModel.instance:getCurGroupMO()

			if not var_15_2 then
				logError("current HeroGroupMO is nil")
				GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

				return
			end

			local var_15_3, var_15_4 = var_15_2:getMainList()
			local var_15_5, var_15_6 = var_15_2:getSubList()
			local var_15_7 = var_15_2:getAllHeroEquips()

			arg_15_0:closeThis()

			local var_15_8 = FightParam.New()

			var_15_8.monsterGroupIds = var_15_1
			var_15_8.isTestFight = true

			var_15_8:setSceneLevel(10601)
			var_15_8:setMySide(var_15_2.clothId, var_15_3, var_15_5, var_15_7)
			FightModel.instance:setFightParam(var_15_8)
			FightController.instance:sendTestFight(var_15_8)

			return
		end
	end
end

function var_0_0.onClickBtnEnterFightByBattleId(arg_16_0)
	local var_16_0 = arg_16_0.battleInput:GetText()
	local var_16_1 = tonumber(var_16_0)

	if not (var_16_1 and lua_battle.configDict[var_16_1]) then
		local var_16_2 = string.format("没有找到战斗id ：%s 对应的配置", var_16_1)

		logError(var_16_2)
		ToastController.instance:showToastWithString(var_16_2)

		return
	end

	local var_16_3

	for iter_16_0, iter_16_1 in ipairs(lua_episode.configList) do
		if iter_16_1.battleId == var_16_1 or iter_16_1.firstBattleId == var_16_1 then
			var_16_3 = iter_16_1

			break
		end
	end

	if not var_16_3 then
		logError("没有找到战斗id对应的关卡id")
		ToastController.instance:showToastWithString("没有找到战斗id对应的关卡id")

		return
	end

	local var_16_4 = FightController.instance:setFightParamByBattleId(var_16_1)

	HeroGroupModel.instance:setParam(var_16_1, nil, nil)

	local var_16_5 = HeroGroupModel.instance:getCurGroupMO()

	if not var_16_5 then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	local var_16_6, var_16_7 = var_16_5:getMainList()
	local var_16_8, var_16_9 = var_16_5:getSubList()
	local var_16_10 = var_16_5:getAllHeroEquips()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, var_16_0)
	arg_16_0:closeThis()

	var_16_4.episodeId = var_16_3.id
	FightResultModel.instance.episodeId = var_16_3.id

	DungeonModel.instance:SetSendChapterEpisodeId(var_16_3.chapterId, var_16_3.id)
	var_16_4:setMySide(var_16_5.clothId, var_16_6, var_16_8, var_16_10)
	FightController.instance:sendTestFightId(var_16_4)
end

function var_0_0.onClickSimulateBattle(arg_17_0)
	arg_17_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightSimulateView)
end

function var_0_0.onClickSkillEditor(arg_18_0)
	SkillEditorMgr.instance:start()
end

function var_0_0.onFightNumToggleValueChange(arg_19_0)
	local var_19_0 = arg_19_0.showFightNumToggle.isOn

	FightFloatMgr.instance:setCanShowFightNumUI(var_19_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FightShowFightNum, var_19_0 and 1 or 0)
end

function var_0_0.onFightUIToggleValueChange(arg_20_0)
	local var_20_0 = GMFightShowState.getList()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		GMFightShowState.setStatus(iter_20_1.valueKey, true)
	end

	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function var_0_0.onClickLockLifeMySide(arg_21_0)
	GMRpc.instance:sendGMRequest("fight lockLife 0")
end

function var_0_0.onClickLockLifeEnemySide(arg_22_0)
	GMRpc.instance:sendGMRequest("fight lockLife 1")
end

function var_0_0.onClickAddHurtMySide(arg_23_0)
	GMRpc.instance:sendGMRequest("fight addHurt 0")
end

function var_0_0.onClickAddHurtEnemySide(arg_24_0)
	GMRpc.instance:sendGMRequest("fight addHurt 1")
end

function var_0_0.onClickReduceDamageMySide(arg_25_0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 0")
end

function var_0_0.onClickReduceDamageEnemySide(arg_26_0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 1")
end

function var_0_0.onClickAddCost(arg_27_0)
	local var_27_0 = arg_27_0.costInput:GetText()

	if string.nilorempty(var_27_0) then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("fight addPower %s 0", var_27_0))
end

function var_0_0.onClickAddExPointMySide(arg_28_0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 0")
end

function var_0_0.onClickAddExPointEnemySide(arg_29_0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 1")
end

function var_0_0.onClickChangeCard(arg_30_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		arg_30_0:closeThis()
		ViewMgr.instance:openView(ViewName.GMResetCardsView)
	else
		GameFacade.showToast(ToastEnum.IconId, "not in fight")
	end
end

function var_0_0.onClickFightGm(arg_31_0)
	arg_31_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightEntityView)
end

function var_0_0.onClickEnableFightLog(arg_32_0)
	GMRpc.instance:sendGMRequest("fight log 2")
end

function var_0_0.onClickLogAttr(arg_33_0)
	GMRpc.instance:sendGMRequest("fight printAttrWithCompute")
end

function var_0_0.onClickLogBaseAttr(arg_34_0)
	GMRpc.instance:sendGMRequest("fight printAttr")
end

function var_0_0.onClickLogLife(arg_35_0)
	GMRpc.instance:sendGMRequest("fight printLife")
end

function var_0_0.onClickSendASFDBtn(arg_36_0)
	local var_36_0 = tonumber(arg_36_0.countASFDInput:GetText()) or 1
	local var_36_1 = arg_36_0.sideASFDDrop:GetValue() + 1
	local var_36_2 = arg_36_0.optionValueList[var_36_1]
	local var_36_3 = arg_36_0.toEntityASFDInput:GetText()

	if not FightHelper.getEntity(var_36_3) then
		local var_36_4

		if var_36_2 == FightEnum.TeamType.MySide then
			var_36_4 = FightDataHelper.entityMgr:getEnemyNormalList()
		else
			var_36_4 = FightDataHelper.entityMgr:getMyNormalList()
		end

		var_36_3 = var_36_4 and var_36_4[1] and var_36_4[1].id

		local var_36_5 = FightHelper.getEntity(var_36_3)

		if not var_36_3 then
			ToastController.instance:showToastWithString("没有找到奥术飞弹目标实体")

			return
		end
	end

	local var_36_6 = arg_36_0.emitterDrop:GetValue() + 1
	local var_36_7 = arg_36_0.missileDrop:GetValue() + 1
	local var_36_8 = arg_36_0.explosionDrop:GetValue() + 1

	GMController.instance:setRecordASFDCo(arg_36_0.emitterList[var_36_6], arg_36_0.missileList[var_36_7], arg_36_0.explosionList[var_36_8])
	GMController.instance:startASFDFlow(var_36_0, var_36_2, var_36_3)
	arg_36_0:closeThis()
end

function var_0_0.onClickBtnMount(arg_37_0)
	local var_37_0 = arg_37_0.effectPath:GetText()
	local var_37_1 = arg_37_0.entityDrop:GetValue() + 1
	local var_37_2 = arg_37_0.mountDrop:GetValue() + 1

	if string.nilorempty(var_37_0) then
		ToastController.instance:showToastWithString("特效资源名 不能为空 ！")

		return
	end

	local var_37_3 = arg_37_0.entityList[var_37_1]
	local var_37_4 = var_37_3 and FightHelper.getEntity(var_37_3.id)

	if not var_37_4 then
		ToastController.instance:showToastWithString("没有找到对应 entity 实体 ！")

		return
	end

	local var_37_5 = arg_37_0.mountList[var_37_2]
	local var_37_6 = var_37_4.effect:addHangEffect(var_37_0, var_37_5)

	if var_37_6 then
		var_37_6:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(var_37_4.id, var_37_6)
	end

	arg_37_0:closeThis()
end

function var_0_0.onClickBtnPlayTimeline(arg_38_0)
	local var_38_0 = arg_38_0.skillIdInput:GetText()
	local var_38_1

	var_38_1 = tonumber(var_38_0) or 0

	local var_38_2 = lua_skill.configDict[var_38_1]

	if not var_38_2 then
		ToastController.instance:showToastWithString("技能不存在 ！")

		return
	end

	local var_38_3 = var_38_2.timeline

	if string.nilorempty(var_38_3) then
		ToastController.instance:showToastWithString("技能不存在timeline ！")

		return
	end

	local var_38_4 = arg_38_0.playTimelineEntityDrop:GetValue() + 1
	local var_38_5 = arg_38_0.entityList[var_38_4]
	local var_38_6 = var_38_5 and FightHelper.getEntity(var_38_5.id)

	if not var_38_6 then
		ToastController.instance:showToastWithString("没有找到对应 entity 实体 ！")

		return
	end

	local var_38_7 = arg_38_0.targetEnumDrop:GetValue() == 0
	local var_38_8 = var_38_5.side == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	local var_38_9 = FightDataHelper.entityMgr:getNormalList(var_38_8)
	local var_38_10 = FightStepData.New()

	var_38_10.actType = 1
	var_38_10.fromId = var_38_5.id
	var_38_10.toId = var_38_9[1].uid
	var_38_10.actId = var_38_1
	var_38_10.actEffect = {}

	arg_38_0:buildDamageEffect(var_38_7, var_38_9, var_38_10.actEffect)
	var_38_6.skill:playSkill(var_38_1, var_38_10)
	arg_38_0:closeThis()
end

function var_0_0.buildDamageEffect(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	for iter_39_0 = 1, #arg_39_2 do
		if iter_39_0 == 1 or not arg_39_1 then
			table.insert(arg_39_3, arg_39_0:createDamageActEffect(arg_39_2[iter_39_0].uid, math.random(1, 100)))
		end
	end
end

function var_0_0.createDamageActEffect(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = FightActEffectData.New()

	var_40_0.targetId = arg_40_1
	var_40_0.effectType = FightEnum.EffectType.DAMAGE
	var_40_0.effectNum = arg_40_2

	return var_40_0
end

function var_0_0.onClickReplaceFloatPrefab(arg_41_0)
	local var_41_0 = arg_41_0.fightFloatDrop:GetValue() + 1
	local var_41_1 = arg_41_0.floatPrefabList[var_41_0]

	GMController.instance:setFightFloatPath(var_41_1)
	GMController.instance:replaceGetFloatPathFunc()
end

function var_0_0.onClickBtnPlayAction(arg_42_0)
	local var_42_0 = arg_42_0.actionNameInput:GetText()

	if string.nilorempty(var_42_0) then
		return
	end

	local var_42_1 = arg_42_0.actionEntityDrop:GetValue() + 1
	local var_42_2 = arg_42_0.entityList[var_42_1]
	local var_42_3 = var_42_2 and FightHelper.getEntity(var_42_2.id)

	if not var_42_3 then
		ToastController.instance:showToastWithString("没有找到对应 entity 实体 ！")

		return
	end

	var_42_3.spine:play(var_42_0, nil, true)
	arg_42_0:closeThis()
end

function var_0_0.onClickBtnActionReset(arg_43_0)
	local var_43_0 = arg_43_0.actionEntityDrop:GetValue() + 1
	local var_43_1 = arg_43_0.entityList[var_43_0]
	local var_43_2 = var_43_1 and FightHelper.getEntity(var_43_1.id)

	if not var_43_2 then
		ToastController.instance:showToastWithString("没有找到对应 entity 实体 ！")

		return
	end

	var_43_2:resetAnimState()
	arg_43_0:closeThis()
end

function var_0_0.onClickLogSkinBtn(arg_44_0)
	for iter_44_0, iter_44_1 in ipairs(arg_44_0.entityList) do
		local var_44_0 = FightHelper.getEntity(iter_44_1.id)
		local var_44_1 = iter_44_1:getCO()
		local var_44_2 = var_44_1 and var_44_1.name

		var_44_2 = var_44_2 or iter_44_1.id

		local var_44_3 = string.format("entityId : %s, entityName : %s, skinId : %s, goName : %s", iter_44_1.id, var_44_2, iter_44_1.skin, var_44_0.go.name)

		logError(var_44_3)
	end
end

return var_0_0
