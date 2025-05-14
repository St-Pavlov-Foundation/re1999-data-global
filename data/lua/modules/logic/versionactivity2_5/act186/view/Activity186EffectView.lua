module("modules.logic.versionactivity2_5.act186.view.Activity186EffectView", package.seeall)

local var_0_0 = class("Activity186EffectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.effectList = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 4 do
		arg_1_0.effectList[iter_1_0] = gohelper.findChild(arg_1_0.viewGO, "#go_effect" .. iter_1_0)
	end

	arg_1_0.audioIdList = {
		[Activity186Enum.ViewEffect.Caidai] = AudioEnum.Act186.play_ui_tangren_banger,
		[Activity186Enum.ViewEffect.Yanhua] = AudioEnum.Act186.play_ui_tangren_firework,
		[Activity186Enum.ViewEffect.Jinsha] = AudioEnum.Act186.play_ui_tangren_mysticism,
		[Activity186Enum.ViewEffect.Xiangyun] = AudioEnum.Act186.play_ui_tangren_cloud
	}

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
	return
end

function var_0_0.onClickBtnClose(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshParam()
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.refreshParam(arg_8_0)
	arg_8_0.effectId = arg_8_0.viewParam.effectId
end

function var_0_0.refreshView(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.effectList) do
		gohelper.setActive(iter_9_1, false)

		if iter_9_0 == arg_9_0.effectId then
			gohelper.setActive(iter_9_1, true)
		end
	end

	local var_9_0 = arg_9_0.audioIdList[arg_9_0.effectId]

	if var_9_0 then
		AudioMgr.instance:trigger(var_9_0)
	end
end

function var_0_0.onClose(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
