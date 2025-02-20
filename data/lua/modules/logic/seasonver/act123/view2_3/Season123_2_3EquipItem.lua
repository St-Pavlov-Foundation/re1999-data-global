module("modules.logic.seasonver.act123.view2_3.Season123_2_3EquipItem", package.seeall)

slot0 = class("Season123_2_3EquipItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gopos = gohelper.findChild(slot0.viewGO, "go_pos")
	slot0._gorole = gohelper.findChild(slot0.viewGO, "go_role")
	slot0._simageroleicon = gohelper.findChildSingleImage(slot0.viewGO, "go_role/image_roleicon")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_select")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_new")
	slot0._gocount = gohelper.findChild(slot0.viewGO, "go_count")
	slot0._txtcountvalue = gohelper.findChildText(slot0.viewGO, "go_count/bg/#txt_countvalue")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._imageroleicon = gohelper.findChildImage(slot0.viewGO, "go_role/image_roleicon")
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._uid = slot1.id
	slot0._itemId = slot1.itemId

	slot0:refreshUI()
	slot0:checkPlayAnim()
end

slot0.ColumnCount = 6
slot0.AnimRowCount = 4
slot0.OpenAnimTime = 0.06
slot0.OpenAnimStartTime = 0.05

function slot0.checkPlayAnim(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)

	if Season123EquipItemListModel.instance:getDelayPlayTime(slot0._mo) == -1 then
		slot0._animator:Play("idle", 0, 0)

		slot0._animator.speed = 1
	else
		slot0._animator:Play("open", 0, 0)

		slot0._animator.speed = 0

		TaskDispatcher.runDelay(slot0.onDelayPlayOpen, slot0, slot1)
	end
end

function slot0.onDelayPlayOpen(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)
	slot0._animator:Play("open", 0, 0)

	slot0._animator.speed = 1
end

function slot0.refreshUI(slot0)
	slot1 = slot0._uid

	slot0:refreshIcon(slot0._itemId, slot1)

	slot3, slot4 = Season123EquipItemListModel.instance:getItemEquipedPos(slot1)

	gohelper.setActive(slot0._goselect, Season123EquipItemListModel.instance:isItemUidInShowSlot(slot1))
	gohelper.setActive(slot0._gonew, not Season123EquipItemListModel.isTrialEquip(slot1) and not Season123EquipItemListModel.instance.recordNew:contain(slot1))

	if slot3 == nil then
		gohelper.setActive(slot0._gorole, false)
	elseif Season123EquipItemListModel.instance:getPosHeroUid(slot3) ~= nil and slot5 ~= Season123EquipItemListModel.EmptyUid then
		slot0:refreshEquipedHero(slot5)
	else
		gohelper.setActive(slot0._gorole, false)
	end

	slot0:refreshDeckCount()
end

function slot0.refreshDeckCount(slot0)
	slot2, slot3 = Season123EquipItemListModel.instance:getNeedShowDeckCount(slot0._uid)

	gohelper.setActive(slot0._gocount, slot2)

	if slot2 then
		slot0._txtcountvalue.text = luaLang("multiple") .. tostring(slot3)
	end
end

function slot0.refreshEquipedHero(slot0, slot1)
	if Season123EquipItemListModel.instance.stage ~= nil then
		slot2 = HeroModel.instance:getById(slot1) or HeroGroupTrialModel.instance:getById(slot1) or Season123HeroUtils.getHeroMO(Season123EquipItemListModel.instance.activityId, slot1, Season123EquipItemListModel.instance.stage)
	end

	if not slot2 then
		return
	end

	gohelper.setActive(slot0._gorole, true)
	slot0._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(slot2.skin))
end

function slot0.refreshIcon(slot0, slot1, slot2)
	slot0:checkCreateIcon()

	if slot1 then
		slot0.icon:updateData(slot1)
		slot0.icon:setIndexLimitShowState(true)

		slot7 = Season123EquipItemListModel.instance:disableBecauseSameCard(slot2) or Season123EquipItemListModel.instance:disableBecauseCareerNotFit(slot1) or Season123EquipItemListModel.instance:disableBecauseRole(slot1) or Season123EquipItemListModel.instance:disableBecausePos(slot1)

		slot0.icon:setColorDark(slot7)
		slot0:setRoleIconDark(slot7)
	end
end

function slot0.checkCreateIcon(slot0)
	if not slot0.icon then
		slot0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view:getResInst(slot0._view.viewContainer:getSetting().otherRes[2], slot0._gopos, "icon"), Season123_2_3CelebrityCardEquip)

		slot0.icon:setClickCall(slot0.onClickSelf, slot0)
	end
end

function slot0.setRoleIconDark(slot0, slot1)
	if slot1 then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imageroleicon, "#7b7b7b")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imageroleicon, "#ffffff")
	end
end

function slot0.onClickSelf(slot0)
	slot1 = slot0._uid

	logNormal("onClickSelf : " .. tostring(slot1))
	slot0:checkClickNew(slot1)

	if slot0:checkCanNotEquipWithToast(slot1) then
		return
	end

	if Season123EquipItemListModel.instance.curEquipMap[Season123EquipItemListModel.instance.curSelectSlot] == slot1 then
		return
	end

	Season123EquipController.instance:equipItemOnlyShow(slot1)
end

function slot0.checkClickNew(slot0, slot1)
	if not Season123EquipItemListModel.instance.recordNew:contain(slot1) then
		Season123EquipItemListModel.instance.recordNew:add(slot1)
		gohelper.setActive(slot0._gonew, false)
	end
end

slot0.Toast_Same_Card = 2851
slot0.Toast_Wrong_Type = 2852
slot0.Toast_MainRole_Wrong_Type = 2854
slot0.Toast_Other_Hero_Equiped = 2853
slot0.Toast_Career_Wrong = 2859
slot0.Toast_Slot_Lock = 67
slot0.Toast_Pos_Wrong = 70501

function slot0.checkCanNotEquipWithToast(slot0, slot1)
	if Season123EquipItemListModel.instance:slotIsLock(Season123EquipItemListModel.instance.curSelectSlot) then
		GameFacade.showToast(uv0.Toast_Slot_Lock)

		return true
	end

	if Season123EquipItemListModel.instance:disableBecauseSameCard(slot1) then
		GameFacade.showToast(uv0.Toast_Same_Card)

		return true
	end

	if Season123EquipItemListModel.instance:getEquipMO(slot1) then
		if Season123EquipItemListModel.instance:disableBecauseRole(slot3.itemId) then
			if Season123EquipItemListModel.instance.curPos == Season123EquipItemListModel.MainCharPos then
				GameFacade.showToast(uv0.Toast_MainRole_Wrong_Type)
			else
				GameFacade.showToast(uv0.Toast_Wrong_Type)
			end

			return true
		end

		if Season123EquipItemListModel.instance:disableBecauseCareerNotFit(slot3.itemId) then
			GameFacade.showToast(uv0.Toast_Career_Wrong)

			return true
		end

		slot6, slot7 = Season123EquipItemListModel.instance:disableBecausePos(slot3.itemId)

		if slot6 then
			GameFacade.showToast(uv0.Toast_Pos_Wrong, slot7)

			return true
		end
	end

	return false
end

function slot0.onDestroyView(slot0)
	if slot0.icon then
		slot0.icon:removeEventListeners()
		slot0.icon:disposeUI()
	end
end

return slot0
