module("modules.logic.effect.view.EffectStatItem", package.seeall)

local var_0_0 = class("EffectStatItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "title/txtName")
	arg_1_0._txtSystem = gohelper.findChildText(arg_1_1, "title/txtSystem")
	arg_1_0._txtParticle = gohelper.findChildText(arg_1_1, "title/txtParticle")
	arg_1_0._txtMaterial = gohelper.findChildText(arg_1_1, "title/txtMaterial")
	arg_1_0._txtTexture = gohelper.findChildText(arg_1_1, "title/txtTexture")
	arg_1_0._clickName = SLFramework.UGUI.UIClickListener.Get(arg_1_0._txtName.gameObject)
	arg_1_0._btnClear = gohelper.findChildButtonWithAudio(arg_1_1, "title/btnClear")
	arg_1_0._slider = gohelper.findChildSlider(arg_1_1, "title/slider")
	arg_1_0._imgViewBg = arg_1_1.transform.parent.parent.parent.parent:GetComponent(gohelper.Type_Image)

	arg_1_0._slider:SetValue(arg_1_0._imgViewBg.color.a)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._clickName:AddClickListener(arg_2_0._onClickName, arg_2_0)
	arg_2_0._btnClear:AddClickListener(arg_2_0._onClickClear, arg_2_0)
	arg_2_0._slider:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._clickName:RemoveClickListener()
	arg_3_0._btnClear:RemoveClickListener()
	arg_3_0._slider:RemoveOnValueChanged()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._txtName.text = arg_4_1.name
	arg_4_0._txtSystem.text = arg_4_1.particleSystem
	arg_4_0._txtParticle.text = arg_4_1.particleCount
	arg_4_0._txtMaterial.text = arg_4_1.materialCount
	arg_4_0._txtTexture.text = arg_4_1.textureCount

	gohelper.setActive(arg_4_0._btnClear.gameObject, arg_4_0._index == 1)
	gohelper.setActive(arg_4_0._slider.gameObject, arg_4_0._index == 2)
end

function var_0_0._onClickName(arg_5_0)
	if not gohelper.isNil(arg_5_0._mo.go) then
		ZProj.GameHelper.SetSelection(arg_5_0._mo.go)
	end
end

function var_0_0._onClickClear(arg_6_0)
	EffectStatModel.instance:clearStat()
end

function var_0_0._onValueChanged(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._imgViewBg.color

	var_7_0.a = arg_7_2
	arg_7_0._imgViewBg.color = var_7_0
end

return var_0_0
