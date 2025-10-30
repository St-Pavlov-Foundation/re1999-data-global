module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaHeroSoliderItem", package.seeall)

local var_0_0 = class("MaLiAnNaHeroSoliderItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._txtRoleName = gohelper.findChildText(arg_1_0.viewGO, "#go_tips/#txt_RoleName")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#go_tips/#txt_dec")
	arg_1_0._txtRoleHP = gohelper.findChildText(arg_1_0.viewGO, "#go_tips/#txt_RoleHP")
	arg_1_0._goSelf = gohelper.findChild(arg_1_0.viewGO, "#go_Self")
	arg_1_0._goEnemy = gohelper.findChild(arg_1_0.viewGO, "#go_Enemy")
	arg_1_0._simageRole = gohelper.findChildSingleImage(arg_1_0.viewGO, "image/#simage_Role")
	arg_1_0._txtRoleHP2 = gohelper.findChildText(arg_1_0.viewGO, "image_RoleHPNumBG/#txt_RoleHP_2")
	arg_1_0._goDead = gohelper.findChild(arg_1_0.viewGO, "#go_Dead")
	arg_1_0._btnrole = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_role")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrole:AddClickListener(arg_2_0._btnroleOnClick, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0.onTouchScreen, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrole:RemoveClickListener()
	arg_3_0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_3_0.onTouchScreen, arg_3_0)
end

function var_0_0._btnroleOnClick(arg_4_0)
	arg_4_0:refreshTip()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goRoleHP = gohelper.findChild(arg_5_0.viewGO, "image_RoleHPNumBG")
	arg_5_0._txtReduceHP = gohelper.findChildText(arg_5_0.viewGO, "#txt_reduceHP")
	arg_5_0._goReduceHp = arg_5_0._txtReduceHP.gameObject

	arg_5_0:_hideReduce()
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onTouchScreen(arg_8_0)
	if arg_8_0._gotips then
		if gohelper.isMouseOverGo(arg_8_0._gotips) or gohelper.isMouseOverGo(arg_8_0._btnrole) then
			return
		end

		arg_8_0._isShowTips = false

		arg_8_0:_refreshTipState()
	end
end

function var_0_0.refreshTip(arg_9_0)
	arg_9_0._isShowTips = not arg_9_0._isShowTips

	arg_9_0:_refreshTipState()
end

function var_0_0._refreshTipState(arg_10_0)
	gohelper.setActive(arg_10_0._gotips, arg_10_0._isShowTips)
	gohelper.setActive(arg_10_0._goRoleHP, not arg_10_0._isShowTips)
end

function var_0_0.initData(arg_11_0, arg_11_1)
	arg_11_0._soliderMo = arg_11_1

	if arg_11_0._soliderMo == nil then
		return
	end

	local var_11_0 = arg_11_0._soliderMo:getConfig()

	arg_11_0._txtdec.text = var_11_0.description
	arg_11_0._txtRoleName.text = var_11_0.name
	arg_11_0._isShowTips = false

	gohelper.setActive(arg_11_0._gotips, false)
	gohelper.setActive(arg_11_0._goSelf, arg_11_0._soliderMo:getCamp() == Activity201MaLiAnNaEnum.CampType.Player)
	gohelper.setActive(arg_11_0._goEnemy, arg_11_0._soliderMo:getCamp() == Activity201MaLiAnNaEnum.CampType.Enemy)
	arg_11_0._simageRole:LoadImage(arg_11_0._soliderMo:getSmallIcon())
end

function var_0_0.updateInfo(arg_12_0, arg_12_1)
	arg_12_0._soliderMo = arg_12_1

	if arg_12_0._soliderMo == nil then
		return
	end

	local var_12_0 = arg_12_0._soliderMo:getHp()

	if arg_12_0._lastHp == nil or arg_12_0._lastHp ~= var_12_0 then
		arg_12_0._txtRoleHP.text = var_12_0
		arg_12_0._txtRoleHP2.text = var_12_0
		arg_12_0._lastHp = var_12_0

		gohelper.setActive(arg_12_0._goDead, arg_12_0._soliderMo:isDead())
	end
end

function var_0_0.showDiff(arg_13_0, arg_13_1)
	if arg_13_0._isShowDiff then
		if arg_13_0._isShowDiffList == nil then
			arg_13_0._isShowDiffList = {}
		end

		table.insert(arg_13_0._isShowDiffList, arg_13_1)
	else
		if arg_13_1 == nil and arg_13_0._isShowDiffList ~= nil and #arg_13_0._isShowDiffList > 0 then
			arg_13_1 = table.remove(arg_13_0._isShowDiffList, 1)
		end

		arg_13_0:_showDiff(arg_13_1)
	end
end

function var_0_0._showDiff(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		return
	end

	if arg_14_0._goReduceHp.activeSelf then
		gohelper.setActive(arg_14_0._goReduceHp, false)
	end

	arg_14_0._txtReduceHP.text = arg_14_1

	gohelper.setActive(arg_14_0._goReduceHp, true)

	arg_14_0._isShowDiff = true

	local var_14_0 = 1

	if arg_14_0._isShowDiffList and #arg_14_0._isShowDiffList > 0 then
		var_14_0 = var_14_0 * 0.4
	end

	TaskDispatcher.runDelay(arg_14_0._hideReduce, arg_14_0, var_14_0)
end

function var_0_0._hideReduce(arg_15_0)
	gohelper.setActive(arg_15_0._goReduceHp, false)

	arg_15_0._isShowDiff = false

	arg_15_0:showDiff()
end

function var_0_0.reset(arg_16_0)
	if arg_16_0._isShowDiffList then
		tabletool.clear(arg_16_0._isShowDiffList)

		arg_16_0._isShowDiffList = nil
	end

	TaskDispatcher.cancelTask(arg_16_0._hideReduce, arg_16_0)
	arg_16_0:_hideReduce()
end

function var_0_0.onDestroyView(arg_17_0)
	if arg_17_0._isShowDiffList then
		tabletool.clear(arg_17_0._isShowDiffList)

		arg_17_0._isShowDiffList = nil
	end

	TaskDispatcher.cancelTask(arg_17_0._hideReduce, arg_17_0)
end

return var_0_0
