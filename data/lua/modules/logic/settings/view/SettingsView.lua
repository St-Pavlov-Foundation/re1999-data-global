module("modules.logic.settings.view.SettingsView", package.seeall)

local var_0_0 = class("SettingsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosettingscontent = gohelper.findChild(arg_1_0.viewGO, "#go_settingscontent")
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_category")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg = gohelper.findChildSingleImage(arg_4_0.viewGO, "bg/bgimg")

	arg_4_0._simagebg:LoadImage(ResUrl.getSettingsBg("full/shezhi_bj.jpg"))
end

function var_0_0.onUpdateParam(arg_5_0)
	local var_5_0 = SettingsModel.instance:getSettingsCategoryList()

	arg_5_0:_selectCategory(var_5_0[1].id)
end

function var_0_0._selectCategory(arg_6_0, arg_6_1)
	SettingsModel.instance:setCurCategoryId(arg_6_1)
	SettingsModel.instance:setSettingsCategoryList(arg_6_0.viewParam.cateList)

	local var_6_0 = SettingsModel.instance:getSettingsCategoryList()

	SettingsCategoryListModel.instance:setCategoryList(var_6_0)
	arg_6_0:_refreshView()
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = SettingsModel.instance:getSettingsCategoryList()

	arg_7_0:_selectCategory(var_7_0[1].id)
	arg_7_0:addEventCb(SettingsController.instance, SettingsEvent.SelectCategory, arg_7_0._selectCategory, arg_7_0)
	arg_7_0:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_7_0._refreshLangTxt, arg_7_0)
end

function var_0_0._refreshView(arg_8_0)
	local var_8_0 = SettingsModel.instance:getCurCategoryId()

	arg_8_0.viewContainer:switchTab(var_8_0)
end

function var_0_0.onClose(arg_9_0)
	arg_9_0:removeEventCb(SettingsController.instance, SettingsEvent.SelectCategory, arg_9_0._selectCategory, arg_9_0)
	arg_9_0:removeEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_9_0._refreshLangTxt, arg_9_0)
	SettingsController.instance:dispatchEvent(SettingsEvent.PlayCloseCategoryAnim)
end

function var_0_0._refreshLangTxt(arg_10_0)
	local var_10_0 = arg_10_0.viewGO:GetComponentsInChildren(typeof(SLFramework.LangTxt), true)
	local var_10_1 = var_10_0.Length

	for iter_10_0 = 0, var_10_1 - 1 do
		SLFramework.LanguageMgr.Instance:ApplyLangTxt(var_10_0[iter_10_0])
	end
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
end

return var_0_0
