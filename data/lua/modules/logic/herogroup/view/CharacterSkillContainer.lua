module("modules.logic.herogroup.view.CharacterSkillContainer", package.seeall)

local var_0_0 = class("CharacterSkillContainer", LuaCompBase)
local var_0_1 = "ReplaceSkill"
local var_0_2 = "ndk"
local var_0_3 = "CharacterSkillContainer_Click"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._goskills = gohelper.findChild(arg_2_1, "line/go_skills")
	arg_2_0._skillitems = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 3 do
		local var_2_0 = gohelper.findChild(arg_2_0._goskills, "skillicon" .. tostring(iter_2_0))
		local var_2_1 = {
			icon = gohelper.findChildSingleImage(var_2_0, "imgIcon"),
			tag = gohelper.findChildSingleImage(var_2_0, "tag/tagIcon"),
			btn = gohelper.findChildButtonWithAudio(var_2_0, "bg", AudioEnum.UI.Play_ui_role_description),
			index = iter_2_0,
			go = var_2_0
		}

		var_2_1.btn:AddClickListener(arg_2_0._onSkillCardClick, arg_2_0, var_2_1.index)

		arg_2_0._skillitems[iter_2_0] = var_2_1
	end

	arg_2_0._reddot = gohelper.findChild(arg_2_1, "line/#RedDot")
	arg_2_0._anim = arg_2_1:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._animationEvent = arg_2_1:GetComponent(typeof(ZProj.AnimationEventWrap))

	if arg_2_0._animationEvent then
		arg_2_0._animationEvent:AddEventListener(var_0_1, arg_2_0._replaceSkill, arg_2_0)
	end

	if arg_2_0._anim then
		arg_2_0._animationPlayer = SLFramework.AnimatorPlayer.Get(arg_2_1)
	end
end

function var_0_0.onDestroy(arg_3_0)
	for iter_3_0 = 1, 3 do
		arg_3_0._skillitems[iter_3_0].btn:RemoveClickListener()
		arg_3_0._skillitems[iter_3_0].icon:UnLoadImage()
		arg_3_0._skillitems[iter_3_0].tag:UnLoadImage()
	end

	if arg_3_0._animationEvent then
		arg_3_0._animationEvent:RemoveEventListener(var_0_1)
	end
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._heroId = arg_4_1
	arg_4_0._heroName = HeroConfig.instance:getHeroCO(arg_4_0._heroId).name
	arg_4_0._heroMo = arg_4_3
	arg_4_0._isBalance = arg_4_4
	arg_4_0._showAttributeOption = arg_4_2 or CharacterEnum.showAttributeOption.ShowCurrent

	arg_4_0:_refreshSkillUI()
end

function var_0_0._refreshSkillUI(arg_5_0)
	if arg_5_0._heroId then
		local var_5_0 = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(arg_5_0._heroId, arg_5_0._showAttributeOption, arg_5_0._heroMo)

		arg_5_0:_showSkillUI(var_5_0)
	end
end

function var_0_0._showSkillUI(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		local var_6_0 = iter_6_1 ~= 0

		if var_6_0 then
			local var_6_1 = lua_skill.configDict[iter_6_1]

			if not var_6_1 then
				logError(string.format("heroID : %s, skillId not found : %s", arg_6_0._heroId, iter_6_1))
			end

			arg_6_0._skillitems[iter_6_0].icon:LoadImage(ResUrl.getSkillIcon(var_6_1.icon))
			arg_6_0._skillitems[iter_6_0].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_6_1.showTag))
			gohelper.setActive(arg_6_0._skillitems[iter_6_0].tag.gameObject, iter_6_0 ~= 3)
		end

		gohelper.setActive(arg_6_0._skillitems[iter_6_0].go.gameObject, var_6_0)
	end
end

function var_0_0._onSkillCardClick(arg_7_0, arg_7_1)
	if arg_7_0._heroId then
		local var_7_0 = {}
		local var_7_1 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(arg_7_0._heroId, arg_7_0._showAttributeOption, arg_7_0._heroMo)

		var_7_0.super = arg_7_1 == 3
		var_7_0.skillIdList = var_7_1[arg_7_1]
		var_7_0.isBalance = arg_7_0._isBalance
		var_7_0.monsterName = arg_7_0._heroName
		var_7_0.heroId = arg_7_0._heroId
		var_7_0.heroMo = arg_7_0._heroMo
		var_7_0.skillIndex = arg_7_1

		if arg_7_0._param then
			var_7_0.anchorX = arg_7_0._param.skillTipX
			var_7_0.anchorY = arg_7_0._param.skillTipY
			var_7_0.adjustBuffTip = arg_7_0._param.adjustBuffTip
			var_7_0.showAssassinBg = arg_7_0._param.showAssassinBg
		end

		ViewMgr.instance:openView(ViewName.SkillTipView, var_7_0)

		local var_7_2, var_7_3 = CharacterModel.instance:isNeedShowNewSkillReddot(arg_7_0._heroMo)

		if var_7_2 and var_7_3 then
			CharacterModel.instance:cencelCardReddot(arg_7_0._heroId)
		end

		arg_7_0:_showSkillReddot(false)
	end
end

function var_0_0._replaceSkill(arg_8_0)
	CharacterModel.instance:cencelPlayReplaceSkillAnim(arg_8_0._heroMo)
	arg_8_0:_refreshSkillUI()
end

function var_0_0.onFinishreplaceSkillAnim(arg_9_0)
	if arg_9_0._isPlayReplaceSkillAnim then
		UIBlockMgr.instance:endBlock(var_0_3)

		arg_9_0._isPlayReplaceSkillAnim = nil
	end
end

function var_0_0.checkShowReplaceBeforeSkillUI(arg_10_0)
	if not arg_10_0._anim then
		return
	end

	if arg_10_0._heroMo then
		local var_10_0, var_10_1 = CharacterModel.instance:isCanPlayReplaceSkillAnim(arg_10_0._heroMo)

		var_10_0 = var_10_0 and arg_10_0._heroMo:isOwnHero()
		var_10_1 = var_10_1 and arg_10_0._heroMo:isOwnHero()

		if var_10_0 then
			local var_10_2 = arg_10_0._heroMo.config
			local var_10_3 = var_10_2.skill
			local var_10_4 = var_10_2.exSkill
			local var_10_5 = SkillConfig.instance:getHeroBaseSkillIdDictByStr(var_10_3, var_10_4)

			arg_10_0:_showSkillUI(var_10_5)
			arg_10_0._animationPlayer:Play(var_0_2, arg_10_0.onFinishreplaceSkillAnim, arg_10_0)
			UIBlockMgrExtend.setNeedCircleMv(false)
			UIBlockMgr.instance:startBlock(var_0_3)
			TaskDispatcher.runDelay(arg_10_0.playNuodikaReplaceSkillAudio, arg_10_0, 0.5)

			arg_10_0._isPlayReplaceSkillAnim = true
		end

		arg_10_0:_showSkillReddot(var_10_1)
	else
		arg_10_0:_showSkillReddot(false)
	end
end

function var_0_0.clearDelay(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.playNuodikaReplaceSkillAudio, arg_11_0)
end

function var_0_0.playNuodikaReplaceSkillAudio(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_nuodika)
end

function var_0_0._showSkillReddot(arg_13_0, arg_13_1)
	if arg_13_0._reddot then
		gohelper.setActive(arg_13_0._reddot.gameObject, arg_13_1)
	end
end

return var_0_0
