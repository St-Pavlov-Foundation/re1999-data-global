module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPvpSettleView", package.seeall)

local var_0_0 = class("AutoChessPvpSettleView", BaseView)

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

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = arg_5_0:getResInst(AutoChessEnum.BadgeItemPath, arg_5_0._goBadge)

	arg_5_0.badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0, AutoChessBadgeItem)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_award_get)

	arg_7_0.settleData = AutoChessModel.instance.settleData

	if arg_7_0.settleData then
		local var_7_0 = Activity182Model.instance:getActMo()

		arg_7_0.badgeItem:setData(arg_7_0.settleData.rank, var_7_0.score, AutoChessBadgeItem.ShowType.PvpSettleView)
		arg_7_0.badgeItem:playProgressAnim(arg_7_0.settleData.score)

		local var_7_1 = lua_auto_chess_episode.configDict[arg_7_0.settleData.episodeId].maxRound

		arg_7_0._txtRound.text = string.format("%d/%d", arg_7_0.settleData.round, var_7_1)

		local var_7_2 = tonumber(arg_7_0.settleData.remainingHp)

		arg_7_0._txtHp.text = var_7_2

		gohelper.setActive(arg_7_0._goHp, var_7_2 ~= 0)

		arg_7_0._txtDamage.text = arg_7_0.settleData.totalInjury

		local var_7_3 = lua_auto_chess_master.configDict[arg_7_0.settleData.masterId]

		if var_7_3 then
			MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._goLeaderMesh, AutoChessMeshComp):setData(var_7_3.image, false, true)
		end

		for iter_7_0, iter_7_1 in ipairs(arg_7_0.settleData.chessIds) do
			local var_7_4 = lua_auto_chess.configDict[iter_7_1][1]
			local var_7_5 = gohelper.cloneInPlace(arg_7_0._goChess, iter_7_1)
			local var_7_6 = gohelper.findChildImage(var_7_5, "image_bg")

			if var_7_4.type == AutoChessStrEnum.ChessType.Attack then
				UISpriteSetMgr.instance:setAutoChessSprite(var_7_6, "v2a5_autochess_quality1_" .. var_7_4.levelFromMall)
			else
				UISpriteSetMgr.instance:setAutoChessSprite(var_7_6, "v2a5_autochess_quality2_" .. var_7_4.levelFromMall)
			end

			local var_7_7 = gohelper.findChild(var_7_5, "Mesh")

			MonoHelper.addNoUpdateLuaComOnceToGo(var_7_7, AutoChessMeshComp):setData(var_7_4.image)
		end

		gohelper.setActive(arg_7_0._goWin, arg_7_0.settleData.round == var_7_1)
		gohelper.setActive(arg_7_0._goLose, arg_7_0.settleData.round ~= var_7_1)
		gohelper.setActive(arg_7_0._goChess, false)
	end
end

function var_0_0.onClose(arg_8_0)
	AutoChessController.instance:checkRankUp()
	AutoChessController.instance:onSettleViewClose()
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
