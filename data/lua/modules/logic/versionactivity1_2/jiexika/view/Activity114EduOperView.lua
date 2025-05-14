module("modules.logic.versionactivity1_2.jiexika.view.Activity114EduOperView", package.seeall)

local var_0_0 = class("Activity114EduOperView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._path = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.go = gohelper.findChild(arg_2_0.viewGO, arg_2_0._path)
	arg_2_0._btnclose = gohelper.findChildButtonWithAudio(arg_2_0.go, "#btn_close")
	arg_2_0._btneduoper = gohelper.findChildButtonWithAudio(arg_2_0.go, "title/#btn_eduoper")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnclose:AddClickListener(arg_3_0._hideGo, arg_3_0)
	arg_3_0._btneduoper:AddClickListener(arg_3_0.onLearn, arg_3_0)
	arg_3_0.viewContainer:registerCallback(Activity114Event.ShowHideEduOper, arg_3_0.changeGoShow, arg_3_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnRoundUpdate, arg_3_0.updateLock, arg_3_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnAttentionUpdate, arg_3_0.updateFailRate, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnclose:RemoveClickListener()
	arg_4_0._btneduoper:RemoveClickListener()
	arg_4_0.viewContainer:unregisterCallback(Activity114Event.ShowHideEduOper, arg_4_0.changeGoShow, arg_4_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnRoundUpdate, arg_4_0.updateLock, arg_4_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnAttentionUpdate, arg_4_0.updateFailRate, arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	Activity114Model.instance.eduSelectAttr = nil
	arg_5_0.attrTb = {}

	for iter_5_0 = 1, Activity114Enum.Attr.End - 1 do
		local var_5_0 = arg_5_0:getUserDataTb_()

		var_5_0.btn = gohelper.findChildButtonWithAudio(arg_5_0.go, "#btn_attr" .. iter_5_0)
		var_5_0.normal = gohelper.findChild(arg_5_0.go, "#btn_attr" .. iter_5_0 .. "/normal")
		var_5_0.select = gohelper.findChild(arg_5_0.go, "#btn_attr" .. iter_5_0 .. "/select")
		var_5_0.txtFailRate = gohelper.findChildTextMesh(arg_5_0.go, "#btn_attr" .. iter_5_0 .. "/select/#txt_failRate")

		arg_5_0:addClickCb(var_5_0.btn, arg_5_0.selectLearnAttr, arg_5_0, iter_5_0)

		arg_5_0.attrTb[iter_5_0] = var_5_0
	end

	arg_5_0:updateFailRate()
	arg_5_0:_hideGo()
end

function var_0_0.changeGoShow(arg_6_0, arg_6_1)
	if arg_6_0.go.activeSelf == arg_6_1 then
		return
	end

	if arg_6_1 then
		gohelper.setActive(arg_6_0.go, true)

		local var_6_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.JieXiKaLastEduSelect, 0)

		arg_6_0:selectLearnAttr(var_6_0 > 0 and var_6_0 or nil, true)
	end
end

function var_0_0.updateFailRate(arg_7_0)
	for iter_7_0 = 1, Activity114Enum.Attr.End - 1 do
		local var_7_0 = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, iter_7_0)
		local var_7_1 = 0

		if var_7_0 and var_7_0.successVerify[Activity114Enum.AddAttrType.Attention] then
			var_7_1 = var_7_0.successVerify[Activity114Enum.AddAttrType.Attention]
		end

		local var_7_2 = Activity114Config.instance:getEduSuccessRate(Activity114Model.instance.id, iter_7_0, Activity114Model.instance.serverData.attention + var_7_1)

		arg_7_0.attrTb[iter_7_0].txtFailRate.text = formatLuaLang("versionactivity_1_2_114success_rate", var_7_2)
	end
end

function var_0_0.selectLearnAttr(arg_8_0, arg_8_1, arg_8_2)
	if Activity114Model.instance.eduSelectAttr ~= arg_8_1 then
		if not arg_8_2 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_subject_choose)
		end

		Activity114Model.instance.eduSelectAttr = arg_8_1

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.JieXiKaLastEduSelect, arg_8_1)
		arg_8_0.viewContainer:dispatchEvent(Activity114Event.EduSelectAttrChange)
	end

	for iter_8_0 = 1, Activity114Enum.Attr.End - 1 do
		gohelper.setActive(arg_8_0.attrTb[iter_8_0].select, iter_8_0 == arg_8_1)
		gohelper.setActive(arg_8_0.attrTb[iter_8_0].normal, iter_8_0 ~= arg_8_1)
	end
end

function var_0_0.onLearn(arg_9_0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	if not Activity114Model.instance.eduSelectAttr then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)

	local var_9_0 = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, Activity114Model.instance.eduSelectAttr)
	local var_9_1 = {
		type = Activity114Enum.EventType.Edu,
		eventId = var_9_0.config.id
	}

	Activity114Model.instance:beginEvent(var_9_1)
	arg_9_0:_hideGo()
end

function var_0_0.updateLock(arg_10_0)
	if not arg_10_0.go.activeSelf then
		return
	end

	local var_10_0 = Activity114Model.instance.serverData.week
	local var_10_1 = Activity114Model.instance.serverData.day
	local var_10_2 = Activity114Model.instance.serverData.round
	local var_10_3 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, var_10_1, var_10_2)

	if not var_10_3["banButton" .. var_10_0] then
		return
	end

	local var_10_4 = string.splitToNumber(var_10_3["banButton" .. var_10_0], "#")

	for iter_10_0, iter_10_1 in pairs(var_10_4) do
		if iter_10_1 == Activity114Enum.EventType.Edu then
			arg_10_0:_hideGo()

			return
		end
	end
end

function var_0_0._hideGo(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	gohelper.setActive(arg_11_0.go, false)
	arg_11_0.viewContainer:dispatchEvent(Activity114Event.ShowHideEduOper, false)

	if Activity114Model.instance.eduSelectAttr then
		Activity114Model.instance.eduSelectAttr = nil

		arg_11_0.viewContainer:dispatchEvent(Activity114Event.EduSelectAttrChange)
	end
end

function var_0_0.onClose(arg_12_0)
	Activity114Model.instance.eduSelectAttr = nil

	arg_12_0.viewContainer:dispatchEvent(Activity114Event.EduSelectAttrChange)
end

return var_0_0
