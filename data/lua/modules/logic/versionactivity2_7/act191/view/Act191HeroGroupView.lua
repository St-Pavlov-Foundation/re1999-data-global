module("modules.logic.versionactivity2_7.act191.view.Act191HeroGroupView", package.seeall)

local var_0_0 = class("Act191HeroGroupView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/btnContain/horizontal/#btn_Start")
	arg_1_0._scrollInfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "container/#scroll_Info")
	arg_1_0._imageRank = gohelper.findChildImage(arg_1_0.viewGO, "container/#scroll_Info/infocontain/enemyrank/bg/txt_Name/#image_Rank")
	arg_1_0._btnEnemy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#scroll_Info/infocontain/enemycontain/enemytitle/#btn_Enemy")
	arg_1_0._goEnemyTeam = gohelper.findChild(arg_1_0.viewGO, "container/#scroll_Info/infocontain/enemycontain/enemyList/#go_EnemyTeam")
	arg_1_0._goSelectedBg = gohelper.findChild(arg_1_0.viewGO, "container/#scroll_Info/infocontain/autofight/#go_SelectedBg")
	arg_1_0._goUnSelectBg = gohelper.findChild(arg_1_0.viewGO, "container/#scroll_Info/infocontain/autofight/#go_UnSelectBg")
	arg_1_0._goRewardList = gohelper.findChild(arg_1_0.viewGO, "container/#scroll_Info/infocontain/autofight/#go_RewardList")
	arg_1_0._goRewardItem = gohelper.findChild(arg_1_0.viewGO, "container/#scroll_Info/infocontain/autofight/#go_RewardList/#go_RewardItem")
	arg_1_0._toggleAutoFight = gohelper.findChildToggle(arg_1_0.viewGO, "container/#scroll_Info/infocontain/autofight/bg/#toggle_AutoFight")
	arg_1_0._btnDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "herogroupcontain/subTitle/txt_TeamLvlS/#btn_Detail")
	arg_1_0._goDetail = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/subTitle/txt_TeamLvlS/#go_Detail")
	arg_1_0._btnCloseDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "herogroupcontain/subTitle/txt_TeamLvlS/#go_Detail/#btn_CloseDetail")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStart:AddClickListener(arg_2_0._btnStartOnClick, arg_2_0)
	arg_2_0._btnEnemy:AddClickListener(arg_2_0._btnEnemyOnClick, arg_2_0)
	arg_2_0._btnDetail:AddClickListener(arg_2_0._btnDetailOnClick, arg_2_0)
	arg_2_0._btnCloseDetail:AddClickListener(arg_2_0._btnCloseDetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStart:RemoveClickListener()
	arg_3_0._btnEnemy:RemoveClickListener()
	arg_3_0._btnDetail:RemoveClickListener()
	arg_3_0._btnCloseDetail:RemoveClickListener()
end

function var_0_0._btnDetailOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._goDetail, true)
end

function var_0_0._btnCloseDetailOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._goDetail, false)
end

function var_0_0._btnStartOnClick(arg_6_0)
	if arg_6_0.fighting then
		return
	end

	if not arg_6_0.gameInfo:teamHasMainHero() then
		GameFacade.showToast(ToastEnum.Act191StartFightTip)

		return
	end

	local var_6_0 = DungeonModel.instance.curSendEpisodeId
	local var_6_1 = DungeonConfig.instance:getEpisodeCO(var_6_0)
	local var_6_2 = var_6_1.battleId

	FightController.instance:setFightParamByEpisodeAndBattle(var_6_0, var_6_2):setDungeon(var_6_1.chapterId, var_6_0)
	DungeonRpc.instance:sendStartDungeonRequest(var_6_1.chapterId, var_6_0)

	arg_6_0.fighting = true
end

