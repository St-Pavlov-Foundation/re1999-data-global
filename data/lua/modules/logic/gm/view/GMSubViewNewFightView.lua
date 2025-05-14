module("modules.logic.gm.view.GMSubViewNewFightView", package.seeall)

local var_0_0 = class("GMSubViewNewFightView", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "战斗·新"
end

function var_0_0.addLineIndex(arg_2_0)
	arg_2_0.lineIndex = arg_2_0.lineIndex + 1
end

function var_0_0.getLineGroup(arg_3_0)
	return "L" .. arg_3_0.lineIndex
end

function var_0_0.initViewContent(arg_4_0)
	if arg_4_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_4_0)

	arg_4_0.lineIndex = 0

	arg_4_0:addLineIndex()

	arg_4_0.gmInput = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "GM 命令 ...", nil, nil, {
		w = 500
	})
	arg_4_0.btnSend = arg_4_0:addButton(arg_4_0:getLineGroup(), "发送", arg_4_0.onClickSendBtn, arg_4_0)

	arg_4_0:addTitleSplitLine("战前GM")
	arg_4_0:addLineIndex()

	arg_4_0.battleInput = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "怪物组/战斗id")
	arg_4_0.btnEnterFightByMonsterGroupId = arg_4_0:addButton(arg_4_0:getLineGroup(), "进战斗怪物组", arg_4_0.onClickBtnEnterFightByMonsterGroupId, arg_4_0)
	arg_4_0.btnEnterFightByBattleId = arg_4_0:addButton(arg_4_0:getLineGroup(), "进战斗战斗ID", arg_4_0.onClickBtnEnterFightByBattleId, arg_4_0)

	arg_4_0:addLineIndex()

	arg_4_0.btnSimulateBattle = arg_4_0:addButton(arg_4_0:getLineGroup(), "战场模拟", arg_4_0.onClickSimulateBattle, arg_4_0)
	arg_4_0.btnSkillEditor = arg_4_0:addButton(arg_4_0:getLineGroup(), "技能编辑器", arg_4_0.onClickSkillEditor, arg_4_0)

	arg_4_0:addTitleSplitLine("战中GM")
	arg_4_0:addLineIndex()
	arg_4_0:addFightNumToggle()
	arg_4_0:addShowFightUIToggle()

	arg_4_0.btnLockLifeMySide = arg_4_0:addButton(arg_4_0:getLineGroup(), "我方锁血", arg_4_0.onClickLockLifeMySide, arg_4_0)
	arg_4_0.btnLockLifeEnemySide = arg_4_0:addButton(arg_4_0:getLineGroup(), "敌方锁血", arg_4_0.onClickLockLifeEnemySide, arg_4_0)

	arg_4_0:addLineIndex()

	arg_4_0.btnAddHurtMySide = arg_4_0:addButton(arg_4_0:getLineGroup(), "我方伤害*10", arg_4_0.onClickAddHurtMySide, arg_4_0)
	arg_4_0.btnAddHurtEnemySide = arg_4_0:addButton(arg_4_0:getLineGroup(), "敌方伤害*10", arg_4_0.onClickAddHurtEnemySide, arg_4_0)
	arg_4_0.btnReduceDamageMySide = arg_4_0:addButton(arg_4_0:getLineGroup(), "我方承伤/10", arg_4_0.onClickReduceDamageMySide, arg_4_0)
	arg_4_0.btnReduceDamageEnemySide = arg_4_0:addButton(arg_4_0:getLineGroup(), "敌方承伤/10", arg_4_0.onClickReduceDamageEnemySide, arg_4_0)

	arg_4_0:addLineIndex()

	arg_4_0.costInput = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "增加cost...")
	arg_4_0.btnAddCost = arg_4_0:addButton(arg_4_0:getLineGroup(), "增加cost", arg_4_0.onClickAddCost, arg_4_0)
	arg_4_0.btnAddExPointMySide = arg_4_0:addButton(arg_4_0:getLineGroup(), "获取我方激情", arg_4_0.onClickAddExPointMySide, arg_4_0)
	arg_4_0.btnAddExPointEnemySide = arg_4_0:addButton(arg_4_0:getLineGroup(), "获取敌方激情", arg_4_0.onClickAddExPointEnemySide, arg_4_0)

	arg_4_0:addLineIndex()

	arg_4_0.btnChangeCard = arg_4_0:addButton(arg_4_0:getLineGroup(), "修改手牌", arg_4_0.onClickChangeCard, arg_4_0)
	arg_4_0.btnFightGm = arg_4_0:addButton(arg_4_0:getLineGroup(), "战中外挂", arg_4_0.onClickFightGm, arg_4_0)

	arg_4_0:addButton(arg_4_0:getLineGroup(), "我方牌库", arg_4_0.onClickMyCardDeck, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "敌方牌库", arg_4_0.onClickEnemyCardDeck, arg_4_0)
	arg_4_0:addLineIndex()

	arg_4_0.countASFDInput = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "奥术飞弹数量...", nil, nil, {
		fsize = 30,
		w = 200
	})
	arg_4_0.optionStrList = {
		"我方",
		"敌方"
	}
	arg_4_0.optionValueList = {
		FightEnum.EntitySide.MySide,
		FightEnum.EntitySide.EnemySide
	}
	arg_4_0.sideASFDDrop = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "奥术飞弹发射方:", arg_4_0.optionStrList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})
	arg_4_0.toEntityASFDInput = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "奥术飞弹目标uid...")
	arg_4_0.btnSendASFD = arg_4_0:addButton(arg_4_0:getLineGroup(), "发射", arg_4_0.onClickSendASFDBtn, arg_4_0)

	arg_4_0:getEntityNameList()
	arg_4_0:getMountList()
	arg_4_0:addLineIndex()
	arg_4_0:addLabel(arg_4_0:getLineGroup(), "特效预览：", {
		fsize = 30,
		w = 100
	})

	arg_4_0.effectPath = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "特效资源名...")
	arg_4_0.entityDrop = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "挂载对象:", arg_4_0.entityNameList, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	arg_4_0.mountDrop = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "挂载节点:", arg_4_0.mountList, nil, nil, {
		total_w = 400,
		fsize = 25,
		drop_w = 300,
		label_w = 100,
		offsetMax = {
			-100,
			0
		}
	})
	arg_4_0.btnMount = arg_4_0:addButton(arg_4_0:getLineGroup(), "挂载", arg_4_0.onClickBtnMount, arg_4_0)

	arg_4_0:addTitleSplitLine("战中打印")
	arg_4_0:addLineIndex()

	arg_4_0.btnEnableFightLog = arg_4_0:addButton(arg_4_0:getLineGroup(), "开启战斗打印", arg_4_0.onClickEnableFightLog, arg_4_0)
	arg_4_0.btnLogAttr = arg_4_0:addButton(arg_4_0:getLineGroup(), "打印当前属性", arg_4_0.onClickLogAttr, arg_4_0)
	arg_4_0.btnLogBaseAttr = arg_4_0:addButton(arg_4_0:getLineGroup(), "打印基础属性", arg_4_0.onClickLogBaseAttr, arg_4_0)
	arg_4_0.btnLogLife = arg_4_0:addButton(arg_4_0:getLineGroup(), "打印生命百分比", arg_4_0.onClickLogLife, arg_4_0)
