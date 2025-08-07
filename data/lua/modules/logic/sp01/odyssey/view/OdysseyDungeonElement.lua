module("modules.logic.sp01.odyssey.view.OdysseyDungeonElement", package.seeall)

local var_0_0 = class("OdysseyDungeonElement", LuaCompBase)
local var_0_1 = Vector2(150, 150)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.config = arg_1_1[1]
	arg_1_0.sceneElements = arg_1_1[2]
	arg_1_0.type = arg_1_0.config.type
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_0.go.transform
	arg_2_0.itemRootMap = arg_2_0:getUserDataTb_()

	for iter_2_0, iter_2_1 in pairs(OdysseyEnum.ElementTypeRoot) do
		arg_2_0.itemRootMap[iter_2_0] = {}
		arg_2_0.itemRootMap[iter_2_0].go = gohelper.findChild(arg_2_0.go, iter_2_1 .. "Item")
		arg_2_0.itemRootMap[iter_2_0].anim = arg_2_0.itemRootMap[iter_2_0].go:GetComponent(gohelper.Type_Animator)
		arg_2_0.itemRootMap[iter_2_0].mainTaskFrame = gohelper.findChild(arg_2_0.itemRootMap[iter_2_0].go, "image_effframe1")
		arg_2_0.itemRootMap[iter_2_0].goldFrame = gohelper.findChild(arg_2_0.itemRootMap[iter_2_0].go, "image_bg1")
		arg_2_0.itemRootMap[iter_2_0].silverFrame = gohelper.findChild(arg_2_0.itemRootMap[iter_2_0].go, "image_bg2")
		arg_2_0.itemRootMap[iter_2_0].goldFrameEffect = gohelper.findChild(arg_2_0.itemRootMap[iter_2_0].go, "vx_gold")
		arg_2_0.itemRootMap[iter_2_0].silverFrameEffect = gohelper.findChild(arg_2_0.itemRootMap[iter_2_0].go, "vx_sliver")
		arg_2_0.itemRootMap[iter_2_0].goldArrow = gohelper.findChild(arg_2_0.itemRootMap[iter_2_0].go, "image_arrow1")
		arg_2_0.itemRootMap[iter_2_0].silverArrow = gohelper.findChild(arg_2_0.itemRootMap[iter_2_0].go, "image_arrow2")
	end

	arg_2_0.imageDialogHero = gohelper.findChildSingleImage(arg_2_0.go, "dialogItem/#image_dialogHero")
	arg_2_0.imageOptionIcon = gohelper.findChildImage(arg_2_0.go, "optionItem/#image_optionIcon")
	arg_2_0.imageFightIcon = gohelper.findChildImage(arg_2_0.go, "fightItem/#image_fightIcon")
	arg_2_0.imageFightGlowIcon = gohelper.findChildImage(arg_2_0.go, "fightItem/#image_fightIcon/#image_fightIcon_glow")
	arg_2_0.goFightConquer = gohelper.findChild(arg_2_0.go, "fightItem/#go_conquer")
	arg_2_0.goFightReward = gohelper.findChild(arg_2_0.go, "fightItem/#go_rewardtips")

	arg_2_0.addBoxColliderListener(arg_2_0.go, arg_2_0.onClickDown, arg_2_0)
	arg_2_0:updateInfo()
end

function var_0_0.addBoxColliderListener(arg_3_0, arg_3_1, arg_3_2)
	gohelper.addBoxCollider2D(arg_3_0, var_0_1)

	local var_3_0 = ZProj.BoxColliderClickListener.Get(arg_3_0)

	var_3_0:SetIgnoreUI(true)
	var_3_0:AddClickListener(arg_3_1, arg_3_2)
end

function var_0_0.onClickDown(arg_4_0)
	arg_4_0.sceneElements:onElementClickDown(arg_4_0)
end

