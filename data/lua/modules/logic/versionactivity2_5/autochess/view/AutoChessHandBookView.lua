module("modules.logic.versionactivity2_5.autochess.view.AutoChessHandBookView", package.seeall)

local var_0_0 = class("AutoChessHandBookView", BaseView)
local var_0_1 = {
	leader = 2,
	chess = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goTagItemRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_tag/viewport/content")
	arg_1_0._goTagItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_tag/viewport/content/#go_tagitem")
	arg_1_0._chessTabNormal = gohelper.findChild(arg_1_0.viewGO, "#scroll_tab/viewport/content/#go_chessTabitem/#go_Normal")
	arg_1_0._chessTabSelected = gohelper.findChild(arg_1_0.viewGO, "#scroll_tab/viewport/content/#go_chessTabitem/#go_Select")
	arg_1_0._leaderTabNormal = gohelper.findChild(arg_1_0.viewGO, "#scroll_tab/viewport/content/#go_leaderTabitem/#go_Normal")
	arg_1_0._leaderTabSelected = gohelper.findChild(arg_1_0.viewGO, "#scroll_tab/viewport/content/#go_leaderTabitem/#go_Select")
	arg_1_0._goCardRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_book/viewport/content")
	arg_1_0._btnChessTab = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scroll_tab/viewport/content/#go_chessTabitem/#btn_click")
	arg_1_0._btnLeaderTab = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scroll_tab/viewport/content/#go_leaderTabitem/#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnChessTab:AddClickListener(arg_2_0.onClickChessTabClick, arg_2_0, var_0_1.chess)
	arg_2_0._btnLeaderTab:AddClickListener(arg_2_0.onClickChessTabClick, arg_2_0, var_0_1.leader)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnChessTab:RemoveClickListener()
	arg_3_0._btnLeaderTab:RemoveClickListener()
end

function var_0_0.onClickChessTabClick(arg_4_0, arg_4_1)
	if arg_4_0._curTab == arg_4_1 then
		return
	end

	arg_4_0._curTab = arg_4_1

	arg_4_0.anim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(arg_4_0._delaySwitch, arg_4_0, 0.16)
end

function var_0_0._delaySwitch(arg_5_0)
	arg_5_0:refreshTabsView()
	arg_5_0:refreshTagView()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._defaultTab = var_0_1.chess
	arg_6_0._defaultTagIdx = 1
	arg_6_0._curTab = arg_6_0._defaultTab
	arg_6_0._curTagIdx = arg_6_0._defaultTagIdx
	arg_6_0._tagIdMap = {}
	arg_6_0._chessCardItems = arg_6_0:getUserDataTb_()
	arg_6_0.anim = arg_6_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshTabsView()
	arg_8_0:createTagItems()
	arg_8_0:refreshTagView()
end

function var_0_0.refreshTabsView(arg_9_0)
	gohelper.setActive(arg_9_0._leaderTabSelected, arg_9_0._curTab == var_0_1.leader)
	gohelper.setActive(arg_9_0._chessTabSelected, arg_9_0._curTab ~= var_0_1.leader)
end

function var_0_0.createTagItems(arg_10_0)
	if arg_10_0._curTab == var_0_1.chess then
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in ipairs(lua_auto_chess_translate.configList) do
			var_10_0[#var_10_0 + 1] = iter_10_1
		end

		arg_10_0._chessTabGoList = arg_10_0:getUserDataTb_()

		gohelper.CreateObjList(arg_10_0, arg_10_0.createChessTagItem, var_10_0, arg_10_0._goTagItemRoot, arg_10_0._goTagItem)
	end
end

function var_0_0.createChessTagItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._chessTabGoList[arg_11_3] = arg_11_1
	gohelper.findChildText(arg_11_1, "#txt_Type").text = arg_11_2.name
	arg_11_0._tagIdMap[arg_11_3] = arg_11_2.id

	local var_11_0 = gohelper.findChildImage(arg_11_1, "#image_Type")

	SLFramework.UGUI.GuiHelper.SetColor(var_11_0, arg_11_2.color)

	local var_11_1 = gohelper.findChild(arg_11_1, "#go_Select")

	gohelper.setActive(var_11_1, arg_11_0._curTagIdx == arg_11_3)
	gohelper.findChildButtonWithAudio(arg_11_1, "#btn_click"):AddClickListener(arg_11_0.onClickTagItem, arg_11_0, arg_11_3)
end

function var_0_0.onClickTagItem(arg_12_0, arg_12_1)
	if arg_12_1 == arg_12_0._curTagIdx then
		return
	end

	arg_12_0._curTagIdx = arg_12_1

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._chessTabGoList) do
		local var_12_0 = gohelper.findChild(iter_12_1, "#go_Select")

		gohelper.setActive(var_12_0, iter_12_0 == arg_12_1)
	end

	arg_12_0:refreshTagView()
end

function var_0_0.refreshTagView(arg_13_0)
	gohelper.setActive(arg_13_0._goTagItemRoot, arg_13_0._curTab == var_0_1.chess)
	arg_13_0:createChessCardItems()
end

function var_0_0.createChessCardItems(arg_14_0)
	if arg_14_0._curTab == var_0_1.chess then
		arg_14_0:clearChessCardItems()

		local var_14_0 = AutoChessConfig:getChessCfgListByRace(arg_14_0._tagIdMap[arg_14_0._curTagIdx])

		table.sort(var_14_0, arg_14_0.chessCfgSortFunc)

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if iter_14_1.illustrationShow == 1 then
				local var_14_1 = iter_14_1.id
				local var_14_2 = arg_14_0:getResInst(AutoChessStrEnum.ResPath.ChessCard, arg_14_0._goCardRoot, "card" .. var_14_1)
				local var_14_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_2, AutoChessCard)
				local var_14_4 = {
					type = AutoChessCard.ShowType.HandBook,
					itemId = var_14_1
				}

				arg_14_0._chessCardItems[var_14_1] = var_14_2

				var_14_3:setData(var_14_4)
			end
		end
	else
		arg_14_0:clearChessCardItems()

		local var_14_5 = AutoChessConfig.instance:getLeaderCfgList()

		table.sort(var_14_5, arg_14_0._leaderCfgSorter)

		for iter_14_2, iter_14_3 in ipairs(var_14_5) do
			if AutoChessConfig.instance:getLeaderCfg(iter_14_3).illustrationShow == 1 then
				local var_14_6 = arg_14_0:getResInst(AutoChessStrEnum.ResPath.LeaderCard, arg_14_0._goCardRoot, "leader" .. iter_14_3)
				local var_14_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_6, AutoChessLeaderCard)
				local var_14_8 = {
					leaderId = iter_14_3,
					type = AutoChessLeaderCard.ShowType.HandBook
				}

				arg_14_0._chessCardItems[iter_14_3] = var_14_6

				var_14_7:setData(var_14_8)
			end
		end
	end
end

function var_0_0.chessCfgSortFunc(arg_15_0, arg_15_1)
	if arg_15_0 and arg_15_1 then
		if arg_15_0.levelFromMall == arg_15_1.levelFromMall then
			return arg_15_0.id < arg_15_1.id
		else
			return arg_15_0.levelFromMall > arg_15_1.levelFromMall
		end
	end

	return false
end

function var_0_0._leaderCfgSorter(arg_16_0, arg_16_1)
	if arg_16_0 and arg_16_1 then
		return arg_16_0 < arg_16_1
	end

	return false
end

function var_0_0.clearChessCardItems(arg_17_0)
	if arg_17_0._chessCardItems then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._chessCardItems) do
			gohelper.destroy(iter_17_1)
		end
	end
end

function var_0_0.onClose(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	if arg_19_0._chessTabGoList and #arg_19_0._chessTabGoList > 0 then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0._chessTabGoList) do
			gohelper.findChildButtonWithAudio(iter_19_1, "#btn_click"):RemoveClickListener()
		end
	end

	arg_19_0:clearChessCardItems()
	TaskDispatcher.cancelTask(arg_19_0._delaySwitch, arg_19_0)
end

return var_0_0
