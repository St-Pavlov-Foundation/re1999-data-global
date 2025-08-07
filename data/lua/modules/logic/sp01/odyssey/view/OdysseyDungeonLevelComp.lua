module("modules.logic.sp01.odyssey.view.OdysseyDungeonLevelComp", package.seeall)

local var_0_0 = class("OdysseyDungeonLevelComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0._txtlevel = gohelper.findChildText(arg_2_0.go, "#txt_level")
	arg_2_0._txtlevel1 = gohelper.findChildText(arg_2_0.go, "#txt_level1")
	arg_2_0._btnlevelReward = gohelper.findChildButtonWithAudio(arg_2_0.go, "#btn_levelReward")
	arg_2_0._golevelBar = gohelper.findChild(arg_2_0.go, "#go_levelBar")
	arg_2_0._goaddLevelProgress = gohelper.findChild(arg_2_0.go, "#go_levelBar/bar/#go_addLevelProgress")
	arg_2_0._golevelProgress = gohelper.findChild(arg_2_0.go, "#go_levelBar/bar/#go_levelProgress")
	arg_2_0._gotargetLevelProgress = gohelper.findChild(arg_2_0.go, "#go_levelBar/bar/#go_targetLevelProgress")
	arg_2_0._txtexpAdd = gohelper.findChildText(arg_2_0.go, "#go_levelBar/#txt_expAdd")
	arg_2_0._golevelReddot = gohelper.findChild(arg_2_0.go, "#go_levelReddot")
	arg_2_0._animLevel = arg_2_0.go:GetComponent(gohelper.Type_Animator)
	arg_2_0.expBarWidth = recthelper.getWidth(arg_2_0._golevelBar.transform)
	arg_2_0._animlevelBar = gohelper.findChild(arg_2_0.go, "#go_levelBar/bar"):GetComponent(gohelper.Type_Animator)

	gohelper.setActive(arg_2_0._golevelBar, false)

	local var_2_0, var_2_1 = OdysseyModel.instance:getHeroOldLevelAndExp()

	arg_2_0.curLevel = var_2_0
	arg_2_0.curExp = var_2_1
	arg_2_0.showState = true

	local var_2_2 = OdysseyConfig.instance:getLevelConfigList()

	arg_2_0.maxLevelConfig = var_2_2[#var_2_2]
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowAddExpEffect, arg_3_0.showExpAdd, arg_3_0)
	arg_3_0._btnlevelReward:AddClickListener(arg_3_0._btnlevelRewardOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.ShowAddExpEffect, arg_4_0.showExpAdd, arg_4_0)
	arg_4_0._btnlevelReward:RemoveClickListener()
end

function var_0_0._btnlevelRewardOnClick(arg_5_0)
	OdysseyDungeonController.instance:openLevelRewardView()
	OdysseyStatHelper.instance:sendOdysseyDungeonViewClickBtn("_btnlevelRewardOnClick")
end

function var_0_0.refreshUI(arg_6_0)
	arg_6_0._txtlevel.text = arg_6_0.curLevel
	arg_6_0._txtlevel1.text = arg_6_0.curLevel

	RedDotController.instance:addRedDot(arg_6_0._golevelReddot, RedDotEnum.DotNode.OdysseyLevelReward)
end

var_0_0.TotalExpShowTIme = 1.5

function var_0_0.showExpAdd(arg_7_0)
	local var_7_0, var_7_1 = OdysseyModel.instance:getHeroOldLevelAndExp()

	arg_7_0.curLevel = var_7_0
	arg_7_0.curExp = var_7_1

	if arg_7_0.curLevel == arg_7_0.maxLevelConfig.level then
		return
	end

	gohelper.setActive(arg_7_0._golevelBar, true)
	arg_7_0._animlevelBar:Play("open", 0, 0)
	arg_7_0._animlevelBar:Update(0)

	arg_7_0._txtexpAdd.text = string.format("+%s", OdysseyModel.instance:getHeroAddExp())
	arg_7_0.heroTargetLevel, arg_7_0.heroTargetExp = OdysseyModel.instance:getHeroCurLevelAndExp()
	arg_7_0.curLevelCo = OdysseyConfig.instance:getLevelConfig(arg_7_0.curLevel)
	arg_7_0.targetLevelCo = OdysseyConfig.instance:getLevelConfig(arg_7_0.heroTargetLevel)
	arg_7_0._txtlevel.text = arg_7_0.curLevel
	arg_7_0._txtlevel1.text = arg_7_0.curLevel

	if not arg_7_0.curLevelCo or not arg_7_0.targetLevelCo then
		arg_7_0._txtlevel.text = arg_7_0.heroTargetLevel
		arg_7_0._txtlevel1.text = arg_7_0.heroTargetLevel

		return
	end

	recthelper.setWidth(arg_7_0._golevelProgress.transform, arg_7_0.curExp / arg_7_0.curLevelCo.needExp * arg_7_0.expBarWidth)

	arg_7_0.eachAnimTime = var_0_0.TotalExpShowTIme / Mathf.Max(arg_7_0.heroTargetLevel - var_7_0, 1)
	arg_7_0.animCount = 0

	arg_7_0:ExpAddAnim()
end

function var_0_0.ExpAddAnim(arg_8_0)
	arg_8_0:cleanExpTween()

	local var_8_0 = recthelper.getWidth(arg_8_0._golevelProgress.transform)
	local var_8_1 = arg_8_0.targetLevelCo.needExp > 0 and arg_8_0.heroTargetExp / arg_8_0.targetLevelCo.needExp * arg_8_0.expBarWidth or var_8_0

	if arg_8_0.curLevel == arg_8_0.heroTargetLevel and Mathf.Abs(var_8_0 - var_8_1) < 1 then
		arg_8_0:endExpAddAnim()

		return
	elseif arg_8_0.curLevel < arg_8_0.heroTargetLevel and Mathf.Abs(var_8_0 - arg_8_0.expBarWidth) < 1 then
		arg_8_0.curLevel = arg_8_0.curLevel + 1
		arg_8_0._txtlevel.text = arg_8_0.curLevel
		arg_8_0._txtlevel1.text = arg_8_0.curLevel

		if not arg_8_0.isPlayingLevelUpAnim then
			arg_8_0._animLevel:Play("up", 0, 0)

			arg_8_0.isPlayingLevelUpAnim = true

			if arg_8_0.showState then
				AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_level_up)
			end
		end

		recthelper.setWidth(arg_8_0._golevelProgress.transform, 0)

		if var_8_1 == 0 and arg_8_0.curLevel == arg_8_0.heroTargetLevel then
			arg_8_0:endExpAddAnim()

			return
		end
	end

	if arg_8_0.curLevel ~= arg_8_0.heroTargetLevel then
		gohelper.setActive(arg_8_0._gotargetLevelProgress, true)
		gohelper.setActive(arg_8_0._goaddLevelProgress, true)
		recthelper.setWidth(arg_8_0._gotargetLevelProgress.transform, var_8_1)
		recthelper.setWidth(arg_8_0._goaddLevelProgress.transform, arg_8_0.expBarWidth)

		arg_8_0.expTweenId = ZProj.TweenHelper.DOWidth(arg_8_0._golevelProgress.transform, arg_8_0.expBarWidth, arg_8_0.eachAnimTime, arg_8_0.ExpAddAnim, arg_8_0)
	else
		gohelper.setActive(arg_8_0._gotargetLevelProgress, false)
		gohelper.setActive(arg_8_0._goaddLevelProgress, true)
		recthelper.setWidth(arg_8_0._goaddLevelProgress.transform, var_8_1)

		arg_8_0.expTweenId = ZProj.TweenHelper.DOWidth(arg_8_0._golevelProgress.transform, var_8_1, arg_8_0.eachAnimTime, arg_8_0.ExpAddAnim, arg_8_0)
	end
