module("modules.logic.versionactivity2_5.autochess.view.AutoChessFriendBattleView", package.seeall)

local var_0_0 = class("AutoChessFriendBattleView", BaseView)
local var_0_1 = {
	100,
	100,
	105
}
local var_0_2 = {
	-463,
	-480,
	-490
}
local var_0_3 = {
	228,
	144,
	60
}
local var_0_4 = 70
local var_0_5 = {
	228,
	144,
	60
}
local var_0_6 = {
	100,
	100,
	110
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBadgeRoot = gohelper.findChild(arg_1_0.viewGO, "#go_BadgeRoot")
	arg_1_0._goReward = gohelper.findChild(arg_1_0.viewGO, "root/#go_Reward")
	arg_1_0._goRewardItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_Reward/reward/#go_RewardItem")
	arg_1_0._playerBadge = gohelper.findChildText(arg_1_0.viewGO, "root/Player/Badge/#txt_badge")
	arg_1_0._playerName = gohelper.findChildText(arg_1_0.viewGO, "root/Player/#txt_Name")
	arg_1_0._playerIconRoot = gohelper.findChild(arg_1_0.viewGO, "root/Player/HeroHeadIcon")
	arg_1_0._btnPlayerAreaClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Player/#btn_Check")
	arg_1_0._playerHeadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Player/HeroHeadIcon/#simage_headicon")
	arg_1_0._goPlayerChess1 = gohelper.findChild(arg_1_0.viewGO, "root/Player/Chess/chess1")
	arg_1_0._goPlayerChess2 = gohelper.findChild(arg_1_0.viewGO, "root/Player/Chess/chess2")
	arg_1_0._goPlayerChess3 = gohelper.findChild(arg_1_0.viewGO, "root/Player/Chess/chess3")
	arg_1_0._goPlayerSnapChess = gohelper.findChild(arg_1_0.viewGO, "root/Player/image_bg/chessbg/simage_chessbg/snapChess/go_Chess")
	arg_1_0._goPlayerLeaderMesh = gohelper.findChild(arg_1_0.viewGO, "root/Player/image_bg/chessbg/simage_chessbg/snapChess/#go_LeaderMesh")
	arg_1_0._enemyRoot = gohelper.findChild(arg_1_0.viewGO, "root/Enemy")
	arg_1_0._emptyEnemy = gohelper.findChild(arg_1_0.viewGO, "root/Enemy_empty")
	arg_1_0._enemyBadge = gohelper.findChildText(arg_1_0.viewGO, "root/Enemy/Badge/#txt_badge")
	arg_1_0._enemyName = gohelper.findChildText(arg_1_0.viewGO, "root/Enemy/#txt_Name")
	arg_1_0._enemyIconRoot = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/HeroHeadIcon")
	arg_1_0._enemyHeadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Enemy/HeroHeadIcon/#simage_headicon")
	arg_1_0._goEnemyChess1 = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/Chess/chess1")
	arg_1_0._goEnemyChess2 = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/Chess/chess2")
	arg_1_0._goEnemyChess3 = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/Chess/chess3")
	arg_1_0._goEnemySnapChess = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/image_bg/chessbg/simage_chessbg/snapChess/go_Chess")
	arg_1_0._goEnemyLeaderMesh = gohelper.findChild(arg_1_0.viewGO, "root/Enemy/image_bg/chessbg/simage_chessbg/snapChess/#go_LeaderMesh")
	arg_1_0._goSelfEmptyState = gohelper.findChild(arg_1_0.viewGO, "root/Player_emptyGroup")
	arg_1_0._goEnemyEmptyState = gohelper.findChild(arg_1_0.viewGO, "root/Enemy_emptyGroup")
	arg_1_0._btnEmptyStateGoFight = gohelper.findChildButtonWithAudio(arg_1_0._goSelfEmptyState, "#btn_Fight")
	arg_1_0._btnEnemyAreaClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Enemy/#btn_Check")
	arg_1_0._btnEnemySwitchLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Enemy/#btn_SwitchLeft")
	arg_1_0._btnEnemySwitchRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Enemy/#btn_SwitchRight")
	arg_1_0._goRecord = gohelper.findChild(arg_1_0.viewGO, "root/#btn_Record/txt_Record")
	arg_1_0._goRecordGray = gohelper.findChild(arg_1_0.viewGO, "root/#btn_Record/txt_RecordGrey")
	arg_1_0._btnBattleRecord = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Record")
	arg_1_0._btnBattleStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Start")
	arg_1_0._imageBattleStart = gohelper.findChildImage(arg_1_0.viewGO, "root/#btn_Start")
	arg_1_0._btnFriendList = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Friend")
	arg_1_0._btnJumpToFriend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Enemy_empty/#btn_AddFriend")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBattleStart:AddClickListener(arg_2_0.onClickBattleStart, arg_2_0)
	arg_2_0._btnBattleRecord:AddClickListener(arg_2_0.onClickBattleRecord, arg_2_0)
	arg_2_0._btnFriendList:AddClickListener(arg_2_0.onClickFriendList, arg_2_0)
	arg_2_0._btnJumpToFriend:AddClickListener(arg_2_0.onClickJumpToFriend, arg_2_0)
	arg_2_0._btnEnemySwitchRight:AddClickListener(arg_2_0.onClickNextFriendBtn, arg_2_0)
	arg_2_0._btnEnemySwitchLeft:AddClickListener(arg_2_0.onClickLastFriendBtn, arg_2_0)
	arg_2_0._btnEmptyStateGoFight:AddClickListener(arg_2_0.onClickGoFight, arg_2_0)
	arg_2_0:addEventCb(AutoChessController.instance, AutoChessEvent.SelectFriendSnapshot, arg_2_0.requestNewFriendSnapshot, arg_2_0)
	arg_2_0:addEventCb(Activity182Controller.instance, Activity182Event.UpdateInfo, arg_2_0._onUpdateInfo, arg_2_0)
	arg_2_0:addEventCb(SocialController.instance, SocialEvent.FriendsInfoChanged, arg_2_0._onFriendInfoUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBattleStart:RemoveClickListener()
	arg_3_0._btnBattleRecord:RemoveClickListener()
	arg_3_0._btnFriendList:RemoveClickListener()
	arg_3_0._btnEnemySwitchRight:RemoveClickListener()
	arg_3_0._btnEnemySwitchLeft:RemoveClickListener()
	arg_3_0._btnJumpToFriend:RemoveClickListener()
	arg_3_0._btnEmptyStateGoFight:RemoveClickListener()
end

function var_0_0.onClickBattleStart(arg_4_0)
	local var_4_0 = arg_4_0._enemySnap and arg_4_0._enemySnap.playerInfo
	local var_4_1 = arg_4_0._selfSnap and arg_4_0._selfSnap.playerInfo
	local var_4_2 = var_4_1 and var_4_1.userId ~= 0
	local var_4_3 = var_4_0 and var_4_0.userId ~= 0

	if not (var_4_2 and var_4_3) then
		return
	end

	local var_4_4 = arg_4_0._curFriendIdx
	local var_4_5 = Activity182Model.instance:getActMo(arg_4_0._actId):getFriendInfoList()[var_4_4].userId

	AutoChessRpc.instance:sendAutoChessEnterFriendFightSceneRequest(arg_4_0._actId, AutoChessEnum.ModuleId.Friend, var_4_5)
end

function var_0_0.onClickBattleRecord(arg_5_0)
	local var_5_0 = Activity182Model.instance:getActMo(arg_5_0._actId):getFriendFightRecords()

	if var_5_0 and #var_5_0 == 0 then
		GameFacade.showToastString(luaLang("activityweekwalkdeepview_empty"))

		return
	end

	AutoChessController.instance:openFriendBattleRecordView()
end

function var_0_0.onGotFriendFightRecordAndOpenRecordView(arg_6_0)
	arg_6_0:refreshBtnState()
	AutoChessController.instance:openFriendBattleRecordView()
end

function var_0_0.onClickFriendList(arg_7_0)
	AutoChessController.instance:openFriendListView()
end

function var_0_0.onClickNextFriendBtn(arg_8_0)
	local var_8_0 = arg_8_0._curFriendIdx
	local var_8_1 = Activity182Model.instance:getActMo(arg_8_0._actId):getFriendInfoList()[var_8_0 + 1]

	if not var_8_1 then
		return
	end

	arg_8_0:requestNewFriendSnapshot(var_8_1.userId)
end

function var_0_0.onClickLastFriendBtn(arg_9_0)
	local var_9_0 = arg_9_0._curFriendIdx
	local var_9_1 = Activity182Model.instance:getActMo(arg_9_0._actId):getFriendInfoList()[var_9_0 - 1]

	if not var_9_1 then
		return
	end

	arg_9_0:requestNewFriendSnapshot(var_9_1.userId)
end

function var_0_0.requestNewFriendSnapshot(arg_10_0, arg_10_1)
	arg_10_0._curFriendUserId = arg_10_1

	Activity182Rpc.instance:sendAct182GetFriendSnapshotsRequest(arg_10_0._actId, arg_10_0._curFriendUserId, arg_10_0.onChangeFriendSnapshot, arg_10_0)
end

function var_0_0.onClickGoFight(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.onChangeFriendSnapshot(arg_12_0)
	arg_12_0:resetSnapView()

	local var_12_0 = Activity182Model.instance:getActMo(arg_12_0._actId)
	local var_12_1 = var_12_0:getFriendInfoList()

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		if iter_12_1.userId == arg_12_0._curFriendUserId then
			arg_12_0._curFriendIdx = iter_12_0

			break
		end
	end

	arg_12_0._selfSnap = var_12_0.snapshot
	arg_12_0._enemySnap = var_12_0:getCurFriendSnapshot()

	arg_12_0:refreshPlayerInfoView()

	local var_12_2 = arg_12_0._selfSnap.warZones
	local var_12_3 = arg_12_0._selfSnap.master

	arg_12_0:refreshMonsterInfoView(var_12_2, var_12_3, true)

	if arg_12_0._enemySnap then
		local var_12_4 = arg_12_0._enemySnap.warZones
		local var_12_5 = arg_12_0._enemySnap.master

		arg_12_0:refreshMonsterInfoView(var_12_4, var_12_5, false)
	end

	arg_12_0:refreshChangeFriendBtn()
end

function var_0_0.onClickJumpToFriend(arg_13_0)
	JumpController.instance:jump(JumpEnum.JumpView.SocialView)
end

function var_0_0._onUpdateInfo(arg_14_0)
	Activity182Rpc.instance:sendAct182GetFriendFightRecordsRequest(arg_14_0._actId, arg_14_0.onGotFriendFightRecordCallback, arg_14_0)
end

function var_0_0._onFriendInfoUpdate(arg_15_0)
	Activity182Rpc.instance:sendAct182GetHasSnapshotFriendRequest(arg_15_0._actId, arg_15_0.onGotSnapshotFriendCallback, arg_15_0)
end

function var_0_0.onGotFriendFightRecordCallback(arg_16_0)
	arg_16_0:refreshBtnState()
end

function var_0_0.onGotSnapshotFriendCallback(arg_17_0)
	arg_17_0:refreshSnapView()
	arg_17_0:refreshChangeFriendBtn()
	arg_17_0:refreshBtnState()
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._actId = Activity182Model.instance:getCurActId()

	Activity182Rpc.instance:sendAct182GetFriendFightRecordsRequest(arg_18_0._actId, arg_18_0.onGotFriendFightRecordCallback, arg_18_0)

	arg_18_0._chessGoList = arg_18_0:getUserDataTb_()
	arg_18_0._leaderMeshGo = nil
	arg_18_0._enemyLeaderMeshGo = nil

	arg_18_0:resetSnapView()
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	AudioMgr.instance:trigger(AudioEnum2_8.AutoChess.play_ui_fuleyuan_comity_open)

	arg_20_0._actId = Activity182Model.instance:getCurActId()

	arg_20_0:refreshSnapView()
	arg_20_0:refreshChangeFriendBtn()
	arg_20_0:refreshBtnState()
end

function var_0_0.refreshSnapView(arg_21_0)
	arg_21_0._curFriendIdx = 1

	local var_21_0 = Activity182Model.instance:getActMo(arg_21_0._actId)

	arg_21_0._selfSnap = var_21_0.snapshot
	arg_21_0._enemySnap = var_21_0:getCurFriendSnapshot()

	arg_21_0:refreshPlayerInfoView()

	local var_21_1 = arg_21_0._selfSnap.warZones
	local var_21_2 = arg_21_0._selfSnap.master

	arg_21_0:refreshMonsterInfoView(var_21_1, var_21_2, true)

	if arg_21_0._enemySnap then
		local var_21_3 = arg_21_0._enemySnap.warZones
		local var_21_4 = arg_21_0._enemySnap.master

		arg_21_0:refreshMonsterInfoView(var_21_3, var_21_4, false)
	end
end

function var_0_0.resetSnapView(arg_22_0)
	if arg_22_0._chessGoList and #arg_22_0._chessGoList > 0 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._chessGoList) do
			gohelper.destroy(iter_22_1)
		end
	end

	gohelper.setActive(arg_22_0._goPlayerChess1, false)
	gohelper.setActive(arg_22_0._goPlayerChess2, false)
	gohelper.setActive(arg_22_0._goPlayerChess3, false)
	gohelper.setActive(arg_22_0._goEnemyChess1, false)
	gohelper.setActive(arg_22_0._goEnemyChess2, false)
	gohelper.setActive(arg_22_0._goEnemyChess3, false)
	gohelper.setActive(arg_22_0._goPlayerSnapChess, false)
	gohelper.setActive(arg_22_0._goPlayerLeaderMesh, false)
	gohelper.setActive(arg_22_0._goEnemySnapChess, false)
	arg_22_0:refreshBtnState()
end

function var_0_0.refreshPlayerInfoView(arg_23_0)
	local var_23_0 = arg_23_0._selfSnap.playerInfo

	if var_23_0 and var_23_0.userId ~= 0 then
		arg_23_0._playerRankCfg = lua_auto_chess_rank.configDict[arg_23_0._actId][var_23_0.rank]

		if not arg_23_0._playerRankCfg then
			arg_23_0._playerBadge.text = luaLang("autochess_badgeitem_noget")
		end

		arg_23_0._playerBadge.text = arg_23_0._playerRankCfg.name

		arg_23_0._playerIconRoot:SetActive(true)

		local var_23_1 = PlayerModel.instance:getPlayinfo()

		arg_23_0._playerName.text = var_23_1.name

		local var_23_2 = var_23_1.portrait

		if not arg_23_0._playerLiveHeadIcon then
			arg_23_0._playerLiveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_23_0._playerHeadicon)
		end

		arg_23_0._playerLiveHeadIcon:setLiveHead(var_23_2)
	else
		gohelper.setActive(arg_23_0._goSelfEmptyState, true)
	end

	local var_23_3 = arg_23_0._enemySnap and arg_23_0._enemySnap.playerInfo

	if var_23_3 and var_23_3.userId ~= 0 then
		gohelper.setActive(arg_23_0._enemyRoot, true)
		gohelper.setActive(arg_23_0._emptyEnemy, false)

		arg_23_0._enemyRankCfg = lua_auto_chess_rank.configDict[arg_23_0._actId][var_23_3.rank]

		if not arg_23_0._enemyRankCfg then
			arg_23_0._enemyBadge.text = luaLang("autochess_badgeitem_noget")
		end

		local var_23_4 = SocialModel.instance:getPlayerMO(var_23_3.userId) or var_23_3

		arg_23_0._enemyBadge.text = arg_23_0._enemyRankCfg.name
		arg_23_0._enemyName.text = var_23_4.name

		arg_23_0._enemyIconRoot:SetActive(true)

		local var_23_5 = var_23_4.portrait

		if not arg_23_0._enemyLiveHeadIcon then
			arg_23_0._enemyLiveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_23_0._enemyHeadicon)
		end

		arg_23_0._enemyLiveHeadIcon:setLiveHead(var_23_5)
	else
		gohelper.setActive(arg_23_0._enemyRoot, false)
		gohelper.setActive(arg_23_0._emptyEnemy, true)
	end
end

function var_0_0.refreshMonsterInfoView(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		local var_24_1 = iter_24_1.id
		local var_24_2 = iter_24_1.positions

		for iter_24_2, iter_24_3 in ipairs(var_24_2) do
			local var_24_3 = iter_24_3.index
			local var_24_4 = iter_24_3.chess.id
			local var_24_5 = {
				zoneId = var_24_1,
				chessId = var_24_4,
				idx = var_24_3
			}

			var_24_0[#var_24_0 + 1] = var_24_5
		end
	end

	local var_24_6 = arg_24_3 and "_goPlayerChess" or "_goEnemyChess"
	local var_24_7 = arg_24_3 and arg_24_0._goPlayerSnapChess or arg_24_0._goEnemySnapChess

	for iter_24_4, iter_24_5 in ipairs(var_24_0) do
		local var_24_8 = AutoChessConfig.instance:getChessCfgById(iter_24_5.chessId)
		local var_24_9 = var_24_8[next(var_24_8)]

		if iter_24_4 <= 3 then
			local var_24_10 = arg_24_0[var_24_6 .. iter_24_4]

			gohelper.setActive(var_24_10, true)

			local var_24_11 = gohelper.findChild(var_24_10, "Mesh")

			MonoHelper.addNoUpdateLuaComOnceToGo(var_24_11, AutoChessMeshComp):setData(var_24_9.image)
		end

		local var_24_12 = gohelper.cloneInPlace(var_24_7, iter_24_5.chessId)

		arg_24_0._chessGoList[#arg_24_0._chessGoList + 1] = var_24_12

		gohelper.setActive(var_24_12, true)

		local var_24_13 = gohelper.findChild(var_24_12, "Mesh")

		MonoHelper.addNoUpdateLuaComOnceToGo(var_24_13, AutoChessMeshComp):setData(var_24_9.image)

		local var_24_14 = 0
		local var_24_15

		if arg_24_3 then
			var_24_14 = var_0_2[iter_24_5.zoneId] + iter_24_5.idx * var_0_1[iter_24_5.zoneId]
			var_24_15 = var_0_3[iter_24_5.zoneId]
		else
			var_24_14 = var_0_4 + (iter_24_5.idx - 5) * var_0_6[iter_24_5.zoneId]
			var_24_15 = var_0_5[iter_24_5.zoneId]
		end

		recthelper.setAnchor(var_24_12.transform, var_24_14, var_24_15)

		local var_24_16, var_24_17, var_24_18 = transformhelper.getLocalScale(var_24_12.transform)

		var_24_16 = arg_24_3 and -1 * var_24_16 or var_24_16

		transformhelper.setLocalScale(var_24_12.transform, var_24_16, var_24_17, var_24_18)
	end

	if not arg_24_2 then
		return
	end

	local var_24_19 = arg_24_3 and arg_24_0._goPlayerLeaderMesh or arg_24_0._goEnemyLeaderMesh
	local var_24_20 = arg_24_2.id
	local var_24_21 = lua_auto_chess_master.configDict[var_24_20]

	if var_24_21 then
		MonoHelper.addNoUpdateLuaComOnceToGo(var_24_19, AutoChessMeshComp):setData(var_24_21.image, false, true)
	end
end

function var_0_0.refreshChangeFriendBtn(arg_25_0)
	local var_25_0 = arg_25_0._curFriendIdx
	local var_25_1 = Activity182Model.instance:getActMo(arg_25_0._actId):getFriendInfoList()

	gohelper.setActive(arg_25_0._btnEnemySwitchRight.gameObject, var_25_0 < #var_25_1)
	gohelper.setActive(arg_25_0._btnEnemySwitchLeft.gameObject, var_25_0 > 1)
end

function var_0_0.refreshBtnState(arg_26_0)
	local var_26_0 = arg_26_0._enemySnap and arg_26_0._enemySnap.playerInfo
	local var_26_1 = arg_26_0._selfSnap and arg_26_0._selfSnap.playerInfo
	local var_26_2 = var_26_1 and var_26_1.userId ~= 0
	local var_26_3 = var_26_0 and var_26_0.userId ~= 0
	local var_26_4 = var_26_2 and var_26_3

	SLFramework.UGUI.GuiHelper.SetColor(arg_26_0._imageBattleStart, var_26_4 and "#FFFFFF" or "#B0B0B0")

	local var_26_5 = Activity182Model.instance:getActMo(arg_26_0._actId):getFriendFightRecords()
	local var_26_6 = false

	if var_26_5 then
		for iter_26_0, iter_26_1 in ipairs(var_26_5) do
			var_26_6 = true
		end
	end

	local var_26_7 = not var_26_6

	gohelper.setActive(arg_26_0._goRecord, not var_26_7)
	gohelper.setActive(arg_26_0._goRecordGray, var_26_7)
	ZProj.UGUIHelper.SetGrayscale(arg_26_0._btnBattleRecord.gameObject, var_26_7)
end

function var_0_0.onClose(arg_27_0)
	AutoChessController.instance:openMainView()
end

return var_0_0
