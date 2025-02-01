module("modules.logic.enemyinfo.view.tab.EnemyInfoWeekWalkTabView", package.seeall)

slot0 = class("EnemyInfoWeekWalkTabView", UserDataDispose)

function slot0.onInitView(slot0)
	slot0.goweekwalktab = gohelper.findChild(slot0.viewGO, "#go_tab_container/#go_weekwalktab")
	slot0.simagebattlelistbg = gohelper.findChildSingleImage(slot0.goweekwalktab, "#simage_battlelistbg")
	slot0.gobattleitem = gohelper.findChild(slot0.goweekwalktab, "scroll_battle/Viewport/battlelist/#go_battlebtntemplate")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0.gobattleitem, false)
	slot0.simagebattlelistbg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))
end

function slot0.onOpen(slot0)
	slot0._mapId = slot0.viewParam.mapId
	slot3 = WeekWalkModel.instance:getInfo():getMapInfo(slot0._mapId).battleIds
	slot0._battleIds = slot3
	slot0._mapConfig = WeekWalkConfig.instance:getMapConfig(slot0._mapId)

	if lua_weekwalk_type.configDict[slot0._mapConfig.type].showDetail <= 0 and slot2.isFinish <= 0 then
		gohelper.setActive(slot0.goweekwalktab, false)
		slot0.enemyInfoMo:setShowLeftTab(false)
		slot0:selectBattleId(slot0.viewParam.selectBattleId or slot3[1])

		return
	end

	slot0._btnList = {}
	slot0._statusList = {}

	for slot12 = 1, math.min(5, #slot2.battleInfos) do
		slot14 = gohelper.cloneInPlace(slot0.gobattleitem).gameObject
		slot15 = gohelper.findChildButton(slot14, "btn")
		gohelper.findChildText(slot14, "txt").text = "0" .. slot12
		slot20 = gohelper.findChild(slot14, "star2")
		slot21 = gohelper.findChild(slot14, "star3")

		gohelper.setActive(slot20, false)
		gohelper.setActive(slot21, false)
		gohelper.setActive(slot2:getStarNumConfig() <= 2 and slot20 or slot21, true)

		slot25 = {
			gohelper.findChild(slot14, "selectIcon"),
			slot16
		}

		for slot29 = 1, slot22.transform.childCount do
			UISpriteSetMgr.instance:setWeekWalkSprite(slot23:GetChild(slot29 - 1):GetComponentInChildren(gohelper.Type_Image), slot29 <= slot2:getBattleInfo(slot3[slot12]).star and "star_highlight4" or "star_null4", true)
			table.insert(slot25, slot31)
		end

		slot15:AddClickListener(slot0.selectBattleId, slot0, slot18)
		gohelper.setActive(slot14, true)
		table.insert(slot0._statusList, slot25)
		table.insert(slot0._btnList, slot15)
	end

	gohelper.setActive(slot0.goweekwalktab, true)
	slot0.enemyInfoMo:setShowLeftTab(true)
	slot0:selectBattleId(slot4)
end

function slot0.selectBattleId(slot0, slot1)
	slot0.enemyInfoMo:updateBattleId(slot1)

	if not slot0._statusList then
		return
	end

	for slot5, slot6 in ipairs(slot0._battleIds) do
		slot7 = slot6 == slot1

		if not slot0._statusList[slot5] then
			break
		end

		gohelper.setActive(slot8[1], slot7)

		if slot7 then
			SLFramework.UGUI.GuiHelper.SetColor(slot8[2], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(slot8[3], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(slot8[4], "#FFFFFF")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot8[2], "#6c6f64")
			SLFramework.UGUI.GuiHelper.SetColor(slot8[3], "#C1C5B6")
			SLFramework.UGUI.GuiHelper.SetColor(slot8[4], "#C1C5B6")
		end

		if slot8[5] then
			SLFramework.UGUI.GuiHelper.SetColor(slot8[5], slot7 and "#FFFFFF" or "#C1C5B6")
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.simagebattlelistbg:UnLoadImage()

	if slot0._btnList then
		for slot4, slot5 in ipairs(slot0._btnList) do
			slot5:RemoveClickListener()
		end
	end
end

return slot0
