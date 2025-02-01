module("modules.logic.equip.view.EquipSelectedItem", package.seeall)

slot0 = class("EquipSelectedItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._goequip = gohelper.findChild(slot0.viewGO, "#go_equip")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goClickEffect = gohelper.findChild(slot0.viewGO, "#click_effect")
	slot0._goEffectImage = gohelper.findChild(slot0.viewGO, "#click_effect/images")
	slot0._addEffectAnim = slot0._goClickEffect:GetComponent(typeof(UnityEngine.Animation))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onAddEquipToPlayEffect, slot0._playAddEquipEffect, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._isEmpty then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeStrengthenScrollState, true)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		EquipChooseListModel.instance:deselectEquip(slot0._mo)
		EquipController.instance:dispatchEvent(EquipEvent.onChooseEquip)
	end
end

function slot0._editableInitView(slot0)
	slot0._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(slot0._goequip, 1)

	slot0._commonEquipIcon:_overrideLoadIconFunc(EquipHelper.getEquipIconLoadPath, slot0._commonEquipIcon)
	gohelper.setActive(slot0._goequip, false)
	gohelper.removeUIClickAudio(slot0._btnclick.gameObject)

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

		slot0._commonEquipIcon._txtnum.text = string.format("%s/%s", slot0._mo._chooseNum, GameUtil.numberDisplay(slot0._mo.count))
	end

	gohelper.setActive(slot0._goClickEffect, not slot0._isEmpty)
	gohelper.setActive(slot0._goequip, not slot0._isEmpty)
	gohelper.setActive(slot0._goempty, slot0._isEmpty)
end

function slot0.initAddEquipEffect(slot0)
	slot1 = gohelper.findChildImage(slot0._goClickEffect, "images")
	slot1.material = UnityEngine.Object.Instantiate(slot1.material)
	slot3 = slot0._goClickEffect:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	slot3.mas:Clear()
	slot3.mas:Add(slot1.material)
	slot0._addEffectAnim:Stop()
end

function slot0._playAddEquipEffect(slot0, slot1)
	if tabletool.indexOf(slot1, slot0._mo.uid) then
		slot0._addEffectAnim.enabled = true

		gohelper.setActive(slot0._goEffectImage, true)
		slot0._addEffectAnim:Stop()
		slot0._addEffectAnim:Play()
	end
end

function slot0.dispose(slot0)
end

function slot0._stopAddEquipEffect(slot0)
	slot0._addEffectAnim:Rewind()

	slot0._addEffectAnim.enabled = false

	gohelper.setActive(slot0._goEffectImage, false)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
