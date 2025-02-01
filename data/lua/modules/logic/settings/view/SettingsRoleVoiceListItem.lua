module("modules.logic.settings.view.SettingsRoleVoiceListItem", package.seeall)

slot0 = class("SettingsRoleVoiceListItem", ListScrollCell)
slot0.PressColor = GameUtil.parseColor("#C8C8C8")

function slot0.init(slot0, slot1)
	slot0._heroGO = slot1
	slot0._heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._heroGO, CommonHeroItem)

	slot0._heroItem:hideFavor(true)
	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)
	slot0:_initObj()
end

function slot0._initObj(slot0)
	slot0._animator = slot0._heroGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._selectframe, false)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)
	slot0._heroItem:setNewShow(false)
	slot0._heroItem:setRankObjActive(false)
	slot0._heroItem:setLevelContentShow(false)
	slot0._heroItem:setExSkillActive(false)

	slot3, slot4 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot1.heroId)

	slot0._heroItem:setCenterTxt(luaLang(LangSettings.shortcutTab[slot3]))
end

function slot0._onrefreshItem(slot0)
end

function slot0._onItemClick(slot0)
	slot1 = not slot0._isSelect

	slot0._view:selectCell(slot0._index, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	SettingsRoleVoiceController.instance:dispatchEvent(SettingsEvent.OnSetVoiceRoleSelected, slot0._mo, slot1)
end

function slot0.onSelect(slot0, slot1)
	if slot0._view.viewContainer:isBatchEditMode() then
		slot0._isSelect = slot1

		slot0._heroItem:setSelect(slot1)
	else
		slot0._isSelect = slot1

		slot0._heroItem:setSelect(slot1)
	end
end

function slot0.onDestroy(slot0)
	if slot0._heroItem then
		slot0._heroItem:onDestroy()

		slot0._heroItem = nil
	end
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
