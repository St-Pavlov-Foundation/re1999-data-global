module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPvpSettleView", package.seeall)

local var_0_0 = class("AutoChessPvpSettleView", BaseView)
local var_0_1 = {
	48,
	48,
	47.6
}
local var_0_2 = {
	50,
	42.2,
	31
}
local var_0_3 = {
	-81,
	-120,
	-160
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goWin = gohelper.findChild(arg_1_0.viewGO, "root/#go_Win")
	arg_1_0._goLose = gohelper.findChild(arg_1_0.viewGO, "root/#go_Lose")
	arg_1_0._goBadge = gohelper.findChild(arg_1_0.viewGO, "root/Left/#go_Badge")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "root/Right/Round/image/#txt_Round")
	arg_1_0._txtDamage = gohelper.findChildText(arg_1_0.viewGO, "root/Right/Damage/image/#txt_Damage")
	arg_1_0._goHp = gohelper.findChild(arg_1_0.viewGO, "root/Right/#go_Hp")
	arg_1_0._txtHp = gohelper.findChildText(arg_1_0.viewGO, "root/Right/#go_Hp/image/#txt_Hp")
	arg_1_0._goChess = gohelper.findChild(arg_1_0.viewGO, "root/Right/Team/Viewport/Content/#go_Chess")
	arg_1_0._goLeaderMesh = gohelper.findChild(arg_1_0.viewGO, "root/Right/Team/Laeder/#go_LeaderMesh")
	arg_1_0._goSnapLeaderMesh = gohelper.findChild(arg_1_0.viewGO, "root/Right/Screen/simage_chessbg/#go_LeaderMesh")
	arg_1_0._goSnapChess = gohelper.findChild(arg_1_0.viewGO, "root/Right/Screen/simage_chessbg/go_Chess")
	arg_1_0._btnSaveBattle = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Right/Screen/#btn_confirm")
	arg_1_0._goSaveBattle = gohelper.findChild(arg_1_0.viewGO, "root/Right/Screen/#btn_confirm")
	arg_1_0._goSaved = gohelper.findChild(arg_1_0.viewGO, "root/Right/Screen/#btn_confirmed")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSaveBattle:AddClickListener(arg_2_0.onClickSaveBattle, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnSaveBattle:RemoveClickListener()
end

function var_0_0.onClickSaveBattle(arg_4_0)
	local var_4_0 = Activity182Model.instance:getCurActId()

	Activity182Rpc.instance:sendAct182SaveSnapshotRequest(var_4_0, arg_4_0.onSaveSnapshotResponse, arg_4_0)
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	local var_6_0 = arg_6_0:getResInst(AutoChessStrEnum.ResPath.BadgeItem, arg_6_0._goBadge)

	arg_6_0.badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_0, AutoChessBadgeItem)

	gohelper.setActive(arg_6_0._goSaved, false)
	gohelper.setActive(arg_6_0._goSaveBattle, true)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_award_get)

	arg_8_0.settleData = AutoChessModel.instance.settleData

	if arg_8_0.settleData then
		local var_8_0 = Activity182Model.instance:getActMo()

		arg_8_0.badgeItem:setData(arg_8_0.settleData.rank, var_8_0.score, AutoChessBadgeItem.ShowType.PvpSettleView)
		arg_8_0.badgeItem:playProgressAnim(arg_8_0.settleData.score)

		local var_8_1 = AutoChessConfig.instance:getEpisodeCO(arg_8_0.settleData.episodeId).maxRound

		arg_8_0._txtRound.text = string.format("%d/%d", arg_8_0.settleData.round, var_8_1)

		local var_8_2 = tonumber(arg_8_0.settleData.remainingHp)

		arg_8_0._txtHp.text = var_8_2

		gohelper.setActive(arg_8_0._goHp, var_8_2 ~= 0)

		arg_8_0._txtDamage.text = arg_8_0.settleData.totalInjury

		local var_8_3 = lua_auto_chess_master.configDict[arg_8_0.settleData.masterId]

		if var_8_3 then
			MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._goLeaderMesh, AutoChessMeshComp):setData(var_8_3.image, false, true)
		end

		gohelper.setActive(arg_8_0._goWin, arg_8_0.settleData.round == var_8_1)
		gohelper.setActive(arg_8_0._goLose, arg_8_0.settleData.round ~= var_8_1)
		gohelper.setActive(arg_8_0._goChess, false)
	end

	gohelper.setActive(arg_8_0._goSnapChess, false)
	gohelper.setActive(arg_8_0._goSnapLeaderMesh, false)
	arg_8_0:_createSnapshotMap()
end

function var_0_0.onClose(arg_9_0)
	AutoChessController.instance:checkRankUp()
	AutoChessController.instance:onSettleViewClose()
end

function var_0_0.onSaveSnapshotResponse(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == 0 then
		GameFacade.showToast(ToastEnum.AutoChessSnapShotSave)
		gohelper.setActive(arg_10_0._goSaved, true)
		gohelper.setActive(arg_10_0._goSaveBattle, false)
	end
end

function var_0_0._createSnapshotMap(arg_11_0)
	arg_11_0.settleData = AutoChessModel.instance.settleData

	local var_11_0 = lua_auto_chess_master.configDict[arg_11_0.settleData.masterId]

	if var_11_0 then
		MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._goSnapLeaderMesh, AutoChessMeshComp):setData(var_11_0.image, false, true)
	end

	local var_11_1 = arg_11_0.settleData.warZones

	arg_11_0:refreshMonsterInfoView(var_11_1)
end

function var_0_0.refreshMonsterInfoView(arg_12_0, arg_12_1)
	arg_12_0._chessGoList = arg_12_0:getUserDataTb_()

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_1 = iter_12_1.id
		local var_12_2 = iter_12_1.positions

		for iter_12_2, iter_12_3 in ipairs(var_12_2) do
			local var_12_3 = iter_12_3.index
			local var_12_4 = iter_12_3.chess.id

			if var_12_4 ~= 0 then
				local var_12_5 = {
					zoneId = var_12_1,
					chessId = var_12_4,
					idx = var_12_3
				}

				var_12_0[#var_12_0 + 1] = var_12_5
			end
		end
	end

	local var_12_6 = arg_12_0._goSnapChess

	for iter_12_4, iter_12_5 in ipairs(var_12_0) do
		local var_12_7 = AutoChessConfig.instance:getChessCfgById(iter_12_5.chessId)
		local var_12_8, var_12_9 = next(var_12_7)

		if var_12_9 then
			local var_12_10 = gohelper.cloneInPlace(var_12_6, iter_12_5.chessId)

			arg_12_0._chessGoList[#arg_12_0._chessGoList + 1] = var_12_10

			gohelper.setActive(var_12_10, true)

			local var_12_11 = gohelper.findChild(var_12_10, "Mesh")

			MonoHelper.addNoUpdateLuaComOnceToGo(var_12_11, AutoChessMeshComp):setData(var_12_9.image)

			local var_12_12 = var_0_2[iter_12_5.zoneId] + iter_12_5.idx * var_0_1[iter_12_5.zoneId]
			local var_12_13 = var_0_3[iter_12_5.zoneId]

			recthelper.setAnchor(var_12_10.transform, var_12_12, var_12_13)

			local var_12_14, var_12_15, var_12_16 = transformhelper.getLocalScale(var_12_10.transform)
			local var_12_17 = -1 * var_12_14

			transformhelper.setLocalScale(var_12_10.transform, var_12_17, var_12_15, var_12_16)
		end
	end
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
