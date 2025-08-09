module("modules.logic.settings.view.SettingsRoleVoiceListItem", package.seeall)

local var_0_0 = class("SettingsRoleVoiceListItem", ListScrollCell)

var_0_0.PressColor = GameUtil.parseColor("#C8C8C8")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGO = arg_1_1
	arg_1_0._heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._heroGO, CommonHeroItem)

	arg_1_0._heroItem:hideFavor(true)
	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)
	arg_1_0:_initObj()
end

function var_0_0._initObj(arg_2_0)
	arg_2_0._animator = arg_2_0._heroGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_2_0._selectframe, false)
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0._heroItem:onUpdateMO(arg_5_1)
	arg_5_0._heroItem:setNewShow(false)
	arg_5_0._heroItem:setRankObjActive(false)
	arg_5_0._heroItem:setLevelContentShow(false)
	arg_5_0._heroItem:setExSkillActive(false)

	local var_5_0 = arg_5_1.heroId
	local var_5_1, var_5_2 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_5_0)
	local var_5_3 = luaLang(LangSettings.shortcutTab[var_5_1])

	arg_5_0._heroItem:setCenterTxt(var_5_3)
	arg_5_0._heroItem:setStyle_CharacterBackpack()
end

function var_0_0._onrefreshItem(arg_6_0)
	return
end

function var_0_0._onItemClick(arg_7_0)
	local var_7_0 = not arg_7_0._isSelect

	arg_7_0._view:selectCell(arg_7_0._index, var_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	SettingsRoleVoiceController.instance:dispatchEvent(SettingsEvent.OnSetVoiceRoleSelected, arg_7_0._mo, var_7_0)
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	if arg_8_0._view.viewContainer:isBatchEditMode() then
		arg_8_0._isSelect = arg_8_1

		arg_8_0._heroItem:setSelect(arg_8_1)
	else
		arg_8_0._isSelect = arg_8_1

		arg_8_0._heroItem:setSelect(arg_8_1)
	end
end

function var_0_0.onDestroy(arg_9_0)
	if arg_9_0._heroItem then
		arg_9_0._heroItem:onDestroy()

		arg_9_0._heroItem = nil
	end
end

function var_0_0.getAnimator(arg_10_0)
	return arg_10_0._animator
end

return var_0_0