function var_0_0._btnEnemyOnClick(arg_7_0)
	if not arg_7_0.isPvp then
		local var_7_0 = FightModel.instance:getFightParam()

		EnemyInfoController.instance:openAct191EnemyInfoView(var_7_0.battleId)
	else
		ViewMgr.instance:openView(ViewName.Act191EnemyInfoView, arg_7_0.nodeDetailMo)
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.anim = arg_8_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_8_0._monsterGroupItemList = {}
	arg_8_0.actId = Activity191Model.instance:getCurActId()
	arg_8_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	local var_8_0 = arg_8_0.gameInfo:getTeamInfo()

	arg_8_0._toggleAutoFight.isOn = var_8_0 and var_8_0.auto or false

	arg_8_0._toggleAutoFight:AddOnValueChanged(arg_8_0.onToggleValueChanged, arg_8_0)

	arg_8_0.goAutoFight = gohelper.findChild(arg_8_0._goRewardList, "mask/#autofight")

	gohelper.setActive(arg_8_0.goAutoFight, arg_8_0._toggleAutoFight.isOn)

	arg_8_0.rewardItemList = {}
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	Act191StatController.instance:onViewOpen(arg_10_0.viewName)
	arg_10_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, arg_10_0.eventClose, arg_10_0)

	arg_10_0.nodeDetailMo = arg_10_0.gameInfo:getNodeDetailMo()

	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0.isPvp = Activity191Helper.isPvpBattle(arg_11_0.nodeDetailMo.type)

	local var_11_0

	if not arg_11_0.isPvp then
		local var_11_1 = arg_11_0.nodeDetailMo.fightEventId

		var_11_0 = lua_activity191_fight_event.configDict[var_11_1].fightLevel
	else
		local var_11_2 = arg_11_0.nodeDetailMo.matchInfo.rank

		var_11_0 = lua_activity191_match_rank.configDict[var_11_2].fightLevel
	end

	UISpriteSetMgr.instance:setAct174Sprite(arg_11_0._imageRank, "act191_level_" .. string.lower(var_11_0))
	arg_11_0:showEnemyList()
	arg_11_0:refreshReward()
end

function var_0_0.onClose(arg_12_0)
	local var_12_0 = arg_12_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_12_0.viewName, var_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._toggleAutoFight:RemoveOnValueChanged()
end

function var_0_0.onToggleValueChanged(arg_14_0)
	local var_14_0 = arg_14_0._toggleAutoFight.isOn

	arg_14_0.gameInfo:setAutoFight(var_14_0)
	gohelper.setActive(arg_14_0.goAutoFight, var_14_0)

	if var_14_0 then
		AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_reward_increase)
	end

	arg_14_0:refreshReward()
	Act191StatController.instance:statButtonClick(arg_14_0.viewName, "onToggleValueChanged")
end

function var_0_0.showEnemyList(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = {}

	if arg_15_0.isPvp then
		local var_15_2 = arg_15_0.nodeDetailMo.matchInfo

		for iter_15_0, iter_15_1 in pairs(var_15_2.heroMap) do
			local var_15_3 = var_15_2:getRoleCo(iter_15_1.heroId)

			if var_15_3 then
				local var_15_4 = var_15_3.career

				var_15_1[var_15_4] = (var_15_1[var_15_4] or 0) + 1
			end
		end

		for iter_15_2, iter_15_3 in pairs(var_15_2.subHeroMap) do
			local var_15_5 = var_15_2:getRoleCo(iter_15_3)

			if var_15_5 then
				local var_15_6 = var_15_5.career

				var_15_1[var_15_6] = (var_15_1[var_15_6] or 0) + 1
			end
		end
	else
		local var_15_7 = FightModel.instance:getFightParam()

		for iter_15_4, iter_15_5 in ipairs(var_15_7.monsterGroupIds) do
			local var_15_8 = lua_monster_group.configDict[iter_15_5].bossId
			local var_15_9 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_15_5].monster, "#")

			for iter_15_6, iter_15_7 in ipairs(var_15_9) do
				local var_15_10 = lua_monster.configDict[iter_15_7].career

				if FightHelper.isBossId(var_15_8, iter_15_7) then
					var_15_0[var_15_10] = (var_15_0[var_15_10] or 0) + 1
				else
					var_15_1[var_15_10] = (var_15_1[var_15_10] or 0) + 1
				end
			end
		end
	end

	local var_15_11 = {}

	for iter_15_8, iter_15_9 in pairs(var_15_0) do
		table.insert(var_15_11, {
			career = iter_15_8,
			count = iter_15_9
		})
	end

	arg_15_0._enemy_boss_end_index = #var_15_11

	for iter_15_10, iter_15_11 in pairs(var_15_1) do
		table.insert(var_15_11, {
			career = iter_15_10,
			count = iter_15_11
		})
	end

	gohelper.CreateObjList(arg_15_0, arg_15_0._onEnemyItemShow, var_15_11, gohelper.findChild(arg_15_0._goEnemyTeam, "enemyList"), gohelper.findChild(arg_15_0._goEnemyTeam, "enemyList/go_enemyitem"))
