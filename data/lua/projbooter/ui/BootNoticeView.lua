module("projbooter.ui.BootNoticeView", package.seeall)

local var_0_0 = class("BootNoticeView")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._callback = arg_1_1
	arg_1_0._callbackObj = arg_1_2
	arg_1_0._go = BootResMgr.instance:getNoticeViewGo()

	arg_1_0._go:SetActive(true)

	arg_1_0._rootTr = arg_1_0._go.transform

	local var_1_0 = typeof(UnityEngine.UI.Text)

	arg_1_0._txtTitle = arg_1_0._rootTr:Find("top/title"):GetComponent(var_1_0)
	arg_1_0._txtContent = arg_1_0._rootTr:Find("#scroll_desc/viewport/content/desc"):GetComponent(var_1_0)
	arg_1_0._btnGo = arg_1_0._rootTr:Find("btnOk").gameObject
	arg_1_0._okBtn = SLFramework.UGUI.ButtonWrap.Get(arg_1_0._btnGo)

	arg_1_0._okBtn:AddClickListener(arg_1_0._onClickOkBtn, arg_1_0)
	arg_1_0._go.transform:SetAsLastSibling()
	arg_1_0:_setNotice()
end

function var_0_0._setNotice(arg_2_0)
	arg_2_0._txtTitle.text = NoticeModel.instance:getBeforeLoginNoticeTitle()
	arg_2_0._txtContent.text = NoticeModel.instance:getBeforeLoginNoticeContent()
end

function var_0_0._onClickOkBtn(arg_3_0)
	if arg_3_0._callback == nil then
		return
	end

	arg_3_0._callback(arg_3_0._callbackObj)

	arg_3_0._callback = nil
	arg_3_0._callbackObj = nil

	arg_3_0:dispose()
end

function var_0_0.dispose(arg_4_0)
	if arg_4_0._okBtn then
		arg_4_0._okBtn:RemoveClickListener()
		UnityEngine.GameObject.Destroy(arg_4_0._go)

		arg_4_0._go = nil
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0) do
		if type(iter_4_1) == "userdata" then
			rawset(arg_4_0, iter_4_0, nil)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
