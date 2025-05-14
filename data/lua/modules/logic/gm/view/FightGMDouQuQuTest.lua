module("modules.logic.gm.view.FightGMDouQuQuTest", package.seeall)

local var_0_0 = class("FightGMDouQuQuTest", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "btn_close")
	arg_1_0._btnEnemyAddSelect = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "centre/enemy/btn_add")
	arg_1_0._btnPlayerAddSelect = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "centre/player/btn_add")
	arg_1_0._btnEnterFight = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "centre/btn_enter_fight")
	arg_1_0._btnMultiSimulate = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "centre/btn_multi_simulate")
	arg_1_0._enemySelectItemContent = gohelper.findChild(arg_1_0.viewGO, "centre/enemy/Scroll View/Viewport/Content")
	arg_1_0._playerSelectItemContent = gohelper.findChild(arg_1_0.viewGO, "centre/player/Scroll View/Viewport/Content")
	arg_1_0._enemySelectedItemContent = gohelper.findChild(arg_1_0.viewGO, "centre/selected/enemy_selected/Viewport/Content")
	arg_1_0._playerSelectedItemContent = gohelper.findChild(arg_1_0.viewGO, "centre/selected/player_selected/Viewport/Content")
	arg_1_0._selectItem = gohelper.findChild(arg_1_0.viewGO, "centre/enemy/Scroll View/Viewport/Content/item")
	arg_1_0._pathInput = gohelper.findChildInputField(arg_1_0.viewGO, "topLeft/InputField")
	arg_1_0._battleIdInput = gohelper.findChildInputField(arg_1_0.viewGO, "centre/battleIdInput/InputField")
	arg_1_0._battleCountInput = gohelper.findChildInputField(arg_1_0.viewGO, "centre/battleCountInput/InputField")
	arg_1_0._logText = gohelper.findChildText(arg_1_0.viewGO, "bottom/Scroll View/Viewport/Content/Text")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0._btnClose, arg_2_0.closeThis)
	arg_2_0:com_registClick(arg_2_0._btnEnemyAddSelect, arg_2_0._onBtnEnemyAddSelect)
	arg_2_0:com_registClick(arg_2_0._btnPlayerAddSelect, arg_2_0._onBtnPlayerAddSelect)
	arg_2_0:com_registClick(arg_2_0._btnEnterFight, arg_2_0._onBtnEnterFight)
	arg_2_0:com_registClick(arg_2_0._btnMultiSimulate, arg_2_0._onBtnMultiSimulate)
	arg_2_0._pathInput:AddOnValueChanged(arg_2_0._onPathInputChange, arg_2_0)
	arg_2_0._battleIdInput:AddOnValueChanged(arg_2_0._onBattleIdInputChange, arg_2_0)
	arg_2_0._battleCountInput:AddOnValueChanged(arg_2_0._onBattleCountInputChange, arg_2_0)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0._pathInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.FightGMDouQuQuTestLogPath))
	arg_3_0._battleIdInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.FightGMDouQuQuTestBattleId))
	arg_3_0._battleCountInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.FightGMDouQuQuTestBattleCount))

	arg_3_0._enemySelectList = arg_3_0:com_registViewItemList(arg_3_0._selectItem, FightGMDouQuQuTestSelectItem, arg_3_0._enemySelectItemContent)

	arg_3_0._enemySelectList:setFuncNameOfRefreshItemData("refreshItemData")

	arg_3_0._playerSelectList = arg_3_0:com_registViewItemList(arg_3_0._selectItem, FightGMDouQuQuTestSelectItem, arg_3_0._playerSelectItemContent)

	arg_3_0._playerSelectList:setFuncNameOfRefreshItemData("refreshItemData")

	arg_3_0._enemySelectedList = arg_3_0:com_registViewItemList(arg_3_0._selectItem, FightGMDouQuQuTestSelectItem, arg_3_0._enemySelectedItemContent)

	arg_3_0._enemySelectedList:setFuncNameOfRefreshItemData("refreshItemData")

	arg_3_0._playerSelectedList = arg_3_0:com_registViewItemList(arg_3_0._selectItem, FightGMDouQuQuTestSelectItem, arg_3_0._playerSelectedItemContent)

	arg_3_0._playerSelectedList:setFuncNameOfRefreshItemData("refreshItemData")

	arg_3_0._enemySelectList.listType = "_enemySelectList"
	arg_3_0._playerSelectList.listType = "_playerSelectList"
	arg_3_0._enemySelectedList.listType = "_enemySelectedList"
	arg_3_0._playerSelectedList.listType = "_playerSelectedList"
	arg_3_0._configList = {}

	for iter_3_0, iter_3_1 in ipairs(lua_activity174_test_bot.configList) do
		table.insert(arg_3_0._configList, iter_3_1)
	end

	arg_3_0._enemySelectList:setDataList(arg_3_0._configList)
	arg_3_0._playerSelectList:setDataList(arg_3_0._configList)
