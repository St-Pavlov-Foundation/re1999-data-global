module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameSkillView", package.seeall)

local var_0_0 = class("YaXianGameSkillView", BaseView)

function var_0_0.onInitView(arg_1_0)
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

function var_0_0.onClickSkillBtn(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_rebound)
	arg_4_0:changeSkillDescContainerVisible()
end

function var_0_0.onBlockClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	arg_5_0:changeSkillDescContainerVisible()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.goSkillBlock = gohelper.findChild(arg_6_0.viewGO, "root/#go_skillblock")
	arg_6_0.blockClick = gohelper.getClick(arg_6_0.goSkillBlock)

	arg_6_0.blockClick:AddClickListener(arg_6_0.onBlockClick, arg_6_0)

	arg_6_0.goSkillContainer = gohelper.findChild(arg_6_0.viewGO, "root/bottomleft")
	arg_6_0.goSkillDescContent = gohelper.findChild(arg_6_0.goSkillContainer, "skillDescContent")

	gohelper.setActive(arg_6_0.goSkillDescContent, false)

	arg_6_0.showSkillDescContainer = false
	arg_6_0.goSkillDescItem1 = gohelper.findChild(arg_6_0.goSkillContainer, "skillDescContent/#go_skillDescItem1")
	arg_6_0.goSkillDescItem2 = gohelper.findChild(arg_6_0.goSkillContainer, "skillDescContent/#go_skillDescItem2")
	arg_6_0.goSkillItem1 = gohelper.findChild(arg_6_0.goSkillContainer, "#go_simple/skillContent/skill1")
	arg_6_0.goSkillItem2 = gohelper.findChild(arg_6_0.goSkillContainer, "#go_simple/skillContent/skill2")
	arg_6_0.skillBtn = gohelper.findChildClickWithAudio(arg_6_0.goSkillContainer, "#go_simple/clickarea")

	arg_6_0.skillBtn:AddClickListener(arg_6_0.onClickSkillBtn, arg_6_0)
	gohelper.setActive(arg_6_0.goSkillDescContent, false)
	arg_6_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnUpdateSkillInfo, arg_6_0.onUpdateSkillInfo, arg_6_0)
end

function var_0_0.initSkillDescItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getUserDataTb_()

	var_7_0.goContainer = arg_7_1
	var_7_0.txtDesc = gohelper.findChildText(arg_7_1, "desc")
	var_7_0.goCantUse = gohelper.findChild(arg_7_1, "skill/cantuse")
	var_7_0.goCanUse = gohelper.findChild(arg_7_1, "skill/canuse")
	var_7_0.skillId = arg_7_2
	var_7_0.animator = gohelper.findChild(arg_7_1, "skill"):GetComponent(typeof(UnityEngine.Animator))
	var_7_0.click = gohelper.getClick(arg_7_1)

	var_7_0.click:AddClickListener(arg_7_0.onClickSkillItem, arg_7_0, var_7_0)

	return var_7_0
end

function var_0_0.initSkillItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.goContainer = arg_8_1
	var_8_0.imgicon = gohelper.findChildImage(arg_8_1, "icon")
	var_8_0.goCantUse = gohelper.findChild(arg_8_1, "cantuse")
	var_8_0.goCanUse = gohelper.findChild(arg_8_1, "canuse")
	var_8_0.skillId = arg_8_2
	var_8_0.animator = arg_8_1:GetComponent(typeof(UnityEngine.Animator))

	return var_8_0
end

function var_0_0.onClickSkillItem(arg_9_0, arg_9_1)
	local var_9_0 = YaXianGameModel.instance:getSkillMo(arg_9_1.skillId)

	if not var_9_0 then
		return
	end

	if var_9_0.canUseCount <= 0 then
		return
	end

	if var_9_0.id == YaXianGameEnum.SkillId.InVisible then
		AudioMgr.instance:trigger(AudioEnum.YaXian.InVisible)
	end

	Activity115Rpc.instance:sendAct115UseSkillRequest(var_9_0.actId, var_9_0.id)
	arg_9_0:changeSkillDescContainerVisible()
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:refreshUI()
end

