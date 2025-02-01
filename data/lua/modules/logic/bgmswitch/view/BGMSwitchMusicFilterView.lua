module("modules.logic.bgmswitch.view.BGMSwitchMusicFilterView", package.seeall)

slot0 = class("BGMSwitchMusicFilterView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goobtain = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_obtain")
	slot0._scrollAmount = gohelper.findChildScrollRect(slot0.viewGO, "container/layoutgroup/#go_obtain/#scroll_Amount")
	slot0._gotypeitem = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_obtain/#scroll_Amount/Viewport/Container/#go_typeitem")
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
	BGMSwitchModel.instance:clearFilterTypes()
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.FilterClassSelect)
	slot0:_refreshView()
end

function slot0._btnconfirmOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._items = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_addSelfEvents()
	slot0:_refreshView()
end

function slot0._addSelfEvents(slot0)
end

function slot0._refreshView(slot0)
	slot0:_refreshContent()
	slot0:_refreshItems()
end

function slot0._refreshContent(slot0)
end

function slot0._refreshItems(slot0)
	slot1 = {}
	slot2 = {}

	if BGMSwitchModel.instance:getBGMSelectType() == BGMSwitchEnum.SelectType.All then
		slot2 = BGMSwitchModel.instance:getUnfilteredAllBgmsSorted()
	elseif slot3 == BGMSwitchEnum.SelectType.Loved then
		slot2 = BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted()
	end

	for slot7, slot8 in pairs(slot2) do
		slot1[BGMSwitchConfig.instance:getBGMSwitchCO(slot8).audioType] = true
	end

	for slot7, slot8 in pairs(slot1) do
		if not slot0._items[slot7] then
			slot9 = BGMSwitchMusicFilterItem.New()

			slot9:init(gohelper.cloneInPlace(slot0._gotypeitem, slot7))

			slot0._items[slot7] = slot9
		end

		slot0._items[slot7]:setItem(BGMSwitchConfig.instance:getBGMTypeCO(slot7))
	end
end

function slot0.onClose(slot0)
	slot0:_removeSelfEvents()
end

function slot0._removeSelfEvents(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._items then
		for slot4, slot5 in pairs(slot0._items) do
			slot5:destroy()
		end
	end
end

return slot0
