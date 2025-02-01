module("modules.logic.seasonver.act123.view2_1.Season123_2_1DecomposeItem", package.seeall)

slot0 = class("Season123_2_1DecomposeItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gopos = gohelper.findChild(slot0.viewGO, "go_pos")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_select")
	slot0._simageroleicon = gohelper.findChildSingleImage(slot0.viewGO, "image_roleicon")
	slot0._gorolebg = gohelper.findChild(slot0.viewGO, "bg")
	slot0._imageroleicon = gohelper.findChildImage(slot0.viewGO, "image_roleicon")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goDecomposeEffect = gohelper.findChild(slot0.viewGO, "vx_compose")
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnRefleshDecomposeItemUI, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnBatchDecomposeEffectPlay, slot0.showDecomposeEffect, slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.CloseBatchDecomposeEffect, slot0.hideDecomposeEffect, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnRefleshDecomposeItemUI, slot0.refreshUI, slot0)
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, slot0.refreshUI, slot0)
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnBatchDecomposeEffectPlay, slot0.showDecomposeEffect, slot0)
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.CloseBatchDecomposeEffect, slot0.hideDecomposeEffect, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._cfg = Season123Config.instance:getSeasonEquipCo(slot0._mo.itemId)

	if slot0._cfg then
		slot0:refreshUI()
	end

	slot0:checkPlayAnim()
end

slot0.AnimRowCount = 4
slot0.OpenAnimTime = 0.06
slot0.OpenAnimStartTime = 0.05

function slot0.refreshUI(slot0)
	slot0:checkCreateIcon()
	slot0.icon:updateData(slot0._mo.itemId)
	slot0.icon:setIndexLimitShowState(true)
	gohelper.setActive(slot0._goselect, Season123DecomposeModel.instance:isSelectedItem(slot0._mo.uid))
	slot0:refreshEquipedHero(Season123DecomposeModel.instance:getItemUidToHeroUid(slot0._mo.uid))
end

function slot0.refreshEquipedHero(slot0, slot1)
	if not slot1 or slot1 == Activity123Enum.EmptyUid then
		gohelper.setActive(slot0._simageroleicon, false)
		gohelper.setActive(slot0._gorolebg, false)

		return
	end

	slot2 = nil

	if slot1 == Activity123Enum.MainRoleHeroUid then
		slot2 = Activity123Enum.MainRoleHeadIconID
	else
		if not HeroModel.instance:getById(slot1) then
			gohelper.setActive(slot0._simageroleicon, false)
			gohelper.setActive(slot0._gorolebg, false)

			return
		end

		slot2 = slot3.skin
	end

	gohelper.setActive(slot0._simageroleicon, true)
	gohelper.setActive(slot0._gorolebg, true)
	slot0._simageroleicon:LoadImage(ResUrl.getHeadIconSmall(slot2))
end

function slot0.checkPlayAnim(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)
	Season123DecomposeModel.instance:setItemCellCount(slot0._view.viewContainer:getLineCount())

	if Season123DecomposeModel.instance:getDelayPlayTime(slot0._mo) == -1 then
		slot0._animator:Play("idle", 0, 0)

		slot0._animator.speed = 1
	else
		slot0._animator:Play("open", 0, 0)

		slot0._animator.speed = 0

		TaskDispatcher.runDelay(slot0.onDelayPlayOpen, slot0, slot2)
	end
end

function slot0.onDelayPlayOpen(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)
	slot0._animator:Play("open", 0, 0)

	slot0._animator.speed = 1
end

function slot0.checkCreateIcon(slot0)
	if not slot0.icon then
		slot0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view:getResInst(slot0._view.viewContainer:getSetting().otherRes[2], slot0._gopos, "icon"), Season123_2_1CelebrityCardEquip)

		slot0.icon:setClickCall(slot0.onClickSelf, slot0)
	end
end

function slot0.onClickSelf(slot0)
	if not Season123DecomposeModel.instance.curSelectItemDict[slot0._mo.uid] and Season123DecomposeModel.instance:isSelectItemMaxCount() then
		GameFacade.showToast(ToastEnum.OverMaxCount)

		return
	end

	Season123DecomposeModel.instance:setCurSelectItemUid(slot0._mo.uid)
	slot0:refreshUI()
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnDecomposeItemSelect)
end

function slot0.showDecomposeEffect(slot0)
	if Season123DecomposeModel.instance.curSelectItemDict[slot0._mo.uid] then
		gohelper.setActive(slot0._goDecomposeEffect, false)
		gohelper.setActive(slot0._goDecomposeEffect, true)
	else
		slot0:hideDecomposeEffect()
	end
end

function slot0.hideDecomposeEffect(slot0)
	gohelper.setActive(slot0._goDecomposeEffect, false)
end

function slot0.onDestroyView(slot0)
	if slot0.icon then
		slot0.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)
end

return slot0
