module("modules.logic.dungeon.view.rolestory.RoleStoryTipView", package.seeall)

slot0 = class("RoleStoryTipView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0.itemList = {}
	slot0.goItem = gohelper.findChild(slot0.viewGO, "layout/item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnClose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnClose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btntipsOnClick(slot0)
	gohelper.setActive(slot0.goTips, false)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshView()
end

function slot0.onClose(slot0)
end

function slot0.refreshView(slot0)
	slot0.storyId = RoleStoryModel.instance:getCurActStoryId()
	slot1 = RoleStoryConfig.instance:getScoreConfig(slot0.storyId) or {}
	slot5 = #slot0.itemList

	for slot5 = 1, math.max(slot5, #slot1) do
		if not slot0.itemList[slot5] then
			slot0.itemList[slot5] = slot0:createItem(slot5)
		end

		slot0:updateItem(slot6, slot1[slot5], slot1[slot5 - 1])
	end
end

function slot0.createItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.index = slot1
	slot2.go = gohelper.cloneInPlace(slot0.goItem)
	slot2.txtNum = gohelper.findChildTextMesh(slot2.go, "#txt_num")
	slot2.txtScore = gohelper.findChildTextMesh(slot2.go, "#txt_score")
	slot2.goLine = gohelper.findChild(slot2.go, "line")

	gohelper.setActive(slot2.goLine, slot2.index ~= 1)

	return slot2
end

function slot0.updateItem(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot1.data = slot2

	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	slot1.txtScore.text = tostring(slot2.score)

	if slot3 and slot3.wave < slot2.wave - 1 then
		slot1.txtNum.text = formatLuaLang("rolestoryactivitytips_wave", string.format("%s-%s", GameUtil.getNum2Chinese(slot3.wave + 1), GameUtil.getNum2Chinese(slot2.wave)))
	else
		slot1.txtNum.text = formatLuaLang("rolestoryactivitytips_wave", GameUtil.getNum2Chinese(slot2.wave))
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
