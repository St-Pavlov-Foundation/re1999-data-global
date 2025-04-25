module("modules.logic.main.view.MainSwitchView", package.seeall)

slot0 = class("MainSwitchView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._scrollcategory = gohelper.findChildScrollRect(slot0.viewGO, "Tab/#scroll_category")
	slot0._gocategoryitem1 = gohelper.findChild(slot0.viewGO, "Tab/#scroll_category/categorycontent/#go_categoryitem1")
	slot0._gocategoryitem2 = gohelper.findChild(slot0.viewGO, "Tab/#scroll_category/categorycontent/#go_categoryitem2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._gotab = gohelper.findChild(slot0.viewGO, "Tab")
	slot0._goswitchloading = gohelper.findChild(slot0.viewGO, "loadingmainview")
	slot0._switchAniamtor = slot0._goswitchloading:GetComponent("Animator")
	slot0._rootAnimator = slot0.viewGO:GetComponent("Animator")
	slot0._tabCanvasGroup = slot0._gotab:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._btnsCanvasGroup = slot0._gobtns:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	MainSwitchCategoryListModel.instance:initCategoryList()

	slot0._itemList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs(MainSwitchCategoryListModel.instance:getList()) do
		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0["_gocategoryitem" .. slot5], MainSwitchCategoryItem)

		slot8:onUpdateMO(slot6)

		slot0._itemList[slot5] = slot8
	end

	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchCategoryClick, slot0._itemClick, slot0)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, slot0._onSceneSwitchUIVisible, slot0)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.BeforeStartSwitchScene, slot0._onStartSwitchScene, slot0)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.CloseSwitchSceneLoading, slot0._onCloseSwitchSceneLoading, slot0)
end

function slot0._onStartSwitchScene(slot0)
	gohelper.setActive(slot0._goswitchloading, true)
	slot0._switchAniamtor:Play("open", 0, 0)
end

function slot0._onCloseSwitchSceneLoading(slot0)
	slot0._switchAniamtor:Play("close", 0, 0)
end

function slot0._onSceneSwitchUIVisible(slot0, slot1)
	slot0._tabCanvasGroup.blocksRaycasts = slot1
	slot0._btnsCanvasGroup.blocksRaycasts = slot1

	slot0._rootAnimator:Play(slot1 and "open" or "close", 0, 0)
end

function slot0._itemClick(slot0, slot1)
	slot0.viewContainer:switchTab(slot1)

	for slot5, slot6 in pairs(slot0._itemList) do
		slot6:refreshStatus()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
