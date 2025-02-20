module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceViewList", package.seeall)

slot0 = class("SummonNewCustomPickChoiceViewList", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._ownHeroes = {}
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/content")
	slot0._tfcontent = slot0._gocontent.transform
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem")

	gohelper.setActive(slot0._goitem, false)
end

function slot0.onOpen(slot0)
	logNormal("SummonNewCustomPickChoiceViewList onOpen")
	SummonNewCustomPickChoiceListModel.instance:clearSelectIds()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshList()
end

function slot0.refreshList(slot0)
	slot0:refreshItems(SummonNewCustomPickChoiceListModel.instance.ownList, slot0._ownHeroes, slot0._gocontent)
	ZProj.UGUIHelper.RebuildLayout(slot0._tfcontent)
end

function slot0.refreshItems(slot0, slot1, slot2, slot3)
	if slot1 and #slot1 > 0 then
		slot7 = true

		gohelper.setActive(slot3, slot7)

		for slot7, slot8 in ipairs(slot1) do
			slot0:getOrCreateItem(slot7, slot2, slot3).component:onUpdateMO(slot8)
		end
	else
		gohelper.setActive(slot3, false)
	end
end

function slot0.getOrCreateItem(slot0, slot1, slot2, slot3)
	if not slot2[slot1] then
		slot4 = slot0:getUserDataTb_()
		slot4.go = gohelper.clone(slot0._goitem, slot3, "item" .. tostring(slot1))

		gohelper.setActive(slot4.go, true)

		slot4.component = MonoHelper.addNoUpdateLuaComOnceToGo(slot4.go, SummonNewCustomPickChoiceItem)

		slot4.component:init(slot4.go)
		slot4.component:addEvents()
		slot4.component:setClickCallBack(function (slot0)
			SummonNewCustomPickChoiceController.instance:setSelect(slot0)
		end)

		slot2[slot1] = slot4
	end

	return slot4
end

function slot0.addEvents(slot0)
	slot0:addEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, slot0.refreshUI, slot0)
end

return slot0
