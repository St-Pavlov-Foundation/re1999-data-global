module("modules.logic.effect.view.EffectStatItem", package.seeall)

slot0 = class("EffectStatItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._txtName = gohelper.findChildText(slot1, "title/txtName")
	slot0._txtSystem = gohelper.findChildText(slot1, "title/txtSystem")
	slot0._txtParticle = gohelper.findChildText(slot1, "title/txtParticle")
	slot0._txtMaterial = gohelper.findChildText(slot1, "title/txtMaterial")
	slot0._txtTexture = gohelper.findChildText(slot1, "title/txtTexture")
	slot0._clickName = SLFramework.UGUI.UIClickListener.Get(slot0._txtName.gameObject)
	slot0._btnClear = gohelper.findChildButtonWithAudio(slot1, "title/btnClear")
	slot0._slider = gohelper.findChildSlider(slot1, "title/slider")
	slot0._imgViewBg = slot1.transform.parent.parent.parent.parent:GetComponent(gohelper.Type_Image)

	slot0._slider:SetValue(slot0._imgViewBg.color.a)
end

function slot0.addEventListeners(slot0)
	slot0._clickName:AddClickListener(slot0._onClickName, slot0)
	slot0._btnClear:AddClickListener(slot0._onClickClear, slot0)
	slot0._slider:AddOnValueChanged(slot0._onValueChanged, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._clickName:RemoveClickListener()
	slot0._btnClear:RemoveClickListener()
	slot0._slider:RemoveOnValueChanged()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtName.text = slot1.name
	slot0._txtSystem.text = slot1.particleSystem
	slot0._txtParticle.text = slot1.particleCount
	slot0._txtMaterial.text = slot1.materialCount
	slot0._txtTexture.text = slot1.textureCount

	gohelper.setActive(slot0._btnClear.gameObject, slot0._index == 1)
	gohelper.setActive(slot0._slider.gameObject, slot0._index == 2)
end

function slot0._onClickName(slot0)
	if not gohelper.isNil(slot0._mo.go) then
		ZProj.GameHelper.SetSelection(slot0._mo.go)
	end
end

function slot0._onClickClear(slot0)
	EffectStatModel.instance:clearStat()
end

function slot0._onValueChanged(slot0, slot1, slot2)
	slot3 = slot0._imgViewBg.color
	slot3.a = slot2
	slot0._imgViewBg.color = slot3
end

return slot0