end

function var_0_0.getEntityNameList(arg_5_0)
	arg_5_0.entityNameList = {}
	arg_5_0.entityList = {}

	FightDataHelper.entityMgr:getAllEntityList(arg_5_0.entityList)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.entityList) do
		local var_5_0 = iter_5_1:getCO()
		local var_5_1 = var_5_0 and var_5_0.name

		var_5_1 = var_5_1 or iter_5_1.id

		table.insert(arg_5_0.entityNameList, var_5_1)
	end
end

function var_0_0.getMountList(arg_6_0)
	arg_6_0.mountList = {
		ModuleEnum.SpineHangPointRoot
	}

	for iter_6_0, iter_6_1 in pairs(ModuleEnum.SpineHangPoint) do
		table.insert(arg_6_0.mountList, iter_6_1)
	end
end

function var_0_0.addFightNumToggle(arg_7_0)
	arg_7_0.showFightNumToggle = arg_7_0:addToggle(arg_7_0:getLineGroup(), "显示战斗数值", arg_7_0.onFightNumToggleValueChange, arg_7_0)
	arg_7_0.showFightNumToggle.isOn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1
end

function var_0_0.addShowFightUIToggle(arg_8_0)
	arg_8_0.showFightUIToggle = arg_8_0:addToggle(arg_8_0:getLineGroup(), "显示战斗UI", arg_8_0.onFightUIToggleValueChange, arg_8_0)
	arg_8_0.showFightUIToggle.isOn = true
end

function var_0_0.onClickMyCardDeck(arg_9_0)
	FightRpc.instance:sendGetFightCardDeckDetailInfoRequest(FightRpc.DeckInfoRequestType.MySide)
end

function var_0_0.onClickEnemyCardDeck(arg_10_0)
	FightRpc.instance:sendGetFightCardDeckDetailInfoRequest(FightRpc.DeckInfoRequestType.EnemySide)
end

function var_0_0.onClickSendBtn(arg_11_0)
	local var_11_0 = arg_11_0.gmInput:GetText()

	if string.nilorempty(var_11_0) then
		return
	end

	GMRpc.instance:sendGMRequest(var_11_0)
end

