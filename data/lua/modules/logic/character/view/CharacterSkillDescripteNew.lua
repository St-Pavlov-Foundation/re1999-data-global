module("modules.logic.character.view.CharacterSkillDescripteNew", package.seeall)

local var_0_0 = class("CharacterSkillDescripteNew", CharacterSkillDescripte)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "#txt_skillevel")
	arg_1_0._goCurlevel = gohelper.findChild(arg_1_0.viewGO, "#go_curlevel")
	arg_1_0._txtskillDesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_descripte")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.canvasGroup = gohelper.onceAddComponent(arg_4_0._txtskillDesc.gameObject, gohelper.Type_CanvasGroup)
	arg_4_0.txtlvcanvasGroup = gohelper.onceAddComponent(arg_4_0._txtlv.gameObject, gohelper.Type_CanvasGroup)
	arg_4_0.govx = gohelper.findChild(arg_4_0.viewGO, "vx")

	gohelper.setActive(arg_4_0.govx, false)

	arg_4_0.vxAni = arg_4_0.govx:GetComponent(typeof(UnityEngine.Animation))
	arg_4_0.aniLength = arg_4_0.vxAni.clip.length
end

function var_0_0.updateInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	arg_5_0.parentView = arg_5_1

	local var_5_0 = SkillConfig.instance:getherolevelexskillCO(arg_5_2, arg_5_3)

	arg_5_0._txtlv.text = arg_5_3

	gohelper.setActive(arg_5_0._goCurlevel, not arg_5_5 and arg_5_4 + 1 == arg_5_3)

	if not var_5_0 then
		return 0
	end

	local var_5_1 = var_5_0.desc

	arg_5_0.canvasGroup.alpha = arg_5_4 < arg_5_3 and 0.5 or 1
	arg_5_0.txtlvcanvasGroup.alpha = arg_5_4 < arg_5_3 and 0.5 or 1

	local var_5_2 = GameUtil.getTextHeightByLine(arg_5_0._txtskillDesc, var_5_1, 28, -3) + 54

	recthelper.setHeight(arg_5_0.viewGO.transform, var_5_2)

	arg_5_0._skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._txtskillDesc.gameObject, SkillDescComp)

	arg_5_0._skillDesc:updateInfo(arg_5_0._txtskillDesc, var_5_1, arg_5_2)

	return var_5_2
end

return var_0_0
