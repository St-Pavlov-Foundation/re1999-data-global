module("modules.logic.gm.view.GMSubViewBattle", package.seeall)

slot0 = class("GMSubViewBattle", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "战斗"
end

function slot0.initViewContent(slot0)
	if slot0._isInit then
		return
	end

	slot0:addButton("L1", "打印出角色平均伤害，平均承伤，平均治疗", slot0._onClickShowBattleCharaterParam, slot0)
	slot0:addButton("L2", "开启战斗录制", slot0._onClickEnableGMFightRecord, slot0)
	slot0:addButton("L2", "保存战斗录制", slot0._onClickSaveRecord, slot0)
	slot0:addButton("L2", "选取录像文件", slot0._onClickGMFightRecordReplay, slot0)
	slot0:addButton("L3", "打开战场日志", slot0._onClickGMFightLog, slot0)
	slot0:addButton("L3", "复制最后一回合协议数据", slot0.onClickCopyLatRoundProtoDataNormal, slot0)
	slot0:addLabel("L4", "通过战斗id进入一牌一动")
	slot0:addInputText("L4", PlayerPrefsHelper.getString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, ""), nil, slot0._onLastBattleIdYiPaiYiDongChange, slot0)
	slot0:addButton("L4", "进入战斗", slot0._onClickEnterYiPaiYiDong, slot0)
	slot0:addLabel("L5", "实时统计buff类层数 : ")

	slot0.buffTypeInput = slot0:addInputText("L5", "6003", "buff类id")
	slot0.statBuffToggle = slot0:addToggle("L5", "", slot0.onStatBuffToggleValueChange, slot0)
	slot0.statBuffToggle.isOn = GMFightController.instance:statingBuffType()
	slot0.effectTypeInput = slot0:addInputText("L6", "", "指定effectType: id1;id2;id2", nil, , {
		w = 600
	})

	slot0:addButton("L6", "复制最后一回合处理后的数据_前端用", slot0.onClickCopyLatRoundDataForClient, slot0)
	slot0:addButton("L7", "复制最后一回合处理前的数据_前端用", slot0.onClickCopyLatRoundProtoDataForClient, slot0)
	slot0:addLabel("L8", "设定战斗版本号(本次登录有效)")
	slot0:addInputText("L8", FightModel.GMForceVersion or "版本号", nil, slot0._onVersionChange, slot0)
	slot0:addButton("L9", "使用新卡牌代码逻辑", slot0.onClickUseNewCardScript, slot0)
	slot0:addButton("L9", "使用旧卡牌代码逻辑", slot0.onClickUseOldCardScript, slot0)

	slot0._isInit = true
end

function slot0.onClickCopyLatRoundDataForClient(slot0)
	FightLogFilterHelper.setFilterEffectList(slot0.effectTypeInput:GetText())
	ZProj.GameHelper.SetSystemBuffer(FightLogHelper.getFightRoundString(FightModel.instance:getCurRoundMO()))
end

function slot0.onClickCopyLatRoundProtoDataForClient(slot0)
	if not GameSceneMgr.instance:getCurScene().fightLog then
		return
	end

	if not (slot1:getLastRoundProto() and slot2.proto) then
		ZProj.GameHelper.SetSystemBuffer("nil")

		return
	end

	ZProj.GameHelper.SetSystemBuffer(FightLogProtobufHelper.getFightRoundString(slot3))
end

function slot0.onClickCopyLatRoundProtoDataNormal(slot0)
	if not GameSceneMgr.instance:getCurScene().fightLog then
		ZProj.UGUIHelper.CopyText("没有数据")

		return
	end

	if not slot1:getLastRoundProto() then
		ZProj.UGUIHelper.CopyText("没有数据")

		return
	end

	ZProj.UGUIHelper.CopyText("回合" .. slot2.round .. "\n" .. FightEditorStateLogView.processStr(tostring(slot2.proto)))
end

function slot0._onLastBattleIdYiPaiYiDongChange(slot0, slot1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, slot1)
end

