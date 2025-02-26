module("modules.logic.handbook.view.HandbookCGView", package.seeall)

slot0 = class("HandbookCGView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagelbwz4 = gohelper.findChildSingleImage(slot0.viewGO, "icon/#simage_lbwz4")
	slot0._btnchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_change")
	slot0._scrollcg = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_cg")
	slot0.verticalScrollPixelList = {}
	slot0._lastSelectId = nil
	slot0._ischanged = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._scrollcg:AddOnValueChanged(slot0._onValueChange, slot0)
	slot0._btnchange:AddClickListener(slot0._btnchangeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._scrollcg:RemoveOnValueChanged()
	slot0._btnchange:RemoveClickListener()
end

function slot0._btnchangeOnClick(slot0)
	HandbookController.instance:openStoryView()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getHandbookBg("full/bg_lb"))
	slot0._simagelbwz4:LoadImage(ResUrl.getHandbookBg("bg_lbwz4"))
	gohelper.addUIClickAudio(slot0._btnchange.gameObject, AudioEnum.UI.play_ui_screenplay_plot_switch)

	slot0._selectItemList = {}
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)

	slot0._csScroll = slot0.viewContainer:getCsScroll()._csMixScroll

	slot0:_refreshBtnList()

	slot0._scrollcg.verticalNormalizedPosition = 1
end

function slot0._refreshBtnList(slot0)
	for slot4 = 1, 2 do
		if not slot0._selectItemList[slot4] then
			slot5 = slot0:getUserDataTb_()
			slot5.go = gohelper.findChild(slot0.viewGO, "#scroll_btnlist/viewport/content/item" .. slot4)
			slot5.gobeselected = gohelper.findChild(slot5.go, "beselected")
			slot5.gounselected = gohelper.findChild(slot5.go, "unselected")
			slot5.chapternamecn1 = gohelper.findChildText(slot5.go, "beselected/chapternamecn")
			slot5.chapternameen1 = gohelper.findChildText(slot5.go, "beselected/chapternameen")
			slot5.chapternamecn2 = gohelper.findChildText(slot5.go, "unselected/chapternamecn")
			slot5.chapternameen2 = gohelper.findChildText(slot5.go, "unselected/chapternameen")
			slot5.btnclick = gohelper.findChildButtonWithAudio(slot5.go, "btnclick", AudioEnum.UI.Play_UI_Universal_Click)

			slot5.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot5)
			table.insert(slot0._selectItemList, slot5)
		end

		slot5.selectId = slot4

		gohelper.setActive(slot5.go, true)
	end

	if #slot0._selectItemList > 0 then
		slot0:_btnclickOnClick(slot0._selectItemList[1])
	else
		HandbookCGTripleListModel.instance:clearStoryList()
	end
end

function slot0._btnclickOnClick(slot0, slot1)
	slot0._ischanged = true

	if slot0._lastSelectId == slot1.selectId then
		return
	else
		slot0._lastSelectId = slot2
	end

	slot3 = {}
	slot4 = {}

	if slot2 == HandbookEnum.CGType.Dungeon then
		slot4 = HandbookConfig.instance:getDungeonCGList()
	elseif slot2 == HandbookEnum.CGType.Role then
		slot4 = HandbookConfig.instance:getRoleCGList()
	end

	slot3.cgList = slot4
	slot3.cgType = slot2

	HandbookCGTripleListModel.instance:setCGList(slot3)

	for slot8, slot9 in ipairs(slot0._selectItemList) do
		gohelper.setActive(slot9.gobeselected, slot2 == slot9.selectId)
		gohelper.setActive(slot9.gounselected, slot2 ~= slot9.selectId)
	end

	if slot0.verticalScrollPixelList[slot0._lastSelectId] then
		slot0._csScroll.VerticalScrollPixel = slot5
	else
		slot0._scrollcg.verticalNormalizedPosition = 1
	end

	slot0._ischanged = false
end

function slot0._onValueChange(slot0)
	if slot0._ischanged then
		return
	end

	slot0.verticalScrollPixelList[slot0._lastSelectId] = slot0._csScroll.VerticalScrollPixel
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.HandbookStoryView then
		ViewMgr.instance:closeView(ViewName.HandbookCGView, true)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._selectItemList) do
		slot5.btnclick:RemoveClickListener()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagelbwz4:UnLoadImage()
end

return slot0