function var_0_0.updateInfo(arg_5_0)
	local var_5_0 = string.splitToNumber(arg_5_0.config.pos, "#")

	transformhelper.setLocalPos(arg_5_0.go.transform, var_5_0[1] or 0, var_5_0[2] or 0, var_5_0[3] or 0)

	for iter_5_0, iter_5_1 in pairs(arg_5_0.itemRootMap) do
		gohelper.setActive(iter_5_1.go, iter_5_0 == arg_5_0.type)
		gohelper.setActive(iter_5_1.goldFrame, arg_5_0.config.iconFrame == OdysseyEnum.IconFrameType.Gold)
		gohelper.setActive(iter_5_1.goldFrameEffect, arg_5_0.config.iconFrame == OdysseyEnum.IconFrameType.Gold)
		gohelper.setActive(iter_5_1.goldArrow, arg_5_0.config.iconFrame == OdysseyEnum.IconFrameType.Gold)
		gohelper.setActive(iter_5_1.silverFrame, arg_5_0.config.iconFrame == OdysseyEnum.IconFrameType.Silver)
		gohelper.setActive(iter_5_1.silverFrameEffect, arg_5_0.config.iconFrame == OdysseyEnum.IconFrameType.Silver)
		gohelper.setActive(iter_5_1.silverArrow, arg_5_0.config.iconFrame == OdysseyEnum.IconFrameType.Silver)
		gohelper.setActive(iter_5_1.mainTaskFrame, arg_5_0.config.main == OdysseyEnum.DungeonMainElement)
	end

	local var_5_1 = string.splitToNumber(arg_5_0.config.pos, "#")

	transformhelper.setLocalPos(arg_5_0.trans, var_5_1[1], var_5_1[2], var_5_1[3])

	if arg_5_0.type == OdysseyEnum.ElementType.Option then
		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(arg_5_0.imageOptionIcon, arg_5_0.config.icon)
	elseif arg_5_0.type == OdysseyEnum.ElementType.Dialog then
		arg_5_0.imageDialogHero:LoadImage(ResUrl.getRoomHeadIcon(arg_5_0.config.icon))
	elseif arg_5_0.type == OdysseyEnum.ElementType.Fight then
		local var_5_2 = OdysseyConfig.instance:getElementFightConfig(arg_5_0.config.id)

		gohelper.setActive(arg_5_0.goFightConquer, var_5_2.type == OdysseyEnum.FightType.Conquer)

		local var_5_3 = DungeonConfig.instance:getEpisodeCO(var_5_2.episodeId)
		local var_5_4 = lua_bonus.configDict[var_5_3.firstBonus]

		gohelper.setActive(arg_5_0.goFightReward, var_5_3.firstBonus > 0 and var_5_4 and not string.nilorempty(var_5_4.fixBonus))
		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(arg_5_0.imageFightIcon, arg_5_0.config.icon)
		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(arg_5_0.imageFightGlowIcon, arg_5_0.config.icon)
	end
end

function var_0_0.needShowArrow(arg_6_0)
	return arg_6_0.config.needFollow == OdysseyEnum.DungeonElementNeedFollow
end

function var_0_0.playShowOrHideAnim(arg_7_0, arg_7_1)
	if arg_7_0.showState == arg_7_1 then
		return
	end

	arg_7_0.showState = arg_7_1

	arg_7_0.itemRootMap[arg_7_0.type].anim:Play(arg_7_1 and "open" or "close", 0, 0)
	arg_7_0.itemRootMap[arg_7_0.type].anim:Update(0)

	if not arg_7_1 then
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_fade_away)
	end
end

function var_0_0.playAnim(arg_8_0, arg_8_1)
	arg_8_0.itemRootMap[arg_8_0.type].anim:Play(arg_8_1, 0, 0)
	arg_8_0.itemRootMap[arg_8_0.type].anim:Update(0)

	if arg_8_1 == OdysseyEnum.ElementAnimName.Tips then
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_hint)
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0.imageDialogHero:UnLoadImage()
end

return var_0_0
