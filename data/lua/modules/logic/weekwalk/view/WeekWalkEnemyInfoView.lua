module("modules.logic.weekwalk.view.WeekWalkEnemyInfoView", package.seeall)

slot0 = class("WeekWalkEnemyInfoView", BaseView)

function slot0.onOpen(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagebattlelistbg = gohelper.findChildSingleImage(slot0.viewGO, "go_battlelist/#simage_battlelistbg")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_battlelist/#btn_reset", AudioEnum.WeekWalk.play_artificial_ui_resetmap)
	slot0._mapId = slot0.viewParam.mapId

	slot0._simagebattlelistbg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))

	slot3 = WeekWalkModel.instance:getInfo():getMapInfo(slot0._mapId).battleIds

	if not slot0.viewParam.battleId then
		slot0.viewParam.battleId = slot3[1]
	end

	slot0._battleIds = slot3
	slot0._mapConfig = WeekWalkConfig.instance:getMapConfig(slot0._mapId)

	if lua_weekwalk_type.configDict[slot0._mapConfig.type].showDetail <= 0 and slot2.isFinish <= 0 then
		gohelper.setActive(slot0._btnreset.gameObject, false)
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "go_battlelist"), false)
		slot0:_doUpdateSelectIcon(slot0.viewParam.battleId)

		return
	end

	slot0._gobattlebtntemplate = gohelper.findChild(slot0.viewGO, "go_battlelist/scroll_battle/Viewport/battlelist/#go_battlebtntemplate")
	slot0._btnList = slot0:getUserDataTb_()
	slot0._statusList = slot0:getUserDataTb_()

	for slot11 = 1, math.min(5, #slot2.battleInfos) do
		slot13 = gohelper.cloneInPlace(slot0._gobattlebtntemplate).gameObject
		slot14 = gohelper.findChildButton(slot13, "btn")
		gohelper.findChildText(slot13, "txt").text = "0" .. slot11
		slot19 = gohelper.findChild(slot13, "star2")
		slot20 = gohelper.findChild(slot13, "star3")

		gohelper.setActive(slot19, false)
		gohelper.setActive(slot20, false)
		gohelper.setActive(slot2:getStarNumConfig() <= 2 and slot19 or slot20, true)

		slot24 = {
			gohelper.findChild(slot13, "selectIcon"),
			slot15
		}
		slot25 = 0

		for slot29 = 1, slot21.transform.childCount do
			UISpriteSetMgr.instance:setWeekWalkSprite(slot22:GetChild(slot29 - 1):GetComponentInChildren(gohelper.Type_Image), slot29 <= slot2:getBattleInfo(slot3[slot11]).star and "star_highlight4" or "star_null4", true)
			table.insert(slot24, slot31)
		end

		slot14:AddClickListener(slot0._changeBattleId, slot0, slot17)
		gohelper.addUIClickAudio(slot14.gameObject, AudioEnum.WeekWalk.play_artificial_ui_checkpointswitch)
		gohelper.setActive(slot13, true)
		table.insert(slot0._statusList, slot24)
		table.insert(slot0._btnList, slot14)
	end

	slot0._btnreset:AddClickListener(slot0._reset, slot0)

	slot9 = WeekWalkConfig.instance:getMapTypeConfig(slot0._mapId).canResetLayer > 0 and ViewMgr.instance:isOpen(ViewName.WeekWalkView)

	if slot0.viewParam.hideResetBtn then
		slot9 = false
	end

	gohelper.setActive(slot0._btnreset.gameObject, slot9 and false)

	if slot9 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideShowResetBtn)
	end

	slot0:_doUpdateSelectIcon(slot0.viewParam.battleId)
end

function slot0._reset(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkResetLayer, MsgBoxEnum.BoxType.Yes_No, function ()
		WeekwalkRpc.instance:sendResetLayerRequest(uv0._mapId)
		uv0:closeThis()
	end)
end

function slot0._changeBattleId(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot0.viewContainer:getEnemyInfoView()
	slot2._battleId = slot1

	slot2:_refreshUI()
	slot0:_updateSelectIcon()
end

function slot0._updateSelectIcon(slot0)
	slot0:_doUpdateSelectIcon(slot0.viewContainer:getEnemyInfoView()._battleId)
end

function slot0._doUpdateSelectIcon(slot0, slot1)
	slot0.viewContainer:getWeekWalkEnemyInfoViewRule():refreshUI(slot1)

	if not slot0._statusList then
		return
	end

	for slot6, slot7 in ipairs(slot0._battleIds) do
		slot8 = slot7 == slot1

		if not slot0._statusList[slot6] then
			break
		end

		gohelper.setActive(slot9[1], slot8)

		if slot8 then
			SLFramework.UGUI.GuiHelper.SetColor(slot9[2], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(slot9[3], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(slot9[4], "#FFFFFF")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot9[2], "#6c6f64")
			SLFramework.UGUI.GuiHelper.SetColor(slot9[3], "#C1C5B6")
			SLFramework.UGUI.GuiHelper.SetColor(slot9[4], "#C1C5B6")
		end

		if slot9[5] then
			SLFramework.UGUI.GuiHelper.SetColor(slot9[5], slot8 and "#FFFFFF" or "#C1C5B6")
		end
	end
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)

	if slot0._btnList then
		for slot4, slot5 in ipairs(slot0._btnList) do
			slot5:RemoveClickListener()
		end
	end

	slot0._btnreset:RemoveClickListener()
	slot0._simagebattlelistbg:UnLoadImage()
end

return slot0
