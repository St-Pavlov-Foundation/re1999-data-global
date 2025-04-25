module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPvpSettleView", package.seeall)

slot0 = class("AutoChessPvpSettleView", BaseView)

function slot0.onInitView(slot0)
	slot0._goWin = gohelper.findChild(slot0.viewGO, "root/#go_Win")
	slot0._goLose = gohelper.findChild(slot0.viewGO, "root/#go_Lose")
	slot0._goBadge = gohelper.findChild(slot0.viewGO, "root/Left/#go_Badge")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "root/Right/Round/image/#txt_Round")
	slot0._txtDamage = gohelper.findChildText(slot0.viewGO, "root/Right/Damage/image/#txt_Damage")
	slot0._goHp = gohelper.findChild(slot0.viewGO, "root/Right/#go_Hp")
	slot0._txtHp = gohelper.findChildText(slot0.viewGO, "root/Right/#go_Hp/image/#txt_Hp")
	slot0._goChess = gohelper.findChild(slot0.viewGO, "root/Right/Team/Viewport/Content/#go_Chess")
	slot0._goLeaderMesh = gohelper.findChild(slot0.viewGO, "root/Right/Team/Laeder/#go_LeaderMesh")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.BadgeItemPath, slot0._goBadge), AutoChessBadgeItem)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_award_get)

	slot0.settleData = AutoChessModel.instance.settleData

	if slot0.settleData then
		slot0.badgeItem:setData(slot0.settleData.rank, Activity182Model.instance:getActMo().score, AutoChessBadgeItem.ShowType.PvpSettleView)
		slot0.badgeItem:playProgressAnim(slot0.settleData.score)

		slot0._txtRound.text = string.format("%d/%d", slot0.settleData.round, lua_auto_chess_episode.configDict[slot0.settleData.episodeId].maxRound)
		slot3 = tonumber(slot0.settleData.remainingHp)
		slot0._txtHp.text = slot3

		gohelper.setActive(slot0._goHp, slot3 ~= 0)

		slot0._txtDamage.text = slot0.settleData.totalInjury

		if lua_auto_chess_master.configDict[slot0.settleData.masterId] then
			MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goLeaderMesh, AutoChessMeshComp):setData(slot4.image, false, true)
		end

		for slot8, slot9 in ipairs(slot0.settleData.chessIds) do
			if lua_auto_chess.configDict[slot9][1].type == AutoChessStrEnum.ChessType.Attack then
				UISpriteSetMgr.instance:setAutoChessSprite(gohelper.findChildImage(gohelper.cloneInPlace(slot0._goChess, slot9), "image_bg"), "v2a5_autochess_quality1_" .. slot10.levelFromMall)
			else
				UISpriteSetMgr.instance:setAutoChessSprite(slot12, "v2a5_autochess_quality2_" .. slot10.levelFromMall)
			end

			MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot11, "Mesh"), AutoChessMeshComp):setData(slot10.image)
		end

		gohelper.setActive(slot0._goWin, slot0.settleData.round == slot2)
		gohelper.setActive(slot0._goLose, slot0.settleData.round ~= slot2)
		gohelper.setActive(slot0._goChess, false)
	end
end

function slot0.onClose(slot0)
	AutoChessController.instance:checkRankUp()
	AutoChessController.instance:onSettleViewClose()
end

function slot0.onDestroyView(slot0)
end

return slot0
