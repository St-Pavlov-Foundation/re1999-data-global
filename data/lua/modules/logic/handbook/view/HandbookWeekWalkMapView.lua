module("modules.logic.handbook.view.HandbookWeekWalkMapView", package.seeall)

slot0 = class("HandbookWeekWalkMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goleftarrow = gohelper.findChild(slot0.viewGO, "#go_leftarrow")
	slot0._gorightarrow = gohelper.findChild(slot0.viewGO, "#go_rightarrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.goweekList = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "weekwalkContainer/#go_week" .. slot4)
		slot5.name = gohelper.findChildText(slot5.go, "txt_name")
		slot5.click = gohelper.getClickWithAudio(slot5.go)

		slot5.click:AddClickListener(slot0.onClickGoWeek, slot0, slot4)
		table.insert(slot0.goweekList, slot5)
	end

	slot0.leftClick = gohelper.getClickWithAudio(slot0._goleftarrow)
	slot0.rightClick = gohelper.getClickWithAudio(slot0._gorightarrow)

	slot0.leftClick:AddClickListener(slot0.leftPageOnClick, slot0)
	slot0.rightClick:AddClickListener(slot0.rightPageOnClick, slot0)
	slot0._simagebg:LoadImage(ResUrl.getHandbookCharacterIcon("full/bg111"))
end

function slot0.onClickGoWeek(slot0, slot1)
	ViewMgr.instance:openView(ViewName.HandbookWeekWalkView, slot0:getMapCoByPageNumAndIndex(slot0.pageNum, slot1))
end

function slot0.leftPageOnClick(slot0)
	if slot0.pageNum <= 1 then
		return
	end

	slot0.pageNum = slot0.pageNum - 1

	slot0:refreshMapElements(slot0.pageNum)
end

function slot0.rightPageOnClick(slot0)
	if slot0.maxPageNum <= slot0.pageNum then
		return
	end

	slot0.pageNum = slot0.pageNum + 1

	slot0:refreshMapElements(slot0.pageNum)
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0.pageNum = 1
	slot0.pageSize = 3
	slot0.maxPageNum = math.ceil(#lua_weekwalk.configList / 3)

	slot0:refreshMapElements(slot0.pageNum)
end

function slot0.refreshMapElements(slot0, slot1)
	slot0.mapCoList = slot0:getMapCoListByPageNum(slot1)

	for slot6 = 1, #slot0.mapCoList do
		slot0.goweekList[slot6].name.text = slot0.mapCoList[slot6].name

		gohelper.setActive(slot0.goweekList[slot6].go, true)
	end

	for slot6 = slot2 + 1, 3 do
		gohelper.setActive(slot0.goweekList[slot6].go, false)
	end

	gohelper.setActive(slot0._goleftarrow, slot0.pageNum > 1)
	gohelper.setActive(slot0._gorightarrow, slot0.pageNum < slot0.maxPageNum)
end

function slot0.getMapCoListByPageNum(slot0, slot1)
	slot3 = {}
	slot4 = nil

	for slot8 = 1, 3 do
		if not lua_weekwalk.configList[(slot1 - 1) * 3 + slot8] then
			break
		end

		table.insert(slot3, slot4)
	end

	return slot3
end

function slot0.getMapCoByPageNumAndIndex(slot0, slot1, slot2)
	return lua_weekwalk.configList[(slot1 - 1) * 3 + slot2]
end

function slot0.onClose(slot0)
	slot0.leftClick:RemoveClickListener()
	slot0.rightClick:RemoveClickListener()
	slot0._simagebg:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.goweekList) do
		slot5.click:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
