module("modules.logic.versionactivity2_5.autochess.view.AutoChessCourseView", package.seeall)

slot0 = class("AutoChessCourseView", BaseView)

function slot0.onInitView(slot0)
	slot0._goBadge = gohelper.findChild(slot0.viewGO, "root/#go_Badge")
	slot0._txtAllWinCnt = gohelper.findChildText(slot0.viewGO, "root/right/item1/#txt_AllWinCnt")
	slot0._txtPlayRound = gohelper.findChildText(slot0.viewGO, "root/right/item2/#txt_PlayRound")
	slot0._txtAllDamage = gohelper.findChildText(slot0.viewGO, "root/right/item3/#txt_AllDamage")
	slot0._txtChessCnt = gohelper.findChildText(slot0.viewGO, "root/right/item4/#txt_ChessCnt")
	slot0._goChessItem = gohelper.findChild(slot0.viewGO, "root/right/Chess/scroll_Chess/viewport/content/#go_ChessItem")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.actMo = Activity182Model.instance:getActMo()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)

	slot1 = slot0.actMo.historyInfo

	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.BadgeItemPath, slot0._goBadge), AutoChessBadgeItem, slot0):setData(slot1.maxRank, 99999, AutoChessBadgeItem.ShowType.CourseView)

	slot0._txtAllWinCnt.text = slot1.winCount
	slot0._txtPlayRound.text = slot1.survivalTotalRound
	slot0._txtAllDamage.text = slot1.totalHurt

	if GameUtil.splitString2(slot1.autoChessCount, true) then
		table.sort(slot4, function (slot0, slot1)
			return slot1[2] < slot0[2]
		end)

		for slot8, slot9 in ipairs(slot4) do
			if lua_auto_chess.configDict[slot9[1]][1].type == AutoChessStrEnum.ChessType.Support then
				UISpriteSetMgr.instance:setAutoChessSprite(gohelper.findChildImage(gohelper.cloneInPlace(slot0._goChessItem), "image_Bg"), "v2a5_autochess_quality2_" .. slot11.levelFromMall)
			else
				UISpriteSetMgr.instance:setAutoChessSprite(slot13, "v2a5_autochess_quality1_" .. slot11.levelFromMall)
			end

			MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot12, "Mesh"), AutoChessMeshComp):setData(slot11.image)
			gohelper.setActive(slot12, true)
		end

		slot0._txtChessCnt.text = #slot4
	else
		slot0._txtChessCnt.text = 0
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
