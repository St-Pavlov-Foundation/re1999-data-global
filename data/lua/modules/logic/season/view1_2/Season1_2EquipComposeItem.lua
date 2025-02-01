module("modules.logic.season.view1_2.Season1_2EquipComposeItem", package.seeall)

slot0 = class("Season1_2EquipComposeItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gopos = gohelper.findChild(slot0.viewGO, "go_pos")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_select")
	slot0._simageroleicon = gohelper.findChildSingleImage(slot0.viewGO, "image_roleicon")
	slot0._gorolebg = gohelper.findChild(slot0.viewGO, "bg")
	slot0._imageroleicon = gohelper.findChildImage(slot0.viewGO, "image_roleicon")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1.originMO
	slot0._listMO = slot1
	slot0._cfg = SeasonConfig.instance:getSeasonEquipCo(slot0._mo.itemId)

	if slot0._cfg then
		slot0:refreshUI()
	end

	slot0:checkPlayAnim()
end

function slot0.refreshUI(slot0)
	slot0:checkCreateIcon()
	slot0.icon:updateData(slot0._cfg.equipId)

	slot2 = Activity104EquipItemComposeModel.instance:getSelectedRare() ~= nil and slot1 ~= slot0._cfg.rare

	slot0.icon:setColorDark(slot2)
	slot0:setRoleIconDark(slot2)
	gohelper.setActive(slot0._goselect, Activity104EquipItemComposeModel.instance:isEquipSelected(slot0._mo.uid))
	slot0:refreshEquipedHero(Activity104EquipItemComposeModel.instance:getEquipedHeroUid(slot0._mo.uid))
end

function slot0.setRoleIconDark(slot0, slot1)
	if slot1 then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imageroleicon, "#7b7b7b")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imageroleicon, "#ffffff")
	end
end

function slot0.refreshEquipedHero(slot0, slot1)
	if not slot1 or slot1 == Activity104EquipItemComposeModel.EmptyUid then
		gohelper.setActive(slot0._simageroleicon, false)
		gohelper.setActive(slot0._gorolebg, false)

		return
	end

	slot2 = nil

	if slot1 == Activity104EquipItemComposeModel.MainRoleHeroUid then
		slot2 = Activity104Enum.MainRoleHeadIconID
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

slot0.ColumnCount = 6
slot0.AnimRowCount = 4
slot0.OpenAnimTime = 0.06
slot0.OpenAnimStartTime = 0.05

function slot0.checkPlayAnim(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)

	if Activity104EquipItemComposeModel.instance:getDelayPlayTime(slot0._listMO) == -1 then
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

function slot0.checkCreateIcon(slot0)
	if not slot0.icon then
		slot0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view:getResInst(slot0._view.viewContainer:getSetting().otherRes[2], slot0._gopos, "icon"), Season1_2CelebrityCardEquip)

		slot0.icon:setClickCall(slot0.onClickSelf, slot0)
		slot0.icon:setLongPressCall(slot0.onLongPress, slot0)
	end
end

function slot0.onClickSelf(slot0)
	if slot0._mo then
		Activity104EquipComposeController.instance:changeSelectCard(slot0._mo.uid)
	end
end

function slot0.onLongPress(slot0)
	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.EquipCard, slot0._cfg.equipId, {
		actId = slot0._view.viewParam.actId
	})
end

function slot0.onDestroyView(slot0)
	if slot0.icon then
		slot0.icon:disposeUI()
	end

	TaskDispatcher.cancelTask(slot0.onDelayPlayOpen, slot0)
end

return slot0
