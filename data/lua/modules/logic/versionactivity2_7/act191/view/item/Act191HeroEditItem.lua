module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroEditItem", package.seeall)

local var_0_0 = class("Act191HeroEditItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.nameCnTxt = gohelper.findChildText(arg_1_1, "namecn")
	arg_1_0.nameEnTxt = gohelper.findChildText(arg_1_1, "nameen")
	arg_1_0.cardIcon = gohelper.findChild(arg_1_1, "mask/charactericon")
	arg_1_0.commonHeroCard = CommonHeroCard.create(arg_1_0.cardIcon, arg_1_0.__cname)
	arg_1_0.front = gohelper.findChildImage(arg_1_1, "mask/front")
	arg_1_0.current = gohelper.findChild(arg_1_1, "current")
	arg_1_0.rare = gohelper.findChildImage(arg_1_1, "image_rare")
	arg_1_0.selectframe = gohelper.findChild(arg_1_1, "selectframe")
	arg_1_0.careerIcon = gohelper.findChildImage(arg_1_1, "career")
	arg_1_0.goexskill = gohelper.findChild(arg_1_1, "go_exskill")
	arg_1_0.imageexskill = gohelper.findChildImage(arg_1_1, "go_exskill/image_exskill")
	arg_1_0.newTag = gohelper.findChild(arg_1_1, "new")
	arg_1_0.goFetter = gohelper.findChild(arg_1_1, "fetter/image_Fetter")
	arg_1_0.goOrderBg = gohelper.findChild(arg_1_1, "go_OrderBg")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "click")
	arg_1_0._animator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.isSelect = false
	arg_1_0.inteam = gohelper.findChild(arg_1_1, "inteam")
	arg_1_0.insub = gohelper.findChild(arg_1_1, "insub")
	arg_1_0.imageFetterList = arg_1_0:getUserDataTb_()

	gohelper.setActive(arg_1_0.goFetter, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	arg_3_0._mo = arg_3_1
	arg_3_0.config = arg_3_1.config
	arg_3_0.nameCnTxt.text = arg_3_0.config.name

	UISpriteSetMgr.instance:setCommonSprite(arg_3_0.careerIcon, "lssx_" .. tostring(arg_3_0.config.career))
	UISpriteSetMgr.instance:setAct174Sprite(arg_3_0.rare, "act174_rolefame_" .. tostring(arg_3_0.config.quality))
	UISpriteSetMgr.instance:setAct174Sprite(arg_3_0.front, "act174_rolebg_" .. tostring(arg_3_0.config.quality))

	local var_3_0 = FightConfig.instance:getSkinCO(arg_3_0.config.skinId)

	if not var_3_0 then
		logError("找不到皮肤配置, id: " .. tostring(arg_3_0.config.skinId))

		return
	end

	arg_3_0.commonHeroCard:onUpdateMO(var_3_0)
	gohelper.setActive(arg_3_0.goexskill, arg_3_0.config.exLevel ~= 0)

	arg_3_0.imageexskill.fillAmount = arg_3_0.config.exLevel / CharacterEnum.MaxSkillExLevel

	arg_3_0:refreshFetterIcon()
	gohelper.setActive(arg_3_0.inteam, arg_3_1.inTeam == 2)
	gohelper.setActive(arg_3_0.insub, arg_3_1.inTeam == 1)
	gohelper.setActive(arg_3_0.current, arg_3_1.inTeam == 3)
end

function var_0_0.onSelect(arg_4_0, arg_4_1)
	arg_4_0.isSelect = arg_4_1

	gohelper.setActive(arg_4_0.selectframe, arg_4_1)

	if arg_4_1 then
		Activity191Controller.instance:dispatchEvent(Activity191Event.ClickHeroEditItem, arg_4_0._mo)
	end
end

function var_0_0._onItemClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_5_0.isSelect then
		arg_5_0._view:selectCell(arg_5_0._index, false)
		Activity191Controller.instance:dispatchEvent(Activity191Event.ClickHeroEditItem)
	else
		arg_5_0._view:selectCell(arg_5_0._index, true)
	end
end

function var_0_0.onDestroy(arg_6_0)
	return
end

function var_0_0.getAnimator(arg_7_0)
	return arg_7_0._animator
end

function var_0_0.refreshFetterIcon(arg_8_0)
	local var_8_0 = string.split(arg_8_0.config.tag, "#")

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not arg_8_0.imageFetterList[iter_8_0] then
			local var_8_1 = gohelper.cloneInPlace(arg_8_0.goFetter)

			arg_8_0.imageFetterList[iter_8_0] = gohelper.findChildImage(var_8_1, "")
		end

		local var_8_2 = Activity191Config.instance:getRelationCo(iter_8_1)

		Activity191Helper.setFetterIcon(arg_8_0.imageFetterList[iter_8_0], var_8_2.icon)
		gohelper.setActive(arg_8_0.imageFetterList[iter_8_0], true)
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.imageFetterList do
		gohelper.setActive(arg_8_0.imageFetterList[iter_8_2], false)
	end
end

return var_0_0
