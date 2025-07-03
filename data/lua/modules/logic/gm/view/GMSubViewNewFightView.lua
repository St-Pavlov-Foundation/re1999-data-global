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

	arg_4_0:addTitleSplitLine("奥术飞弹GM")
	arg_4_0:addLineIndex()

	arg_4_0.emitterList, arg_4_0.missileList, arg_4_0.explosionList = arg_4_0:getASFDUnitList()
	arg_4_0.emitterDrop = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "发射器特效配置:", arg_4_0.emitterList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})
	arg_4_0.missileDrop = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "飞弹特效配置:", arg_4_0.missileList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})
	arg_4_0.explosionDrop = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "爆点特效配置:", arg_4_0.explosionList, nil, nil, {
		fsize = 25,
		label_w = 100,
		total_w = 300,
		drop_w = 200
	})

	local var_4_0 = GMController.instance.emitterId and tostring(GMController.instance.emitterId) or arg_4_0.emitterList[1]
	local var_4_1 = GMController.instance.missileId and tostring(GMController.instance.missileId) or arg_4_0.missileList[1]
	local var_4_2 = GMController.instance.explosionId and tostring(GMController.instance.explosionId) or arg_4_0.explosionList[1]

	arg_4_0.emitterDrop:SetValue((tabletool.indexOf(arg_4_0.emitterList, var_4_0) or 1) - 1)
	arg_4_0.missileDrop:SetValue((tabletool.indexOf(arg_4_0.missileList, var_4_1) or 1) - 1)
	arg_4_0.explosionDrop:SetValue((tabletool.indexOf(arg_4_0.explosionList, var_4_2) or 1) - 1)
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

	arg_4_0:addTitleSplitLine("战中打印")
	arg_4_0:addLineIndex()

	arg_4_0.btnEnableFightLog = arg_4_0:addButton(arg_4_0:getLineGroup(), "开启战斗打印", arg_4_0.onClickEnableFightLog, arg_4_0)
	arg_4_0.btnLogAttr = arg_4_0:addButton(arg_4_0:getLineGroup(), "打印当前属性", arg_4_0.onClickLogAttr, arg_4_0)
	arg_4_0.btnLogBaseAttr = arg_4_0:addButton(arg_4_0:getLineGroup(), "打印基础属性", arg_4_0.onClickLogBaseAttr, arg_4_0)
	arg_4_0.btnLogLife = arg_4_0:addButton(arg_4_0:getLineGroup(), "打印生命百分比", arg_4_0.onClickLogLife, arg_4_0)
end

function var_0_0.getASFDUnitList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs(lua_fight_asfd.configList) do
		local var_5_3 = iter_5_1.unit

		if var_5_3 == FightEnum.ASFDUnit.Emitter then
			table.insert(var_5_0, tostring(iter_5_1.id))
		elseif var_5_3 == FightEnum.ASFDUnit.Missile then
			table.insert(var_5_1, tostring(iter_5_1.id))
		elseif var_5_3 == FightEnum.ASFDUnit.Explosion then
			table.insert(var_5_2, tostring(iter_5_1.id))
		end
	end

	return var_5_0, var_5_1, var_5_2
end

function var_0_0.getEntityNameList(arg_6_0)
	arg_6_0.entityNameList = {}
	arg_6_0.entityList = {}

	FightDataHelper.entityMgr:getAllEntityList(arg_6_0.entityList)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.entityList) do
		local var_6_0 = iter_6_1:getCO()
		local var_6_1 = var_6_0 and var_6_0.name

		var_6_1 = var_6_1 or iter_6_1.id

		table.insert(arg_6_0.entityNameList, var_6_1)
	end
end

function var_0_0.getMountList(arg_7_0)
	arg_7_0.mountList = {
		ModuleEnum.SpineHangPointRoot
	}

	for iter_7_0, iter_7_1 in pairs(ModuleEnum.SpineHangPoint) do
		table.insert(arg_7_0.mountList, iter_7_1)
	end
end

function var_0_0.addFightNumToggle(arg_8_0)
	arg_8_0.showFightNumToggle = arg_8_0:addToggle(arg_8_0:getLineGroup(), "显示战斗数值", arg_8_0.onFightNumToggleValueChange, arg_8_0)
	arg_8_0.showFightNumToggle.isOn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1
