module("modules.logic.gm.view.GMSubViewBattle", package.seeall)

local var_0_0 = class("GMSubViewBattle", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "战斗"
end

function var_0_0.initViewContent(arg_2_0)
	if arg_2_0._isInit then
		return
	end

	arg_2_0:addButton("L1", "打印出角色平均伤害，平均承伤，平均治疗", arg_2_0._onClickShowBattleCharaterParam, arg_2_0)
	arg_2_0:addButton("L2", "开启战斗录制", arg_2_0._onClickEnableGMFightRecord, arg_2_0)
	arg_2_0:addButton("L2", "保存战斗录制", arg_2_0._onClickSaveRecord, arg_2_0)
	arg_2_0:addButton("L2", "选取录像文件", arg_2_0._onClickGMFightRecordReplay, arg_2_0)
	arg_2_0:addButton("L3", "打开战场日志", arg_2_0._onClickGMFightLog, arg_2_0)
	arg_2_0:addButton("L3", "复制最后一回合协议数据", arg_2_0.onClickCopyLatRoundProtoDataNormal, arg_2_0)
	arg_2_0:addLabel("L4", "通过战斗id进入一牌一动")
	arg_2_0:addInputText("L4", PlayerPrefsHelper.getString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, ""), nil, arg_2_0._onLastBattleIdYiPaiYiDongChange, arg_2_0)
	arg_2_0:addButton("L4", "进入战斗", arg_2_0._onClickEnterYiPaiYiDong, arg_2_0)
	arg_2_0:addLabel("L5", "实时统计buff类层数 : ")

	arg_2_0.buffTypeInput = arg_2_0:addInputText("L5", "6003", "buff类id")
	arg_2_0.statBuffToggle = arg_2_0:addToggle("L5", "", arg_2_0.onStatBuffToggleValueChange, arg_2_0)
	arg_2_0.statBuffToggle.isOn = GMFightController.instance:statingBuffType()
	arg_2_0.effectTypeInput = arg_2_0:addInputText("L6", "", "指定effectType: id1;id2;id2", nil, nil, {
		w = 600
	})

	arg_2_0:addButton("L6", "复制最后一回合处理后的数据_前端用", arg_2_0.onClickCopyLatRoundDataForClient, arg_2_0)
	arg_2_0:addButton("L7", "复制最后一回合处理前的数据_前端用", arg_2_0.onClickCopyLatRoundProtoDataForClient, arg_2_0)
	arg_2_0:addLabel("L8", "设定战斗版本号(本次登录有效)")
	arg_2_0:addInputText("L8", FightModel.GMForceVersion or "版本号", nil, arg_2_0._onVersionChange, arg_2_0)
	arg_2_0:addButton("L9", "使用新卡牌代码逻辑", arg_2_0.onClickUseNewCardScript, arg_2_0)
	arg_2_0:addButton("L9", "使用旧卡牌代码逻辑", arg_2_0.onClickUseOldCardScript, arg_2_0)

	arg_2_0._isInit = true
end

function var_0_0.onClickCopyLatRoundDataForClient(arg_3_0)
	FightLogFilterHelper.setFilterEffectList(arg_3_0.effectTypeInput:GetText())

	local var_3_0 = FightModel.instance:getCurRoundMO()
	local var_3_1 = FightLogHelper.getFightRoundString(var_3_0)

	ZProj.GameHelper.SetSystemBuffer(var_3_1)
end

function var_0_0.onClickCopyLatRoundProtoDataForClient(arg_4_0)
	local var_4_0 = GameSceneMgr.instance:getCurScene().fightLog

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0:getLastRoundProto()
	local var_4_2 = var_4_1 and var_4_1.proto

	if not var_4_2 then
		ZProj.GameHelper.SetSystemBuffer("nil")

		return
	end

	local var_4_3 = FightLogProtobufHelper.getFightRoundString(var_4_2)

	ZProj.GameHelper.SetSystemBuffer(var_4_3)
end

function var_0_0.onClickCopyLatRoundProtoDataNormal(arg_5_0)
	local var_5_0 = GameSceneMgr.instance:getCurScene().fightLog

	if not var_5_0 then
		ZProj.UGUIHelper.CopyText("没有数据")

		return
	end

	local var_5_1 = var_5_0:getLastRoundProto()

	if not var_5_1 then
		ZProj.UGUIHelper.CopyText("没有数据")

		return
	end

	local var_5_2 = ("回合" .. var_5_1.round .. "\n") .. FightEditorStateLogView.processStr(tostring(var_5_1.proto))

	ZProj.UGUIHelper.CopyText(var_5_2)
end

function var_0_0._onLastBattleIdYiPaiYiDongChange(arg_6_0, arg_6_1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, arg_6_1)
end

function var_0_0._onVersionChange(arg_7_0, arg_7_1)
	FightModel.GMForceVersion = tonumber(arg_7_1)
