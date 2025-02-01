module("modules.logic.seasonver.act123.view2_0.Season123_2_0DecomposeFilterView", package.seeall)

slot0 = class("Season123_2_0DecomposeFilterView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gorare = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_rare")
	slot0._gorareContainer = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_rare/#go_rareContainer")
	slot0._gorareItem = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_rare/#go_rareContainer/#go_rareItem")
	slot0._gotag = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_tag")
	slot0._scrolltag = gohelper.findChildScrollRect(slot0.viewGO, "container/layoutgroup/#go_tag/#scroll_tag")
	slot0._gotagContainer = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_tag/#scroll_tag/Viewport/#go_tagContainer")
	slot0._gotagItem = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_tag/#scroll_tag/Viewport/#go_tagContainer/#go_tagItem")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#btn_reset")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnresetOnClick(slot0)
	for slot4, slot5 in pairs(slot0.rareSelectTab) do
		slot0.rareSelectTab[slot4] = false
	end

	for slot4, slot5 in pairs(slot0.tagSelectTab) do
		slot0.tagSelectTab[slot4] = false
	end

	for slot4, slot5 in pairs(slot0.rareItemTab) do
		gohelper.setActive(slot5.goSelected, false)
		gohelper.setActive(slot5.goUnSelected, true)
	end

	for slot4, slot5 in pairs(slot0.tagItemTab) do
		gohelper.setActive(slot5.goSelected, false)
		gohelper.setActive(slot5.goUnSelected, true)
	end
end

function slot0._btnconfirmOnClick(slot0)
	Season123DecomposeModel.instance:setRareSelectItem(slot0.rareSelectTab)
	Season123DecomposeModel.instance:setTagSelectItem(slot0.tagSelectTab)
	Season123DecomposeModel.instance:clearCurSelectItem()
	Season123DecomposeModel.instance:initList()
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnResetBatchDecomposeView)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnDecomposeItemSelect)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorareItem, false)

	slot0.rareItemTab = slot0:getUserDataTb_()
	slot0.rareSelectTab = {}
	slot0.tagItemTab = slot0:getUserDataTb_()
	slot0.tagSelectTab = {}
end

function slot0.onOpen(slot0)
	slot0:createRareItem()
	slot0:createTagItem()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshRareSelectUI()
	slot0:refreshTagSelectUI()
end

function slot0.refreshRareSelectUI(slot0)
	slot0.rareSelectTab = tabletool.copy(Season123DecomposeModel.instance.rareSelectTab)

	for slot4, slot5 in pairs(slot0.rareItemTab) do
		gohelper.setActive(slot5.goSelected, slot0.rareSelectTab[slot4])
		gohelper.setActive(slot5.goUnSelected, not slot0.rareSelectTab[slot4])
	end
end

function slot0.refreshTagSelectUI(slot0)
	slot0.tagSelectTab = tabletool.copy(Season123DecomposeModel.instance.tagSelectTab)

	for slot4, slot5 in pairs(slot0.tagItemTab) do
		slot6 = slot5.data.id

		gohelper.setActive(slot5.goSelected, slot0.tagSelectTab[slot6])
		gohelper.setActive(slot5.goUnSelected, not slot0.tagSelectTab[slot6])
	end
end

function slot0.createRareItem(slot0)
	for slot4 = 5, 1, -1 do
		if not slot0.rareItemTab[slot4] then
			slot5 = {
				rare = slot4,
				go = gohelper.clone(slot0._gorareItem, slot0._gorareContainer, "rare" .. slot4)
			}
			slot5.goSelected = gohelper.findChild(slot5.go, "selected")
			slot5.goUnSelected = gohelper.findChild(slot5.go, "unselected")
			slot5.icon = gohelper.findChildImage(slot5.go, "image_rareicon")
			slot5.txt = gohelper.findChildText(slot5.go, "tagText")
			slot5.click = gohelper.findChildButtonWithAudio(slot5.go, "click")
			slot0.rareItemTab[slot4] = slot5
		end

		gohelper.setActive(slot5.go, true)
		gohelper.setActive(slot5.goUnSelected, true)
		gohelper.setActive(slot5.goSelected, false)
		UISpriteSetMgr.instance:setSeason123Sprite(slot5.icon, "v1a7_season_cardcareer_" .. slot4, true)
		SLFramework.UGUI.GuiHelper.SetColor(slot5.txt, "#C1C1C1")

		slot5.txt.text = luaLang("Season123Rare_" .. slot4)

		slot5.click:AddClickListener(slot0.rareItemOnClick, slot0, slot4)
	end
end

function slot0.rareItemOnClick(slot0, slot1)
	slot0:setRareSelectState(slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0.rareItemTab[slot1].txt, slot0.rareSelectTab[slot1] and "#FF7C41" or "#C1C1C1")
	gohelper.setActive(slot0.rareItemTab[slot1].goSelected, slot2)
	gohelper.setActive(slot0.rareItemTab[slot1].goUnSelected, not slot2)
end

function slot0.setRareSelectState(slot0, slot1)
	if slot0.rareSelectTab[slot1] then
		slot0.rareSelectTab[slot1] = false
	else
		slot0.rareSelectTab[slot1] = true
	end
end

function slot0.createTagItem(slot0)
	gohelper.CreateObjList(slot0, slot0.tagItemShow, slot0:tagItemSort(Season123Config.instance:getSeasonTagDesc(Season123DecomposeModel.instance.curActId)), slot0._gotagContainer, slot0._gotagItem)
end

function slot0.tagItemSort(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(tabletool.copy(slot1)) do
		table.insert(slot2, slot8)
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.order < slot1.order
	end)

	return slot2
end

function slot0.tagItemShow(slot0, slot1, slot2, slot3)
	slot4 = {
		data = slot2,
		go = slot1
	}
	slot4.goSelected = gohelper.findChild(slot4.go, "selected")
	slot4.goUnSelected = gohelper.findChild(slot4.go, "unselected")
	slot4.tagText = gohelper.findChildText(slot4.go, "tagText")
	slot4.click = gohelper.findChildButtonWithAudio(slot4.go, "click")

	slot4.click:AddClickListener(slot0.tagItemOnClick, slot0, slot2)
	gohelper.setActive(slot4.goSelected, false)
	gohelper.setActive(slot4.goUnSelected, true)
	SLFramework.UGUI.GuiHelper.SetColor(slot4.tagText, "#C1C1C1")

	slot4.tagText.text = slot2.desc
	slot0.tagItemTab[slot2.id] = slot4
end

function slot0.tagItemOnClick(slot0, slot1)
	slot2 = slot1.id

	slot0:setTagSelectState(slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot0.tagItemTab[slot2].tagText, slot0.tagSelectTab[slot2] and "#FF7C41" or "#C1C1C1")
	gohelper.setActive(slot0.tagItemTab[slot2].goSelected, slot3)
	gohelper.setActive(slot0.tagItemTab[slot2].goUnSelected, not slot3)
end

function slot0.setTagSelectState(slot0, slot1)
	if slot0.tagSelectTab[slot1] then
		slot0.tagSelectTab[slot1] = false
	else
		slot0.tagSelectTab[slot1] = true
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.rareItemTab) do
		slot5.click:RemoveClickListener()
	end

	for slot4, slot5 in pairs(slot0.tagItemTab) do
		slot5.click:RemoveClickListener()
	end
end

return slot0
