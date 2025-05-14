module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentDisplayView", package.seeall)

local var_0_0 = class("V2a5_GoldenMilletPresentDisplayView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	gohelper.setActive(arg_1_0.viewGO, true)

	arg_1_0._btnPresentList = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, GoldenMilletEnum.DISPLAY_SKIN_COUNT do
		local var_1_0 = string.format("present%s/#btn_Present", iter_1_0)
		local var_1_1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, var_1_0)

		if var_1_1 then
			arg_1_0._btnPresentList[#arg_1_0._btnPresentList + 1] = var_1_1
		end
	end

	arg_1_0._goHasReceiveTip = gohelper.findChild(arg_1_0.viewGO, "#go_ReceiveTip")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._btnBgClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "close")
end

function var_0_0.addEvents(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._btnPresentList) do
		iter_2_1:AddClickListener(arg_2_0._btnPresentOnClick, arg_2_0, iter_2_0)
	end

	if arg_2_0._btnClose then
		arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	end

	if arg_2_0._btnBgClose then
		arg_2_0._btnBgClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._btnPresentList) do
		iter_3_1:RemoveClickListener()
	end

	if arg_3_0._btnClose then
		arg_3_0._btnClose:RemoveClickListener()
	end

	if arg_3_0._btnBgClose then
		arg_3_0._btnBgClose:RemoveClickListener()
	end
end

function var_0_0._btnPresentOnClick(arg_4_0, arg_4_1)
	if not GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(true) then
		return
	end

	local var_4_0 = GoldenMilletEnum.Index2Skin[arg_4_1]

	if var_4_0 then
		CharacterController.instance:openCharacterSkinTipView({
			isShowHomeBtn = false,
			skinId = var_4_0
		})
	end
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(arg_6_0._goHasReceiveTip, var_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletDisplayViewOpen)
end

function var_0_0.onDestroy(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._btnPresentList) do
		iter_7_1:RemoveClickListener()
	end
end

return var_0_0