function var_0_0.onClickBtnEnterFightByMonsterGroupId(arg_12_0)
	local var_12_0 = arg_12_0.battleInput:GetText()

	if not string.nilorempty(var_12_0) then
		local var_12_1 = string.splitToNumber(var_12_0, "#")

		if #var_12_1 > 0 then
			PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, var_12_0)
			HeroGroupModel.instance:setParam(nil, nil, nil)

			local var_12_2 = HeroGroupModel.instance:getCurGroupMO()

			if not var_12_2 then
				logError("current HeroGroupMO is nil")
				GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

				return
			end

			local var_12_3, var_12_4 = var_12_2:getMainList()
			local var_12_5, var_12_6 = var_12_2:getSubList()
			local var_12_7 = var_12_2:getAllHeroEquips()

			arg_12_0:closeThis()

			local var_12_8 = FightParam.New()

			var_12_8.monsterGroupIds = var_12_1
			var_12_8.isTestFight = true

			var_12_8:setSceneLevel(10601)
			var_12_8:setMySide(var_12_2.clothId, var_12_3, var_12_5, var_12_7)
			FightModel.instance:setFightParam(var_12_8)
			FightController.instance:sendTestFight(var_12_8)

			return
		end
	end
end

function var_0_0.onClickBtnEnterFightByBattleId(arg_13_0)
	local var_13_0 = arg_13_0.battleInput:GetText()
	local var_13_1 = tonumber(var_13_0)

	if not (var_13_1 and lua_battle.configDict[var_13_1]) then
		local var_13_2 = string.format("没有找到战斗id ：%s 对应的配置", var_13_1)

		logError(var_13_2)
		ToastController.instance:showToastWithString(var_13_2)

		return
	end

	local var_13_3

	for iter_13_0, iter_13_1 in ipairs(lua_episode.configList) do
		if iter_13_1.battleId == var_13_1 or iter_13_1.firstBattleId == var_13_1 then
			var_13_3 = iter_13_1

			break
		end
	end

	if not var_13_3 then
		logError("没有找到战斗id对应的关卡id")
		ToastController.instance:showToastWithString("没有找到战斗id对应的关卡id")

		return
	end

	local var_13_4 = FightController.instance:setFightParamByBattleId(var_13_1)

	HeroGroupModel.instance:setParam(var_13_1, nil, nil)

	local var_13_5 = HeroGroupModel.instance:getCurGroupMO()

	if not var_13_5 then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	local var_13_6, var_13_7 = var_13_5:getMainList()
	local var_13_8, var_13_9 = var_13_5:getSubList()
	local var_13_10 = var_13_5:getAllHeroEquips()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, var_13_0)
	arg_13_0:closeThis()

	var_13_4.episodeId = var_13_3.id
	FightResultModel.instance.episodeId = var_13_3.id

	DungeonModel.instance:SetSendChapterEpisodeId(var_13_3.chapterId, var_13_3.id)
	var_13_4:setMySide(var_13_5.clothId, var_13_6, var_13_8, var_13_10)
	FightController.instance:sendTestFightId(var_13_4)
end

function var_0_0.onClickSimulateBattle(arg_14_0)
	arg_14_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightSimulateView)
end

function var_0_0.onClickSkillEditor(arg_15_0)
	SkillEditorMgr.instance:start()
end

function var_0_0.onFightNumToggleValueChange(arg_16_0)
	local var_16_0 = arg_16_0.showFightNumToggle.isOn

	FightFloatMgr.instance:setCanShowFightNumUI(var_16_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FightShowFightNum, var_16_0 and 1 or 0)
end

function var_0_0.onFightUIToggleValueChange(arg_17_0)
	local var_17_0 = GMFightShowState.getList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		GMFightShowState.setStatus(iter_17_1.valueKey, true)
	end

	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function var_0_0.onClickLockLifeMySide(arg_18_0)
	GMRpc.instance:sendGMRequest("fight lockLife 0")
end

function var_0_0.onClickLockLifeEnemySide(arg_19_0)
	GMRpc.instance:sendGMRequest("fight lockLife 1")
end

function var_0_0.onClickAddHurtMySide(arg_20_0)
	GMRpc.instance:sendGMRequest("fight addHurt 0")
end

function var_0_0.onClickAddHurtEnemySide(arg_21_0)
	GMRpc.instance:sendGMRequest("fight addHurt 1")
end

