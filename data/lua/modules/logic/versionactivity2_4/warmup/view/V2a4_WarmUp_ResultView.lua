module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_ResultView", package.seeall)

local var_0_0 = class("V2a4_WarmUp_ResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagepanelbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_panelbg1")
	arg_1_0._simagepanelbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_panelbg2")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._txtfail = gohelper.findChildText(arg_1_0.viewGO, "#go_fail/#txt_fail")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._txtsuccess = gohelper.findChildText(arg_1_0.viewGO, "#go_success/#txt_success")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

local var_0_1 = SLFramework.AnimatorPlayer

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._animPlayer = var_0_1.Get(arg_5_0.viewGO)
end

function var_0_0.onUpdateParam(arg_6_0)
	gohelper.setActive(arg_6_0._gofail, not arg_6_0:_isSucc())
	gohelper.setActive(arg_6_0._gosuccess, arg_6_0:_isSucc())

	arg_6_0._txtsuccess.text = arg_6_0:_desc()
	arg_6_0._txtfail.text = arg_6_0:_desc()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:onUpdateParam()
	arg_7_0._animPlayer:Play(arg_7_0:_isSucc() and "success" or "fail", nil, nil)
	AudioMgr.instance:trigger(arg_7_0:_isSucc() and AudioEnum.UI.play_ui_diqiu_yure_success_20249043 or AudioEnum.UI.play_ui_mln_remove_effect_20249042)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:_callCloseCallback()
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0._isSucc(arg_10_0)
	return arg_10_0.viewParam.isSucc
end

function var_0_0._desc(arg_11_0)
	return arg_11_0.viewParam.desc
end

function var_0_0._callCloseCallback(arg_12_0)
	local var_12_0 = arg_12_0.viewParam.closeCb

	if var_12_0 then
		var_12_0(arg_12_0.viewParam.closeCbObj)
	end
end

return var_0_0
