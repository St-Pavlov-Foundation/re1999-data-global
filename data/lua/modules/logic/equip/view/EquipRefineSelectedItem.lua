module("modules.logic.equip.view.EquipRefineSelectedItem", package.seeall)

slot0 = class("EquipRefineSelectedItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_cost_empty")
	slot0._goequip = gohelper.findChild(slot0.viewGO, "#go_cost_equip")
	slot0._btnclick = gohelper.findChildButton(slot0.viewGO, "#btn_add_click")
	slot0._goClickEffect = gohelper.findChild(slot0.viewGO, "#click_effect")
	slot0._effectImage = gohelper.findChildImage(slot0.viewGO, "#click_effect/images")
	slot0._addEffectAnim = slot0._goClickEffect:GetComponent(typeof(UnityEngine.Animation))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._isEmpty then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, true)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		EquipRefineListModel.instance:deselectEquip(slot0._mo)
		EquipRefineListModel.instance:refreshData()
	end
end

function slot0._editableInitView(slot0)
	slot0._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(slot0._goequip, 1)

	slot0._commonEquipIcon:_overrideLoadIconFunc(EquipHelper.getEquipIconLoadPath, slot0._commonEquipIcon)
	gohelper.setActive(slot0._goequip, false)

	slot0._isEmpty = true

	slot0:initAddEquipEffect()
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:_stopAddEquipEffect()

	slot0._mo = slot1
	slot0._isEmpty = true

	if slot0._mo.config then
		slot0._isEmpty = false

		slot0._commonEquipIcon:setEquipMO(slot0._mo)
	end

	gohelper.setActive(slot0._goClickEffect, not slot0._isEmpty)
	gohelper.setActive(slot0._goequip, not slot0._isEmpty)
	gohelper.setActive(slot0._goempty, slot0._isEmpty)
end

function slot0.initAddEquipEffect(slot0)
	slot0._effectImage.material = UnityEngine.Object.Instantiate(slot0._effectImage.material)
	slot2 = slot0._goClickEffect:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	slot2.mas:Clear()
	slot2.mas:Add(slot0._effectImage.material)
	slot0._addEffectAnim:Stop()
end

function slot0._playAddEquipEffect(slot0, slot1)
	if slot0._mo.uid == slot1 then
		slot0._addEffectAnim.enabled = true

		gohelper.setActive(slot0._effectImage.gameObject, true)
		slot0._addEffectAnim:Stop()
		slot0._addEffectAnim:Play()
	end
end

function slot0.dispose(slot0)
end

function slot0._stopAddEquipEffect(slot0)
	slot0._addEffectAnim:Rewind()

	slot0._addEffectAnim.enabled = false

	gohelper.setActive(slot0._effectImage.gameObject, false)
end

function slot0.onDestroyView(slot0)
end

return slot0
