module("modules.logic.room.view.backpack.RoomBackpackView", package.seeall)

slot0 = class("RoomBackpackView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocategoryItem = gohelper.findChild(slot0.viewGO, "#scroll_category/viewport/content/#go_categoryItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnTabOnClick(slot0, slot1)
	if not slot0.viewContainer:checkTabId(slot1) then
		logError(string.format("RoomBackpackView._btnTabOnClick error, no subview, tabId:%s", slot1))

		return
	end

	if slot0._curSelectTab == slot1 then
		return
	end

	slot0.viewContainer:switchTab(slot1)

	slot0._curSelectTab = slot1

	slot0:refreshTab()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gocategoryItem, false)
	slot0:clearVar()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._curSelectTab = slot0.viewContainer:getDefaultSelectedTab()

	slot0:setTabItem()
	slot0:refreshTab()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_lower)
end

function slot0.setTabItem(slot0)
	for slot4, slot5 in ipairs(RoomBackpackViewContainer.TabSettingList) do
		if not slot0._tabDict[slot4] and not gohelper.isNil(gohelper.cloneInPlace(slot0._gocategoryItem, slot4)) then
			slot6 = slot0:getUserDataTb_()
			slot6.go = slot7
			slot6.btn = gohelper.getClickWithDefaultAudio(slot7)

			slot6.btn:AddClickListener(slot0._btnTabOnClick, slot0, slot4)

			slot6.goselected = gohelper.findChild(slot7, "#go_selected")
			slot6.gounselected = gohelper.findChild(slot7, "#go_normal")
			slot6.goreddot = gohelper.findChild(slot7, "#go_reddot")

			if slot4 == RoomBackpackViewContainer.SubViewTabId.Critter then
				RedDotController.instance:addRedDot(slot6.goreddot, RedDotEnum.DotNode.CritterIsFull)
			end

			slot8 = luaLang(slot5.namecn)
			gohelper.findChildText(slot7, "#go_normal/#txt_namecn").text = slot8
			gohelper.findChildText(slot7, "#go_selected/#txt_namecn").text = slot8
			slot11 = luaLang(slot5.nameen)
			gohelper.findChildText(slot7, "#go_normal/#txt_nameen").text = slot11
			gohelper.findChildText(slot7, "#go_selected/#txt_nameen").text = slot11

			gohelper.setActive(slot7, true)

			slot0._tabDict[slot4] = slot6
		end
	end
end

function slot0.refreshTab(slot0)
	for slot4, slot5 in pairs(slot0._tabDict) do
		slot6 = slot4 == slot0._curSelectTab

		gohelper.setActive(slot5.goselected, slot6)
		gohelper.setActive(slot5.gounselected, not slot6)
	end
end

function slot0.clearVar(slot0)
	slot0._curSelectTab = nil

	slot0:clearTab()
end

function slot0.clearTab(slot0)
	if slot0._tabDict then
		for slot4, slot5 in pairs(slot0._tabDict) do
			slot5.btn:RemoveClickListener()
		end
	end

	slot0._tabDict = {}
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
end

function slot0.onDestroyView(slot0)
	slot0:clearVar()
end

return slot0
