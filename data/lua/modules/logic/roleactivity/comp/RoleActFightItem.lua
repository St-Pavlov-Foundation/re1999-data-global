module("modules.logic.roleactivity.comp.RoleActFightItem", package.seeall)

local var_0_0 = class("RoleActFightItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "#go_UnSelected")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_0.viewGO, "#go_UnSelected/#btn_click")
	arg_1_0._txtstageNumN = gohelper.findChildText(arg_1_0.viewGO, "#go_UnSelected/info/#txt_stageNum")
	arg_1_0._gostar1N = gohelper.findChild(arg_1_0.viewGO, "#go_UnSelected/info/#go_star/star1/#go_star1")
	arg_1_0._gostar2N = gohelper.findChild(arg_1_0.viewGO, "#go_UnSelected/info/#go_star/star2/#go_star2")
	arg_1_0._goLock = gohelper.findChild(arg_1_0.viewGO, "#go_UnSelected/#go_Lock")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Selected")
	arg_1_0._txtstagenameS = gohelper.findChildText(arg_1_0.viewGO, "#go_Selected/info/#txt_stagename")
	arg_1_0._txtstageNumS = gohelper.findChildText(arg_1_0.viewGO, "#go_Selected/info/#txt_stagename/#txt_stageNum")
	arg_1_0._gostar1S = gohelper.findChild(arg_1_0.viewGO, "#go_Selected/info/#txt_stagename/star1/#go_star1")
	arg_1_0._gostar2S = gohelper.findChild(arg_1_0.viewGO, "#go_Selected/info/#txt_stagename/star2/#go_star2")
	arg_1_0._btnNormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Selected/#btn_Normal")
	arg_1_0._btnHard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Selected/#btn_Hard")
	arg_1_0._goHardLock = gohelper.findChild(arg_1_0.viewGO, "#go_Selected/#btn_Hard/#go_Lock")
	arg_1_0._selectAnim = arg_1_0._goSelected:GetComponent(gohelper.Type_Animator)
	arg_1_0._animLock = arg_1_0._goLock:GetComponent(gohelper.Type_Animator)
	arg_1_0._animStar1S = arg_1_0._gostar1S:GetComponent(gohelper.Type_Animation)
	arg_1_0._animStar2S = arg_1_0._gostar2S:GetComponent(gohelper.Type_Animation)
	arg_1_0._animHardLock = arg_1_0._goHardLock:GetComponent(gohelper.Type_Animator)
	arg_1_0._gostar1Nno = gohelper.findChild(arg_1_0.viewGO, "#go_UnSelected/info/#go_star/star1/no")
	arg_1_0._gostar2Nno = gohelper.findChild(arg_1_0.viewGO, "#go_UnSelected/info/#go_star/star2/no")
	arg_1_0._gostar1Sno = gohelper.findChild(arg_1_0.viewGO, "#go_Selected/info/#txt_stagename/star1/no")
	arg_1_0._gostar2Sno = gohelper.findChild(arg_1_0.viewGO, "#go_Selected/info/#txt_stagename/star2/no")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnOnClick, arg_2_0)
	arg_2_0._btnNormal:AddClickListener(arg_2_0._btnOnNormal, arg_2_0)
	arg_2_0._btnHard:AddClickListener(arg_2_0._btnOnHard, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnNormal:RemoveClickListener()
	arg_3_0._btnHard:RemoveClickListener()
end

function var_0_0._btnOnClick(arg_4_0)
	if not arg_4_0.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.FightItemClick, arg_4_0.index)
end

function var_0_0._btnOnNormal(arg_5_0)
	arg_5_0:enterFight(arg_5_0.config)
end

function var_0_0._btnOnHard(arg_6_0)
	if not RoleActivityModel.instance:isLevelUnlock(arg_6_0.actId, arg_6_0.hardConfig.id) then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	arg_6_0:enterFight(arg_6_0.hardConfig)
end

function var_0_0.setParam(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.config = arg_7_1
	arg_7_0.id = arg_7_1.id
	arg_7_0.actId = arg_7_3
	arg_7_0.hardConfig = DungeonConfig.instance:getEpisodeCO(arg_7_0.id + 1)
	arg_7_0.index = arg_7_2

	arg_7_0:_refreshUI()
end

function var_0_0._refreshUI(arg_8_0)
	arg_8_0:refreshStatus()

	arg_8_0._txtstageNumN.text = "0" .. arg_8_0.index
	arg_8_0._txtstageNumS.text = "0" .. arg_8_0.index
	arg_8_0._txtstagenameS.text = arg_8_0.config.name
end

function var_0_0.refreshStatus(arg_9_0)
	arg_9_0.unlock = RoleActivityModel.instance:isLevelUnlock(arg_9_0.actId, arg_9_0.id)

	local var_9_0 = RoleActivityModel.instance:isLevelUnlock(arg_9_0.actId, arg_9_0.hardConfig.id)

	gohelper.setActive(arg_9_0._goLock, not arg_9_0.unlock)
	gohelper.setActive(arg_9_0._goHardLock, not var_9_0)
	arg_9_0:refreshStar()
end

function var_0_0.refreshStar(arg_10_0)
	local var_10_0 = RoleActivityModel.instance:isLevelPass(arg_10_0.actId, arg_10_0.id)
	local var_10_1 = RoleActivityModel.instance:isLevelPass(arg_10_0.actId, arg_10_0.hardConfig.id)

	gohelper.setActive(arg_10_0._gostar1N, var_10_0)
	gohelper.setActive(arg_10_0._gostar1S, var_10_0)
	gohelper.setActive(arg_10_0._gostar2N, var_10_1)
	gohelper.setActive(arg_10_0._gostar2S, var_10_1)
	gohelper.setActive(arg_10_0._gostar1Nno, not var_10_0)
	gohelper.setActive(arg_10_0._gostar1Sno, not var_10_0)
	gohelper.setActive(arg_10_0._gostar2Nno, not var_10_1)
	gohelper.setActive(arg_10_0._gostar2Sno, not var_10_1)
end

function var_0_0.refreshSelect(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or arg_11_0.index

	gohelper.setActive(arg_11_0._goNormal, arg_11_0.index ~= arg_11_1)
	gohelper.setActive(arg_11_0._goSelected, arg_11_0.index == arg_11_1)

	if arg_11_1 and arg_11_0._goSelected.activeInHierarchy then
		arg_11_0._selectAnim:Play("open")
	end
end

function var_0_0.isUnlock(arg_12_0)
	return arg_12_0.unlock
end

function var_0_0.enterFight(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.chapterId
	local var_13_1 = arg_13_1.id
	local var_13_2 = arg_13_1.battleId

	if var_13_0 and var_13_1 and var_13_2 > 0 then
		RoleActivityModel.instance:setEnterFightIndex(arg_13_0.index)
		DungeonFightController.instance:enterFightByBattleId(var_13_0, var_13_1, var_13_2)
	end
end

function var_0_0.playUnlock(arg_14_0)
	arg_14_0._animLock:Play("unlock")
end

function var_0_0.playHardUnlock(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	arg_15_0._animHardLock:Play("unlock")
end

function var_0_0.playStarAnim(arg_16_0, arg_16_1)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)

	if arg_16_1 then
		arg_16_0._animStar1S:Play()
	else
		arg_16_0._animStar2S:Play()
	end
end

return var_0_0
