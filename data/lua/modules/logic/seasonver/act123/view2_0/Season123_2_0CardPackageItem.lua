module("modules.logic.seasonver.act123.view2_0.Season123_2_0CardPackageItem", package.seeall)

slot0 = class("Season123_2_0CardPackageItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gopos = gohelper.findChild(slot0.viewGO, "go_itempos/go_pos")
	slot0._gocount = gohelper.findChild(slot0.viewGO, "go_itempos/go_count")
	slot0._txtcountvalue = gohelper.findChildText(slot0.viewGO, "go_itempos/go_count/bg/#txt_countvalue")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:checkCreateIcon()
	slot0.icon:updateData(slot0._mo.itemId)
	slot0.icon:setIndexLimitShowState(true)

	if slot0._mo.count > 0 then
		gohelper.setActive(slot0._gocount, true)

		slot0._txtcountvalue.text = luaLang("multiple") .. tostring(slot0._mo.count)
	else
		gohelper.setActive(slot0._gocount, false)
	end
end

function slot0.checkCreateIcon(slot0)
	if not slot0.icon then
		slot0.icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._view:getResInst(slot0._view.viewContainer:getSetting().otherRes[2], slot0._gopos, "icon"), Season123_2_0CelebrityCardEquip)

		slot0.icon:setClickCall(slot0.onClickSelf, slot0)
	end
end

function slot0.onClickSelf(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, slot0._mo.itemId)
end

function slot0.getAnimator(slot0)
	slot0._animator.enabled = true

	return slot0._animator
end

function slot0.onDestroyView(slot0)
	if slot0.icon then
		slot0.icon:disposeUI()
	end
end

return slot0