function slot0._onVersionChange(slot0, slot1)
	FightModel.GMForceVersion = tonumber(slot1)
end

function slot0._onClickEnterYiPaiYiDong(slot0)
	if string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.GMLastBattleIdOfYiPaiYiDong, "")) then
		return
	end

	if tonumber(slot1) and lua_battle.configDict[slot1] then
		slot3 = FightController.instance:setFightParamByBattleId(slot1)

		HeroGroupModel.instance:setParam(slot1, nil, )

		if not HeroGroupModel.instance:getCurGroupMO() then
			logError("current HeroGroupMO is nil")
			GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

			return
		end

		slot5, slot6 = slot4:getMainList()
		slot7, slot8 = slot4:getSubList()
		slot9 = slot4:getAllHeroEquips()

		slot0:closeThis()

		for slot13, slot14 in ipairs(lua_episode.configList) do
			if slot14.battleId == slot1 then
				slot3.episodeId = slot14.id
				FightResultModel.instance.episodeId = slot14.id

				DungeonModel.instance:SetSendChapterEpisodeId(slot14.chapterId, slot14.id)

				break
			end
		end

		if not slot3.episodeId then
			slot3.episodeId = 10101
		end

		slot3:setMySide(slot4.clothId, slot5, slot7, slot9)

		slot3.fightActType = FightEnum.FightActType.Season2

		FightController.instance:sendTestFightId(slot3)
	end
end

function slot0._onClickShowBattleCharaterParam(slot0)
	if not string.nilorempty(GMBattleModel.instance:getBattleParam()) then
		logError(string.gsub(string.gsub(slot1, "{", "\n{\n"), ",", ",\n"))
	else
		logError("数据为空")
	end
end

function slot0._onClickEnableGMFightRecord(slot0)
	GMBattleModel.instance:setGMFightRecordEnable()
	GameFacade.showToast(ToastEnum.IconId, "开启战斗录制，请在结算界面点击保存")
end

function slot0._onClickSaveRecord(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnGMFightWithRecordAllReply, slot0._onGetRecord, slot0)
	FightRpc.instance:sendGetFightRecordAllRequest()
end

function slot0._onGetRecord(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnGMFightWithRecordAllReply, slot0._onGetRecord, slot0)
	FightGMRecordView.saveRecord()
end

function slot0._onClickGMFightRecordReplay(slot0)
	slot2 = cjson.decode(WindowsUtil.getSelectFileContent("选取战斗录制文件", "json"))
	slot3 = ProtoTestCaseMO.New()

	slot3:deserialize(slot2)

	slot5 = slot2.fightParam
	FightController.instance:setFightParamByEpisodeId(slot5.episodeId, true, 1, slot5.battleId).isShowSettlement = false

	FightRpc.instance:sendFightWithRecordAllRequest(slot3:buildProtoMsg())
end

function slot0._onClickGMFightLog(slot0)
	ViewMgr.instance:openView(ViewName.FightEditorStateView)
	ViewMgr.instance:closeView(ViewName.GMToolView)
end

function slot0.onStatBuffToggleValueChange(slot0)
	if not GameSceneMgr.instance:isFightScene() then
		return
	end

	if not slot0._isInit then
		return
	end

	if slot0.statBuffToggle.isOn then
		if not (tonumber(slot0.buffTypeInput:GetText()) and lua_skill_bufftype.configDict[slot1]) then
			GameFacade.showToastString(string.format("buff类 : %s 不存在", slot1))

			slot0.statBuffToggle.isOn = false

			return
		end

		GMFightController.instance:startStatBuffType(slot1)
	else
		GMFightController.instance:stopStatBuffType()
	end
end

function slot0.onClickUseNewCardScript(slot0)
	FightMgr.instance:changeCardScript(true)
	logError("使用新卡牌逻辑")
end

function slot0.onClickUseOldCardScript(slot0)
	FightMgr.instance:changeCardScript(false)
	logError("使用旧卡牌逻辑")
end

function slot0.onDestroyView(slot0)
end

return slot0
