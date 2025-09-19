module("modules.logic.versionactivity2_5.autochess.view.AutoChessBattleRecordItem", package.seeall)

local var_0_0 = class("AutoChessBattleRecordItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSelfWinFlag = gohelper.findChild(arg_1_0.viewGO, "#go_playerwin")
	arg_1_0._goEnemyWinFlag = gohelper.findChild(arg_1_0.viewGO, "#go_enemywin")
	arg_1_0._txtSelfName = gohelper.findChildText(arg_1_0.viewGO, "PlayerGroup/#txt_Name")
	arg_1_0._txtEnemyName = gohelper.findChildText(arg_1_0.viewGO, "EnemyGroup/#txt_Name")
	arg_1_0._txtSelfRank = gohelper.findChildText(arg_1_0.viewGO, "PlayerGroup/Badge/#txt_badge")
	arg_1_0._txtEnemyRank = gohelper.findChildText(arg_1_0.viewGO, "EnemyGroup/Badge/#txt_badge")
	arg_1_0._goSelfIconRoot = gohelper.findChild(arg_1_0.viewGO, "PlayerGroup/HeroHeadIcon")
	arg_1_0._goEnemyIconRoot = gohelper.findChild(arg_1_0.viewGO, "EnemyGroup/HeroHeadIcon")
	arg_1_0._selfHeadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "PlayerGroup/HeroHeadIcon/#simage_headicon")
	arg_1_0._enemyHeadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "EnemyGroup/HeroHeadIcon/#simage_headicon")
	arg_1_0._txtSelfAddScore = gohelper.findChildText(arg_1_0.viewGO, "PlayerGroup/Score/#txt_Add")
	arg_1_0._txtEnemyAddScore = gohelper.findChildText(arg_1_0.viewGO, "EnemyGroup/Score/#txt_Add")
	arg_1_0._txtSelfReduceScore = gohelper.findChildText(arg_1_0.viewGO, "PlayerGroup/Score/#txt_Reduce")
	arg_1_0._txtEnemyReduceScore = gohelper.findChildText(arg_1_0.viewGO, "EnemyGroup/Score/#txt_Reduce")
	arg_1_0._btnReplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Replay")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnReplay:AddClickListener(arg_2_0._onClickBtnReplay, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnReplay:RemoveClickListener()
end

function var_0_0._onClickBtnReplay(arg_4_0)
	Activity182Rpc.instance:sendAct182GetFriendFightMessageRequest(arg_4_0._actId, arg_4_0.recordData.friendPlayerInfo.userId, arg_4_0.recordData.uid)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._actId = Activity182Model.instance:getCurActId()
end

function var_0_0.onUpdateData(arg_6_0, arg_6_1)
	arg_6_0.recordData = arg_6_1

	local var_6_0 = arg_6_1.playerInfo
	local var_6_1 = arg_6_1.friendPlayerInfo
	local var_6_2 = var_6_0.rank
	local var_6_3 = var_6_1.rank
	local var_6_4 = tonumber(var_6_0.hurt)
	local var_6_5 = tonumber(var_6_1.hurt)
	local var_6_6 = var_6_0.isWin
	local var_6_7 = var_6_1.isWin
	local var_6_8 = var_6_0.name
	local var_6_9 = var_6_1.name
	local var_6_10 = lua_auto_chess_rank.configDict[arg_6_0._actId][var_6_2]
	local var_6_11 = lua_auto_chess_rank.configDict[arg_6_0._actId][var_6_3]
	local var_6_12 = var_6_10 and var_6_10.name or luaLang("autochess_badgeitem_noget")
	local var_6_13 = var_6_11 and var_6_11.name or luaLang("autochess_badgeitem_noget")
	local var_6_14 = var_6_0.portrait
	local var_6_15 = var_6_1.portrait

	arg_6_0._txtSelfRank.text = var_6_12
	arg_6_0._txtEnemyRank.text = var_6_13
	arg_6_0._txtSelfName.text = var_6_8
	arg_6_0._txtEnemyName.text = var_6_9

	gohelper.setActive(arg_6_0._goSelfWinFlag, var_6_6)
	gohelper.setActive(arg_6_0._goEnemyWinFlag, var_6_7)

	arg_6_0._txtSelfReduceScore.text = "-" .. var_6_5
	arg_6_0._txtEnemyReduceScore.text = "-" .. var_6_4

	gohelper.setActive(arg_6_0._txtSelfReduceScore.gameObject, true)
	gohelper.setActive(arg_6_0._txtEnemyReduceScore.gameObject, true)
	gohelper.setActive(arg_6_0._txtSelfAddScore.gameObject, false)
	gohelper.setActive(arg_6_0._txtEnemyAddScore.gameObject, false)

	if not arg_6_0._selfLiveHeadIcon then
		arg_6_0._selfLiveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_6_0._selfHeadicon)
	end

	arg_6_0._selfLiveHeadIcon:setLiveHead(var_6_14)

	if not arg_6_0._enemyLiveHeadIcon then
		arg_6_0._enemyLiveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_6_0._enemyHeadicon)
	end

	arg_6_0._enemyLiveHeadIcon:setLiveHead(var_6_15)
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

return var_0_0
