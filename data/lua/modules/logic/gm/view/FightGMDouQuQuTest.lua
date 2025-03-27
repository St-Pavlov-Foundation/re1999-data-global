module("modules.logic.gm.view.FightGMDouQuQuTest", package.seeall)

slot0 = class("FightGMDouQuQuTest", FightBaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "btn_close")
	slot0._btnEnemyAddSelect = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "centre/enemy/btn_add")
	slot0._btnPlayerAddSelect = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "centre/player/btn_add")
	slot0._btnEnterFight = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "centre/btn_enter_fight")
	slot0._btnMultiSimulate = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "centre/btn_multi_simulate")
	slot0._enemySelectItemContent = gohelper.findChild(slot0.viewGO, "centre/enemy/Scroll View/Viewport/Content")
	slot0._playerSelectItemContent = gohelper.findChild(slot0.viewGO, "centre/player/Scroll View/Viewport/Content")
	slot0._enemySelectedItemContent = gohelper.findChild(slot0.viewGO, "centre/selected/enemy_selected/Viewport/Content")
	slot0._playerSelectedItemContent = gohelper.findChild(slot0.viewGO, "centre/selected/player_selected/Viewport/Content")
	slot0._selectItem = gohelper.findChild(slot0.viewGO, "centre/enemy/Scroll View/Viewport/Content/item")
	slot0._pathInput = gohelper.findChildInputField(slot0.viewGO, "topLeft/InputField")
	slot0._battleIdInput = gohelper.findChildInputField(slot0.viewGO, "centre/battleIdInput/InputField")
	slot0._battleCountInput = gohelper.findChildInputField(slot0.viewGO, "centre/battleCountInput/InputField")
	slot0._logText = gohelper.findChildText(slot0.viewGO, "bottom/Scroll View/Viewport/Content/Text")
end

function slot0.addEvents(slot0)
	slot0:com_registClick(slot0._btnClose, slot0.closeThis)
	slot0:com_registClick(slot0._btnEnemyAddSelect, slot0._onBtnEnemyAddSelect)
	slot0:com_registClick(slot0._btnPlayerAddSelect, slot0._onBtnPlayerAddSelect)
	slot0:com_registClick(slot0._btnEnterFight, slot0._onBtnEnterFight)
	slot0:com_registClick(slot0._btnMultiSimulate, slot0._onBtnMultiSimulate)
	slot0._pathInput:AddOnValueChanged(slot0._onPathInputChange, slot0)
	slot0._battleIdInput:AddOnValueChanged(slot0._onBattleIdInputChange, slot0)
	slot0._battleCountInput:AddOnValueChanged(slot0._onBattleCountInputChange, slot0)
end

function slot0.onOpen(slot0)
	slot0._pathInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.FightGMDouQuQuTestLogPath))
	slot0._battleIdInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.FightGMDouQuQuTestBattleId))
	slot0._battleCountInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.FightGMDouQuQuTestBattleCount))

	slot0._enemySelectList = slot0:com_registViewItemList(slot0._selectItem, FightGMDouQuQuTestSelectItem, slot0._enemySelectItemContent)

	slot0._enemySelectList:setFuncNameOfRefreshItemData("refreshItemData")

	slot0._playerSelectList = slot0:com_registViewItemList(slot0._selectItem, FightGMDouQuQuTestSelectItem, slot0._playerSelectItemContent)

	slot0._playerSelectList:setFuncNameOfRefreshItemData("refreshItemData")

	slot0._enemySelectedList = slot0:com_registViewItemList(slot0._selectItem, FightGMDouQuQuTestSelectItem, slot0._enemySelectedItemContent)

	slot0._enemySelectedList:setFuncNameOfRefreshItemData("refreshItemData")

	slot4 = FightGMDouQuQuTestSelectItem
	slot5 = slot0._playerSelectedItemContent
	slot0._playerSelectedList = slot0:com_registViewItemList(slot0._selectItem, slot4, slot5)

	slot0._playerSelectedList:setFuncNameOfRefreshItemData("refreshItemData")

	slot0._enemySelectList.listType = "_enemySelectList"
	slot0._playerSelectList.listType = "_playerSelectList"
	slot0._enemySelectedList.listType = "_enemySelectedList"
	slot0._playerSelectedList.listType = "_playerSelectedList"
	slot0._configList = {}

	for slot4, slot5 in ipairs(lua_activity174_test_bot.configList) do
		table.insert(slot0._configList, slot5)
	end

	slot0._enemySelectList:setDataList(slot0._configList)
	slot0._playerSelectList:setDataList(slot0._configList)
