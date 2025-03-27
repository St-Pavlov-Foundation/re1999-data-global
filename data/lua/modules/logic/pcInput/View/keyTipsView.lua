module("modules.logic.pcInput.View.keyTipsView", package.seeall)

slot0 = class("keyTipsView", LuaCompBase)
slot1 = "ui/viewres/pc/pcbuttonitem.prefab"

function slot0.ctor(slot0, slot1)
	slot0._keyName = slot1.keyname
	slot0._activityid = slot1.activityId
	slot0._keyid = slot1.keyid
end

function slot0.init(slot0, slot1)
	slot0._go = slot1

	slot0:load()
end

function slot0.load(slot0)
	slot0._loader = PrefabInstantiate.Create(slot0._go)

	slot0._loader:startLoad(uv0, uv1._onCallback, slot0)
end

function slot0._onCallback(slot0)
	slot0._instGO = slot0._loader:getInstGO()

	if PlayerPrefsHelper.getNumber("keyTips", 0) == 0 then
		slot0._instGO:SetActive(false)

		return
	else
		slot0._instGO:SetActive(true)
	end

	gohelper.setActive(slot0._instGO, not ViewMgr.instance:isOpen(ViewName.GuideView))

	slot0._text1 = gohelper.findChildText(slot0._instGO, "btn_1/#txt_btn")
	slot0._text2 = gohelper.findChildText(slot0._instGO, "btn_2/#txt_btn")
	slot0._btn1 = gohelper.findChild(slot0._instGO, "btn_1")
	slot0._btn2 = gohelper.findChild(slot0._instGO, "btn_2")

	if slot0:selectType(slot0._keyName or PCInputModel.instance:getKey(slot0._activityid, slot0._keyid)) == 1 then
		slot0._btn1:SetActive(true)
		slot0._btn2:SetActive(false)

		slot0._text1.text = PCInputController.instance:KeyNameToDescName(slot2)
	else
		slot0._btn1:SetActive(false)
		slot0._btn2:SetActive(true)

		slot0._text2.text = PCInputController.instance:KeyNameToDescName(slot2)
	end
end

function slot0.Show(slot0, slot1)
	if slot0._instGO then
		slot0._instGO:SetActive(slot1 and not ViewMgr.instance:isOpen(ViewName.GuideView) and PlayerPrefsHelper.getNumber("keyTips", 0) == 1)
	end
end

function slot0.selectType(slot0, slot1)
	if string.len(slot1) > 1 then
		return 2
	else
		return 1
	end
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0._activityid = slot1
	slot0._keyid = slot2
	slot0._keyName = nil

	if slot0._instGO then
		slot0:_onCallback()
	end
end

function slot0.RefreshByKeyName(slot0, slot1)
	slot0._keyName = slot1
	slot0._activityid = nil
	slot0._keyid = nil

	if slot0._instGO then
		slot0:_onCallback()
	end
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, slot0._onCallback, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenViewCallBack, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseViewCallBack, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, slot0._onCallback, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenViewCallBack, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseViewCallBack, slot0)
end

function slot0.onOpenViewCallBack(slot0, slot1)
	if slot1 == ViewName.GuideView then
		slot0._instGO:SetActive(false)
	end
end

function slot0.onCloseViewCallBack(slot0, slot1)
	if slot1 == ViewName.GuideView then
		slot0._instGO:SetActive(true)
	end
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
end

return slot0