end

function var_0_0.checkLevelDiffAndRefresh(arg_9_0)
	arg_9_0.heroTargetLevel, arg_9_0.heroTargetExp = OdysseyModel.instance:getHeroCurLevelAndExp()

	local var_9_0, var_9_1 = OdysseyModel.instance:getHeroOldLevelAndExp()

	if arg_9_0.curLevel < arg_9_0.heroTargetLevel or var_9_1 ~= arg_9_0.heroTargetExp then
		arg_9_0.eachAnimTime = var_0_0.TotalExpShowTIme / Mathf.Max(arg_9_0.heroTargetLevel - var_9_0, 1)
		arg_9_0.animCount = 0
		arg_9_0.targetLevelCo = OdysseyConfig.instance:getLevelConfig(arg_9_0.heroTargetLevel)

		arg_9_0:ExpAddAnim()
	end
end

function var_0_0.endExpAddAnim(arg_10_0)
	gohelper.setActive(arg_10_0._gotargetLevelProgress, false)
	gohelper.setActive(arg_10_0._goaddLevelProgress, false)
	arg_10_0._animlevelBar:Play("close", 0, 0)
	arg_10_0._animlevelBar:Update(0)
	TaskDispatcher.runDelay(arg_10_0.hideLevelBar, arg_10_0, 0.17)

	arg_10_0._txtexpAdd.text = ""
	arg_10_0.isPlayingLevelUpAnim = false

	OdysseyModel.instance:updateHeroOldLevel(arg_10_0.heroTargetLevel, arg_10_0.heroTargetExp)
	arg_10_0:refreshUI()
end

function var_0_0.hideLevelBar(arg_11_0)
	gohelper.setActive(arg_11_0._golevelBar, false)
end

function var_0_0.setShowState(arg_12_0, arg_12_1)
	arg_12_0.showState = arg_12_1
end

function var_0_0.cleanExpTween(arg_13_0)
	if arg_13_0.expTweenId then
		ZProj.TweenHelper.KillById(arg_13_0.expTweenId)

		arg_13_0.expTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_13_0.hideLevelBar, arg_13_0)
end

function var_0_0.destroy(arg_14_0)
	arg_14_0:__onDispose()
	arg_14_0:cleanExpTween()
end

return var_0_0