end

function var_0_0._onPathInputChange(arg_4_0)
	local var_4_0 = arg_4_0._pathInput:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.FightGMDouQuQuTestLogPath, var_4_0)
end

function var_0_0._onBattleIdInputChange(arg_5_0)
	local var_5_0 = arg_5_0._battleIdInput:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.FightGMDouQuQuTestBattleId, var_5_0)
end

function var_0_0._onBattleCountInputChange(arg_6_0)
	local var_6_0 = arg_6_0._battleCountInput:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.FightGMDouQuQuTestBattleCount, var_6_0)
end

function var_0_0._onBtnEnemyAddSelect(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._enemySelectedList) do
		table.insert(var_7_0, iter_7_1.config)
	end

	for iter_7_2 = #arg_7_0._enemySelectList, 1, -1 do
		if arg_7_0._enemySelectList[iter_7_2].selecting then
			local var_7_1 = arg_7_0._enemySelectList:removeIndex(iter_7_2)

			table.insert(var_7_0, var_7_1.config)
		end
	end

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0.robotId < arg_8_1.robotId
	end)
	arg_7_0._enemySelectedList:setDataList(var_7_0)

	arg_7_0._enemySelectList.lastSelectIndex = nil
end

function var_0_0._onBtnPlayerAddSelect(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._playerSelectedList) do
		table.insert(var_9_0, iter_9_1.config)
	end

	for iter_9_2 = #arg_9_0._playerSelectList, 1, -1 do
		if arg_9_0._playerSelectList[iter_9_2].selecting then
			local var_9_1 = arg_9_0._playerSelectList:removeIndex(iter_9_2)

			table.insert(var_9_0, var_9_1.config)
		end
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0.robotId < arg_10_1.robotId
	end)
	arg_9_0._playerSelectedList:setDataList(var_9_0)

	arg_9_0._playerSelectList.lastSelectIndex = nil
end

function var_0_0._getGMStr(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._pathInput:GetText()

	if arg_11_1 == 2 and string.nilorempty(var_11_0) then
		arg_11_0._logText.text = "未配置导出路径"

		return
	end

	local var_11_1 = ""

	if #arg_11_0._playerSelectedList < 1 or #arg_11_0._enemySelectedList < 1 then
		arg_11_0._logText.text = "未选择对战机器人"

		return
	end

	if arg_11_1 == 1 and (#arg_11_0._playerSelectedList > 1 or #arg_11_0._enemySelectedList > 1) then
		arg_11_0._logText.text = "多个机器人无法进入战斗"

		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._playerSelectedList) do
		if iter_11_0 > 1 then
			var_11_1 = var_11_1 .. "#"
		end

		var_11_1 = var_11_1 .. iter_11_1.config.robotId
	end

	local var_11_2 = ""

	for iter_11_2, iter_11_3 in ipairs(arg_11_0._enemySelectedList) do
		if iter_11_2 > 1 then
			var_11_2 = var_11_2 .. "#"
		end

		var_11_2 = var_11_2 .. iter_11_3.config.robotId
	end

	local var_11_3 = tonumber(arg_11_0._battleIdInput:GetText())

	if not lua_battle.configDict[var_11_3] then
		arg_11_0._logText.text = "战斗id不存在"

		return
	end

	local var_11_4 = tonumber(arg_11_0._battleCountInput:GetText())

	if not var_11_4 then
		arg_11_0._logText.text = "对战次数未配置"

		return
	end

	return (string.format("act174Test %s %s %s %s %s %s", var_11_0, var_11_1, var_11_2, var_11_3, var_11_4, arg_11_1))
end

function var_0_0._onBtnEnterFight(arg_12_0)
	local var_12_0 = arg_12_0:_getGMStr(1)

	if var_12_0 then
		GMRpc.instance:sendGMRequest(var_12_0)
	end
end

function var_0_0._onBtnMultiSimulate(arg_13_0)
	local var_13_0 = arg_13_0:_getGMStr(2)

	if var_13_0 then
		GMRpc.instance:sendGMRequest(var_13_0)
	end
end

function var_0_0.onDestructor(arg_14_0)
	arg_14_0._pathInput:RemoveOnValueChanged()
	arg_14_0._battleIdInput:RemoveOnValueChanged()
	arg_14_0._battleCountInput:RemoveOnValueChanged()
end

return var_0_0
