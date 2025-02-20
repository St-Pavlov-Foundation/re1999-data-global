module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickTipsView", package.seeall)

slot0 = class("SummonNewCustomPickTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bg2")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._btncloseBg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeBg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btncloseBg:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btncloseBg:RemoveClickListener()
	slot0:removeEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, slot0.refreshUI, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._noGainHeroes = {}
	slot0._ownHeroes = {}
	slot0._gobg = gohelper.findChild(slot0.viewGO, "bg")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem")
	slot0._goNoGain = gohelper.findChild(slot0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	slot0._goOwn = gohelper.findChild(slot0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/#go_own")
	slot0._goTitleNoGain = gohelper.findChild(slot0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/Title1")
	slot0._goTitleOwn = gohelper.findChild(slot0.viewGO, "root/#scroll_rule/Viewport/#go_storeItem/Title2")

	gohelper.setActive(slot0._goitem, false)

	slot0._tfcontent = slot0._gocontent.transform
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	logNormal("SummonCustomPickChoiceList onOpen")
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshList()
end

function slot0.refreshList(slot0)
	slot0:refreshItems(SummonNewCustomPickChoiceListModel.instance.noGainList, slot0._noGainHeroes, slot0._goNoGain, slot0._goTitleNoGain)
	slot0:refreshItems(SummonNewCustomPickChoiceListModel.instance.ownList, slot0._ownHeroes, slot0._goOwn, slot0._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(slot0._tfcontent)
end

function slot0.refreshItems(slot0, slot1, slot2, slot3, slot4)
	if slot1 and #slot1 > 0 then
		gohelper.setActive(slot3, true)

		slot8 = true

		gohelper.setActive(slot4, slot8)

		for slot8, slot9 in ipairs(slot1) do
			slot0:getOrCreateItem(slot8, slot2, slot3).component:onUpdateMO(slot9)
		end
	else
		gohelper.setActive(slot3, false)
		gohelper.setActive(slot4, false)
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

		slot2[slot1] = slot4
	end

	return slot4
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
