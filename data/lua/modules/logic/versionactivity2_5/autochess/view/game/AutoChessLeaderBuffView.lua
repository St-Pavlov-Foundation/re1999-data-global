module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessLeaderBuffView", package.seeall)

local var_0_0 = class("AutoChessLeaderBuffView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollDetail = gohelper.findChildScrollRect(arg_1_0.viewGO, "Detail/#scroll_Detail")
	arg_1_0._goBg = gohelper.findChild(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/#go_Bg")
	arg_1_0._goEnergy = gohelper.findChild(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Energy")
	arg_1_0._txtEnergy = gohelper.findChildText(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Energy/#txt_Energy")
	arg_1_0._txtEnergyDesc = gohelper.findChildText(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Energy/#txt_EnergyDesc")
	arg_1_0._goFire = gohelper.findChild(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Fire")
	arg_1_0._txtFire = gohelper.findChildText(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Fire/#txt_Fire")
	arg_1_0._txtFireDesc = gohelper.findChildText(arg_1_0.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Fire/#txt_FireDesc")
	arg_1_0._goBuff = gohelper.findChild(arg_1_0.viewGO, "Detail/#go_Buff")
	arg_1_0._txtBuffName = gohelper.findChildText(arg_1_0.viewGO, "Detail/#go_Buff/title/#txt_BuffName")
	arg_1_0._scrollBuff = gohelper.findChildScrollRect(arg_1_0.viewGO, "Detail/#go_Buff/#scroll_Buff")
	arg_1_0._txtBuffDesc = gohelper.findChildText(arg_1_0.viewGO, "Detail/#go_Buff/#scroll_Buff/viewport/content/#txt_BuffDesc")

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

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	SkillHelper.addHyperLinkClick(arg_5_0._txtEnergyDesc, arg_5_0.clickHyperLink, arg_5_0)
	SkillHelper.addHyperLinkClick(arg_5_0._txtFireDesc, arg_5_0.clickHyperLink, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.chessMo = AutoChessModel.instance:getChessMo()

	local var_6_0 = arg_6_0.chessMo.svrFight.mySideMaster

	if AutoChessHelper.getBuffCnt(var_6_0.buffContainer.buffs, AutoChessEnum.EnergyBuffIds) == 0 then
		gohelper.setActive(arg_6_0._goEnergy, false)
	else
		arg_6_0._txtEnergy.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_leaderbuffview_energy"), 1)

		local var_6_1 = AutoChessConfig.instance:getSkillEffectDesc(2)

		arg_6_0._txtEnergyDesc.text = AutoChessHelper.buildSkillDesc(var_6_1.desc)

		gohelper.setActive(arg_6_0._goEnergy, true)
	end

	if AutoChessHelper.getBuffCnt(var_6_0.buffContainer.buffs, AutoChessEnum.FireBuffIds) == 0 then
		gohelper.setActive(arg_6_0._goFire, false)
	else
		arg_6_0._txtFire.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_leaderbuffview_fire"), 1)

		local var_6_2 = AutoChessConfig.instance:getSkillEffectDesc(16)

		arg_6_0._txtFireDesc.text = AutoChessHelper.buildSkillDesc(var_6_2.desc)

		gohelper.setActive(arg_6_0._goFire, true)
	end

	TaskDispatcher.runDelay(arg_6_0.delaySet, arg_6_0, 0.05)
end

function var_0_0.onDestroyView(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.delaySet, arg_7_0)
end

function var_0_0.delaySet(arg_8_0)
	local var_8_0 = arg_8_0._scrollDetail.content.gameObject.transform
	local var_8_1 = recthelper.getHeight(var_8_0) + 36

	var_8_1 = var_8_1 < 500 and var_8_1 or 500

	recthelper.setHeight(arg_8_0._goBg.transform, var_8_1)

	local var_8_2 = arg_8_0.viewParam.position

	recthelper.setAnchor(arg_8_0.viewGO.transform, var_8_2.x + 180, var_8_2.y + var_8_1 - 80)
end

function var_0_0.clickHyperLink(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = AutoChessConfig.instance:getSkillEffectDesc(tonumber(arg_9_1))

	if var_9_0 then
		arg_9_0._txtBuffName.text = var_9_0.name
		arg_9_0._txtBuffDesc.text = var_9_0.desc

		gohelper.setActive(arg_9_0._goBuff, true)
	end
end

return var_0_0