end

function slot0._onPathInputChange(slot0)
	PlayerPrefsHelper.setString(PlayerPrefsKey.FightGMDouQuQuTestLogPath, slot0._pathInput:GetText())
end

function slot0._onBattleIdInputChange(slot0)
	PlayerPrefsHelper.setString(PlayerPrefsKey.FightGMDouQuQuTestBattleId, slot0._battleIdInput:GetText())
end

function slot0._onBattleCountInputChange(slot0)
	PlayerPrefsHelper.setString(PlayerPrefsKey.FightGMDouQuQuTestBattleCount, slot0._battleCountInput:GetText())
end

function slot0._onBtnEnemyAddSelect(slot0)
	for slot5, slot6 in ipairs(slot0._enemySelectedList) do
		table.insert({}, slot6.config)
	end

	for slot5 = #slot0._enemySelectList, 1, -1 do
		if slot0._enemySelectList[slot5].selecting then
			table.insert(slot1, slot0._enemySelectList:removeIndex(slot5).config)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.robotId < slot1.robotId
	end)
	slot0._enemySelectedList:setDataList(slot1)

	slot0._enemySelectList.lastSelectIndex = nil
end

function slot0._onBtnPlayerAddSelect(slot0)
	for slot5, slot6 in ipairs(slot0._playerSelectedList) do
		table.insert({}, slot6.config)
	end

	for slot5 = #slot0._playerSelectList, 1, -1 do
		if slot0._playerSelectList[slot5].selecting then
			table.insert(slot1, slot0._playerSelectList:removeIndex(slot5).config)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.robotId < slot1.robotId
	end)
	slot0._playerSelectedList:setDataList(slot1)

	slot0._playerSelectList.lastSelectIndex = nil
end

function slot0._getGMStr(slot0, slot1)
	if slot1 == 2 and string.nilorempty(slot0._pathInput:GetText()) then
		slot0._logText.text = "未配置导出路径"

		return
	end

	slot3 = ""

	if #slot0._playerSelectedList < 1 or #slot0._enemySelectedList < 1 then
		slot0._logText.text = "未选择对战机器人"

		return
	end

	if slot1 == 1 and (#slot0._playerSelectedList > 1 or #slot0._enemySelectedList > 1) then
		slot0._logText.text = "多个机器人无法进入战斗"

		return
	end

	for slot7, slot8 in ipairs(slot0._playerSelectedList) do
		if slot7 > 1 then
			slot3 = slot3 .. "#"
		end

		slot3 = slot3 .. slot8.config.robotId
	end

	for slot8, slot9 in ipairs(slot0._enemySelectedList) do
		if slot8 > 1 then
			slot4 = "" .. "#"
		end

		slot4 = slot4 .. slot9.config.robotId
	end

	if not lua_battle.configDict[tonumber(slot0._battleIdInput:GetText())] then
		slot0._logText.text = "战斗id不存在"

		return
	end

	if not tonumber(slot0._battleCountInput:GetText()) then
		slot0._logText.text = "对战次数未配置"

		return
	end

	return string.format("act174Test %s %s %s %s %s %s", slot2, slot3, slot4, slot5, slot6, slot1)
end

function slot0._onBtnEnterFight(slot0)
	if slot0:_getGMStr(1) then
		GMRpc.instance:sendGMRequest(slot1)
	end
end

function slot0._onBtnMultiSimulate(slot0)
	if slot0:_getGMStr(2) then
		GMRpc.instance:sendGMRequest(slot1)
	end
end

function slot0.onDestructor(slot0)
	slot0._pathInput:RemoveOnValueChanged()
	slot0._battleIdInput:RemoveOnValueChanged()
	slot0._battleCountInput:RemoveOnValueChanged()
end

return slot0
