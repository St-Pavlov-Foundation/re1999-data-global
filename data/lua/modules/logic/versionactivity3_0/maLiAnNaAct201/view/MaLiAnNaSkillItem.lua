module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaSkillItem", package.seeall)

local var_0_0 = class("MaLiAnNaSkillItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Selected")
	arg_1_0._imageSkill = gohelper.findChildImage(arg_1_0.viewGO, "image/#image_Skill")
	arg_1_0._imageCD = gohelper.findChildImage(arg_1_0.viewGO, "#image_CD")

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
	arg_4_0._click = gohelper.getClickWithDefaultAudio(arg_4_0.viewGO)

	arg_4_0._click:AddClickListener(arg_4_0.onClick, arg_4_0)

	arg_4_0._goVx = gohelper.findChild(arg_4_0.viewGO, "vx_tips")
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onClick(arg_7_0)
	if arg_7_0._skillData == nil or arg_7_0._skillData:isInCD() then
		return
	end

	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnSelectActiveSkill, arg_7_0._skillData)
end

function var_0_0.initData(arg_8_0, arg_8_1)
	arg_8_0._skillData = arg_8_1

	local var_8_0 = arg_8_0._skillData:getConfig()

	if var_8_0 and var_8_0.icon then
		UISpriteSetMgr.instance:setMaliAnNaSprite(arg_8_0._imageSkill, var_8_0.icon)
	end
end

function var_0_0.updateInfo(arg_9_0, arg_9_1)
	arg_9_0._skillData = arg_9_1

	if arg_9_0._skillData == nil then
		return
	end

	local var_9_0 = arg_9_1:getCDPercent()

	if arg_9_0._cdValue == nil or arg_9_0._cdValue ~= var_9_0 then
		arg_9_0._imageCD.fillAmount = var_9_0

		if arg_9_0._cdValue ~= nil and var_9_0 <= 0 then
			AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_activity_level_chosen)
		end

		gohelper.setActive(arg_9_0._goVx, var_9_0 <= 0)

		arg_9_0._cdValue = var_9_0
	end
end

function var_0_0.refreshSelect(arg_10_0, arg_10_1)
	if arg_10_1 == nil then
		gohelper.setActive(arg_10_0._goSelected, false)

		return
	end

	gohelper.setActive(arg_10_0._goSelected, arg_10_0._skillData._id == arg_10_1._id)
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0._click then
		arg_11_0._click:RemoveClickListener()

		arg_11_0._click = nil
	end
end

return var_0_0
