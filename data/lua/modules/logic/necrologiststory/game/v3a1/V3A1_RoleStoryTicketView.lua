module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryTicketView", package.seeall)

local var_0_0 = class("V3A1_RoleStoryTicketView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtPlace = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/Title/#txt_place")
	arg_1_0.txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/Title/#txt_time")
	arg_1_0.btnConfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Ticket/#btn_confirm")
	arg_1_0.txtFrom = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/Ticket/simage_bg/#txt_from")
	arg_1_0.dropdownOption = gohelper.findChildDropdown(arg_1_0.viewGO, "root/Ticket/#drop_filter")
	arg_1_0.txtError = gohelper.findChildTextMesh(arg_1_0.dropdownOption.gameObject, "Label")
	arg_1_0.txtCorrectly = gohelper.findChildTextMesh(arg_1_0.dropdownOption.gameObject, "Correctly")
	arg_1_0.imageArrow = gohelper.findChildImage(arg_1_0.dropdownOption.gameObject, "arrow")

	arg_1_0.dropdownOption:AddOnValueChanged(arg_1_0.handleDropValueChanged, arg_1_0)

	arg_1_0.optionClick = gohelper.getClickWithAudio(arg_1_0.dropdownOption.gameObject, AudioEnum.UI.UI_Common_Click)
	arg_1_0.imageWeather = gohelper.findChildImage(arg_1_0.viewGO, "root/Title/#image_weather")
	arg_1_0.animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnConfirm, arg_2_0.onClickBtnConfirm, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.optionClick, arg_2_0.onClickOption, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnConfirm)
	arg_3_0:removeClickCb(arg_3_0.optionClick)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickModalMask(arg_5_0)
	return
end

function var_0_0.onClickOption(arg_6_0)
	return
end

function var_0_0.handleDropValueChanged(arg_7_0, arg_7_1)
	arg_7_0.selectIndex = arg_7_1

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	arg_7_0:refreshOption()
end

function var_0_0.onClickBtnConfirm(arg_8_0)
	if arg_8_0.selectIndex == -1 then
		return
	end

	local var_8_0 = arg_8_0.selectIndex + 1

	if arg_8_0.rightOption == var_8_0 then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_wulu_build)
		arg_8_0.gameBaseMO:tryFinishBase(arg_8_0.curBaseId)
		arg_8_0.animatorPlayer:Play("correctly", arg_8_0.onCorrectlyFinished, arg_8_0)
	end
end

function var_0_0.onCorrectlyFinished(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.initViewParam(arg_10_0)
	local var_10_0 = arg_10_0.viewParam.roleStoryId

	arg_10_0.gameBaseMO = NecrologistStoryModel.instance:getGameMO(var_10_0)
	arg_10_0.curBaseId = arg_10_0.gameBaseMO:getCurBaseId()

	local var_10_1 = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(arg_10_0.curBaseId)

	arg_10_0.options = string.split(var_10_1.choose, "#")
	arg_10_0.rightOption = var_10_1.rightChoose
	arg_10_0.selectIndex = -1
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:initViewParam()
	arg_11_0:refreshView()
end

function var_0_0.refreshView(arg_12_0)
	arg_12_0:refreshTitle()
	arg_12_0.dropdownOption:ClearOptions()
	arg_12_0.dropdownOption:AddOptions(arg_12_0.options)
	arg_12_0.dropdownOption:SetValue(arg_12_0.selectIndex)
	gohelper.setActive(arg_12_0.btnConfirm, false)
end

function var_0_0.refreshTitle(arg_13_0)
	local var_13_0 = arg_13_0.gameBaseMO:getCurTime()
	local var_13_1 = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(arg_13_0.curBaseId)
	local var_13_2, var_13_3 = NecrologistStoryHelper.getTimeFormat2(var_13_0)

	arg_13_0.txtTime.text = string.format("%d:%02d", var_13_2, var_13_3)
	arg_13_0.txtPlace.text = var_13_1.name
	arg_13_0.txtFrom.text = var_13_1.name

	UISpriteSetMgr.instance:setRoleStorySprite(arg_13_0.imageWeather, string.format("rolestory_weather%s", var_13_1.weather))
end

function var_0_0.refreshOption(arg_14_0)
	local var_14_0 = arg_14_0.selectIndex + 1
	local var_14_1 = arg_14_0.rightOption == var_14_0

	gohelper.setActive(arg_14_0.btnConfirm, var_14_1)

	local var_14_2 = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(arg_14_0.curBaseId)
	local var_14_3 = string.splitToNumber(var_14_2.dialogId, "#")
	local var_14_4 = var_14_1 and var_14_3[1] or var_14_3[2]

	if var_14_4 then
		TipDialogController.instance:openTipDialogView(var_14_4, arg_14_0.onDialogFinished, arg_14_0)
	end

	local var_14_5 = arg_14_0.options[var_14_0]

	if var_14_1 then
		arg_14_0.txtCorrectly.text = var_14_5
		arg_14_0.txtError.text = ""
	else
		arg_14_0.txtCorrectly.text = ""
		arg_14_0.txtError.text = var_14_5
	end
end

function var_0_0.onDialogFinished(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0.dropdownOption then
		arg_16_0.dropdownOption:RemoveOnValueChanged()

		arg_16_0.dropdownOption = nil
	end
end

return var_0_0
