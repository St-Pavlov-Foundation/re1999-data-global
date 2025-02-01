module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverResultView", package.seeall)

slot0 = class("V1a6_CachotRoleRecoverResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotipswindow = gohelper.findChild(slot0.viewGO, "#go_tipswindow")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goteamprepareitem = gohelper.findChild(slot0.viewGO, "#go_teamprepareitem")

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

function slot0._editableInitView(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_easter_success)
end

function slot0.onUpdateParam(slot0)
end

function slot0._initPresetItem(slot0)
	slot0._item = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goteamprepareitem), V1a6_CachotRoleRecoverPresetItem)
end

function slot0._initPrepareItem(slot0)
	slot0._item = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._goteamprepareitem), V1a6_CachotRoleRecoverPrepareItem)
end

function slot0.onOpen(slot0)
	slot0._mo = slot0.viewParam[1]

	if V1a6_CachotTeamModel.instance:getSeatInfo(slot0._mo) then
		slot0:_initPresetItem()
	else
		slot0:_initPrepareItem()
	end

	slot0._item:onUpdateMO(slot0._mo)
	slot0:_tweenHp()
end

function slot0._tweenHp(slot0)
	if not V1a6_CachotModel.instance:getChangeLifes() then
		return
	end

	if not slot0._item:getHeroMo() then
		return
	end

	for slot7, slot8 in ipairs(slot1) do
		if slot2.heroId == slot8.heroId then
			slot0._item:tweenHp(slot8.life, V1a6_CachotModel.instance:getTeamInfo():getHeroHp(slot8.heroId).life, 0.3)

			break
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
