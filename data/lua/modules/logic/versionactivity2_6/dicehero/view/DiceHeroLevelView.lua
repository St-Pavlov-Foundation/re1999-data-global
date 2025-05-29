module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroLevelView", package.seeall)

local var_0_0 = class("DiceHeroLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_Normal")
	arg_1_0._goinfinite = gohelper.findChild(arg_1_0.viewGO, "#go_Endless")
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Reset")
	arg_1_0._txtTitle1 = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_Normal/Title/#txt_Title")
	arg_1_0._txtTitle2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_Endless/Title/#txt_Title")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0._onResetClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnReset:RemoveClickListener()
end

function var_0_0._onResetClick(arg_4_0)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroReset, MsgBoxEnum.BoxType.Yes_No, arg_4_0._onSendReset, nil, nil, arg_4_0)
end

function var_0_0._onSendReset(arg_5_0)
	DiceHeroRpc.instance:sendDiceGiveUp(5)
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_alaifuchapter)
	gohelper.setActive(arg_6_0._gonormal, not arg_6_0.viewParam.isInfinite)
	gohelper.setActive(arg_6_0._goinfinite, arg_6_0.viewParam.isInfinite)
	gohelper.setActive(arg_6_0._btnReset, arg_6_0.viewParam.isInfinite)

	local var_6_0 = arg_6_0.viewContainer._viewSetting.otherRes.roleinfoitem
	local var_6_1 = arg_6_0.viewParam and arg_6_0.viewParam.chapterId or 1

	for iter_6_0 = 1, 6 do
		local var_6_2 = gohelper.findChild(arg_6_0.viewGO, "#btn_stage" .. iter_6_0)
		local var_6_3 = iter_6_0
		local var_6_4 = DiceHeroConfig.instance:getLevelCo(var_6_1, var_6_3)

		if not var_6_4 then
			break
		end

		MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, DiceHeroStageItem):initData(var_6_4, arg_6_0.viewParam.isInfinite)

		if iter_6_0 == 1 then
			arg_6_0._txtTitle1.text = var_6_4.chapterName
			arg_6_0._txtTitle2.text = var_6_4.chapterName
		end
	end

	local var_6_5 = gohelper.findChild(arg_6_0.viewGO, "#go_roleinfoitem")
	local var_6_6 = arg_6_0:getResInst(var_6_0, var_6_5)

	MonoHelper.addNoUpdateLuaComOnceToGo(var_6_6, DiceHeroRoleItem, {
		chapter = var_6_1
	})
end

return var_0_0
