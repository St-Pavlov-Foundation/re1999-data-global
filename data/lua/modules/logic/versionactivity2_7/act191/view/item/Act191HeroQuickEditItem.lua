module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroQuickEditItem", package.seeall)

local var_0_0 = class("Act191HeroQuickEditItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.nameCnTxt = gohelper.findChildText(arg_1_1, "namecn")
	arg_1_0.nameEnTxt = gohelper.findChildText(arg_1_1, "nameen")
	arg_1_0.cardIcon = gohelper.findChild(arg_1_1, "mask/charactericon")
	arg_1_0.commonHeroCard = CommonHeroCard.create(arg_1_0.cardIcon, arg_1_0.__cname)
	arg_1_0.front = gohelper.findChildImage(arg_1_1, "mask/front")
	arg_1_0.rare = gohelper.findChildImage(arg_1_1, "image_rare")
	arg_1_0.selectframe = gohelper.findChild(arg_1_1, "selectframe")
	arg_1_0.careerIcon = gohelper.findChildImage(arg_1_1, "career")
	arg_1_0.goexskill = gohelper.findChild(arg_1_1, "go_exskill")
	arg_1_0.imageexskill = gohelper.findChildImage(arg_1_1, "go_exskill/image_exskill")
	arg_1_0.newTag = gohelper.findChild(arg_1_1, "new")
	arg_1_0.goFetter = gohelper.findChild(arg_1_1, "fetter/image_Fetter")
	arg_1_0.goOrderBg = gohelper.findChild(arg_1_1, "go_OrderBg")
	arg_1_0.imageOrder = gohelper.findChildImage(arg_1_1, "go_OrderBg/image_Order")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "click")
	arg_1_0.animator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.assist = gohelper.findChild(arg_1_1, "assist")
	arg_1_0.imageFetterList = arg_1_0:getUserDataTb_()

	gohelper.setActive(arg_1_0.goFetter, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0.config = arg_4_1.config
	arg_4_0.nameCnTxt.text = arg_4_0.config.name

	UISpriteSetMgr.instance:setCommonSprite(arg_4_0.careerIcon, "lssx_" .. tostring(arg_4_0.config.career))
	UISpriteSetMgr.instance:setAct174Sprite(arg_4_0.rare, "act174_rolefame_" .. tostring(arg_4_0.config.quality))
	UISpriteSetMgr.instance:setAct174Sprite(arg_4_0.front, "act174_rolebg_" .. tostring(arg_4_0.config.quality))

	local var_4_0 = FightConfig.instance:getSkinCO(arg_4_0.config.skinId)

	if not var_4_0 then
		logError("找不到皮肤配置, id: " .. tostring(arg_4_0.config.skinId))

		return
	end

	arg_4_0.commonHeroCard:onUpdateMO(var_4_0)
	gohelper.setActive(arg_4_0.goexskill, arg_4_0.config.exLevel ~= 0)

	arg_4_0.imageexskill.fillAmount = arg_4_0.config.exLevel / CharacterEnum.MaxSkillExLevel

	arg_4_0:refreshFetterIcon()
	arg_4_0:refreshSelect()

	arg_4_0._open_ani_finish = true
end

function var_0_0.refreshSelect(arg_5_0)
	arg_5_0._team_pos_index = Act191HeroQuickEditListModel.instance:getHeroTeamPos(arg_5_0._mo.heroId)
	arg_5_0.isSelect = arg_5_0._team_pos_index ~= 0

	if not arg_5_0._open_ani_finish then
		TaskDispatcher.runDelay(arg_5_0.showOrderBg, arg_5_0, 0.3)
	else
		arg_5_0:showOrderBg()
	end
end

function var_0_0.showOrderBg(arg_6_0)
	if arg_6_0.isSelect then
		if arg_6_0._team_pos_index < 5 then
			gohelper.setActive(arg_6_0.goOrderBg, true)
			gohelper.setActive(arg_6_0.assist, false)
			gohelper.setActive(arg_6_0.selectframe, true)
			UISpriteSetMgr.instance:setHeroGroupSprite(arg_6_0.imageOrder, "biandui_shuzi_" .. arg_6_0._team_pos_index)
		else
			gohelper.setActive(arg_6_0.goOrderBg, false)
			gohelper.setActive(arg_6_0.assist, true)
			gohelper.setActive(arg_6_0.selectframe, true)
		end
	else
		gohelper.setActive(arg_6_0.goOrderBg, false)
		gohelper.setActive(arg_6_0.assist, false)
		gohelper.setActive(arg_6_0.selectframe, false)
	end
end

function var_0_0._onItemClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	Act191HeroQuickEditListModel.instance:selectHero(arg_7_0._mo.heroId, not arg_7_0.isSelect)
	arg_7_0:refreshSelect()
	Activity191Controller.instance:dispatchEvent(Activity191Event.OnClickHeroEditItem, arg_7_0._mo)
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.showOrderBg, arg_8_0)
end

function var_0_0.getAnimator(arg_9_0)
	return arg_9_0.animator
end

function var_0_0.refreshFetterIcon(arg_10_0)
	local var_10_0 = string.split(arg_10_0.config.tag, "#")

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if not arg_10_0.imageFetterList[iter_10_0] then
			local var_10_1 = gohelper.cloneInPlace(arg_10_0.goFetter)

			arg_10_0.imageFetterList[iter_10_0] = gohelper.findChildImage(var_10_1, "")
		end

		local var_10_2 = Activity191Config.instance:getRelationCo(iter_10_1)

		Activity191Helper.setFetterIcon(arg_10_0.imageFetterList[iter_10_0], var_10_2.icon)
		gohelper.setActive(arg_10_0.imageFetterList[iter_10_0], true)
	end

	for iter_10_2 = #var_10_0 + 1, #arg_10_0.imageFetterList do
		gohelper.setActive(arg_10_0.imageFetterList[iter_10_2], false)
	end
end

return var_0_0
