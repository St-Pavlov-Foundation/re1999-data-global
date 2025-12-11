module("modules.logic.survival.view.shelter.ShelterMapEventChoiceItem", package.seeall)

local var_0_0 = class("ShelterMapEventChoiceItem", SurvivalEventChoiceItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._btn = gohelper.findChildButtonWithAudio(arg_1_1, "#go_State")
	arg_1_0._gobgyellow = gohelper.findChild(arg_1_1, "#go_State/#go_bg_yellow")
	arg_1_0._gobgred = gohelper.findChild(arg_1_1, "#go_State/#go_bg_red")
	arg_1_0._gobggreen = gohelper.findChild(arg_1_1, "#go_State/#go_bg_green")
	arg_1_0._gobggray = gohelper.findChild(arg_1_1, "#go_State/#go_bg_gray")
	arg_1_0._gonormal = gohelper.findChild(arg_1_1, "#go_State/#go_normal")
	arg_1_0._txtnormaldesc = gohelper.findChildTextMesh(arg_1_1, "#go_State/#go_normal/#txt_desc")
	arg_1_0._txt_desc_lock = gohelper.findChildTextMesh(arg_1_1, "#go_State/#txt_desc_lock")
	arg_1_0._txt_condition_lock = gohelper.findChildTextMesh(arg_1_1, "#go_State/#txt_desc_lock/#txt_condition_lock")
	arg_1_0._go_costtime_lock = gohelper.findChild(arg_1_1, "#go_State/#txt_desc_lock/#go_costTime")
	arg_1_0._txt_costtime_lock = gohelper.findChildTextMesh(arg_1_1, "#go_State/#txt_desc_lock/#go_costTime/#txt_Time")
	arg_1_0._txt_desc_unlock = gohelper.findChildTextMesh(arg_1_1, "#go_State/#txt_desc_unlock")
	arg_1_0._txt_condition_unlock = gohelper.findChildTextMesh(arg_1_1, "#go_State/#txt_desc_unlock/#txt_condition_unlock")
	arg_1_0._go_costtime_unlock = gohelper.findChild(arg_1_1, "#go_State/#txt_desc_unlock/#go_costTime")
	arg_1_0._txt_costtime_unlock = gohelper.findChildTextMesh(arg_1_1, "#go_State/#txt_desc_unlock/#go_costTime/#txt_Time")
	arg_1_0._goicon = gohelper.findChild(arg_1_1, "#go_State/#go_Icon")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btn:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btn:RemoveClickListener()
end

function var_0_0.updateData(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	gohelper.setActive(arg_4_0.go, arg_4_1)

	if arg_4_1 then
		local var_4_0 = arg_4_1.color

		gohelper.setActive(arg_4_0._gobgred, var_4_0 == SurvivalConst.EventChoiceColor.Red)
		gohelper.setActive(arg_4_0._gobgyellow, var_4_0 == SurvivalConst.EventChoiceColor.Yellow)
		gohelper.setActive(arg_4_0._gobggreen, var_4_0 == SurvivalConst.EventChoiceColor.Green)
		gohelper.setActive(arg_4_0._gobggray, var_4_0 == SurvivalConst.EventChoiceColor.Gray)
		gohelper.setActive(arg_4_0._gonormal, arg_4_1.exStr == nil)
		gohelper.setActive(arg_4_0._txt_desc_unlock, arg_4_1.exStr and arg_4_1.isValid)
		gohelper.setActive(arg_4_0._txt_desc_lock, arg_4_1.exStr and not arg_4_1.isValid)
		gohelper.setActive(arg_4_0._goicon, arg_4_1.icon ~= SurvivalEnum.EventChoiceIcon.None)

		if not arg_4_1.exStr then
			arg_4_0._txtnormaldesc.text = arg_4_1.desc
		elseif arg_4_1.isValid then
			arg_4_0._txt_desc_unlock.text = arg_4_1.desc

			gohelper.setActive(arg_4_0._go_costtime_unlock, arg_4_1.isCostTime)
			gohelper.setActive(arg_4_0._txt_condition_unlock, not arg_4_1.isCostTime)

			if arg_4_1.isCostTime then
				arg_4_0._txt_costtime_unlock.text = arg_4_1.exStr
			else
				arg_4_0._txt_condition_unlock.text = arg_4_1.exStr
			end
		else
			arg_4_0._txt_desc_lock.text = arg_4_1.desc

			gohelper.setActive(arg_4_0._go_costtime_lock, arg_4_1.isCostTime)
			gohelper.setActive(arg_4_0._txt_condition_lock, not arg_4_1.isCostTime)

			if arg_4_1.isCostTime then
				arg_4_0._txt_costtime_lock.text = arg_4_1.exStr
			else
				arg_4_0._txt_condition_lock.text = arg_4_1.exStr
			end
		end
	end
end

function var_0_0._onClick(arg_5_0)
	if not arg_5_0.data.isValid then
		return
	end

	if arg_5_0.data.callback then
		arg_5_0.data.callback(arg_5_0.data.callobj, arg_5_0.data.param, arg_5_0.data)
	end
end

return var_0_0
