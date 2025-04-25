module("modules.logic.weather.controller.WeatherSwitchControlComp", package.seeall)

slot0 = class("WeatherSwitchControlComp", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._btnup = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_up")
	slot0._goexpand = gohelper.findChild(slot0.viewGO, "#go_expand")
	slot0._gonumitem = gohelper.findChild(slot0.viewGO, "#go_expand/go_numitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_expand/#btn_close")
	slot0._btnmiddle = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_middle")
	slot0._middleicon = gohelper.findChildImage(slot0.viewGO, "#btn_middle/icon")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#btn_middle/icon/#txt_num")
	slot0._btndown = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_down")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnup:AddClickListener(slot0._btnupOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnmiddle:AddClickListener(slot0._btnmiddleOnClick, slot0)
	slot0._btndown:AddClickListener(slot0._btndownOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnup:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnmiddle:RemoveClickListener()
	slot0._btndown:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	gohelper.setActive(slot0._goexpand, false)
end

function slot0._btnupOnClick(slot0)
	slot0._switchComp:switchPrevLightMode()
	slot0:_updateBtnStatus()
	slot0:_startDelayUpdateStatus()
end

function slot0._btnmiddleOnClick(slot0)
	slot0._showExpand = true

	gohelper.setActive(slot0._goexpand, true)

	for slot5, slot6 in ipairs(slot0._switchComp:getReportList()) do
		if not slot0._itemList[slot5] then
			slot0:_onItemShow(gohelper.cloneInPlace(slot0._gonumitem, slot5), slot6, slot5)
		else
			gohelper.setActive(slot0._itemList[slot5] and slot7.go, true)
		end
	end

	for slot5 = #slot1 + 1, #slot0._itemList do
		gohelper.setActive(slot0._itemList[slot5] and slot6.go, false)
	end

	slot0:_updateItemSelectStatus()
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "#txt_num").text = slot3
	slot5 = gohelper.findChild(slot1, "select")
	slot6 = gohelper.findChildButtonWithAudio(slot1, "#btn_click")

	slot6:AddClickListener(slot0._btnclickOnClick, slot0, slot3)

	slot0._itemList[slot3] = {
		go = slot1,
		selectGo = slot5,
		btn = slot6
	}

	gohelper.setActive(slot1, true)
	gohelper.setActive(slot5, false)
	gohelper.setSiblingAfter(slot1, slot0._gonumitem)
end

function slot0._btnclickOnClick(slot0, slot1)
	gohelper.setActive(slot0._goexpand, false)

	if slot0._switchComp:getReportIndex() == slot1 then
		return
	end

	slot0._switchComp:switchReport(slot1)
end

function slot0._btndownOnClick(slot0)
	slot0._switchComp:switchNextLightMode()
	slot0:_updateBtnStatus()
	slot0:_startDelayUpdateStatus()
end

function slot0._updateBtnStatus(slot0)
	if not slot0._switchComp then
		return
	end

	slot0._txtnum.text = slot0._switchComp:getReportIndex()
	slot0._btnup.button.interactable = slot0._switchComp:getLightMode() ~= 1
	slot0._btndown.button.interactable = slot1 ~= 4

	UISpriteSetMgr.instance:setStoreGoodsSprite(slot0._middleicon, slot0._iconMap[slot1])
	slot0:_updateItemSelectStatus()
end

function slot0._updateItemSelectStatus(slot0)
	for slot5, slot6 in ipairs(slot0._itemList) do
		gohelper.setActive(slot6.selectGo, slot5 == slot0._switchComp:getReportIndex())
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goexpand, false)
	gohelper.setActive(slot0._gonumitem, false)
	gohelper.setActive(slot0._btnclose, false)

	slot0._itemList = slot0:getUserDataTb_()
	slot0._iconMap = {
		[WeatherEnum.LightModeDuring] = "store_weathericon_01",
		[WeatherEnum.LightModeOvercast] = "store_weathericon_03",
		[WeatherEnum.LightModeDusk] = "store_weathericon_02",
		[WeatherEnum.LightModeNight] = "store_weathericon_04"
	}
	slot0._cdTime = CommonConfig.instance:getConstNum(ConstEnum.MainSceneChangeCD) / 1000

	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, slot0._onTouch, slot0)
end

function slot0._startDelayUpdateStatus(slot0)
	slot0._btnup.button.interactable = false
	slot0._btndown.button.interactable = false

	TaskDispatcher.cancelTask(slot0._delayUpdateStatus, slot0)
	TaskDispatcher.runDelay(slot0._delayUpdateStatus, slot0, slot0._cdTime)
end

function slot0._delayUpdateStatus(slot0)
	slot0:_updateBtnStatus()
end

function slot0._onTouch(slot0)
	if slot0._showExpand then
		slot0._showExpand = false

		return
	end

	gohelper.setActive(slot0._goexpand, false)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.updateScene(slot0, slot1, slot2)
	if slot0._switchComp then
		slot0._switchComp:removeReportChangeCallback()

		slot0._switchComp = nil
	end

	slot0._switchComp = slot2:getSwitchComp(slot1)

	gohelper.setActive(slot0.viewGO, slot0._switchComp ~= nil)

	if not slot0._switchComp then
		return
	end

	slot0._switchComp:addReportChangeCallback(slot0._updateBtnStatus, slot0)
	slot0:_updateBtnStatus()
end

function slot0.onDestroyView(slot0)
	slot0._switchComp = nil

	for slot4, slot5 in ipairs(slot0._itemList) do
		slot5.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(slot0._delayUpdateStatus, slot0)
end

return slot0
