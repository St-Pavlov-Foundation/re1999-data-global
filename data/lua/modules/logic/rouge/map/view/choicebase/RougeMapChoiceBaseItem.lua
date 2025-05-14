module("modules.logic.rouge.map.view.choicebase.RougeMapChoiceBaseItem", package.seeall)

local var_0_0 = class("RougeMapChoiceBaseItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1:GetComponent(gohelper.Type_RectTransform)

	arg_1_0:_editableInitView()
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.click = gohelper.getClickWithDefaultAudio(arg_2_0.go)

	arg_2_0.click:AddClickListener(arg_2_0.onClickSelf, arg_2_0)

	arg_2_0.animator = arg_2_0.go:GetComponent(gohelper.Type_Animator)
	arg_2_0._golocked = gohelper.findChild(arg_2_0.go, "#go_locked")
	arg_2_0._txtlocktitle = gohelper.findChildText(arg_2_0.go, "#go_locked/#txt_locktitle")
	arg_2_0._txtlockdesc = gohelper.findChildText(arg_2_0.go, "#go_locked/#txt_lockdesc")
	arg_2_0._txtlocktip = gohelper.findChildText(arg_2_0.go, "#go_locked/#txt_locktip")
	arg_2_0._golockdetail = gohelper.findChild(arg_2_0.go, "#go_locked/#btn_lockdetail")
	arg_2_0._golockdetail2 = gohelper.findChild(arg_2_0.go, "#go_locked/#btn_lockdetail2")
	arg_2_0.goLockTip = arg_2_0._txtlocktip.gameObject
	arg_2_0._gonormal = gohelper.findChild(arg_2_0.go, "#go_normal")
	arg_2_0._txtnormaltitle = gohelper.findChildText(arg_2_0.go, "#go_normal/#txt_normaltitle")
	arg_2_0._txtnormaldesc = gohelper.findChildText(arg_2_0.go, "#go_normal/#txt_normaldesc")
	arg_2_0._txtnormaltip = gohelper.findChildText(arg_2_0.go, "#go_normal/#txt_normaltip")
	arg_2_0._gonormaldetail = gohelper.findChild(arg_2_0.go, "#go_normal/#btn_normaldetail")
	arg_2_0._gonormaldetail2 = gohelper.findChild(arg_2_0.go, "#go_normal/#btn_normaldetail2")
	arg_2_0._goselect = gohelper.findChild(arg_2_0.go, "#go_select")
	arg_2_0._txtselecttitle = gohelper.findChildText(arg_2_0.go, "#go_select/#txt_selecttitle")
	arg_2_0._txtselectdesc = gohelper.findChildText(arg_2_0.go, "#go_select/#txt_selectdesc")
	arg_2_0._txtselecttip = gohelper.findChildText(arg_2_0.go, "#go_select/#txt_selecttip")
	arg_2_0._goselectdetail = gohelper.findChild(arg_2_0.go, "#go_select/#btn_selectdetail")
	arg_2_0._goselectdetail2 = gohelper.findChild(arg_2_0.go, "#go_select/#btn_selectdetail2")

	gohelper.setActive(arg_2_0._golockdetail, false)
	gohelper.setActive(arg_2_0._golockdetail2, false)
	gohelper.setActive(arg_2_0._gonormaldetail, false)
	gohelper.setActive(arg_2_0._goselectdetail, false)
	gohelper.setActive(arg_2_0._gonormaldetail2, false)
	gohelper.setActive(arg_2_0._goselectdetail2, false)
	arg_2_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChoiceItemStatusChange, arg_2_0.onStatusChange, arg_2_0)
end

function var_0_0.onStatusChange(arg_3_0, arg_3_1)
	return
end

function var_0_0.onClickSelf(arg_4_0)
	return
end

function var_0_0.onSelectAnimDone(arg_5_0)
	return
end

function var_0_0.update(arg_6_0, arg_6_1)
	recthelper.setAnchor(arg_6_0.tr, arg_6_1.x, arg_6_1.y)
end

function var_0_0.canShowNormalUI(arg_7_0)
	return arg_7_0.status == RougeMapEnum.ChoiceStatus.Normal or arg_7_0.status == RougeMapEnum.ChoiceStatus.UnSelect
end

function var_0_0.canShowLockUI(arg_8_0)
	return arg_8_0.status == RougeMapEnum.ChoiceStatus.Lock
end

function var_0_0.canShowSelectUI(arg_9_0)
	return arg_9_0.status == RougeMapEnum.ChoiceStatus.Select
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0:refreshLockUI()
	arg_10_0:refreshNormalUI()
	arg_10_0:refreshSelectUI()
end

function var_0_0.refreshLockUI(arg_11_0)
	local var_11_0 = arg_11_0:canShowLockUI()

	gohelper.setActive(arg_11_0._golocked, var_11_0)

	if var_11_0 then
		arg_11_0._txtlocktitle.text = arg_11_0.title
		arg_11_0._txtlockdesc.text = arg_11_0.desc
		arg_11_0._txtlocktip.text = arg_11_0.tip

		gohelper.setActive(arg_11_0.goLockTip, not string.nilorempty(arg_11_0.tip))
	end
end

function var_0_0.refreshNormalUI(arg_12_0)
	local var_12_0 = arg_12_0:canShowNormalUI()

	gohelper.setActive(arg_12_0._gonormal, var_12_0)

	if var_12_0 then
		arg_12_0._txtnormaltitle.text = arg_12_0.title
		arg_12_0._txtnormaldesc.text = arg_12_0.desc
		arg_12_0._txtnormaltip.text = arg_12_0.tip

		if arg_12_0.status == RougeMapEnum.ChoiceStatus.Normal then
			arg_12_0.animator:Play("normal", 0, 0)
		else
			arg_12_0.animator:Play("unselect", 0, 0)
		end
	end
end

function var_0_0.refreshSelectUI(arg_13_0)
	local var_13_0 = arg_13_0:canShowSelectUI()

	gohelper.setActive(arg_13_0._goselect, var_13_0)

	if var_13_0 then
		arg_13_0._txtselecttitle.text = arg_13_0.title
		arg_13_0._txtselectdesc.text = arg_13_0.desc
		arg_13_0._txtselecttip.text = arg_13_0.tip
	end
end

function var_0_0.clearCallback(arg_14_0)
	if arg_14_0.callbackId then
		RougeRpc.instance:removeCallbackById(arg_14_0.callbackId)

		arg_14_0.callbackId = nil
	end
end

function var_0_0.show(arg_15_0)
	gohelper.setActive(arg_15_0.go, true)
end

function var_0_0.hide(arg_16_0)
	gohelper.setActive(arg_16_0.go, false)
end

function var_0_0.destroy(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.onSelectAnimDone, arg_17_0)
	arg_17_0.click:RemoveClickListener()
	arg_17_0:clearCallback()
	arg_17_0:__onDispose()
end

return var_0_0