end

function var_0_0._onClickEnterYiPaiYiDong(arg_8_0)
	local var_8_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, "")

	if string.nilorempty(var_8_0) then
		return
	end

	local var_8_1 = tonumber(var_8_0)

	if var_8_1 and lua_battle.configDict[var_8_1] then
		local var_8_2 = FightController.instance:setFightParamByBattleId(var_8_1)

		HeroGroupModel.instance:setParam(var_8_1, nil, nil)

		local var_8_3 = HeroGroupModel.instance:getCurGroupMO()

		if not var_8_3 then
			logError("current HeroGroupMO is nil")
			GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

			return
		end

		local var_8_4, var_8_5 = var_8_3:getMainList()
		local var_8_6, var_8_7 = var_8_3:getSubList()
		local var_8_8 = var_8_3:getAllHeroEquips()

		arg_8_0:closeThis()

		for iter_8_0, iter_8_1 in ipairs(lua_episode.configList) do
			if iter_8_1.battleId == var_8_1 then
				var_8_2.episodeId = iter_8_1.id
				FightResultModel.instance.episodeId = iter_8_1.id

				DungeonModel.instance:SetSendChapterEpisodeId(iter_8_1.chapterId, iter_8_1.id)

				break
			end
		end

		if not var_8_2.episodeId then
			var_8_2.episodeId = 10101
		end

		var_8_2:setMySide(var_8_3.clothId, var_8_4, var_8_6, var_8_8)

		var_8_2.fightActType = FightEnum.FightActType.Season2

		FightController.instance:sendTestFightId(var_8_2)
	end
end

function var_0_0._onClickShowBattleCharaterParam(arg_9_0)
	local var_9_0 = GMBattleModel.instance:getBattleParam()

	if not string.nilorempty(var_9_0) then
		local var_9_1 = string.gsub(var_9_0, "{", "\n{\n")
		local var_9_2 = string.gsub(var_9_1, ",", ",\n")

		logError(var_9_2)
	else
		logError("数据为空")
	end
end

function var_0_0._onClickEnableGMFightRecord(arg_10_0)
	GMBattleModel.instance:setGMFightRecordEnable()
	GameFacade.showToast(ToastEnum.IconId, "开启战斗录制，请在结算界面点击保存")
end

function var_0_0._onClickSaveRecord(arg_11_0)
	arg_11_0:addEventCb(FightController.instance, FightEvent.OnGMFightWithRecordAllReply, arg_11_0._onGetRecord, arg_11_0)
	FightRpc.instance:sendGetFightRecordAllRequest()
end

function var_0_0._onGetRecord(arg_12_0)
	arg_12_0:removeEventCb(FightController.instance, FightEvent.OnGMFightWithRecordAllReply, arg_12_0._onGetRecord, arg_12_0)
	FightGMRecordView.saveRecord()
end

function var_0_0._onClickGMFightRecordReplay(arg_13_0)
	local var_13_0 = WindowsUtil.getSelectFileContent("选取战斗录制文件", "json")
	local var_13_1 = cjson.decode(var_13_0)
	local var_13_2 = ProtoTestCaseMO.New()

	var_13_2:deserialize(var_13_1)

	local var_13_3 = var_13_2:buildProtoMsg()
	local var_13_4 = var_13_1.fightParam

	FightController.instance:setFightParamByEpisodeId(var_13_4.episodeId, true, 1, var_13_4.battleId).isShowSettlement = false

	FightRpc.instance:sendFightWithRecordAllRequest(var_13_3)
end

function var_0_0._onClickGMFightLog(arg_14_0)
	ViewMgr.instance:openView(ViewName.FightEditorStateView)
	ViewMgr.instance:closeView(ViewName.GMToolView)
end

function var_0_0.onStatBuffToggleValueChange(arg_15_0)
	if not GameSceneMgr.instance:isFightScene() then
		return
	end

	if not arg_15_0._isInit then
		return
	end

	if arg_15_0.statBuffToggle.isOn then
		local var_15_0 = arg_15_0.buffTypeInput:GetText()
		local var_15_1 = tonumber(var_15_0)

		if not (var_15_1 and lua_skill_bufftype.configDict[var_15_1]) then
			GameFacade.showToastString(string.format("buff类 : %s 不存在", var_15_1))

			arg_15_0.statBuffToggle.isOn = false

			return
		end

		GMFightController.instance:startStatBuffType(var_15_1)
	else
		GMFightController.instance:stopStatBuffType()
	end
end

function var_0_0.onClickUseNewCardScript(arg_16_0)
	FightMgr.instance:changeCardScript(true)
	logError("使用新卡牌逻辑")
end

function var_0_0.onClickUseOldCardScript(arg_17_0)
	FightMgr.instance:changeCardScript(false)
	logError("使用旧卡牌逻辑")
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