end

function var_0_0.addShowFightUIToggle(arg_9_0)
	arg_9_0.showFightUIToggle = arg_9_0:addToggle(arg_9_0:getLineGroup(), "显示战斗UI", arg_9_0.onFightUIToggleValueChange, arg_9_0)
	arg_9_0.showFightUIToggle.isOn = true
end

function var_0_0.onClickMyCardDeck(arg_10_0)
	FightRpc.instance:sendGetFightCardDeckDetailInfoRequest(FightRpc.DeckInfoRequestType.MySide)
end

function var_0_0.onClickEnemyCardDeck(arg_11_0)
	FightRpc.instance:sendGetFightCardDeckDetailInfoRequest(FightRpc.DeckInfoRequestType.EnemySide)
end

function var_0_0.onClickSendBtn(arg_12_0)
	local var_12_0 = arg_12_0.gmInput:GetText()

	if string.nilorempty(var_12_0) then
		return
	end

	GMRpc.instance:sendGMRequest(var_12_0)
end

function var_0_0.onClickBtnEnterFightByMonsterGroupId(arg_13_0)
	local var_13_0 = arg_13_0.battleInput:GetText()

	if not string.nilorempty(var_13_0) then
		local var_13_1 = string.splitToNumber(var_13_0, "#")

		if #var_13_1 > 0 then
			PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, var_13_0)
			HeroGroupModel.instance:setParam(nil, nil, nil)

			local var_13_2 = HeroGroupModel.instance:getCurGroupMO()

			if not var_13_2 then
				logError("current HeroGroupMO is nil")
				GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

				return
			end

			local var_13_3, var_13_4 = var_13_2:getMainList()
			local var_13_5, var_13_6 = var_13_2:getSubList()
			local var_13_7 = var_13_2:getAllHeroEquips()

			arg_13_0:closeThis()

			local var_13_8 = FightParam.New()

			var_13_8.monsterGroupIds = var_13_1
			var_13_8.isTestFight = true

			var_13_8:setSceneLevel(10601)
			var_13_8:setMySide(var_13_2.clothId, var_13_3, var_13_5, var_13_7)
			FightModel.instance:setFightParam(var_13_8)
			FightController.instance:sendTestFight(var_13_8)

			return
		end
	end
end

function var_0_0.onClickBtnEnterFightByBattleId(arg_14_0)
	local var_14_0 = arg_14_0.battleInput:GetText()
	local var_14_1 = tonumber(var_14_0)

	if not (var_14_1 and lua_battle.configDict[var_14_1]) then
		local var_14_2 = string.format("没有找到战斗id ：%s 对应的配置", var_14_1)

		logError(var_14_2)
		ToastController.instance:showToastWithString(var_14_2)

		return
	end

	local var_14_3

	for iter_14_0, iter_14_1 in ipairs(lua_episode.configList) do
		if iter_14_1.battleId == var_14_1 or iter_14_1.firstBattleId == var_14_1 then
			var_14_3 = iter_14_1

			break
		end
	end

	if not var_14_3 then
		logError("没有找到战斗id对应的关卡id")
		ToastController.instance:showToastWithString("没有找到战斗id对应的关卡id")

		return
	end

	local var_14_4 = FightController.instance:setFightParamByBattleId(var_14_1)

	HeroGroupModel.instance:setParam(var_14_1, nil, nil)

	local var_14_5 = HeroGroupModel.instance:getCurGroupMO()

	if not var_14_5 then
		logError("current HeroGroupMO is nil")
		GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

		return
	end

	local var_14_6, var_14_7 = var_14_5:getMainList()
	local var_14_8, var_14_9 = var_14_5:getSubList()
	local var_14_10 = var_14_5:getAllHeroEquips()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, var_14_0)
	arg_14_0:closeThis()

	var_14_4.episodeId = var_14_3.id
	FightResultModel.instance.episodeId = var_14_3.id

	DungeonModel.instance:SetSendChapterEpisodeId(var_14_3.chapterId, var_14_3.id)
	var_14_4:setMySide(var_14_5.clothId, var_14_6, var_14_8, var_14_10)
	FightController.instance:sendTestFightId(var_14_4)
end