function var_0_0.onOpen(arg_11_0)
	gohelper.setActive(arg_11_0.goSkillBlock, false)

	arg_11_0.hideSkillDescItem = arg_11_0:initSkillDescItem(arg_11_0.goSkillDescItem1, YaXianGameEnum.SkillId.InVisible)
	arg_11_0.throughSkillDescItem = arg_11_0:initSkillDescItem(arg_11_0.goSkillDescItem2, YaXianGameEnum.SkillId.ThroughWall)
	arg_11_0.hideSkillItem = arg_11_0:initSkillItem(arg_11_0.goSkillItem1, YaXianGameEnum.SkillId.InVisible)
	arg_11_0.throughSkillItem = arg_11_0:initSkillItem(arg_11_0.goSkillItem2, YaXianGameEnum.SkillId.ThroughWall)
	arg_11_0.hideSkillDescItem.txtDesc.text = YaXianConfig.instance:getSkillConfig(YaXianEnum.ActivityId, YaXianGameEnum.SkillId.InVisible).desc
	arg_11_0.throughSkillDescItem.txtDesc.text = YaXianConfig.instance:getSkillConfig(YaXianEnum.ActivityId, YaXianGameEnum.SkillId.ThroughWall).desc

	if YaXianGameModel.instance:hasSkill() then
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
	end

	arg_11_0:refreshUI()
end

function var_0_0.refreshUI(arg_12_0)
	local var_12_0 = YaXianGameModel.instance:hasSkill()

	gohelper.setActive(arg_12_0.goSkillContainer, var_12_0)

	if not var_12_0 then
		return
	end

	arg_12_0:refreshSkillDescItem(arg_12_0.hideSkillDescItem)
	arg_12_0:refreshSkillDescItem(arg_12_0.throughSkillDescItem)
	arg_12_0:refreshSkillItem(arg_12_0.hideSkillItem)
	arg_12_0:refreshSkillItem(arg_12_0.throughSkillItem)
end

function var_0_0.refreshSkillDescItem(arg_13_0, arg_13_1)
	local var_13_0 = YaXianGameModel.instance:getSkillMo(arg_13_1.skillId)

	if not var_13_0 then
		gohelper.setActive(arg_13_1.goContainer, false)

		return
	end

	gohelper.setActive(arg_13_1.goContainer, true)
	gohelper.setActive(arg_13_1.goCanUse, var_13_0.canUseCount > 0)
	gohelper.setActive(arg_13_1.goCantUse, var_13_0.canUseCount <= 0)
	arg_13_0:playDescItemAnimator(arg_13_1)
end

function var_0_0.playDescItemAnimator(arg_14_0, arg_14_1)
	if arg_14_0.showSkillDescContainer then
		local var_14_0 = YaXianGameModel.instance:getSkillMo(arg_14_1.skillId)

		if not var_14_0 then
			return
		end

		local var_14_1 = UIAnimationName.Idle

		if var_14_0.canUseCount > 0 then
			var_14_1 = UIAnimationName.Open
		end

		arg_14_1.animator:Play(var_14_1)
	end
end

var_0_0.ModeSelectColor = Color.white
var_0_0.ModeDisSelectColor = Color(0.4, 0.4, 0.4, 1)

function var_0_0.refreshSkillItem(arg_15_0, arg_15_1)
	local var_15_0 = YaXianGameModel.instance:getSkillMo(arg_15_1.skillId)

	if not var_15_0 then
		gohelper.setActive(arg_15_1.goContainer, false)

		return
	end

	gohelper.setActive(arg_15_1.goContainer, true)
	gohelper.setActive(arg_15_1.goCanUse, var_15_0.canUseCount > 0)

	arg_15_1.imgicon.color = var_15_0.canUseCount > 0 and var_0_0.ModeSelectColor or var_0_0.ModeDisSelectColor

	local var_15_1 = UIAnimationName.Idle

	if var_15_0.canUseCount > 0 then
		var_15_1 = UIAnimationName.Open
	end

	arg_15_1.animator:Play(var_15_1)
end

function var_0_0.onUpdateSkillInfo(arg_16_0)
	arg_16_0:refreshUI()
end

function var_0_0.changeSkillDescContainerVisible(arg_17_0)
	arg_17_0.showSkillDescContainer = not arg_17_0.showSkillDescContainer

	gohelper.setActive(arg_17_0.goSkillDescContent, arg_17_0.showSkillDescContainer)
	gohelper.setActive(arg_17_0.goSkillBlock, arg_17_0.showSkillDescContainer)
	arg_17_0:playDescItemAnimator(arg_17_0.hideSkillDescItem)
	arg_17_0:playDescItemAnimator(arg_17_0.throughSkillDescItem)
end

function var_0_0.onClose(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0.hideSkillDescItem.click:RemoveClickListener()
	arg_19_0.throughSkillDescItem.click:RemoveClickListener()
	arg_19_0.skillBtn:RemoveClickListener()
	arg_19_0.blockClick:RemoveClickListener()
end

return var_0_0
