module("modules.logic.fight.view.preview.SkillEffectStatItem", package.seeall)

slot0 = class("SkillEffectStatItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._txtName = gohelper.findChildText(slot1, "title/txtName")
	slot0._txtSystem = gohelper.findChildText(slot1, "title/txtSystem")
	slot0._txtParticle = gohelper.findChildText(slot1, "title/txtParticle")
	slot0._txtMaterial = gohelper.findChildText(slot1, "title/txtMaterial")
	slot0._txtTexture = gohelper.findChildText(slot1, "title/txtTexture")
	slot0._clickName = SLFramework.UGUI.UIClickListener.Get(slot0._txtName.gameObject)
end

function slot0.addEventListeners(slot0)
	slot0._clickName:AddClickListener(slot0._onClickName, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._clickName:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtName.text = slot1.name
	slot0._txtSystem.text = slot1.particleSystem
	slot0._txtParticle.text = slot1.particleCount
	slot0._txtMaterial.text = slot1.materialCount
	slot0._txtTexture.text = slot1.textureCount
end

function slot0._onClickName(slot0)
	if not gohelper.isNil(slot0._mo.go) then
		ZProj.GameHelper.SetSelection(slot0._mo.go)
	end
end

return slot0
