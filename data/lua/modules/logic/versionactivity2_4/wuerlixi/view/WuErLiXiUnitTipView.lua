module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiUnitTipView", package.seeall)

slot0 = class("WuErLiXiUnitTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._scrollunits = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_units")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_units/Viewport/#go_content")
	slot0._gounititem = gohelper.findChild(slot0.viewGO, "#scroll_units/Viewport/#go_content/#go_unititem")
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclose1:AddClickListener(slot0._btnclose1OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnclose1:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclose1OnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._unitItems = {}
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	for slot4, slot5 in pairs(slot0._unitItems) do
		slot5:hide()
	end

	for slot5, slot6 in ipairs(WuErLiXiMapModel.instance:getUnlockElements()) do
		if not slot0._unitItems[slot6.id] then
			slot0._unitItems[slot6.id] = WuErLiXiUnitTipItem.New()

			slot0._unitItems[slot6.id]:init(gohelper.cloneInPlace(slot0._gounititem))
		end

		slot0._unitItems[slot6.id]:setItem(slot6)
	end
end

return slot0