function var_0_0.onClickSimulateBattle(arg_15_0)
	arg_15_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightSimulateView)
end

function var_0_0.onClickSkillEditor(arg_16_0)
	SkillEditorMgr.instance:start()
end

function var_0_0.onFightNumToggleValueChange(arg_17_0)
	local var_17_0 = arg_17_0.showFightNumToggle.isOn

	FightFloatMgr.instance:setCanShowFightNumUI(var_17_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FightShowFightNum, var_17_0 and 1 or 0)
end

function var_0_0.onFightUIToggleValueChange(arg_18_0)
	local var_18_0 = GMFightShowState.getList()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		GMFightShowState.setStatus(iter_18_1.valueKey, true)
	end

	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function var_0_0.onClickLockLifeMySide(arg_19_0)
	GMRpc.instance:sendGMRequest("fight lockLife 0")
end

function var_0_0.onClickLockLifeEnemySide(arg_20_0)
	GMRpc.instance:sendGMRequest("fight lockLife 1")
end

function var_0_0.onClickAddHurtMySide(arg_21_0)
	GMRpc.instance:sendGMRequest("fight addHurt 0")
end

function var_0_0.onClickAddHurtEnemySide(arg_22_0)
	GMRpc.instance:sendGMRequest("fight addHurt 1")
end

function var_0_0.onClickReduceDamageMySide(arg_23_0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 0")
end

function var_0_0.onClickReduceDamageEnemySide(arg_24_0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 1")
end

function var_0_0.onClickAddCost(arg_25_0)
	local var_25_0 = arg_25_0.costInput:GetText()

	if string.nilorempty(var_25_0) then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("fight addPower %s 0", var_25_0))
end

function var_0_0.onClickAddExPointMySide(arg_26_0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 0")
end

function var_0_0.onClickAddExPointEnemySide(arg_27_0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 1")
end

function var_0_0.onClickChangeCard(arg_28_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		arg_28_0:closeThis()
		ViewMgr.instance:openView(ViewName.GMResetCardsView)
	else
		GameFacade.showToast(ToastEnum.IconId, "not in fight")
	end
end

function var_0_0.onClickFightGm(arg_29_0)
	arg_29_0:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightEntityView)
end

function var_0_0.onClickEnableFightLog(arg_30_0)
	GMRpc.instance:sendGMRequest("fight log 2")
end

function var_0_0.onClickLogAttr(arg_31_0)
	GMRpc.instance:sendGMRequest("fight printAttrWithCompute")
end

function var_0_0.onClickLogBaseAttr(arg_32_0)
	GMRpc.instance:sendGMRequest("fight printAttr")
end

function var_0_0.onClickLogLife(arg_33_0)
	GMRpc.instance:sendGMRequest("fight printLife")
end

function var_0_0.onClickSendASFDBtn(arg_34_0)
	local var_34_0 = tonumber(arg_34_0.countASFDInput:GetText()) or 1
	local var_34_1 = arg_34_0.sideASFDDrop:GetValue() + 1
	local var_34_2 = arg_34_0.optionValueList[var_34_1]
	local var_34_3 = arg_34_0.toEntityASFDInput:GetText()

	if not FightHelper.getEntity(var_34_3) then
		local var_34_4

		if var_34_2 == FightEnum.TeamType.MySide then
			var_34_4 = FightDataHelper.entityMgr:getEnemyNormalList()
		else
			var_34_4 = FightDataHelper.entityMgr:getMyNormalList()
		end

		var_34_3 = var_34_4 and var_34_4[1] and var_34_4[1].id

		local var_34_5 = FightHelper.getEntity(var_34_3)

		if not var_34_3 then
			ToastController.instance:showToastWithString("没有找到奥术飞弹目标实体")

			return
		end
	end

	local var_34_6 = arg_34_0.emitterDrop:GetValue() + 1
	local var_34_7 = arg_34_0.missileDrop:GetValue() + 1
	local var_34_8 = arg_34_0.explosionDrop:GetValue() + 1

	GMController.instance:setRecordASFDCo(arg_34_0.emitterList[var_34_6], arg_34_0.missileList[var_34_7], arg_34_0.explosionList[var_34_8])
	GMController.instance:startASFDFlow(var_34_0, var_34_2, var_34_3)
	arg_34_0:closeThis()
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
