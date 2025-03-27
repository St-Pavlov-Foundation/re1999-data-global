module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeInstrumentSetView", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeInstrumentSetView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "root/#txt_info")
	slot0._goinstrument = gohelper.findChild(slot0.viewGO, "root/#go_instrument")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._indexList = tabletool.copy(VersionActivity2_4MusicFreeModel.instance:getInstrumentIndexList())

	slot0:_initItem()
	slot0:_updateItems()
end

function slot0._initItem(slot0)
	slot0._itemList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs(Activity179Config.instance:getInstrumentSwitchList()) do
		slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goinstrument), VersionActivity2_4MusicFreeInstrumentSetItem)
		slot0._itemList[slot5] = slot9

		slot9:onUpdateMO(slot6, slot0)
	end
end

function slot0._updateItems(slot0)
	for slot4, slot5 in ipairs(slot0._itemList) do
		slot5:updateIndex()
	end

	slot0._txtinfo.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("MusicInstrumentsSelectedTips"), string.format("<color=#C66030>%s</color>/%s", slot0:_getSelectedNum(), 2))
	slot0._hasSelectedChange = true
end

function slot0.addInstrument(slot0, slot1)
	if VersionActivity2_4MusicEnum.SelectInstrumentNum <= slot0:_getSelectedNum() then
		return
	end

	slot0._indexList[tabletool.indexOf(slot0._indexList, 0)] = slot1

	slot0:_updateItems()
end

function slot0.removeInstrument(slot0, slot1)
	if tabletool.indexOf(slot0._indexList, slot1) then
		slot0._indexList[slot2] = 0

		slot0:_updateItems()
	end
end

function slot0._getSelectedNum(slot0)
	for slot5, slot6 in ipairs(slot0._indexList) do
		if slot6 ~= 0 then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
	if not slot0._hasSelectedChange then
		return
	end

	VersionActivity2_4MusicFreeModel.instance:setInstrumentIndexList(slot0._indexList)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.InstrumentSelectChange)
end

function slot0.onDestroyView(slot0)
end

return slot0