end

function var_0_0._onEnemyItemShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = gohelper.findChildImage(arg_16_1, "icon")
	local var_16_1 = gohelper.findChild(arg_16_1, "icon/kingIcon")
	local var_16_2 = gohelper.findChildTextMesh(arg_16_1, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(var_16_0, "lssx_" .. tostring(arg_16_2.career))

	var_16_2.text = arg_16_2.count > 1 and luaLang("multiple") .. arg_16_2.count or ""

	gohelper.setActive(var_16_1, arg_16_3 <= arg_16_0._enemy_boss_end_index)
end

function var_0_0.refreshReward(arg_17_0)
	local var_17_0 = arg_17_0._toggleAutoFight.isOn and "autoRewardView" or "rewardView"
	local var_17_1

	if arg_17_0.isPvp then
		local var_17_2 = Activity191Enum.NodeType2Key[arg_17_0.nodeDetailMo.type]
		local var_17_3 = lua_activity191_pvp_match.configDict[var_17_2]

		var_17_1 = GameUtil.splitString2(var_17_3[var_17_0], true)
	else
		local var_17_4 = lua_activity191_fight_event.configDict[arg_17_0.nodeDetailMo.fightEventId]

		var_17_1 = GameUtil.splitString2(var_17_4[var_17_0], true)
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.rewardItemList) do
		gohelper.setActive(iter_17_1.parent, false)
	end

	for iter_17_2, iter_17_3 in ipairs(var_17_1) do
		local var_17_5 = arg_17_0.rewardItemList[iter_17_2]

		if not var_17_5 then
			var_17_5 = arg_17_0:getUserDataTb_()
			var_17_5.parent = gohelper.cloneInPlace(arg_17_0._goRewardItem)

			local var_17_6 = arg_17_0:getResInst(Activity191Enum.PrefabPath.RewardItem, var_17_5.parent)

			var_17_5.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_6, Act191RewardItem)
			arg_17_0.rewardItemList[iter_17_2] = var_17_5
		end

		var_17_5.item:showAutoEff(false)
		var_17_5.item:setData(iter_17_3[1], iter_17_3[2])
		var_17_5.item:setExtraParam({
			fromView = arg_17_0.viewName,
			index = iter_17_2
		})
		gohelper.setActive(var_17_5.parent, true)

		if arg_17_0._toggleAutoFight.isOn then
			var_17_5.item:showAutoEff(true)
		end
	end

	gohelper.setActive(arg_17_0._goSelectedBg, arg_17_0._toggleAutoFight.isOn)
	gohelper.setActive(arg_17_0._goUnSelectBg, not arg_17_0._toggleAutoFight.isOn)
end

function var_0_0.eventClose(arg_18_0)
	ViewMgr.instance:closeView(arg_18_0.viewName)
end

return var_0_0