function var_0_0.onClickReduceDamageMySide(arg_22_0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 0")
end

function var_0_0.onClickReduceDamageEnemySide(arg_23_0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 1")
end

function var_0_0.onClickAddCost(arg_24_0)
	local var_24_0 = arg_24_0.costInput:GetText()

	if string.nilorempty(var_24_0) then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("fight addPower %s 0", var_24_0))
end

function var_0_0.onClickAddExPointMySide(arg_25_0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 0")
end

function var_0_0.onClickAddExPointEnemySide(arg_26_0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 1")
end

function var_0_0.onClickChangeCard(arg_27_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		arg_27_0:closeThis()
		ViewMgr.instance:openView(ViewName.GMResetCardsView)
	else
		GameFacade.showToast(ToastEnum.IconId, "not in fight")
	end
end

function var_0_0.onClickFightGm(arg_28_0)
	arg_28_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightEntityView)
end

function var_0_0.onClickEnableFightLog(arg_29_0)
	GMRpc.instance:sendGMRequest("fight log 2")
end

function var_0_0.onClickLogAttr(arg_30_0)
	GMRpc.instance:sendGMRequest("fight printAttrWithCompute")
end

function var_0_0.onClickLogBaseAttr(arg_31_0)
	GMRpc.instance:sendGMRequest("fight printAttr")
end

function var_0_0.onClickLogLife(arg_32_0)
	GMRpc.instance:sendGMRequest("fight printLife")
end

function var_0_0.onClickSendASFDBtn(arg_33_0)
	local var_33_0 = tonumber(arg_33_0.countASFDInput:GetText()) or 1
	local var_33_1 = arg_33_0.sideASFDDrop:GetValue() + 1
	local var_33_2 = arg_33_0.optionValueList[var_33_1]
	local var_33_3 = arg_33_0.toEntityASFDInput:GetText()

	if not FightHelper.getEntity(var_33_3) then
		local var_33_4

		if var_33_2 == FightEnum.TeamType.MySide then
			var_33_4 = FightDataHelper.entityMgr:getEnemyNormalList()
		else
			var_33_4 = FightDataHelper.entityMgr:getMyNormalList()
		end

		var_33_3 = var_33_4 and var_33_4[1] and var_33_4[1].id

		local var_33_5 = FightHelper.getEntity(var_33_3)

		if not var_33_3 then
			ToastController.instance:showToastWithString("没有找到奥术飞弹目标实体")

			return
		end
	end

	local var_33_6 = FightDataHelper.entityMgr:getASFDEntityMo(var_33_2) or arg_33_0:createASFDEmitter(var_33_2)
	local var_33_7 = {}

	for iter_33_0 = 1, var_33_0 do
		local var_33_8 = FightStepMO.New()

		var_33_8:init({
			cardIndex = 1,
			actType = 1,
			fromId = var_33_6.id,
			toId = var_33_3,
			actId = FightASFDConfig.instance.skillId,
			actEffect = {}
		})
		table.insert(var_33_7, var_33_8)
	end

	if arg_33_0.asfdSequence then
		arg_33_0.asfdSequence:stop()
	end

	arg_33_0.asfdSequence = FlowSequence.New()

	for iter_33_1, iter_33_2 in ipairs(var_33_7) do
		local var_33_9 = FightASFDFlow.New(iter_33_2, var_33_7[iter_33_1 + 1], iter_33_1)

		arg_33_0.asfdSequence:addWork(var_33_9)
	end

	arg_33_0.asfdSequence:start()
	arg_33_0:closeThis()
end

function var_0_0.createASFDEmitter(arg_34_0, arg_34_1)
	local var_34_0 = FightEntityMO.New()

	var_34_0:init({
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
		uid = arg_34_1 == FightEnum.TeamType.MySide and "99998" or "-99998",
		entityType = FightEnum.EntityType.ASFDEmitter,
		side = arg_34_1,
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

	var_34_0.side = arg_34_1

	local var_34_1 = FightDataHelper.entityMgr:addEntityMO(var_34_0)
	local var_34_2 = FightDataHelper.entityMgr:getOriginASFDEmitterList(var_34_1.side)

	table.insert(var_34_2, var_34_1)

	local var_34_3 = GameSceneMgr.instance:getCurScene()

	;(var_34_3 and var_34_3.entityMgr):addASFDUnit()

	return var_34_1
end

function var_0_0.onClickBtnMount(arg_35_0)
	local var_35_0 = arg_35_0.effectPath:GetText()
	local var_35_1 = arg_35_0.entityDrop:GetValue() + 1
	local var_35_2 = arg_35_0.mountDrop:GetValue() + 1

	if string.nilorempty(var_35_0) then
		ToastController.instance:showToastWithString("特效资源名 不能为空 ！")

		return
	end

	local var_35_3 = arg_35_0.entityList[var_35_1]
	local var_35_4 = var_35_3 and FightHelper.getEntity(var_35_3.id)

	if not var_35_4 then
		ToastController.instance:showToastWithString("没有找到对应 entity 实体 ！")

		return
	end

	local var_35_5 = arg_35_0.mountList[var_35_2]
	local var_35_6 = var_35_4.effect:addHangEffect(var_35_0, var_35_5)

	if var_35_6 then
		var_35_6:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(var_35_4.id, var_35_6)
	end
end

return var_0_0
