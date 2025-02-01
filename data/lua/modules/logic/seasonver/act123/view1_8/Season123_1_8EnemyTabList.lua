module("modules.logic.seasonver.act123.view1_8.Season123_1_8EnemyTabList", package.seeall)

slot0 = class("Season123_1_8EnemyTabList", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebattlelistbg = gohelper.findChildSingleImage(slot0.viewGO, "go_battlelist/#simage_battlelistbg")
	slot0._gobattlebtntemplate = gohelper.findChild(slot0.viewGO, "go_battlelist/scroll_battle/Viewport/battlelist/#go_battlebtntemplate")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebattlelistbg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))

	slot0._tabItems = {}
end

function slot0.onDestroyView(slot0)
	if slot0._tabItems then
		for slot4, slot5 in ipairs(slot0._tabItems) do
			slot5.btn:RemoveClickListener()
		end

		slot0._tabItems = nil
	end

	slot0._simagebattlelistbg:UnLoadImage()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.EnemyDetailSwitchTab, slot0.refreshSelect, slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshItems()
	slot0:refreshSelect()
end

function slot0.refreshItems(slot0)
	for slot5 = 1, #Season123EnemyModel.instance:getBattleIds() do
		slot6 = slot0:getOrCreateTabItem(slot5)
		slot6.txt.text = "0" .. tostring(slot5)
		slot7 = slot1[slot5]

		for slot12 = 1, slot6.starCount do
			if slot6["imageStar" .. slot12] then
				UISpriteSetMgr.instance:setWeekWalkSprite(slot13, slot12 <= 1 and "star_highlight4" or "star_null4", true)
			end
		end
	end
end

function slot0.getOrCreateTabItem(slot0, slot1)
	if not slot0._tabItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot3 = gohelper.cloneInPlace(slot0._gobattlebtntemplate)
		slot2.go = slot3

		gohelper.setActive(slot2.go, true)

		slot2.btn = gohelper.findChildButton(slot3, "btn")
		slot2.txt = gohelper.findChildText(slot3, "txt")
		slot2.selectIcon = gohelper.findChild(slot3, "selectIcon")
		slot2.starGo2 = gohelper.findChild(slot3, "star2")
		slot2.starGo3 = gohelper.findChild(slot3, "star3")
		slot2.starGo = slot2.starGo3

		gohelper.setActive(slot2.starGo2, false)
		gohelper.setActive(slot2.starGo3, false)
		gohelper.setActive(slot2.starGo, true)

		slot2.starCount = slot2.starGo.transform.childCount

		for slot8 = 1, slot2.starCount do
			slot2["imageStar" .. slot8] = slot4:GetChild(slot8 - 1):GetComponentInChildren(gohelper.Type_Image)
		end

		slot2.btn:AddClickListener(slot0.onClickTab, slot0, slot1)
		gohelper.addUIClickAudio(slot2.btn.gameObject, AudioEnum.WeekWalk.play_artificial_ui_checkpointswitch)

		slot0._tabItems[slot1] = slot2
	end

	return slot2
end

function slot0.onClickTab(slot0, slot1)
	Season123EnemyController.instance:switchTab(slot1)
end

function slot0.refreshSelect(slot0)
	for slot5, slot6 in ipairs(Season123EnemyModel.instance:getBattleIds()) do
		slot8 = Season123EnemyModel.instance.selectIndex == slot5

		gohelper.setActive(slot0:getOrCreateTabItem(slot5).selectIcon, slot8)

		if slot8 then
			SLFramework.UGUI.GuiHelper.SetColor(slot7.txt, "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(slot7.imageStar1, "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(slot7.imageStar2, "#FFFFFF")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot7.txt, "#6c6f64")
			SLFramework.UGUI.GuiHelper.SetColor(slot7.imageStar1, "#C1C5B6")
			SLFramework.UGUI.GuiHelper.SetColor(slot7.imageStar2, "#C1C5B6")
		end

		if slot7.imageStar3 then
			SLFramework.UGUI.GuiHelper.SetColor(slot7.imageStar3, slot8 and "#FFFFFF" or "#C1C5B6")
		end
	end
end

return slot0
