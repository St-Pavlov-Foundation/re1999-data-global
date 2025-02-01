module("modules.logic.bgmswitch.view.BGMSwitchMusicFilterItem", package.seeall)

slot0 = class("BGMSwitchMusicFilterItem")

function slot0.init(slot0, slot1)
	slot0.go = slot1

	gohelper.setActive(slot0.go, true)

	slot0._gounselected = gohelper.findChild(slot1, "unselected")
	slot0._txtunselected = gohelper.findChildText(slot1, "unselected/info")
	slot0._goselected = gohelper.findChild(slot1, "selected")
	slot0._txtselected = gohelper.findChildText(slot1, "selected/info")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot1, "click")

	slot0:addEvents()
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	BGMSwitchModel.instance:setFilterType(slot0._typeCo.id, not BGMSwitchModel.instance:getFilterTypeSelectState(slot0._typeCo.id))
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.FilterClassSelect)
	slot0:_refreshItem()
end

function slot0.setItem(slot0, slot1)
	slot0._typeCo = slot1

	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	slot1 = BGMSwitchModel.instance:getFilterTypeSelectState(slot0._typeCo.id)

	gohelper.setActive(slot0._goselected, slot1)
	gohelper.setActive(slot0._gounselected, not slot1)

	slot0._txtselected.text = slot0._typeCo.typename
	slot0._txtunselected.text = slot0._typeCo.typename
end

function slot0.destroy(slot0)
	slot0:removeEvents()
end

return slot0
