module("modules.logic.settings.view.SettingsView", package.seeall)

slot0 = class("SettingsView", BaseView)

function slot0.onInitView(slot0)
	slot0._gosettingscontent = gohelper.findChild(slot0.viewGO, "#go_settingscontent")
	slot0._scrollcategory = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_category")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/bgimg")

	slot0._simagebg:LoadImage(ResUrl.getSettingsBg("full/shezhi_bj.jpg"))
end

function slot0.onUpdateParam(slot0)
	slot0:_selectCategory(SettingsModel.instance:getSettingsCategoryList()[1].id)
end

function slot0._selectCategory(slot0, slot1)
	SettingsModel.instance:setCurCategoryId(slot1)
	SettingsModel.instance:setSettingsCategoryList(slot0.viewParam.cateList)
	SettingsCategoryListModel.instance:setCategoryList(SettingsModel.instance:getSettingsCategoryList())
	slot0:_refreshView()
end

function slot0.onOpen(slot0)
	slot0:_selectCategory(SettingsModel.instance:getSettingsCategoryList()[1].id)
	slot0:addEventCb(SettingsController.instance, SettingsEvent.SelectCategory, slot0._selectCategory, slot0)
	slot0:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, slot0._refreshLangTxt, slot0)
end

function slot0._refreshView(slot0)
	slot0.viewContainer:switchTab(SettingsModel.instance:getCurCategoryId())
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SettingsController.instance, SettingsEvent.SelectCategory, slot0._selectCategory, slot0)
	slot0:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, slot0._refreshLangTxt, slot0)
	SettingsController.instance:dispatchEvent(SettingsEvent.PlayCloseCategoryAnim)
end

function slot0._refreshLangTxt(slot0)
	slot6 = SLFramework.LangTxt

	for slot6 = 0, slot0.viewGO:GetComponentsInChildren(typeof(slot6), true).Length - 1 do
		SLFramework.LanguageMgr.Instance:ApplyLangTxt(slot1[slot6])
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
