module("modules.logic.fight.view.preview.SkillEffectStatItem", package.seeall)

local var_0_0 = class("SkillEffectStatItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "title/txtName")
	arg_1_0._txtSystem = gohelper.findChildText(arg_1_1, "title/txtSystem")
	arg_1_0._txtParticle = gohelper.findChildText(arg_1_1, "title/txtParticle")
	arg_1_0._txtMaterial = gohelper.findChildText(arg_1_1, "title/txtMaterial")
	arg_1_0._txtTexture = gohelper.findChildText(arg_1_1, "title/txtTexture")
	arg_1_0._clickName = SLFramework.UGUI.UIClickListener.Get(arg_1_0._txtName.gameObject)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._clickName:AddClickListener(arg_2_0._onClickName, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._clickName:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._txtName.text = arg_4_1.name
	arg_4_0._txtSystem.text = arg_4_1.particleSystem
	arg_4_0._txtParticle.text = arg_4_1.particleCount
	arg_4_0._txtMaterial.text = arg_4_1.materialCount
	arg_4_0._txtTexture.text = arg_4_1.textureCount
end

function var_0_0._onClickName(arg_5_0)
	if not gohelper.isNil(arg_5_0._mo.go) then
		ZProj.GameHelper.SetSelection(arg_5_0._mo.go)
	end
end

return var_0_0
